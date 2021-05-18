private _vehicles = createHashMap;



private _aa = [];
private _veh_0 = createHashMapFromArray [
    ["type", "light"], ["class", "CUP_I_Hilux_igla_TK"],
    ["family", "technical"], ["name", "Technical (Igla)"],
    ["cost", 50], ["fuel", 1], ["upgrade_cost", 15],
    ["woodland", ["any"]], ["desert", ["any"]], ["nocamo", ["any"]],
    ["unlocked", true]
];
_aa append [_veh_0, 10];
private _veh_1 = createHashMapFromArray [
    ["type", "heavy"], ["class", "CUP_B_ZSU23_Afghan_CDF"],
    ["family", "zsu23"], ["name", "ZSU-23-4 Afghanskiy"],
    ["cost", 5], ["fuel", 5], ["upgrade_cost", 0],
    ["woodland", ["SLA"]], ["desert", ["TKA"]], ["nocamo", [""]],
    ["unlocked", false]
];
_aa append [_veh_1, 60];
private _veh_2 = createHashMapFromArray [
    ["type", "heavy"], ["class", "LOP_ISTS_ZSU234"],
    ["family", "zsu23"], ["name", "ZSU-23-4"],
    ["cost", 5], ["fuel", 5], ["upgrade_cost", 1],
    ["woodland", ["standard"]], ["desert", ["LOP_ISTS"]], ["nocamo", [""]],
    ["unlocked", false]
];
_aa append [_veh_2, 40];
_vehicles set ["aa", _aa];

private _apc = [];
private _veh_0 = createHashMapFromArray [
    ["type", "light"], ["class", "LOP_ISTS_OPF_BTR60"],
    ["family", "btr"], ["name", "BTR-60PB"],
    ["cost", 4], ["fuel", 4], ["upgrade_cost", 0],
    ["woodland", [""]], ["desert", [""]], ["nocamo", [""]],
    ["unlocked", false]
];
_apc append [_veh_0, 70];
private _veh_1 = createHashMapFromArray [
    ["type", "light"], ["class", "rhs_btr70_vmf"],
    ["family", "btr"], ["name", "BTR-70"],
    ["cost", 4], ["fuel", 4], ["upgrade_cost", 1],
    ["woodland", ["Desert","Takistan","Omon2"]], ["desert", ["Belarusian","Desert","Takistan","Omon2"]], ["nocamo", [""]],
    ["unlocked", false]
];
_apc append [_veh_1, 50];
private _veh_2 = createHashMapFromArray [
    ["type", "heavy"], ["class", "CUP_B_M113_USA"],
    ["family", "m113"], ["name", "M113"],
    ["cost", 3], ["fuel", 5], ["upgrade_cost", 0],
    ["woodland", ["OliveDrab"]], ["desert", ["Desert"]], ["nocamo", [""]],
    ["unlocked", false]
];
_apc append [_veh_2, 70];
private _veh_3 = createHashMapFromArray [
    ["type", "heavy"], ["class", "CUP_O_MTLB_pk_TKA"],
    ["family", "mtlb"], ["name", "MT-LB"],
    ["cost", 3], ["fuel", 5], ["upgrade_cost", 0],
    ["woodland", ["NAPA","SYNDIKAT"]], ["desert", ["SYNDIKAT"]], ["nocamo", [""]],
    ["unlocked", false]
];
_apc append [_veh_3, 80];
_vehicles set ["apc", _apc];

