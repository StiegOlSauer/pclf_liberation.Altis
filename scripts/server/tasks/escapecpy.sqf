//template for 1-phase simple mission
if (!isServer) exitWith {};

params ["_markersArray"];
private ["_taskPrefix", "_taskMarker", "_taskCity","_base_objects", "_unitToSpawn", "_defendersAlive", "_arrayOfPositions", "_taskStates", "_pos",
"_phaseOneSpawned", "_phaseTwoSpawned", "_phaseOneDone", "_phaseTwoDone", "_phaseOnePrepare", "_phaseTwoPrepare",
"_airfield", "_dudes", "_dudesGroup", "_dudeMobile", "_escapePlane", "_escapePlaneType", "_distanceOk", "_duke", "_mike"];

_taskPrefix = "ESCAPE";
_taskStates = [];
_base_objects = [];
_defendersAlive = [];
_arrayOfPositions = [];
_distanceOk = false;
_phaseOneSpawned = false;
_phaseTwoSpawned = false;
_phaseOneDone = false;
_phaseTwoDone = false;
_phaseOnePrepare = true;
_phaseTwoPrepare = false;
_taskMarker = _markersArray deleteAt 0; //since then, _markersArray will contain list of airfields
_taskCity = [_taskMarker] call BIS_fnc_taskDestination;
_dudes = [];
_escapePlane = ObjNull;
diag_log format ["%1 task %2 INITIALIZATION START",_taskPrefix, _taskMarker];

while {(({ alive _x } count _dudes) > 0) && !(_distanceOk) || ((_phaseOnePrepare) && !(_phaseOneDone))} do {

	sleep 10;
	_distanceOk = false;
	private _aliveDudes = [];	
	if (((count _dudes) > 0) && (alive _escapePlane)) then {		
		_duke = _dudes select 0;
		_mike = _dudes select 1;
		
		if ((alive _duke) && (alive _mike) && ((_duke distance _escapePlane) <= 30) && ((_mike distance _escapePlane) <= 30)) then {
			_distanceOk = true;
		};
		
		if ((alive _duke) && !(alive _mike) && ((_duke distance _escapePlane) <= 30)) then {
			_distanceOk = true;
		};		
		
		if (!(alive _duke) && (alive _mike) && ((_mike distance _escapePlane) <= 30)) then {
			_distanceOk = true;
		};		
	};
	
	//mission is assigned - spawn it
	if ((([_taskMarker] call BIS_fnc_taskState) == "ASSIGNED") && !(_phaseOneSpawned)) then {
		diag_log format ["%1 task %2 ENTERED BRANCH SPAWN",_taskPrefix, _taskMarker];
		
		//code goes here
		//spawn car with dudes, disable movement, addAction to car that will transfer AI to player's group. End phase when at least 1 dude is alive and in DC-3
		//2nd phase used to calculate distance between DC3 with alive dude(s) and Altis.
		_dudesGroup = createGroup CIVILIAN;
		_airfield = selectRandom _markersArray;
		_escapePlaneType = selectRandom ["CUP_C_DC3_CIV","CUP_C_AN2_CIV"];
		_dudeMobile = "CUP_C_SUV_CIV" createVehicle (getMarkerPos _taskMarker);
		_escapePlane = _escapePlaneType createVehicle (getMarkerPos _airfield);
		sleep 0.5;
//		"C_man_1_3_F" createUnit [getMarkerPos _taskMarker, _dudesGroup];
//		"C_Man_casual_2_F" createUnit [getMarkerPos _taskMarker, _dudesGroup];
		
		_pos = _dudesGroup createUnit ["C_man_1_3_F", getPos _dudeMobile, [], 0, "FORM"];
		_pos = _dudesGroup createUnit ["C_Man_casual_2_F", getPos _dudeMobile, [], 0, "FORM"];
		sleep 0.5;
		
		_dudes = units _dudesGroup;
		diag_log format ["%1 task %2 spawned some units: dudemobile: %3, dudes: %4",_taskPrefix, _taskMarker, _dudeMobile, _dudes];
		(_dudes select 0) moveInDriver _dudeMobile;
		(_dudes select 1) moveInCargo _dudeMobile;
		
		{_x disableAI "MOVE";} foreach _dudes;
		_dudeMobile lock true;
		
		[_dudeMobile] remoteExec ["remote_call_addEscapeActions", 0];
		
		_base_objects = [_dudeMobile] + _dudes + [_escapePlane];
		
		_debug = createMarker [format ["markername_%1", (floor (random 500))],(getPos _escapePlane)];
		_debug setMarkerShape "ICON";
		_debug setMarkerType "hd_objective";		
		
		_phaseOneSpawned = true;
		_phaseOnePrepare = false;
		0 = [_taskMarker, getMarkerPos _taskMarker] call BIS_fnc_taskSetDestination;
		0 = [_taskMarker, "ASSIGNED",false] spawn BIS_fnc_taskSetState;
	};
	
	//mission was spawned, but then unassigned - cleanup and restore starting state
	if ((_phaseOneSpawned) && !(([_taskMarker] call BIS_fnc_taskState) == "ASSIGNED")) then {
		diag_log format ["%1 task %2 ENTERED BRANCH CLEANUP",_taskPrefix, _taskMarker];		
		{sleep 0.1; deleteVehicle _x;} foreach _base_objects;
		//need to return marker back
		_phaseOneDone = false;
		_phaseOnePrepare = true;
		_phaseOneSpawned = false;
		0 = [_taskMarker, _taskCity] call BIS_fnc_taskSetDestination;
		0 = [_taskMarker, "CREATED",false] spawn BIS_fnc_taskSetState;
	};
	
	//FOB relocated and mission did not appear again - check if it was spawned before, cleanup, end thread
	if (!(_taskMarker in GRLIB_tasksAssigned)) then {
		diag_log format ["%1 task %2 ENTERED BRANCH END",_taskPrefix, _taskMarker];
		//do cleanup
		_phaseOnePrepare = false;
		_phaseOneSpawned = false;
		_phaseOneDone = false;
		{sleep 0.1; deleteVehicle _x;} foreach _base_objects;
	};
};

