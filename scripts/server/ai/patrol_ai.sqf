params ["_grp"];
private ["_waypoint", "_patrol_startpos", "_sectors_patrol"];

if ( isNil "reinforcements_sector_under_attack" ) then { reinforcements_sector_under_attack = locationNull };

while { count (units _grp) > 0 } do {
	if ( reinforcements_sector_under_attack != "" ) then {

		while {(count (waypoints _grp)) != 0} do {deleteWaypoint ((waypoints _grp) select 0);};
		{_x doFollow leader _grp} foreach units _grp;

		_waypoint = _grp addWaypoint [position reinforcements_sector_under_attack, 50];
		_waypoint setWaypointType "MOVE";
		_waypoint setWaypointSpeed "FULL";
		_waypoint setWaypointBehaviour "AWARE";
		_waypoint setWaypointCombatMode "GREEN";
		_waypoint setWaypointCompletionRadius 30;
		_waypoint = _grp addWaypoint [position reinforcements_sector_under_attack, 50];
		_waypoint setWaypointSpeed "LIMITED";
		_waypoint setWaypointType "SAD";
		_waypoint = _grp addWaypoint [position reinforcements_sector_under_attack, 50];
		_waypoint setWaypointSpeed "LIMITED";
		_waypoint setWaypointType "SAD";
		_waypoint = _grp addWaypoint [position reinforcements_sector_under_attack, 50];
		_waypoint setWaypointSpeed "LIMITED";
		_waypoint setWaypointType "CYCLE";

		sleep 300;
	};

	if ( name reinforcements_sector_under_attack == "" ) then {
		_patrol_startpos = getpos (leader _grp);
		_sectors_patrol = [_patrol_startpos, GRLIB_side_enemy, "any", 2500] call LP_getLocations;

		while {(count (waypoints _grp)) != 0} do {deleteWaypoint ((waypoints _grp) select 0);};
		{_x doFollow leader _grp} foreach units _grp;

		{
			_waypoint = _grp addWaypoint [position _x, 300];
			_waypoint setWaypointType "MOVE";
			_waypoint setWaypointSpeed "NORMAL";
			_waypoint setWaypointBehaviour "AWARE";
			_waypoint setWaypointCombatMode "GREEN";
			_waypoint setWaypointCompletionRadius 30;
		} foreach _sectors_patrol;

		_waypoint = _grp addWaypoint [_patrol_startpos, 300];
		_waypoint setWaypointType "MOVE";
		_waypoint setWaypointCompletionRadius 100;
		_waypoint = _grp addWaypoint [_patrol_startpos , 300];
		_waypoint setWaypointType "CYCLE";
	};

	waitUntil { sleep 5;(count (units _grp) == 0) || (name reinforcements_sector_under_attack != "") };
};
