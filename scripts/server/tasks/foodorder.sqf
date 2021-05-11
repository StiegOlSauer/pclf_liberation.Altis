if (!isServer) exitWith {};

params ["_markersArray"];
private ["_taskPrefix", "_taskMarker", "_taskCity","_base_objects", "_unitToSpawn", "_defendersAlive", "_arrayOfPositions", "_ammoboxes", "_taskStates", "_pos", "_spawnedAlready", "_prepareInProgress",
"_basePos","_checkpoint1", "_checkpoint2", "_checkpoint1Pos", "_checkpoint2Pos", "_roadObjects", "_road", "_spawnpos", "_sacks", "_dir", "_debug", "_deliveredFood"];

_taskPrefix = "FOODORDER";
_base_objects = [];
_defendersAlive = [];
_arrayOfPositions = [];
_sacks = [];
_deliveredFood = [];
_spawnedAlready = false;
_prepareInProgress = true;
_taskMarker = _markersArray deleteAt 0;
_basePos = _markersArray deleteAt 0;
_checkpoint1Pos = _markersArray deleteAt 0;
_checkpoint2Pos = _markersArray deleteAt 0;
_taskCity = [_taskMarker] call BIS_fnc_taskDestination;
diag_log format ["%1 task %2 INITIALIZATION START",_taskPrefix, _taskMarker];

