params ["_magType", "_wpnColor", "_config", "_deleteItem"];
/*
 * Magazines:
 * Type (AK74, AK, AR15...) 1:N Camoflage (nocamo, desert, etc) 1:N Magazine items
 *
*/
getMagOfTypeXAndColorY = {
    params ["_mtype", "_mcolor"];
    private _mag = "";

    private _magsOfTypeX = _config get _mtype;
    private _magsOfColorX = _magsOfTypeX get _mcolor;
    if (count _magsOfColorX > 0) then {
        _mag = selectRandom _magsOfColorX;
        if (_deleteItem) then {
            _magsOfColorX deleteAt (_magsOfColorX find _mag);
            _magsOfTypeX set [_mcolor, _magsOfColorX];
            _config set [_mtype, _magsOfTypeX];
        };
    } else {
        {
            if (count _mag > 0) exitWith {_mag};
            _mag = [_y, _deleteItem, false] call PCLF_fnc_searchAndDelete;
        } forEach _magsOfTypeX;
    };
    _mag
};

if (_magType == "None") exitWith {""};

private _mag = "";
private _magTypes = _config get "types";

if (not (_wpnColor in GRLIB_eligible_weapon_camo)) then {
    _wpnColor = selectRandom GRLIB_eligible_weapon_camo;
};

if (not (_magType in _magTypes)) then {
    _magType = selectRandom _magTypes;
};

{
    _mag = [_x, _wpnColor] call getMagOfTypeXAndColorY;
    if (count _mag > 0) exitWith {_mag};
} forEach ([_magType] + ((_magTypes - [_magType]) call BIS_fnc_arrayShuffle));

_mag