private _artillery = [];
private _veh_0 = createHashMapFromArray [
    ["type", "light"], ["class", "CUP_I_Hilux_podnos_TK"],
    ["family", "technical"], ["name", "Technical (Podnos)"],
    ["cost", 50], ["fuel", 1], ["upgrade_cost", 15],
    ["woodland", ["any"]], ["desert", ["any"]], ["nocamo", ["any"]],
    ["unlocked", true]
];
_artillery append [_veh_0, 30];
private _veh_1 = createHashMapFromArray [
    ["type", "light"], ["class", "CUP_I_Hilux_UB32_TK"],
    ["family", "technical"], ["name", "Technical (UB-32)"],
    ["cost", 50], ["fuel", 1], ["upgrade_cost", 15],
    ["woodland", ["any"]], ["desert", ["any"]], ["nocamo", ["any"]],
    ["unlocked", true]
];
_artillery append [_veh_1, 20];
private _veh_2 = createHashMapFromArray [
    ["type", "light"], ["class", "CUP_I_Hilux_MLRS_TK"],
    ["family", "technical"], ["name", "Technical (Improvised MLRS)"],
    ["cost", 50], ["fuel", 1], ["upgrade_cost", 15],
    ["woodland", ["any"]], ["desert", ["any"]], ["nocamo", ["any"]],
    ["unlocked", true]
];
_artillery append [_veh_2, 15];
_vehicles set ["artillery", _artillery];

private _atgm = [];
private _veh_0 = createHashMapFromArray [
    ["type", "light"], ["class", "CUP_I_Hilux_metis_TK"],
    ["family", "technical"], ["name", "Technical (metis)"],
    ["cost", 50], ["fuel", 1], ["upgrade_cost", 15],
    ["woodland", ["any"]], ["desert", ["any"]], ["nocamo", ["any"]],
    ["unlocked", true]
];
_atgm append [_veh_0, 10];
_vehicles set ["atgm", _atgm];

private _fob_veh = [];
private _veh_0 = createHashMapFromArray [
    ["type", "service"], ["class", "RHS_Ural_Repair_MSV_01"],
    ["family", "fob_veh"], ["name", "FOB truck"],
    ["cost", 100], ["fuel", 2], ["upgrade_cost", 0],
    ["woodland", ["standard"]], ["desert", ["rhs_sand"]], ["nocamo", [""]],
    ["unlocked", true], ["can_recycle", true]
];
_fob_veh append [_veh_0, 100];
_vehicles set ["fob_veh", _fob_veh];

private _ifv = [];
private _veh_0 = createHashMapFromArray [
    ["type", "heavy"], ["class", "LOP_ISTS_BMP1"],
    ["family", "bmp1"], ["name", "BMP-1"],
    ["cost", 4], ["fuel", 5], ["upgrade_cost", 0],
    ["woodland", ["chedaki"]], ["desert", [""]], ["nocamo", [""]],
    ["unlocked", false]
];
_ifv append [_veh_0, 50];
private _veh_1 = createHashMapFromArray [
    ["type", "heavy"], ["class", "rhs_bmp1d_vdv"],
    ["family", "bmp1"], ["name", "BMP-1D"],
    ["cost", 4], ["fuel", 5], ["upgrade_cost", 1],
    ["woodland", ["chedaki"]], ["desert", ["LOP_Afghani"]], ["nocamo", [""]],
    ["unlocked", false]
];
_ifv append [_veh_1, 40];
private _veh_2 = createHashMapFromArray [
    ["type", "heavy"], ["class", "rhs_bmp1p_vdv"],
    ["family", "bmp1"], ["name", "BMP-1P"],
    ["cost", 4], ["fuel", 5], ["upgrade_cost", 1],
    ["woodland", ["chedaki"]], ["desert", ["LOP_Afghani"]], ["nocamo", [""]],
    ["unlocked", false]
];
_ifv append [_veh_2, 30];
private _veh_3 = createHashMapFromArray [
    ["type", "heavy"], ["class", "CUP_O_BMP2_ZU_TKA"],
    ["family", "bpm2"], ["name", "BMP-2 (ZU-23)"],
    ["cost", 4], ["fuel", 5], ["upgrade_cost", 0],
    ["woodland", ["NAPA"]], ["desert", ["CZ_DES"]], ["nocamo", [""]],
    ["unlocked", false]
];
_ifv append [_veh_3, 45];
private _veh_4 = createHashMapFromArray [
    ["type", "heavy"], ["class", "rhs_bmp2e_vdv"],
    ["family", "bpm2"], ["name", "BMP-2"],
    ["cost", 5], ["fuel", 5], ["upgrade_cost", 1],
    ["woodland", ["chedaki"]], ["desert", ["LOP_Afghani"]], ["nocamo", [""]],
    ["unlocked", false]
];
_ifv append [_veh_4, 35];
_vehicles set ["ifv", _ifv];

