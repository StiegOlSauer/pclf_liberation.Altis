//template for 2-phase simple mission
if (!isServer) exitWith {};

params ["_markersArray"];
private ["_taskPrefix", "_taskMarker", "_taskCity","_base_objects", "_unitToSpawn", "_defendersAlive", "_arrayOfPositions", "_ammoboxes", "_taskStates", "_pos",
"_phaseOneSpawned", "_phaseTwoSpawned", "_phaseOneDone", "_phaseTwoDone", "_phaseOnePrepare", "_phaseTwoPrepare", "_campsArray", "_campDefenders", "_praga", "_wpArray", "_targetsArray"];

_taskPrefix = "FUELWARS";
_base_objects = [];
_defendersAlive = [];
_arrayOfPositions = [];
_phaseOneSpawned = false;
_phaseTwoSpawned = false;
_phaseOneDone = false;
_phaseTwoDone = false;
_phaseOnePrepare = true;
_phaseTwoPrepare = false;
_ammoboxes = [];
_campsArray = [];
_taskMarker = _markersArray deleteAt 0;
_taskCity = [_taskMarker] call BIS_fnc_taskDestination;

diag_log format ["%1 task %2 INITIALIZATION START",_taskPrefix, _taskMarker];


GRLIB_fuelwarsRouteTo = {
	params ["_praga", "_wpArray", "_targetsArray"];

	(driver _praga) setFormation "FILE";
	(driver _praga) setBehaviour "SAFE";
	(driver _praga) setCombatMode "GREEN";
	(driver _praga) setSpeedMode "LIMITED";

	while {(count (waypoints (driver _praga))) != 0} do {deleteWaypoint ((waypoints (driver _praga)) select 0);};
	diag_log format ["FUELWARS task: waypoints generated: %1", _wpArray];

	//[_wpArray, _convoyComposition, _baseLocation] spawn GRLIB_revengeConvoyInit;
	private _spawnExit = false;
	_praga doMove (getPos (_wpArray select 1));

	waitUntil {sleep 3; (((_praga distance (_wpArray select 1)) < 60) && ((speed _praga) == 0)) || (!canMove _praga)};
	doStop _praga;
	if (!canMove _praga) exitwith {diag_log "FUELWARS Praga was demaged or destroyed.";};

	[_praga, _wpArray, _targetsArray] spawn GRLIB_fuelwarsWait;
};

GRLIB_fuelwarsWait = {
	params ["_praga", "_wpArray", "_targetsArray"];

	diag_log format ["FUELWARS task: driver gotta out his truck."];
	_pragaDriver = driver _praga;
	_pragaDriver leaveVehicle _praga;
	while {(count (waypoints _pragaDriver)) != 0} do {deleteWaypoint ((waypoints _pragaDriver) select 0);};
	diag_log format ["FUELWARS task %1: driver is moving to base.",_taskMarker];

	_pragaDriver setBehaviour "CARELESS";
	_pragaDriver setSpeedMode "LIMITED";
	_pragaDriver doMove (_wpArray select 1);
	_pragaDriver setBehaviour "CARELESS";
	_pragaDriver setSpeedMode "LIMITED";

	waitUntil {sleep 5; ((_pragaDriver distance (_wpArray select 1) < 5) || (!alive _pragaDriver))};
	if ((!alive _pragaDriver) || (!canMove _praga)) exitwith {diag_log "FUELWARS task driver's path is broken or he is dead.";};

	sleep 15;
	diag_log format ["FUELWARS task: driver is moving to the truck."];

	private _dir = getDir _praga;
	if (_dir >= 180) then {_dir = _dir - 180;} else {_dir = 360 + _dir - 180;};
	_praga setDir _dir;

	_pragaDriver doMove (getPos _praga);
	_pragaDriver setBehaviour "CARELESS";
	_pragaDriver setSpeedMode "LIMITED";
	waitUntil {sleep 5; (((_pragaDriver distance _praga) <= 5) || (!alive _pragaDriver) || (!canMove _praga))};
	if ((!alive _pragaDriver) || (!canMove _praga)) exitwith {diag_log "FUELWARS task: driver is dead.";};
	_pragaDriver moveInDriver _praga;
	diag_log format ["FUELWARS task: TARGET is in the truck."];

	[_praga, _wpArray, _targetsArray] spawn GRLIB_revengeRouteFrom;
};

GRLIB_fuelwarsRouteFrom = {
	params ["_praga", "_wpArray", "_targetsArray"];

	while {(count (waypoints (driver _praga))) != 0} do {deleteWaypoint ((waypoints (driver _praga)) select 0);};
	diag_log format ["FUELWARS task started waypoint generation."];

	waitUntil {sleep 3; (((_praga distance _taskCity) < 100) || (!alive _pragaDriver) || (!canMove _praga))};

	if ((GRLIB_revengeAttacked) && (_targetVIP distance (getMarkerPos _baseLocation) > 200)) exitwith {[_targetVIP, _convoyComposition, _markersArray, _taskMarker, _baseLocation, _convoyGroup, _taskCity] spawn GRLIB_revengeAlertFar;};

	[_praga, _wpArray, _targetsArray] spawn GRLIB_fuelwarsRouteTo;
	diag_log format ["FUELWARS task: TARGET made a full circle."];
};


