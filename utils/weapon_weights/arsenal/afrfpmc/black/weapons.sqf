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

private _ats = [

    ["launch_RPG32_ghex_F", "RPG32", "None", "black", "false", "false", "false", "false"],     1
];
_weapons_hash set ["at", _ats];

private _carbines = [

    ["rhs_weap_m4a1", "AR15", "RIS", "black", "true", "true", "false", "false"],     1.6460905349794241,
    ["rhs_weap_g36c", "G36", "RIS", "black", "true", "true", "false", "false"],     1.6460905349794241
];
_weapons_hash set ["carbine", _carbines];

private _carbinegls = [

];
_weapons_hash set ["carbinegl", _carbinegls];

private _lmgs = [

];
_weapons_hash set ["lmg", _lmgs];

private _mgs = [

    ["rhs_weap_pkp", "PK", "Dovetail", "black", "false", "false", "true", "false"],     12.5,
    ["CUP_lmg_Pecheneg_top_rail_B50_vfg", "PK", "RIS", "black", "true", "false", "true", "true"],     1.851851851851852
];
_weapons_hash set ["mg", _mgs];

private _marksmans = [

    ["rhs_weap_svdp", "SVD", "Dovetail", "black", "true", "false", "false", "false"],     16.666666666666668,
    ["rhs_weap_svdp_npz", "SVD", "RIS", "black", "true", "false", "false", "false"],     11.111111111111112
];
_weapons_hash set ["marksman", _marksmans];

private _pistols = [

    ["hgun_P07_blk_F", "P99", "None", "black", "true", "false", "false", "false"],     16.666666666666668,
    ["rhsusf_weap_glock17g4", "G17", "None", "black", "true", "false", "false", "false"],     11.111111111111112
];
_weapons_hash set ["pistol", _pistols];

private _rifles = [

    ["CUP_arifle_AKMN_railed", "AK", "RIS", "black", "true", "true", "false", "true"],     4.938271604938272,
    ["rhs_weap_akm_zenitco01_b33", "AK", "RIS", "black", "true", "true", "false", "false"],     4.938271604938272,
    ["hlc_rifle_ak74m", "AK74", "Dovetail", "black", "true", "false", "false", "false"],     16.666666666666668,
    ["rhs_weap_ak74m_zenitco01", "AK74", "Dovetail", "black", "true", "true", "false", "false"],     11.111111111111112,
    ["CUP_arifle_AK74M_railed", "AK74", "RIS", "black", "true", "true", "false", "true"],     2.469135802469136,
    ["arifle_AK12_F", "AK", "RIS", "black", "true", "true", "false", "false"],     0.7054673721340388,
    ["CUP_arifle_DSA_SA58_DMR", "FAL", "RIS", "black", "true", "true", "false", "true"],     0.41152263374485604,
    ["rhs_weap_savz58p_rail_black", "SA58", "RIS", "black", "false", "false", "false", "false"],     8.333333333333334
];
_weapons_hash set ["rifle", _rifles];

private _riflegls = [

    ["rhs_weap_akmn_gp25_npz", "AK", "RIS", "black", "true", "false", "false", "false"],     8.88888888888889,
    ["hlc_rifle_ak74m_gl", "AK74", "Dovetail", "black", "true", "false", "false", "false"],     6.666666666666667,
    ["CUP_arifle_AK74M_GL_railed", "AK74", "RIS", "black", "true", "false", "false", "false"],     2.9629629629629632,
    ["arifle_AK12_GL_F", "AK", "RIS", "black", "true", "false", "false", "false"],     0.42328042328042326,
    ["CUP_arifle_Sa58RIS2_gl", "SA58", "RIS", "black", "true", "false", "false", "false"],     1.4814814814814816
];
_weapons_hash set ["riflegl", _riflegls];

private _smgs = [

    ["SMG_03C_black", "P90", "None", "black", "false", "false", "false", "true"],     8.333333333333334,
    ["SMG_03C_TR_black", "P90", "RIS", "black", "false", "false", "false", "true"],     0.925925925925926
];
_weapons_hash set ["smg", _smgs];

private _snipers = [

    ["rhs_weap_m24sws", "M24", "RIS", "black", "true", "true", "false", "false"],     3.703703703703704,
    ["srifle_LRR_F", "M200", "RIS", "black", "false", "false", "true", "false"],     0.5952380952380952,
    ["hlc_rifle_awmagnum_BL", "AWM", "RIS", "black", "false", "false", "true", "false"],     1.388888888888889
];
_weapons_hash set ["sniper", _snipers];


private _starting = [
["rhs_weap_svdp", "SVD", "Dovetail", "black", "true", "false", "false", "false"]
];

[_weapons_hash, _starting]
