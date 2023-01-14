/* ----------------------------------------------------------------------------
Function: CBA_fnc_searchNearby

Description:
    A function for a group to search a nearby building.

Parameters:
    - Group (Group or Object)

Example:
    (begin example)
    [group player] call CBA_fnc_searchNearby
    (end)

Returns:
    Nil

Author:
    Rommel, SilentSpike

Liberation adaptation:
    StiegOlSauer

---------------------------------------------------------------------------- */
params ["_group"];

_group = _group call CBA_fnc_getGroup;
if !(local _group) exitWith {}; // Don't create waypoints on each machine

private _building = nearestBuilding (leader _group);
if (isNil "_building" || ((leader _group) distanceSqr _building > 250e3) || ! (alive _building) || (count (units _group)) == 1) exitWith {};

[_group, _building] spawn {
    params ["_group", "_building"];
    private _leader = leader _group;

    (3 boundingBoxReal _building) params ["_pos1", "_pos2"];
    _pos1 params ["_x1", "_y1", "_z1"];
    _pos2 params ["_x2", "_y2", "_z2"];

    _nearBuildingPositions = [
//     building corners
        [_x2, _y2, 0],
        [_x1, _y2, 0],
        [_x1, _y1, 0],
        [_x2, _y1, 0],
//     centers of each side
        [(_x1 + _x2)/2, _y1, 0],
        [(_x1 + _x2)/2, _y2, 0],
        [_x1, (_y1 + _y2)/2, 0],
        [_x2, (_y1 + _y2)/2, 0]
    ];

    // Add a waypoint to regroup after the search
    _group lockWP true;

    // Prepare group to search
    _group setCombatBehaviour (combatBehaviour _group);
    _group setFormDir ([_leader, _building] call BIS_fnc_dirTo);

    // Check for available positions
    private _positions = [];

    private _searchGroup = [];
    // Update units in case of death
    private _units = (units _group) - [_leader];
    // Abort search if the group has no units left
    if (_units isEqualTo []) exitWith {};

    private _bPositions = _building buildingPos -1;
    for "_i" from 1 to ceil ((count _units) / 2) do {
        if (_bPositions isEqualTo []) exitWith {};
        private  _p = selectRandom _bPositions;
        _positions pushback _p;
        _bPositions deleteAt (_bPositions find _p);
    };

    // Send one available unit to the next available position
    {
        if (_positions isEqualTo []) then {
            [_x, _building modelToWorld (selectRandom _nearBuildingPositions), _searchGroup] spawn {
                params ["_u", "_buildingPos", "_searchGroup"];
                private _orderIssued = time;
                _u doMove _buildingPos;
                waituntil {sleep 1; unitReady _u || time > _orderIssued + 60};
                doStop _u;
                waituntil {sleep 1; damage _u != 0 || ({alive _x && unitReady _x} count _searchGroup) == (count _searchGroup) || time > _orderIssued + 60};
                _u doMove (position _u);
            };
        } else {
        _searchGroup pushBack _x;
            [_x, _positions deleteAt 0, _building modelToWorld (selectRandom _nearBuildingPositions)] spawn {
                params ["_u", "_p", "_buildingPos"];
                if (isNil "_p") exitWith {};
                private _orderIssued = time;
                _u doMove _p;
            };
        };
        sleep 2;
    } forEach _units;
    waitUntil {({unitReady _x || !(alive _x)} count _units) == count _units};

    _group lockWP false;
};
