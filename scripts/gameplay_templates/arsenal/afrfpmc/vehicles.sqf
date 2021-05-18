private _vehicles = createHashMap;



private _aa = [];
private _veh_0 = createHashMapFromArray [
    ["type", "heavy"], ["class", "rhs_zsu234_aa"],
    ["family", "aaa"], ["name", "ZSU-23-4"],
    ["cost", 60], ["fuel", 5], ["upgrade_cost", 0],
    ["woodland", ["standard"]], ["desert", ["rhs_sand"]], ["nocamo", [""]],
    ["unlocked", false]
];
_aa append [_veh_0, 20];
private _veh_1 = createHashMapFromArray [
    ["type", "heavy"], ["class", "CUP_O_2S6_RU"],
    ["family", "aaa"], ["name", "2S6 Tunguska"],
    ["cost", 200], ["fuel", 5], ["upgrade_cost", 50],
    ["woodland", [""]], ["desert", [""]], ["nocamo", [""]],
    ["unlocked", false]
];
_aa append [_veh_1, 0.3];
_vehicles set ["aa", _aa];

private _apc = [];
private _veh_0 = createHashMapFromArray [
    ["type", "light"], ["class", "rhs_btr80_msv"],
    ["family", "btr"], ["name", "BTR-80"],
    ["cost", 35], ["fuel", 4], ["upgrade_cost", 0],
    ["woodland", ["standard","tricolourparade","tricolourhard"]], ["desert", ["rhs_sand","tricolourhard"]], ["nocamo", [""]],
    ["unlocked", false]
];
_apc append [_veh_0, 40];
private _veh_1 = createHashMapFromArray [
    ["type", "light"], ["class", "rhs_btr80a_msv"],
    ["family", "btr"], ["name", "BTR-80A"],
    ["cost", 45], ["fuel", 4], ["upgrade_cost", 15],
    ["woodland", ["standard","tricolourhard"]], ["desert", ["rhs_sand","tricolourhard"]], ["nocamo", [""]],
    ["unlocked", false]
];
_apc append [_veh_1, 10];
_vehicles set ["apc", _apc];

private _artillery = [];
private _veh_0 = createHashMapFromArray [
    ["type", "heavy"], ["class", "rhs_2s1_tv"],
    ["family", "arty"], ["name", "2S1"],
    ["cost", 120], ["fuel", 5], ["upgrade_cost", 0],
    ["woodland", ["light","standard_dirty","light_dirty","RHS_SAF_Camo","standard"]], ["desert", ["sand"]], ["nocamo", [""]],
    ["unlocked", false]
];
_artillery append [_veh_0, 10];
private _veh_1 = createHashMapFromArray [
    ["type", "heavy"], ["class", "rhs_2s3_tv"],
    ["family", "arty"], ["name", "2S3M1"],
    ["cost", 160], ["fuel", 5], ["upgrade_cost", 50],
    ["woodland", ["standard","rhs_tri"]], ["desert", ["rhs_sand","rhs_tri"]], ["nocamo", [""]],
    ["unlocked", false]
];
_artillery append [_veh_1, 1];
_vehicles set ["artillery", _artillery];

private _atgm = [];
private _veh_0 = createHashMapFromArray [
    ["type", "light"], ["class", "rhsgref_BRDM2_ATGM"],
    ["family", "brdm"], ["name", "BRDM-2 (Konkurs)"],
    ["cost", 50], ["fuel", 4], ["upgrade_cost", 15],
    ["woodland", ["olive","khaki"]], ["desert", ["khaki"]], ["nocamo", [""]],
    ["unlocked", false]
];
_atgm append [_veh_0, 5];
_vehicles set ["atgm", _atgm];

