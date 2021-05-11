/*
//["AddCargoByClass", [<item classname string>, <vehicle object>, <amount number, default 1>]] call ace_common_fnc_localEvent
1. choose correct sector for terror attack: sectors_allSectors - _select 0 - sectors_tower
2. Choose opfor spawn point
3. Create opfor group (2*10): Officer + SL + riflemans + sentry + AR; Create transports: 2*Kamaz (need to check whether they will be deleted)
4. set opfor waypoints: unload and scripted one which will send units to search buildings
5. create civs, place in buildings, make them captive
6. create defenders from blufor, set loadouts, make patrol
7. play notification
8. mission ends either when all civs dead or when all soldiers.
*/
//_liberatedSector = _this select 0;
_liberatedSector = (blufor_sectors - sectors_bigtown - sectors_tower - sectors_military) call BIS_fnc_selectRandom;
_possibleSectors = [];
_bestCandidate = "";
GRLIB_terror_enabled = true;
GRLIB_terror_civilians = [];

{
	if (((markerpos _x) distance (markerpos _liberatedSector)) > 1000 ) then {
		_possibleSectors = _possibleSectors + [_x];
	};
} foreach (blufor_sectors - [_liberatedSector] - sectors_bigtown - sectors_tower - sectors_military);

_bestCandidate = _possibleSectors select 0;

{	
	_testedSector = _x;
	{		
		_reference = (markerpos _bestCandidate) distance (markerpos _x);
		if (((markerpos _x) distance (markerpos _testedSector)) < _reference) then {
			_bestCandidate = _testedSector;
		};
	} foreach sectors_opfor;
} foreach _possibleSectors;

diag_log (format ["best candidate = %1", _bestCandidate]);
diag_log (format ["possible Sectors = %1", _possibleSectors]);
if (_bestCandidate == "") exitwith {diag_log "Could not find terror position"; };

_spawn_marker = [_bestCandidate, 1000] call F_findNearestOpforSpawnPoint;
if ( _spawn_marker == "" ) exitWith { diag_log "Could not find position for spawning terror squad mission"; };

[ [ _bestCandidate ] , "remote_call_terror" ] call BIS_fnc_MP;

diag_log (format ["spawn marker = %1", _spawn_marker]);

_spawnSquad = [opfor_officer, opfor_squad_leader, opfor_rifleman, opfor_rifleman, opfor_grenadier, opfor_sentry, opfor_sentry, opfor_sharpshooter, opfor_medic, opfor_machinegunner, opfor_grenadier, opfor_sentry, opfor_machinegunner];

//O_Truck_02_covered_F
_spawnpos = [];
_spawnpos =  ( [ (markerpos _spawn_marker), random 150, random 360 ] call bis_fnc_relpos ) findEmptyPosition [10, 150, 'B_Heli_Transport_01_F'];

_allcivs = [_bestCandidate] spawn fn_forceSpawnCivs;

//if ((count _allcivs) > 0) then {GRLIB_terror_civilians = _allcivs};
//GRLIB_terror_civilians = _allcivs;

_vhc1 = "O_Truck_02_covered_F" createVehicle _spawnpos;
_vhc2 = "O_Truck_02_covered_F" createVehicle _spawnpos;

{
	_x allowdamage false;
	clearWeaponCargoGlobal _x;
	clearMagazineCargoGlobal _x;
	clearItemCargoGlobal _x;
	clearBackpackCargoGlobal _x;
	
	[ _x ] call F_libSpawnOpforCrew;
	sleep 0.1;
	_veh = _x;
	{ _x addMPEventHandler ['MPKilled', {_this spawn kill_manager}]; } foreach (crew _veh);	
	_x addMPEventHandler ['MPKilled', {_this spawn kill_manager}];
	
	sleep 0.1;
	_x allowdamage true;
	_x setdamage 0;
} foreach [_vhc1, _vhc2];

_transportGroup1 = group (driver _vhc1);
_transportGroup2 = group (driver _vhc2);

_grp1 = createGroup EAST;
_grp2 = createGroup EAST;

