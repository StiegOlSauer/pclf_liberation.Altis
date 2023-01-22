params ["_location", "_loadoutHash", "_garrison", "_searchRange", "_minStaticsOnRoofs"];
private ["_base_class", "_squad_comp"];

private _staticPositions = [];
private _staticPlaceholder = "Sign_Arrow_F";
private _alert = [_location, "alert"] call LP_getLocationProperty;
private _military_defenders_posts = 0;
private _ret = ["guard", false] call PCLF_getAdaptiveSquadComp;
_base_class = _ret select 0;
_squad_comp = _ret select 1;

private _rooftop_buildings = ["Land_Cargo_House_V1_F", "Land_Cargo_House_V2_F", "Land_Cargo_House_V3_F"];
private _mil_buildings = ["Land_Cargo_Patrol_V1_F","Land_Cargo_Patrol_V2_F","Land_Cargo_Patrol_V3_F", "Land_Cargo_House_V1_F", "Land_Cargo_House_V2_F", "Land_Cargo_House_V3_F"];

private _rooftops = (nearestObjects [position _location, _rooftop_buildings, _searchRange]) select {alive _x};
if (_rooftops isNotEqualTo []) then {
    _rooftops = _rooftops call BIS_fnc_arrayShuffle;
    _rooftops resize (ceil ((count _rooftops) * (_alert / 100)) min _minStaticsOnRoofs);
    _rooftops apply {
        private _hash = (LP_compositions get "fortifications") get "rooftop";
        private _compName = format ["fortifications/rooftop/%1", selectRandom (keys _hash)];
        [_compName, _x] call PCLF_spawnOnRoof;
        [_location, _compName] call LP_setLocationRoofDefence;

        private _weapon = (["static"] call PCLF_getOpforVehicle) # 0;
        ((position _x) nearObjects [_staticPlaceholder, 100]) apply {
            private _staticPos = getPosATL _x;
            deleteVehicle _x;
            private _s = createVehicle [_weapon, _staticPos, [], 0, "CAN_COLLIDE"];
            _s setPosATL _staticPos;
            _s setVectorUp [0.001, 0.001, 1];
            _military_defenders_posts = _military_defenders_posts + 1;
            sleep 0.1;
        };
    };
};

((nearestObjects [position _location, _mil_buildings, _searchRange]) select {alive _x}) apply {
    _military_defenders_posts = _military_defenders_posts + count (_x buildingPos -1);
};
_military_defenders_posts = [_military_defenders_posts, _garrison] select (_garrison < _military_defenders_posts);
if (_military_defenders_posts == 0) exitWith {[]};

_spawnpos = (position _location) findEmptyPosition [0,100];
private _grp = createGroup GRLIB_side_enemy;
private _groups = [_grp];
{
    _unit = _grp createUnit [_base_class, _spawnpos, [], 0, "NONE"];
    _unit addMPEventHandler ["MPKilled", {_this spawn kill_manager}];
    [_unit, (selectRandom _squad_comp), _forEachIndex+1, _loadoutHash] call PCLF_swap_loadout;
    _x assignAsGunner _x;
    _unit moveInGunner _x;
} forEach ((position _location) nearObjects ["StaticWeapon", _searchRange]);

_grp = createGroup GRLIB_side_enemy;
_groups pushback _grp;
for "_i" from 1 to (_military_defenders_posts) do {
    if (_i % 7 == 0) then {
        _grp = createGroup GRLIB_side_enemy;
        _groups pushback _grp;
    };
    _unit = _grp createUnit [_base_class, _spawnpos, [], 0, "NONE"];
    _unit addMPEventHandler ["MPKilled", {_this spawn kill_manager}];
    [_unit, (selectRandom _squad_comp), _i+1, _loadoutHash] call PCLF_swap_loadout;
    _spawnpos = _spawnpos findEmptyPosition [0,100];
};

_groups apply {
	_x setVariable [LP_group_assignment_var, _location];
    (leader _x) setUnitRank "SERGEANT";
    [
        _x, (position _location), _searchRange, 1, false, 0.9, true,
        "sleep 3; !alive _unit || (damage _unit) > 0 || (_unit nearEntities [['Man'], 10]) findIf {side _x == GRLIB_side_friendly} != -1",
        _mil_buildings
    ] call PCLF_taskDefend;
};

_groups
