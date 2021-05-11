private _arsenal_magazine_types = ["AK", "MP44", "AK74", "SA58", "Mosin", "KAR98", "Garand", "LEE", "M76", "MG42", "M240", "PK", "M14", "AR15", "GALIL556", "GALIL762", "M60", "FAL", "SKS", "SVD", "G3", "HK33", "MP5", "HP", "CZ75", "M9", "MAC10", "UZI", "TT33", "TEC9", "PM", "VZ61", "M1911", "None", "Metis", "Dragon", "RPG7", "Strela"];
private _arsenal_magazines = createHashMap;


private _mags_AK_nocamo = [
    "rhs_30Rnd_762x39mm_bakelite_89",
    "rhs_30Rnd_762x39mm_bakelite_tracer",
    "rhssaf_30Rnd_762x39_M82_api",
    "hlc_45Rnd_762x39_t_rpk",
    "hlc_45Rnd_762x39_m_rpk"
];
private _mags_AK_black = [
    "rhs_30Rnd_762x39mm_polymer_89",
    "rhs_30Rnd_762x39mm_polymer_tracer",
    "rhs_30Rnd_762x39mm_polymer_U",
    "rhs_75Rnd_762x39mm_89",
    "rhs_75Rnd_762x39mm_tracer",
    "75rnd_762x39_AK12_Mag_F",
    "75rnd_762x39_AK12_Mag_Tracer_F"
];
private _mags_AK_desert = [
    "hlc_30Rnd_762x39_b_ak_PMAGD",
    "CUP_30Rnd_762x39_AKM_bakelite_desert_M",
    "75rnd_762x39_AK12_Arid_Mag_F",
    "75rnd_762x39_AK12_Arid_Mag_Tracer_F"
];
private _mags_AK_woodland = [
    "30rnd_762x39_AK12_Lush_Mag_F",
    "75rnd_762x39_AK12_Lush_Mag_F",
    "75rnd_762x39_AK12_Lush_Mag_Tracer_F"
];

private _AK_mags = createHashMapFromArray  [["nocamo", _mags_AK_nocamo], ["black", _mags_AK_black], ["desert", _mags_AK_desert], ["woodland", _mags_AK_woodland]];
_arsenal_magazines set ["AK", _AK_mags];

private _mags_MP44_nocamo = ["rhsgref_30Rnd_792x33_SmE_StG"];
private _mags_MP44_black = [];
private _mags_MP44_desert = [];
private _mags_MP44_woodland = [];

private _MP44_mags = createHashMapFromArray  [["nocamo", _mags_MP44_nocamo], ["black", _mags_MP44_black], ["desert", _mags_MP44_desert], ["woodland", _mags_MP44_woodland]];
_arsenal_magazines set ["MP44", _MP44_mags];

private _mags_AK74_nocamo = [
    "rhs_30Rnd_545x39_7N6M_AK",
    "rhs_30Rnd_545x39_7N6M_plum_AK",
    "rhs_45Rnd_545X39_7N6_AK",
    "rhs_45Rnd_545X39_7N10_AK",
    "rhs_45Rnd_545X39_7N22_AK",
    "rhs_45Rnd_545X39_AK_Green"
];
private _mags_AK74_black = [
    "rhs_30Rnd_545x39_7N10_AK",
    "rhs_30Rnd_545x39_7N22_AK",
    "rhs_30Rnd_545x39_7U1_AK",
    "rhs_30Rnd_545x39_7N10_2mag_AK",
    "hlc_60Rnd_545x39_EP_rpk",
    "hlc_45Rnd_545x39_EP_rpkm"
];
private _mags_AK74_desert = [
    "rhs_30Rnd_545x39_7N10_2mag_desert_AK",
    "rhs_30Rnd_545x39_7N10_desert_AK",
    "rhs_30Rnd_545x39_7N22_desert_AK"
];
private _mags_AK74_woodland = [
    "rhs_30Rnd_545x39_7N6M_green_AK",
    "rhs_30Rnd_545x39_7N10_2mag_camo_AK",
    "rhs_30Rnd_545x39_7N10_camo_AK",
    "rhs_30Rnd_545x39_7N22_camo_AK"
];

