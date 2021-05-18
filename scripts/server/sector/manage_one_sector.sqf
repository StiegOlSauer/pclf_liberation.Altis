params [ "_sector" ];
private [ "_sectorpos", "_stopit", "_spawncivs", "_building_ai_max", "_infsquad", "_building_range", "_local_capture_size", "_iedcount","_combat_readiness_increase","_vehtospawn","_managed_units", "_minimum_building_positions", "_popfactor", "_sector_despawn_tickets", "_opforcount", "_squadCount" ];

waitUntil { !isNil "combat_readiness" };

_sectorpos = getmarkerpos _sector;
_stopit = false;
_spawncivs = false;
_building_ai_max = 0; // replace this constant with % of the Garrison and factor of alert level of the sector
_building_range = 50;
_local_capture_size = GRLIB_capture_size;
_iedcount = 0;
_vehtospawn = [];
_managed_units = [];
_squadCount = 0;
_minimum_building_positions = 5;
_sector_despawn_tickets = 12;

_popfactor = 1;
if ( GRLIB_unitcap < 1 ) then { _popfactor = GRLIB_unitcap; };
if ( GRLIB_unitcap > 1 ) then { _popfactor = sqrt ( GRLIB_unitcap ) };

if ( isNil "active_sectors" ) then { active_sectors = [] };
if ( _sector in active_sectors ) exitWith {};
active_sectors pushback _sector; publicVariable "active_sectors";

_opforcount = [] call F_opforCap;
[ _sector, _opforcount ] call wait_to_spawn_sector;

