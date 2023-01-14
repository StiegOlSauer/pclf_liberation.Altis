params ["_marker"];
private ["_red_forces", "_blue_forces", "_ratio"];

private _mSize = (markerSize _marker select 0) max (markerSize _marker select 1);
_red_forces = [markerPos _marker, _mSize, GRLIB_side_enemy ] call F_getUnitsCount;
_blue_forces = [markerPos _marker, _mSize, GRLIB_side_friendly ] call F_getUnitsCount;
_ratio = 1;

if (_red_forces > 0) then {
    _ratio = _blue_forces / (_red_forces + _blue_forces);
};

_ratio
