// Returns randomly selected weapon of provided class
// Params:
//   * _wpnType - string, possible values: rifle, carbine, sniper, smg, pistol, mg, lmg, aa, at
//   * _evict - bool, whether remove found weapon or not
//   * _shift - [Optional] int, select only among weapons _shift points cooler than default
params ["_wpnClass", "_config", "_evict", ["_shift", 0]];

private _shift_array = {
    params ["_arr", "_shift"];

    if (_shift == 0) exitWith {_arr};
    private _shifted_arr = [];
    private _shifted_weight = 100 - _shift;
    for "_i" from 1 to ((count _arr)-1) step 2 do {
        if ((_arr select _i) <= _shifted_weight) then { // if weight of a weapon is lower than (max weight - desired shift) value
            _shifted_arr pushBack (_arr select (_i-1)); // add the weapon itself
            _shifted_arr pushBack (_arr select _i);     // and its weight to new array
        };
    };

    _shifted_arr
};

/*
 * Weapons:
 * Class ("aa", "lat", "hat", "rifle", "rifleGL", "carbine", "carbineGL", "lmg", "mg", "pistol", "smg", "marksman", "sniper") 1:N Weapon piece
 *
*/
private _wpn = "";
private _wpnOfClassX = _config get _wpnClass;

if (_shift > 0 && _evict) then {
    ["'_evict' and '_shift' parameters are mutually exclusive, removing '_evict'"] call BIS_fnc_error;
    _evict = false;
};

if (count _wpnOfClassX > 0) then {
    private _shifted_arr = [_wpnOfClassX, _shift] call _shift_array;
    _wpn = selectRandomWeighted _shifted_arr;
    if (_evict) then {
        private _idx = _wpnOfClassX find _wpn;
        _wpnOfClassX deleteRange [_idx, 2];
        _config set [_wpnClass, _wpnOfClassX];
    };
} else {
    {
        if (count _wpn > 0) exitWith {_wpn};
        private _shifted_arr = [_y, _shift] call _shift_array;
        _wpn = [_shifted_arr, _evict, true] call PCLF_fnc_searchAndDelete;
    } forEach _config;
};

_wpn
