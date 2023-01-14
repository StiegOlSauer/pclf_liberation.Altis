private ["_building", "_roofQuarter", "_sidePositions", "_cornerPositions"];

_building = (((position player) nearObjects ["House", 10]) select {alive _x && (count (_x buildingPos -1)) >= 7})  select 0;
(0 boundingBoxReal _building) params ["_pos1", "_pos2"];
_pos1 params ["_x1", "_y1", "_z1"];
_pos2 params ["_x2", "_y2", "_z2"];

_roofQuarter = [
    (_x2 + _x1) / 4,
    (_y2 + _y1) / 4,
    (_z2) * 0.8
];

dish1 setPos (_building modelToWorld _roofQuarter);
dish1 setVectorUp [0,0,2];
createVehicle ["Sign_Arrow_F", (_building modelToWorld _roofQuarter), [], 0, "CAN_COLLIDE"];
diag_log (_building modelToWorld _roofQuarter);

_roofQuarter set [1, (_roofQuarter select 1) + (_x2 - _x1) / 4];

dish2 setPos (_building modelToWorld _roofQuarter);
dish2 setVectorUp [0,0,2];
createVehicle ["Sign_Arrow_F", (_building modelToWorld _roofQuarter), [], 0, "CAN_COLLIDE"];
diag_log (_building modelToWorld _roofQuarter);

_sidePositions = [
    [ [_x1, (_y1 + _y2)/2, (_z1 + _z2)/2], -90],
    [ [_x2, (_y1 + _y2)/2, (_z1 + _z2)/2], 90]
];

(selectRandom _sidePositions) params ["_dishPos", "_ang"];
_dishPos = _building modelToWorld _dishPos;
dish3 setPos _dishPos;
dish3 setVectorUp [0, 0, 1];
dish3 setDir ((getDir _building) + _ang);
createVehicle ["Sign_Arrow_F",  _dishPos, [], 0, "CAN_COLLIDE"];
diag_log _dishPos;

_cornerPositions = [
        [_x2, _y2, 0],
        [_x1, _y2, 0],
        [_x1, _y1, 0],
        [_x2, _y1, 0]
];

_antennaPos = _building modelToWorld (selectRandom _cornerPositions);
_antennaPos set [2, getTerrainHeightASL _antennaPos];
antenna1 setPosASL _antennaPos;
antenna1 setVectorUp [0,0,2];
createVehicle ["Sign_Arrow_F", _antennaPos, [], 0, "CAN_COLLIDE"];
diag_log _antennaPos;

[ [srv], "Land_PortableServer_01_black_F"] call BIS_fnc_spawnObjects;
// Land_MultiScreenComputer_01_black_F
// Land_PortableServer_01_black_F
// Land_Router_01_sand_F
// CBA_BuildingPos
