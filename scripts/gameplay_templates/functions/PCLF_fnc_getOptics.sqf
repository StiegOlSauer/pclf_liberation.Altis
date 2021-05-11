params ["_opticsType", "_mount", "_camo", "_config", "_strict", "_deleteItem"];
private ["_mountsToCheck", "_typesToCheck"];

/*
 * Optics:
 * Type (holo, sniper, combat) 1:N Mount (Dovetail, RIS, etc) 1:N Camoflage (nocamo, desert, etc) 1:N Optic pieces
 *
*/
private _opticsMounts = ["RIS", "Dovetail", "RPG7"];
private _opticsTypes = ["holo", "combat", "sniper"];
private _optics = "";

if (_mount == "None") exitWith { _optics };
if (_mount == "any") then {
    _mount = selectRandom _opticsMounts;
};
if (not (_opticsType in _opticsTypes)) then {
    _opticsType = selectRandom _opticsTypes;
};

if (_strict) then {
    _mountsToCheck = [_mount]; // search only within chosen mount category if optics is requested for enemy soldier
    _typesToCheck = [_opticsType];
} else {
    _mountsToCheck = ([_mount] + ((_opticsMounts - [_mount]) call BIS_fnc_arrayShuffle));
    _typesToCheck = [_opticsType] + ((_opticsTypes - [_opticsType]) call BIS_fnc_arrayShuffle);
};

if (not (_camo in GRLIB_eligible_weapon_camo)) then {
    _camo = selectRandom GRLIB_eligible_weapon_camo;
};

scopeName "main";
{
    private _opticsOfTypeX = _config getOrDefault [_x, []];
    if (count _opticsOfTypeX == 0) then {continue};
    {
        private _opticsOfMountX = _opticsOfTypeX getOrDefault [_x, []];
        if (count _opticsOfMountX == 0) then {continue};
        {
            private _opticsOfColorX = _opticsOfMountX getOrDefault [_x, []];
            _optics = [_opticsOfColorX, _deleteItem, false] call PCLF_fnc_searchAndDelete;
            if (count _optics > 0) then { breakTo "main" };
        } forEach ([_camo] + ((GRLIB_eligible_weapon_camo - [_camo]) call BIS_fnc_arrayShuffle));
    } forEach _mountsToCheck;
} forEach (_typesToCheck);

_optics