sleep 1;
diag_log format ["%1 task %2 ended its first phase",_taskPrefix,_taskMarker];
if ((({ alive _x } count _dudes) > 0) && (([_taskMarker] call BIS_fnc_taskState) == "ASSIGNED") && (_taskMarker in GRLIB_tasksAssigned)) then {
	_phaseOneDone = true;
	_phaseTwoDone = false;
	_phaseOnePrepare = false;
	_phaseTwoPrepare = true;
	_phaseOneSpawned = false;
	_phaseTwoSpawned = false;
	_distanceOk = false;
};

//Beginning of phase two
while {(({ alive _x } count _dudes) > 0) && (alive _escapePlane) && !(_distanceOk) || ((_phaseOneDone) && (_phaseTwoPrepare))} do {	
	
	sleep 5;
	_dudesGroup = createGroup CIVILIAN;
	_distanceOk = false;
	private _aliveDudes = [];	
	if (((count _dudes) > 0) && (alive _escapePlane)) then {		
		_duke = _dudes select 0;
		_mike = _dudes select 1;
		
		if (((alive _duke) && (_duke in (crew _escapePlane))) || ((alive _mike) && (_mike in (crew _escapePlane))) && ({_escapePlane distance (getMarkerPos _x) < 1000} count sectors_opfor) == 0) then {
			_distanceOk = true;
		};
	};
	
	//mission is assigned - spawn it
	if ((([_taskMarker] call BIS_fnc_taskState) == "ASSIGNED") && !(_phaseTwoSpawned)) then {
		diag_log format ["%1 task %2 entered phase two spawn",_taskPrefix,_taskMarker];

		{
			[_x] joinSilent _dudesGroup;
			_x assignAsCargo _escapePlane;
			[_x] orderGetIn true;
		} foreach _dudes;
				
		diag_log format ["%1 task %2 has ended phase two spawn",_taskPrefix, _taskMarker];		
		_phaseTwoSpawned = true;
		_phaseTwoPrepare = false;
		0 = [_taskMarker, getPos _escapePlane] call BIS_fnc_taskSetDestination;
		0 = [_taskMarker, ["escape", "Fly away from Altis (10 km minimum).", "Running men"]] call BIS_fnc_taskSetDescription;
		0 = [_taskMarker, "ASSIGNED",true] spawn BIS_fnc_taskSetState;
	};
	
	if ((_phaseTwoSpawned) && !(([_taskMarker] call BIS_fnc_taskState) == "ASSIGNED")) then {		
		diag_log format ["%1 task %2 ENTERED BRANCH CLEANUP",_taskPrefix, _taskMarker];		
		
		//need to return marker back
		_phaseTwoPrepare = true;
		_phaseTwoSpawned = false;
		//0 = [_taskMarker, _taskCity] call BIS_fnc_taskSetDestination;
		0 = [_taskMarker, "CREATED",false] spawn BIS_fnc_taskSetState;
	};
	
	//FOB relocated and mission did not appear again - check if it was spawned before, cleanup, end thread
	if (!(_taskMarker in GRLIB_tasksAssigned)) then {
		diag_log format ["%1 task %2 ENTERED BRANCH END",_taskPrefix, _taskMarker];
		//do cleanup
		_phaseTwoPrepare = false;
		_phaseTwoSpawned = false;
		{sleep 0.1; deleteVehicle _x;} foreach _base_objects;
	};
};
	
