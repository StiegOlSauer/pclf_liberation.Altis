params ["_camo", "_config", "_deleteItem"];

private _uniform = "";
// private _config = GRLIB_arsenal_blufor get "uniforms";
//
// if (_side == GRLIB_side_enemy) then {
//     _config = GRLIB_arsenal_opfor_low get "uniforms";
// };

if (not (_camo in GRLIB_eligible_weapon_camo) || _camo == "any") then {
    _camo = selectRandom GRLIB_eligible_weapon_camo;
};

private _uniformsOfCamoX = _config get _camo;
if (count _uniformsOfCamoX > 0) then {
    _uniform = selectRandom _uniformsOfCamoX;
    if (_deleteItem) then {
        _uniformsOfCamoX deleteAt (_uniformsOfCamoX find _uniform);
        _config set [_camo, _uniformsOfCamoX];
    };
} else {
    {
        if (count _uniform > 0) exitWith {_uniform};
        _uniform = [_y, _deleteItem, false] call PCLF_fnc_searchAndDelete;
    } forEach _config;
};

_uniform
