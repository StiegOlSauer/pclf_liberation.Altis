// GRLIB_allowed_weapons = GRLIB_allowed_weapons - GRLIB_whitelisted_from_arsenal;
//perform initial shuffle of allowed weapons array
// private _shufflingArray = GRLIB_allowed_weapons;
// GRLIB_allowed_weapons = [_shufflingArray, 5000] call KK_fnc_arrayShufflePlus;
// publicVariable "GRLIB_allowed_weapons";
//publicVariable "GRLIB_whitelisted_from_arsenal";
private ["_ret", "_vests", "_commonItems", "_ACEItems"];

PCLF_fnc_searchAndDelete = {
    params ["_arr", "_deleteItem", "_weighted"];
    private ["_idx"];
    private _v = "";

    if (count _arr > 0) then {
        if (_weighted == false) then {
            _v = selectRandom _arr;
            if (_deleteItem) then { _arr deleteAt (_arr find _v) };
        } else {
            _v = selectRandomWeighted _arr;
            if (_deleteItem) then {
                _idx = _arr find _v;
                _arr deleteRange [_idx, 2];
            };
        };

    };
    _v
};
PCLF_getMagazine = compileFinal preprocessFileLineNumbers "scripts\gameplay_templates\functions\PCLF_fnc_getMagazine.sqf";
PCLF_getOptics = compileFinal preprocessFileLineNumbers "scripts\gameplay_templates\functions\PCLF_fnc_getOptics.sqf";
PCLF_getVest = compileFinal preprocessFileLineNumbers "scripts\gameplay_templates\functions\PCLF_fnc_getVest.sqf";
PCLF_getUniform = compileFinal preprocessFileLineNumbers "scripts\gameplay_templates\functions\PCLF_fnc_getUniform.sqf";
PCLF_getPrimaryWeapon = compileFinal preprocessFileLineNumbers "scripts\gameplay_templates\functions\PCLF_fnc_getPrimaryWeapon.sqf";
PCLF_getDevices = compileFinal preprocessFileLineNumbers "scripts\gameplay_templates\functions\PCLF_fnc_getDevices.sqf";
PCLF_unlockWeapon = compileFinal preprocessFileLineNumbers "scripts\gameplay_templates\functions\PCLF_fnc_unlockWeapon.sqf";
PCLF_unlockVest = compileFinal preprocessFileLineNumbers "scripts\gameplay_templates\functions\PCLF_fnc_unlockVest.sqf";

GRLIB_weapon_classes = ["aa", "lat", "hat", "rifle", "riflegl", "carbine", "carbinegl", "lmg", "mg", "pistol", "smg", "marksman", "sniper"];

// All varibles below must be exposed by arsenal template
GRLIB_arsenal_blufor = createHashMap;
GRLIB_arsenal_starting_weapons = [];

GRLIB_arsenal_opfor_low = createHashMap;
GRLIB_arsenal_opfor_hi = createHashMap;

GRLIB_arsenal_wpn_unlocks_per_box = floor (10 / (2 * GRLIB_difficulty_modifier));
if (GRLIB_arsenal_wpn_unlocks_per_box < 3) then {GRLIB_arsenal_wpn_unlocks_per_box = 3};
GRLIB_arsenal_vest_unlocks_per_box = 2;


// Choose and process appropriate BLUFOR weapons preset
_arsenal = [GRLIB_blufor_preset] call compile preprocessFileLineNumbers "scripts\gameplay_templates\arsenal\main.sqf";
GRLIB_common_items = call compile preprocessFileLineNumbers "scripts\gameplay_templates\arsenal\common_items.sqf";

GRLIB_arsenal_blufor set ["weapons", _arsenal select 0];
GRLIB_arsenal_starting_weapons = _arsenal select 1;
GRLIB_arsenal_blufor set ["mags", _arsenal select 2];
GRLIB_arsenal_blufor set ["optics", _arsenal select 3];
GRLIB_arsenal_blufor set ["uniforms", _arsenal select 4];
GRLIB_arsenal_blufor set ["vests", _arsenal select 5];
GRLIB_arsenal_blufor set ["devices", _arsenal select 6];
GRLIB_arsenal_blufor set ["explosives", (_arsenal select 7) get "explosives"];
GRLIB_arsenal_blufor set ["grenadesfrag", (_arsenal select 7) get "grenadefrag"];
GRLIB_arsenal_blufor set ["grenadesmoke", (_arsenal select 7) get "grenadesmoke"];
GRLIB_arsenal_blufor set ["grenadesother", (_arsenal select 7) get "grenadeother"];


{["", _x, "any"] call PCLF_unlockWeapon} forEach GRLIB_arsenal_starting_weapons;

for "_i" from 0 to GRLIB_arsenal_vest_unlocks_per_box do {
    ["any", "any"] call PCLF_unlockVest;
};

[ missionNamespace, (GRLIB_arsenal_blufor get "grenadesfrag"), true ] call BIS_fnc_addVirtualMagazineCargo;
[ missionNamespace, (GRLIB_arsenal_blufor get "grenadesmoke"), true ] call BIS_fnc_addVirtualMagazineCargo;
[ missionNamespace, (GRLIB_arsenal_blufor get "grenadesother"), true ] call BIS_fnc_addVirtualMagazineCargo;
[ missionNamespace, (GRLIB_arsenal_blufor get "explosives"), true ] call BIS_fnc_addVirtualMagazineCargo;

