//template for 1-phase simple mission
if (!isServer) exitWith {};

params ["_markersArray"];
private ["_taskPrefix", "_taskMarker", "_taskCity","_base_objects", "_unitToSpawn", "_defendersAlive", "_arrayOfPositions", "_ammoboxes", "_pos", "_spawnedAlready", "_prepareInProgress",
"_wpArray", "_baseLocation", "_targetVIP", "_convoyComposition", "_grpsentry", "_grpdefenders", "_convoyPath"];

_taskPrefix = "REVENGE";
_base_objects = [];
_defendersAlive = [];
_arrayOfPositions = [];
_spawnedAlready = false;
_prepareInProgress = true;
_ammoboxes = [];
_taskMarker = _markersArray deleteAt 0;
_taskCity = [_taskMarker] call BIS_fnc_taskDestination;
_baseLocation = _markersArray deleteAt 0;
_targetVIP = ObjNull;
_convoyPath = [];
GRLIB_revengeResevists = [];
GRLIB_revengeVehicles = [];
GRLIB_revengeConvoyHead = "";
GRLIB_revengeAttacked = false;
GRLIB_revengeConvoySpawnExit = false;

GRLIB_convoyRoute = 0; //0 - from start to base, 1 - wait sequence , 2 - from base to city.

GRLIB_revengeRouteTo = {
	params ["_targetVIP", "_convoyComposition", "_markersArray", "_taskMarker", "_baseLocation", "_convoyGroup", "_taskCity"];
	if (GRLIB_convoyRoute == 0) then {
		private _lead = _convoyComposition select 0;
		_lead setPos (getMarkerPos _taskMarker);
		_lead setDir (_lead getDir (getMarkerPos (_markersArray select 1)));
		private _i = 0;
		{_i = _i + 1; _x setPos (_lead modelToWorld [0, -(_i*7), 0]);_x setDir (getDir _lead);} foreach _convoyComposition;
		{_x setDamage 0} foreach _convoyComposition;				

		_convoyGroup setFormation "FILE";
		_convoyGroup setBehaviour "SAFE";
		_convoyGroup setCombatMode "GREEN";
		_convoyGroup setSpeedMode "LIMITED";
		
		while {(count (waypoints _convoyGroup)) != 0} do {deleteWaypoint ((waypoints _convoyGroup) select 0);};
		diag_log format ["REVENGE task %1 started waypoint generation",_taskMarker];
		_wpArray = [];
		{_wpArray append [(getMarkerPos _x)]} foreach _markersArray;
		diag_log format ["REVENGE task %1: waypoints generated: %2",_taskMarker, _wpArray];
		GRLIB_revengeConvoySpawnExit = true;
		sleep 3;
		GRLIB_revengeConvoySpawnExit = false;
		[_wpArray, _convoyComposition, _baseLocation] spawn GRLIB_revengeConvoyInit;

		waitUntil {sleep 3; (((_targetVIP distance (getMarkerPos _baseLocation)) < 120) && (speed (_convoyComposition select 1) == 0)) || (GRLIB_revengeAttacked)};
		
		if ((GRLIB_revengeAttacked) && (_targetVIP distance (getMarkerPos _baseLocation) > 200)) exitwith {[_targetVIP, _convoyComposition, _markersArray, _taskMarker, _baseLocation, _convoyGroup, _taskCity] spawn GRLIB_revengeAlertFar;};
		if ((GRLIB_revengeAttacked) && (_targetVIP distance (getMarkerPos _baseLocation) <= 200)) exitwith {[_targetVIP, _convoyComposition, _markersArray, _taskMarker, _baseLocation, _convoyGroup, _taskCity] spawn GRLIB_revengeAlertNear;};
		
		GRLIB_convoyRoute = 1;
		[_targetVIP, _convoyComposition, _markersArray, _taskMarker, _baseLocation, _convoyGroup, _taskCity] spawn GRLIB_revengeWait;
	};
};

