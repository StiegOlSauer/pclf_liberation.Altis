params ["_location"];
private [
    "_sectorpos", "_spawncivs", "_building_ai_max", "_building_range", "_iedcount","_vehtospawn","_managed_units", "_minimum_building_positions", "_squadCount", "_bluforCount",
    "_default_behavior", "_alert_level", "_garrison", "_veh_garrison", "_combatMode", "_locationGroups", "_buildingGarrison", "_closePatrols", "_medPatrols", "_deepPatrols",
    "_locationSize", "_defaultBuildingShare", "_managed_vehicles", "_garrisonMaxActual", "_garrisonMax", "_managed_civs", "_garrisonMaxOverride", "_buildingPositionsCount",
    "_minStaticsOnRoofs"
];

waitUntil { !isNil "combat_readiness" };

_sectorpos = locationPosition _location;
_sectorpos set [2, -1 * (_sectorpos select 2)];
_locationSize = [_location] call LP_getLocationMaxSize;
_spawncivs = false;
_iedcount = 0;
_minStaticsOnRoofs = 0;
_loadoutHash = [] call PCLF_prepareSectorArmory;

_isSpecops = {
    if ("specops" in ([_location] call LP_getLocationTraits) || (([_location] call LP_getLocationType in LP_locations_military) && ((random 100) > (combat_readiness * GRLIB_difficulty_modifier)))) exitWith { true };
    false
};

/* Spawning squad types:
 * 1. Patrols: close (r=1/8 of size), med (1/6) and deep (1/4) ranges. Longer range - more patrols (1 for close, 4 for med, 5 for deep).
 * 2. Building garrisons: at least 25% of location garrison, more depending on initial location alert level (higher - more garrisons)
 * 3. Roaming: circulate through location, do "search nearby" action on each WP
 *
 * Spawning order:
 * 0. Follow unitcap limitations, but apply them to sector
 * 1. Place one roaming squad.
 * 2. Try to place Military Post squads (if any), static weapons squads, compositions' placeholders.
 * 3. Place alert_level% (at least 25%) of remaining garrison to buildings. I.e. for 100%, all remaining squads will garrison the buildings
 * 4. Spawn patrols - less alert level - more patrols.
 * 5. Create roaming/building (1/1) squads for the rest of the garrison.
 *
 * After all spawned forces are eliminated and location shall fall into BLUFOR hands:
 * 1. Check what remained of a garrison:
 * 1.1. 10% or less of Unitcap: location becomes BLUFOR remaining OPFOR assimilates,
 *      after some time depending on "civilian resistance (reception?)" mutiny is started. If reception is poor,
 *      OPFOR garrison reinforced by locals at some degree. On highest level of "reception", locals do not allow mutiny to start.
 *
 * 1.2. 11 to 33% of Unitcap: location is BLUFOR. Garrison flees to the nearest location with highest available capacity.
 *      In case of location's over-capacity, it immediately attacks nearest BLUFOR location
 * 1.3. 34 to 50% of Unitcap: location is BLUFOR. Garrison regroups and immediately counter-attacks this location
 * 1.4. 51+% of Unitcap: location is OPFOR. Garrison keeps spawning near the location and at unoccupied houses, battle continues
 *
 */

_managed_civs = [];
_managed_vehicles = [];
_locationGroups = [];
_garrison = [_location, "garrison"] call LP_getLocationProperty; // current quantity of infantry in location garrison
_garrisonMax = [_location, "garrison_max"] call LP_getLocationProperty; // current maximum amount of infantry that sector garrison could hold
_garrisonMaxOverride = [_location, "garrison_override"] call LP_getLocationProperty; // value, below which garrison_max cannot be decreased by any means

 _garrisonMaxActual = 0; // value of garrison_max, provided by actual building positions