{
	_currentGrp = _x;
	{	
		_x createUnit [_spawnpos, _currentGrp,"this addMPEventHandler [""MPKilled"", {_this spawn kill_manager}]", 0.5, "private"];
	} foreach (_spawnSquad);	
	while {(count (waypoints _x)) != 0} do {deleteWaypoint ((waypoints _x) select 0);};
} foreach [_grp1, _grp2];

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
} foreach ((units _grp1) + (units _grp2));

{ _x moveInCargo _vhc1 } foreach (units _grp1);
{ _x moveInCargo _vhc2 } foreach (units _grp2);

sleep 3;

diag_log (format ["_transportGroup1 = %1", _transportGroup1]);
diag_log (format ["_transportGroup2 = %1", _transportGroup2]);

{		
	while {(count (waypoints _x)) != 0} do {deleteWaypoint ((waypoints _x) select 0);};
} foreach [_transportGroup1, _transportGroup2];

/*_transport_waypoint01 =  _transportGroup1 addWaypoint [(markerpos _bestCandidate), 0];
_transport_waypoint01 setWaypointType "MOVE";
_transport_waypoint01 setWaypointCompletionRadius 1;

_transport_waypoint02 =  _transportGroup2 addWaypoint [(markerpos _bestCandidate), 0];
_transport_waypoint02 setWaypointType "MOVE";
_transport_waypoint02 setWaypointCompletionRadius 1;
*/

(leader _transportGroup1) doMove (markerpos _bestCandidate);
(leader _transportGroup2) doMove (markerpos _bestCandidate);

[_vhc1, _bestCandidate, _transportGroup1, _grp1] spawn {
	_vehToCheck = _this select 0;
	_bestCandidate = _this select 1;
	_transportGroup1 = _this select 2;
	_grp1 = _this select 3;
	while {(alive _vehToCheck) && (alive (driver _vehToCheck)) && (_vehToCheck distance (markerpos _bestCandidate)) > 300} do {
		(leader _transportGroup1) doMove (markerpos _bestCandidate);
		sleep 5;
	};
	
	while {(count (waypoints _transportGroup1)) != 0} do {deleteWaypoint ((waypoints _transportGroup1) select 0);};
	_transport_waypoint1 =  _transportGroup1 addWaypoint [(getpos _vehToCheck), 0];
	_transport_waypoint1 setWaypointType "TR UNLOAD";
	_transport_waypoint1 setWaypointCompletionRadius 10;
	
	{
		unassignvehicle _x;
		_x action ["EJECT", vehicle _x];
		sleep 0.5;
	} foreach (units _grp1);
	_tmp = driver _vehToCheck;
	waituntil {sleep 1; count (crew _vehToCheck) <= 1};
	deleteVehicle _vehToCheck;
	deleteVehicle _tmp;
	
	_grp1_waypoint2 = _grp1 addWaypoint [(markerpos _bestCandidate), 10];
	_grp1_waypoint2 setWaypointType "MOVE";
	_grp1_waypoint2 setWaypointSpeed "NORMAL";
	_grp1_waypoint2 setWaypointBehaviour "AWARE";
	_grp1_waypoint2 setWaypointCombatMode "YELLOW";
	
	while {alive (leader _grp1) && ((leader _grp1) distance (markerpos _bestCandidate) < 25)} do {
		sleep 10;
		if (count (waypoints _grp1) == 0) then {[_grp1, 200] call fn_searchBuilding;};
	};
};

