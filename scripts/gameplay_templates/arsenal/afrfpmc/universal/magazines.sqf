private _arsenal_magazine_types = ["AK74", "AK", "SVD", "PK", "AK101", "FAL", "SA58", "VAL", "GROZA", "AR15", "G36", "P90", "Bizon", "Vityaz", "MP5", "MP510", "P99", "G17", "MP443", "PMM", "6P53", "PP2000", "PM", "M9", "SIG226", "M24", "M200", "AWM", "Mosin", "M14", "T5000", "RPG32", "Metis", "RPG7", "Strela", "Igla"];
private _arsenal_magazines = createHashMap;


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


private _mags_SVD_nocamo = [
    "rhs_10Rnd_762x54mmR_7N1",
    "rhs_10Rnd_762x54mmR_7N14"
];
private _mags_SVD_black = [];
private _mags_SVD_desert = [];
private _mags_SVD_woodland = [];

private _SVD_mags = createHashMapFromArray  [["nocamo", _mags_SVD_nocamo], ["black", _mags_SVD_black], ["desert", _mags_SVD_desert], ["woodland", _mags_SVD_woodland]];
_arsenal_magazines set ["SVD", _SVD_mags];


private _mags_PK_nocamo = [
    "rhs_100Rnd_762x54mmR",
    "rhs_100Rnd_762x54mmR_7BZ3",
    "rhs_100Rnd_762x54mmR_7N13",
    "rhs_100Rnd_762x54mmR_7N26",
    "rhs_100Rnd_762x54mmR_green"
];
private _mags_PK_black = [];
private _mags_PK_desert = [];
private _mags_PK_woodland = [];

private _PK_mags = createHashMapFromArray  [["nocamo", _mags_PK_nocamo], ["black", _mags_PK_black], ["desert", _mags_PK_desert], ["woodland", _mags_PK_woodland]];
_arsenal_magazines set ["PK", _PK_mags];


private _mags_AK101_nocamo = [];
private _mags_AK101_black = [
    "CUP_30Rnd_556x45_AK",
    "CUP_30Rnd_TE1_Green_Tracer_556x45_AK"
];
private _mags_AK101_desert = [];
private _mags_AK101_woodland = [];

private _AK101_mags = createHashMapFromArray  [["nocamo", _mags_AK101_nocamo], ["black", _mags_AK101_black], ["desert", _mags_AK101_desert], ["woodland", _mags_AK101_woodland]];
_arsenal_magazines set ["AK101", _AK101_mags];


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


private _mags_SA58_nocamo = [
    "rhs_30Rnd_762x39mm_Savz58",
    "rhs_30Rnd_762x39mm_Savz58_tracer"
];
private _mags_SA58_black = [];
private _mags_SA58_desert = [];
private _mags_SA58_woodland = [];

private _SA58_mags = createHashMapFromArray  [["nocamo", _mags_SA58_nocamo], ["black", _mags_SA58_black], ["desert", _mags_SA58_desert], ["woodland", _mags_SA58_woodland]];
_arsenal_magazines set ["SA58", _SA58_mags];


private _mags_VAL_nocamo = [
    "rhs_20rnd_9x39mm_SP5",
    "rhs_20rnd_9x39mm_SP6",
    "CUP_30Rnd_9x39_SP5_VIKHR_M"

];
private _mags_VAL_black = [];
private _mags_VAL_desert = [];
private _mags_VAL_woodland = [];

private _VAL_mags = createHashMapFromArray  [["nocamo", _mags_VAL_nocamo], ["black", _mags_VAL_black], ["desert", _mags_VAL_desert], ["woodland", _mags_VAL_woodland]];
_arsenal_magazines set ["VAL", _VAL_mags];


private _mags_GROZA_nocamo = [
    "CUP_20Rnd_9x39_SP5_GROZA_M"
];
private _mags_GROZA_black = [];
private _mags_GROZA_desert = [];
private _mags_GROZA_woodland = [];

private _GROZA_mags = createHashMapFromArray  [["nocamo", _mags_GROZA_nocamo], ["black", _mags_GROZA_black], ["desert", _mags_GROZA_desert], ["woodland", _mags_GROZA_woodland]];
_arsenal_magazines set ["GROZA", _GROZA_mags];


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

