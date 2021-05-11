params ["_fob"];
private ["_sectorsArray", "_count"];

_testedSectors = sectors_capture - blufor_sectors;
_count = ((count GRLIB_all_fobs) * 5) + 3;

//_position = getPos _fob;
_sectorsArray = [sectors_capture - blufor_sectors,[],{_fob distance (getMarkerPos _x)},"ASCEND"] call BIS_fnc_sortBy;
_sectorsArray resize _count;

_sectorsArray