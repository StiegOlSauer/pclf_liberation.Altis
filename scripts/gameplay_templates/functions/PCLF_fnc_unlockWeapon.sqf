params ["_wpnClass", "_wpn", "_oType"];
private ["_oMount", "_camo", "_magType", "_opticTypes", "_magazine", "_ret", "_rail", "_muzzle", "_optics", "_unlocked_wpns", "_unlocked_items"];

/*
 * Unlock weapon, magazine, optics and accessory
 * Adds one piece of weapon of provided type and compatible mag.type, optics and accessories to virtual arsenal.
 * Tries to match camo of unlocked items.
 * Params:
 * _wpnClass - unlock weapon of selected class, should be one of GRLIB_weapon_classes
 * _wpn - pass if particular type of weapon should be unlocked, then _wpnClass is ignored
 * _oType - type of optics unlocked with a weapon
*/

_opticTypes = ["combat", "holo", "sniper"];

_unlocked_items = missionNamespace call BIS_fnc_getVirtualItemCargo;
if (count _wpn == 0) then {
    if (not (_wpnClass in GRLIB_weapon_classes)) exitWith {
        ["Unknown weapon class %1!", _wpnClass] call BIS_fnc_error;
    };
    _unlocked_wpns = missionNamespace call BIS_fnc_getVirtualWeaponCargo;
    _wpn = [_wpnClass, GRLIB_arsenal_blufor get "weapons", true] call PCLF_getPrimaryWeapon;
    while {(_wpn select 0) in _unlocked_wpns} do {
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
while {_optics in _unlocked_items} do {
    _optics = [_oType, _oMount, _camo, GRLIB_arsenal_blufor get "optics", false, true] call PCLF_getOptics;
};

_muzzle = [_camo, GRLIB_arsenal_blufor get "devices", true, ["muzzle"]] call PCLF_getDevices;
while {_muzzle in _unlocked_items} do {
    _muzzle = [_camo, GRLIB_arsenal_blufor get "devices", true, ["muzzle"]] call PCLF_getDevices;
};

_rail = [_camo, GRLIB_arsenal_blufor get "devices", true, ["rail"]] call PCLF_getDevices;
while {_rail in _unlocked_items} do {
    _rail = [_camo, GRLIB_arsenal_blufor get "devices", true, ["rail"]] call PCLF_getDevices;
};

if (count _wpn > 0) then {
    _wpnClass = _wpn select 6;
    ((GRLIB_arsenal_unlocks get "weapons") getOrDefault [_wpnClass, [], true]) pushBack _wpn;
    ((GRLIB_arsenal_unlocks get "weapons") get _wpnClass) pushBack (random 100);
    [missionNamespace, _wpn select 0, true] call BIS_fnc_addVirtualWeaponCargo;
};

if (count _magazine > 0) then {
    [missionNamespace, _magazine, true] call BIS_fnc_addVirtualMagazineCargo;
};

if (count _optics > 0) then {
    [missionNamespace, (_optics select 0), true] call BIS_fnc_addVirtualItemCargo;
    _oType = _optics select 1;
    _oMount = _optics select 2;
    _camo = _optics select 3;
    _optics = _optics select 0;
    ((((GRLIB_arsenal_unlocks get "optics") get _oType) getOrDefault [_oMount, createHashMap, true]) getOrDefault [_camo, [], true]) pushBack _optics;
};

if (count (_rail select 1) > 0) then {
    _camo = _rail select 2;
    (((GRLIB_arsenal_unlocks get "devices") get _camo) getOrDefault ["rail", [], true]) pushBack (_rail select 1);
    [missionNamespace, (_rail select 1), true] call BIS_fnc_addVirtualItemCargo;
};

if (count (_muzzle select 0) > 0) then {
    _camo = _muzzle select 3;
    (((GRLIB_arsenal_unlocks get "devices") get _camo) getOrDefault ["muzzle", [], true]) pushBack (_muzzle select 0);
    [missionNamespace, (_muzzle select 0), true] call BIS_fnc_addVirtualItemCargo;
};
