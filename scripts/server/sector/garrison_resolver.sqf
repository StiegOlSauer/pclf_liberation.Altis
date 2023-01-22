params ["_location", "_locationGroups", "_loadoutHash"];
private ["_garrisonRemaining", "_spawnedUnits", "_garrisonMax", "_zoneMarker", "_grp", "_groups", "_spawnThreshold"];


_findLocationPosition = {
    params ["_location", "_locationSize"];
    private ["_goodPos", "_blackListZones", "_rad", "_validityChecker", "_position"];

    _goodPos = [];
    for "_i" from _locationSize to (_locationSize / 10) step -100 do {
        diag_log format ["SAMPLING POSITION %1 METERS AWAY", _i];
        _blackListZones = [];
        (allPlayers select {_x inArea _location}) apply {
            _rad = (_x distance (position _location))/1.5 min 400;
            _rad = _rad max 40;
            _blackListZones pushBack [position _x, _rad];
        };
        _validityChecker = format [
            "private _thisSoldierHeight = [_this select 0, _this select 1, (getTerrainHeightASL _this) + 1.75]; ((_this isFlatEmpty [2]) isNotEqualTo []) && ((_this distance %1) <= %2) && ((allPlayers select {_x inArea '%3'}) findIf {([objNull, 'VIEW'] checkVisibility [eyePos _x, _thisSoldierHeight]) == 1} == -1)",
            position _location, _i, _zoneMarker
                                  ];
        _position = [
            [_location],
            _blackListZones,
            (compile _validityChecker)
        ] call BIS_fnc_randomPos;
        diag_log format ["GOT POSITION FROM RANDOMPOS: %1", _position];
        if (_position isEqualTo [0, 0]) exitWith {};
        diag_log format ["IT IS A GOOD POSITION"];
        _goodPos = _position;
    };
    if (_goodPos isEqualTo []) then {
        diag_log format ["POSITION WAS NOT FOUND, WILL USE SAFE ONE!"];
        _goodPos = [
            [_location], [],
            {
                ((_this isFlatEmpty [2, -1, -1, 1, 0, false]) isNotEqualTo []) && ((allPlayers findIf {(_x distance _this) <= 350}) == -1)
            }
        ] call BIS_fnc_randomPos;
    };
    diag_log format ["POSITION: %1", _goodPos];

    deleteMarker format ["%1_1", name _location];
    private _c = selectRandom ["ColorGrey", "ColorGreen", "ColorBlue", "ColorRed", "ColorYellow", "ColorBlack", "ColorOrange", "ColorWhite"];
    _marker = createMarker [format ["%1_1", name _location], _goodPos];
    _marker setMarkerTypeLocal "mil_warning";
    _marker setMarkerColor _c;

    _goodPos
};

_findLocationBuilding = {
    params ["_location", "_locationSize"];
    private ["_buildings", "_bldg"];

    _buildings = ((position _location) nearObjects ["House", (_locationSize / 4)]) select {
        private _bldg = _x;
        private _nearPlayers = (allPlayers select {_x inArea _location}) findIf {_x distance (position _bldg) <= 40} != -1;
        private _occupied = count (_x getVariable ["CBA_taskDefend_positions", []]) < 3;
        (alive _x) && ! _occupied && ! _nearPlayers
    };
    if (_buildings isEqualTo []) exitWith {[ [], 0]};
    _bldg = selectRandom _buildings;

    deleteMarker format ["%1_bldg", name _location];
    private _c = selectRandom ["ColorGrey", "ColorGreen", "ColorBlue", "ColorRed", "ColorYellow", "ColorBlack", "ColorOrange", "ColorWhite"];
    _marker = createMarker [format ["%1_bldg", name _location], position _bldg];
    _marker setMarkerTypeLocal "mil_warning";
    _marker setMarkerColor _c;

    [position _bldg, count (_bldg getVariable "CBA_taskDefend_positions")]
};


_locationSize = [_location] call LP_getLocationMaxSize;
_spawnThreshold = 5;
_spawnedUnits = [];
_locationGroups apply {
    _spawnedUnits = _spawnedUnits + (units _x);
};
_garrisonMax = [_location, "garrison_max"] call LP_getLocationProperty;
_garrisonRemaining = [_location, "garrison"] call LP_getLocationProperty;
_garrisonRemaining = _garrisonRemaining - (count _spawnedUnits);
_zoneMarker = [_location] call LP_getLocationZoneMarker;

