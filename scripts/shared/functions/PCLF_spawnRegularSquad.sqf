params ["_location", "_remainingLimit", "_loadoutHash", "_isSpec", ["_spawnPosOverride", []], ["_behavior", "SAFE"], ["_combatMode", "GREEN"]];
private ["_spawnpos", "_grp", "_baseClass", "_squadComp"];

private _ret = ["regular", _isSpec] call PCLF_getAdaptiveSquadComp;
_baseClass = _ret select 0;
_squadComp = _ret select 1;

if ((count _squadComp) > _remainingLimit) then {
    _squadComp resize _remainingLimit;
};

_spawnpos = _spawnPosOverride;
if (_spawnpos isEqualTo []) then {
//     _spawnpos = [position _location, 5, 50, 3] call BIS_fnc_findSafePos;
    _spawnpos = (position _location) findEmptyPosition [0,100];
};
_grp = createGroup GRLIB_side_enemy;
{
    _baseClass createUnit [_spawnpos, _grp,'this addMPEventHandler ["MPKilled", {_this spawn kill_manager}]'];
    [(units _grp) select _forEachIndex, _x, _forEachIndex+1, _loadoutHash] call PCLF_swap_loadout;
//     _spawnpos = [_spawnpos, 5, 20, 10, 0, 0, 0] call BIS_fnc_findSafePos;
    _spawnpos = (position _location) findEmptyPosition [0,100];
} forEach _squadComp;

_grp setVariable [LP_group_assignment_var, _location];
_grp setCombatMode _combatMode;
_grp setCombatBehaviour _behavior;
(leader _grp) setUnitRank "LIEUTENANT";

_grp
