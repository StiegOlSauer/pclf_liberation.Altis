/* Discovers pre-existing locations on map of particular types
 * Creates dummy locations on top of discovered ones
 * Inits locations' properties and attaches them as variable to each location
 * Places marker of corresponding type, size and color for each capturable location
*/
private ["_location", "_locationProps", "_icon", "_marker", "_mName", "_last_name_part", "_ret", "_garrisonPositions", "_startGarrisonMult", "_initialized_locations"];

[] call compile preprocessFileLineNumbers "scripts\shared\location_functions.sqf";
_ret = [] call compile preprocessFileLineNumbers "scripts\shared\location_constants.sqf";
_ret params ["_location_exclusions", "_location_patches", "_location_markers"];
_location_exclusions = _location_exclusions get LP_island;
_location_patches = _location_patches get LP_island;
_location_markers = _location_markers get LP_island;
_initialized_locations = [];

{
    private _loc_type = _x;
    _y apply {
        private _l = createLocation [_loc_type, getMarkerPos (_x select 1), 1, 1];
        _l setName (_x select 0);
        _l setText (_x select 0);
        deleteMarker (_x select 1);
    };
} forEach _location_markers;

(nearestLocations [position locationNull, ["NameLocal", "NameVillage", "NameCity", "NameCityCapital", "Hill"], 80000]) apply {
    if ((format["%1", _x] in _location_exclusions) || ((text _x) in _location_exclusions)) then { continue };

    switch (type _x) do {
    case "NameLocal": {
        _last_name_part = format["%1", _x] splitString " ";
        _last_name_part = _last_name_part select (count _last_name_part) - 1; // reverse array does not work in 2.04
        _startGarrisonMult = 0.7 * GRLIB_difficulty_modifier;
        _locationProps = createHashMapFromArray[
            ["name", text _x],
            ["type", LP_location_tiny],
            ["size", 900],              // location activation area
            ["importance", random 15],  // how important is this location to OPFOR (1 - 100)
            ["garrison", ceil(random [12, 16, 24])],
            ["garrison_override", 18],
            ["vehicles", ["support"]]   // vehicles in garrison
        ];

        if (text _x in LP_location_words_military || _last_name_part in LP_location_words_military) then {
            if (_last_name_part in ["Base", "Airbase", "Outpost"]) then {
                _locationProps set ["name", name _x];
            } else {
                _locationProps set ["name", format["Military base %1", mapGridPosition(position _x)]];
            };
            _startGarrisonMult = 0.9;
            _locationProps set ["type", LP_location_base];
            _locationProps set ["size", 1200];
            _locationProps set ["importance", random [40, 50, 80]],
            _locationProps set ["garrison", 60];
            _locationProps set ["garrison_override", 80];
            _locationProps set ["vehicles", ["apc", "support", "ifv"]];
        };

        if (text _x in LP_location_words_factory || _last_name_part in LP_location_words_factory) then {
            if (_last_name_part in ["Dock", "Powerplant", "Factory"]) then {
                _locationProps set ["name", name _x];
            } else {
                _locationProps set ["name", format["Factory %1", mapGridPosition(position _x)]];
            };
            _startGarrisonMult = 0.6 * GRLIB_difficulty_modifier;
            _locationProps set ["type", LP_location_factory];
            _locationProps set ["size", 1100];
            _locationProps set ["importance", random [30, 40, 60]],
            _locationProps set ["garrison", 40];
            _locationProps set ["garrison_override", 50];
            _locationProps set ["vehicles", ["ifv", "apc"]];
        };

    };
    case "NameVillage": {
        _startGarrisonMult = 0.7 * GRLIB_difficulty_modifier;
        _locationProps = createHashMapFromArray[
            ["size", 1000],
            ["name", text _x],
            ["type", LP_location_village],
            ["importance", random 25],
            ["garrison", ceil(random [16, 24, 32])],
            ["garrison_override", 40],
            ["vehicles", ["support", "support"]]
        ];
    };
    case "NameCity": {
        _startGarrisonMult = 0.6 * GRLIB_difficulty_modifier;
        _locationProps = createHashMapFromArray[
            ["size", 1100],
            ["name", text _x],
            ["type", LP_location_city],
            ["importance", random 35],
            ["garrison", ceil(random [28, 42, 48])],
            ["garrison_override", 70],
            ["vehicles", ["support", "support","ifv", "apc"]]
        ];
    };
    case "NameCityCapital": {
        _startGarrisonMult = 0.5 * GRLIB_difficulty_modifier;
        _locationProps = createHashMapFromArray[
            ["size", 1200],
            ["name", format ["City of %1", text _x]],
            ["type", LP_location_capital],
            ["importance", 100],
            ["garrison", ceil(random [50, 80, 100])],
            ["garrison_override", 200],
            ["vehicles", ["support", "tank", "tank", "ifv", "ifv", "apc", "apc"]]
        ];
    };
    case "Hill": {
        _startGarrisonMult = 1;
        _locationProps = createHashMapFromArray[
            ["size", 1300],
            ["name", format["Comms Array %1", mapGridPosition(position _x)]],
            ["type", LP_location_radio],
            ["importance", random 25],
            ["garrison", ceil(random [16, 20, 24])],
            ["garrison_override", 24],
            ["vehicles", ["support", "ifv"]],
//             ["composition", {selectRandom ((LP_compositions get "radios") get "med")}]
            [
                "composition",
                [] call {
                    private _hash = LP_compositions get "radios";
                    private _arr = ((keys (_hash get "small")) apply {["radios", "small", _x] joinString "/"}) + ((keys (_hash get "med")) apply {["radios", "med", _x] joinString "/"});
                    selectRandom _arr
                }
            ]
        ];
    };
    };
    _locationProps set ["side", GRLIB_side_enemy];
    _locationProps set ["alert", 25]; // FIXME: remove when alert system is ready

    _garrisonPositions = 0;
    (((locationPosition _x) nearObjects ["House", (_locationProps get "size") / 4]) select {alive _x}) apply {
        _garrisonPositions = _garrisonPositions + count (_x buildingPos -1);
    };
//     diag_log format ["Location %1 found %2 building positions", (_locationProps get "name"), _garrisonPositions];
    if (_garrisonPositions > (_locationProps get "garrison_override")) then {
        _locationProps set ["garrison_max", _garrisonPositions];
    } else {
        _locationProps set ["garrison_max", (_locationProps get "garrison_override")];
    };

    _startGarrisonMult = [_startGarrisonMult, 1] select (_startGarrisonMult > 1);
    _locationProps set ["garrison", ceil ((_locationProps get "garrison_max") * _startGarrisonMult)];
//     diag_log format ["Location %1 configured %2 MAX garrison and %3 CURRENT garrison", (_locationProps get "name"), _locationProps get "garrison_max", _locationProps get "garrison"];

    private _p = _location_patches get (format["%1", _x]);
    if (!isNil "_p") then {
        _locationProps merge [_p, true];
    };

    _location = createLocation ["CBA_NamespaceDummy", locationPosition _x, _locationProps get "size", _locationProps get "size"];
    _location setName (_locationProps get "name");
    _location setImportance (_locationProps get "importance");
    _location setSide (_locationProps get "side");
    _location setSize [(_locationProps get "size"), (_locationProps get "size")];
    _location setVariable [LP_location_props_varname, _locationProps];

    _mName = [_location] call LP_getLocationMarker;
    _marker = createMarker [_mName, locationPosition _location];
    _icon = LP_location_type_icons get (_locationProps get "type");
    _mName setMarkerTypeLocal _icon;
    _mName setMarkerColorLocal ([GRLIB_color_friendly, GRLIB_color_enemy] select (side _location == GRLIB_side_enemy));
    _mName setMarkerTextLocal (_locationProps get "name");

    switch (_locationProps get "type") do {
        case LP_location_base: {
            _mName setMarkerSizeLocal [1.55, 1.55];
            _mName setMarkerAlpha 0.9;
        };
        case LP_location_city: {
            _mName setMarkerPosLocal [(getMarkerPos _mName) select 0, ((getMarkerPos _mName) select 1) + 35];
            _mName setMarkerSizeLocal [1.25, 1.25];
            _mName setMarkerAlpha 0.9;
        };
        case LP_location_capital: {
            _mName setMarkerPosLocal [(getMarkerPos _mName) select 0, ((getMarkerPos _mName) select 1) + 40];
            _mName setMarkerSizeLocal [1.5, 1.5];
            _mName setMarkerAlpha 1;
        };
        case LP_location_radio: {
            _mName setMarkerSizeLocal [1.2, 1.2];
            _mName setMarkerAlpha 0.8;
        };
        default {
            _mName setMarkerPosLocal [(getMarkerPos _mName) select 0, ((getMarkerPos _mName) select 1) + 15];
            _mName setMarkerAlpha 0.8;
        };
    };
    _initialized_locations pushBack _location;
};
LP_allLocations = _initialized_locations;

[] spawn compileFinal preprocessFileLineNumbers "scripts\server\statemachines\locations.sqf";
