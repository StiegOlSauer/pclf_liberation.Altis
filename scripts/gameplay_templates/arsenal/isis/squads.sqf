private [
    "_base_soldier_class", "_tl", "_rifleman", "_tl_hvy", "_rifleman_hvy", "_rifleman_gl", "_rifleman_gl_hvy", "_rifleman_sharp", "_marksman",
    "_lat", "_hat", "_aa", "_medic", "_lmg", "_mg", "_mg_assistant", "_sniper", "_spec_tl", "_spec_rfl", "_spec_gl", "_spec_mark", "_spec_sniper", "_spec_mg", "_crew_smg", "_crew_carbine",
    "_base_squad", "_light_squad", "_heavy_squad", "_spec_ft", "_sniper_ft", "_spec_sniper_ft", "_at_squad", "_aa_squad", "_patrol_squad", "_sentry_squad", "_ambush_squad",
    "_roles", "_squads",
    "_squads_inf", "_squads_at", "_squads_aa", "_squads_spec_inf", "_crew_squad"
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
        grip_device bool,
    ],
    grenades,
    sidearm bool,
    vest_type str["None", "normal", "heavy"],
    backpack bool,
    trait str["tl", "medic", "gl", "lat", "hat", "aa", "mg_assistant", "trained", "specops"]
];

Traits:
    * tl - grenades are replaces with smoke
    * medic - backpack is filled with medical supplies
    * gl - grenades are replaced with GL ammunition
    * lat - light AT as secondary weapon
    * hat - heavy AT as secondary weapon
    * aa - AA as secondary weapon
    * mg_assistant - backpack is filled with MG bearer ammunition
    * crew - doesn't wear headgear (FIXME!) and vest. Lightly armed.
    * trained - skill is increased by 20%
    * specops - skill is increased by 50%
 */
_tl = ["tl", ["carbine", 4, "combat", false, true], 2, true, "normal", false, ["tl"]];
_tl_hvy = ["tl_heavy", ["carbine", 4, "combat", false, true], 4, true, "heavy", false, ["tl"]];
_rifleman_light = ["rifleman_light", ["carbine", 5, "holo", false, false], 3, false, "normal", false, []];
_rifleman = ["rifleman", ["rifle", 6, "holo", false, false], 3, false, "normal", false, []];
_rifleman_hvy = ["rifleman_heavy", ["rifle", 6, "holo", false, false], 3, false, "normal", false, ["trained"]];
_rifleman_gl = ["grenadier", ["riflegl", 6, "holo", false, false], 8, false, "normal", true, ["gl"]];
_rifleman_gl_hvy = ["grenadier_heavy", ["riflegl", 6, "holo", false, false], 8, false, "heavy", true, ["gl", "trained"]];
_rifleman_sharp = ["sharpshooter", ["rifle", 5, "combat", false, true], 2, false, "normal", false, ["trained"]];
_marksman = ["marksman", ["marksman", 8, "combat", false, true], 0, true, "normal", false, []];
_lat = ["lat", ["carbine", 5, "holo", false, false], 0, false, "normal", false, ["lat"]];
_hat = ["hat", ["rifle", 5, "None", false, false], 0, false, "heavy", true, ["hat", "trained"]];
_aa = ["aa", ["carbine", 5, "None", false, false], 0, false, "heavy", false, ["aa"]];
_medic = ["medic", ["carbine", 5, "None", false, false], 2, false, "normal", true, ["medic"]];
_lmg = ["lmg", ["lmg", 5, "holo", false, false], 0, false, "normal", false, []];
_mg = ["mg", ["mg", 2, "combat", false, false], 0, false, "normal", false, []];
_mg_assistant = ["mg_assistant", ["rifle", 4, "holo", false, false], 0, false, "normal", true, ["mg_assistant"]];
_sniper = ["sniper", ["sniper", 6, "sniper", false, true], 0, true, "normal", false, []];

_crew_smg = ["crew_smg", ["smg", 3, "None", false, false], 0, false, "normal", false, ["crew"]];
_crew_carbine = ["crew_carbine", ["carbine", 2, "None", false, false], 0, false, "normal", false, ["crew"]];

_spec_tl = ["spec_tl", ["carbinegl", 5, "combat", true, true], 4, true, "heavy", false, ["specops", "tl"]];
_spec_rfl = ["spec_rifleman", ["rifle", 8, "combat", true, true], 3, false, "heavy", true, ["specops"]];
_spec_gl = ["spec_grenadier", ["riflegl", 6, "holo", true, true], 10, false, "heavy", true, ["specops", "gl"]];
_spec_mark = ["spec_marksman", ["marksman", 7, "combat", true, true], 2, true, "normal", false, ["specops"]];
_spec_sniper = ["spec_sniper", ["sniper", 7, "sniper", true, true], 0, true, "normal", false, ["specops"]];
_spec_mg = ["spec_mg", ["lmg", 4, "combat", true, true], 2, false, "heavy", true, ["specops"]];

_base_squad = [_tl, _rifleman, _marksman, _lat, _rifleman_gl, _mg, _mg_assistant, _medic];
_light_squad = [_tl, _rifleman, _rifleman_gl, _lmg, _lmg, _lat, _lat, _rifleman_sharp];
_heavy_squad = [_tl_hvy, _rifleman_hvy, _marksman, _hat, _rifleman_gl_hvy, _mg, _lat, _rifleman_sharp];
_sniper_ft = [_tl_hvy, _marksman, _sniper, _rifleman];
_at_squad = [_tl, _rifleman_gl, _rifleman_sharp, _hat, _hat, _lat, _lat, _lmg];
_aa_squad = [_tl, _rifleman_gl, _rifleman_sharp, _lat, _lat, _aa, _aa, _lmg];
_spec_ft = [_spec_tl, _spec_rfl, _spec_gl, _spec_mg];
_spec_sniper_ft = [_spec_tl, _spec_mark, _spec_sniper, _spec_rfl];

// squads for specific tasks
_patrol_squad = [_rifleman_gl, _rifleman_light, _rifleman_light, _rifleman_sharp];
_sentry_squad = [_marksman, _sniper, _lmg, _mg];
_ambush_squad = [];
_crew_squad = [_crew_smg, _crew_carbine];

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

_squads_inf = [_base_squad, 1, _light_squad, 2, _heavy_squad, 0.3, _sniper_ft, 0.1]; // weigted squads for correct randomization. Lower the weight - lower spawn chance
_squads_at = [_at_squad, 1];
_squads_aa = [_aa_squad, 1];
_squads_spec_inf = [_spec_ft, 1, _spec_sniper_ft, 0.2];

_squads = createHashMapFromArray [
            ["regular", [_squads_inf, _squads_at, _squads_aa]],                 // conventional squads [anti-infantry, anti-tank, anti-air]
            ["patrol", _patrol_squad],
            ["guard", _sentry_squad],
            ["ambush", _ambush_squad],
            ["crew", _crew_squad]
];

[
    _base_soldier_class,    // base class for spawning and re-arming, needed for correct voice and visual appearance
    _roles,
    _squads
]
