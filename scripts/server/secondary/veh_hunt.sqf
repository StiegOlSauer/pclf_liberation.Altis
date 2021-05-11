
_defenders_amount = 15;
if ( _defenders_amount > 15 ) then { _defenders_amount = 15 };
_repair_templates = [
"scripts\fob_templates\test.sqf"
];

//_spawn_marker = "m1";
_spawn_marker = [2000,999999,false] call F_findOpforSpawnPoint;
if ( _spawn_marker == "" ) exitWith { diag_log "Could not find position for fob hunting mission"; };

used_positions = used_positions + [ _spawn_marker ];
_base_position = markerpos _spawn_marker;
_base_objects = objNull;
_base_objectives = [];
_base_defenders = [];
_defendersAlive = [];
_arrayOfPositions = [];
//_template = ([] call (compile preprocessFileLineNumbers ( _repair_templates call bis_fnc_selectrandom )));

//_base_objects = [getMarkerPos _spawn_marker, (random 360), call (compile (preprocessFileLineNumbers (_repair_templates call bis_fnc_selectrandom)))] call BIS_fnc_ObjectsMapper;

_base_objects = [getMarkerPos _spawn_marker, (random 360), call (compile (preprocessFileLineNumbers "scripts\fob_templates\test.sqf"))] call BIS_fnc_ObjectsMapper;

_grpdefenders = createGroup EAST;
{
	if ((typeOf _x) == "Land_Scrap_MRAP_01_F") then {
		_pos = getPos _x;
		_dir = getDir _x;
		_vehToSpawn = (opfor_battlegroup_vehicles - opfor_choppers - opfor_air - ["CUP_B_LAV25_USMC"]) call bis_fnc_selectrandom;
		_spawnPos = _pos findEmptyPosition [0, 200, _vehToSpawn];
		deleteVehicle _x;
		_veh = _vehToSpawn createVehicle _spawnPos;
		_veh setDir (_dir + 180);
		_veh setPos _pos;
		_base_objectives = _veh;
	};
	
	if ((typeOf _x) == "Land_Bag_EP1") then {
		_pos = getPos _x;
		_arrayOfPositions = _arrayOfPositions + [_pos];
		_unitToSpawn = opfor_squad_8_infkillers call bis_fnc_selectrandom;
		deleteVehicle _x;
		_unitToSpawn createUnit [_pos, _grpdefenders,"this addMPEventHandler [""MPKilled"", {_this spawn kill_manager}]", 0.5, "private"];
	};
} foreach _base_objects;

_grpdefenders setBehaviour "CARELESS";

{
_defendersAlive = _defendersAlive + [_x];
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
	if ((count _arrayOfPositions) > 0) then {
		_x setPos (_arrayOfPositions select 0);
		_arrayOfPositions deleteAt 0;
	};
	[_x] join grpNull;
} foreach (units _grpdefenders);

sleep 1;

{ _x setDamage 0; } foreach (_base_objects);
_base_objectives setHit ["motor", 1];

_sentry = ceil ((3 + (floor (random 4))) * ( sqrt ( GRLIB_unitcap ) ) );

_grpsentry = createGroup EAST;
//_base_sentry_pos = [(_base_position select 0) + ((_base_corners select 0) select 0), (_base_position select 1) + ((_base_corners select 0) select 1),0];
for [ {_idx=0},{_idx < _sentry},{_idx=_idx+1} ] do {
	opfor_sentry createUnit [_base_position, _grpsentry,"this addMPEventHandler [""MPKilled"", {_this spawn kill_manager}]; [this] call opfor_sentry_loadout", 0.5, "private"];
};

0 = [_grpsentry, getMarkerPos _spawn_marker, 50] call BIS_fnc_taskPatrol;

_objectives_alive = true;

secondary_objective_position = _base_position;
secondary_objective_position_marker = [(((secondary_objective_position select 0) + 800) - random 1600),(((secondary_objective_position select 1) + 800) - random 1600),0];
publicVariable "secondary_objective_position_marker";
sleep 1;
GRLIB_secondary_in_progress = 0; publicVariable "GRLIB_secondary_in_progress";
[ [ 2 ] , "remote_call_intel" ] call BIS_fnc_MP;

while {alive _base_objectives && _base_objectives distance (getMarkerPos _spawn_marker) < 700} do {
	sleep 10;	
	_needBackup = {alive _x} count _defendersAlive;
	if (_needBackup < 3) then {
//		_defendersAlive = _defendersAlive + ([_base_position] call F_spawnObjBackup);
	};
};

combat_readiness = round (combat_readiness * GRLIB_secondary_objective_impact);
stats_secondary_objectives = stats_secondary_objectives + 1;
sleep 1;
trigger_server_save = true;
sleep 3;

[ [ 3 ] , "remote_call_intel" ] call BIS_fnc_MP;

GRLIB_secondary_in_progress = -1; publicVariable "GRLIB_secondary_in_progress";
_base_objects = _base_objects - [_base_objectives];
{deleteVehicle _x; sleep 0.1;} foreach _base_objects;