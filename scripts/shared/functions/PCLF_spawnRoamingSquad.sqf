params ["_location", "_remainingGarrison", "_loadoutHash", "_isSpec", "_behavior", "_combatMode"];
private ["_spawnpos", "_grp", "_baseClass", "_squadComp", "_size"];

_size = [_location] call LP_getLocationMaxSize;
private _ret = ["regular", _isSpec] call PCLF_getAdaptiveSquadComp;
_baseClass = _ret select 0;
_squadComp = _ret select 1;

if ((count _squadComp) > _remainingGarrison) then {
    _squadComp resize _remainingGarrison;
};

_spawnpos = (position _location) findEmptyPosition [0,100];
_grp = createGroup GRLIB_side_enemy;
{
    _baseClass createUnit [_spawnpos, _grp,'this addMPEventHandler ["MPKilled", {_this spawn kill_manager}]'];
    [(units _grp) select _forEachIndex, _x, _forEachIndex+1, _loadoutHash] call PCLF_swap_loadout;
    _spawnpos = (position _location) findEmptyPosition [0,100];
} forEach _squadComp;

_grp setVariable [LP_group_assignment_var, _location];
_grp setCombatMode _combatMode;
_grp setCombatBehaviour _behavior;
(leader _grp) setUnitRank "LIEUTENANT";

[
    _grp, _location,
    ([_location] call LP_getLocationMaxSize) / 11, // radius
    5,   // count
    "MOVE",
    _behavior,
    _combatMode,
    "LIMITED",
    "FILE",
    "this call PCLF_CBA_searchNearby",  // action on each WP
    [1, 2, 3]  // wait time (min, med, max)
] call PCLF_CBA_taskPatrol;

_grp
