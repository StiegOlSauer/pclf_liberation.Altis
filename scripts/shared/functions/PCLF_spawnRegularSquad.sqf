params ["_sector", "_loadoutHash", "_spec_squad"];
private ["_sectorpos", "_spawnpos", "_grp", "_tier", "_base_class", "_squad_comp"];

private _ret = ["regular", _spec_squad] call PCLF_getAdaptiveSquadComp;
_base_class = _ret select 0;
_squad_comp = _ret select 1;
_sectorpos = [ getMarkerPos _sector, random 100, random 360 ] call BIS_fnc_relPos;
_spawnpos = zeropos;
while { _spawnpos distance zeropos < 1000 } do {
	_spawnpos = ([ _sectorpos, random 50, random 360 ] call BIS_fnc_relPos) findEmptyPosition [5, 100, "B_Heli_Light_01_F"];
	if (count _spawnpos == 0) then { _spawnpos = zeropos; };
};

_grp = createGroup GRLIB_side_enemy;
{
    _base_class createUnit [_spawnpos, _grp,'this addMPEventHandler ["MPKilled", {_this spawn kill_manager}]'];
    [(units _grp) select _forEachIndex, _x, _forEachIndex+1, _loadoutHash] call PCLF_swap_loadout;
} forEach _squad_comp;

_grp