private _attack = [];
private _veh_0 = createHashMapFromArray [
    ["type", "air"], ["class", "RHS_Mi24V_vvs"],
    ["family", "mi24"], ["name", "Mi-24V"],
    ["cost", 180], ["fuel", 11], ["upgrade_cost", 0],
    ["woodland", ["LOP_SRI","Camo","Camo1","Camo2","Camo3"]], ["desert", ["Camo1","Camo3"]], ["nocamo", ["standard","LOP_SHA"]],
    ["unlocked", false]
];
_attack append [_veh_0, 1];
private _veh_1 = createHashMapFromArray [
    ["type", "air"], ["class", "RHS_Mi24P_vvs"],
    ["family", "mi24"], ["name", "Mi-24P"],
    ["cost", 180], ["fuel", 11], ["upgrade_cost", 10],
    ["woodland", ["LOP_SRI","Camo","Camo1","Camo2","Camo3"]], ["desert", ["Camo1","Camo3"]], ["nocamo", ["standard"]],
    ["unlocked", false]
];
_attack append [_veh_1, 1];
private _veh_2 = createHashMapFromArray [
    ["type", "air"], ["class", "rhsgref_mi24g_CAS"],
    ["family", "mi24"], ["name", "MI-35P"],
    ["cost", 200], ["fuel", 11], ["upgrade_cost", 30],
    ["woodland", ["Camo","Camo1","Camo2","Camo3"]], ["desert", ["Camo1","Camo3"]], ["nocamo", ["standard"]],
    ["unlocked", false]
];
_attack append [_veh_2, 0.1];
_vehicles set ["attack", _attack];

private _fob_veh = [];
private _veh_0 = createHashMapFromArray [
    ["type", "service"], ["class", "O_T_Truck_02_Medical_F"],
    ["family", "fob_veh"], ["name", "FOB truck"],
    ["cost", 100], ["fuel", 2], ["upgrade_cost", 0],
    ["woodland", ["EAF"]], ["desert", [""]], ["nocamo", [""]],
    ["unlocked", true]
];
_fob_veh append [_veh_0, 100];
_vehicles set ["fob_veh", _fob_veh];

private _ifv = [];
private _veh_0 = createHashMapFromArray [
    ["type", "heavy"], ["class", "rhs_bmp1d_vdv"],
    ["family", "bmp1"], ["name", "BMP-1D"],
    ["cost", 80], ["fuel", 5], ["upgrade_cost", 0],
    ["woodland", ["standard"]], ["desert", ["rhs_sand"]], ["nocamo", [""]],
    ["unlocked", false]
];
_ifv append [_veh_0, 20];
private _veh_1 = createHashMapFromArray [
    ["type", "heavy"], ["class", "rhs_bmp1p_vdv"],
    ["family", "bmp1"], ["name", "BMP-1D"],
    ["cost", 90], ["fuel", 5], ["upgrade_cost", 20],
    ["woodland", ["standard"]], ["desert", ["rhs_sand"]], ["nocamo", [""]],
    ["unlocked", false]
];
_ifv append [_veh_1, 10];
private _veh_2 = createHashMapFromArray [
    ["type", "heavy"], ["class", "rhs_bmp2_vdv"],
    ["family", "bmp2"], ["name", "BMP-2 (1986)"],
    ["cost", 100], ["fuel", 5], ["upgrade_cost", 0],
    ["woodland", ["standard"]], ["desert", ["rhs_sand"]], ["nocamo", [""]],
    ["unlocked", false]
];
_ifv append [_veh_2, 5];
private _veh_3 = createHashMapFromArray [
    ["type", "heavy"], ["class", "rhs_bmp2d_vdv"],
    ["family", "bmp2"], ["name", "BMP-2D"],
    ["cost", 110], ["fuel", 5], ["upgrade_cost", 10],
    ["woodland", ["standard"]], ["desert", ["rhs_sand"]], ["nocamo", [""]],
    ["unlocked", false]
];
_ifv append [_veh_3, 2];
private _veh_4 = createHashMapFromArray [
    ["type", "heavy"], ["class", "rhs_bmp3_msv"],
    ["family", "bmp3"], ["name", "BMP-3 (early)"],
    ["cost", 140], ["fuel", 5], ["upgrade_cost", 0],
    ["woodland", ["standard"]], ["desert", ["rhs_sand"]], ["nocamo", [""]],
    ["unlocked", false]
];
_ifv append [_veh_4, 0.4];
private _veh_5 = createHashMapFromArray [
    ["type", "heavy"], ["class", "rhs_bmp3m_msv"],
    ["family", "bmp3"], ["name", "BMP-3M"],
    ["cost", 170], ["fuel", 5], ["upgrade_cost", 50],
    ["woodland", ["standard"]], ["desert", ["rhs_sand"]], ["nocamo", [""]],
    ["unlocked", false]
];
_ifv append [_veh_5, 0.1];
_vehicles set ["ifv", _ifv];

