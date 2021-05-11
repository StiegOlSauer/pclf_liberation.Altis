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

    ["CUP_launch_9K32Strela", "Strela", "None", "nocamo", false, false],     5,
    ["rhs_weap_igla", "Igla", "None", "nocamo", false, false],     1
];
_weapons_hash set ["aa", _aas];

private _carbines = [

    ["rhs_weap_aks74un", "AK74", "Dovetail", "nocamo", true, false],     33.333333333333336,
    ["rhs_weap_asval", "VAL", "Dovetail", "nocamo", false, false],     5.555555555555556,
    ["rhs_weap_asval_grip_npz", "VAL", "RIS", "nocamo", false, true],     1.6460905349794241,
    ["CUP_arifle_AK102", "AK101", "Dovetail", "nocamo", true, false],     16.666666666666668,
    ["rhs_weap_ak104", "AK", "Dovetail", "nocamo", true, false],     16.666666666666668,
    ["rhs_weap_ak104_npz", "AK", "RIS", "nocamo", true, false],     11.111111111111112,
    ["rhs_weap_ak104_zenitco01", "AK", "Dovetail", "nocamo", true, true],     7.407407407407408,
    ["rhs_weap_ak105", "AK74", "Dovetail", "nocamo", true, false],     16.666666666666668,
    ["rhs_weap_ak105_npz", "AK74", "RIS", "nocamo", true, false],     11.111111111111112,
    ["rhs_weap_ak105_zenitco01", "AK74", "Dovetail", "nocamo", true, true],     7.407407407407408,
    ["rhs_weap_asval_grip", "VAL", "Dovetail", "nocamo", false, true],     2.469135802469136,
    ["CUP_arifle_AS_VAL_VFG_top_rail", "VAL", "RIS", "nocamo", false, true],     0.8230452674897121,
    ["CUP_arifle_AK102_railed", "AK101", "RIS", "nocamo", true, true],     2.469135802469136,
    ["rhs_weap_ak104_zenitco01_b33", "AK", "RIS", "nocamo", true, true],     2.469135802469136,
    ["rhs_weap_ak105_zenitco01_b33", "AK74", "RIS", "nocamo", true, true],     2.469135802469136,
    ["hlc_rifle_slr107u", "AK", "Dovetail", "nocamo", true, true],     14.814814814814817,
    ["hlc_rifle_falosw", "FAL", "RIS", "nocamo", true, true],     0.8230452674897121,
    ["hlc_rifle_CQBR", "AR15", "RIS", "nocamo", true, true],     0.8230452674897121,
    ["hlc_rifle_G36CV", "G36", "RIS", "nocamo", true, true],     1.6460905349794241
];
_weapons_hash set ["carbine", _carbines];

private _carbinegls = [

    ["CUP_arifle_OTS14_GROZA_762_GL", "AK", "Integral", "nocamo", false, false],     8.88888888888889,
    ["CUP_arifle_OTS14_GROZA_GL", "GROZA", "Integral", "nocamo", false, false],     4.444444444444445,
    ["hlc_rifle_osw_GL", "FAL", "RIS", "nocamo", true, false],     0.49382716049382724
];
_weapons_hash set ["carbinegl", _carbinegls];

private _hats = [

    ["rhs_weap_rpg7", "RPG7", "RPG7", "nocamo", false, false],     2
];
_weapons_hash set ["hat", _hats];

private _lats = [

    ["CUP_launch_RPG18", "None", "None", "nocamo", false, false],     20,
    ["rhs_weap_rpg26", "None", "None", "nocamo", false, false],     8,
    ["rhs_weap_rshg2", "None", "None", "nocamo", false, false],     8
];
_weapons_hash set ["lat", _lats];

private _lmgs = [

    ["hlc_rifle_rpk", "AK", "Dovetail", "nocamo", true, false],     16.666666666666668,
    ["hlc_rifle_rpk74n", "AK74", "Dovetail", "nocamo", true, false],     16.666666666666668,
    ["CUP_arifle_RPK74_45_top_rail", "AK74", "RIS", "nocamo", true, false],     7.407407407407408,
    ["CUP_arifle_RPK74M_railed", "AK74", "RIS", "nocamo", true, false],     1.851851851851852
];
_weapons_hash set ["lmg", _lmgs];