GRLIB_revengeWait = {
	params ["_targetVIP", "_convoyComposition", "_markersArray", "_taskMarker", "_baseLocation", "_convoyGroup", "_taskCity"];
	if (GRLIB_convoyRoute == 1) then {
		diag_log format ["REVENGE task %1: TARGET gotta out his truck.",_taskMarker];
		_suv = _convoyComposition select 1;
		_targetVIP leaveVehicle _suv;
		while {(count (waypoints _targetVIP)) != 0} do {deleteWaypoint ((waypoints _targetVIP) select 0);};
		diag_log format ["REVENGE task %1: TARGET is moving to base.",_taskMarker];
		
		_targetVIP setBehaviour "CARELESS";
		_targetVIP setSpeedMode "LIMITED";
		_targetVIP doMove (getMarkerPos _baseLocation);
		_targetVIP setBehaviour "CARELESS";
		_targetVIP setSpeedMode "LIMITED";
		
		waitUntil {sleep 5; ((_targetVIP distance (getMarkerPos _baseLocation) < 10) || (!alive _targetVIP))};
		if (GRLIB_revengeAttacked) exitwith {[_targetVIP, _convoyComposition, _markersArray, _taskMarker, _baseLocation, _convoyGroup, _taskCity] spawn GRLIB_revengeAlertNear;};
		
		sleep 10;
		diag_log format ["REVENGE task %1: TARGET is moving to jeep.",_taskMarker];		
		
		GRLIB_revengeConvoySpawnExit = true;
		sleep 3;
		GRLIB_revengeConvoySpawnExit = false;
		
		private _pos = _markersArray select ((count _markersArray) - 1);
		private _lead = _convoyComposition select 0;
		_lead setPos (getMarkerPos _pos);
		_pos = _markersArray select ((count _markersArray) - 2);
		sleep 0.1;
		_lead setDir (_lead getDir (getMarkerPos _pos));
		private _i = 0;
		{sleep 0.1; _i = _i + 1; _x setPos (_lead modelToWorld [0, -(_i*10), 0]);_x setDir (getDir _lead);} foreach _convoyComposition;
		sleep 1;
		_targetVIP doMove (getPos _suv);
		_targetVIP setBehaviour "CARELESS";
		_targetVIP setSpeedMode "LIMITED";
		waitUntil {sleep 5; (((_targetVIP distance _suv) <= 5) || (!alive _targetVIP))};
		if (GRLIB_revengeAttacked) exitwith {[_targetVIP, _convoyComposition, _markersArray, _taskMarker, _baseLocation, _convoyGroup, _taskCity] spawn GRLIB_revengeAlertNear;};
		_targetVIP moveInCargo _suv;
		diag_log format ["REVENGE task %1: TARGET is in the jeep.",_taskMarker];
		GRLIB_convoyRoute = 2;
		[_targetVIP, _convoyComposition, _markersArray, _taskMarker, _baseLocation, _convoyGroup, _taskCity] spawn GRLIB_revengeRouteFrom;
	};
};

GRLIB_revengeRouteFrom = {
	params ["_targetVIP", "_convoyComposition", "_markersArray", "_taskMarker", "_baseLocation", "_convoyGroup", "_taskCity"];
	if (GRLIB_convoyRoute == 2) then {
		while {(count (waypoints _convoyGroup)) != 0} do {deleteWaypoint ((waypoints _convoyGroup) select 0);};
		diag_log format ["REVENGE task %1 started waypoint generation",_taskMarker];
		_tmpMarkersArray = +_markersArray;
		reverse _tmpMarkersArray;
		_wpArray = [];		
		
		{_wpArray append [(getMarkerPos _x)]} foreach _tmpMarkersArray;
		_wpArray append [_taskCity];
		diag_log format ["REVENGE task %1: waypoints generated: %2",_taskMarker, _wpArray];		
		
		[_wpArray, _convoyComposition] spawn GRLIB_revengeConvoyInit;
		waitUntil {sleep 3; ((_targetVIP distance _taskCity) < 100) || (GRLIB_revengeAttacked)};
		
		if ((GRLIB_revengeAttacked) && (_targetVIP distance (getMarkerPos _baseLocation) > 200)) exitwith {[_targetVIP, _convoyComposition, _markersArray, _taskMarker, _baseLocation, _convoyGroup, _taskCity] spawn GRLIB_revengeAlertFar;};
		if ((GRLIB_revengeAttacked) && (_targetVIP distance (getMarkerPos _baseLocation) <= 200)) exitwith {[_targetVIP, _convoyComposition, _markersArray, _taskMarker, _baseLocation, _convoyGroup, _taskCity] spawn GRLIB_revengeAlertNear;};
		
		GRLIB_convoyRoute = 0;
		[_targetVIP, _convoyComposition, _markersArray, _taskMarker, _baseLocation, _convoyGroup, _taskCity] spawn GRLIB_revengeRouteTo;
		diag_log format ["REVENGE task %1: TARGET made a full circle.",_taskMarker];
	};
};