private _repair_veh = [];
private _veh_0 = createHashMapFromArray [
    ["type", "service"], ["class", "CUP_O_Kamaz_Repair_RU"],
    ["family", "repair_veh"], ["name", "Repair truck"],
    ["cost", 10], ["fuel", 1], ["upgrade_cost", 0],
    ["woodland", ["RU"]], ["desert", ["RU"]], ["nocamo", [""]],
    ["unlocked", true], ["can_recycle", true]
];
_repair_veh append [_veh_0, 100];
_vehicles set ["repair_veh", _repair_veh];

private _respawn_veh = [];
private _veh_0 = createHashMapFromArray [
    ["type", "service"], ["class", "CUP_B_BRDM2_HQ_CDF"],
    ["family", "respawn_veh"], ["name", "BRDM-2 (HQ)"],
    ["cost", 20], ["fuel", 4], ["upgrade_cost", 0],
    ["woodland", ["NAPA","RU","CZ"]], ["desert", ["RU","CZD"]], ["nocamo", [""]],
    ["unlocked", true]
];
_respawn_veh append [_veh_0, 100];
private _veh_1 = createHashMapFromArray [
    ["type", "service"], ["class", "rhs_typhoon_vdv"],
    ["family", "respawn_veh"], ["name", "Respawn truck"],
    ["cost", 20], ["fuel", 3], ["upgrade_cost", 30],
    ["woodland", ["rhs_green"]], ["desert", [""]], ["nocamo", [""]],
    ["unlocked", true]
];
_respawn_veh append [_veh_1, 100];
_vehicles set ["respawn_veh", _respawn_veh];

private _support = [];
private _veh_0 = createHashMapFromArray [
    ["type", "light"], ["class", "CUP_O_GAZ_Vodnik_KPVT_RU"],
    ["family", "vodnik"], ["name", "GAZ-3937 Vodnik (KPV)"],
    ["cost", 40], ["fuel", 3], ["upgrade_cost", 50],
    ["woodland", [""]], ["desert", [""]], ["nocamo", [""]],
    ["unlocked", true]
];
_support append [_veh_0, 100];
private _veh_1 = createHashMapFromArray [
    ["type", "light"], ["class", "CUP_O_GAZ_Vodnik_BPPU_RU"],
    ["family", "vodnik"], ["name", "GAZ-3937 Vodnik (2A42)"],
    ["cost", 60], ["fuel", 3], ["upgrade_cost", 100],
    ["woodland", [""]], ["desert", [""]], ["nocamo", [""]],
    ["unlocked", true]
];
_support append [_veh_1, 100];
private _veh_2 = createHashMapFromArray [
    ["type", "light"], ["class", "rhsgref_BRDM2"],
    ["family", "brdm"], ["name", "BRDM-2"],
    ["cost", 30], ["fuel", 4], ["upgrade_cost", 0],
    ["woodland", ["olive","khaki","3tone"]], ["desert", ["3tone"]], ["nocamo", [""]],
    ["unlocked", false]
];
_support append [_veh_2, 50];
private _veh_3 = createHashMapFromArray [
    ["type", "air"], ["class", "CUP_I_Ka60_GL_Blk_ION"],
    ["family", "ka60"], ["name", "Ka-60 (M-32)"],
    ["cost", 100], ["fuel", 8], ["upgrade_cost", 20],
    ["woodland", [""]], ["desert", [""]], ["nocamo", ["Black","Grey"]],
    ["unlocked", false]
];
_support append [_veh_3, 1];
private _veh_4 = createHashMapFromArray [
    ["type", "air"], ["class", "RHS_Mi8MTV3_vvs"],
    ["family", "mi8"], ["name", "MI-8MTV-3"],
    ["cost", 150], ["fuel", 9], ["upgrade_cost", 30],
    ["woodland", ["LOP_SLA"]], ["desert", [""]], ["nocamo", ["standard"]],
    ["unlocked", false]
];
_support append [_veh_4, 5];
private _veh_5 = createHashMapFromArray [
    ["type", "air"], ["class", "RHS_Mi8AMTSh_vvs"],
    ["family", "mi8"], ["name", "Mi-8AMTSh"],
    ["cost", 150], ["fuel", 9], ["upgrade_cost", 30],
    ["woodland", ["Camo2","Camo3","Camo5"]], ["desert", ["Camo2","Camo5"]], ["nocamo", ["standard"]],
    ["unlocked", false]
];
_support append [_veh_5, 0.7];
_vehicles set ["support", _support];

