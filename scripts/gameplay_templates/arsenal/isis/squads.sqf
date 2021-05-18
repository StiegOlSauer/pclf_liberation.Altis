private [
  "_tl","_tl_heavy","_rifleman_light","_rifleman","_rifleman_heavy","_grenadier","_grenadier_heavy","_sharpshooter","_marksman","_lat","_hat","_aa","_medic","_lmg","_mg","_sniper","_crew_smg","_crew_carbine","_spec_tl","_spec_rifleman_light","_spec_rifleman","_spec_grenadier","_spec_marksman","_spec_sniper","_spec_mg","_spec_sharpshooter","_spec_lat","_spec_hat","_spec_aa","_spec_medic","_spec_lmg",
  "_aa_sq","_ambush_sq","_at_sq","_base_sq","_crew_comp","_heavy_sq","_light_sq","_patrol_sq","_sentry_comp","_sniper_ft","_spec_ft","_spec_sniper_ft",
  "_squads_inf", "_squads_at", "_squads_aa", "_squads_spec_inf", "_base_soldier_class", "_roles", "_squads"
];

_base_soldier_class = "LOP_ISTS_OPF_Infantry_Rifleman_7";
/*
 * Soldier roles definition
role = [
    name str,
    [
        pri_weapon_class str,
        # mags int,
        optics str["None", "holo", "combat", "sniper"],
        muzzle_device bool,
        frontgrip_device bool,
    ],
    grenades,
    vest_type str["None", "normal", "heavy"],
    backpack bool,
    trait str["tl", "medic", "gl", "lat", "hat", "aa", "mg_assistant", "trained", "specops"]
];

Traits:
    * tl - grenades are replaces with smoke, uses sidearm
    * medic - backpack is filled with medical supplies
    * gl - grenades are replaced with GL ammunition
    * lat - light AT as secondary weapon
    * hat - heavy AT as secondary weapon
    * aa - AA as secondary weapon
    * mg_assistant - backpack is filled with MG bearer ammunition
    * crew - doesn't wear vest. Lightly armed.
    * trained - skill is increased by 20%
    * specops - skill is increased by 50%
 */


