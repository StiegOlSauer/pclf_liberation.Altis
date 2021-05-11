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

    ["CUP_launch_9K32Strela", "Strela", "None", "nocamo", false, false],     5
];
_weapons_hash set ["aa", _aas];

private _carbines = [

    ["rhs_weap_MP44", "MP44", "None", "nocamo", false, false],     100,
    ["rhs_weap_aks74u", "AK74", "None", "nocamo", true, false],     66.66666666666667,
    ["rhs_weap_savz58v", "SA58", "None", "nocamo", false, false],     50,
    ["rhs_weap_savz58v_rail", "SA58", "RIS", "nocamo", false, false],     8.333333333333334,
    ["CUP_arifle_Sa58RIS1", "SA58", "RIS", "nocamo", true, true],     2.469135802469136,
    ["rhs_weap_m92", "AK", "None", "nocamo", true, false],     66.66666666666667,
    ["CUP_arifle_Galil_SAR_black", "GALIL556", "RIS", "nocamo", false, false],     16.666666666666668,
    ["hlc_rifle_Colt727", "AR15", "RIS", "nocamo", true, false],     7.407407407407408,
    ["hlc_wp_mod733", "AR15", "RIS", "nocamo", true, false],     7.407407407407408,
    ["hlc_rifle_SLRchopmod", "FAL", "FAL", "nocamo", true, false],     16.666666666666668,
    ["hlc_rifle_hk51", "G3", "G3", "nocamo", true, false],     5.555555555555556,
    ["hlc_rifle_hk33ka3", "HK33", "G3", "nocamo", true, false],     33.333333333333336,
    ["hlc_rifle_hk53", "HK33", "G3", "nocamo", true, false],     16.666666666666668,
    ["hlc_rifle_hk53RAS", "HK33", "RIS", "nocamo", true, false],     1.851851851851852,
    ["hlc_rifle_g3ka4", "G3", "RIS", "nocamo", true, true],     1.234567901234568
];
_weapons_hash set ["carbine", _carbines];

private _carbinegls = [

    ["CUP_arifle_Sa58RIS2_gl", "SA58", "RIS", "nocamo", true, false],     1.4814814814814816,
    ["HLC_Rifle_g3ka4_GL", "G3", "RIS", "nocamo", true, false],     0.7407407407407408
];
_weapons_hash set ["carbinegl", _carbinegls];

private _hats = [

    ["CUP_launch_Metis", "Metis", "None", "nocamo", false, false],     0.2,
    ["CUP_launch_M47", "Dragon", "None", "nocamo", false, false],     1,
    ["rhs_weap_rpg7", "RPG7", "RPG7", "nocamo", false, false],     6
];
_weapons_hash set ["hat", _hats];

private _lats = [

    ["rhs_weap_rpg75", "None", "None", "nocamo", false, false],     25,
    ["CUP_launch_RPG18", "None", "None", "nocamo", false, false],     20,
    ["CUP_launch_M72A6", "None", "None", "nocamo", false, false],     15,
    ["rhs_weap_m72a7", "None", "None", "nocamo", false, false],     12
];
_weapons_hash set ["lat", _lats];

private _lmgs = [

    ["hlc_rifle_rpk", "AK", "Dovetail", "nocamo", true, false],     16.666666666666668,
    ["hlc_rifle_rpk74n", "AK74", "Dovetail", "nocamo", true, false],     16.666666666666668
];
_weapons_hash set ["lmg", _lmgs];

private _mgs = [

    ["rhs_weap_mg42", "MG42", "None", "nocamo", false, false],     25,
    ["rhs_weap_fnmag", "M240", "RIS", "nocamo", true, false],     2.777777777777778,
    ["rhs_weap_m84", "PK", "None", "nocamo", false, false],     25,
    ["rhs_weap_pkm", "PK", "None", "nocamo", false, false],     50,
    ["CUP_lmg_PKMN", "PK", "Dovetail", "nocamo", true, false],     16.666666666666668,
    ["hlc_lmg_m60", "M240", "None", "nocamo", false, false],     50,
    ["hlc_lmg_M60E4", "M240", "RIS", "nocamo", false, false],     1.851851851851852
];
_weapons_hash set ["mg", _mgs];

