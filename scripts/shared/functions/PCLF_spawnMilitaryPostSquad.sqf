params ["_sectorpos", "_loadoutHash"];
private ["_base_class", "_squad_comp"];

private _military_defenders_posts = 0;
private _ret = ["guard", false] call PCLF_getAdaptiveSquadComp;
_base_class = _ret select 0;
_squad_comp = _ret select 1;

private _mil_buildings = ["Land_Cargo_Patrol_V1_F","Land_Cargo_Patrol_V2_F","Land_Cargo_Patrol_V3_F", "Land_Cargo_House_V1_F", "Land_Cargo_House_V2_F", "Land_Cargo_House_V3_F"];

((nearestObjects [_sectorpos, _mil_buildings, GRLIB_capture_size]) select {alive _x}) apply {
    _military_defenders_posts = _military_defenders_posts + count (_x buildingPos -1);
};
if (_military_defenders_posts == 0) exitWith {[]};

private _grp = createGroup GRLIB_side_enemy;
private _groups = [_grp];
for "_i" from 1 to (_military_defenders_posts) do {
    if (_i % 7 == 0) then {
        _grp = createGroup GRLIB_side_enemy;
        _groups pushback _grp;
    };
    _unit = _grp createUnit [_base_class, _sectorpos, [], 0, "NONE"];
    _unit addMPEventHandler ["MPKilled", {_this spawn kill_manager}];
    [_unit, (selectRandom _squad_comp), _i+1, _loadoutHash] call PCLF_swap_loadout;
};

_groups apply {
    [
        _x, _sectorpos, GRLIB_capture_size, 1, false, 0.9, true,
        "sleep 3; !alive _unit || (damage _unit) > 0 || (_unit nearEntities [['Man'], 10]) findIf {side _x == GRLIB_side_friendly} != -1",
        _mil_buildings
    ] call PCLF_taskDefend;
};

_groups
