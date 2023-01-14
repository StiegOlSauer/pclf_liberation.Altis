LP_infantry_weight = 1;
LP_armor_weight = 1;
LP_air_weight = 1;

enableDynamicSimulationSystem true;

"Group" setDynamicSimulationDistance 700;
"Vehicle" setDynamicSimulationDistance 700;
"EmptyVehicle" setDynamicSimulationDistance 200;
"Prop" setDynamicSimulationDistance 50;

"IsMoving" setDynamicSimulationDistanceCoef 1.5;

[] call compileFinal preprocessFileLineNumbers "scripts\server\init_medical.sqf";

// AI
add_civ_waypoints = compileFinal preprocessFileLineNumbers "scripts\server\ai\add_civ_waypoints.sqf";
add_defense_waypoints = compileFinal preprocessFileLineNumbers "scripts\server\ai\add_defense_waypoints.sqf";
battlegroup_ai = compileFinal preprocessFileLineNumbers "scripts\server\ai\battlegroup_ai.sqf";
building_defence_ai = compileFinal preprocessFileLineNumbers "scripts\server\ai\building_defence_ai.sqf";
csat_abandon_vehicle = compileFinal preprocessFileLineNumbers "scripts\server\ai\csat_abandon_vehicle.sqf";
patrol_ai = compileFinal preprocessFileLineNumbers "scripts\server\ai\patrol_ai.sqf";
prisonner_ai = compileFinal preprocessFileLineNumbers "scripts\server\ai\prisonner_ai.sqf";
troup_transport = compileFinal preprocessFileLineNumbers "scripts\server\ai\troup_transport.sqf";
fnc_searchBuilding = compileFinal preprocessFileLineNumbers "scripts\server\ai\fn_SearchBuilding.sqf";

// Battlegroup
spawn_air = compileFinal preprocessFileLineNumbers "scripts\server\battlegroup\spawn_air.sqf";
spawn_battlegroup = compileFinal preprocessFileLineNumbers "scripts\server\battlegroup\spawn_battlegroup.sqf";

// Game
check_victory_conditions = compileFinal preprocessFileLineNumbers "scripts\server\game\check_victory_conditions.sqf";

// Patrol
manage_one_civilian_patrol = compileFinal preprocessFileLineNumbers "scripts\server\patrols\manage_one_civilian_patrol.sqf";
manage_one_patrol = compileFinal preprocessFileLineNumbers "scripts\server\patrols\manage_one_patrol.sqf";
reinforcements_manager = compileFinal preprocessFileLineNumbers "scripts\server\patrols\reinforcements_manager.sqf";
send_paratroopers = compileFinal preprocessFileLineNumbers "scripts\server\patrols\send_paratroopers.sqf";

// Resources
recalculate_caps = compileFinal preprocessFileLineNumbers "scripts\server\resources\recalculate_caps.sqf";

// Secondary objectives
fob_hunting = compileFinal preprocessFileLineNumbers "scripts\server\secondary\fob_hunting.sqf";
convoy_hijack = compileFinal preprocessFileLineNumbers "scripts\server\secondary\convoy_hijack.sqf";
veh_hunt = compileFinal preprocessFileLineNumbers "scripts\server\secondary\veh_hunt.sqf";
//terror_mission = compileFinal preprocessFileLineNumbers "scripts\server\secondary\terror.sqf";
planecrash_mission = compileFinal preprocessFileLineNumbers "scripts\server\secondary\planecrash.sqf";
search_and_rescue = compileFinal preprocessFileLineNumbers "scripts\server\secondary\search_and_rescue.sqf";

//Convoy helpers
convoy_setFormation = compileFinal preprocessFileLineNumbers "scripts\server\ai\ConvoyMaxspeed.sqf";
convoyInit = compileFinal preprocessFileLineNumbers "scripts\server\ai\convoyDefend_init.sqf";
GRLIB_revengeConvoyInit = compileFinal preprocessFileLineNumbers "scripts\server\ai\convoyDefend_init_revenge.sqf";

// Tasks
task_banditCamp = compileFinal preprocessFileLineNumbers "scripts\server\tasks\banditCamp.sqf";
task_roadblock = compileFinal preprocessFileLineNumbers "scripts\server\tasks\roadblock.sqf";
task_commArray = compileFinal preprocessFileLineNumbers "scripts\server\tasks\commArray.sqf";
task_demolitions = compileFinal preprocessFileLineNumbers "scripts\server\tasks\demolitions.sqf";
task_wheels = compileFinal preprocessFileLineNumbers "scripts\server\tasks\deliverWheels.sqf";
task_roadblock_small = compileFinal preprocessFileLineNumbers "scripts\server\tasks\roadblockSmall.sqf";
task_foodorder = compileFinal preprocessFileLineNumbers "scripts\server\tasks\foodorder.sqf";
task_escape = compileFinal preprocessFileLineNumbers "scripts\server\tasks\escape.sqf";
task_revenge = compileFinal preprocessFileLineNumbers "scripts\server\tasks\revenge.sqf";
task_fuelwars = compileFinal preprocessFileLineNumbers "scripts\server\tasks\fuelwars.sqf";