GRLIB_revengeAlertFar = {
	params ["_targetVIP", "_convoyComposition", "_markersArray", "_taskMarker", "_baseLocation", "_convoyGroup", "_taskCity"];
	//call reinforcements from base
	//additional vehicles needed
	diag_log format ["REVENGE task %1: far alert started!",_taskMarker];
	private _alertGroup = createGroup EAST;
	{		
		if (canMove _x) then {
			diag_log format ["REVENGE task %1: remaining reservists: %2.",_taskMarker, (count GRLIB_revengeResevists)];
			if (count (crew _x) == 0) then {[_x] call F_libSpawnOpforCrew;};
			sleep 0.5;
			(crew _x) joinSilent _alertGroup;
			sleep 0.1;
			private _veh = _x;
			{if (vehicle _x == _x) then {_x MoveInCargo _veh; sleep 0.2;};} foreach GRLIB_revengeResevists;
		};		
	} foreach (GRLIB_revengeVehicles + [GRLIB_revengeConvoyHead]);
	diag_log format ["REVENGE task %1: vehicle group created - %2 - and grunts moved to cargo.",_taskMarker, GRLIB_revengeVehicles];	
	
	GRLIB_revengeConvoyHead setPos ([GRLIB_revengeConvoyHead, 8, 180 ] call BIS_fnc_relPos);
	
	while {(count (waypoints _alertGroup)) != 0} do {deleteWaypoint ((waypoints _alertGroup) select 0);};
	
	private _convoyPosition = getPos _targetVIP;
	diag_log format ["REVENGE task %1: waypoints added.",_taskMarker];
	{
		[_x, _convoyPosition] spawn {
			params ["_veh", "_convoyPosition"];
			diag_log format ["REVENGE task: internal spawn for _veh = %1.",_veh];
			_veh doMove _convoyPosition;
			(driver _veh) setBehaviour "AWARE";
			(driver _veh) setSpeedMode "FULL";
			_crew = crew _veh;			
			waitUntil {sleep 2; (((((_veh distance _convoyPosition) <= ((random 50) + 10)) && (speed _veh) < 5)) || (({!alive _x} count _crew) > 0))};
			diag_log format ["REVENGE task: vehicle %1 reached convoy location.",_veh];
			//while {(count (waypoints (driver _veh))) != 0} do {deleteWaypoint ((waypoints (driver _veh)) select 0);};
			doStop _veh;
			waitUntil {sleep 1;(speed _veh) < 5};
			private _patrolGroup = createGroup EAST;
			{
				if ((_x != gunner _veh) && (alive _x)) then {_x leaveVehicle _veh};
				[_x] joinSilent _patrolGroup;
			} foreach _crew;
			_patrolGroup setBehaviour "AWARE";
			0 = [_patrolGroup,  _convoyPosition, (random 75)] call BIS_fnc_taskPatrol;
		};
	} foreach (GRLIB_revengeVehicles + [GRLIB_revengeConvoyHead]);
	
	private _tmpReservists = [];
	{
		if (((vehicle _x) == _x) && (alive _x)) then {_tmpReservists append [_x];};
	} foreach GRLIB_revengeResevists;
	
	_z = 0;
	for [{_i=2},{_i<(count _tmpReservists)},{_i=_i+3}] do {	
		_localGrp = createGroup EAST;
		while {_z <= _i} do {
			[_tmpReservists deleteAt 0] joinSilent _localGrp;
			_z = _z + 1;			
		};
		_localGrp setBehaviour "AWARE";
		_localGrp setSpeedMode "FULL";
		0 = [_localGrp,  (getPos _targetVIP), (random 75)] call BIS_fnc_taskPatrol;
		diag_log format ["REVENGE task: meanwhile, one group will move on foot."];
	};	
};

