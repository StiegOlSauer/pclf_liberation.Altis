private ["_veh", "_vehsArray","_count", "_crew"];

_vehsArray = [];
_count = 0;
{_vehsArray append [_x select 0];} foreach heavy_vehicles;

{
	if ((typeOf _x) in _vehsArray) then {
		_crew = crew _x;
		if (side (_crew select 0) == WEST) then {_count = _count + 1;};
	};
} foreach vehicles;

_veh = selectRandom militia_heavy_vehicles;

if (_count == 0) then {_veh = selectRandom militia_vehicles;};

_veh
