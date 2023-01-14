params ["_unit", "_killer"];

private _delta_cr = 0.0;

if ( !isServer ) exitWith {};

if ( ((typeof _unit) in [ammobox_o_typename, ammobox_b_typename, ammocrate_o_typename]) && ((getPosATL _unit) select 2 < 10) ) exitWith {
    ("R_80mm_HE" createVehicle (getPosATL _unit)) setVelocity [0, 0, -200];
    deleteVehicle _unit;
};

if (side _killer == GRLIB_side_friendly) then {
    if (_killer isKindOf "Man") then { LP_infantry_weight = LP_infantry_weight + 1 };
    if (_killer isKindOf "LandVehicle") then  { LP_armor_weight = LP_armor_weight + 1 };
    if (_killer isKindOf "Air") then  { LP_air_weight = LP_air_weight + 1 };
};

if (isPlayer _unit) then { stats_player_deaths = stats_player_deaths + 1 };

if ( side (group _unit) == GRLIB_side_civilian ) then {
	stats_civilians_killed = stats_civilians_killed + 1;
	if (isPlayer _killer) then {
		stats_civilians_killed_by_players = stats_civilians_killed_by_players + 1;
		if ( GRLIB_civ_penalties ) then {
            [name _unit, GRLIB_civ_killing_penalty, _killer] remoteExec ["remote_call_civ_penalty", GRLIB_side_friendly, false];
		};
	};
};

if (_unit isKindOf "Man") then {
    switch (side (group _unit)) do {
        case GRLIB_side_enemy: {
            private _loc = (group _unit) getVariable LP_group_assignment_var;
            [_loc] call LP_decreaseLocationGarrison;

            diag_log format ["UNIT IS KILLED IN %2, GARRISON AFTER CHANGE: %1", [_loc, "garrison"] call LP_getLocationProperty, name _loc];

            _delta_cr = 0.1 * GRLIB_difficulty_modifier;
            stats_opfor_soldiers_killed = stats_opfor_soldiers_killed + 1;
            if (isPlayer _killer) then {
                stats_opfor_killed_by_players = stats_opfor_killed_by_players + 1
            };
        };
        case GRLIB_side_friendly: {
            if (side _killer == GRLIB_side_friendly) then {
                stats_blufor_teamkills = stats_blufor_teamkills + 1;
            } else {
                stats_blufor_soldiers_killed = stats_blufor_soldiers_killed + 1;
            };
        };
        case GRLIB_side_civilian: {
            // FIXME: civilian case for new meta
            stats_civilians_killed = stats_civilians_killed + 1;
            if (isPlayer _killer) then {
                stats_civilians_killed_by_players = stats_civilians_killed_by_players + 1;
                [name _unit, GRLIB_civ_killing_penalty, _killer] remoteExec ["remote_call_civ_penalty", GRLIB_side_friendly, false];
            };
        };
    };
// TODO: add conditions for vehicles
} else {
	if (typeof _unit in all_hostile_classnames) then {
        _delta_cr = 0.5 * GRLIB_difficulty_modifier;
		stats_opfor_vehicles_killed = stats_opfor_vehicles_killed + 1;
		if (isplayer _killer) then {
			stats_opfor_vehicles_killed_by_players = stats_opfor_vehicles_killed_by_players + 1;
		};
	} else {
		stats_blufor_vehicles_killed = stats_blufor_vehicles_killed + 1;
	};
};

combat_readiness = combat_readiness + _delta_cr;
stats_readiness_earned = stats_readiness_earned + _delta_cr;
if (combat_readiness > 100.0 && GRLIB_difficulty_modifier < 2) then { combat_readiness = 100.0 };