[ missionNamespace, (GRLIB_common_items get "gp25_he"), true ] call BIS_fnc_addVirtualMagazineCargo;
[ missionNamespace, (GRLIB_common_items get "gp25_other"), true ] call BIS_fnc_addVirtualMagazineCargo;
[ missionNamespace, (GRLIB_common_items get "m203_he"), true ] call BIS_fnc_addVirtualMagazineCargo;
[ missionNamespace, (GRLIB_common_items get "m203_other"), true ] call BIS_fnc_addVirtualMagazineCargo;

[ missionNamespace, (GRLIB_common_items get "backpack"), true ] call BIS_fnc_addVirtualBackpackCargo;
[ missionNamespace, (GRLIB_common_items get "binoculars"), true ] call BIS_fnc_addVirtualItemCargo;
[ missionNamespace, (GRLIB_common_items get "common"), true ] call BIS_fnc_addVirtualItemCargo;

if (GRLIB_ace) then {
    _ACEItems = call compile preprocessFileLineNumbers "scripts\gameplay_templates\arsenal\ace_items.sqf";
//     [missionNamespace, (_ACEItems get "aceitem"), true] call BIS_fnc_addVirtualItemCargo;
    (keys _ACEItems) apply {
        [missionNamespace, (_ACEItems get _x), true] call BIS_fnc_addVirtualItemCargo;
    };
    [missionNamespace, (_ACEItems get "acegrenade"), true] call BIS_fnc_addVirtualMagazineCargo;
    GRLIB_common_items merge _ACEItems;
} else {
    [ missionNamespace, (GRLIB_common_items get "medicinefak"), true ] call BIS_fnc_addVirtualItemCargo;
    [ missionNamespace, (GRLIB_common_items get "medicinepak"), true ] call BIS_fnc_addVirtualItemCargo;
};

// Process BLUFOR squad preset
GRLIB_blufor_base_soldier_class = (_arsenal select 8) select 0;
GRLIB_blufor_roles = (_arsenal select 8) select 1;
GRLIB_blufor_squad_comp = (_arsenal select 8) select 2;

// Process BLUFOR vehicles preset
// Init vehicle progression (i.e. PMC-related unlocks), so we get rid of weights in BLUFOR veh arsenal
/* There are two variables per vehicle class: "unlocked" and "available" giving 4 possible states:
 * 1. Unlocked(false), available(false) - veh is not shown in build menu at all
 * 2. Unlocked(true), available(true) - veh is shown in build menu and available for ordering if there are enough resources
 * 3. Unlocked(true), available(false) - veh is shown in menu as "upgrade available", which indicates that it is not possible to order a vehicle until upgrade cost is paid
 * 4. Unlocked(true), available(false) - veh is shown in menu as "locked: conditions are not met", it is not possible to order or upgrade until certain conditions are satisfied
*/
private _vehs = createHashMap;
{
    for "_i" from 0 to (count _y)-1 step 2 do {
        private _veh = _y select _i;
        if (_veh get "unlocked") then {
            _veh set ["available", true];
        };
        _vehs set [(_veh get "type"), _veh];
    };
} forEach (_arsenal select 9);

GRLIB_arsenal_blufor set ["vehicles", _vehs];

// Choose OPFOR LOW preset
_ret = [GRLIB_opfor_preset_low] call compile preprocessFileLineNumbers "scripts\gameplay_templates\arsenal\main.sqf";
GRLIB_arsenal_opfor_low set ["weapons", _ret select 0];
GRLIB_arsenal_opfor_low set ["mags", _ret select 2];
GRLIB_arsenal_opfor_low set ["optics", _ret select 3];
GRLIB_arsenal_opfor_low set ["uniforms", _ret select 4];
GRLIB_arsenal_opfor_low set ["vests", _ret select 5];
GRLIB_arsenal_opfor_low set ["devices", _ret select 6];
GRLIB_arsenal_opfor_low set ["explosives", (_ret select 7) get "explosives"];
GRLIB_arsenal_opfor_low set ["grenadesfrag", (_ret select 7) get "grenadefrag"];
GRLIB_arsenal_opfor_low set ["grenadesmoke", (_ret select 7) get "grenadesmoke"];
GRLIB_arsenal_opfor_low set ["grenadesother", (_ret select 7) get "grenadeother"];

GRLIB_opfor_low_base_soldier_class = (_ret select 8) select 0;
GRLIB_opfor_low_roles = (_ret select 8) select 1;
GRLIB_opfor_low_squad_comp = (_ret select 8) select 2;
GRLIB_opfor_low_vehicles = _ret select 9;


//
//
// Choose OPFOR Hi preset
// _dir = [GRLIB_opfor_preset_high] call _initArsenal;
// _arsenal = execVM format ["scripts\gameplay_templates\arsenal\%1\main.sqf", _dir];
// _squads = execVM format ["scripts\gameplay_templates\arsenal\%1\squads.sqf", _dir];


