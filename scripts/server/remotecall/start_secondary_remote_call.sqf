if ( !isServer ) exitWith {};
if ( isNil "GRLIB_secondary_starting" ) then { GRLIB_secondary_starting = false; };
if ( GRLIB_secondary_starting ) exitWith { diag_log "Multiple calls to start secondary mission : shouldn't be possible, isn't allowed"; };
if ( isNil "used_positions" ) then { used_positions = []; };

GRLIB_secondary_starting = true; publicVariable "GRLIB_secondary_starting";
params [ "_mission_index" ];

// FOB Hunting
if ( _mission_index == 0 ) then {
	resources_intel = resources_intel - ( GRLIB_secondary_missions_costs select _mission_index );
	[] call fob_hunting;
};

// Convoy Hijack
if ( _mission_index == 1 ) then {
	resources_intel = resources_intel - ( GRLIB_secondary_missions_costs select _mission_index );
	[] call convoy_hijack;
};

if ( _mission_index == 2 ) then {
	resources_intel = resources_intel - ( GRLIB_secondary_missions_costs select _mission_index );
	[] call veh_hunt;
};

if ( _mission_index == 3 ) then {
	resources_intel = resources_intel - ( GRLIB_secondary_missions_costs select _mission_index );
	[] call planecrash_mission;
};

if ( _mission_index == 4 ) then {
	resources_intel = resources_intel - ( GRLIB_secondary_missions_costs select _mission_index );
	[] call search_and_rescue;
};

GRLIB_secondary_starting = false; publicVariable "GRLIB_secondary_starting";