private _repair_veh = [];
private _veh_0 = createHashMapFromArray [
    ["type", "service"], ["class", "CUP_O_Ural_Repair_RU"],
    ["family", "repair_veh"], ["name", "Repair truck"],
    ["cost", 10], ["fuel", 1], ["upgrade_cost", 0],
    ["woodland", ["SLA"]], ["desert", ["RUD"]], ["nocamo", [""]],
    ["unlocked", true], ["can_recycle", true]
];
_repair_veh append [_veh_0, 100];
_vehicles set ["repair_veh", _repair_veh];

private _respawn_veh = [];
private _veh_0 = createHashMapFromArray [
    ["type", "service"], ["class", "RHS_Ural_MSV_01"],
    ["family", "respawn_veh"], ["name", "Respawn truck"],
    ["cost", 20], ["fuel", 2], ["upgrade_cost", 0],
    ["woodland", ["Camo"]], ["desert", ["Camo"]], ["nocamo", [""]],
    ["unlocked", true]
];
_respawn_veh append [_veh_0, 100];
private _veh_1 = createHashMapFromArray [
    ["type", "service"], ["class", "rhs_bmp1k_vdv"],
    ["family", "respawn_veh"], ["name", "Respawn BMP-1"],
    ["cost", 50], ["fuel", 5], ["upgrade_cost", 30],
    ["woodland", ["standard"]], ["desert", ["LOP_Afghani"]], ["nocamo", [""]],
    ["unlocked", true]
];
_respawn_veh append [_veh_1, 100];
_vehicles set ["respawn_veh", _respawn_veh];

