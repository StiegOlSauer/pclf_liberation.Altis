params ["_targetSector", "_minDistance"];
private ["_possibleSectors", "_spawnPoint"];

if (_targetSector == "") exitwith {};
_possibleSectors = [];
_spawnPoint = "";

{
	if (((markerpos _x) distance (markerpos _targetSector)) >= _minDistance) then {_possibleSectors = _possibleSectors + [_x]};
} foreach (sectors_opfor - sectors_factory - sectors_tower);

_spawnPoint = _possibleSectors select 0;

{
	_reference = (markerpos _spawnPoint) distance (markerpos _targetSector);
	if ( ((markerpos _x) distance (markerpos _targetSector)) < _reference) then {
		_spawnPoint = _x;
	};
} foreach _possibleSectors;

_spawnPoint

