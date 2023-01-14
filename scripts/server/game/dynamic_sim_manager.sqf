private [
    "_playersNearLocation", "_loc", "_contestedLocations", "_closeCombatLocations", "_normalInf", "_normalVeh", "_closeInf", "_closeVeh", "_longRangeInf", "_longRangeVeh", "_preset"
];

_longRangeInf = 1000;
_longRangeVeh = 1000;
_normalInf = 700;
_normalVeh = 700;
_closeInf = 300;
_closeVeh = 250;

private _presetNormal = [_normalInf, _normalVeh];
private _presetClose = [_closeInf, _closeVeh];
private _presetLong = [_longRangeInf, _longRangeVeh];

while {true} do {
    sleep 30;
    _contestedLocations = [];
    _closeCombatLocations = [];

    _preset = _presetNormal;
    if ((LP_active_locations findIf {([_x] call LP_getLocationType) == LP_location_radio}) != -1) then {
        _preset = _presetLong;
    };

    LP_active_locations apply {
        _loc = _x;
        private _zone_marker = [_loc] call LP_getLocationZoneMarker; // Find markers since their area is 1/2 of location activation area, which is convenient for calculations
        _playersNearLocation = ((call BIS_fnc_listPlayers) inAreaArray _zone_marker);
        if ((count _playersNearLocation) > 0) then {
            _contestedLocations pushBack _loc;
        };
        if ((_playersNearLocation findIf {_x distance (locationPosition _loc) <= (([_loc] call LP_getLocationMaxSize) / 3)}) != -1) then {
            _closeCombatLocations pushBack _loc;
        };
//          diag_log format ["Curent preset: %4. Checking location %1 of type (%2) - closeCombat range: %3, zone range - %6, player distance = %5", (name _x), [_x] call LP_getLocationType, (([_loc] call LP_getLocationMaxSize) / 3), dynamicSimulationDistance "Group", (player distance (locationPosition _loc)), markerSize _zone_marker];
//          diag_log format ["CONTESTED LOCATIONS: %1", _contestedLocations];
//          diag_log format ["CLOSECOMBAT LOCATIONS: %1", _closeCombatLocations];
    };

    if (_contestedLocations isEqualTo _closeCombatLocations && (count _closeCombatLocations) > 0) then {
        _preset = _presetClose;
    };

    if (dynamicSimulationDistance "Group" != (_preset select 0)) then {
        "Group" setDynamicSimulationDistance (_preset select 0);
        "Vehicle" setDynamicSimulationDistance (_preset select 1);
    };
};