private _marksmans = [

    ["rhs_weap_m76", "M76", "Dovetail", "nocamo", true, false],     33.333333333333336,
    ["hlc_rifle_M14_Bipod", "M14", "M14", "nocamo", true, false],     33.333333333333336,
    ["hlc_rifle_M14_Bipod_Rail", "M14", "RIS", "nocamo", true, false],     11.111111111111112,
    ["hlc_rifle_M21_Rail", "M14", "RIS", "nocamo", true, false],     11.111111111111112,
    ["hlc_rifle_M14dmr_Rail", "M14", "RIS", "nocamo", true, false],     5.555555555555556,
    ["CUP_SKS_rail", "SKS", "RIS", "nocamo", false, false],     33.333333333333336,
    ["CUP_srifle_SVD", "SVD", "Dovetail", "nocamo", true, false],     33.333333333333336,
    ["CUP_srifle_SVD_top_rail", "SVD", "RIS", "nocamo", true, false],     22.222222222222225,
    ["hlc_rifle_g3sg1", "G3", "G3", "nocamo", true, false],     33.333333333333336,
    ["hlc_rifle_g3sg1ris", "G3", "RIS", "nocamo", true, false],     5.555555555555556
];
_weapons_hash set ["marksman", _marksmans];

private _pistols = [

    ["CUP_hgun_Browning_HP", "HP", "None", "nocamo", true, false],     33.333333333333336,
    ["CUP_hgun_CZ75", "CZ75", "None", "nocamo", true, false],     33.333333333333336,
    ["CUP_hgun_M9", "M9", "None", "nocamo", true, false],     16.666666666666668,
    ["CUP_hgun_Mac10", "MAC10", "None", "nocamo", true, false],     8.333333333333334,
    ["CUP_hgun_MicroUzi", "UZI", "None", "nocamo", true, false],     8.333333333333334,
    ["rhs_weap_tt33", "TT33", "None", "nocamo", false, false],     100,
    ["CUP_hgun_TEC9_FA", "TEC9", "None", "nocamo", false, false],     12.5,
    ["rhs_weap_makarov_pm", "PM", "None", "nocamo", false, false],     100,
    ["rhs_weap_savz61_folded", "VZ61", "None", "nocamo", true, false],     16.666666666666668,
    ["rhsusf_weap_m1911a1", "M1911", "None", "nocamo", false, false],     100
];
_weapons_hash set ["pistol", _pistols];

private _rifles = [

    ["rhs_weap_pm63", "AK", "None", "nocamo", true, false],     33.333333333333336,
    ["rhs_weap_akms", "AK", "None", "nocamo", true, false],     66.66666666666667,
    ["rhs_weap_akmn", "AK", "Dovetail", "nocamo", true, false],     33.333333333333336,
    ["rhs_weap_aks74", "AK74", "None", "nocamo", true, false],     66.66666666666667,
    ["rhs_weap_aks74n", "AK74", "Dovetail", "nocamo", true, false],     33.333333333333336,
    ["rhs_weap_m70ab2", "AK", "None", "nocamo", true, false],     66.66666666666667,
    ["rhs_weap_m70b1n", "AK", "Dovetail", "nocamo", true, false],     33.333333333333336,
    ["rhs_weap_m70b3n", "AK", "Dovetail", "nocamo", true, false],     33.333333333333336,
    ["CUP_arifle_TYPE_56_2_Early", "AK", "None", "nocamo", true, false],     66.66666666666667,
    ["CUP_arifle_TYPE_56_2", "AK", "Dovetail", "nocamo", true, false],     33.333333333333336,
    ["CUP_arifle_TYPE_56_2_top_rail", "AK", "RIS", "nocamo", true, false],     22.222222222222225,
    ["rhs_weap_savz58p", "SA58", "None", "nocamo", false, false],     50,
    ["rhs_weap_savz58p_rail", "SA58", "RIS", "nocamo", false, false],     8.333333333333334,
    ["rhs_weap_kar98k", "KAR98", "None", "nocamo", false, false],     100,
    ["rhs_weap_m1garand_sa43", "Garand", "None", "nocamo", false, false],     100,
    ["hlc_wp_m16A1", "AR15", "RIS", "nocamo", true, false],     22.222222222222225,
    ["hlc_wp_m16a2", "AR15", "RIS", "nocamo", true, false],     22.222222222222225,
    ["CUP_arifle_Galil_556_black", "GALIL556", "RIS", "nocamo", false, false],     16.666666666666668,
    ["CUP_arifle_Galil_black", "GALIL762", "RIS", "nocamo", false, false],     16.666666666666668,
    ["CUP_arifle_IMI_Romat_railed", "FAL", "RIS", "nocamo", true, false],     7.407407407407408,
    ["hlc_rifle_c1A1", "FAL", "FAL", "nocamo", true, false],     66.66666666666667,
    ["hlc_rifle_FAL5000", "FAL", "FAL", "nocamo", true, false],     66.66666666666667,
    ["hlc_rifle_FAL5000Rail", "FAL", "RIS", "nocamo", true, false],     11.111111111111112,
    ["hlc_rifle_FAL5061", "FAL", "FAL", "nocamo", true, false],     66.66666666666667,
    ["hlc_rifle_FAL5061Rail", "FAL", "RIS", "nocamo", true, false],     11.111111111111112,
    ["CUP_arifle_FNFAL5061_wooden_railed", "FAL", "RIS", "nocamo", true, false],     7.407407407407408,
    ["hlc_rifle_LAR", "FAL", "FAL", "nocamo", true, false],     66.66666666666667,
    ["hlc_rifle_STG58F", "FAL", "RIS", "nocamo", true, false],     11.111111111111112,
    ["CUP_arifle_DSA_SA58", "FAL", "RIS", "nocamo", true, true],     0.8230452674897121,
    ["hlc_rifle_hk33a2", "HK33", "G3", "nocamo", true, false],     33.333333333333336,
    ["hlc_rifle_hk33a2RIS", "HK33", "RIS", "nocamo", true, false],     3.703703703703704,
    ["hlc_rifle_g3a3v", "G3", "G3", "nocamo", true, false],     66.66666666666667,
    ["hlc_rifle_g3a3ris", "G3", "RIS", "nocamo", true, false],     11.111111111111112,
    ["CUP_arifle_G3A3_ris_vfg", "G3", "RIS", "nocamo", true, true],     2.469135802469136
];
_weapons_hash set ["rifle", _rifles];