(((locationPosition _location) nearObjects ["House", (_locationSize / 4)]) select {alive _x}) apply {
    _garrisonMaxActual = _garrisonMaxActual + count (_x buildingPos -1);
};
_buildingPositionsCount = _garrisonMaxActual;
_garrisonMaxActual = [_garrisonMaxActual, _garrisonMaxOverride] select (_garrisonMaxOverride > _garrisonMaxActual);
if (_garrisonMaxActual < _garrisonMax) then { // "kill" 50% of a garrison which occupied destroyed buildings
    _garrison = _garrison - floor((_garrisonMax - _garrisonMaxActual) * 0.5);
    [_location, "garrison_max", _garrisonMaxActual] call LP_setLocationProperty;
    [_location, "garrison", _garrison] call LP_setLocationProperty;
};

_garrison = _garrison min LP_unitcap_location;
_veh_garrison = [_location, "vehicles"] call LP_getLocationProperty;

if (_garrison == 0 && (count _veh_garrison) == 0) exitWith {
    ["LP_locationCapturedBLUFOR", [_location]] call CBA_fnc_serverEvent;
};

_alert_level = [_location, "alert"] call LP_getLocationProperty;
_default_behavior = "CARELESS";
_combatMode = "GREEN";
if (_alert_level > 10 && _alert_level <= 20) then {
    _default_behavior = "SAFE"; _combatMode = "GREEN";
};
if (_alert_level > 20 && _alert_level <= 50) then {
    _default_behavior = "SAFE"; _combatMode = "WHITE";
} else {
    _default_behavior = "AWARE"; _combatMode = "YELLOW";
};

switch ([_location] call LP_getLocationType) do {
    case LP_location_radio;
    case LP_location_tiny: {
        _defaultBuildingShare = 0.4;
        _closePatrols = 1;
        _medPatrols = (3 - floor (_alert_level / 30)) max 2;
        _deepPatrols = 0;
        _minStaticsOnRoofs = 1;
    };
    case LP_location_outpost;
    case LP_location_factory;
    case LP_location_village: {
        _defaultBuildingShare = 0.35;
        _closePatrols = 1;
        _medPatrols = (4 - floor (_alert_level / 30)) max 2;
        _deepPatrols = (3 - floor (_alert_level / 10)) max 0;
        _minStaticsOnRoofs = 2;
    };
    case LP_location_base_small;
    case LP_location_base;
    case LP_location_airfield;
    case LP_location_city;
    case LP_location_capital: {
        _defaultBuildingShare = 0.25;
        _closePatrols = 2;
        _medPatrols = (4 - floor (_alert_level / 30)) max 2;
        _deepPatrols = (6 - floor (_alert_level / 10)) max 0;
        _minStaticsOnRoofs = 4;
    };
};

diag_log format ["Location: %2 - READY TO SPAWN. Remaining GARRISON %1", _garrison, name _location];
private _groups = [_sectorpos, _loadoutHash, _garrison] call PCLF_spawnCompositionSquads;
_groups apply {
    _locationGroups pushBack _x;
    _garrison = _garrison - count (units _x);
    diag_log format ["Location: %2 - SPAWNED COMP SQUAD. Remaining GARRISON %1", _garrison, name _location];
};
sleep 2;

_groups = [_location, _loadoutHash, _garrison, _locationSize / 4, _minStaticsOnRoofs] call PCLF_spawnMilitaryPostSquad;
_groups apply {
    _locationGroups pushBack _x;
    _garrison = _garrison - count (units _x);
    diag_log format ["Location: %2 - SPAWNED MILPOST SQUAD. Remaining GARRISON %1", _garrison, name _location];
};
sleep 2;

private _buildingShare = [_defaultBuildingShare, _alert_level/100] select (_alert_level > 25);
_buildingGarrison = _buildingPositionsCount min (ceil (_garrison * _buildingShare));
diag_log format ["Location: %4 - Initial building share: %1, free building positions: %2, resulting buildings garrison: %3", _buildingShare, _buildingPositionsCount, _buildingGarrison, name _location];