private _mags_G36_nocamo = [
    "hlc_30rnd_556x45_EPR_G36",
    "hlc_30rnd_556x45_Tracers_G36",
    "hlc_30rnd_556x45_SOST_G36"
];
private _mags_G36_black = [
    "hlc_100rnd_556x45_M_G36",
    "CUP_100Rnd_TE1_Red_Tracer_556x45_BetaCMag"
];
private _mags_G36_desert = [
    "CUP_100Rnd_TE1_Red_Tracer_556x45_BetaCMag_camo",
    "CUP_100Rnd_556x45_BetaCMag_camo",
    "CUP_30Rnd_556x45_G36_camo"
];
private _mags_G36_woodland = [
    "CUP_100Rnd_556x45_BetaCMag_wdl",
    "CUP_100Rnd_TE1_Red_Tracer_556x45_BetaCMag_wdl",
    "CUP_30Rnd_556x45_G36_wdl"
];

private _G36_mags = createHashMapFromArray  [["nocamo", _mags_G36_nocamo], ["black", _mags_G36_black], ["desert", _mags_G36_desert], ["woodland", _mags_G36_woodland]];
_arsenal_magazines set ["G36", _G36_mags];


private _mags_P90_nocamo = [
    "50Rnd_570x28_SMG_03"
];
private _mags_P90_black = [];
private _mags_P90_desert = [];
private _mags_P90_woodland = [];

private _P90_mags = createHashMapFromArray  [["nocamo", _mags_P90_nocamo], ["black", _mags_P90_black], ["desert", _mags_P90_desert], ["woodland", _mags_P90_woodland]];
_arsenal_magazines set ["P90", _P90_mags];


private _mags_Bizon_nocamo = [];
private _mags_Bizon_black = [
    "CUP_64Rnd_9x19_Bizon_M"
];
private _mags_Bizon_desert = [];
private _mags_Bizon_woodland = [];

private _Bizon_mags = createHashMapFromArray  [["nocamo", _mags_Bizon_nocamo], ["black", _mags_Bizon_black], ["desert", _mags_Bizon_desert], ["woodland", _mags_Bizon_woodland]];
_arsenal_magazines set ["Bizon", _Bizon_mags];


private _mags_Vityaz_nocamo = [];
private _mags_Vityaz_black = [
    "CUP_30Rnd_9x19_Vityaz",
    "CUP_30Rnd_9x19AP_Vityaz"
];
private _mags_Vityaz_desert = [];
private _mags_Vityaz_woodland = [];

private _Vityaz_mags = createHashMapFromArray  [["nocamo", _mags_Vityaz_nocamo], ["black", _mags_Vityaz_black], ["desert", _mags_Vityaz_desert], ["woodland", _mags_Vityaz_woodland]];
_arsenal_magazines set ["Vityaz", _Vityaz_mags];


private _mags_MP5_nocamo = [];
private _mags_MP5_black = [
    "hlc_30Rnd_9x19_B_MP5",
    "hlc_30Rnd_9x19_GD_MP5"
];
private _mags_MP5_desert = [];
private _mags_MP5_woodland = [];

private _MP5_mags = createHashMapFromArray  [["nocamo", _mags_MP5_nocamo], ["black", _mags_MP5_black], ["desert", _mags_MP5_desert], ["woodland", _mags_MP5_woodland]];
_arsenal_magazines set ["MP5", _MP5_mags];


private _mags_MP510_nocamo = [
    "hlc_30Rnd_10mm_B_MP5",
    "hlc_30Rnd_10mm_JHP_MP5"
];
private _mags_MP510_black = [];
private _mags_MP510_desert = [];
private _mags_MP510_woodland = [];

private _MP510_mags = createHashMapFromArray  [["nocamo", _mags_MP510_nocamo], ["black", _mags_MP510_black], ["desert", _mags_MP510_desert], ["woodland", _mags_MP510_woodland]];
_arsenal_magazines set ["MP510", _MP510_mags];


private _mags_P99_nocamo = [
    "16Rnd_9x21_Mag"
];
private _mags_P99_black = [];
private _mags_P99_desert = [];
private _mags_P99_woodland = [];

private _P99_mags = createHashMapFromArray  [["nocamo", _mags_P99_nocamo], ["black", _mags_P99_black], ["desert", _mags_P99_desert], ["woodland", _mags_P99_woodland]];
_arsenal_magazines set ["P99", _P99_mags];


private _mags_G17_nocamo = [
    "rhsusf_mag_17Rnd_9x19_FMJ",
    "rhsusf_mag_17Rnd_9x19_JHP"
];
private _mags_G17_black = [];
private _mags_G17_desert = [];
private _mags_G17_woodland = [];