if ( (!(_sector in blufor_sectors)) &&  ( ( [ getmarkerpos _sector , [ _opforcount ] call F_getCorrectedSectorRange , GRLIB_side_friendly ] call F_getUnitsCount ) > 0 ) ) then {
    _loadoutHash = [] call PCLF_prepareSectorArmory;

	if (_sector in sectors_bigtown) then {
// 		_vehtospawn = [([] call F_getAdaptiveVehicle), ([] call F_getAdaptiveMilVehicle), ([] call F_getAdaptiveMilVehicle)];
        _vehtospawn = ["tank", "atgm", "support", "ifv"];
        _squadCount = 2;
		if ( GRLIB_unitcap >= 1) then {
            _squadCount = 1 + (ceil (GRLIB_unitcap * 2));
		};
		if((random 100) > (66 / GRLIB_difficulty_modifier)) then {_vehtospawn pushback "apc"};
		if((random 100) > (50 / GRLIB_difficulty_modifier)) then {_vehtospawn pushback "aa"};
		if((random 100) > (33 / GRLIB_difficulty_modifier)) then {_vehtospawn pushback "tank"};
		_spawncivs = true;

		_building_ai_max = round (50 * _popfactor) ;
		_building_range = 110;
		_local_capture_size = _local_capture_size * 1.4;
		_iedcount = (2 + (floor (random 4))) * GRLIB_difficulty_modifier;
		if ( _iedcount > 10 ) then { _iedcount = 10 };
	};
	if (_sector in sectors_capture) then {
		_vehtospawn = [];
        _squadCount = ceil GRLIB_unitcap;
		if((random 100) > (66 / GRLIB_difficulty_modifier)) then {_vehtospawn pushback "support"};
		if((random 100) > (33 / GRLIB_difficulty_modifier)) then {_vehtospawn pushback "transport"};
		_spawncivs = true;
		_building_ai_max = round ((floor (18 + (round (combat_readiness / 10 )))) * _popfactor);
		_building_range = 70;
		_iedcount = (floor (random 4)) * GRLIB_difficulty_modifier;
		if ( _iedcount > 7 ) then { _iedcount = 7 };
	};
	if ( _sector in sectors_military ) then {
		_infsquad = "csat";
		_squadCount = 2;
		if ( GRLIB_unitcap >= 1) then {
            _squadCount = 1 + (ceil (GRLIB_unitcap * 2));
		};
		_vehtospawn = ["ifv", "apc"];
		if((random 100) > (66 / GRLIB_difficulty_modifier)) then {
            _vehtospawn pushback "support";
		};
		if((random 100) > (40 / GRLIB_difficulty_modifier)) then {_vehtospawn pushback "tank"};
		_spawncivs = false;
		_building_ai_max = round ((floor (18 + (round (combat_readiness / 4 )))) * _popfactor);
		_building_range = 110;
	};
	if ( _sector in sectors_factory ) then {
		_vehtospawn = [];
		_infsquad = "militia";
		_squadCount = 1;
		if ( GRLIB_unitcap >= 1.25) then {
			_squadCount = _squadCount + 1;
		};
		if((random 100) > 66) then { _vehtospawn pushback "ifv"};
		if((random 100) > 33) then { _vehtospawn pushback "ifv"};
		_spawncivs = false;
		_building_ai_max = round ((floor (18 + (round (combat_readiness / 10 )))) * _popfactor);
		_building_range = 100;
		_iedcount = (floor (random 3)) * GRLIB_difficulty_modifier;
		if ( _iedcount > 5 ) then { _iedcount = 5 };
	};
	if ( _sector in sectors_tower ) then {
		_spawncivs = false;
		_squadCount = 1;
		if ( GRLIB_unitcap >= 1.5) then {
			_squadCount = _squadCount + 1;
		};
		_building_ai_max = 0;
		if((random 100) > 95) then { _vehtospawn pushback "apc"; };
	};

	if ( _building_ai_max > 0 && GRLIB_adaptive_opfor ) then {
		_building_ai_max = round ( _building_ai_max * ([] call F_adaptiveOpforFactor));
	};

	{
        private _veh_props = [_x] call PCLF_getOpforVehicle;
        _vehicle = [_sectorpos, _veh_props, _loadoutHash] call F_libSpawnVehicle;
		[group ((crew _vehicle) select 0 ),_sectorpos] spawn add_defense_waypoints;
		_managed_units pushback _vehicle;
		(crew _vehicle) apply {_managed_units pushback _x};
		sleep 0.25;
	} foreach _vehtospawn;

	if ( _building_ai_max > 0 ) then {
        _allbuildings = (_sectorpos nearObjects ["House", _building_range]) select {alive _x};
		_buildingpositions = 0;
        _allbuildings apply {
            _buildingpositions = _buildingpositions + count (_x buildingPos -1);
        };
		if (_buildingpositions > _minimum_building_positions) then {
            private _defenders_in_buildings = floor (_buildingpositions * GRLIB_defended_buildingpos_part);
            _defenders_in_buildings = [_defenders_in_buildings, _building_ai_max] select (_defenders_in_buildings > _building_ai_max);
            private _groups = [_loadoutHash, _defenders_in_buildings, _sectorpos, _building_range] call PCLF_spawnBuildingSquad;
            _groups apply {
                _managed_units append (units _x);
            };
        };
    };

    private _groups = [_sectorpos, _loadoutHash] call PCLF_spawnMilitaryPostSquad;
    _groups apply {
        _managed_units append (units _x);
    };
    for "_i" from 1 to _squadCount do {
        _grp = [ _sector, _loadoutHash, false ] call PCLF_spawnRegularSquad;
        [ _grp, _sectorpos ] spawn add_defense_waypoints;
        _managed_units append (units _grp);
    };

	if ( _spawncivs && GRLIB_civilian_activity > 0) then {
		_managed_units append ([ _sector ] call F_spawnCivilians);
	};

	[ _sector, _building_range, _iedcount ] spawn ied_manager;
	sleep 10;

	if ( ( _sector in sectors_factory ) || (_sector in sectors_capture ) || (_sector in sectors_bigtown ) || (_sector in sectors_military ) ) then {
		[ [ _sector ] , "reinforcements_remote_call" ] call BIS_fnc_MP;
	};

	while { !_stopit } do {
		if ( ( [_sectorpos, _local_capture_size] call F_sectorOwnership == GRLIB_side_friendly ) && ( GRLIB_endgame == 0 ) ) then {
			if (isServer) then {
				[ _sector ] spawn sector_liberated_remote_call;
			} else {
				[ [ _sector ] , "sector_liberated_remote_call" ] call BIS_fnc_MP;
			};

			_stopit = true;

			{ [_x] spawn prisonner_ai; } foreach ( (getmarkerpos _sector) nearEntities [ [ "Man" ], _local_capture_size * 1.2 ] );

			sleep 60;
			active_sectors = active_sectors - [ _sector ]; publicVariable "active_sectors";
			sleep 600;
			{
				if (_x isKindOf "Man") then {
					if ( side group _x != GRLIB_side_friendly ) then {
						deleteVehicle _x;
					};
				} else {
					[ _x ] call F_cleanOpforVehicle;
				};
			} foreach _managed_units;

		} else {
			if ( ( [_sectorpos, ( ( [ _opforcount ] call F_getCorrectedSectorRange ) + 300 ), GRLIB_side_friendly ] call F_getUnitsCount ) == 0 ) then {
				_sector_despawn_tickets = _sector_despawn_tickets - 1;
			} else {
				_sector_despawn_tickets = 12;
			};

			if ( _sector_despawn_tickets <= 0 ) then {

				{
					if (_x isKindOf "Man") then {
						deleteVehicle _x;
					} else {
						[ _x ] call F_cleanOpforVehicle;
					};
				} foreach _managed_units;

				_stopit = true;
				active_sectors = active_sectors - [ _sector ]; publicVariable "active_sectors";
			};
		};
		sleep 5;
	};
} else {
	sleep 40;
	active_sectors = active_sectors - [ _sector ]; publicVariable "active_sectors";
};