private _mgs = [

    ["CUP_lmg_PKM_B50_vfg", "PK", "None", "nocamo", true, false],     11.111111111111112,
    ["CUP_lmg_PKM_top_rail", "PK", "RIS", "nocamo", true, false],     11.111111111111112,
    ["CUP_lmg_PKMN", "PK", "Dovetail", "nocamo", true, false],     16.666666666666668,
    ["CUP_lmg_PKM_top_rail_B50_vfg", "PK", "RIS", "nocamo", true, false],     3.703703703703704
];
_weapons_hash set ["mg", _mgs];

private _marksmans = [

    ["hlc_rifle_m14sopmod", "M14", "RIS", "nocamo", true, true],     1.234567901234568,
    ["rhs_weap_vss", "VAL", "Dovetail", "nocamo", false, false],     5.555555555555556,
    ["rhs_weap_vss_grip_npz", "VAL", "RIS", "nocamo", false, true],     2.469135802469136
];
_weapons_hash set ["marksman", _marksmans];

private _pistols = [

    ["rhs_weap_pya", "MP443", "None", "nocamo", false, false],     25,
    ["hgun_Pistol_01_F", "PMM", "None", "nocamo", false, false],     100,
    ["rhs_weap_6p53", "6P53", "None", "nocamo", false, false],     2.380952380952381,
    ["rhs_weap_pp2000_folded", "PP2000", "RIS", "nocamo", false, false],     1.0416666666666667,
    ["rhs_weap_pb_6p9", "PM", "None", "nocamo", false, false],     44.44444444444445,
    ["rhsusf_weap_m9", "M9", "None", "nocamo", false, false],     25,
    ["CUP_hgun_M9A1", "M9", "None", "nocamo", true, false],     11.111111111111112,
    ["hlc_pistol_P226R_Combat", "SIG226", "SIG", "nocamo", true, false],     5.555555555555556
];
_weapons_hash set ["pistol", _pistols];

private _rifles = [

    ["rhs_weap_ak74n_2", "AK74", "Dovetail", "nocamo", true, false],     33.333333333333336,
    ["rhs_weap_ak103", "AK", "Dovetail", "nocamo", true, false],     16.666666666666668,
    ["rhs_weap_ak103_2", "AK", "Dovetail", "nocamo", true, false],     16.666666666666668,
    ["rhs_weap_ak74n_2_npz", "AK74", "RIS", "nocamo", true, false],     22.222222222222225,
    ["rhs_weap_ak103_npz", "AK", "RIS", "nocamo", true, false],     11.111111111111112,
    ["rhs_weap_ak103_zenitco01", "AK", "Dovetail", "nocamo", true, true],     7.407407407407408,
    ["rhs_weap_ak103_2_npz", "AK", "RIS", "nocamo", true, false],     11.111111111111112,
    ["CUP_arifle_AK101", "AK101", "Dovetail", "nocamo", true, false],     16.666666666666668,
    ["CUP_arifle_AK101_railed", "AK101", "RIS", "nocamo", true, true],     2.469135802469136,
    ["CUP_arifle_AK107", "AK74", "Dovetail", "nocamo", true, false],     1.388888888888889,
    ["CUP_arifle_AK108", "AK101", "Dovetail", "nocamo", true, false],     1.388888888888889,
    ["CUP_arifle_AK109", "AK", "Dovetail", "nocamo", true, false],     1.388888888888889,
    ["CUP_arifle_AK107_railed", "AK74", "RIS", "nocamo", true, true],     0.20576131687242802,
    ["CUP_arifle_AK108_railed", "AK101", "RIS", "nocamo", true, true],     0.20576131687242802,
    ["CUP_arifle_AK109_railed", "AK", "RIS", "nocamo", true, true],     0.20576131687242802,
    ["hlc_rifle_aek971_mtk", "AK74", "RIS", "nocamo", true, false],     1.388888888888889,
    ["hlc_rifle_aek971", "AK74", "Dovetail", "nocamo", true, false],     2.0833333333333335,
    ["hlc_rifle_ak12", "AK74", "RIS", "nocamo", true, true],     0.7054673721340388,
    ["rhs_weap_ak74mr", "AK74", "RIS", "nocamo", true, true],     0.7054673721340388,
    ["rhs_weap_ak74m_zenitco01_b33", "AK74", "RIS", "nocamo", true, true],     2.469135802469136,
    ["rhs_weap_ak103_zenitco01_b33", "AK", "RIS", "nocamo", true, true],     2.469135802469136
];
_weapons_hash set ["rifle", _rifles];