diag_log format ["CHECKING FOR EXTRA-GARRISON ACTIONS IN %1 - %2 / %3", name _location, _garrisonRemaining, _garrisonMax];
if (_garrisonRemaining <= ((0.1 * _garrisonMax) min (0.5 * LP_unitcap_location))) exitWith {};
if (_garrisonRemaining <= ((0.5 * _garrisonMax) min LP_unitcap_location)) exitWith {
    waitUntil {sleep 60; not ([_location] call LP_isLocationActive)};
    if (side _location == GRLIB_side_friendly) then {
        // TODO: Regroup spawn and counter-attack:
        // 1. Spawn stuff at the border of a sector
        // 2. Do not enable DynSim
        // 3. call taskAttack on spawned groups
        // 4. send locationUnderAttack event
    };
};

diag_log format ["EXCESS OF GARRISON IS DETECTED IN %1. GOING TO CREEEP SPAWN PLAYERS", name _location];
diag_log format ["%1: while {sleep 45; %2 > 0 && (%3)}", name _location, _garrisonRemaining, [_location] call LP_isLocationActive];
while {sleep 45; _garrisonRemaining > 0 && ([_location] call LP_isLocationActive)} do {
    diag_log format ["CHECKING IF GARRISON IS GOING TO FLEE %1: %2", name _location, _garrisonRemaining];
    if ((_garrisonRemaining <= ((0.3 * _garrisonMax) min (0.5 * LP_unitcap_location))) && !(([_location] call LP_getLocationType) in LP_locations_military)) exitWith {
            // This is needed to simulate garrison fleeing from attacked location
            // TODO: 1. Relocate garrison into nearest OPFOR sector
            //       2. In Locations statemachine add transition for attacking nearest sector if garrison exceedes some value (33% of location's garrison_max?)
    };

    private _vacantSpawns = (count _spawnedUnits) - ({alive _x} count _spawnedUnits);
    diag_log format ["CHECKING HOW MANY we could spawn: %1", _vacantSpawns];
    if (_vacantSpawns < _spawnThreshold) then {continue};
    diag_log format ["READY TO START SPAWNING %1 AIs!", _vacantSpawns];

    _groups = [];
    while {_vacantSpawns > 1} do {
        switch (ceil (random 2)) do {
            case 1: {
                private _ret = [_location, _locationSize] call _findLocationBuilding;
                _ret params ["_pos", "_bPosCount"];
                diag_log format ["FOUND BUILDING: %1!", _ret];
                if ((_pos isNotEqualTo []) && (_bPosCount > 0) && false) then {
                    _bPosCount = _bPosCount min _vacantSpawns;
                    diag_log format ["GOING TO SPAWN BUILDING SQUADS OF %1 MEN", _bPosCount];
                    private _spawnedGroups = [_loadoutHash, _bPosCount, _location, 25, 0, _pos] call PCLF_spawnBuildingSquad;
                    private _diag_grp_cnt = 0;
                    _spawnedGroups apply {_vacantSpawns = _vacantSpawns - (count (units _x)); _diag_grp_cnt = _diag_grp_cnt + (count (units _x))};
                    _groups append _spawnedGroups;
                    diag_log format ["SPAWNED BUILDING SQUADS %1 OF %2 MEN", _spawnedGroups, _diag_grp_cnt];
                };
            };
            case 2: {
                diag_log format ["WILL SPAWN %1 ON-FOOT SOLDIERS!", _vacantSpawns];
                _pos = [_location, _locationSize] call _findLocationPosition;
                diag_log format ["SPAWN POSITION FOUND: %1 !", _pos];
                _grp = [_location, _vacantSpawns, _loadoutHash, _pos] call PCLF_spawnRegularSquad;
                diag_log format ["GROUP HAS SPAWNED ON POS: %1 !", _pos];
                private _allyDownSpot = position (selectRandom (_spawnedUnits select {!(alive _x)}));
                [_grp, _allyDownSpot, 100, true] call CBA_fnc_taskAttack;
                diag_log format ["GROUP GOT TASK ATTACK ORDER!"];
                _vacantSpawns = _vacantSpawns - (count (units _grp));
                _groups pushBack _grp;
            };
        };
    };
    _locationGroups append _groups;
    _spawnedUnits = _spawnedUnits select {alive _x};
    _groups apply {
        _spawnedUnits append (units _x);
        _garrisonRemaining = _garrisonRemaining - (count (units _x));
    };
    diag_log format ["GARRISON REMAINING: %1", _garrisonRemaining];
};
diag_log format ["EXITED FROM SCRIPT: %1", name _location];