private _support = [];
private _veh_0 = createHashMapFromArray [
    ["type", "light"], ["class", "CUP_I_Hilux_DSHKM_TK"],
    ["family", "technical"], ["name", "Technical (DshKM)"],
    ["cost", 5], ["fuel", 1], ["upgrade_cost", 5],
    ["woodland", ["any"]], ["desert", ["any"]], ["nocamo", ["any"]],
    ["unlocked", true]
];
_support append [_veh_0, 100];
private _veh_1 = createHashMapFromArray [
    ["type", "light"], ["class", "CUP_I_Hilux_M2_TK"],
    ["family", "technical"], ["name", "Technical (M2)"],
    ["cost", 7], ["fuel", 1], ["upgrade_cost", 5],
    ["woodland", ["any"]], ["desert", ["any"]], ["nocamo", ["any"]],
    ["unlocked", true]
];
_support append [_veh_1, 100];
private _veh_2 = createHashMapFromArray [
    ["type", "light"], ["class", "CUP_I_Hilux_AGS30_TK"],
    ["family", "technical"], ["name", "Technical (AGS-30)"],
    ["cost", 10], ["fuel", 1], ["upgrade_cost", 5],
    ["woodland", ["any"]], ["desert", ["any"]], ["nocamo", ["any"]],
    ["unlocked", true]
];
_support append [_veh_2, 60];
private _veh_3 = createHashMapFromArray [
    ["type", "light"], ["class", "CUP_I_Hilux_btr60_TK"],
    ["family", "technical"], ["name", "Technical (BTR turret)"],
    ["cost", 15], ["fuel", 1], ["upgrade_cost", 10],
    ["woodland", ["any"]], ["desert", ["any"]], ["nocamo", ["any"]],
    ["unlocked", true]
];
_support append [_veh_3, 45];
private _veh_4 = createHashMapFromArray [
    ["type", "light"], ["class", "CUP_I_Hilux_zu23_TK"],
    ["family", "technical"], ["name", "Technical (ZU-23)"],
    ["cost", 25], ["fuel", 1], ["upgrade_cost", 10],
    ["woodland", ["any"]], ["desert", ["any"]], ["nocamo", ["any"]],
    ["unlocked", true]
];
_support append [_veh_4, 50];
private _veh_5 = createHashMapFromArray [
    ["type", "light"], ["class", "CUP_I_Hilux_BMP1_TK"],
    ["family", "technical"], ["name", "Technical (BMP turret)"],
    ["cost", 30], ["fuel", 1], ["upgrade_cost", 15],
    ["woodland", ["any"]], ["desert", ["any"]], ["nocamo", ["any"]],
    ["unlocked", true]
];
_support append [_veh_5, 35];
private _veh_6 = createHashMapFromArray [
    ["type", "light"], ["class", "CUP_I_Hilux_SPG9_TK"],
    ["family", "technical"], ["name", "Technical (SPG-9)"],
    ["cost", 25], ["fuel", 1], ["upgrade_cost", 10],
    ["woodland", ["any"]], ["desert", ["any"]], ["nocamo", ["any"]],
    ["unlocked", true]
];
_support append [_veh_6, 60];
private _veh_7 = createHashMapFromArray [
    ["type", "light"], ["class", "CUP_I_Hilux_armored_M2_TK"],
    ["family", "technical"], ["name", "Armored Technical (M2) "],
    ["cost", 15], ["fuel", 2], ["upgrade_cost", 20],
    ["woodland", ["any"]], ["desert", ["any"]], ["nocamo", ["any"]],
    ["unlocked", true]
];
_support append [_veh_7, 50];
private _veh_8 = createHashMapFromArray [
    ["type", "light"], ["class", "CUP_I_Hilux_armored_BTR60_TK"],
    ["family", "technical"], ["name", "Armored Technical (BTR) "],
    ["cost", 30], ["fuel", 2], ["upgrade_cost", 20],
    ["woodland", ["any"]], ["desert", ["any"]], ["nocamo", ["any"]],
    ["unlocked", true]
];
_support append [_veh_8, 40];
private _veh_9 = createHashMapFromArray [
    ["type", "light"], ["class", "CUP_I_Hilux_armored_BMP1_TK"],
    ["family", "technical"], ["name", "Armored Technical (BMP) "],
    ["cost", 40], ["fuel", 2], ["upgrade_cost", 20],
    ["woodland", ["any"]], ["desert", ["any"]], ["nocamo", ["any"]],
    ["unlocked", true]
];
_support append [_veh_9, 30];
private _veh_10 = createHashMapFromArray [
    ["type", "light"], ["class", "rhsgref_BRDM2"],
    ["family", "brdm"], ["name", "BRDM-2"],
    ["cost", 3], ["fuel", 4], ["upgrade_cost", 0],
    ["woodland", ["olive","khaki","3tone"]], ["desert", ["3tone"]], ["nocamo", [""]],
    ["unlocked", false]
];
_support append [_veh_10, 50];
private _veh_11 = createHashMapFromArray [
    ["type", "light"], ["class", "rhsgref_ins_g_ural_Zu23"],
    ["family", "ural"], ["name", "Ural (ZU-23)"],
    ["cost", 2], ["fuel", 3], ["upgrade_cost", 0],
    ["woodland", ["standard"]], ["desert", [""]], ["nocamo", [""]],
    ["unlocked", false]
];
_support append [_veh_11, 80];
_vehicles set ["support", _support];

