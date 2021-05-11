params ["_car"];
private ["_actionID"];
_actionID = _car addAction ["<t color='#FFFF00'>" + "Acquire payload" + "</t>","scripts\client\actions\do_capture_escape.sqf","",-850,true,true,"","(vehicle player == player) && (alive _target) && ({alive _x} count (crew _target) > 0)"];

waituntil {sleep 3; count (crew _car) < 2};
_car removeAction _actionID;