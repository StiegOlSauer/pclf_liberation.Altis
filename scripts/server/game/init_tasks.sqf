if (!isServer) exitWith {};
waitUntil { time > 1 };
waitUntil { !isNil "GRLIB_all_fobs" };
waitUntil { !isNil "save_is_loaded" };

if ( count GRLIB_all_fobs > 0 ) then {
	{
		_taskMarkers = [];
		_sectorMarkers = [_x] call F_tasks_getNearestMarkers;
		_sectorMarkers resize 5;
		{
			_marker = format ["task_c_%1", _x];
			_taskMarkers = _taskMarkers + [_marker];
		} foreach _sectorMarkers;		

		{
			_nil = [_x] call F_tasks_spawnTask;
			GRLIB_tasksAssigned = GRLIB_tasksAssigned + [_x];			
			sleep 2;
		} foreach _taskMarkers;
	} foreach GRLIB_all_fobs;
};

"GRLIB_addUnitTask" addPublicVariableEventHandler {
	_addUnitTask = _this select 1;
	_unit = _addUnitTask select 0;
	_task = _addUnitTask select 1;
	
	diag_log format ["EVENTHANDLER. Input parameters: %1, Parsed unit: %2, parsed task: %3",_addUnitTask, _unit, _task];
	_i = 0;
	_added = false;
	{
		if (((_x select 0) == _unit) && ((_x select 1) != _task)) then {
			GRLIB_unitToTaskPool deleteAt _i;
			GRLIB_unitToTaskPool append [[_unit,_task]];
			_added = true;
		};
		if (!(alive (_x select 0))) then {
			GRLIB_unitToTaskPool deleteAt _i;
		};
		_i = _i + 1;
	} foreach GRLIB_unitToTaskPool;

	if !(_added) then {GRLIB_unitToTaskPool append [[_unit,_task]]};
	
	_taskPopularityArray = [];
	{
		_taskPopularityArray append [(_x select 1)];
		diag_log format ["Unit has task %1", _x];
	} foreach GRLIB_unitToTaskPool;
	
	_max = 0;
	_current = 0;
	_topTask = "";
	_i = 0;
	{
		_current = {_x == (GRLIB_tasksAssigned select _i)} count _taskPopularityArray;
		if (_current >= _max) then {
			_topTask = (GRLIB_tasksAssigned select _i);
			_max = _current;
		};
		_i = _i + 1;
	} foreach GRLIB_tasksAssigned;
	diag_log format ["EVENTHANDLER. Top task: %1",_topTask];
	
	if (!(([_topTask] call BIS_fnc_taskState) == "ASSIGNED")) then {
		{[_x, "CREATED", false] call BIS_fnc_taskSetState} foreach GRLIB_tasksAssigned;
		[_topTask] call BIS_fnc_taskSetCurrent;
	};
	
	_z = "";
	{
		_z = [_x] call bis_fnc_taskState;
		diag_log format ["task %1 is in state: %2",_x, _z];
	} foreach GRLIB_tasksAssigned;
};