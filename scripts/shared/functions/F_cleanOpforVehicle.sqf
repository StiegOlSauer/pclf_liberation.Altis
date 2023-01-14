params ["_veh"];

if (isNull _veh) exitWith {};

{_veh deleteVehicleCrew _x} forEach (crew _veh);
if (_veh getVariable ["GRLIB_captured", 0] == 0)  then {
    deleteVehicle _veh;
};
