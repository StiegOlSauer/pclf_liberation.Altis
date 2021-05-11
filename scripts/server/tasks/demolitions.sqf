//template for 1-phase simple mission
if (!isServer) exitWith {};

params ["_markersArray"];
private ["_taskPrefix", "_taskMarker", "_taskCity","_base_objects", "_unitToSpawn", "_defendersAlive", "_arrayOfPositions", "_taskStates", "_pos", "_spawnedAlready", "_prepareInProgress", "_spawnpos", "_taskObjects", "_testedPos"];

_taskPrefix = "DEMOLITIONS";
_taskStates = [];
_base_objects = [];
_defendersAlive = [];
_arrayOfPositions = [];
_spawnedAlready = false;
_prepareInProgress = true;
_taskObjects = [];
_taskMarker = _markersArray deleteAt 0;
_taskCity = [_taskMarker] call BIS_fnc_taskDestination;
diag_log format ["%1 task %2 INITIALIZATION START",_taskPrefix, _taskMarker];

while {((({ alive _x } count _defendersAlive) > 0) || (({ alive _x } count _taskObjects) > 0)) || (_prepareInProgress)} do {

	sleep 2; 
	//mission is assigned - spawn it
	if ((([_taskMarker] call BIS_fnc_taskState) == "ASSIGNED") && !(_spawnedAlready)) then {
		diag_log format ["%1 task %2 ENTERED BRANCH SPAWN",_taskPrefix, _taskMarker];
		
		_spawnpos = [_taskCity, 10, 400, 12, 0, 5, 0] call BIS_fnc_findSafePos;
		while {count (_spawnpos nearRoads 30) > 0} do {
			_testedPos = [_spawnpos, (random 50), (random 360)] call BIS_fnc_relPos;
			_spawnpos = [_testedPos, 10, 400, 12, 0, 5, 0] call BIS_fnc_findSafePos;
			diag_log format ["DEMOLITIONS tested _spawnpos %1",_spawnpos];
		};
		diag_log format ["DEMOLITIONS task %1 FOUND THE POSITION: %2",_taskMarker, _spawnpos];
		if (_spawnpos isEqualTo []) exitWith {diag_log format ["DEMOLITIONS task %1 DID NOT FIND THE POSITION :(",_taskMarker]};
		
		sleep 0.5;
		_base_objects = [_spawnpos, (random 360), call (compile (preprocessFileLineNumbers "scripts\fob_templates\demolitions.sqf"))] call BIS_fnc_ObjectsMapper;		
		sleep 5;		
		
		_grpdefenders = createGroup EAST;
		{	
			if ((typeOf _x) == "VR_Area_01_square_1x1_grey_F") then {
				_pos = getPos _x;
				_arrayOfPositions append [_pos];
				_unitToSpawn = opfor_squad_8_standard call bis_fnc_selectrandom;
				deleteVehicle _x;
				_unitToSpawn createUnit [_pos, _grpdefenders,"this addMPEventHandler [""MPKilled"", {_this spawn kill_manager}]", 0.5, "private"];
				diag_log "DEMOLITIONS unit spawned";				
				sleep 0.5;
			};
			if (((typeOf _x) == "Land_cargo_house_slum_F") || ((typeOf _x) == "Land_Slum_House03_F")) then {
				_taskObjects append [_x];
			};
		} foreach _base_objects;
		
		private _index = 0;		
		{
			[_x] call (hobo_loadouts select _index);
			_index = _index + 1;
			if (_index > 3) then {_index = 0};
		} foreach (units _grpdefenders);
		
		{
			_defendersAlive = _defendersAlive + [_x];			
			if ((count _arrayOfPositions) > 0) then {
				_x setPos (_arrayOfPositions select 0);
				_arrayOfPositions deleteAt 0;
			};
			[_x] joinSilent (createGroup EAST);
			_x setBehaviour "CARELESS";
		} foreach (units _grpdefenders);
		
		sleep 1;
		{ _x setDamage 0; } foreach (_base_objects);
		
		_defendersAlive spawn {waitUntil {sleep 5; {!(alive _x)} count _this > 0}; { _x setBehaviour "COMBAT"} foreach _this;};
		
		_spawnedAlready = true;
		_prepareInProgress = false;
		0 = [_taskMarker, _spawnpos] call BIS_fnc_taskSetDestination;
		0 = [_taskMarker, "ASSIGNED",false] spawn BIS_fnc_taskSetState;
	};
	
	//mission was spawned, but then unassigned - cleanup and restore starting state
	if ((_spawnedAlready) && !(([_taskMarker] call BIS_fnc_taskState) == "ASSIGNED")) then {		
		diag_log format ["%1 task %2 ENTERED BRANCH CLEANUP",_taskPrefix, _taskMarker];		
		
		//need to return marker back
		_prepareInProgress = true;
		_spawnedAlready = false;
		{sleep 0.1; deleteVehicle _x;} foreach _defendersAlive;
		{sleep 0.1; deleteVehicle _x;} foreach _base_objects;
		0 = [_taskMarker, _taskCity] call BIS_fnc_taskSetDestination;
		0 = [_taskMarker, "CREATED",false] spawn BIS_fnc_taskSetState;
	};
	
	//FOB relocated and mission did not appear again - check if it was spawned before, cleanup, end thread
	if (!(_taskMarker in GRLIB_tasksAssigned)) then {
		diag_log format ["%1 task %2 ENTERED BRANCH END",_taskPrefix, _taskMarker];
		//do cleanup
		_prepareInProgress = false;
		_spawnedAlready = false;
		{sleep 0.1; deleteVehicle _x;} foreach _defendersAlive;
	};
};

diag_log format ["%1 task %2 EXITED FROM LOOP",_taskPrefix, _taskMarker];
//cleanup code
if ((_taskMarker in GRLIB_tasksAssigned) && (([_taskMarker] call BIS_fnc_taskState) == "ASSIGNED")) then {
	_nil = [_taskMarker, "SUCCEEDED",true] spawn BIS_fnc_taskSetState;
	GRLIB_tasksCompleted append [_taskMarker];
	sleep 5;
	0 = [_taskMarker] call BIS_fnc_deleteTask;
	0 = GRLIB_tasksAssigned deleteAt (GRLIB_tasksAssigned find _taskMarker);
//	0 = GRLIB_tasksRunning deleteAt (GRLIB_tasksRunning find _taskMarker);
	
	diag_log format ["%1 task %2 SUCCEEDED. AAR: GRLIB_tasksAssigned: %3",_taskPrefix, _taskMarker, GRLIB_tasksAssigned];
	
	sleep 1;
	[_taskMarker] call F_tasks_replaceTask;
	sleep 30;
} else {
	0 = [_taskMarker] call BIS_fnc_deleteTask;
//	0 = GRLIB_tasksAssigned deleteAt (GRLIB_tasksAssigned find _taskMarker);
//	0 = GRLIB_tasksRunning deleteAt (GRLIB_tasksRunning find _taskMarker);
};

{sleep 0.1; deleteVehicle _x;} foreach _defendersAlive;		
{sleep 0.1; deleteVehicle _x;} foreach _base_objects;