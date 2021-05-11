params ["_base_objects", "_isMilitia"];
private ["_grpdefenders", "_grpsentry"];

_grpdefenders = createGroup EAST;
{	
	if ((typeOf _x) == "VR_Area_01_square_1x1_grey_F") then {				
		_pos = getPosASL _x;
		_arrayOfPositions append [_pos];
		_unitToSpawn = opfor_squad_8_standard call bis_fnc_selectrandom;
		if (_isMilitia) then {_unitToSpawn = militia_squad call bis_fnc_selectrandom;};
		deleteVehicle _x;
		_unitToSpawn createUnit [_pos, _grpdefenders,"this addMPEventHandler [""MPKilled"", {_this spawn kill_manager}]", 0.5, "private"];
		sleep 0.5;
	};
	
	if ((typeOf _x) == "Box_East_Wps_F") then {
		clearWeaponCargoGlobal _x;
		clearMagazineCargoGlobal _x;
		clearItemCargoGlobal _x;
		clearBackpackCargoGlobal _x;
		_x addMPEventHandler ['MPKilled', {_this spawn kill_manager}];
		_ammoboxes = _ammoboxes + [_x];
	};
} foreach _base_objects;

_grpdefenders setBehaviour "SAFE";
_grpdefenders spawn {waitUntil {sleep 5; {!(alive _x)} count (units _this) > 0}; _this setBehaviour "COMBAT";};

if (!_isMilitia) then {[units _grpdefenders] call F_loadouts_swapOpfor;};

{
	_defendersAlive = _defendersAlive + [_x];			
	if ((count _arrayOfPositions) > 0) then {
		_x setPosASL (_arrayOfPositions select 0);
		_arrayOfPositions deleteAt 0;
		_x DisableAI "MOVE";
		if (_isMilitia) then {[_x] call ( militia_standard_squad call BIS_fnc_selectRandom );};
	};			
} foreach (units _grpdefenders);

sleep 1;
{ _x setDamage 0; } foreach (_base_objects);
_base_objects = _base_objects - _ammoboxes;

_grpsentry = createGroup EAST;
private _patrolPos = (getPos (selectRandom _base_objects)) findEmptyPosition [25,100];

for [ {_idx=0},{_idx < 4},{_idx=_idx+1} ] do {
	_unitToSpawn = opfor_squad_8_infkillers call bis_fnc_selectrandom;
	if (_isMilitia) then {_unitToSpawn = militia_squad call bis_fnc_selectrandom;};
	_unitToSpawn createUnit [_patrolPos, _grpsentry,"this addMPEventHandler [""MPKilled"", {_this spawn kill_manager}]", 0.5, "private"];
	sleep 0.5;
};		

if (!_isMilitia) then {
	[units _grpsentry] call F_loadouts_swapOpfor;
} else {
	{[_x] call ( militia_standard_squad call BIS_fnc_selectRandom );} foreach (units _grpsentry);
};

0 = [_grpsentry,  (getMarkerPos _baseLocation), 50] call BIS_fnc_taskPatrol;
_defendersAlive = _defendersAlive + (units _grpsentry);

_defendersAlive