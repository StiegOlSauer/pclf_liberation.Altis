params [
	"_sectorpos",
	"_vehicle_props",
    "_loadout_hash",
	["_precise_position", false],
	["_disable_abandon", false],
	["_random_rotate", true]
];

private _newvehicle = objNull;
private _spawnpos = zeropos;

if ( _precise_position ) then {
	_spawnpos = [] + _sectorpos;
} else {
	while { _spawnpos distance zeropos < 1000 } do {
		_spawnpos = ( [ _sectorpos, random 150, random 360 ] call bis_fnc_relpos ) findEmptyPosition [10, 100, 'B_Heli_Transport_01_F'];
		if ( count _spawnpos == 0 ) then { _spawnpos = zeropos; };
	};
};
private _classname = _vehicle_props select 0;
private _camo = _vehicle_props select 1;

_newvehicle = objNull;
if ( _classname in opfor_choppers ) then {
	_newvehicle = createVehicle [_classname, _spawnpos, [], 0, 'FLY'];
	_newvehicle flyInHeight (100 + (random 200));
} else {
	_newvehicle = _classname createVehicle _spawnpos;
	_newvehicle setpos _spawnpos;
};

if ((count _camo) > 0 || _camo != "any") then {
    [_newvehicle, [_camo, 1], false] call BIS_fnc_initVehicle;
};
_newvehicle allowdamage false;

clearWeaponCargoGlobal _newvehicle;
clearMagazineCargoGlobal _newvehicle;
clearItemCargoGlobal _newvehicle;
clearBackpackCargoGlobal _newvehicle;

[_newvehicle, _loadout_hash] call F_libSpawnOpforCrew;
sleep 0.1;
{ _x addMPEventHandler ['MPKilled', {_this spawn kill_manager}]; } foreach (crew _newvehicle);

_newvehicle addMPEventHandler ['MPKilled', {_this spawn kill_manager}];
if ( _random_rotate ) then {
	_newvehicle setdir (random 360);
};
_newvehicle setVectorUp surfaceNormal position _newvehicle;

sleep 0.1;
_newvehicle allowdamage true;
_newvehicle setdamage 0;

if ( !_disable_abandon ) then {
	[ _newvehicle ] spawn csat_abandon_vehicle;
};

_newvehicle
