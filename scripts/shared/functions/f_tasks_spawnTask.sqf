if (!isServer) exitWith {};
//define task type according to matrix
//put corresponding task content - name and description in a variables
//perhaps, I need separate function for this
params ["_taskMarker"];
private ["_counter","_taskMarkersArray", "_tmpName", "_tmpName2", "_arrayOfCompatTasksAndMarkers", "_taskType", "_taskTypeArray", "_tmp"];

diag_log format ["SPAWN TASK: initiated, marker is _taskMarker: %1", _taskMarker];

//generate proper city name from task marker
_taskCity = [];
_tmpName2 = [];
_taskMarkersArray = [];
_arrayOfCompatTasksAndMarkers = [];
_taskTypeArray = [];
_tmpName = toArray _taskMarker;
_tmp = "";

for [ {_i=7},{_i < (count _tmpName)},{_i=_i+1} ] do {
	_tmpName2 append [(_tmpName select _i)];
};
_taskCity = toString _tmpName2;
_counter = 0;
{
	_tmp = _x select 0;
	if (_taskMarker == _tmp) exitWith {};
	_counter = _counter + 1;
} foreach GRLIB_markerToTask;

diag_log format ["SPAWN TASK: calculated task ID _counter: %1", _counter];

//pick random task type
_arrayOfCompatTasksAndMarkers = +(GRLIB_markerToTask select _counter); 			// ["task_c_capture_67",	[0,"task_c_capture_67"], [1,"task_c_capture_67","task_c_capture_67_r1"]]
0 = _arrayOfCompatTasksAndMarkers deleteAt 0;

//then go deeper
_taskTypeArray = selectRandom _arrayOfCompatTasksAndMarkers;					// [1,"task_c_capture_67", "task_c_capture_67_r1"]
diag_log format ["SPAWN TASK: _taskTypeArray: %1", _taskTypeArray];
_taskType = _taskTypeArray deleteAt 0;											// 1
diag_log format ["SPAWN TASK: _taskType: %1", _taskType];

_taskObject = GRLIB_taskDescriptions select _taskType;
_taskDescription = _taskObject select 1;
_taskTitle = _taskObject select 2;

[WEST,_taskMarker,[_taskDescription,_taskTitle,_taskMarker],getMarkerPos _taskCity,"CREATED",1,false,"attack",false] call BIS_fnc_taskCreate;
//0          1                              2                                  3         4     5   6       7     8

//now we need to start a task, I think. Via spawn. Ensure that spawned task knows its name - it will need to delete itself on completion
switch _taskType do {
	case 0: {[_taskMarker] spawn task_banditCamp};
	case 1: {[_taskTypeArray] spawn task_roadblock};
	case 2: {[_taskTypeArray] spawn task_commarray};
	case 3: {[_taskTypeArray] spawn task_demolitions};
	case 4: {[_taskTypeArray] spawn task_wheels};
	case 5: {[_taskTypeArray] spawn task_roadblock_small};
	case 6: {[_taskTypeArray] spawn task_foodorder};
	case 7: {[_taskTypeArray] spawn task_escape};
	case 8: {[_taskTypeArray] spawn task_revenge};
	case 9: {[_taskTypeArray] spawn task_fuelwars};	
};