private _tank = [];
private _veh_0 = createHashMapFromArray [
    ["type", "heavy"], ["class", "CUP_B_T72_CDF"],
    ["family", "t72"], ["name", "T-72"],
    ["cost", 170], ["fuel", 10], ["upgrade_cost", 0],
    ["woodland", ["NAPA","RU"]], ["desert", ["RU"]], ["nocamo", [""]],
    ["unlocked", false]
];
_tank append [_veh_0, 8];
private _veh_1 = createHashMapFromArray [
    ["type", "heavy"], ["class", "CUP_B_T72_CZ"],
    ["family", "t72"], ["name", "T-72M4CZ"],
    ["cost", 200], ["fuel", 10], ["upgrade_cost", 20],
    ["woodland", [""]], ["desert", [""]], ["nocamo", [""]],
    ["unlocked", false]
];
_tank append [_veh_1, 1];
private _veh_2 = createHashMapFromArray [
    ["type", "heavy"], ["class", "rhs_t72bb_tv"],
    ["family", "t72b"], ["name", "T-72B (1985)"],
    ["cost", 200], ["fuel", 10], ["upgrade_cost", 0],
    ["woodland", ["standard"]], ["desert", ["rhs_Sand"]], ["nocamo", [""]],
    ["unlocked", false]
];
_tank append [_veh_2, 4];
private _veh_3 = createHashMapFromArray [
    ["type", "heavy"], ["class", "rhs_t72bd_tv"],
    ["family", "t72b"], ["name", "T-72B3 (2012)"],
    ["cost", 220], ["fuel", 10], ["upgrade_cost", 40],
    ["woodland", ["standard"]], ["desert", ["rhs_Sand"]], ["nocamo", [""]],
    ["unlocked", false]
];
_tank append [_veh_3, 0.5];
private _veh_4 = createHashMapFromArray [
    ["type", "heavy"], ["class", "rhs_t80b"],
    ["family", "t80b"], ["name", "T-80B"],
    ["cost", 180], ["fuel", 14], ["upgrade_cost", 0],
    ["woodland", ["RHS_CDF"]], ["desert", [""]], ["nocamo", [""]],
    ["unlocked", false]
];
_tank append [_veh_4, 5];
private _veh_5 = createHashMapFromArray [
    ["type", "heavy"], ["class", "rhs_t80u"],
    ["family", "t80b"], ["name", "T-80U"],
    ["cost", 200], ["fuel", 14], ["upgrade_cost", 45],
    ["woodland", ["standard","tricolor"]], ["desert", ["tricolor"]], ["nocamo", [""]],
    ["unlocked", false]
];
_tank append [_veh_5, 1];
private _veh_6 = createHashMapFromArray [
    ["type", "heavy"], ["class", "rhs_sprut_vdv"],
    ["family", "sprut"], ["name", "2S25 Sprut"],
    ["cost", 150], ["fuel", 6], ["upgrade_cost", 0],
    ["woodland", ["standard"]], ["desert", [""]], ["nocamo", [""]],
    ["unlocked", false]
];
_tank append [_veh_6, 2];
_vehicles set ["tank", _tank];

