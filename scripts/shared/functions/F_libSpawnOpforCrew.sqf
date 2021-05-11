params [ "_vehicle", "_loadoutHash"];
private [ "_grp", "_vehcrew" ];

private _ret = ["crew", false] call PCLF_getAdaptiveSquadComp;
_base_class = _ret select 0;
_squad_comp = _ret select 1;

_grp = createGroup EAST;
_vehcrew = [];
while { count units _grp < 3 } do {
	_base_class createUnit [ getpos _vehicle, _grp, "", 0.5, "private"];
};
_grp selectLeader ((units _grp) select 0);
((units _grp) select 0) setRank "CAPTAIN";
((units _grp) select 0) moveInDriver _vehicle;
((units _grp) select 1) moveInGunner _vehicle;
((units _grp) select 2) moveInCommander _vehicle;
{
	if (isNull objectParent _x) then {
		deleteVehicle _x;
	};
    [_x, (selectRandom _squad_comp), 1, _loadoutHash] call PCLF_swap_loadout;
} foreach (units _grp);
