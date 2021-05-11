params ["_camo", "_config", "_deleteItem"];

getDevOfTypeXAndColorY = {
    params ["_camo", "_hash", "_dType"];
    private ["_colorHash", "_devsOfTypeX"];
    private _device = "";

    _colorHash = _hash get _camo;
    if (count _device == 0) then {
        _devsOfTypeX = _colorHash getOrDefault [_dType, []];
        if (count _devsOfTypeX == 0) exitWith {};
        _device = [_devsOfTypeX, _deleteItem, true] call PCLF_fnc_searchAndDelete;
    };

    _device
};

private _muzzle = "";
private _rail = "";
// private _config = GRLIB_arsenal_blufor get "devices";
//
// if (_side == GRLIB_side_enemy) then {
//     _config = GRLIB_arsenal_opfor_low get "devices";
// };

if (not (_camo in GRLIB_eligible_weapon_camo)) then {
    _camo = selectRandom GRLIB_eligible_weapon_camo;
};

{
    _rail = [_x, _config, "rail"] call getDevOfTypeXAndColorY;
    if (count _rail > 0) then {break};
} forEach ([_camo] + ((GRLIB_eligible_weapon_camo - [_camo]) call BIS_fnc_arrayShuffle));

{
    _muzzle = [_x, _config, "muzzle"] call getDevOfTypeXAndColorY;
    if (count _muzzle > 0) then {break};
} forEach ([_camo] + ((GRLIB_eligible_weapon_camo - [_camo]) call BIS_fnc_arrayShuffle));

[ _muzzle, _rail ]
