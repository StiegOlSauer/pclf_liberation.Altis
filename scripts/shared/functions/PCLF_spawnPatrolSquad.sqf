params ["_location", "_patrolsCount", "_range","_remainingGarrison", "_loadoutHash", "_isSpec", "_behavior", "_combatMode"];
private ["_spawnpos", "_grp", "_baseClass", "_squadComp", "_groups"];

private _ret = ["patrol", _isSpec] call PCLF_getAdaptiveSquadComp;
_baseClass = _ret select 0;
_squadComp = _ret select 1;

_groups = [];
for "_i" from 1 to _patrolsCount do {
    if (_remainingGarrison <= 0) exitWith {_groups};
    _spawnpos = (position _location) findEmptyPosition [0,100];
    if ((count _squadComp) > _remainingGarrison) then {
        _squadComp resize _remainingGarrison;
    };
    _remainingGarrison = _remainingGarrison - (count _squadComp);

    _grp = createGroup GRLIB_side_enemy;
    {
        _unit = _grp createUnit [_baseClass, _spawnpos, [], 0, "NONE"];
        _unit addMPEventHandler ["MPKilled", {_this spawn kill_manager}];
        [_unit, _x, _forEachIndex+1, _loadoutHash] call PCLF_swap_loadout;
        _spawnpos = (position _location) findEmptyPosition [0,100];
    } forEach _squadComp;

    _grp setVariable [LP_group_assignment_var, _location];
    _grp setCombatMode _combatMode;
    _grp setCombatBehaviour _behavior;
    (leader _grp) setUnitRank "SERGEANT";

    [
        _grp, _location, _range, 8,
        "MOVE", _behavior, _combatMode,
        "LIMITED", "FILE",
        "",             // action on each WP
        [60, 120, 180]  // wait time (min, med, max)
    ] call PCLF_CBA_taskPatrol;
    _groups pushBack _grp;
};

_groups
