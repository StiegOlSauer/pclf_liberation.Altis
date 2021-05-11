GRLIB_uptier_readiness = 70;

// kill_manager = compileFinal preprocessFileLineNumbers "scripts\shared\kill_manager.sqf";
kill_manager = compileFinal preprocessFileLineNumbers "scripts\shared\PCLF_kill_manager.sqf";

build_remote_call = compileFinal preprocessFileLineNumbers "scripts\server\remotecall\build_remote_call.sqf";
build_fob_remote_call = compileFinal preprocessFileLineNumbers "scripts\server\remotecall\build_fob_remote_call.sqf";
cancel_build_remote_call = compileFinal preprocessFileLineNumbers "scripts\server\remotecall\cancel_build_remote_call.sqf";
prisonner_remote_call = compileFinal preprocessFileLineNumbers "scripts\server\remotecall\prisonner_remote_call.sqf";
recycle_remote_call = compileFinal preprocessFileLineNumbers "scripts\server\remotecall\recycle_remote_call.sqf";
reinforcements_remote_call = compileFinal preprocessFileLineNumbers "scripts\server\remotecall\reinforcements_remote_call.sqf";
sector_liberated_remote_call = compileFinal preprocessFileLineNumbers "scripts\server\remotecall\sector_liberated_remote_call.sqf";
intel_remote_call = compileFinal preprocessFileLineNumbers "scripts\server\remotecall\intel_remote_call.sqf";
start_secondary_remote_call = compileFinal preprocessFileLineNumbers "scripts\server\remotecall\start_secondary_remote_call.sqf";
recalculate_unitcap_remote_call = compileFinal preprocessFileLineNumbers "scripts\server\remotecall\recalculate_unitcap_remote_call.sqf";
assign_curator_remotecall = compileFinal preprocessFileLineNumbers "scripts\server\remotecall\assign_curator_remotecall.sqf";
assign_curator_opfor_remotecall = compileFinal preprocessFileLineNumbers "scripts\server\remotecall\assign_curator_opfor_remotecall.sqf";
//terror_remote_call = compileFinal preprocessFileLineNumbers "scripts\server\remotecall\terror_remote_call.sqf";

remote_call_sector = compileFinal preprocessFileLineNumbers "scripts\client\remotecall\remote_call_sector.sqf";
remote_call_fob = compileFinal preprocessFileLineNumbers "scripts\client\remotecall\remote_call_fob.sqf";
remote_call_battlegroup = compileFinal preprocessFileLineNumbers "scripts\client\remotecall\remote_call_battlegroup.sqf";
remote_call_endgame = compileFinal preprocessFileLineNumbers "scripts\client\remotecall\remote_call_endgame.sqf";
remote_call_prisonner = compileFinal preprocessFileLineNumbers "scripts\client\remotecall\remote_call_prisonner.sqf";
remote_call_switchmove = compileFinal preprocessFileLineNumbers "scripts\client\remotecall\remote_call_switchmove.sqf";
remote_call_ammo_bounty = compileFinal preprocessFileLineNumbers "scripts\client\remotecall\remote_call_ammo_bounty.sqf";
remote_call_civ_penalty = compileFinal preprocessFileLineNumbers "scripts\client\remotecall\remote_call_civ_penalty.sqf";
remote_call_intel = compileFinal preprocessFileLineNumbers "scripts\client\remotecall\remote_call_intel.sqf";
remote_call_incoming = compileFinal preprocessFileLineNumbers "scripts\client\remotecall\remote_call_incoming.sqf";
remote_call_addEscapeActions = compileFinal preprocessFileLineNumbers "scripts\client\remotecall\remote_call_addEscapeActions.sqf";
//remote_handleZeusJip = compileFinal preprocessFileLineNumbers "scripts\client\remotecall\remote_handleZeusJip.sqf";
//remote_call_terror = compileFinal preprocessFileLineNumbers "scripts\client\remotecall\remote_call_terror.sqf";

PCLF_swap_loadout = compileFinal preprocessFileLineNumbers "scripts\shared\functions\PCLF_swap_loadout.sqf";
F_curatorBluforLoadout = compileFinal preprocessFileLineNumbers "scripts\shared\functions\F_curatorBluforLoadout.sqf";
uav_open_build_menu = compileFinal preprocessFileLineNumbers "scripts\server\zeus_build\uav_open_build_menu.sqf";
uav_do_build = compileFinal preprocessFileLineNumbers "scripts\server\zeus_build\uav_do_build.sqf";

//we need them here to fire from client on unit spawn
blufor_GL_loadout = compile preprocessFileLineNumbers "scripts\loadouts\blufor\loadout_gl.sqf";
blufor_AT_loadout = compile preprocessFileLineNumbers "scripts\loadouts\blufor\loadout_at.sqf";
blufor_AA_loadout = compile preprocessFileLineNumbers "scripts\loadouts\blufor\loadout_aa.sqf";
blufor_AR_loadout = compile preprocessFileLineNumbers "scripts\loadouts\blufor\loadout_ar.sqf";
blufor_MG_loadout = compile preprocessFileLineNumbers "scripts\loadouts\blufor\loadout_mg.sqf";
blufor_mark_loadout = compile preprocessFileLineNumbers "scripts\loadouts\blufor\loadout_mark.sqf";
blufor_sniper_loadout = compile preprocessFileLineNumbers "scripts\loadouts\blufor\loadout_sniper.sqf";
blufor_crew_loadout = compile preprocessFileLineNumbers "scripts\loadouts\blufor\loadout_crew.sqf";
blufor_spec_loadout = compile preprocessFileLineNumbers "scripts\loadouts\blufor\loadout_spec.sqf";
blufor_rfl_loadout = compile preprocessFileLineNumbers "scripts\loadouts\blufor\loadout_rfl.sqf";
blufor_light_loadout = compile preprocessFileLineNumbers "scripts\loadouts\blufor\loadout_light.sqf";

[] spawn compileFinal preprocessFileLineNumbers "scripts\shared\diagnostics.sqf";
[] spawn compileFinal preprocessFileLineNumbers "scripts\shared\manage_weather.sqf";