private _riflegls = [

    ["rhs_weap_ak74n_2_gp25", "AK74", "Dovetail", "nocamo", true, false],     13.333333333333334,
    ["rhs_weap_akmn_gp25", "AK", "Dovetail", "nocamo", true, false],     13.333333333333334,
    ["rhs_weap_ak74n_2_gp25_npz", "AK74", "RIS", "nocamo", true, false],     8.88888888888889,
    ["rhs_weap_ak103_gp25", "AK", "Dovetail", "nocamo", true, false],     6.666666666666667,
    ["rhs_weap_ak103_gp25_npz", "AK", "RIS", "nocamo", true, false],     4.444444444444445,
    ["rhs_weap_ak74m_gp25_npz", "AK74", "RIS", "nocamo", true, false],     4.444444444444445,
    ["CUP_arifle_AK101_GL", "AK101", "Dovetail", "nocamo", true, false],     6.666666666666667,
    ["CUP_arifle_AK101_GL_top_rail", "AK101", "RIS", "nocamo", true, false],     4.444444444444445,
    ["CUP_arifle_AK101_GL_railed", "AK101", "RIS", "nocamo", true, false],     2.9629629629629632,
    ["CUP_arifle_AK107_GL", "AK74", "Dovetail", "nocamo", true, false],     0.5555555555555556,
    ["CUP_arifle_AK108_GL", "AK101", "Dovetail", "nocamo", true, false],     0.5555555555555556,
    ["CUP_arifle_AK109_GL", "AK", "Dovetail", "nocamo", true, false],     0.5555555555555556,
    ["CUP_arifle_AK107_GL_railed", "AK74", "RIS", "nocamo", true, false],     0.24691358024691362,
    ["CUP_arifle_AK108_GL_railed", "AK101", "RIS", "nocamo", true, false],     0.24691358024691362,
    ["CUP_arifle_AK109_GL_railed", "AK", "RIS", "nocamo", true, false],     0.24691358024691362,
    ["hlc_rifle_ak12GL", "AK74", "RIS", "nocamo", true, false],     0.42328042328042326,
    ["rhs_weap_ak74mr_gp25", "AK74", "RIS", "nocamo", true, false],     0.42328042328042326
];
_weapons_hash set ["riflegl", _riflegls];

private _smgs = [

    ["CUP_smg_bizon", "Bizon", "Dovetail", "nocamo", true, false],     8.333333333333334,
    ["CUP_arifle_SR3M_Vikhr_VFG", "VAL", "Dovetail", "nocamo", false, false],     2.777777777777778,
    ["CUP_arifle_OTS14_GROZA_762", "AK", "Integral", "nocamo", false, false],     7.407407407407408,
    ["CUP_arifle_OTS14_GROZA", "GROZA", "Integral", "nocamo", false, false],     7.407407407407408,
    ["CUP_smg_vityaz_top_rail", "Vityaz", "RIS", "nocamo", true, false],     3.703703703703704,
    ["CUP_smg_vityaz_vfg", "Vityaz", "Dovetail", "nocamo", true, false],     3.703703703703704,
    ["hlc_smg_mp5a2_tac", "MP5", "RIS", "nocamo", true, true],     2.469135802469136,
    ["hlc_mp510_tac", "MP510", "RIS", "nocamo", true, true],     1.6460905349794241,
    ["CUP_arifle_SR3M_Vikhr_VFG_top_rail", "VAL", "RIS", "nocamo", true, false],     1.234567901234568,
    ["CUP_smg_vityaz_vfg_top_rail", "Vityaz", "RIS", "nocamo", true, false],     1.234567901234568
];
_weapons_hash set ["smg", _smgs];

private _snipers = [

    ["rhs_weap_m38_rail", "Mosin", "RIS", "nocamo", false, false],     33.333333333333336,
    ["rhs_weap_t5000", "T5000", "RIS", "nocamo", false, true],     0.7936507936507936
];
_weapons_hash set ["sniper", _snipers];


private _starting = [
["rhs_weap_aks74un", "AK74", "Dovetail", "nocamo", true, false], ["CUP_launch_RPG18", "None", "None", "nocamo", false, false], ["rhs_weap_ak74n_2", "AK74", "Dovetail", "nocamo", true, false], ["rhs_weap_ak103", "AK", "Dovetail", "nocamo", true, false], ["rhs_weap_ak103_2", "AK", "Dovetail", "nocamo", true, false], ["rhs_weap_ak74n_2_gp25", "AK74", "Dovetail", "nocamo", true, false], ["rhs_weap_akmn_gp25", "AK", "Dovetail", "nocamo", true, false]
];

[_weapons_hash, _starting]
