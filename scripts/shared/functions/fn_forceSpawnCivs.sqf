params [ "_sector" ];
private [ "_sectorpos", "_idx", "_nbcivs", "_spread", "_spawnpos", "_grp", "_createdcivs", "_nextciv" ];

_createdcivs = [];
_battlecivs = [];
_sectorpos = getMarkerPos _sector;

_idx = 0;
_nbcivs = round (6 + (floor (random 5)));
_nbdefs = round (4 + (floor (random 3)));
_spread = 1;
_blueforGroup = grpNull;

while { _idx < _nbdefs } do {
	_spawnpos = [(((_sectorpos select 0) + (75 * _spread)) - (random (150 * _spread))),(((_sectorpos select 1) + (75 * _spread)) - (random (150 * _spread))),0];
	_grp = createGroup WEST;
	"CUP_B_GER_Soldier" createUnit [_spawnpos, _grp,"this addMPEventHandler [""MPKilled"", {_this spawn kill_manager}]; [this] call civilian_loadout;", 0.5, "private"];
	_nextciv = ((units _grp) select 0);
	_nextciv addAction ["<t color='#FFFF00'>" + localize "STR_SECONDARY_CAPTURE" + "</t>","scripts\client\actions\liberate.sqf","",-850,true,true,"","(vehicle player == player) && (GRLIB_terror_enabled)"];
	_createdcivs pushBack _nextciv;
	_basepos = getpos (leader _grp);
	
	_waypoint = _grp addWaypoint [_basepos, 150];
	_waypoint setWaypointType "MOVE";
	_waypoint setWaypointBehaviour "SAFE";
	_waypoint setWaypointSpeed "LIMITED";
	_waypoint setWaypointCombatMode "YELLOW";
	_waypoint setWaypointCompletionRadius 5;

	_waypoint = _grp addWaypoint [_basepos, 150];
	_waypoint setWaypointType "MOVE";
	_waypoint setWaypointBehaviour "SAFE";
	_waypoint setWaypointSpeed "LIMITED";
	_waypoint setWaypointCombatMode "YELLOW";
	_waypoint setWaypointCompletionRadius 5;

	_waypoint = _grp addWaypoint [_basepos, 150];
	_waypoint setWaypointType "MOVE";
	_waypoint setWaypointBehaviour "SAFE";
	_waypoint setWaypointSpeed "LIMITED";
	_waypoint setWaypointCombatMode "YELLOW";
	_waypoint setWaypointCompletionRadius 5;

	_waypoint = _grp addWaypoint [_basepos, 150];
	_waypoint setWaypointType "CYCLE";
	_waypoint setWaypointBehaviour "SAFE";
	_waypoint setWaypointSpeed "LIMITED";
	_waypoint setWaypointCombatMode "YELLOW";
	_waypoint setWaypointCompletionRadius 5;
	
	_idx = _idx + 1;
	_blueforGroup = _grp;
};

(leader _blueforGroup) setRank "COLONEL";
_allbuildings = [ nearestObjects [_sectorpos, ["House"], 150 ], { alive _x } ] call BIS_fnc_conditionalSelect;
_buildingpositions = [];
{
	_buildingpositions = _buildingpositions + ( [_x] call BIS_fnc_buildingPositions );
} foreach _allbuildings;

_idx = 0;
while { _idx < _nbcivs } do {
	_spawnpos = [(((_sectorpos select 0) + (75 * _spread)) - (random (150 * _spread))),(((_sectorpos select 1) + (75 * _spread)) - (random (150 * _spread))),0];
	_grp = createGroup CIVILIAN;
	(civilians select (floor (random (count civilians)))) createUnit [_spawnpos, _grp,"this addMPEventHandler [""MPKilled"", {_this spawn kill_manager}]", 0.5, "private"];
	_nextciv = ((units _grp) select 0);
	if ( count _buildingpositions > 0 ) then {
		_pos = _buildingpositions call BIS_fnc_selectRandom;
		_buildingpositions = _buildingpositions - [_pos];
		_nextciv setpos _pos;
	};
	
	_nextciv addAction ["<t color='#FFFF00'>" + localize "STR_SECONDARY_CAPTURE" + "</t>","scripts\client\actions\liberate.sqf","",-850,true,true,"","(vehicle player == player) && (GRLIB_terror_enabled)"];
	
	_createdcivs pushBack _nextciv;
	_nextciv disableAI "ANIM";
	_nextciv disableAI "MOVE";
	[_nextciv] joinSilent _blueforGroup;
	_idx = _idx + 1;
};
GRLIB_terror_civilians = _createdcivs;
diag_log format [ "Done Spawning civilians at %1", time ];

_createdcivs