diag_log format ["%1 task %2 EXITED FROM LOOP",_taskPrefix, _taskMarker];
//cleanup code
if ((_taskMarker in GRLIB_tasksAssigned) && (([_taskMarker] call BIS_fnc_taskState) == "ASSIGNED") && (({ alive _x } count _dudes) > 0)) then {
	_nil = [_taskMarker, "SUCCEEDED",true] spawn BIS_fnc_taskSetState;
	GRLIB_tasksCompleted append [_taskMarker];
	sleep 5;
	0 = [_taskMarker] call BIS_fnc_deleteTask;
	0 = GRLIB_tasksAssigned deleteAt (GRLIB_tasksAssigned find _taskMarker);
	
	diag_log format ["%1 task %2 SUCCEEDED. AAR: GRLIB_tasksAssigned: %3",_taskPrefix, _taskMarker, GRLIB_tasksAssigned];
	
	sleep 1;
	[_taskMarker] call F_tasks_replaceTask;
	sleep 30;
};
if ((_taskMarker in GRLIB_tasksAssigned) && (([_taskMarker] call BIS_fnc_taskState) == "ASSIGNED") && (({ alive _x } count _dudes) == 0)) then {
	//handle task failure
	_nil = [_taskMarker, "FAILED",true] spawn BIS_fnc_taskSetState;
	GRLIB_tasksCompleted append [_taskMarker];
	GRLIB_tasksPenalty = GRLIB_tasksPenalty + 1;
	sleep 5;
	0 = [_taskMarker] call BIS_fnc_deleteTask;
	0 = GRLIB_tasksAssigned deleteAt (GRLIB_tasksAssigned find _taskMarker);
	
	diag_log format ["%1 task %2 FAILED. AAR: GRLIB_tasksAssigned: %3",_taskPrefix, _taskMarker, GRLIB_tasksAssigned];	
	sleep 1;
	[_taskMarker] call F_tasks_replaceTask;
	sleep 30;
} else {
	0 = [_taskMarker] call BIS_fnc_deleteTask;
};
{sleep 0.1; deleteVehicle _x;} foreach _dudes;
if (((crew _escapePlane) > 0) && (alive _escapePlane)) then {_base_objects = _base_objects - [_escapePlane]};
if (((crew _dudeMobile) > 0) && (alive _escapePlane)) then {_base_objects = _base_objects - [_dudeMobile]};
{sleep 0.1; deleteVehicle _x;} foreach _base_objects;