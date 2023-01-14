LP_placeComposition = {
    params ["_pos", "_comp"];
    private ["_base_objects", "_spawnpos", "_dir"];

    if (isNil "_comp") exitWith {};
    _spawnpos = [_pos, 0, 150, 6, 0, 0.1, 0] call BIS_fnc_findSafePos;
    private _gc = "Land_ClutterCutter_large_F" createVehicle _spawnpos;
    deleteVehicle _gc;
    _base_objects = [_spawnpos, 0, _comp] call BIS_fnc_ObjectsMapper;
    _base_objects apply {
        _x enableDynamicSimulation true;
    };
};

LP_removeComposition = {
    params ["_pos", "_compPath"];
    if (isNil "_compPath") exitWith {};
    private _comp = [_compPath] call LP_getCompositionByPath;
    _comp apply {
        (_pos nearObjects [(_x select 0), 1000]) apply {deleteVehicle _x};
    };
};

LP_getCompositionByPath = {
    params ["_path"];
    private _c = nil;
    private _hash = LP_compositions;

    _pathItems = _path splitString "/";
    _pathItems apply {
        _c = _hash get _x;
        _hash = _c;
    };
    _c
};

LP_removeObjectsByType = {
    params ["_loc", "_typeName"];

    private _range = [_loc] call LP_getLocationMaxSize;
    (position _loc) nearObjects [_typeName, _range] apply {
        private _veh = _x;
        {_veh deleteVehicleCrew _x} forEach crew _veh;
        deleteVehicle _x;
    };
};