[_vhc2, _bestCandidate, _transportGroup2, _grp2] spawn {
	_vehToCheck = _this select 0;
	_bestCandidate = _this select 1;
	_transportGroup2 = _this select 2;
	_grp2 = _this select 3;
/*	waitUntil { sleep 1;
	(!(alive _vehToCheck)
	|| !(alive (driver _vehToCheck))
	|| ((_vehToCheck distance (markerpos _bestCandidate))) < 150);};*/
	
	while {(alive _vehToCheck) && (alive (driver _vehToCheck)) && (_vehToCheck distance (markerpos _bestCandidate)) > 300} do {
		(leader _transportGroup2) doMove (markerpos _bestCandidate);
		sleep 5;
	};

	while {(count (waypoints _transportGroup2)) != 0} do {deleteWaypoint ((waypoints _transportGroup2) select 0);};	
	_transport_waypoint2 =  _transportGroup2 addWaypoint [(getPos _vehToCheck), 0];
	_transport_waypoint2 setWaypointType "TR UNLOAD";
	_transport_waypoint2 setWaypointCompletionRadius 10;
	
	{
		unassignvehicle _x;
		_x action ["EJECT", vehicle _x];
		sleep 0.5;
	} foreach (units _grp2);
	_tmp = driver _vehToCheck;
	waituntil {sleep 1; count (crew _vehToCheck) <= 1};
	deleteVehicle _vehToCheck;
	deleteVehicle _tmp;
	
	_grp2_waypoint2 = _grp2 addWaypoint [(markerpos _bestCandidate), 10];
	_grp2_waypoint2 setWaypointType "MOVE";
	_grp2_waypoint2 setWaypointSpeed "NORMAL";
	_grp2_waypoint2 setWaypointBehaviour "AWARE";
	_grp2_waypoint2 setWaypointCombatMode "YELLOW";
	
	while {alive (leader _grp2) && ((leader _grp2) distance (markerpos _bestCandidate) < 25)} do {
		sleep 10;
		if (count (waypoints _grp2) == 0) then {[_grp2, 200] call fn_searchBuilding;};
	};
};

//waitUntil { sleep 0.5; (!(alive _vhc1) || !(alive _vhc2)) || (!(alive (driver _vhc1)) || !(alive (driver _vhc2))) || ((((_vhc1 distance (markerpos _bestCandidate)) < 300)) || (((_vhc2 distance (markerpos _bestCandidate)) < 300)))};
/*{		
	while {(count (waypoints _x)) != 0} do {deleteWaypoint ((waypoints _x) select 0);};
} foreach [_transportGroup1, _transportGroup2];

_transport_waypoint1 =  _transportGroup1 addWaypoint [(getpos _vhc1), 0];
_transport_waypoint1 setWaypointType "TR UNLOAD";
_transport_waypoint1 setWaypointCompletionRadius 10;

_transport_waypoint2 =  _transportGroup2 addWaypoint [(getPos _vhc2), 0];
_transport_waypoint2 setWaypointType "TR UNLOAD";
_transport_waypoint2 setWaypointCompletionRadius 10;


{
	unassignvehicle _x;
	_x action ["EJECT", vehicle _x];
	sleep 0.5;
}foreach ((units _grp1) + (units _grp2));

{		
	deleteVehicle (vehicle (leader _x));
} foreach [_transportGroup1, _transportGroup2];
*/
/*_grp1_waypoint1 = _grp1 addWaypoint [(getpos _vhc1), 0];
_grp1_waypoint1 setWaypointType "GETOUT";
_grp1_waypoint1 setWaypointCompletionRadius 10;

_grp2_waypoint1 = _grp2 addWaypoint [(getpos _vhc2), 0];
_grp2_waypoint1 setWaypointType "GETOUT";
_grp2_waypoint1 setWaypointCompletionRadius 10;

diag_log (format ["Waypoints _grp1 = %1", waypoints _grp1]);
diag_log (format ["Waypoints _grp2 = %1", waypoints _grp2]);

_grp1_waypoint2 = _grp1 addWaypoint [(markerpos _bestCandidate), 5];
_grp2_waypoint2 = _grp2 addWaypoint [(markerpos _bestCandidate), 5];

{
	_x setWaypointType "MOVE";
	_x setWaypointSpeed "NORMAL";
	_x setWaypointBehaviour "AWARE";
	_x setWaypointCombatMode "YELLOW";
} foreach [_grp1_waypoint2, _grp2_waypoint2];
*/
diag_log (format ["Waypoints _grp1 = %1", waypoints _grp1]);
diag_log (format ["Waypoints _grp2 = %1", waypoints _grp2]);



/*waitUntil { sleep 1; (!(isNull _grp1) || !(isNull _grp2)) || ((((leader _grp1 distance (markerpos _bestCandidate)) < 30)) && (((leader _grp2 distance (markerpos _bestCandidate)) < 30)))};

{		
	while {(count (waypoints _x)) != 0} do {deleteWaypoint ((waypoints _x) select 0);};
} foreach [_grp1, _grp2];

while {alive (leader _grp1) && alive (leader _grp2)} do {
	sleep 10;
	{
		if (count (waypoints _x) == 0) then {[_x, 200] call fn_searchBuilding;};		
	} foreach [_grp1, _grp2]
};
*/