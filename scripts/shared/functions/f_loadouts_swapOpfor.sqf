if (!isServer) exitWith {};

params ["_unitsArray"];

{
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
} foreach _unitsArray;