// Sector
attack_in_progress_fob = compileFinal preprocessFileLineNumbers "scripts\server\sector\attack_in_progress_fob.sqf";
attack_in_progress_sector = compileFinal preprocessFileLineNumbers "scripts\server\sector\attack_in_progress_sector.sqf";
destroy_fob = compileFinal preprocessFileLineNumbers "scripts\server\sector\destroy_fob.sqf";
ied_manager = compileFinal preprocessFileLineNumbers "scripts\server\sector\ied_manager.sqf";
manage_ammoboxes = compileFinal preprocessFileLineNumbers "scripts\server\sector\manage_ammoboxes.sqf";
manage_one_sector = compileFinal preprocessFileLineNumbers "scripts\server\sector\manage_one_sector.sqf";
wait_to_spawn_sector = compileFinal preprocessFileLineNumbers "scripts\server\sector\wait_to_spawn_sector.sqf";
activate_location = compileFinal preprocessFileLineNumbers "scripts\server\sector\activate_location.sqf";
garrison_resolver = compileFinal preprocessFileLineNumbers "scripts\server\sector\garrison_resolver.sqf";

[] spawn compileFinal preprocessFileLineNumbers "scripts\server\base\startgame.sqf";
[] spawn compileFinal preprocessFileLineNumbers "scripts\server\base\huron_manager.sqf";
// [] spawn compileFinal preprocessFileLineNumbers "scripts\server\battlegroup\counter_battlegroup.sqf";
[] spawn compileFinal preprocessFileLineNumbers "scripts\server\battlegroup\random_battlegroups.sqf";
[] spawn compileFinal preprocessFileLineNumbers "scripts\server\battlegroup\readiness_increase.sqf";
[] spawn compileFinal preprocessFileLineNumbers "scripts\server\game\apply_default_permissions.sqf";
[] spawn compileFinal preprocessFileLineNumbers "scripts\server\game\apply_saved_scores.sqf";
[] spawn compileFinal preprocessFileLineNumbers "scripts\server\game\capture_vehicles.sqf";
[] spawn compileFinal preprocessFileLineNumbers "scripts\server\game\clean.sqf";
[] spawn compileFinal preprocessFileLineNumbers "scripts\server\game\cleanup_vehicles.sqf";
// [] spawn compileFinal preprocessFileLineNumbers "scripts\server\game\fucking_set_fog.sqf";
[] spawn compileFinal preprocessFileLineNumbers "scripts\server\game\manage_time.sqf";
[] spawn compileFinal preprocessFileLineNumbers "scripts\server\game\manage_weather.sqf";
[] spawn compileFinal preprocessFileLineNumbers "scripts\server\game\periodic_save.sqf";
[] spawn compileFinal preprocessFileLineNumbers "scripts\server\game\playtime.sqf";
[] spawn compileFinal preprocessFileLineNumbers "scripts\server\game\save_manager.sqf";
// [] spawn compileFinal preprocessFileLineNumbers "scripts\server\game\spawn_radio_towers.sqf";
[] spawn compileFinal preprocessFileLineNumbers "scripts\server\game\synchronise_vars.sqf";
[] spawn compileFinal preprocessFileLineNumbers "scripts\server\game\zeus_opfor.sqf";
[] spawn compileFinal preprocessFileLineNumbers "scripts\server\game\zeus_blufor.sqf";
[] spawn compileFinal preprocessFileLineNumbers "scripts\server\offloading\offload_calculation.sqf";
[] spawn compileFinal preprocessFileLineNumbers "scripts\server\offloading\offload_manager.sqf";
[] spawn compileFinal preprocessFileLineNumbers "scripts\server\offloading\show_fps.sqf";
[] spawn compileFinal preprocessFileLineNumbers "scripts\server\patrols\civilian_patrols.sqf";
[] spawn compileFinal preprocessFileLineNumbers "scripts\server\patrols\manage_patrols.sqf";
[] spawn compileFinal preprocessFileLineNumbers "scripts\server\patrols\reinforcements_resetter.sqf";
[] spawn compileFinal preprocessFileLineNumbers "scripts\server\resources\manage_resources.sqf";
[] spawn compileFinal preprocessFileLineNumbers "scripts\server\resources\recalculate_resources.sqf";
[] spawn compileFinal preprocessFileLineNumbers "scripts\server\resources\recalculate_timer.sqf";
[] spawn compileFinal preprocessFileLineNumbers "scripts\server\resources\unit_cap.sqf";
[] spawn compileFinal preprocessFileLineNumbers "scripts\server\sector\lose_sectors.sqf";
[] spawn compileFinal preprocessFileLineNumbers "scripts\client\markers\hostile_groups.sqf";
// [] spawn compileFinal preprocessFileLineNumbers "scripts\server\sector\manage_sectors.sqf";
// [] spawn compileFinal preprocessFileLineNumbers "scripts\server\game\init_tasks.sqf";

[] spawn compileFinal preprocessFileLineNumbers "scripts\server\game\dynamic_sim_manager.sqf";
[] spawn compileFinal preprocessFileLineNumbers "scripts\server\init_arsenal.sqf";
[] spawn compileFinal preprocessFileLineNUmbers "scripts\shared\init_locations.sqf";

{
	if ( (_x != player) && (_x distance (getmarkerpos GRLIB_respawn_marker) < 200 ) ) then {
		deleteVehicle _x;
	};
} foreach allUnits;
