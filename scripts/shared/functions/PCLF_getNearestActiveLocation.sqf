params ["_pos"];
private ["_closestLocation", "_leastDistance"];

_closestLocation = "";
_leastDistance = 9999;
LP_active_markers apply {
    private _marker = _x select 1;
    if (_pos inArea _marker) then {
        if ((_pos distance (markerPos _marker)) < _leastDistance) then {
            _leastDistance = _pos distance (markerPos _marker);
            _closestLocation = _x;
        };
    };
};

_closestLocation
