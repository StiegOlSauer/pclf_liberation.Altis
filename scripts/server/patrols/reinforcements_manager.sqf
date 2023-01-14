if ( combat_readiness > 15 ) then {
    params [ "_targetsector" ];

    private _isCapital = {
        if (([_targetsector] call LP_getLocationType) == LP_location_capital) exitWith { true };
        false
    };

	private _init_units_count = [position _targetsector, GRLIB_capture_size, GRLIB_side_enemy] call F_getUnitsCount;

	if (! _isCapital) then {
		while { (_init_units_count * 0.75) <=  ( [ position _targetsector , GRLIB_capture_size , GRLIB_side_enemy ] call F_getUnitsCount ) } do {
			sleep 5;
		};
	};

	if ( _targetsector in LP_active_locations ) then {
        _nearestower = [position _targetsector, GRLIB_side_enemy, LP_location_radio, GRLIB_radiotower_size * 1.4] call LP_getNearestLocation;

		if ( _nearestower != "" ) then {
			_reinforcements_time = (((((position _nearestower) distance (position _targetsector)) / 1000) ^ 1.66 ) * 120) / (GRLIB_difficulty_modifier * GRLIB_csat_aggressivity);
			if (_isCapital) then {
				_reinforcements_time = _reinforcements_time * 0.35;
			};
			_current_timer = time;

			waitUntil { sleep 1; (_current_timer + _reinforcements_time < time) || (_targetsector in blufor_sectors) || (_nearestower in blufor_sectors) };

			sleep 15;

			if ( (_targetsector in LP_active_locations) && !(_targetsector in ([] call LP_getBLUFORLocations)) && !(_nearestower in ([] call LP_getBLUFORLocations)) || isCapital) then {
				reinforcements_sector_under_attack = _targetsector;
				reinforcements_set = true;
				[ [ "lib_reinforcements" , [ name _targetsector ] ] , "bis_fnc_shownotification" ] call BIS_fnc_MP;
				if ( (random combat_readiness) > (20 + (30 / GRLIB_csat_aggressivity) ) ) then {
					[ _targetsector ] spawn send_paratroopers;
				};
				stats_reinforcements_called = stats_reinforcements_called + 1;
			};
		};
	};
};

