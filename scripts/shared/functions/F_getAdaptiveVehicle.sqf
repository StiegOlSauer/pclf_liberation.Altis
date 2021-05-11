private ["_vehicle_to_spawn", "_veh", "_vehsArray","_count", "_crew"];

_vehsArray = [];
_count = 0;
{_vehsArray append [_x select 0];} foreach heavy_vehicles;

{
	if ((typeOf _x) in _vehsArray) then {
		_crew = crew _x;
		if (side (_crew select 0) == WEST) then {_count = _count + 1;};
	};
} foreach vehicles;

_vehicle_to_spawn = opfor_vehicles call BIS_fnc_selectRandom;
if ((combat_readiness < 50) || (_count == 0)) then {
	_vehicle_to_spawn = opfor_vehicles_low_intensity call BIS_fnc_selectRandom;
};

_vehicle_to_spawn;