while {(count _deliveredFood < 5) || (_prepareInProgress)} do {
	
	sleep 2;
	_deliveredFood = nearestObjects [(getMarkerPos _taskMarker), ["Land_Sacks_heap_F"], 30];
	//mission is assigned - spawn it
	if ((([_taskMarker] call BIS_fnc_taskState) == "ASSIGNED") && !(_spawnedAlready)) then {
		diag_log format ["%1 task %2 ENTERED BRANCH SPAWN",_taskPrefix, _taskMarker];
		
		//2 2-sided checkpoints: find position, align or road, spawn.
		sleep 1;
		_roadObjects = (getMarkerPos _checkpoint1Pos) nearRoads 50;
		_road = selectRandom _roadObjects;
		_roadObjects = (roadsConnectedTo _road) select 0;
		diag_log format ["%1 task %2 Checkpoint 1 will spawn there: %3 with direction: %4",_taskPrefix, _taskMarker, (getPos _road), (_road getDir _roadObjects)];
		
		_checkpoint1 = [getPos _road, (_road getDir _roadObjects), call (compile (preprocessFileLineNumbers "scripts\fob_templates\checkpoint2sided.sqf"))] call BIS_fnc_ObjectsMapper;		
		
		sleep 1;
		_roadObjects = (getMarkerPos _checkpoint2Pos) nearRoads 50;
		_road = selectRandom _roadObjects;
		_roadObjects = (roadsConnectedTo _road) select 0;
		diag_log format ["%1 task %2 Checkpoint 2 will spawn there: %3 with direction: %4",_taskPrefix, _taskMarker, (getPos _road), (_road getDir _roadObjects)];
		
		_checkpoint2 = [getPos _road, (_road getDir _roadObjects), call (compile (preprocessFileLineNumbers "scripts\fob_templates\checkpoint2sided.sqf"))] call BIS_fnc_ObjectsMapper;
				
		//spawn infantry on checkpoints
		_grpCheckpoint1 = createGroup EAST;
		{	
			if ((typeOf _x) == "VR_Area_01_square_1x1_grey_F") then {
				_pos = getPos _x;
				_arrayOfPositions append [_pos];
				_unitToSpawn = opfor_squad_8_standard call bis_fnc_selectrandom;
				deleteVehicle _x;
				_unitToSpawn createUnit [_pos, _grpCheckpoint1,"this addMPEventHandler [""MPKilled"", {_this spawn kill_manager}]", 0.5, "private"];
				diag_log "FOODORDER unit spawned";
				sleep 0.5;				
			};			
		} foreach _checkpoint1;
		
		_grpCheckpoint2 = createGroup EAST;
		{	
			if ((typeOf _x) == "VR_Area_01_square_1x1_grey_F") then {
				_pos = getPos _x;
				_arrayOfPositions append [_pos];
				_unitToSpawn = opfor_squad_8_standard call bis_fnc_selectrandom;
				deleteVehicle _x;
				_unitToSpawn createUnit [_pos, _grpCheckpoint2,"this addMPEventHandler [""MPKilled"", {_this spawn kill_manager}]", 0.5, "private"];
				diag_log "FOODORDER unit spawned";
				sleep 0.5;				
			};			
		} foreach _checkpoint2;
		
		[units _grpCheckpoint1] call F_loadouts_swapOpfor;
		[units _grpCheckpoint2] call F_loadouts_swapOpfor;
		
		_grpCheckpoint1 spawn {waitUntil {sleep 5; {!(alive _x)} count (units _this) > 0}; _this setBehaviour "COMBAT";};
		_grpCheckpoint2 spawn {waitUntil {sleep 5; {!(alive _x)} count (units _this) > 0}; _this setBehaviour "COMBAT";};
		
		{
			_defendersAlive = _defendersAlive + [_x];
			if ((count _arrayOfPositions) > 0) then {
				_x setPos (_arrayOfPositions select 0);
				_arrayOfPositions deleteAt 0;
			};
			_x setBehaviour "CARELESS";
		} foreach ((units _grpCheckpoint1) + (units _grpCheckpoint2));
		
		_spawnpos = [(getMarkerPos _basePos), 10, 200, 12, 0, 1, 0] call BIS_fnc_findSafePos;
		diag_log format ["FOODORDER task %1 FOUND THE POSITION: %2",_taskMarker, _spawnpos];
		if (_spawnpos isEqualTo []) exitWith {diag_log format ["FOODORDER task %1 DID NOT FIND THE POSITION :(",_taskMarker]};
		
		_base_objects = [_spawnpos, (random 360), call (compile (preprocessFileLineNumbers "scripts\fob_templates\foodBase.sqf"))] call BIS_fnc_ObjectsMapper;
		
		_grpdefenders = createGroup EAST;
		private _turretGrp = createGroup EAST;
		{	
			if ((typeOf _x) == "VR_Area_01_square_1x1_grey_F") then {
				_pos = getPos _x;
				_arrayOfPositions append [_pos];
				_unitToSpawn = opfor_squad_8_infkillers call bis_fnc_selectrandom;
				deleteVehicle _x;
				_unitToSpawn createUnit [_pos, _grpdefenders,"this addMPEventHandler [""MPKilled"", {_this spawn kill_manager}]", 0.5, "private"];
				diag_log "FOODORDER unit spawned";
				sleep 0.5;
			};			
			if ((typeOf _x) == "VR_Area_01_square_1x1_yellow_F") then {
				_pos = getPos _x;
				deleteVehicle _x;
				_sack = createVehicle ["Land_Sacks_heap_F", [_pos select 0, _pos select 1, (_pos select 2) + 0.1], [], 0, "CAN_COLLIDE"];
				_sack enableSimulationGlobal false;
				diag_log format ["FOODORDER task %1 sack spawned as: %2 in position %3",_taskMarker,typeOf _sack, getPos _sack];
				_sack allowDamage false;
				[_sack, true, 1] call ace_cargo_fnc_makeLoadable;
				[_sack, true, [0,1,0.1], 0] call ace_dragging_fnc_setDraggable;
				_sacks append [_sack];				
			};
			if ((typeOf _x) == "RHS_MK19_TriPod_WD") then {
				_dir = getDir _x;
				_pos = getPos _x;
				_unitToSpawn = opfor_squad_8_standard call bis_fnc_selectrandom;
				_unitToSpawn createUnit [_pos, _turretGrp,"this addMPEventHandler [""MPKilled"", {_this spawn kill_manager}]", 0.5, "private"];
				[units _turretGrp] call F_loadouts_swapOpfor;
				private _u = (units _turretGrp) select 0;
				_u moveInGunner _x;
				_x setPos (_x modelToWorld[0,0.5,3]);
				_x setDir _dir;
				sleep 0.1;
			};			
		} foreach _base_objects;
		
		[units _grpdefenders] call F_loadouts_swapOpfor;
		
		{
			_defendersAlive = _defendersAlive + [_x];
			if ((count _arrayOfPositions) > 0) then {
				_x setPos (_arrayOfPositions select 0);
				_arrayOfPositions deleteAt 0;
			};
			_x setBehaviour "CARELESS";
		} foreach (units _grpdefenders);
		
		sleep 1;
		{_x setDamage 0;} foreach (_checkpoint1 + _checkpoint2 + _base_objects);
		
		_grpsentry = createGroup EAST;
		for [ {_idx=0},{_idx < 4},{_idx=_idx+1} ] do {
			_unitToSpawn = opfor_squad_8_standard call bis_fnc_selectrandom;
			_unitToSpawn createUnit [_spawnpos, _grpsentry,"this addMPEventHandler [""MPKilled"", {_this spawn kill_manager}]", 0.5, "private"];
			sleep 0.5;
		};		
		[units _grpsentry] call F_loadouts_swapOpfor;
		
		0 = [_grpsentry,  _spawnpos, 75] call BIS_fnc_taskPatrol;
		
		_defendersAlive = _defendersAlive + (units _grpsentry);
		
		sleep 5;
		{_x enableSimulationGlobal true} foreach _sacks;
		
		_debug = createMarker [format ["markername_%1", (floor (random 500))],(getMarkerPos _taskMarker)];
		_debug setMarkerShape "ICON";
		_debug setMarkerType "hd_objective";
				
		_spawnedAlready = true;
		_prepareInProgress = false;
		0 = [_taskMarker, _spawnpos] call BIS_fnc_taskSetDestination;
		0 = [_taskMarker, "ASSIGNED",false] spawn BIS_fnc_taskSetState;
	};
	
	//mission was spawned, but then unassigned - cleanup and restore starting state
	if ((_spawnedAlready) && !(([_taskMarker] call BIS_fnc_taskState) == "ASSIGNED")) then {		
		diag_log format ["%1 task %2 ENTERED BRANCH CLEANUP",_taskPrefix, _taskMarker];
		{sleep 0.1; deleteVehicle _x;} foreach _defendersAlive;
		{sleep 0.1; deleteVehicle _x;} foreach _base_objects;
		{sleep 0.1; deleteVehicle _x;} foreach _checkpoint1;
		{sleep 0.1; deleteVehicle _x;} foreach _checkpoint2;
		//need to return marker back
		_prepareInProgress = true;
		_spawnedAlready = false;
		deleteMarker _debug;
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
{sleep 0.1; deleteVehicle _x;} foreach _checkpoint1;
{sleep 0.1; deleteVehicle _x;} foreach _checkpoint2;