while {(({alive _x} count _targetsArray) > 0) || ((_phaseOnePrepare) && !(_phaseOneDone))} do {

	sleep 2;
	//mission is assigned - spawn it
	if ((([_taskMarker] call BIS_fnc_taskState) == "ASSIGNED") && !(_spawnedAlready)) then {
		diag_log format ["%1 task %2 ENTERED BRANCH SPAWN",_taskPrefix, _taskMarker];

		//spawn base, spawn camps, add patrol to base, spawn v3s
		_base_objects = [(getMarkerPos _taskMarker), 0, call (compile (preprocessFileLineNumbers "scripts\fob_templates\refinery_small.sqf"))] call BIS_fnc_ObjectsMapper;
		_defendersAlive = [_base_objects, true] call F_tasks_spawnBaseDefenders;

		{
			if ((typeOf _x) == "I_Truck_02_fuel_F") then {
			_pos = getPos _x;
			deleteVehicle _x;
			"CUP_I_V3S_Refuel_TKG" createVehicle _pos;
			};
			if ((typeOf _x) == "Land_Tank_rust_F") then {
				_targetsArray append [_x];
			};
		} foreach _base_objects;

		private _camp = [];
		{
			_camp = [(getMarkerPos _x), (random 360), call (compile (preprocessFileLineNumbers format["scripts\fob_templates\%1.sqf", (selectRandom ["banditCamp_small1", "banditCamp_small2"])]))] call BIS_fnc_ObjectsMapper;
			_campDefenders = [_camp, true] call F_tasks_spawnBaseDefenders;
			_campsArray append _camp;
		} foreach _markersArray;

		//v3s time!
		//CUP_I_V3S_Refuel_TKG
		//CUP_I_V3S_Repair_TKG
		private _road;
		_road = selectRandom (_taskCity nearRoads 50);
		_praga = "CUP_I_V3S_Repair_TKG" createVehicle (getPos _road);
		[_praga] call F_libSpawnOpforCrew;

		_wpArray = [_taskCity, (getMarkerPos _taskMarker)];

		[_praga, _wpArray, _targetsArray] spawn GRLIB_fuelwarsRouteTo;

		_phaseOneSpawned = true;
		_phaseOnePrepare = false;
		0 = [_taskMarker, getMarkerPos _taskMarker] call BIS_fnc_taskSetDestination;
		0 = [_taskMarker, "ASSIGNED",false] spawn BIS_fnc_taskSetState;
	};

	//mission was spawned, but then unassigned - cleanup and restore starting state
	if ((_phaseOneSpawned) && !(([_taskMarker] call BIS_fnc_taskState) == "ASSIGNED")) then {
		diag_log format ["%1 task %2 ENTERED BRANCH CLEANUP",_taskPrefix, _taskMarker];

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
		{sleep 0.1; deleteVehicle _x;} foreach _defendersAlive;
	};
};

sleep 1;
diag_log format ["%1 task %2 ended its first phase",_taskPrefix,_taskMarker];
if ((({ alive _x } count _defendersAlive ) == 0) && (([_taskMarker] call BIS_fnc_taskState) == "ASSIGNED") && (_taskMarker in GRLIB_tasksAssigned)) then {
	_phaseOneDone = true;
	_phaseTwoDone = false;
	_phaseOnePrepare = false;
	_phaseTwoPrepare = true;
	_phaseOneSpawned = false;
	_phaseTwoSpawned = false;
};

//Beginning of phase two
while {(({ alive _x } count _convoyDefenders ) > 2) || ((_phaseOneDone) && (_phaseTwoPrepare))} do {

	sleep 10;
	//mission is assigned - spawn it
	if ((([_taskMarker] call BIS_fnc_taskState) == "ASSIGNED") && !(_phaseTwoSpawned)) then {
		diag_log format ["%1 task %2 entered phase two spawn",_taskPrefix,_taskMarker];



		diag_log format ["%1 task %2 has ended phase two spawn",_taskPrefix, _taskMarker];
		GRLIB_tasksTOD = [];
		_phaseTwoSpawned = true;
		_phaseTwoPrepare = false;
		0 = [_taskMarker, getMarkerPos _convoyStartMarker] call BIS_fnc_taskSetDestination;
		0 = [_taskMarker, ["destroy roadblock", "task description", "Task header"]] call BIS_fnc_taskSetDescription;
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

	diag_log format ["%1 task %2 SUCCEEDED. AAR: GRLIB_tasksAssigned: %3",_taskPrefix, _taskMarker, GRLIB_tasksAssigned];

	sleep 1;
	[_taskMarker] call F_tasks_replaceTask;
	sleep 30;
} else {
	0 = [_taskMarker] call BIS_fnc_deleteTask;
};

{sleep 0.1; deleteVehicle _x;} foreach _defendersAlive;
{sleep 0.1; deleteVehicle _x;} foreach _base_objects;
