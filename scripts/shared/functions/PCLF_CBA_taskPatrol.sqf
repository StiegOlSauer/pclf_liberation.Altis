//#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: CBA_fnc_taskPatrol
Description:
    A function for a group to randomly patrol a parsed radius and location.
Parameters:
    - Group (Group or Object)
Optional:
    - Position (XYZ, Object, Location or Group)
    - Radius (Scalar)
    - Waypoint Count (Scalar)
    - Waypoint Type (String)
    - Behaviour (String)
    - Combat Mode (String)
    - Speed Mode (String)
    - Formation (String)
    - Code To Execute at Each Waypoint (String)
    - TimeOut at each Waypoint (Array [Min, Med, Max])
Example:
    (begin example)
    [this, getMarkerPos "objective1", 50] call CBA_fnc_taskPatrol
    [this, this, 300, 7, "MOVE", "AWARE", "YELLOW", "FULL", "STAG COLUMN", "this call CBA_fnc_searchNearby", [3, 6, 9]] call CBA_fnc_taskPatrol;
    (end)
Returns:
    Nil
Author:
    Rommel
Liberation adaptation:
    StiegOlSauer
---------------------------------------------------------------------------- */

params [
    ["_group", grpNull, [grpNull, objNull]],
    ["_position", [], [[], objNull, grpNull, locationNull], [2, 3]],
    ["_radius", 100, [0]],
    ["_count", 3, [0]]
];

_group = _group call CBA_fnc_getGroup;
if !(local _group) exitWith {}; // Don't create waypoints on each machine

_position = [_position, _group] select (_position isEqualTo []);
_position = _position call CBA_fnc_getPos;

private _direction = selectRandom [-1, 1];

// Clear existing waypoints first
[_group] call CBA_fnc_clearWaypoints;
{
    _x enableAI "PATH";
} forEach units _group;

// Can pass parameters straight through to addWaypoint
_this =+ _this;
_this set [2,-1];
if (count _this > 3) then {
    _this deleteAt 3;
};

    // Using angles create better patrol patterns
    // Also fixes weird editor bug where all WP are on same position
    private _step = 360 / _count;
    private _startingAngle = random 360;
    for "_i" from 1 to _count do {
        private _offset = random [_step * 0.6, _step * 0.9, _step * 1.3];
        private _radius = _radius + random (_radius/4);
        private _innerRadius = _radius - random (_radius/4);
        private _rad = sqrt (_innerRadius^2 + random (_radius^2 - _innerRadius^2));
        private _theta = _startingAngle + (_i * _step + _offset) * _direction;

        private _pos = _position getPos [_rad, _theta];
        if (surfaceIsWater _pos) then {
            continue;
        };

        _this set [1, _pos];
        _this call CBA_fnc_addWaypoint;
    };
    deleteWaypoint [_group, currentWaypoint _group]; // Remove starting waypoint, which is usually in the center of a location
    [_group, (waypointPosition ((waypoints _group) select 0)) findEmptyPosition [0,20], 10] call CBA_fnc_setPos;

// Close the patrol loop
_this set [1, waypointPosition ((waypoints _group) select 0)];
_this set [2, _radius];
_this set [3, "CYCLE"];
_this call CBA_fnc_addWaypoint;

private _c = selectRandom ["ColorGrey", "ColorGreen", "ColorBlue", "ColorRed", "ColorYellow", "ColorBlack", "ColorOrange", "ColorWhite"];
{
    _marker = createMarker [format ["%1_%2", _group, _x], waypointPosition _x];
    _marker setMarkerTypeLocal "hd_dot";
    _marker setMarkerText format["%1", _forEachIndex];
    _marker setMarkerColor _c;
} forEach (waypoints _group);
