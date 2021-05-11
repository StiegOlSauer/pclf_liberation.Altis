params ["_car"];
private ["_dudes"];

_dudes = crew _car;
_car lock false;
{
	_x enableAI "MOVE";
	doGetOut _x;
	[_x] join (group player);
} foreach _dudes;