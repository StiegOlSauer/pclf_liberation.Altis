private ["_possiblePositions", "_crashsite", "_testSector", "_allSectors", "_defendersAlive"];

_possiblePositions = [];
_allSectors = [];
_allsectorsShuffle = [];
_crashsite = [];
_testSector = "";
_defendersAlive = [];
_arrayOfPositions = [];
_ammoboxes = [];
_i = 0;

//_allsectorsShuffle = sectors_crashsite;
//_allSectors = [_allsectorsShuffle, 500] call KK_fnc_arrayShufflePlus;
_allSectors = sectors_crashsite;
//_i = (count _allSectors) - 1;

_tmp = sectors_crashsite call bis_fnc_selectrandom;
_crashsite = markerpos _tmp;		

if ((count _crashsite) == 0) exitWith {diag_log "No crashsite found";};

_base_objects = [_crashsite, (random 360), call (compile (preprocessFileLineNumbers "scripts\fob_templates\crashsite.sqf"))] call BIS_fnc_ObjectsMapper;

_grpdefenders = createGroup EAST;
{	
	if ((typeOf _x) == "Land_Bag_EP1") then {
		_pos = getPos _x;
		_arrayOfPositions = _arrayOfPositions + [_pos];
		_unitToSpawn = opfor_squad_8_infkillers call bis_fnc_selectrandom;
		deleteVehicle _x;
		_unitToSpawn createUnit [_pos, _grpdefenders,"this addMPEventHandler [""MPKilled"", {_this spawn kill_manager}]", 0.5, "private"];
	};
	
	if ((typeOf _x) == "B_APC_Tracked_01_CRV_F") then {
		_x setVehicleLock "LOCKED";
	};
	
	if ((typeOf _x) == "Box_East_Wps_F") then {
		clearWeaponCargoGlobal _x;
		clearMagazineCargoGlobal _x;
		clearItemCargoGlobal _x;
		clearBackpackCargoGlobal _x;
		_x addMPEventHandler ['MPKilled', {_this spawn kill_manager}];
		_ammoboxes = _ammoboxes + [_x];
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

_base_objects = _base_objects - _ammoboxes;
_grpsentry = createGroup EAST;

for [ {_idx=0},{_idx < 8},{_idx=_idx+1} ] do {
	_unitToSpawn = opfor_squad_8_infkillers call bis_fnc_selectrandom;
	_unitToSpawn createUnit [_crashsite, _grpsentry,"this addMPEventHandler [""MPKilled"", {_this spawn kill_manager}]", 0.5, "private"];
	sleep 0.5;
};

0 = [_grpsentry,  markerpos _tmp, 50] call BIS_fnc_taskPatrol;

_grpsentry1 = createGroup EAST;

for [ {_idx=0},{_idx < 8},{_idx=_idx+1} ] do {
	_unitToSpawn = opfor_squad_8_infkillers call bis_fnc_selectrandom;
	_unitToSpawn createUnit [_crashsite, _grpsentry1,"this addMPEventHandler [""MPKilled"", {_this spawn kill_manager}]", 0.5, "private"];
	sleep 0.5;
};

0 = [_grpsentry1, markerpos _tmp, 75] call BIS_fnc_taskPatrol;

_defendersAlive = _defendersAlive + (units _grpsentry1) + (units _grpsentry);

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
} foreach (units _grpsentry1) + (units _grpsentry);

_objectives_alive = true;

secondary_objective_position = _crashsite;
secondary_objective_position_marker = [(((secondary_objective_position select 0) + 800) - random 1600),(((secondary_objective_position select 1) + 800) - random 1600),0];
publicVariable "secondary_objective_position_marker";
sleep 1;
GRLIB_secondary_in_progress = 0; publicVariable "GRLIB_secondary_in_progress";
[ [ 2 ] , "remote_call_intel" ] call BIS_fnc_MP;

waituntil {sleep 5;
	( { alive _x } count _defendersAlive ) <= 1 };

combat_readiness = round (combat_readiness * 0.9);
stats_secondary_objectives = stats_secondary_objectives + 1;
sleep 1;
trigger_server_save = true;
sleep 3;
[ [ 3 ] , "remote_call_intel" ] call BIS_fnc_MP;

GRLIB_secondary_in_progress = -1; publicVariable "GRLIB_secondary_in_progress";
sleep 900;
{sleep 0.1; deleteVehicle _x;} foreach _base_objects;