private [
    "_base_soldier_class", "_tl", "_rifleman", "_tl_hvy", "_rifleman_hvy", "_rifleman_gl", "_rifleman_gl_hvy", "_rifleman_sharp", "_marksman",
    "_lat", "_hat", "_aa", "_medic", "_lmg", "_mg", "_mg_assistant", "_sniper", "_spec_tl", "_spec_rfl", "_spec_gl", "_spec_mark", "_spec_sniper", "_spec_mg",
    "_base_squad", "_light_squad", "_heavy_squad", "_spec_ft", "_sniper_ft", "_spec_sniper_ft", "_at_squad", "_aa_squad", "_roles", "_squas"
];

_base_soldier_class = "rhs_msv_emr_rifleman";
/*
 * Soldier roles definition
role = [
    name str,
    [
        pri_weapon_class str,
        # mags int,
        optics str["None", "holo", "combat", "sniper"],
        muzzle_device bool,
        grip_device bool,
    ],
    grenades,
    sidearm bool,
    heavy_weapon str["None", "aa", "at"],
    vest_type str["None", "normal", "heavy"],
    backpack bool,
    trait str["tl", "medic", "gl", "mg_assistant", "trained", "specops"]
];

Traits:
    * tl - grenades are replaces with smoke
    * medic - backpack is filled with medical supplies
    * gl - grenades are replaced with GL ammunition
    * mg_assistant - backpack is filled with MG bearer ammunition
    * trained - skill is increased by 20%
    * specops - skill is increased by 50%
 */
_tl = ["tl", ["carbine", 4, "combat", false, true], 2, true, "None", "normal", false, "tl"];
_tl_hvy = ["tl_heavy", ["carbine", 4, "combat", false, true], 4, true, "None", "heavy", false, "tl"];
_rifleman = ["rifleman", ["rifle", 6, "holo", false, false], 3, false, "None", "normal", false, ""];
_rifleman_hvy = ["rifleman_heavy", ["rifle", 6, "holo", false, false], 3, false, "None", "normal", false, "trained"];
_rifleman_gl = ["grenadier", ["riflegl", 6, "holo", false, false], 8, false, "None", "normal", true, "gl"];
_rifleman_gl_hvy = ["grenadier_heavy", ["rifle_gl", 6, "holo", false, false], 8, false, "None", "heavy", true, "gl"];
_rifleman_sharp = ["sharpshooter", ["rifle", 5, "combat", false, true], 2, false, "None", "normal", false, ""];
_marksman = ["marksman", ["marksman", 8, "combat", false, true], 0, true, "None", "normal", false, ""];
_lat = ["lat", ["carbine", 5, "holo", false, false], 0, false, "at", "normal", false, ""];
_hat = ["hat", ["rifle", 5, "None", false, false], 0, false, "at", "heavy", true, "trained"];
_aa = ["aa", ["carbine", 5, "None", false, false], 0, false, "aa", "heavy", false, ""];
_medic = ["medic", ["carbine", 5, "None", false, false], 2,false, "normal", true, "medic"];
_lmg = ["lmg", ["lmg", 5, "holo", false, false], 0, false, "normal", false, ""];
_mg = ["mg", ["mg", 2, "combat", false, false], 0, false, "normal", false, ""];
_mg_assistant = ["mg_assistant", ["rifle", 4, "holo", false, false], 0, false, "normal", true, "mg_assistant"];
_sniper = ["sniper", ["sniper", 6, "sniper", false, true], 0, true, "None", "None", false, ""];
_spec_tl = ["spec_tl", ["carbinegl", 5, "combat", true, true], 4, true, "None", "heavy", false, "specops"];
_spec_rfl = ["spec_rifleman", ["rifle", 8, "combat", true, true], 3, false, "at", "heavy", true, "specops"];
_spec_gl = ["spec_grenadier", ["riflegl", 6, "holo", true, true], 10, false, "None", "heavy", true, "specops"];
_spec_mark = ["spec_marksman", ["marksman", 7, "combat", true, true], 2, true, "None", "normal", false, "specops"];
_spec_sniper = ["spec_sniper", ["sniper", 7, "sniper", true, true], 0, true, "None", "normal", false, "specops"];
_spec_mg = ["spec_mg", ["lmg", 4, "combat", true, true], 2, false, "heavy", true, "specops"];