private _G17_mags = createHashMapFromArray  [["nocamo", _mags_G17_nocamo], ["black", _mags_G17_black], ["desert", _mags_G17_desert], ["woodland", _mags_G17_woodland]];
_arsenal_magazines set ["G17", _G17_mags];


private _mags_MP443_nocamo = [
    "rhs_mag_9x19_17"
];
private _mags_MP443_black = [];
private _mags_MP443_desert = [];
private _mags_MP443_woodland = [];

private _MP443_mags = createHashMapFromArray  [["nocamo", _mags_MP443_nocamo], ["black", _mags_MP443_black], ["desert", _mags_MP443_desert], ["woodland", _mags_MP443_woodland]];
_arsenal_magazines set ["MP443", _MP443_mags];


private _mags_PMM_nocamo = [
    "10Rnd_9x21_Mag"
];
private _mags_PMM_black = [];
private _mags_PMM_desert = [];
private _mags_PMM_woodland = [];

private _PMM_mags = createHashMapFromArray  [["nocamo", _mags_PMM_nocamo], ["black", _mags_PMM_black], ["desert", _mags_PMM_desert], ["woodland", _mags_PMM_woodland]];
_arsenal_magazines set ["PMM", _PMM_mags];


private _mags_6P53_nocamo = [
    "rhs_18rnd_9x21mm_7N28",
    "rhs_18rnd_9x21mm_7N29",
    "rhs_18rnd_9x21mm_7BT3"
];
private _mags_6P53_black = [];
private _mags_6P53_desert = [];
private _mags_6P53_woodland = [];

private _6P53_mags = createHashMapFromArray  [["nocamo", _mags_6P53_nocamo], ["black", _mags_6P53_black], ["desert", _mags_6P53_desert], ["woodland", _mags_6P53_woodland]];
_arsenal_magazines set ["6P53", _6P53_mags];


private _mags_PP2000_nocamo = [
    "rhs_mag_9x19mm_7n21_20",
    "rhs_mag_9x19mm_7n31_20",
    "rhs_mag_9x19mm_7n21_44",
    "rhs_mag_9x19mm_7n31_44"
];
private _mags_PP2000_black = [];
private _mags_PP2000_desert = [];
private _mags_PP2000_woodland = [];

private _PP2000_mags = createHashMapFromArray  [["nocamo", _mags_PP2000_nocamo], ["black", _mags_PP2000_black], ["desert", _mags_PP2000_desert], ["woodland", _mags_PP2000_woodland]];
_arsenal_magazines set ["PP2000", _PP2000_mags];


private _mags_PM_nocamo = [
    "rhs_mag_9x18_8_57N181S"
];
private _mags_PM_black = [];
private _mags_PM_desert = [];
private _mags_PM_woodland = [];

private _PM_mags = createHashMapFromArray  [["nocamo", _mags_PM_nocamo], ["black", _mags_PM_black], ["desert", _mags_PM_desert], ["woodland", _mags_PM_woodland]];
_arsenal_magazines set ["PM", _PM_mags];


private _mags_M9_nocamo = [
    "rhsusf_mag_15Rnd_9x19_FMJ",
    "rhsusf_mag_15Rnd_9x19_JHP"
];
private _mags_M9_black = [];
private _mags_M9_desert = [];
private _mags_M9_woodland = [];

private _M9_mags = createHashMapFromArray  [["nocamo", _mags_M9_nocamo], ["black", _mags_M9_black], ["desert", _mags_M9_desert], ["woodland", _mags_M9_woodland]];
_arsenal_magazines set ["M9", _M9_mags];


private _mags_SIG226_nocamo = [
    "hlc_15Rnd_9x19_B_P226",
    "hlc_15Rnd_9x19_JHP_P226",
    "hlc_15Rnd_9x19_SD_P226"
];
private _mags_SIG226_black = [];
private _mags_SIG226_desert = [];
private _mags_SIG226_woodland = [];

private _SIG226_mags = createHashMapFromArray  [["nocamo", _mags_SIG226_nocamo], ["black", _mags_SIG226_black], ["desert", _mags_SIG226_desert], ["woodland", _mags_SIG226_woodland]];
_arsenal_magazines set ["SIG226", _SIG226_mags];


private _mags_M24_nocamo = [
    "rhsusf_5Rnd_762x51_m118_special_Mag",
    "rhsusf_5Rnd_762x51_m62_Mag"
];
private _mags_M24_black = [];
private _mags_M24_desert = [];
private _mags_M24_woodland = [];