private _tank = [];
private _veh_0 = createHashMapFromArray [
    ["type", "heavy"], ["class", "LOP_ISTS_T55"],
    ["family", "t55"], ["name", "T-55A"],
    ["cost", 8], ["fuel", 9], ["upgrade_cost", 0],
    ["woodland", [""]], ["desert", [""]], ["nocamo", [""]],
    ["unlocked", false]
];
_tank append [_veh_0, 20];
private _veh_1 = createHashMapFromArray [
    ["type", "heavy"], ["class", "CUP_B_T72_CDF"],
    ["family", "t72"], ["name", "T-72M"],
    ["cost", 10], ["fuel", 10], ["upgrade_cost", 0],
    ["woodland", ["CDF"]], ["desert", ["RACS"]], ["nocamo", [""]],
    ["unlocked", false]
];
_tank append [_veh_1, 8];
private _veh_2 = createHashMapFromArray [
    ["type", "heavy"], ["class", "LOP_ISTS_T72BA"],
    ["family", "t72b"], ["name", "T-72B (1984)"],
    ["cost", 10], ["fuel", 10], ["upgrade_cost", 0],
    ["woodland", ["standard"]], ["desert", ["rhs_Sand"]], ["nocamo", [""]],
    ["unlocked", false]
];
_tank append [_veh_2, 4];
private _veh_3 = createHashMapFromArray [
    ["type", "heavy"], ["class", "rhs_t72bb_tv"],
    ["family", "t72b"], ["name", "T-72B (1985)"],
    ["cost", 12], ["fuel", 10], ["upgrade_cost", 1],
    ["woodland", ["standard"]], ["desert", ["rhs_Sand"]], ["nocamo", [""]],
    ["unlocked", false]
];
_tank append [_veh_3, 1];
private _veh_4 = createHashMapFromArray [
    ["type", "heavy"], ["class", "CUP_B_M60A3_USMC"],
    ["family", "m60"], ["name", "M60A3"],
    ["cost", 10], ["fuel", 10], ["upgrade_cost", 0],
    ["woodland", ["USMC"]], ["desert", ["RACS"]], ["nocamo", [""]],
    ["unlocked", false]
];
_tank append [_veh_4, 10];
private _veh_5 = createHashMapFromArray [
    ["type", "heavy"], ["class", "CUP_B_M60A3_TTS_USMC"],
    ["family", "m60"], ["name", "M60A3 (TTS)"],
    ["cost", 12], ["fuel", 10], ["upgrade_cost", 1],
    ["woodland", ["USMC"]], ["desert", ["RACS"]], ["nocamo", [""]],
    ["unlocked", false]
];
_tank append [_veh_5, 1];
_vehicles set ["tank", _tank];

private _transport = [];
private _veh_0 = createHashMapFromArray [
    ["type", "service"], ["class", "rhsgref_ins_kraz255b1_flatbed"],
    ["family", "transport_veh"], ["name", "Transport truck"],
    ["cost", 2], ["fuel", 2], ["upgrade_cost", 0],
    ["woodland", [""]], ["desert", [""]], ["nocamo", [""]],
    ["unlocked", true], ["cargo_offset", [-6.5, [0, -0.8, 0.4], [0,-2.4, 0.4], [0, -4.0, 0.4]]]
];
_transport append [_veh_0, 100];
private _veh_1 = createHashMapFromArray [
    ["type", "light"], ["class", "CUP_I_Hilux_unarmed_TK"],
    ["family", "technical"], ["name", "Technical"],
    ["cost", 2], ["fuel", 1], ["upgrade_cost", 0],
    ["woodland", ["any"]], ["desert", ["any"]], ["nocamo", ["any"]],
    ["unlocked", true]
];
_transport append [_veh_1, 100];
private _veh_2 = createHashMapFromArray [
    ["type", "light"], ["class", "rhssaf_m1151_olive_pkm"],
    ["family", "m1151"], ["name", "M1151 (PKM)"],
    ["cost", 2], ["fuel", 2], ["upgrade_cost", 0],
    ["woodland", ["rhs_olive"]], ["desert", ["rhs_desert"]], ["nocamo", [""]],
    ["unlocked", false]
];
_transport append [_veh_2, 40];
_vehicles set ["transport", _transport];

_vehicles
