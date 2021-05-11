// Spaw loadout of freshly spawned OPFOR unit.
// params: unit which loadout is swapped, unit's role for picking new loadout, index for checking uptier probability
params ["_unit", "_role", "_idx", "_squadLoadoutHash"];
private ["_cfg", "_uptier_probability", "_wpnProps", "_wpn", "_optics", "_devices", "_mags", "_vest", "_headgear", "_uniform", "_vestCamo", "_grenade", "_secondary", "_secMag", "_arsenal"];

if (!local _unit) exitWith {};

//Remove existing items
removeAllWeapons _unit;
removeAllItems _unit;
removeAllAssignedItems _unit;
removeUniform _unit;
removeVest _unit;
removeBackpack _unit;
removeHeadgear _unit;
removeGoggles _unit;


_secondary = [];
_devices = [];
_cfg = _squadLoadoutHash get "low";
_arsenal = GRLIB_arsenal_opfor_low;
_uptier_probability = ((combat_readiness / 100) ^ _idx) * 100;
if (combat_readiness >= GRLIB_uptier_readiness || _uptier_probability >= random 100 ) then {
    _cfg = _squadLoadoutHash get "high";
    _arsenal = GRLIB_arsenal_opfor_low;
};

_wpnProps = _role select 1;
_wpn = _cfg get (_wpnProps select 0);
_mag = [_wpn select 1, _wpn select 3, _arsenal get "mags", false] call PCLF_getMagazine;
_grenade = selectRandom (_arsenal get "grenadesfrag");

if ((_wpnProps select 3) or (_wpnProps select 4)) then {
    _devices = [_wpn select 3, _arsenal get "devices", true] call PCLF_getDevices;
};

_vest = _cfg get (_role select 4);
_headgear = _cfg get "headgear";
_uniform = _cfg get "uniform";

_unit forceAddUniform _uniform;
if (not ("crew" in (_role select 6))) then {
    _unit addVest (_vest select 0);
    _unit addHeadgear (_headgear select 0);
};

_unit addWeapon (_wpn select 0);
_unit addPrimaryWeaponItem _mag;

if (_wpnProps select 2 != "None" && _wpn select 2 != "None") then {
    _optics = [_wpnProps select 2, _wpn select 2, _wpn select 3, _arsenal get "optics", true, false] call PCLF_getOptics;
    _unit addPrimaryWeaponItem _optics;
};

if (_role select 5) then {
    _unit addBackpack (selectRandom (GRLIB_common_items get "backpack"));
};

if ("tl" in (_role select 6)) then {
    _grenade = selectRandom (_arsenal get "grenadesmoke");
};

if ("gl" in (_role select 6)) then {
    _grenade = selectRandom (GRLIB_common_items get "gp25_he");
    if (!(_unit addPrimaryWeaponItem _grenade)) then {
        _grenade = selectRandom (GRLIB_common_items get "m203_he");
        _unit addPrimaryWeaponItem _grenade;
    };
};

if ("lat" in (_role select 6)) then {
    _secondary = _cfg get "lat";
};

if ("hat" in (_role select 6)) then {
    _secondary = _cfg get "hat";
};

if ("aa" in (_role select 6)) then {
    _secondary = _cfg get "aa";
};


if (count _secondary > 0) then {
    _unit addWeapon (_secondary select 0);
    if ((_secondary select 1) != "None") then {
        _secMag = [_secondary select 1, _secondary select 3, _arsenal get "mags", false] call PCLF_getMagazine;
        _unit addSecondaryWeaponItem _secMag;
        if (_role select 5) then {_unit addItemToBackpack _secMag };
    };
};

if ((_wpnProps select 3) && (_wpn select 4)) then { _unit addPrimaryWeaponItem (_devices select 0) }; // muzzle device
if ((_wpnProps select 4) && (_wpn select 5)) then { _unit addPrimaryWeaponItem (_devices select 1) }; // rail device

for "_i" from 1 to (_wpnProps select 1) do { _unit addItemToVest _mag };

if (_role select 5) then {
    for "_i" from 1 to (_role select 2) do { _unit addItemToBackpack _grenade };
} else {
    for "_i" from 1 to (_role select 2) do { _unit addItemToVest _grenade };
};

if (GRLIB_ace) then {
    private _d = selectRandom (GRLIB_common_items get "acemeddressing");
    for "_i" from 1 to 5 do { _unit addItemToUniform  _d };
    if ("medic" in (_role select 6)) then {
        for "_i" from 1 to 10 do { _unit addItemToBackpack  _d };
        for "_i" from 1 to 5 do { _unit addItemToBackpack  selectRandom (GRLIB_common_items get "acemedinjector") };
        for "_i" from 1 to 5 do { _unit addItemToBackpack  selectRandom (GRLIB_common_items get "acemedicine") };
    };
} else {
    _unit addItemToUniform selectRandom (GRLIB_common_items get "medicinefak");
    if ("medic" in (_role select 6)) then { _unit addItemToBackpack selectRandom (GRLIB_common_items get "medicinepak") };
};

_unit linkItem "ItemMap";
_unit linkItem "ItemCompass";
_unit linkItem "ItemWatch";
_unit linkItem "ItemRadio";

// diag_log format ["SQUAD %8 - EQUIPPING %1 SOLDIER WITH: wpn - %2, secondary - %3, uni - %4, vest - %5, head - %6, grenade - %7", (_role select 0), (_wpn select 0), (_secondary select 0), _uniform, (_vest select 0), (_headgear select 0), _grenade, (group _unit)];
