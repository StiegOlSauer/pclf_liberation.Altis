params ["_wpnClass", "_wpn", "_oType"];
private ["_oMount", "_camo", "_magType", "_opticTypes", "_magazine", "_ret", "_rail", "_muzzle", "_optics"];

/*
 * Unlock weapon, magazine, optics and accessory
 * Adds one piece of weapon of provided type and compatible mag.type, optics and accessories to virtual arsenal.
 * Tries to match camo of unlocked items.
 * Params:
 * _vestType - normal or heavy
 * _camo - "any" or valid camo type
*/

_opticTypes = ["combat", "holo", "sniper"];

if (count _wpn == 0) then {
    if (not (_camo in GRLIB_eligible_weapon_camo)) then {
        _camo = "any";
    };

    if (not (_wpnClass in GRLIB_weapon_classes)) exitWith {
        ["Unknown weapon class %1!", _wpnClass] call BIS_fnc_error;
    };
    _wpn = [_wpnClass, GRLIB_arsenal_blufor get "weapons", true] call PCLF_getPrimaryWeapon;
    while {(_wpn select 0) in (missionNamespace call BIS_fnc_getVirtualWeaponCargo) || (count _wpn) == 0} do {
        _wpnClass = [_wpnClass, (selectRandom GRLIB_weapon_classes)] select ((count _wpn) == 0);
        _wpn = [_wpnClass, GRLIB_arsenal_blufor get "weapons", true] call PCLF_getPrimaryWeapon;
    };
};

if (count _wpn == 0) then {
    _camo = "any";
    _oMount = "any";
    _magType = "any";
} else {
    _magType = _wpn select 1;
    _oMount = _wpn select 2;
    _camo = _wpn select 3;
};
if (_magType == "None") then {
    _magType == "any";
};
_magazine = [_magType, _camo, GRLIB_arsenal_blufor get "mags", true] call PCLF_getMagazine;

if (_oMount == "None") then { _oMount == "any" };
if (_oType == "any") then { _oType = selectRandom _opticTypes };

_optics = [_oType, _oMount, _camo, GRLIB_arsenal_blufor get "optics", false, true] call PCLF_getOptics;

_ret = [_camo, GRLIB_arsenal_blufor get "devices", true] call PCLF_getDevices;
_muzzle = _ret select 0; _rail = _ret select 1;
if (count _wpn > 0) then {
    [ missionNamespace, _wpn select 0, true ] call BIS_fnc_addVirtualWeaponCargo;
};

if (count _magazine > 0) then {
    [ missionNamespace, _magazine, true ] call BIS_fnc_addVirtualMagazineCargo;
};

{
    if (count _x > 0) then {[ missionNamespace, _x, true ] call BIS_fnc_addVirtualItemCargo};
} forEach [_optics, _rail, _muzzle];