private _M24_mags = createHashMapFromArray  [["nocamo", _mags_M24_nocamo], ["black", _mags_M24_black], ["desert", _mags_M24_desert], ["woodland", _mags_M24_woodland]];
_arsenal_magazines set ["M24", _M24_mags];


private _mags_M200_nocamo = [
    "7Rnd_408_Mag"
];
private _mags_M200_black = [];
private _mags_M200_desert = [];
private _mags_M200_woodland = [];

private _M200_mags = createHashMapFromArray  [["nocamo", _mags_M200_nocamo], ["black", _mags_M200_black], ["desert", _mags_M200_desert], ["woodland", _mags_M200_woodland]];
_arsenal_magazines set ["M200", _M200_mags];


private _mags_AWM_nocamo = [
    "hlc_5rnd_300WM_FMJ_AWM",
    "hlc_5rnd_300WM_T_AWM",
    "hlc_5rnd_300WM_mk248_AWM",
    "hlc_5rnd_300WM_AP_AWM"
];
private _mags_AWM_black = [];
private _mags_AWM_desert = [];
private _mags_AWM_woodland = [];

private _AWM_mags = createHashMapFromArray  [["nocamo", _mags_AWM_nocamo], ["black", _mags_AWM_black], ["desert", _mags_AWM_desert], ["woodland", _mags_AWM_woodland]];
_arsenal_magazines set ["AWM", _AWM_mags];


private _mags_Mosin_nocamo = [
    "rhsgref_5Rnd_762x54_m38"
];
private _mags_Mosin_black = [];
private _mags_Mosin_desert = [];
private _mags_Mosin_woodland = [];

private _Mosin_mags = createHashMapFromArray  [["nocamo", _mags_Mosin_nocamo], ["black", _mags_Mosin_black], ["desert", _mags_Mosin_desert], ["woodland", _mags_Mosin_woodland]];
_arsenal_magazines set ["Mosin", _Mosin_mags];


private _mags_M14_nocamo = [
    "rhsusf_20Rnd_762x51_m118_special_Mag",
    "rhsusf_20Rnd_762x51_m62_Mag",
    "rhsusf_20Rnd_762x51_m80_Mag"
];
private _mags_M14_black = [];
private _mags_M14_desert = [];
private _mags_M14_woodland = [];

private _M14_mags = createHashMapFromArray  [["nocamo", _mags_M14_nocamo], ["black", _mags_M14_black], ["desert", _mags_M14_desert], ["woodland", _mags_M14_woodland]];
_arsenal_magazines set ["M14", _M14_mags];


private _mags_T5000_nocamo = [
    "rhs_5Rnd_338lapua_t5000"
];
private _mags_T5000_black = [];
private _mags_T5000_desert = [];
private _mags_T5000_woodland = [];

private _T5000_mags = createHashMapFromArray  [["nocamo", _mags_T5000_nocamo], ["black", _mags_T5000_black], ["desert", _mags_T5000_desert], ["woodland", _mags_T5000_woodland]];
_arsenal_magazines set ["T5000", _T5000_mags];


private _mags_RPG32_nocamo = ["RPG32_HE_F","RPG32_F"];
private _mags_RPG32_black = [];
private _mags_RPG32_desert = [];
private _mags_RPG32_woodland = [];

private _RPG32_mags = createHashMapFromArray  [["nocamo", _mags_RPG32_nocamo], ["black", _mags_RPG32_black], ["desert", _mags_RPG32_desert], ["woodland", _mags_RPG32_woodland]];
_arsenal_magazines set ["RPG32", _RPG32_mags];


private _mags_Metis_nocamo = ["Vorona_HE","Vorona_HEAT"];
private _mags_Metis_black = [];
private _mags_Metis_desert = [];
private _mags_Metis_woodland = [];

private _Metis_mags = createHashMapFromArray  [["nocamo", _mags_Metis_nocamo], ["black", _mags_Metis_black], ["desert", _mags_Metis_desert], ["woodland", _mags_Metis_woodland]];
_arsenal_magazines set ["Metis", _Metis_mags];


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


private _mags_Igla_nocamo = ["rhs_mag_9k38_rocket"];
private _mags_Igla_black = [];
private _mags_Igla_desert = [];
private _mags_Igla_woodland = [];

private _Igla_mags = createHashMapFromArray  [["nocamo", _mags_Igla_nocamo], ["black", _mags_Igla_black], ["desert", _mags_Igla_desert], ["woodland", _mags_Igla_woodland]];
_arsenal_magazines set ["Igla", _Igla_mags];

_arsenal_magazines set ["types", _arsenal_magazine_types];

_arsenal_magazines
