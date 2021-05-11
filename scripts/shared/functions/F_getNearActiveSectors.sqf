//F_getNearActiveSectors

private ["_allSectors", "_nearestSectors", "_sector"];

_allSectors = [];
_nearestSectors = [];
_sector = "";

{
	_sector = _x;
	{
	_t = _x distance (markerPos _sector);
	_allSectors = _allSectors + _t;
	} foreach allPlayers;
} foreach active_sectors;
