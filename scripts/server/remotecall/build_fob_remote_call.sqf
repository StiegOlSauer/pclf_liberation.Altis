if (!isServer) exitWith {};

params [ "_new_fob", "_create_fob_building" ];
private [ "_fob_building", "_fob_pos", "_sectorMarkers", "_taskMarkers", "_marker", "_tmpTasksArray", "_count"];

GRLIB_all_fobs pushback _new_fob;
publicVariable "GRLIB_all_fobs";

if ( _create_fob_building ) then {
	_fob_pos = [ (_new_fob select 0) + 15, (_new_fob select 1) + 2, 0 ];
	_fob_building = FOB_typename createVehicle _fob_pos;
	_fob_building setpos _fob_pos;
	_fob_building setVectorUp [0,0,1];
	sleep 1;
};

please_recalculate = true;
trigger_server_save = true;

sleep 3;
[ [ _new_fob, 0 ] , "remote_call_fob" ] call BIS_fnc_MP;

//do cleanup!
_count = (count GRLIB_all_fobs) * 5;
_tmpTasksArray = [];
_tmpTasksArray = +GRLIB_tasksAssigned;

_taskMarkers = [];
diag_log format ["FOB REPACKAGE: BEFORE ASSIGNED TASKS: %1",GRLIB_tasksAssigned];
{
	_sectorMarkers = [_x] call F_tasks_getNearestMarkers;	
	{
		_marker = format ["task_c_%1", _x];
		if (!(_marker in GRLIB_tasksCompleted)) then {
			_taskMarkers append [_marker];
		};
	} foreach _sectorMarkers;
} foreach GRLIB_all_fobs;
//TODO: handle cases when tasks amount is less that FOBs*5 - obviously, do not resize marker to 5, but use returned raw value instead
_taskMarkers resize _count;
diag_log format ["FOB REPACKAGE: TASK MARKERS: %1",_taskMarkers];
GRLIB_tasksAssigned = GRLIB_tasksAssigned + (_taskMarkers - _tmpTasksArray) - (_tmpTasksArray - _taskMarkers);

{
	if (!(_x in _tmpTasksArray)) then {
		diag_log format ["FOB REPACKAGE: Starting spawn tasks routine for %1",_x];
		_nil = [_x] call F_tasks_spawnTask;
	};
	sleep 0.1;
} foreach _taskMarkers;

diag_log format ["FOB REPACKAGE: FINAL GRLIB_tasksAssigned: %1",GRLIB_tasksAssigned];

stats_fobs_built = stats_fobs_built + 1;