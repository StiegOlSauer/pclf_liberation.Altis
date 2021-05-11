//template for 1-phase simple mission
if (!isServer) exitWith {};

params ["_markersArray"];
private ["_taskMarker", "_taskCity","_base_objects", "_unitToSpawn", "_defendersAlive", "_arrayOfPositions", "_pos", "_spawnedAlready", "_prepareInProgress", "_spawnpos", "_taskObjects", "_testedPos"];

_base_objects = [];
_taskObjects = [];
_defendersAlive = [];
_arrayOfPositions = [];
_spawnedAlready = false;
_prepareInProgress = true;
_taskMarker = _markersArray deleteAt 0;
_taskCity = [_taskMarker] call BIS_fnc_taskDestination;
diag_log format ["COMMARRAY task %1 INITIALIZATION START",_taskMarker];

while {((({ alive _x } count _defendersAlive) > 1) || (({ alive _x } count _taskObjects) > 0)) || (_prepareInProgress)} do {

	sleep 2; 
	//mission is assigned - spawn it
	if ((([_taskMarker] call BIS_fnc_taskState) == "ASSIGNED") && !(_spawnedAlready)) then {
		diag_log format ["COMMARRAY task %1 ENTERED BRANCH SPAWN",_taskMarker];
		
		_spawnpos = [(getMarkerPos _taskMarker), 10, 400, 12, 0, 5, 0] call BIS_fnc_findSafePos;
		while {count (_spawnpos nearRoads 30) > 0} do {
			_testedPos = [_spawnpos, (random 50), (random 360)] call BIS_fnc_relPos;
			_spawnpos = [_testedPos, 10, 400, 12, 0, 5, 0] call BIS_fnc_findSafePos;
			diag_log format ["COMMARRAY tested _spawnpos %1",_spawnpos];
		};
		diag_log format ["COMMARRAY task %1 FOUND THE POSITION: %2",_taskMarker, _spawnpos];
		if (_spawnpos isEqualTo []) exitWith {diag_log format ["COMMARRAY task %1 DID NOT FIND THE POSITION :(",_taskMarker]};
		
		sleep 0.5;
		_base_objects = [_spawnpos, (random 360), call (compile (preprocessFileLineNumbers "scripts\fob_templates\commArray.sqf"))] call BIS_fnc_ObjectsMapper;		
		sleep 5;

		_grpdefenders = createGroup EAST;
		{	
			if ((typeOf _x) == "VR_Area_01_square_1x1_grey_F") then {
				_pos = getPos _x;
				_arrayOfPositions append [_pos];
				_unitToSpawn = opfor_squad_8_standard call bis_fnc_selectrandom;
				deleteVehicle _x;
				_unitToSpawn createUnit [_pos, _grpdefenders,"this addMPEventHandler [""MPKilled"", {_this spawn kill_manager}]", 0.5, "private"];
				diag_log "COMMARRAY unit spawned";
				sleep 0.5;
			};
			if (((typeOf _x) == "Land_PowerGenerator_F") || ((typeOf _x) == "Land_TTowerSmall_1_F")) then {
				_taskObjects append [_x];
			};
		} foreach _base_objects;
		
		_grpdefenders setBehaviour "CARELESS";
		_grpdefenders spawn {waitUntil {sleep 5; {!(alive _x)} count (units _this) > 0}; _this setBehaviour "COMBAT";};
		[units _grpdefenders] call F_loadouts_swapOpfor;
		
		{
			_defendersAlive = _defendersAlive + [_x];			
			if ((count _arrayOfPositions) > 0) then {
				_x setPos (_arrayOfPositions select 0);
				_arrayOfPositions deleteAt 0;
			};
		} foreach (units _grpdefenders);
		
		sleep 1;
		{ _x setDamage 0; } foreach (_base_objects);
		
		_grpsentry = createGroup EAST;
		for [ {_idx=0},{_idx < 4},{_idx=_idx+1} ] do {
			_unitToSpawn = opfor_squad_8_standard call bis_fnc_selectrandom;
			_unitToSpawn createUnit [_spawnpos, _grpsentry,"this addMPEventHandler [""MPKilled"", {_this spawn kill_manager}]", 0.5, "private"];
			sleep 0.5;
		};		
		[units _grpsentry] call F_loadouts_swapOpfor;
		
		0 = [_grpsentry,  _spawnpos, 50] call BIS_fnc_taskPatrol;
		
		_defendersAlive = _defendersAlive + (units _grpsentry);
		
		_spawnedAlready = true;
		_prepareInProgress = false;
		0 = [_taskMarker, _spawnpos] call BIS_fnc_taskSetDestination;
		0 = [_taskMarker, "ASSIGNED",false] spawn BIS_fnc_taskSetState;
	};
	
	//mission was spawned, but then unassigned - cleanup and restore starting state
	if ((_spawnedAlready) && !(([_taskMarker] call BIS_fnc_taskState) == "ASSIGNED")) then {		
		diag_log format ["COMMARRAY task %1 ENTERED BRANCH CLEANUP",_taskMarker];		
		
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
		diag_log format ["COMMARRAY task %1 ENTERED BRANCH END",_taskMarker];
		//do cleanup
		_prepareInProgress = false;
		_spawnedAlready = false;
		{sleep 0.1; deleteVehicle _x;} foreach _defendersAlive;
	};
};

diag_log format ["COMMARRAY task %1 EXITED FROM LOOP",_taskMarker];
//cleanup code
if ((_taskMarker in GRLIB_tasksAssigned) && (([_taskMarker] call BIS_fnc_taskState) == "ASSIGNED")) then {
	_nil = [_taskMarker, "SUCCEEDED",true] spawn BIS_fnc_taskSetState;
	GRLIB_tasksCompleted append [_taskMarker];
	sleep 5;
	0 = [_taskMarker] call BIS_fnc_deleteTask;
	0 = GRLIB_tasksAssigned deleteAt (GRLIB_tasksAssigned find _taskMarker);
//	0 = GRLIB_tasksRunning deleteAt (GRLIB_tasksRunning find _taskMarker);
	
	diag_log format ["COMMARRAY task %1 SUCCEEDED. AAR: GRLIB_tasksRunning, GRLIB_tasksAssigned: %2",_taskMarker, GRLIB_tasksAssigned];
	
	sleep 1;
	[_taskMarker] call F_tasks_replaceTask;
	sleep 30;
} else {
	0 = [_taskMarker] call BIS_fnc_deleteTask;
};

{sleep 0.1; deleteVehicle _x;} foreach _defendersAlive;		
{sleep 0.1; deleteVehicle _x;} foreach _base_objects;