private _riflegls = [

    ["rhs_weap_akmn_gp25", "AK", "Dovetail", "nocamo", true, false],     13.333333333333334,
    ["rhs_weap_akmn_gp25_npz", "AK", "RIS", "nocamo", true, false],     8.88888888888889,
    ["rhs_weap_akms_gp25", "AK", "Dovetail", "nocamo", true, false],     13.333333333333334,
    ["rhs_weap_aks74_gp25", "AK74", "None", "nocamo", true, false],     26.666666666666668,
    ["rhs_weap_aks74n_gp25", "AK74", "Dovetail", "nocamo", true, false],     13.333333333333334,
    ["rhs_weap_m70b3n_pbg40", "AK", "Dovetail", "nocamo", true, false],     13.333333333333334,
    ["hlc_rifle_A1m203", "AR15", "RIS", "nocamo", true, false],     8.88888888888889,
    ["hlc_rifle_m203", "AR15", "RIS", "nocamo", true, false],     8.88888888888889,
    ["hlc_rifle_hk33a2RIS_GL", "HK33", "RIS", "nocamo", true, false],     1.4814814814814816
];
_weapons_hash set ["riflegl", _riflegls];

private _smgs = [

    ["hlc_smg_mp5a2", "MP5", "RIS", "nocamo", true, false],     5.555555555555556
];
_weapons_hash set ["smg", _smgs];

private _snipers = [

    ["rhs_weap_m38_rail", "Mosin", "RIS", "nocamo", false, false],     16.666666666666668,
    ["CUP_srifle_LeeEnfield_rail", "LEE", "RIS", "nocamo", false, false],     16.666666666666668
];
_weapons_hash set ["sniper", _snipers];


private _starting = [
["rhs_weap_MP44", "MP44", "None", "nocamo", false, false], ["rhs_weap_savz58v", "SA58", "None", "nocamo", false, false], ["rhs_weap_m92", "AK", "None", "nocamo", true, false], ["rhs_weap_rpg75", "None", "None", "nocamo", false, false], ["rhs_weap_pkm", "PK", "None", "nocamo", false, false], ["hlc_lmg_m60", "M240", "None", "nocamo", false, false], ["rhs_weap_m76", "M76", "Dovetail", "nocamo", true, false], ["hlc_rifle_M14_Bipod", "M14", "M14", "nocamo", true, false], ["CUP_SKS_rail", "SKS", "RIS", "nocamo", false, false], ["rhs_weap_tt33", "TT33", "None", "nocamo", false, false], ["rhs_weap_makarov_pm", "PM", "None", "nocamo", false, false], ["rhsusf_weap_m1911a1", "M1911", "None", "nocamo", false, false], ["rhs_weap_akms", "AK", "None", "nocamo", true, false], ["rhs_weap_akmn", "AK", "Dovetail", "nocamo", true, false], ["rhs_weap_m70ab2", "AK", "None", "nocamo", true, false], ["CUP_arifle_TYPE_56_2_Early", "AK", "None", "nocamo", true, false], ["rhs_weap_savz58p", "SA58", "None", "nocamo", false, false], ["rhs_weap_kar98k", "KAR98", "None", "nocamo", false, false], ["rhs_weap_m1garand_sa43", "Garand", "None", "nocamo", false, false], ["CUP_arifle_Galil_black", "GALIL762", "RIS", "nocamo", false, false], ["hlc_rifle_FAL5000", "FAL", "FAL", "nocamo", true, false], ["rhs_weap_akmn_gp25", "AK", "Dovetail", "nocamo", true, false]
];

[_weapons_hash, _starting]