_tl = ["tl", ["carbine", 5, "combat", false, true], 3, "normal", false, ["tl"]];
_tl_heavy = ["tl_heavy", ["carbine", 6, "combat", false, true], 4, "heavy", false, ["tl"]];
_rifleman_light = ["rifleman_light", ["carbine", 5, "holo", false, false], 3, "normal", false, []];
_rifleman = ["rifleman", ["rifle", 6, "holo", false, false], 3, "normal", false, []];
_rifleman_heavy = ["rifleman_heavy", ["rifle", 6, "holo", false, false], 3, "heavy", false, ["trained"]];
_grenadier = ["grenadier", ["riflegl", 6, "holo", false, false], 8, "normal", true, ["gl"]];
_grenadier_heavy = ["grenadier_heavy", ["riflegl", 6, "holo", false, false], 12, "heavy", true, ["gl","trained"]];
_sharpshooter = ["sharpshooter", ["rifle", 5, "combat", false, true], 2, "normal", false, ["trained"]];
_marksman = ["marksman", ["marksman", 5, "combat", false, true], 0, "normal", false, []];
_lat = ["lat", ["carbine", 5, "holo", false, false], 0, "normal", false, ["lat"]];
_hat = ["hat", ["rifle", 4, "None", false, false], 0, "heavy", true, ["hat","trained"]];
_aa = ["aa", ["carbine", 4, "None", false, false], 0, "normal", false, ["aa"]];
_medic = ["medic", ["carbine", 5, "None", false, false], 4, "normal", true, ["medic"]];
_lmg = ["lmg", ["lmg", 5, "holo", false, false], 2, "normal", false, []];
_mg = ["mg", ["mg", 2, "combat", false, false], 0, "normal", false, []];
_sniper = ["sniper", ["sniper", 6, "sniper", false, true], 0, "normal", false, ["trained"]];
_crew_smg = ["crew_smg", ["smg", 3, "None", false, false], 0, "normal", false, ["crew"]];
_crew_carbine = ["crew_carbine", ["carbine", 2, "None", false, false], 0, "normal", false, ["crew"]];
_spec_tl = ["spec_tl", ["carbinegl", 6, "combat", true, true], 5, "heavy", false, ["tl","specops"]];
_spec_rifleman_light = ["spec_rifleman_light", ["carbine", 5, "holo", false, false], 3, "normal", false, ["specops"]];
_spec_rifleman = ["spec_rifleman", ["rifle", 7, "combat", true, true], 4, "heavy", true, ["specops"]];
_spec_grenadier = ["spec_grenadier", ["riflegl", 6, "holo", true, true], 12, "heavy", true, ["specops","gl"]];
_spec_marksman = ["spec_marksman", ["marksman", 6, "combat", true, true], 2, "normal", false, ["specops"]];
_spec_sniper = ["spec_sniper", ["sniper", 6, "sniper", true, true], 0, "normal", false, ["specops"]];
_spec_mg = ["spec_mg", ["mg", 2, "combat", true, true], 2, "heavy", true, ["specops"]];
_spec_sharpshooter = ["spec_sharpshooter", ["rifle", 5, "combat", true, true], 2, "normal", false, ["specops"]];
_spec_lat = ["spec_lat", ["carbine", 5, "holo", true, true], 0, "normal", false, ["lat","specops"]];
_spec_hat = ["spec_hat", ["rifle", 4, "None", true, true], 0, "heavy", true, ["hat","specops"]];
_spec_aa = ["spec_aa", ["carbine", 4, "None", true, true], 0, "heavy", false, ["specops","aa"]];
_spec_medic = ["spec_medic", ["carbine", 5, "holo", true, true], 4, "heavy", true, ["specops","medic"]];
_spec_lmg = ["spec_lmg", ["lmg", 5, "combat", true, true], 2, "heavy", true, ["specops"]];


 _aa_sq = [_tl,_grenadier,_sharpshooter,_lat,_lat,_aa,_aa,_lmg];
 _ambush_sq = [_tl_heavy,_grenadier_heavy,_sharpshooter,_marksman,_lmg,_mg];
 _at_sq = [_tl,_grenadier,_sharpshooter,_lat,_lat,_hat,_hat,_lmg];
 _base_sq = [_tl,_rifleman,_grenadier,_marksman,_lat,_medic,_mg];
 _crew_comp = [_crew_smg,_crew_carbine];
 _heavy_sq = [_tl_heavy,_rifleman_heavy,_grenadier_heavy,_sharpshooter,_marksman,_lat,_hat,_mg];
 _light_sq = [_tl,_rifleman,_grenadier,_grenadier,_sharpshooter,_lat,_lmg,_lmg];
 _patrol_sq = [_rifleman_light,_rifleman_light,_grenadier,_sharpshooter];
 _sentry_comp = [_marksman,_lmg,_mg,_sniper];
 _sniper_ft = [_tl_heavy,_rifleman,_marksman,_sniper];
 _spec_ft = [_spec_tl,_spec_rifleman,_spec_grenadier,_spec_mg];
 _spec_sniper_ft = [_spec_tl,_spec_rifleman,_spec_marksman,_spec_sniper];

_squads_inf = [_base_sq, 1.5, _light_sq, 2, _heavy_sq, 0.5, _sniper_ft, 0.1]; // weigted squads for correct randomization. Lower the weight - lower spawn chance
_squads_at = [_at_sq, 1];
_squads_aa = [_aa_sq, 1];
_squads_spec = [_spec_ft, 1, _spec_sniper_ft, 0.2];

_roles = createHashMapFromArray [
    ["tl", _tl], ["tl_heavy", _tl_heavy], ["rifleman_light", _rifleman_light], ["rifleman", _rifleman], ["rifleman_heavy", _rifleman_heavy], ["grenadier", _grenadier], ["grenadier_heavy", _grenadier_heavy], ["sharpshooter", _sharpshooter], ["marksman", _marksman], ["lat", _lat], ["hat", _hat], ["aa", _aa], ["medic", _medic], ["lmg", _lmg], ["mg", _mg], ["sniper", _sniper], ["crew_smg", _crew_smg], ["crew_carbine", _crew_carbine], ["spec_tl", _spec_tl], ["spec_rifleman_light", _spec_rifleman_light], ["spec_rifleman", _spec_rifleman], ["spec_grenadier", _spec_grenadier], ["spec_marksman", _spec_marksman], ["spec_sniper", _spec_sniper], ["spec_mg", _spec_mg], ["spec_sharpshooter", _spec_sharpshooter], ["spec_lat", _spec_lat], ["spec_hat", _spec_hat], ["spec_aa", _spec_aa], ["spec_medic", _spec_medic], ["spec_lmg", _spec_lmg]
];

_squads = createHashMapFromArray [
            ["regular", [_squads_inf, _squads_at, _squads_aa]],    // conventional squads [anti-infantry, anti-tank, anti-air]
            ["patrol", _patrol_sq],
            ["guard", _sentry_comp],
            ["ambush", _ambush_sq],
            ["crew", _crew_comp]
];

[
    _base_soldier_class,     // base class for spawning and re-arming, needed for correct voice and visual appearance
    _roles,
    _squads
]
