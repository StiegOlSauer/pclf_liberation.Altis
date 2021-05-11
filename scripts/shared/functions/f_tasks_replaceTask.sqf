if (!isServer) exitWith {};
//F_tasks_replaceTask
//define nearest fob
//pick one location which is not the location task completed for
//create new task in that location
params ["_completedTask"];
private ["_newTaskLocations", "_fob", "_fobPos", "_newTask", "_sectorMarkers", "_marker"];

//_fob = nearestObject [getMarkerPos _completedTask, FOB_typename];
_fob = [GRLIB_all_fobs,[],{(getMarkerPos _completedTask) distance _x},"ASCEND"] call BIS_fnc_sortBy;
_fobPos = _fob deleteAt 0;
_newTaskLocations = [];
diag_log format ["REPLACE TASK: replacing task for FOB: _fobPos: %1", _fobPos];

_sectorMarkers = [_fobPos] call F_tasks_getNearestMarkers;
//TODO: handle free task starvation case
diag_log format ["REPLACE TASK: replacing task with _sectorMarkers: %1", _sectorMarkers];
{
	_marker = format ["task_c_%1", _x];
	_newTaskLocations append [_marker];
} foreach _sectorMarkers;

_newTaskLocations = _newTaskLocations - GRLIB_tasksAssigned - [_completedTask];
diag_log format ["REPLACE TASK: _newTaskLocations: %1", _newTaskLocations];

_newTask = selectRandom _newTaskLocations;
diag_log format ["REPLACE TASK: replacing task with _newTask: %1", _newTask];
GRLIB_tasksAssigned append [_newTask];
0 = [_newTask] call F_tasks_spawnTask;