_base_squad = [_tl, _rifleman, _marksman, _lat, _rifleman_gl, _mg, _mg_assistant, _medic];
_light_squad = [_tl, _rifleman, _rifleman_gl, _lmg, _lmg, _lat, _lat, _rifleman_sharp];
_heavy_squad = [_tl_hvy, _rifleman_hvy, _marksman, _hat, _rifleman_gl_hvy, _mg, _lat, _rifleman_sharp];
_sniper_ft = [_tl_hvy, _marksman, _sniper, _rifleman];
_at_squad = [_tl, _rifleman_gl, _rifleman_sharp, _hat, _hat, _lat, _lat, _lmg];
_aa_squad = [_tl, _rifleman_gl, _rifleman_sharp, _lat, _lat, _aa, _aa, _lmg];
_spec_ft = [_spec_tl, _spec_rfl, _spec_gl, _spec_mg];
_spec_sniper_ft = [_spec_tl, _spec_mark, _spec_sniper, _spec_rfl];

_roles = createHashMapFromArray [
            ["tl", _tl], ["tl_heavy", _tl_hvy],
            ["rifleman", _rifleman], ["rifleman_heavy", _rifleman_hvy], ["grenadier", _rifleman_gl],
            ["grenadier_heavy", _rifleman_gl_hvy], ["sharpshooter", _rifleman_sharp],
            ["marksman", _marksman], ["sniper", _sniper],
            ["lat", _lat], ["hat", _hat], ["aa", _aa], ["medic", _medic],
            ["lmg", _lmg], ["mg", _mg], ["mg_assistant", _mg_assistant],
            ["spec_tl", _spec_tl], ["spec_rifleman", _spec_rfl], ["spec_grenadier", _spec_gl],
            ["spec_marksman", _spec_mark], ["spec_sniper", _spec_sniper], ["spec_mg", _spec_mg]
];
_squads = createHashMapFromArray [
            ["base", _base_squad], ["light", _light_squad], ["heavy", _heavy_squad], ["sniper", _sniper_ft],
            ["at", _at_squad], ["aa", _aa_squad], ["specops", _spec_ft], ["specops_sniper", _spec_sniper_ft]
];

[_base_soldier_class, _roles, _squads]

// comment "[!] UNIT MUST BE LOCAL [!]";
// if (!local this) exitWith {};
//
// comment "Remove existing items";
// removeAllWeapons this;
// removeAllItems this;
// removeAllAssignedItems this;
// removeUniform this;
// removeVest this;
// removeBackpack this;
// removeHeadgear this;
// removeGoggles this;
//
// comment "Add weapons";
// this addWeapon "rhs_weap_ak74m";
// this addPrimaryWeaponItem "rhs_acc_dtk";
// this addPrimaryWeaponItem "rhs_acc_1pn93_1";
// this addPrimaryWeaponItem "rhs_30Rnd_545x39_7N10_AK";
//
// comment "Add containers";
// this forceAddUniform "rhs_uniform_msv_emr";
// this addVest "rhs_6b23_digi_6sh92";
//
// comment "Add items to containers";
// this addItemToUniform "FirstAidKit";
// for "_i" from 1 to 2 do {this addItemToUniform "rhs_30Rnd_545x39_7N10_AK";};
// this addItemToUniform "rhs_mag_rgn";
// for "_i" from 1 to 5 do {this addItemToVest "rhs_30Rnd_545x39_7N10_AK";};
// this addItemToVest "rhs_mag_rgn";
// this addHeadgear "rhs_6b27m_digi";
//
// comment "Add items";
// this linkItem "ItemMap";
// this linkItem "ItemCompass";
// this linkItem "ItemWatch";
// this linkItem "ItemRadio";
//
// comment "Set identity";
// [this,"RHS_GreekHead_A3_08","male02rus"] call BIS_fnc_setIdentity;

