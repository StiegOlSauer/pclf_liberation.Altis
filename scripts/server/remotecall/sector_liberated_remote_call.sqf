if (isServer) then {
	params ["_location"];

	_combat_readiness_increase = 0;
    private _locationType = [_location] call LP_getLocationType;
	if (_locationType in [LP_location_capital, LP_location_city]) then {
		_combat_readiness_increase = (floor (random 10)) * GRLIB_difficulty_modifier;
	};

	if (_locationType <= LP_location_village) then {
		_combat_readiness_increase = (floor (random 6)) * GRLIB_difficulty_modifier;
	};

	if (_locationType in LP_locations_military) then {
		_combat_readiness_increase = (5 + (floor (random 11))) * GRLIB_difficulty_modifier;
	};

	if (_locationType == LP_location_factory) then {
		_combat_readiness_increase = (3 + (floor (random 7))) * GRLIB_difficulty_modifier;
	};

	if (_locationType == LP_location_radio) then {
		_combat_readiness_increase = (floor (random 4));
	};

	if  (GRLIB_passive_income) then {
		resources_ammo = resources_ammo + (floor (random 20));
	};

	_unitcap_local = unitcap + 10;
	if (_unitcap_local <= unitcap_respawns_limit) then {
		unitcap = _unitcap_local;
	};

	combat_readiness = combat_readiness + _combat_readiness_increase;
	if ( combat_readiness > 100.0 && GRLIB_difficulty_modifier <= 2.0 ) then { combat_readiness = 100.0 };
	stats_readiness_earned = stats_readiness_earned + _combat_readiness_increase;
	[ [ name _location, 0 ] , "remote_call_sector" ] call BIS_fnc_MP;

	reset_battlegroups_ai = true; publicVariable "reset_battlegroups_ai";
    stats_sectors_liberated = stats_sectors_liberated + 1;

	[] call recalculate_caps;
	[] spawn check_victory_conditions;

	sleep 1;
	trigger_server_save = true;
    sleep 45;

	if ( GRLIB_endgame == 0 ) then {
		if ( (!( _locationType == LP_location_radio )) && (((random (200.0 / (GRLIB_difficulty_modifier * GRLIB_csat_aggressivity) )) < (combat_readiness - 20)) || ( _locationType in [LP_location_capital, LP_location_city] )) && ([] call F_opforCap < GRLIB_battlegroup_cap) ) then {
			[ _location ] spawn spawn_battlegroup;
		};
	};
};