private _AK74_mags = createHashMapFromArray  [["nocamo", _mags_AK74_nocamo], ["black", _mags_AK74_black], ["desert", _mags_AK74_desert], ["woodland", _mags_AK74_woodland]];
_arsenal_magazines set ["AK74", _AK74_mags];

private _mags_SA58_nocamo = [
    "rhs_30Rnd_762x39mm_Savz58",
    "rhs_30Rnd_762x39mm_Savz58_tracer"
];
private _mags_SA58_black = [];
private _mags_SA58_desert = [];
private _mags_SA58_woodland = [];

private _SA58_mags = createHashMapFromArray  [["nocamo", _mags_SA58_nocamo], ["black", _mags_SA58_black], ["desert", _mags_SA58_desert], ["woodland", _mags_SA58_woodland]];
_arsenal_magazines set ["SA58", _SA58_mags];

private _mags_Mosin_nocamo = [
    "rhsgref_5Rnd_762x54_m38"
];
private _mags_Mosin_black = [];
private _mags_Mosin_desert = [];
private _mags_Mosin_woodland = [];

private _Mosin_mags = createHashMapFromArray  [["nocamo", _mags_Mosin_nocamo], ["black", _mags_Mosin_black], ["desert", _mags_Mosin_desert], ["woodland", _mags_Mosin_woodland]];
_arsenal_magazines set ["Mosin", _Mosin_mags];

private _mags_KAR98_nocamo = ["rhsgref_5Rnd_792x57_kar98k"];
private _mags_KAR98_black = [];
private _mags_KAR98_desert = [];
private _mags_KAR98_woodland = [];

private _KAR98_mags = createHashMapFromArray  [["nocamo", _mags_KAR98_nocamo], ["black", _mags_KAR98_black], ["desert", _mags_KAR98_desert], ["woodland", _mags_KAR98_woodland]];
_arsenal_magazines set ["KAR98", _KAR98_mags];

private _mags_Garand_nocamo = ["rhsgref_8Rnd_762x63_M2B_M1rifle", "rhsgref_8Rnd_762x63_Tracer_M1T_M1rifle"];
private _mags_Garand_black = [];
private _mags_Garand_desert = [];
private _mags_Garand_woodland = [];

private _Garand_mags = createHashMapFromArray  [["nocamo", _mags_Garand_nocamo], ["black", _mags_Garand_black], ["desert", _mags_Garand_desert], ["woodland", _mags_Garand_woodland]];
_arsenal_magazines set ["Garand", _Garand_mags];

private _mags_LEE_nocamo = ["CUP_10x_303_M"];
private _mags_LEE_black = [];
private _mags_LEE_desert = [];
private _mags_LEE_woodland = [];

private _LEE_mags = createHashMapFromArray  [["nocamo", _mags_LEE_nocamo], ["black", _mags_LEE_black], ["desert", _mags_LEE_desert], ["woodland", _mags_LEE_woodland]];
_arsenal_magazines set ["LEE", _LEE_mags];

private _mags_M76_nocamo = [
    "rhsgref_10Rnd_792x57_m76",
    "rhssaf_10Rnd_792x57_m76_tracer"
];
private _mags_M76_black = [];
private _mags_M76_desert = [];
private _mags_M76_woodland = [];

private _M76_mags = createHashMapFromArray  [["nocamo", _mags_M76_nocamo], ["black", _mags_M76_black], ["desert", _mags_M76_desert], ["woodland", _mags_M76_woodland]];
_arsenal_magazines set ["M76", _M76_mags];

private _mags_MG42_nocamo = [
    "rhsgref_50Rnd_792x57_SmE_drum",
    "rhsgref_50Rnd_792x57_SmK_drum",
    "rhsgref_50Rnd_792x57_SmK_alltracers_drum",
    "rhsgref_296Rnd_792x57_SmE_belt",
    "rhsgref_296Rnd_792x57_SmK_belt",
    "rhsgref_296Rnd_792x57_SmK_alltracers_belt",
    "hlc_100Rnd_792x57_AP_MG42",
    "hlc_200Rnd_792x57_AP_MG42",
    "hlc_100Rnd_792x57_M_MG42",
    "hlc_200Rnd_792x57_M_MG42",
    "hlc_100Rnd_792x57_B_MG42",
    "hlc_200Rnd_792x57_B_MG42",
    "hlc_100Rnd_792x57_T_MG42",
    "hlc_200Rnd_792x57_T_MG42"
];
private _mags_MG42_black = [];
private _mags_MG42_desert = [];
private _mags_MG42_woodland = [];

