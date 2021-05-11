// maxspeed.sqf 
// MARCH 2010 - norrin
// September 2016 - Operator
params ["_vcl", "_convoyArray", "_c"];
private ["_count", "_vcl2", "_vcl3"];
//_vcl 			= _this select 0;
//_convoyArray	= _this select 1;
//_c 				= _this select 2;
_count 			= count _convoyArray;
_vcl2 			= objNull;
_vcl3 			= objNull; 
if (_c < (_count -2)) then {_vcl2 = _convoyArray select (_c + 1)};
if (_c > 0) then {_vcl3 = _convoyArray select (_c - 1)};    		
//if (true)exitWith {};
while {(canMove _vcl)} do
{	
	if (!isNull _vcl2) then
	{	
		if (speed _vcl > 40) then 
		{	
			_vcl setVelocity [(11 * (sin getDir _vcl)), (11 * (cos getDir _vcl)), velocity _vcl select 2];
		};
		while {((_vcl distance _vcl2 > 50) && !(GRLIB_revengeConvoySpawnExit))} do 
		{	
			_dir = getDir _vcl;
			if (_vcl distance _vcl2 <= 80) then 
			{
				if (((sin _dir) * (velocity _vcl select 0)) > 3) then {_vcl setVelocity [(velocity _vcl select 0) - (1 * (sin _dir)), (velocity _vcl select 1), velocity _vcl select 2]};
				if (((cos _dir) * (velocity _vcl select 1)) > 3) then {_vcl setVelocity [(velocity _vcl select 0), (velocity _vcl select 1) - (1 * (cos _dir)), velocity _vcl select 2]};
			} else {
				if (((sin _dir) * (velocity _vcl select 0)) > 1) then {_vcl setVelocity [(velocity _vcl select 0) - (2 * (sin _dir)), (velocity _vcl select 1), velocity _vcl select 2]};
				if (((cos _dir) * (velocity _vcl select 1)) > 1) then {_vcl setVelocity [(velocity _vcl select 0), (velocity _vcl select 1) - (2 * (cos _dir)), velocity _vcl select 2]};
			};
			sleep 0.1;
		};		
	};
	if (!isNull _vcl3) then
	{
		while {((_vcl distance _vcl3 < 30) && !(GRLIB_revengeConvoySpawnExit))} do 
		{	
			_dir = getDir _vcl;
			if (((sin _dir) * (velocity _vcl select 0)) > 1) then {_vcl setVelocity [(velocity _vcl select 0) - (2 * (sin _dir)), (velocity _vcl select 1), velocity _vcl select 2]};
			if (((cos _dir) * (velocity _vcl select 1)) > 1) then {_vcl setVelocity [(velocity _vcl select 0), (velocity _vcl select 1) - (2 * (cos _dir)), velocity _vcl select 2]};
			sleep 0.1;
		};		
	};
	sleep 0.1;
	if ((GRLIB_revengeAttacked) || (GRLIB_revengeConvoySpawnExit)) exitWith {diag_log "REVENGE: vehicle exited from convoy script.";};
};
//diag_log "REVENGE: vehicle exited from convoy script.";