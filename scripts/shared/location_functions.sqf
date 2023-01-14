LP_getLocationMarker = {
    params ["_loc"];
    format ["loc_%1", mapGridPosition(position _loc)]
};

LP_getLocationZoneMarker = {
    params ["_loc"];
    format ["loc_%1_zone", mapGridPosition(position _loc)]
};

LP_isLocationActive = {
    params ["_loc"];
    private _mrk = [_loc] call LP_getLocationZoneMarker;
    LP_active_markers findIf {_x select 1 == _mrk} != -1
};

LP_getLocationType = {
    params ["_loc"];
    private _properties = _loc getVariable LP_location_props_varname;
    if (! isNil "_properties") exitWith {
        _properties get "type"
    };
};

LP_getLocationMaxSize = {
    params ["_loc"];
    (size _loc) #0 max (size _loc) #1
};

LP_getLocationComposition = {
    params ["_loc"];

    private _c = nil;
    private _properties = _loc getVariable LP_location_props_varname;
    if !(isNil "_properties") then {
        _c = _properties get ["composition", 0];
        if (_c isEqualType "") exitWith {
            _c = [_c] call LP_getCompositionByPath;
//             _properties set ["composition_spawned", true];
            _loc setVariable ["LP_compositionSpawned", true];
            _loc setVariable [LP_location_props_varname, _properties];
            _c
        };
    };
    nil
};

LP_isCompositionSpawned = {
    params ["_loc"];

    private _properties = _loc getVariable LP_location_props_varname;
    if (! isNil "_properties") exitWith {
        _properties getOrDefault ["composition_spawned", false]
    };
    false
};

LP_setLocationRoofDefence = {
    params ["_loc", "_comp"];
    private _comps = _loc getVariable ["LP_rooftopDefences", []];
    _comps pushBack _comp;
    _loc setVariable ["LP_rooftopDefences", _comps];
};

// LP_setLocationRoofDefence = {
//     params ["_loc", "_comp"];
//
//     private _fortifications = [_loc, "fortifications"] call LP_getLocationProperty;
//     if (isNil "_fortifications") then {
//         _fortifications = [ [comp], [] ];
//     } else {
//         _fortifications set [0, (_fortifications select 0) pushBack _comp];
//     };
//     [_loc, "fortifications", _fortifications] call LP_setLocationProperty;
// };

LP_setLocationSide = {
    params ["_loc", "_side"];
    private _properties = _loc getVariable LP_location_props_varname;
    if (! isNil "_properties") exitWith {
        _properties set ["side", _side];
        _loc setVariable [LP_location_props_varname, _properties];
        _loc setSide _side;
    };
};

LP_getBLUFORLocations = {
    nearestLocations [position locationNull, ["CBA_NamespaceDummy"], 80000] select {count (name _x) > 0 && (side _x) == GRLIB_side_friendly}
};

LP_getLocations = {
    params ["_pos", "_side", "_types", ["_distance", 80000]];

    if (_types isEqualType 0) then {
        _types = [_types];
    };
    if (_types isEqualType "" && {_types == "any"}) then {
        _types = LP_locations_allTypes;
    };

    nearestLocations [_pos, ["CBA_NamespaceDummy"], _distance] select {
        count (name _x) > 0 && (side _x) == _side && ([_x] call LP_getLocationType) in _types
    }
};

LP_getNearestLocation = {
    params ["_pos", "_side", "_type", ["_distance", 30000]];
    ([_pos, _side, _type, _distance] call LP_getLocations) # 0
};

LP_getLocationProperty = {
    params ["_loc", "_propName"];
    private _properties = _loc getVariable LP_location_props_varname;
    if (! isNil "_properties") exitWith {
        _properties get _propName;
    };
    nil
};

LP_setLocationProperty = {
    params ["_loc", "_propName", "_value"];
    private _properties = _loc getVariable LP_location_props_varname;
    if (! isNil "_properties") exitWith {
        _properties set [_propName, _value];
        _loc setVariable [LP_location_props_varname, _properties];
    };
    nil
};

LP_getLocationTraits = {
    params ["_loc"];
    private _properties = _loc getVariable LP_location_props_varname;
    if (! isNil "_properties") exitWith {
        _properties getOrDefault ["traits", []];
    };
    []
};

LP_decreaseLocationGarrison = {
    params ["_loc", ["_amount", 1]];
    if !(_amount isEqualType 0) exitWith {
        ["Incorrect value to deduct from garrison (%1)", _amount] call BIS_fnc_error;
    };

    private _currentGarrison = [_loc, "garrison"] call LP_getLocationProperty;
    [_loc, "garrison", (_currentGarrison - _amount)] call LP_setLocationProperty;
};