GRLIB_revengeAlertNear = {
	params ["_targetVIP", "_convoyComposition", "_markersArray", "_taskMarker", "_baseLocation", "_convoyGroup", "_taskCity"];
	diag_log format ["REVENGE task %1: near alert started!",_taskMarker];
	//set all base garrison to patrol
	private _tmpReservists = [];
	{
		if (((vehicle _x) == _x) && (alive _x)) then {_tmpReservists append [_x];};
	} foreach GRLIB_revengeResevists;
	
	_z = 0;
	for [{_i=2},{_i<(count _tmpReservists)},{_i=_i+3}] do {
		_localGrp = createGroup EAST;
		while {_z <= _i} do {
			[_tmpReservists deleteAt 0] joinSilent _localGrp;
			_z = _z + 1;			
		};
		_localGrp setBehaviour "AWARE";
		_localGrp setSpeedMode "FULL";
		0 = [_localGrp,  (getPos _targetVIP), (random 200)] call BIS_fnc_taskPatrol;		
	};
};

diag_log format ["%1 task %2 INITIALIZATION START",_taskPrefix, _taskMarker];

while {(alive _targetVIP) || (_prepareInProgress)} do {

	sleep 2; 
	//mission is assigned - spawn it
	if ((([_taskMarker] call BIS_fnc_taskState) == "ASSIGNED") && !(_spawnedAlready)) then {
		diag_log format ["%1 task %2 ENTERED BRANCH SPAWN",_taskPrefix, _taskMarker];	
		private _baseDir = (getMarkerPos _baseLocation) getDir (getMarkerPos _taskMarker);
		
		if (_baseDir < 90) then {_baseDir = 360 + _baseDir - 90;} else {_baseDir = _baseDir - 90;};

		_base_objects = [(getMarkerPos _baseLocation), _baseDir, call (compile (preprocessFileLineNumbers "scripts\fob_templates\radarBase.sqf"))] call BIS_fnc_ObjectsMapper;
		sleep 5;

		_grpdefenders = createGroup EAST;
		{	
			if ((typeOf _x) == "VR_Area_01_square_1x1_grey_F") then {				
				_pos = getPosASL _x;
				_arrayOfPositions append [_pos];
				_unitToSpawn = opfor_squad_8_standard call bis_fnc_selectrandom;				
				deleteVehicle _x;
				_unitToSpawn createUnit [_pos, _grpdefenders,"this addMPEventHandler [""MPKilled"", {_this spawn kill_manager}]", 0.5, "private"];				
				sleep 0.5;
			};
			
			if ((typeOf _x) == "Box_East_Wps_F") then {
				clearWeaponCargoGlobal _x;
				clearMagazineCargoGlobal _x;
				clearItemCargoGlobal _x;
				clearBackpackCargoGlobal _x;
				_x addMPEventHandler ['MPKilled', {_this spawn kill_manager}];
				_ammoboxes = _ammoboxes + [_x];
			};
			
			if ((typeOf _x) == "rhsusf_m113d_usarmy") then {
				_x addMPEventHandler ['MPKilled', {_this spawn kill_manager}];
				[_x] call F_libSpawnOpforCrew;
				GRLIB_revengeConvoyHead = _x;				
			};
			
			if (((typeOf _x) == "rhsusf_m998_d_s_2dr_fulltop") || ((typeOf _x) == "rhsusf_m1025_d_s_Mk19")) then {
				_x addMPEventHandler ['MPKilled', {_this spawn kill_manager}];				
				GRLIB_revengeVehicles append [_x];
			};
		} foreach _base_objects;
		
		_grpdefenders setBehaviour "SAFE";
//		_grpdefenders spawn {waitUntil {sleep 5; {!(alive _x)} count (units _this) > 0}; _this setBehaviour "COMBAT";};

		[units _grpdefenders] call F_loadouts_swapOpfor;
		{
			_defendersAlive = _defendersAlive + [_x];			
			if ((count _arrayOfPositions) > 0) then {
				_x setPosASL (_arrayOfPositions select 0);
				_arrayOfPositions deleteAt 0;
				_x DisableAI "MOVE";
				[_x] spawn {
					params ["_unit"];
					waitUntil {sleep 4; ((GRLIB_revengeAttacked) || (({!alive _x} count GRLIB_revengeResevists) > 0))};
					_unit enableAI "MOVE";
				};
			};
			GRLIB_revengeResevists append [_x];
		} foreach (units _grpdefenders);
		
		sleep 1;
		{ _x setDamage 0; } foreach (_base_objects);
		_base_objects = _base_objects - _ammoboxes;
		
		_grpsentry = createGroup EAST;
		private _patrolPos = (getMarkerPos _baseLocation) findEmptyPosition [25,100];
		
		for [ {_idx=0},{_idx < 4},{_idx=_idx+1} ] do {
			_unitToSpawn = opfor_squad_8_infkillers call bis_fnc_selectrandom;
			_unitToSpawn createUnit [_patrolPos, _grpsentry,"this addMPEventHandler [""MPKilled"", {_this spawn kill_manager}]", 0.5, "private"];
			sleep 0.5;
		};		
		
		[units _grpsentry] call F_loadouts_swapOpfor;
		
		0 = [_grpsentry,  (getMarkerPos _baseLocation), 50] call BIS_fnc_taskPatrol;
		_defendersAlive = _defendersAlive + (units _grpsentry);
		
		private _scoutConvoy = [[getMarkerPos _taskMarker, 10, 0 ] call BIS_fnc_relPos, "rhsusf_m1025_d_s_m2", true, false, false ] call F_libSpawnVehicle;
		sleep 0.5;		
		private _suvConvoy = [[ getMarkerPos _taskMarker, 10, 180 ] call BIS_fnc_relPos, "CUP_I_SUV_Armored_ION", true, false, false ] call F_libSpawnVehicle;
		sleep 0.5;
		private _tailConvoy = [[ getMarkerPos _taskMarker, 30, 180 ] call BIS_fnc_relPos, "rhsusf_m998_d_s_2dr", true, false, false ] call F_libSpawnVehicle;
		sleep 0.5;
		
		private _convoyGroup = group driver _scoutConvoy;
		(crew _scoutConvoy + crew _suvConvoy + crew _tailConvoy) joinSilent _convoyGroup;
		
		diag_log format ["REVENGE task %1 formed convoy group: %2",_taskMarker, (units _convoyGroup)];
		
		private _targetGroup = createGroup EAST;
		
		"LOP_SLA_Infantry_Officer" createUnit [getMarkerPos _taskMarker, _targetGroup,"this addMPEventHandler [""MPKilled"", {_this spawn kill_manager; GRLIB_revengeAttacked = true;}]", 0.5, "private"];
		_targetVIP = (units _targetGroup) select 0;
		
		[_targetVIP] call opfor_general_loadout;
		_targetVIP moveInCargo _suvConvoy;
		
		private _troopsGroup = createGroup EAST;
		{ _x createUnit [getMarkerPos _taskMarker, _troopsGroup,"this addMPEventHandler [""MPKilled"", {_this spawn kill_manager; GRLIB_revengeAttacked = true;}]", 0.5, "private"]; } foreach ([] call F_getAdaptiveSquadComp);
		sleep 1;
		[units _troopsGroup] call F_loadouts_swapOpfor;
		sleep 1;
		{
			_x moveInCargo _tailConvoy;
			sleep 0.2;
			if (vehicle _x == _x) then {_x moveInCargo _scoutConvoy;};
			sleep 0.2;
			if (vehicle _x == _x) then {deleteVehicle _x;};
		} foreach (units _troopsGroup);
		
		diag_log format ["REVENGE task %1 spawned armed grunts",_taskMarker];
		_convoyComposition = [_scoutConvoy, _suvConvoy, _tailConvoy];
		_convoyDefenders = (units _convoyGroup) + (units _troopsGroup);
		
		GRLIB_convoyRoute = 0;
		[_targetVIP, _convoyComposition, _markersArray, _taskMarker, _baseLocation, _convoyGroup, _taskCity] spawn GRLIB_revengeRouteTo;
		
		diag_log format ["REVENGE task %1: convoy initialized",_taskMarker];
		
		//create waypoint markers for players		
		{
			private _mrk = createMarker [format ["markername_%1", (floor (random 500))],(getMarkerPos _x)];
			_mrk setMarkerShape "ICON";
			_mrk setMarkerType "hd_dot";
			_mrk setMarkerColor "ColorRed";
			_convoyPath append [_mrk];
		} foreach _markersArray;
		
		_spawnedAlready = true;
		_prepareInProgress = false;
		0 = [_taskMarker, getMarkerPos _baseLocation] call BIS_fnc_taskSetDestination;
		//add new description
		0 = [_taskMarker, ["Our target is OPFOR officer which travels between town and military installation marked on map in heavily guarded convoy. Our source marked approximate route of the convoy on map. Target will move from town to base, possibly disembark there and return to the city with convoy. Since the inspection is onoging, target will make this route several times, so we have enough time for reconnaissance.<br>Possible execution methods are:<br>1) ambush convoy on the road;<br>2) snipe disembarked target near the base;<br>3) infiltrate the base and 'meet' the target there;<br>4) any other possible way.", "Revenge!", "Revenge!"]] call BIS_fnc_taskSetDescription;
		0 = [_taskMarker, "ASSIGNED",false] spawn BIS_fnc_taskSetState;
	};
	
	//mission was spawned, but then unassigned - cleanup and restore starting state
	if ((_spawnedAlready) && !(([_taskMarker] call BIS_fnc_taskState) == "ASSIGNED")) then {		
		diag_log format ["%1 task %2 ENTERED BRANCH CLEANUP",_taskPrefix, _taskMarker];		
		
		GRLIB_revengeAttacked = false;
		GRLIB_revengeConvoySpawnExit = false;
		GRLIB_convoyRoute = 0;
		//need to return marker back
		_prepareInProgress = true;
		_spawnedAlready = false;
		
		{sleep 0.1; deleteVehicle _x;} foreach _base_objects;
		{sleep 0.1; deleteVehicle _x;} foreach _defendersAlive;
		{
			{deleteVehicle _x;} foreach (crew _x);
			sleep 0.1;
			deleteVehicle _x;
		} foreach _convoyComposition;
		
		{deleteMarker _x;} foreach _convoyPath;
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
	
	diag_log format ["%1 task %2 SUCCEEDED. AAR: GRLIB_tasksAssigned: %3",_taskPrefix, _taskMarker, GRLIB_tasksAssigned];
	
	sleep 1;
	[_taskMarker] call F_tasks_replaceTask;
	sleep 30;
} else {
	0 = [_taskMarker] call BIS_fnc_deleteTask;
};
GRLIB_revengeAttacked = false;
GRLIB_revengeConvoySpawnExit = false;
GRLIB_convoyRoute = 0;

{deleteMarker _x;} foreach _convoyPath;

private _cycles = 0;
while {_cycles <= 20} do {
	sleep 60;
	{
		if (_x distance (getMarkerPos _baseLocation) < 500) then {_cycles = 0;};
	} foreach (allPlayers - entities "HeadlessClient_F");
	_cycles = _cycles + 1;
};
{sleep 0.1; deleteVehicle _x;} foreach _base_objects;
{sleep 0.1; deleteVehicle _x;} foreach _defendersAlive;
{
	{deleteVehicle _x;} foreach (crew _x);
	sleep 0.1;
	deleteVehicle _x;
} foreach _convoyComposition;