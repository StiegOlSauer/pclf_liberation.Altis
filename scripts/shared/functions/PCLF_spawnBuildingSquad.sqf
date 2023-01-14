params ["_loadoutHash", "_building_defenders_count", "_location", "_building_range", ["_holdPercentage", 0.5], ["_spawnPosOverride", []]];
private ["_grp", "_unit", "_squad_comp", "_base_class", "_defendPos"];

private _ret = ["patrol", false] call PCLF_getAdaptiveSquadComp;
_base_class = _ret select 0;
_squad_comp = _ret select 1;

_spawnpos = _spawnPosOverride;
_defendPos = _spawnPosOverride;
if (_spawnpos isEqualTo []) then {
    _spawnpos = (position _location) findEmptyPosition [0,100];
    _defendPos = position _location;
};
_grp = createGroup GRLIB_side_enemy;
private _groups = [_grp];

for "_i" from 1 to _building_defenders_count do {
    if (_i % 4 == 0) then {
        _grp = createGroup GRLIB_side_enemy;
        _groups pushback _grp;
    };
    _unit = _grp createUnit [_base_class, _spawnpos, [], 0, "NONE"];
    _unit addMPEventHandler ["MPKilled", {_this spawn kill_manager}];
    [_unit, (selectRandom _squad_comp), _i+1, _loadoutHash] call PCLF_swap_loadout;
    _spawnpos = (position _location) findEmptyPosition [0,100];
};

_groups apply {
    _x setVariable [LP_group_assignment_var, _location];
    (leader _x) setUnitRank "SERGEANT";
    [
        _x, _defendPos, _building_range, 2, false, _holdPercentage, true,
        "sleep 3; !alive _unit || (damage _unit) > 0 || (_unit nearEntities [['Man'], 10]) findIf {side _x == GRLIB_side_friendly} != -1"
    ] call PCLF_taskDefend;
};

_groups
