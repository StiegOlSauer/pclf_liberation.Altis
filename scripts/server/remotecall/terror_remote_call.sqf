if (isServer) then {
	
	_civsAlive = {alive _x} count GRLIB_terror_civilians;
	resources_intel = resources_intel + (_civsAlive * 5);
	GRLIB_terror_enabled = false; publicVariable "GRLIB_terror_enabled";
	
	{
		deleteVehicle _x;
	} foreach GRLIB_terror_civilians;
	
	GRLIB_terror_civilians = []; publicVariable "GRLIB_terror_civilians";
};