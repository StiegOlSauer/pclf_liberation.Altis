//template for 1-phase simple mission
if (!isServer) exitWith {};

params ["_markersArray"];
private ["_taskPrefix", "_taskMarker", "_taskCity","_base_objects", "_unitToSpawn", "_defendersAlive", "_arrayOfPositions", "_ammoboxes", "_taskStates", "_pos", "_spawnedAlready", "_prepareInProgress",
"_taskObjects", "_adjacent", "_normalizedDir", "_dir1", "_dir2", "_roadObjects", "_road"];

_taskPrefix = "SMALLBLOCK";
_taskStates = [];
_base_objects = [];
_taskObjects = [];
_defendersAlive = [];
_arrayOfPositions = [];
_spawnedAlready = false;
_prepareInProgress = true;
_ammoboxes = [];
_taskMarker = _markersArray deleteAt 0;
_taskCity = [_taskMarker] call BIS_fnc_taskDestination;
diag_log format ["%1 task %2 INITIALIZATION START",_taskPrefix, _taskMarker];

while {((({alive _x} count _defendersAlive) > 0) || (({ alive _x } count _taskObjects) > 0)) || (_prepareInProgress)} do {

	sleep 2; 
	//mission is assigned - spawn it
	if ((([_taskMarker] call BIS_fnc_taskState) == "ASSIGNED") && !(_spawnedAlready)) then {
		diag_log format ["%1 task %2 ENTERED BRANCH SPAWN",_taskPrefix, _taskMarker];
		
		sleep 1;
		_roadObjects = (getMarkerPos _taskMarker) nearRoads 50;
		_road = selectRandom _roadObjects;
		_roadObjects = (roadsConnectedTo _road) select 0;
		
		//check direction to marker
		if (((roadsConnectedTo _road) select 1) distance _taskCity < ((roadsConnectedTo _road) select 0) distance _taskCity) then {
			_roadObjects = (roadsConnectedTo _road) select 1;			
		};		
		
		//find 3 adjacent sectors of road and normalize direction between them
		_adjacent = [];
		_dir1 = 0;
		_dir2 = 0;
		_normalizedDir = 0;
		while {count _adjacent < 3} do {
			_road = _roadObjects;
			_roadObjects = (roadsConnectedTo _road) select 0;
			if (((roadsConnectedTo _road) select 1) distance _taskCity < ((roadsConnectedTo _road) select 0) distance _taskCity) then {
				_roadObjects = (roadsConnectedTo _road) select 1;					
			};
			diag_log format ["SMALLBLOCK task: adding to road array: %1", getPos _road];
			_adjacent append [getPos _road];
		};
		
		_dir1 = (_adjacent select 0) getDir (_adjacent select 1);
		_dir2 = (_adjacent select 0) getDir (_adjacent select 2);
		_normalizedDir = _dir1 + (_dir2 - _dir1)/2;
		diag_log format ["%1 task: directions: %2, %3, %4", _taskPrefix, _dir1, _dir2, _normalizedDir];
		
		//90 is a direction offset for this particular composition
		if (_normalizedDir < 90) then {
			_base_objects = [(_adjacent select 1), (360 + _normalizedDir - 90), call (compile (preprocessFileLineNumbers "scripts\fob_templates\roadblockSmall.sqf"))] call BIS_fnc_ObjectsMapper;
		} else {
			_base_objects = [(_adjacent select 1), (_normalizedDir - 90), call (compile (preprocessFileLineNumbers "scripts\fob_templates\roadblockSmall.sqf"))] call BIS_fnc_ObjectsMapper;
		};
		
		_grpdefenders = createGroup EAST;
		{	
			if ((typeOf _x) == "VR_Area_01_square_1x1_grey_F") then {
				_pos = getPos _x;
				_arrayOfPositions append [_pos];
				_unitToSpawn = opfor_squad_8_standard call bis_fnc_selectrandom;
				deleteVehicle _x;
				_unitToSpawn createUnit [_pos, _grpdefenders,"this addMPEventHandler [""MPKilled"", {_this spawn kill_manager}]", 0.5, "private"];
				diag_log "SMALLBLOCK unit spawned";
				sleep 0.5;				
			};
			if (((typeOf _x) == "Land_BarGate_F") || ((typeOf _x) == "Land_BagBunker_Tower_F") || ((typeOf _x) == "Land_BagBunker_Small_F")) then {
				_taskObjects append [_x];
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
		
		_base_objects = _base_objects -_ammoboxes;
		
		_grpdefenders spawn {waitUntil {sleep 5; {!(alive _x)} count (units _this) > 0}; _this setBehaviour "COMBAT";};
		[units _grpdefenders] call F_loadouts_swapOpfor;
		{
			_defendersAlive = _defendersAlive + [_x];
			if ((count _arrayOfPositions) > 0) then {
				_x setPos (_arrayOfPositions select 0);
				_arrayOfPositions deleteAt 0;
				_x setBehaviour "CARELESS";
			};
		} foreach (units _grpdefenders);

		sleep 1;
		{ _x setDamage 0; } foreach (_base_objects);		
		sleep 5;
		
		_spawnedAlready = true;
		_prepareInProgress = false;
		0 = [_taskMarker, getMarkerPos _taskMarker] call BIS_fnc_taskSetDestination;
		0 = [_taskMarker, "ASSIGNED",false] spawn BIS_fnc_taskSetState;
		diag_log format ["%1 task %2 ENDED SPAWN",_taskPrefix, _taskMarker];
	};
	
	//mission was spawned, but then unassigned - cleanup and restore starting state
	if ((_spawnedAlready) && !(([_taskMarker] call BIS_fnc_taskState) == "ASSIGNED")) then {		
		diag_log format ["%1 task %2 ENTERED BRANCH CLEANUP",_taskPrefix, _taskMarker];		
		
		//need to return marker back
		_prepareInProgress = true;
		_spawnedAlready = false;
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