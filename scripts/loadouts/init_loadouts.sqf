_is_rhs = false;
_rhs_classnames = [ "rhs_weap_ak74m_camo_folded","rhs_weap_ak74m_camo_npz","rhs_weap_pkm","rhs_weap_akms","rhs_weap_ak74m_camo_npz","rhs_weap_svdp_wd_npz","rhs_weap_akm","rhs_weap_rpg7" ];

if ( count ( [ _rhs_classnames, { isClass ( configFile / "cfgWeapons" / _x ) } ] call BIS_fnc_conditionalSelect ) == ( count _rhs_classnames ) ) then { _is_rhs = true };

_loadouts_folder = "scripts\loadouts\vanilla\";
if ( _is_rhs ) then { _loadouts_folder = "scripts\loadouts\rhs\"; };

loadout_crewman = compile preprocessFileLineNumbers (format ["%1%2.sqf", _loadouts_folder, "crewman" ]);
loadout_sl = compile preprocessFileLineNumbers (format ["%1%2.sqf", _loadouts_folder, "sl" ]);
loadout_rifleman = compile preprocessFileLineNumbers (format ["%1%2.sqf", _loadouts_folder, "rifleman" ]);
loadout_autorifleman = compile preprocessFileLineNumbers (format ["%1%2.sqf", _loadouts_folder, "autorifleman" ]);
loadout_rifleman_light = compile preprocessFileLineNumbers (format ["%1%2.sqf", _loadouts_folder, "rifleman_light" ]);
loadout_marksman = compile preprocessFileLineNumbers (format ["%1%2.sqf", _loadouts_folder, "marksman" ]);
loadout_at = compile preprocessFileLineNumbers (format ["%1%2.sqf", _loadouts_folder, "at" ]);
loadout_mg = compile preprocessFileLineNumbers (format ["%1%2.sqf", _loadouts_folder, "mg" ]);
//hunter with a shotgun
//hunter with light sniper rifle
//engineer

militia_standard_squad = [ loadout_sl, loadout_autorifleman, loadout_rifleman, loadout_rifleman, loadout_rifleman_light, loadout_rifleman_light, loadout_marksman, loadout_at, loadout_at, loadout_at, loadout_mg, loadout_autorifleman, loadout_rifleman, loadout_rifleman_light, loadout_rifleman ];

opfor_sentry_loadout = compile preprocessFileLineNumbers "scripts\loadouts\opfor\soldier_lat.sqf";		
opfor_rifleman_loadout = compile preprocessFileLineNumbers "scripts\loadouts\opfor\soldier.sqf";		
opfor_grenadier_loadout = compile preprocessFileLineNumbers "scripts\loadouts\opfor\soldier_gl.sqf";	
opfor_squad_leader_loadout = compile preprocessFileLineNumbers "scripts\loadouts\opfor\soldier_sl.sqf";	
opfor_team_leader_loadout = compile preprocessFileLineNumbers "scripts\loadouts\opfor\soldier_tl.sqf";	
opfor_officer_loadout = compile preprocessFileLineNumbers "scripts\loadouts\opfor\commander.sqf";		
opfor_machinegunner_loadout = compile preprocessFileLineNumbers "scripts\loadouts\opfor\soldier_ar.sqf";
opfor_heavygunner_loadout = compile preprocessFileLineNumbers "scripts\loadouts\opfor\mg.sqf";			
opfor_rpg_loadout = compile preprocessFileLineNumbers "scripts\loadouts\opfor\soldier_at.sqf";			
opfor_at_loadout = compile preprocessFileLineNumbers "scripts\loadouts\opfor\soldier_hat.sqf";			
opfor_aa_loadout = compile preprocessFileLineNumbers "scripts\loadouts\opfor\soldier_aa.sqf";			
opfor_marksman_loadout = compile preprocessFileLineNumbers "scripts\loadouts\opfor\sniper.sqf";			
opfor_sharpshooter_loadout = compile preprocessFileLineNumbers "scripts\loadouts\opfor\sharpshooter.sqf";
opfor_sniper_loadout = compile preprocessFileLineNumbers "scripts\loadouts\opfor\hsniper.sqf";			
opfor_medic_loadout = compile preprocessFileLineNumbers "scripts\loadouts\opfor\medic.sqf";				
opfor_engineer_loadout = compile preprocessFileLineNumbers "scripts\loadouts\opfor\engineer.sqf";		
opfor_crew_loadout = compile preprocessFileLineNumbers "scripts\loadouts\opfor\loadout_crewman.sqf";
opfor_general_loadout = compile preprocessFileLineNumbers "scripts\loadouts\opfor\loadout_general.sqf";

civilian_loadout = compile preprocessFileLineNumbers "scripts\loadouts\civilian.sqf";

hobo1_loadout = compile preprocessFileLineNumbers "scripts\loadouts\hobos\hobo1.sqf";
hobo2_loadout = compile preprocessFileLineNumbers "scripts\loadouts\hobos\hobo2.sqf";
hobo3_loadout = compile preprocessFileLineNumbers "scripts\loadouts\hobos\hobo3.sqf";
hobo4_loadout = compile preprocessFileLineNumbers "scripts\loadouts\hobos\hobo4.sqf";

hobo_loadouts = [hobo1_loadout, hobo2_loadout, hobo3_loadout, hobo4_loadout];

militia_standard_squad = [ loadout_sl, loadout_autorifleman, loadout_rifleman, loadout_rifleman, loadout_rifleman_light, loadout_rifleman_light, loadout_marksman, loadout_at, loadout_at, loadout_at ];