if (_buildingGarrison > 0) then {
    _groups = [_loadoutHash, _buildingGarrison, _location, _locationSize / 4] call PCLF_spawnBuildingSquad;
    _groups apply {
        _locationGroups pushBack _x;
        _garrison = _garrison - count (units _x);
        _buildingPositionsCount = _buildingPositionsCount - count (units _x);
        diag_log format ["Location: %2 - SPAWNED BUILDING SQUAD. Remaining GARRISON %1", _garrison, name _location];
    };
};
sleep 2;

private _grp = [_location, _garrison, _loadoutHash, (call _isSpecops), _default_behavior, _combatMode] call PCLF_spawnRoamingSquad;
_garrison = _garrison - count (units _grp);
_locationGroups pushback _grp;
diag_log format ["Location: %2 - SPAWNED ROAMING SQUAD. Remaining GARRISON %1", _garrison, name _location];
sleep 2;

{
    _x params ["_count", "_radius"];
    _groups = [_location, _count, _radius, _garrison, _loadoutHash, (call _isSpecops), _default_behavior, _combatMode] call PCLF_spawnPatrolSquad;
    _groups apply {
        _locationGroups pushBack _x;
        _garrison = _garrison - count (units _x);
        diag_log format ["Location: %3 - SPAWNED PATROL SQUAD ON RADIUS %2. Remaining GARRISON %1", _garrison, _radius, name _location];
    };
} foreach [
    [_closePatrols, _locationSize / 5.5],
    [_medPatrols,   _locationSize / 3],
    [_deepPatrols,  _locationSize / 2]
];

while {_garrison > 0} do {
    if ((random 100) > _alert_level) then {
        _grp = [_location, _garrison, _loadoutHash, (call _isSpecops), _default_behavior, _combatMode] call PCLF_spawnRoamingSquad;
        _garrison = _garrison - count (units _grp);
        diag_log format ["Location: %2 - SPAWNED ROAMING SQUAD. Remaining GARRISON %1", _garrison, name _location];
        _locationGroups pushBack _grp;
    } else {
        _buildingGarrison = _garrison min 6;
        if (_buildingPositionsCount < _buildingGarrison) then {_buildingGarrison = _buildingPositionsCount};
        _groups = [_loadoutHash, _buildingGarrison, _location, _locationSize / 4] call PCLF_spawnBuildingSquad;
        _groups apply {
            _locationGroups pushBack _x;
            _garrison = _garrison - count (units _x);
            diag_log format ["Location: %2 - SPAWNED BUILDING SQUAD. Remaining GARRISON %1", _garrison, name _location];
            _buildingPositionsCount = _buildingPositionsCount - count (units _x);
        };
    };
    sleep 2;
};

_locationGroups apply {
    _x enableDynamicSimulation true;
};

{
    private _veh_props = [_x] call PCLF_getOpforVehicle;
    _vehicle = [_sectorpos, _veh_props, _loadoutHash] call F_libSpawnVehicle;
    [group ((crew _vehicle) select 0),_sectorpos] spawn add_defense_waypoints;
    _vehicle enableDynamicSimulation true;
    (group ((crew _vehicle) select 0)) enableDynamicSimulation true;
    _managed_vehicles pushback _vehicle;
} foreach _veh_garrison;

if ( _spawncivs && GRLIB_civilian_activity > 0) then {
     private _civs = ([_location] call F_spawnCivilians);
     _civs apply {(group _x) enableDynamicSimulation true};
     _managed_civs append _civs;
};

[_location, _locationGroups, _managed_vehicles, _managed_civs] call LP_storeLocationSpawnedEntities;
[([_location] call LP_getLocationMarker), (_locationSize / 3), _iedcount] spawn ied_manager;
sleep 3;

[_locationGroups, _location] spawn active_location_statemachine;
[_location, _locationGroups, _loadoutHash] spawn garrison_resolver;