private _MG42_mags = createHashMapFromArray  [["nocamo", _mags_MG42_nocamo], ["black", _mags_MG42_black], ["desert", _mags_MG42_desert], ["woodland", _mags_MG42_woodland]];
_arsenal_magazines set ["MG42", _MG42_mags];

private _mags_M240_nocamo = [
    "rhsusf_100Rnd_762x51_m61_ap",
    "rhsusf_100Rnd_762x51_m62_tracer",
    "rhsusf_100Rnd_762x51"
];
private _mags_M240_black = [];
private _mags_M240_desert = [];
private _mags_M240_woodland = [];

private _M240_mags = createHashMapFromArray  [["nocamo", _mags_M240_nocamo], ["black", _mags_M240_black], ["desert", _mags_M240_desert], ["woodland", _mags_M240_woodland]];
_arsenal_magazines set ["M240", _M240_mags];

private _mags_PK_nocamo = [
    "rhs_100Rnd_762x54mmR",
    "rhs_100Rnd_762x54mmR_7BZ3",
    "rhs_100Rnd_762x54mmR_green"
];
private _mags_PK_black = [];
private _mags_PK_desert = [];
private _mags_PK_woodland = [];

private _PK_mags = createHashMapFromArray  [["nocamo", _mags_PK_nocamo], ["black", _mags_PK_black], ["desert", _mags_PK_desert], ["woodland", _mags_PK_woodland]];
_arsenal_magazines set ["PK", _PK_mags];

private _mags_M14_nocamo = [
    "hlc_20Rnd_762x51_B_M14",
    "hlc_20Rnd_762x51_T_M14",
    "rhsusf_20Rnd_762x51_m80_Mag"
];
private _mags_M14_black = [];
private _mags_M14_desert = [];
private _mags_M14_woodland = [];

private _M14_mags = createHashMapFromArray  [["nocamo", _mags_M14_nocamo], ["black", _mags_M14_black], ["desert", _mags_M14_desert], ["woodland", _mags_M14_woodland]];
_arsenal_magazines set ["M14", _M14_mags];

private _mags_AR15_nocamo = [
    "hlc_30rnd_556x45_EPR_STANAGHD",
    "hlc_30rnd_556x45_SOST_STANAGHD",
    "hlc_30rnd_556x45_t_STANAGHD"
];
private _mags_AR15_black = [
    "hlc_50rnd_556x45_EPR",
    "hlc_50rnd_556x45_SOST",
    "rhs_mag_100Rnd_556x45_M855_cmag_mixed",
    "rhs_mag_100Rnd_556x45_Mk318_cmag",
    "rhs_mag_30Rnd_556x45_M855_PMAG",
    "rhs_mag_30Rnd_556x45_Mk318_PMAG"
];
private _mags_AR15_desert = [
    "rhs_mag_30Rnd_556x45_M855_PMAG_Tan"
];
private _mags_AR15_woodland = [
    "CUP_30Rnd_556x45_PMAG_QP_Olive"
];

private _AR15_mags = createHashMapFromArray  [["nocamo", _mags_AR15_nocamo], ["black", _mags_AR15_black], ["desert", _mags_AR15_desert], ["woodland", _mags_AR15_woodland]];
_arsenal_magazines set ["AR15", _AR15_mags];

private _mags_GALIL556_nocamo = [
    "CUP_35Rnd_556x45_Galil_Mag",
    "CUP_50Rnd_556x45_Galil_Mag",
    "CUP_35Rnd_556x45_Red_Tracer_Galil_Mag",
    "CUP_50Rnd_556x45_Red_Tracer_Galil_Mag"
];
private _mags_GALIL556_black = [];
private _mags_GALIL556_desert = [];
private _mags_GALIL556_woodland = [];

private _GALIL556_mags = createHashMapFromArray  [["nocamo", _mags_GALIL556_nocamo], ["black", _mags_GALIL556_black], ["desert", _mags_GALIL556_desert], ["woodland", _mags_GALIL556_woodland]];
_arsenal_magazines set ["GALIL556", _GALIL556_mags];