private _transport = [];
private _veh_0 = createHashMapFromArray [
    ["type", "service"], ["class", "CUP_O_Kamaz_Open_RU"],
    ["family", "transport_veh"], ["name", "Transport truck"],
    ["cost", 2], ["fuel", 1], ["upgrade_cost", 0],
    ["woodland", ["Green","RU","Camo1"]], ["desert", ["RU"]], ["nocamo", [""]],
    ["unlocked", true], ["cargo_offset", [-6.5, [0, -0.8, 0.4], [0,-2.4, 0.4], [0, -4.0, 0.4]]]
];
_transport append [_veh_0, 100];
private _veh_1 = createHashMapFromArray [
    ["type", "light"], ["class", "CUP_O_GAZ_Vodnik_Unarmed_RU"],
    ["family", "vodnik"], ["name", "GAZ-3937 Vodnik"],
    ["cost", 5], ["fuel", 3], ["upgrade_cost", 0],
    ["woodland", [""]], ["desert", [""]], ["nocamo", [""]],
    ["unlocked", true]
];
_transport append [_veh_1, 100];
private _veh_2 = createHashMapFromArray [
    ["type", "light"], ["class", "CUP_O_GAZ_Vodnik_PK_RU"],
    ["family", "vodnik"], ["name", "GAZ-3937 Vodnik (PKM)"],
    ["cost", 15], ["fuel", 3], ["upgrade_cost", 30],
    ["woodland", [""]], ["desert", [""]], ["nocamo", [""]],
    ["unlocked", true]
];
_transport append [_veh_2, 100];
private _veh_3 = createHashMapFromArray [
    ["type", "light"], ["class", "CUP_O_GAZ_Vodnik_AGS_RU"],
    ["family", "vodnik"], ["name", "GAZ-3937 Vodnik (AGS)"],
    ["cost", 25], ["fuel", 3], ["upgrade_cost", 30],
    ["woodland", [""]], ["desert", [""]], ["nocamo", [""]],
    ["unlocked", true]
];
_transport append [_veh_3, 100];
private _veh_4 = createHashMapFromArray [
    ["type", "light"], ["class", "rhs_tigr_vdv"],
    ["family", "tigr"], ["name", "GAZ-233011 Tigr"],
    ["cost", 10], ["fuel", 2], ["upgrade_cost", 0],
    ["woodland", ["standard","Camo"]], ["desert", ["Camo"]], ["nocamo", [""]],
    ["unlocked", false]
];
_transport append [_veh_4, 100];
private _veh_5 = createHashMapFromArray [
    ["type", "light"], ["class", "rhs_tigr_sts_vdv"],
    ["family", "tigr"], ["name", "GAZ-233014 Tigr"],
    ["cost", 20], ["fuel", 2], ["upgrade_cost", 10],
    ["woodland", ["standard","Camo"]], ["desert", ["Camo"]], ["nocamo", [""]],
    ["unlocked", false]
];
_transport append [_veh_5, 60];
private _veh_6 = createHashMapFromArray [
    ["type", "light"], ["class", "rhs_tigr_m_vdv"],
    ["family", "tigr"], ["name", "GAZ-233114 Tigr"],
    ["cost", 10], ["fuel", 2], ["upgrade_cost", 5],
    ["woodland", ["standard","Camo"]], ["desert", ["Camo"]], ["nocamo", [""]],
    ["unlocked", false]
];
_transport append [_veh_6, 90];
private _veh_7 = createHashMapFromArray [
    ["type", "air"], ["class", "I_C_Heli_Light_01_civil_F"],
    ["family", "mh6"], ["name", "MH-6 Little Bird"],
    ["cost", 100], ["fuel", 8], ["upgrade_cost", 0],
    ["woodland", [""]], ["desert", [""]], ["nocamo", [""]],
    ["unlocked", false]
];
_transport append [_veh_7, 20];
private _veh_8 = createHashMapFromArray [
    ["type", "air"], ["class", "rhs_ka60_grey"],
    ["family", "ka60"], ["name", "Ka-60"],
    ["cost", 100], ["fuel", 8], ["upgrade_cost", 0],
    ["woodland", ["vvs_camo"]], ["desert", [""]], ["nocamo", ["vvs_grey"]],
    ["unlocked", false]
];
_transport append [_veh_8, 10];
private _veh_9 = createHashMapFromArray [
    ["type", "air"], ["class", "RHS_Mi8mt_vvs"],
    ["family", "mi8"], ["name", "Mi-8MT"],
    ["cost", 100], ["fuel", 9], ["upgrade_cost", 0],
    ["woodland", ["Camo3","Camo2"]], ["desert", ["Camo5","Camo2","LOP_AA"]], ["nocamo", ["standard"]],
    ["unlocked", false]
];
_transport append [_veh_9, 25];
_vehicles set ["transport", _transport];

_vehicles
