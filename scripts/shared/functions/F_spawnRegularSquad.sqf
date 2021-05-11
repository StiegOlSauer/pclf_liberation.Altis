diag_log format [ "Spawning regular squad at %1", time ];

params [ "_sector", "_squadies_to_spawn" ];
private [ "_sectorpos", "_spawnpos", "_grp", "_unitidx", "_corrected_amount" ];

_sectorpos = [ getMarkerPos _sector, random 100, random 360 ] call BIS_fnc_relPos;

_spawnpos = zeropos;
while { _spawnpos distance zeropos < 1000 } do {
	_spawnpos = ( [ _sectorpos, random 50, random 360 ] call BIS_fnc_relPos ) findEmptyPosition [5, 100, "B_Heli_Light_01_F"];
	if ( count _spawnpos == 0 ) then { _spawnpos = zeropos; };
};

_corrected_amount = round ( (count _squadies_to_spawn) * ([] call F_adaptiveOpforFactor) );
_grp = createGroup GRLIB_side_enemy;
{
	if ( ( count units _grp ) < _corrected_amount) then {
		_x createUnit [_spawnpos, _grp,'this addMPEventHandler ["MPKilled", {_this spawn kill_manager}]'];
	};
	sleep 0.1;
} foreach _squadies_to_spawn;

//if ( _sector in sectors_capture ) then {
	_unitidx = 0;
	{
		if ( (typeof _x) in original_resistance ) then {
			[ _x ] spawn ( militia_standard_squad select _unitidx );
			if ( random 100 < 40 ) then {
				_x addPrimaryWeaponItem "acc_flashlight";
			};
		}
		else {
			switch (typeOf _x) do {
					case opfor_sentry: {[ _x ] call opfor_sentry_loadout};
					case opfor_rifleman: {[ _x ] call opfor_rifleman_loadout};
					case opfor_grenadier: {[ _x ] call opfor_grenadier_loadout};
					case opfor_squad_leader: {[ _x ] call opfor_squad_leader_loadout};
					case opfor_team_leader: {[ _x ] call opfor_team_leader_loadout};			
					case opfor_marksman: {[ _x ] call opfor_marksman_loadout};
					case opfor_machinegunner: {[ _x ] call opfor_machinegunner_loadout};
					case opfor_heavygunner: {[ _x ] call opfor_heavygunner_loadout};
					case opfor_medic: {[ _x ] call opfor_medic_loadout};
					case opfor_rpg: {[ _x ] call opfor_rpg_loadout};
					case opfor_at: {[ _x ] call opfor_at_loadout};			
					case opfor_aa: {[ _x ] call opfor_aa_loadout};
					case opfor_officer: {[ _x ] call opfor_officer_loadout};
					case opfor_sharpshooter: {[ _x ] call opfor_sharpshooter_loadout};
					case opfor_sniper: {[ _x ] call opfor_sniper_loadout};
					case opfor_engineer: {[ _x ] call opfor_engineer_loadout};
				};
		};
		_unitidx = _unitidx + 1;
		if ( _unitidx > 9 ) then { _unitidx = 0 };
	} foreach (units _grp);
//};

diag_log format [ "Done Spawning regular squad at %1", time ];

_grp;
