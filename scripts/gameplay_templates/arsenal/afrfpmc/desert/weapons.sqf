private _weapons_hash = createHashMap;

/*
 * 100 / (
 * RIS mount: /1.5;
 * Rareness: modern /2; specops used: /1.5; unusual hardware: /3.5;
 * Mounts: allows muzzle devs: /1.5; has preinstalled optics: /1.5; allows optics: /2;
 * front rail: /1,5; can mount grip/bipod: /1.5;
 * Integrated hardware: bipod: /2, int.toprail: /2, GL /2.5, int.front grip: /2;
 * Mechanics: balanced /4; high ROF: /2;
 * silenced: /1.5;
 * powerful cartridge: /2;
 * hi-cap mag: /2 (for pistols, precision rifles and shotguns)
 * )
*/


private _aas = [

];
_weapons_hash set ["aa", _aas];

private _carbines = [

    ["rhs_weap_m4a1_d", "AR15", "RIS", "desert", true, true],     0.8230452674897121,
    ["CUP_arifle_G36C_VFG_camo", "G36", "RIS", "desert", true, false],     1.234567901234568
];
_weapons_hash set ["carbine", _carbines];

private _carbinegls = [

];
_weapons_hash set ["carbinegl", _carbinegls];

private _hats = [

    ["launch_RPG32_F", "RPG32", "None", "desert", false, false],     1,
    ["launch_O_Vorona_brown_F", "Metis", "None", "desert", false, false],     0.2
];
_weapons_hash set ["hat", _hats];

private _lats = [

];
_weapons_hash set ["lat", _lats];

private _lmgs = [

];
_weapons_hash set ["lmg", _lmgs];

private _mgs = [

    ["CUP_lmg_Pecheneg_desert", "PK", "Dovetail", "desert", true, false],     8.333333333333334
];
_weapons_hash set ["mg", _mgs];

private _marksmans = [

    ["CUP_srifle_SVD_des", "SVD", "Dovetail", "desert", true, false],     33.333333333333336,
    ["CUP_srifle_SVD_des_top_rail", "SVD", "RIS", "desert", true, false],     22.222222222222225
];
_weapons_hash set ["marksman", _marksmans];

private _pistols = [

    ["hgun_P07_F", "P99", "None", "desert", true, false],     16.666666666666668,
    ["CUP_hgun_Glock17_tan", "G17", "Glock", "desert", true, false],     5.555555555555556
];
_weapons_hash set ["pistol", _pistols];

private _rifles = [

    ["rhs_weap_ak74m_desert", "AK74", "Dovetail", "desert", true, false],     16.666666666666668,
    ["rhs_weap_ak74m_desert_npz", "AK74", "RIS", "desert", true, false],     11.111111111111112,
    ["CUP_arifle_AKMN_railed_desert", "AK", "RIS", "desert", true, true],     4.938271604938272,
    ["CUP_arifle_AK74M_railed_desert", "AK74", "RIS", "desert", true, true],     2.469135802469136,
    ["arifle_AK12_arid_F", "AK", "RIS", "desert", true, true],     0.7054673721340388,
    ["CUP_arifle_DSA_SA58_OSW_VFG_Desert", "FAL", "RIS", "desert", true, true],     0.41152263374485604
];
_weapons_hash set ["rifle", _rifles];

private _riflegls = [

    ["CUP_arifle_AK74M_GL_railed_desert", "AK74", "RIS", "desert", true, false],     2.9629629629629632,
    ["arifle_AK12_GL_arid_F", "AK", "RIS", "desert", true, false],     0.42328042328042326,
    ["CUP_arifle_Sa58RIS2_gl_desert", "SA58", "RIS", "desert", true, false],     2.9629629629629632
];
_weapons_hash set ["riflegl", _riflegls];

private _smgs = [

    ["SMG_03C_khaki", "P90", "None", "desert", false, false],     8.333333333333334,
    ["SMG_03C_TR_khaki", "P90", "RIS", "desert", false, false],     0.925925925925926
];
_weapons_hash set ["smg", _smgs];

private _snipers = [

    ["rhs_weap_m24sws_d", "M24", "RIS", "desert", true, true],     3.703703703703704,
    ["srifle_LRR_camo_F", "M200", "RIS", "desert", false, false],     0.5952380952380952,
    ["hlc_rifle_awmagnum_FDE", "AWM", "RIS", "desert", false, false],     1.388888888888889
];
_weapons_hash set ["sniper", _snipers];


private _starting = [
["CUP_lmg_Pecheneg_desert", "PK", "Dovetail", "desert", true, false], ["CUP_srifle_SVD_des", "SVD", "Dovetail", "desert", true, false]
];

[_weapons_hash, _starting]