private _mags_GALIL762_nocamo = [
    "CUP_25Rnd_762x51_Galil_Mag", "CUP_25Rnd_762x51_Red_Tracers_Galil_Mag"
];
private _mags_GALIL762_black = [];
private _mags_GALIL762_desert = [];
private _mags_GALIL762_woodland = [];

private _GALIL762_mags = createHashMapFromArray  [["nocamo", _mags_GALIL762_nocamo], ["black", _mags_GALIL762_black], ["desert", _mags_GALIL762_desert], ["woodland", _mags_GALIL762_woodland]];
_arsenal_magazines set ["GALIL762", _GALIL762_mags];

private _mags_FAL_nocamo = [
    "CUP_30Rnd_762x51_FNFAL_M",
    "CUP_30Rnd_TE1_Green_Tracer_762x51_FNFAL_M",
    "hlc_50rnd_762x51_M_FAL",
    "hlc_50Rnd_762x51_T_fal",
    "hlc_20Rnd_762x51_barrier_fal",
    "hlc_20Rnd_762x51_B_fal"
];
private _mags_FAL_black = [
    "hlc_20Rnd_762x51_T_fal"
];
private _mags_FAL_desert = [
    "CUP_20Rnd_762x51_FNFAL_Desert_M",
    "CUP_20Rnd_TE1_Green_Tracer_762x51_FNFAL_Desert_M"
];
private _mags_FAL_woodland = [
    "CUP_20Rnd_762x51_FNFAL_Woodland_M",
    "CUP_20Rnd_TE1_Green_Tracer_762x51_FNFAL_Woodland_M"
];


private _FAL_mags = createHashMapFromArray  [["nocamo", _mags_FAL_nocamo], ["black", _mags_FAL_black], ["desert", _mags_FAL_desert], ["woodland", _mags_FAL_woodland]];
_arsenal_magazines set ["FAL", _FAL_mags];

private _mags_SKS_nocamo = ["CUP_10Rnd_762x39_SKS_M"];
private _mags_SKS_black = [];
private _mags_SKS_desert = [];
private _mags_SKS_woodland = [];

private _SKS_mags = createHashMapFromArray  [["nocamo", _mags_SKS_nocamo], ["black", _mags_SKS_black], ["desert", _mags_SKS_desert], ["woodland", _mags_SKS_woodland]];
_arsenal_magazines set ["SKS", _SKS_mags];

private _mags_SVD_nocamo = [
    "rhs_10Rnd_762x54mmR_7N1",
    "rhs_10Rnd_762x54mmR_7N14"
];
private _mags_SVD_black = [];
private _mags_SVD_desert = [];
private _mags_SVD_woodland = [];

private _SVD_mags = createHashMapFromArray  [["nocamo", _mags_SVD_nocamo], ["black", _mags_SVD_black], ["desert", _mags_SVD_desert], ["woodland", _mags_SVD_woodland]];
_arsenal_magazines set ["SVD", _SVD_mags];

private _mags_G3_nocamo = [
    "hlc_20rnd_762x51_b_G3",
    "hlc_50Rnd_762x51_B_G3",
    "hlc_50rnd_762x51_M_G3",
    "hlc_20rnd_762x51_T_G3",
    "hlc_50Rnd_762x51_T_G3",
    "hlc_20rnd_762x51_Mk316_G3",
    "hlc_20rnd_762x51_barrier_G3"
];
private _mags_G3_black = [];
private _mags_G3_desert = [];
private _mags_G3_woodland = [];

private _G3_mags = createHashMapFromArray  [["nocamo", _mags_G3_nocamo], ["black", _mags_G3_black], ["desert", _mags_G3_desert], ["woodland", _mags_G3_woodland]];
_arsenal_magazines set ["G3", _G3_mags];

private _mags_HK33_nocamo = [
    "hlc_30rnd_556x45_EPR_HK33",
    "hlc_30rnd_556x45_M_HK33",
    "hlc_30rnd_556x45_b_HK33",
    "hlc_30rnd_556x45_SPR_HK33",
    "hlc_30rnd_556x45_SOST_HK33",
    "hlc_30rnd_556x45_t_HK33"
];
private _mags_HK33_black = [];
private _mags_HK33_desert = [];
private _mags_HK33_woodland = [];

