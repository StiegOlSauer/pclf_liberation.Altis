//  The script plot the route to destination using roads.
//
//     Where possible, will use the road with the best coverage: asphalt, then gravel, then mud and any terrain.
//     Script is not plot entire route at once, and, to distribute the computation, returns after each call coordinates of the next waypoint.
//
// Call agruments:
//
//     currentPosition
//     destinationPosition
//     roadTypePrefixesArray
//     roadTypePrioritiesArray
//
// Return value:
//
//     nextWaypointPosition
//
//
//
// Usage:
//
// private _nextWaypointPosition = [_currentPosition, _destinationPosition,
// 	["asf1_", "asf2_", "asf3_", "city_", "invisible", "grav_", "mud_", ""],
// 	[4, 4, 3, 3, 3, 2, 2, 1]] call SearchNextWaypointPosition;


SearchNextWaypointPosition = {
	params ["_org", "_dst", "_rts", "_rws"];
	private _rad = 50;
	private _dsc = _org distance _dst;
	private _cls = 0.000000000001;
	private _dss = _dsc;
	private _rdd = objNull;

	while {isNull _rdd and _rad <= 800} do {
		{
            private _rdt = (getModelInfo _x) select 0;
			private _clx = {if (_rdt find _x >= 0) exitWith {_rws select _forEachIndex}; 0} forEach _rts;
			if (_clx >= _cls) then {
				private _dsx = _x distance _dst;
				if (_dsx < _dsc and {_clx > _cls or {_dsx < _dss}}) then {
					_cls = _clx;
                    _dss = _dsx;
                    _rdd = _x;
                };
            };
        } forEach (_org nearRoads _rad);
        _rad = _rad * 2;
    };

	if (isNull _rdd) then {
        _org getPos [_dss min 800, _org getDir _dst]
    } else {
        getPos _rdd;
    };
};
