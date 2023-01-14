params ["_compPath", "_building"];
private ["_comp"];

_bmtw = {_building modelToWorld _this};
_offsets = createHashMapFromArray [
    ["Land_Cargo_House_V1_F", [0, 2, 0]]
];

(0 boundingBoxReal _building) params ["_pos1", "_pos2"];
_pos1 params ["_x1", "_y1", "_z1"];
_pos2 params ["_x2", "_y2", "_z2"];

_roof = [
    [_x2, _y2, _z2],
    [_x1, _y2, _z2],
    [_x1, _y1, _z2],
    [_x2, _y1, _z2]
];

(_offsets getOrDefault [(typeOf _building), [0,0,0]]) params ["_xoffset", "_yoffset", "_zoffset"];

([_x1, _y1, _z2] call _bmtw) params ["_wx1", "_wy1", "_wz2"];
([_x2+_xoffset, _y2+_yoffset, _z2+_zoffset] call _bmtw) params ["_wx2", "_wy2", "_wz2"];

_pcenter = [
    (_wx1 + _wx2) / 2,
    (_wy1 + _wy2) / 2,
    _wz2
];

_comp = [_compPath] call LP_getCompositionByPath;
([_pcenter, 0, _comp] call BIS_fnc_objectsMapper) apply {
    private _p = getPosATL _x;
//     _x setVehiclePosition [ [_p select 0, _p select 1, _wz2], [], 0, "CAN_COLLIDE"];
    _x setPos [_p select 0, _p select 1, _wz2];
    _x setVectorUp [0, 0, 1];
    diag_log format ["%1 POSITIONED TO: %2", _x, [_p select 0, _p select 1, _wz2]];
};

// createVehicle ["Sign_Arrow_Blue_F", _pcenter, [], 0, "CAN_COLLIDE"];
// createVehicle ["Sign_Arrow_F", _pcenter, [], 0, "CAN_COLLIDE"];




// _bmtw = {_building modelToWorld _this};
// _building = (player call CBA_fnc_getNearestBuilding) select 0;
// (0 boundingBoxReal _building) params ["_pos1", "_pos2", "_diameter"];
//     _pos1 params ["_x1", "_y1", "_z1"];
//     _pos2 params ["_x2", "_y2", "_z2"];
//
//     _roof = [
//         building corners
//         [_x2, _y2, 0],
//         [_x1, _y2, 0],
//         [_x1, _y1, 0],
//         [_x2, _y1, 0],
//         centers of each side
//         [(_x1 + _x2)/2, _y1, 0],
//         [(_x1 + _x2)/2, _y2, 0],
//         [_x1, (_y1 + _y2)/2, 0],
//         [_x2, (_y1 + _y2)/2, 0]
//     ];
//
// _roof apply {
//     createVehicle ["Sign_Arrow_F", (_building modelToWorld _x), [], 0, "CAN_COLLIDE"];
//     diag_log (_building modelToWorld _x);
// };
//
//
// ([_x1, _y1, _z2] call _bmtw) params ["_wx1", "_wy1", "_wz2"];
// ([_x2, _y2, _z2] call _bmtw) params ["_wx2", "_wy2", "_wz2"];

//     _roof = [
//         building corners
//         [_wx2, _wy2, 0],
//         [_wx1, _wy2, 0],
//         [_wx1, _wy1, 0],
//         [_wx2, _wy1, 0],
//         centers of each side
//         [(_wx2 - _wx1)/2, _wy1, 0],
//         [(_wx2 - _wx1)/2, _wy2, 0],
//         [_wx1, (_wy2 - _wy1)/2, 0],
//         [_wx2, (_wy2 - _wy1)/2, 0]
//     ];

// _roof apply {
//     createVehicle ["Sign_Arrow_F",  _x, [], 0, "CAN_COLLIDE"];
//     diag_log _x;
// };