private _HK33_mags = createHashMapFromArray  [["nocamo", _mags_HK33_nocamo], ["black", _mags_HK33_black], ["desert", _mags_HK33_desert], ["woodland", _mags_HK33_woodland]];
_arsenal_magazines set ["HK33", _HK33_mags];

private _mags_MP5_nocamo = [];
private _mags_MP5_black = [
    "hlc_30Rnd_9x19_B_MP5",
    "hlc_30Rnd_9x19_GD_MP5"
];
private _mags_MP5_desert = [];
private _mags_MP5_woodland = [];

private _MP5_mags = createHashMapFromArray  [["nocamo", _mags_MP5_nocamo], ["black", _mags_MP5_black], ["desert", _mags_MP5_desert], ["woodland", _mags_MP5_woodland]];
_arsenal_magazines set ["MP5", _MP5_mags];

private _mags_HP_nocamo = ["CUP_13Rnd_9x19_Browning_HP"];
private _mags_HP_black = [];
private _mags_HP_desert = [];
private _mags_HP_woodland = [];

private _HP_mags = createHashMapFromArray  [["nocamo", _mags_HP_nocamo], ["black", _mags_HP_black], ["desert", _mags_HP_desert], ["woodland", _mags_HP_woodland]];
_arsenal_magazines set ["HP", _HP_mags];

private _mags_CZ75_nocamo = ["CUP_16Rnd_9x19_cz75"

];
private _mags_CZ75_black = [

];
private _mags_CZ75_desert = [

];
private _mags_CZ75_woodland = [

];

private _CZ75_mags = createHashMapFromArray  [["nocamo", _mags_CZ75_nocamo], ["black", _mags_CZ75_black], ["desert", _mags_CZ75_desert], ["woodland", _mags_CZ75_woodland]];
_arsenal_magazines set ["CZ75", _CZ75_mags];

private _mags_M9_nocamo = [
    "rhsusf_mag_15Rnd_9x19_FMJ", "rhsusf_mag_15Rnd_9x19_JHP"
];
private _mags_M9_black = [

];
private _mags_M9_desert = [

];
private _mags_M9_woodland = [

];

private _M9_mags = createHashMapFromArray  [["nocamo", _mags_M9_nocamo], ["black", _mags_M9_black], ["desert", _mags_M9_desert], ["woodland", _mags_M9_woodland]];
_arsenal_magazines set ["M9", _M9_mags];

private _mags_MAC10_nocamo = [
    "CUP_30Rnd_45ACP_MAC10_M", "CUP_30Rnd_45ACP_Yellow_Tracer_MAC10_M"
];
private _mags_MAC10_black = [

];
private _mags_MAC10_desert = [

];
private _mags_MAC10_woodland = [

];

private _MAC10_mags = createHashMapFromArray  [["nocamo", _mags_MAC10_nocamo], ["black", _mags_MAC10_black], ["desert", _mags_MAC10_desert], ["woodland", _mags_MAC10_woodland]];
_arsenal_magazines set ["MAC10", _MAC10_mags];

private _mags_UZI_nocamo = ["CUP_30Rnd_9x19_UZI"];
private _mags_UZI_black = [

];
private _mags_UZI_desert = [

];
private _mags_UZI_woodland = [

];

private _UZI_mags = createHashMapFromArray  [["nocamo", _mags_UZI_nocamo], ["black", _mags_UZI_black], ["desert", _mags_UZI_desert], ["woodland", _mags_UZI_woodland]];
_arsenal_magazines set ["UZI", _UZI_mags];

private _mags_TT33_nocamo = ["rhs_mag_762x25_8"];
private _mags_TT33_black = [

];
private _mags_TT33_desert = [

];
private _mags_TT33_woodland = [

];

private _TT33_mags = createHashMapFromArray  [["nocamo", _mags_TT33_nocamo], ["black", _mags_TT33_black], ["desert", _mags_TT33_desert], ["woodland", _mags_TT33_woodland]];
_arsenal_magazines set ["TT33", _TT33_mags];

private _mags_TEC9_nocamo = ["CUP_32Rnd_9x19_TEC9"];
private _mags_TEC9_black = [

];
private _mags_TEC9_desert = [

];
private _mags_TEC9_woodland = [

];

