if (!isServer) exitWith {};

params ["_markersArray"];
private ["_taskMarker","_taskCity","_base_objects", "_roadObjects", "_road", "_convoyStartMarker", "_unitToSpawn", "_defendersAlive", "_arrayOfPositions",
"_pos", "_adjacent", "_normalizedDir", "_dir1", "_dir2",
"_phaseOneSpawned", "_phaseTwoSpawned", "_phaseOneDone", "_phaseTwoDone", "_phaseOnePrepare", "_phaseTwoPrepare", "_convoyComposition", "_convoyDefenders", "_addTroopsGroup",
"_truckConvoy", "_apcConvoy", "_wpArray"];

_base_objects = [];
_defendersAlive = [];
_convoyDefenders = [];
_arrayOfPositions = [];
_phaseOneSpawned = false;
_phaseTwoSpawned = false;
_phaseOneDone = false;
_phaseTwoDone = false;
_phaseOnePrepare = true;
_phaseTwoPrepare = false;
_taskMarker = _markersArray deleteAt 0;
_convoyStartMarker = _markersArray deleteAt 0;
_taskCity = [_taskMarker] call BIS_fnc_taskDestination;
diag_log format ["task %1 SPAWNED AS ROADBLOCK",_taskMarker];

while {(({ alive _x } count _defendersAlive ) > 0) || ((_phaseOnePrepare) && !(_phaseOneDone))} do {

	sleep 10;
	//mission is assigned - spawn it
	if ((([_taskMarker] call BIS_fnc_taskState) == "ASSIGNED") && !(_phaseOneSpawned)) then {
		diag_log format ["ROADBLOCK task %1 ENTERED BRANCH SPAWN",_taskMarker];
		
		sleep 1;
		_roadObjects = (getMarkerPos _taskMarker) nearRoads 50;
		_road = selectRandom _roadObjects;
		_roadObjects = (roadsConnectedTo _road) select 0;
		
		//check direction to marker
		if (((roadsConnectedTo _road) select 1) distance (getMarkerPos _convoyStartMarker) < ((roadsConnectedTo _road) select 0) distance (getMarkerPos _convoyStartMarker)) then {
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
			if (((roadsConnectedTo _road) select 1) distance (getMarkerPos _convoyStartMarker) < ((roadsConnectedTo _road) select 0) distance (getMarkerPos _convoyStartMarker)) then {
				_roadObjects = (roadsConnectedTo _road) select 1;					
			};
			diag_log format ["ROADBLOCK task: adding to road array: %1", getPos _road];
			_adjacent append [getPos _road];
		};
		
		_dir1 = (_adjacent select 0) getDir (_adjacent select 1);
		_dir2 = (_adjacent select 0) getDir (_adjacent select 2);
		_normalizedDir = _dir1 + (_dir2 - _dir1)/2;
		diag_log format ["ROADBLOCK task: directions: %1, %2, %3", _dir1, _dir2, _normalizedDir];
		
		//137 is a direction offset for this particular composition
		if (_normalizedDir > 223) then {
			_base_objects = [(_adjacent select 1), (_normalizedDir + 137 - 360), call (compile (preprocessFileLineNumbers "scripts\fob_templates\roadblock.sqf"))] call BIS_fnc_ObjectsMapper;
		} else {
			_base_objects = [(_adjacent select 1), _normalizedDir + 137, call (compile (preprocessFileLineNumbers "scripts\fob_templates\roadblock.sqf"))] call BIS_fnc_ObjectsMapper;
		};
		
		_grpdefenders = createGroup EAST;
		{	
			if ((typeOf _x) == "VR_Area_01_square_1x1_grey_F") then {
				_pos = getPos _x;
				_arrayOfPositions append [_pos];
				_unitToSpawn = opfor_squad_8_infkillers call bis_fnc_selectrandom;
				deleteVehicle _x;
				_unitToSpawn createUnit [_pos, _grpdefenders,"this addMPEventHandler [""MPKilled"", {_this spawn kill_manager; GRLIB_tasksTOD append [time];}]", 0.5, "private"];
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
		sleep 5;
		diag_log format ["ROADBLOCK task %1 ENDED SPAWN",_taskMarker];
		//Essentially, this is the end of phase one. Now we got to watch for phase 1 progress. Bail out on standard circumstances (task unassigned, FOB redeployed).
		_phaseOneSpawned = true;
		_phaseOnePrepare = false;
		0 = [_taskMarker, getMarkerPos _taskMarker] call BIS_fnc_taskSetDestination;
		0 = [_taskMarker, "ASSIGNED",false] spawn BIS_fnc_taskSetState;
	};
	
	//mission was spawned, but then unassigned - cleanup and restore starting state
	if ((_phaseOneSpawned) && !(([_taskMarker] call BIS_fnc_taskState) == "ASSIGNED")) then {		
		diag_log format ["ROADBLOCK task %1 ENTERED BRANCH CLEANUP",_taskMarker];		
		{sleep 0.1; deleteVehicle _x;} foreach _base_objects;
		{sleep 0.1; deleteVehicle _x;} foreach _defendersAlive;
		//need to return marker back
		_phaseOneDone = false;
		_phaseOnePrepare = true;
		_phaseOneSpawned = false;
		0 = [_taskMarker, _taskCity] call BIS_fnc_taskSetDestination;
		0 = [_taskMarker, "CREATED",false] spawn BIS_fnc_taskSetState;
	};
	
	//FOB relocated and mission did not appear again - check if it was spawned before, cleanup, end thread
	if (!(_taskMarker in GRLIB_tasksAssigned)) then {
		diag_log format ["ROADBLOCK task %1 ENTERED BRANCH END",_taskMarker];
		//do cleanup
		_phaseOnePrepare = false;
		_phaseOneSpawned = false;
		_phaseOneDone = false;
		{sleep 0.1; deleteVehicle _x;} foreach _defendersAlive;
	};
//	diag_log format ["ROADBLOCK task _defendersAlive: %1, %2, %3",({ alive _x } count _defendersAlive), _phaseOnePrepare, _phaseOneDone];
};
sleep 1;
diag_log format ["ROADBLOCK task %1 ended its first phase",_taskMarker];
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
	
	sleep 300 + (random 60);
	//mission is assigned - spawn it
	if ((([_taskMarker] call BIS_fnc_taskState) == "ASSIGNED") && !(_phaseTwoSpawned)) then {
		diag_log format ["ROADBLOCK task %1 calculated TODs: %2",_taskMarker,GRLIB_tasksTOD];
		diag_log format ["ROADBLOCK task %1 entered phase two spawn",_taskMarker];
				
		//spawn convoy: scout (hmmv), apc (m113 with grunts), ammo truck (+ammobox), fuel truck, [bradley, troop transport (O_Truck_02_covered_F)], tail hmmv.
		
		private _scoutConvoy = [[getMarkerPos _convoyStartMarker, 30, 0 ] call BIS_fnc_relPos, "rhsusf_m1025_d_m2", true, false, false ] call F_libSpawnVehicle;
		sleep 0.5;
		if ((GRLIB_tasksTOD select 4) - (GRLIB_tasksTOD select 0) > 15) then {
			diag_log format ["ROADBLOCK task %1 TOD delta is %2, additional units will be spawned",_taskMarker, (GRLIB_tasksTOD select 4) - (GRLIB_tasksTOD select 0)];
			_apcConvoy = [[ getMarkerPos _convoyStartMarker, 10, 0 ] call BIS_fnc_relPos, "RHS_M2A2", true, false, false ] call F_libSpawnVehicle;
		} else {
			_apcConvoy= [[ getMarkerPos _convoyStartMarker, 10, 0 ] call BIS_fnc_relPos, "rhsusf_m113d_usarmy", true, false, false ] call F_libSpawnVehicle;
		};
		sleep 0.5;
		private _ammoConvoy = [[ getMarkerPos _convoyStartMarker, 10, 180 ] call BIS_fnc_relPos, "O_Truck_02_Ammo_F", true, false, false ] call F_libSpawnVehicle;
		sleep 0.5;
		private _fuelConvoy = [[ getMarkerPos _convoyStartMarker, 30, 180 ] call BIS_fnc_relPos, "O_Truck_02_fuel_F", true, false, false ] call F_libSpawnVehicle;
		sleep 0.5;
		private _tailConvoy = [[ getMarkerPos _convoyStartMarker, 50, 180 ] call BIS_fnc_relPos, "rhsusf_m1025_d_Mk19", true, false, false ] call F_libSpawnVehicle;
		sleep 0.5;
			
		if ((GRLIB_tasksTOD select 4) - (GRLIB_tasksTOD select 0) > 15) then {
			_truckConvoy = [[ getMarkerPos _convoyStartMarker, 70, 180 ] call BIS_fnc_relPos, "O_Truck_02_transport_F", true, false, false ] call F_libSpawnVehicle;
			sleep 0.5;
		};
		
		private _convoyGroup = group driver _scoutConvoy;
		(crew _apcConvoy + crew _ammoConvoy + crew _fuelConvoy + crew _tailConvoy) joinSilent _convoyGroup;
		
		if ((GRLIB_tasksTOD select 4) - (GRLIB_tasksTOD select 0) > 15) then {
			(crew _truckConvoy) joinSilent _convoyGroup;
		};
		
		diag_log format ["ROADBLOCK task %1 formed convoy group: %2",_taskMarker, (units _convoyGroup)];
		
		//["AddCargoByClass", [ammocrate_o_typename, _ammoConvoy, 2]] call ace_common_fnc_localEvent;
		//20:35:09 [ACE] (common) WARNING: ace_common_fnc_localEvent is deprecated. Support will be dropped in version 3.8.0. Replaced by: CBA_fnc_localEvent File: z\ace\addons\common\functions\fnc_localEvent.sqf Line: 12
		
		_convoyGroup setFormation "FILE";
		_convoyGroup setBehaviour "SAFE";
		_convoyGroup setCombatMode "GREEN";
		_convoyGroup setSpeedMode "LIMITED";

		while {(count (waypoints _convoyGroup)) != 0} do {deleteWaypoint ((waypoints _convoyGroup) select 0);};
		diag_log format ["ROADBLOCK task %1 started waypoint generation",_taskMarker];
		_wpArray = [];
		_wpArray append [([(getMarkerPos _convoyStartMarker), (getMarkerPos _taskMarker), 300, true] call F_tasks_followRoad)];
		diag_log format ["ROADBLOCK task %1: 1 waypoint generated: %2",_taskMarker, _wpArray];
		_wpArray append [([(getMarkerPos _taskMarker), (getMarkerPos _convoyStartMarker), 300, true] call F_tasks_followRoad)];
		diag_log format ["ROADBLOCK task %1: 2 waypoints generated: %2",_taskMarker, _wpArray];
		_wpArray append [([(getMarkerPos _taskMarker), (_wpArray select 1), 1000, false] call F_tasks_followRoad)];
		diag_log format ["ROADBLOCK task %1: 3 waypoints generated: %2",_taskMarker, _wpArray];
		
		private _troopsGroup = createGroup EAST;
		{ _x createUnit [getMarkerPos _convoyStartMarker, _troopsGroup,"this addMPEventHandler [""MPKilled"", {_this spawn kill_manager}]", 0.5, "private"]; } foreach ([] call F_getAdaptiveSquadComp);
		sleep 1;
		[units _troopsGroup] call F_loadouts_swapOpfor;
		sleep 1;
		{
			_x moveInCargo _apcConvoy;
			sleep 0.2;
			if (vehicle _x == _x) then {deleteVehicle _x;};
		} foreach (units _troopsGroup);
		
		diag_log format ["ROADBLOCK task %1 spawned armed grunts",_taskMarker];
		
		_convoyComposition = [_scoutConvoy, _apcConvoy, _ammoConvoy, _fuelConvoy, _tailConvoy];
		_convoyDefenders = (units _convoyGroup) + (units _troopsGroup);
		
		if ((GRLIB_tasksTOD select 4) - (GRLIB_tasksTOD select 0) > 15) then {
			_addTroopsGroup = createGroup EAST;
			{ _x createUnit [getMarkerPos _convoyStartMarker, _addTroopsGroup,"this addMPEventHandler [""MPKilled"", {_this spawn kill_manager}]", 0.5, "private"]; } foreach ([] call F_getAdaptiveSquadComp);
			sleep 1;
			[units _addTroopsGroup] call F_loadouts_swapOpfor;
			{ _x moveInCargo _truckConvoy } foreach (units _addTroopsGroup);			
			_convoyComposition = [_scoutConvoy, _apcConvoy, _ammoConvoy, _fuelConvoy, _truckConvoy ,_tailConvoy];
			_convoyDefenders append (crew _truckConvoy);
		};
		
		private _lead = _convoyComposition select 0;
		_lead setPos (getMarkerPos _convoyStartMarker);
		_lead setDir (_lead getDir (getMarkerPos _taskMarker));
		private _i = 0;
		{_i = _i + 1; _x setPos (_lead modelToWorld [0, -(_i*20), 0]);_x setDir (getDir _lead);} foreach _convoyComposition;
		{_x setDamage 0} foreach _convoyComposition;
		[_wpArray, _convoyComposition] spawn convoyInit;
		
		diag_log format ["ROADBLOCK task %1: convoy initialized",_taskMarker];
		
		private _flarePos = [(getMarkerPos _taskMarker), (getMarkerPos _convoyStartMarker), 150, true] call F_tasks_followRoad;
		private _flare = "F_40mm_Red" createvehicle[_flarePos select 0, _flarePos select 1, 150];
		_flare setVelocity [0,0,-4];
		
		diag_log format ["ROADBLOCK task %1 has ended phase two spawn",_taskMarker];
		GRLIB_tasksTOD = [];
		_phaseTwoSpawned = true;
		_phaseTwoPrepare = false;
		0 = [_taskMarker, getMarkerPos _convoyStartMarker] call BIS_fnc_taskSetDestination;
		0 = [_taskMarker, ["destroy roadblock", "Roadblock cleared, not it is time to take care about convoy", "Capture and ambush"]] call BIS_fnc_taskSetDescription;
		0 = [_taskMarker, "ASSIGNED",true] spawn BIS_fnc_taskSetState;
	};
	
	//mission was spawned, but then unassigned - cleanup and restore starting state
	if ((_phaseTwoSpawned) && !(([_taskMarker] call BIS_fnc_taskState) == "ASSIGNED")) then {		
		diag_log format ["ROADBLOCK task %1 ENTERED BRANCH CLEANUP",_taskMarker];		
		{sleep 0.1; deleteVehicle _x;} foreach _convoyDefenders;
		{sleep 0.1; deleteVehicle _x;} foreach _convoyComposition;
		//need to return marker back
		_phaseTwoPrepare = true;
		_phaseTwoSpawned = false;
		//0 = [_taskMarker, _taskCity] call BIS_fnc_taskSetDestination;
		0 = [_taskMarker, "CREATED",false] spawn BIS_fnc_taskSetState;
	};
	
	//FOB relocated and mission did not appear again - check if it was spawned before, cleanup, end thread
	if (!(_taskMarker in GRLIB_tasksAssigned)) then {
		diag_log format ["ROADBLOCK task %1 ENTERED BRANCH END",_taskMarker];
		//do cleanup
		_phaseTwoPrepare = false;
		_phaseTwoSpawned = false;
		{sleep 0.1; deleteVehicle _x;} foreach _defendersAlive;
	};
//	diag_log format ["ROADBLOCK task _convoyDefenders: %1, %2, %3",({ alive _x } count _convoyDefenders), _phaseOneDone, _phaseTwoPrepare];
};

diag_log format ["ROADBLOCK task %1 EXITED FROM LOOP",_taskMarker];
//cleanup code
if ((_taskMarker in GRLIB_tasksAssigned) && (([_taskMarker] call BIS_fnc_taskState) == "ASSIGNED")) then {
	_nil = [_taskMarker, "SUCCEEDED",true] spawn BIS_fnc_taskSetState;
	GRLIB_tasksCompleted append [_taskMarker];
	sleep 5;
	0 = [_taskMarker] call BIS_fnc_deleteTask;
	0 = GRLIB_tasksAssigned deleteAt (GRLIB_tasksAssigned find _taskMarker);
//	0 = GRLIB_tasksRunning deleteAt (GRLIB_tasksRunning find _taskMarker);
	
	diag_log "GRLIB_tasksAssigned";
	diag_log GRLIB_tasksAssigned;
	
	sleep 1;
	[_taskMarker] call F_tasks_replaceTask;
	sleep 30;
} else {
	0 = [_taskMarker] call BIS_fnc_deleteTask;
//	0 = GRLIB_tasksAssigned deleteAt (GRLIB_tasksAssigned find _taskMarker);
//	0 = GRLIB_tasksRunning deleteAt (GRLIB_tasksRunning find _taskMarker);
};

{sleep 0.1; deleteVehicle _x;} foreach _defendersAlive;
{sleep 0.1; deleteVehicle _x;} foreach _convoyDefenders;
{sleep 0.1; deleteVehicle _x;} foreach _convoyComposition;	
{sleep 0.1; deleteVehicle _x;} foreach _base_objects;