private _TEC9_mags = createHashMapFromArray  [["nocamo", _mags_TEC9_nocamo], ["black", _mags_TEC9_black], ["desert", _mags_TEC9_desert], ["woodland", _mags_TEC9_woodland]];
_arsenal_magazines set ["TEC9", _TEC9_mags];

private _mags_PM_nocamo = ["rhs_mag_9x18_8_57N181S"];
private _mags_PM_black = [

];
private _mags_PM_desert = [

];
private _mags_PM_woodland = [

];

private _PM_mags = createHashMapFromArray  [["nocamo", _mags_PM_nocamo], ["black", _mags_PM_black], ["desert", _mags_PM_desert], ["woodland", _mags_PM_woodland]];
_arsenal_magazines set ["PM", _PM_mags];

private _mags_VZ61_nocamo = ["rhsgref_20rnd_765x17_vz61"];
private _mags_VZ61_black = [

];
private _mags_VZ61_desert = [

];
private _mags_VZ61_woodland = [

];

private _VZ61_mags = createHashMapFromArray  [["nocamo", _mags_VZ61_nocamo], ["black", _mags_VZ61_black], ["desert", _mags_VZ61_desert], ["woodland", _mags_VZ61_woodland]];
_arsenal_magazines set ["VZ61", _VZ61_mags];

private _mags_M1911_nocamo = ["rhsusf_mag_7x45acp_MHP"];
private _mags_M1911_black = [

];
private _mags_M1911_desert = [

];
private _mags_M1911_woodland = [

];

private _M1911_mags = createHashMapFromArray  [["nocamo", _mags_M1911_nocamo], ["black", _mags_M1911_black], ["desert", _mags_M1911_desert], ["woodland", _mags_M1911_woodland]];
_arsenal_magazines set ["M1911", _M1911_mags];

private _mags_Metis_nocamo = [
    "Vorona_HE", "Vorona_HEAT"
];
private _mags_Metis_black = [

];
private _mags_Metis_desert = [

];
private _mags_Metis_woodland = [

];

private _Metis_mags = createHashMapFromArray  [["nocamo", _mags_Metis_nocamo], ["black", _mags_Metis_black], ["desert", _mags_Metis_desert], ["woodland", _mags_Metis_woodland]];
_arsenal_magazines set ["Metis", _Metis_mags];

private _mags_Dragon_nocamo = ["CUP_Dragon_EP1_M"];
private _mags_Dragon_black = [

];
private _mags_Dragon_desert = [

];
private _mags_Dragon_woodland = [

];

private _Dragon_mags = createHashMapFromArray  [["nocamo", _mags_Dragon_nocamo], ["black", _mags_Dragon_black], ["desert", _mags_Dragon_desert], ["woodland", _mags_Dragon_woodland]];
_arsenal_magazines set ["Dragon", _Dragon_mags];

private _mags_RPG7_nocamo = [
    "rhs_rpg7_OG7V_mag",
    "rhs_rpg7_PG7VM_mag",
    "rhs_rpg7_PG7VL_mag",
    "rhs_rpg7_PG7VR_mag",
    "rhs_rpg7_PG7VS_mag",
    "rhs_rpg7_TBG7V_mag",
    "rhs_rpg7_type69_airburst_mag"
];
private _mags_RPG7_black = [];
private _mags_RPG7_desert = [];
private _mags_RPG7_woodland = [];

private _RPG7_mags = createHashMapFromArray  [["nocamo", _mags_RPG7_nocamo], ["black", _mags_RPG7_black], ["desert", _mags_RPG7_desert], ["woodland", _mags_RPG7_woodland]];
_arsenal_magazines set ["RPG7", _RPG7_mags];

private _mags_Strela_nocamo = ["CUP_Strela_2_M"];
private _mags_Strela_black = [];
private _mags_Strela_desert = [];
private _mags_Strela_woodland = [];

private _Strela_mags = createHashMapFromArray  [["nocamo", _mags_Strela_nocamo], ["black", _mags_Strela_black], ["desert", _mags_Strela_desert], ["woodland", _mags_Strela_woodland]];
_arsenal_magazines set ["Strela", _Strela_mags];

_arsenal_magazines set ["types", _arsenal_magazine_types];

_arsenal_magazines
