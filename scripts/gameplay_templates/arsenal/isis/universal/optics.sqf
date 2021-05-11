private _arsenal_optics = createHashMap;
private _optics_combat = createHashMap;

// Block: optics type: combat, mount type: Dovetail
private _combat_Dovetail_nocamo = ["rhs_acc_pso1m2", "rhs_acc_pso1m21", "rhs_acc_1p29"];
private _combat_Dovetail_black = [];
private _combat_Dovetail_desert = [];
private _combat_Dovetail_woodland = [];

private _combat_Dovetail = createHashMapFromArray [["nocamo", _combat_Dovetail_nocamo], ["black", _combat_Dovetail_black], ["desert", _combat_Dovetail_desert], ["woodland", _combat_Dovetail_woodland]];
_optics_combat set ["Dovetail", _combat_Dovetail];

// Block: optics type: combat, mount type: FAL
private _combat_FAL_nocamo = ["hlc_optic_suit"];
private _combat_FAL_black = [];
private _combat_FAL_desert = [];
private _combat_FAL_woodland = [];

private _combat_FAL = createHashMapFromArray [["nocamo", _combat_FAL_nocamo], ["black", _combat_FAL_black], ["desert", _combat_FAL_desert], ["woodland", _combat_FAL_woodland]];
_optics_combat set ["FAL", _combat_FAL];

// Block: optics type: combat, mount type: G3
private _combat_G3_nocamo = ["hlc_optic_stanagzf_g3", "hlc_optic_accupoint_g3"];
private _combat_G3_black = [];
private _combat_G3_desert = [];
private _combat_G3_woodland = [];

private _combat_G3 = createHashMapFromArray [["nocamo", _combat_G3_nocamo], ["black", _combat_G3_black], ["desert", _combat_G3_desert], ["woodland", _combat_G3_woodland]];
_optics_combat set ["G3", _combat_G3];

// Block: optics type: combat, mount type: G4
private _combat_G4_nocamo = ["hlc_optic_zfsg1"];
private _combat_G4_black = [];
private _combat_G4_desert = [];
private _combat_G4_woodland = [];

private _combat_G4 = createHashMapFromArray [["nocamo", _combat_G4_nocamo], ["black", _combat_G4_black], ["desert", _combat_G4_desert], ["woodland", _combat_G4_woodland]];
_optics_combat set ["G4", _combat_G4];

// Block: optics type: combat, mount type: RIS
private _combat_RIS_nocamo = ["cup_optic_elcanm145", "cup_optic_rco"];
private _combat_RIS_black = [];
private _combat_RIS_desert = ["cup_optic_rco_desert"];
private _combat_RIS_woodland = ["cup_optic_acog_ta01nsn_od"];

private _combat_RIS = createHashMapFromArray [["nocamo", _combat_RIS_nocamo], ["black", _combat_RIS_black], ["desert", _combat_RIS_desert], ["woodland", _combat_RIS_woodland]];
_optics_combat set ["RIS", _combat_RIS];

// Block: optics type: combat, mount type: RPG7
private _combat_RPG7_nocamo = ["rhs_acc_pgo7v"];
private _combat_RPG7_black = [];
private _combat_RPG7_desert = [];
private _combat_RPG7_woodland = [];

private _combat_RPG7 = createHashMapFromArray [["nocamo", _combat_RPG7_nocamo], ["black", _combat_RPG7_black], ["desert", _combat_RPG7_desert], ["woodland", _combat_RPG7_woodland]];
_optics_combat set ["RPG7", _combat_RPG7];

_arsenal_optics set ["combat", _optics_combat];

private _optics_holo = createHashMap;

// Block: optics type: holo, mount type: Dovetail
private _holo_Dovetail_nocamo = ["rhs_acc_okp7_dovetail", "rhs_acc_ekp8_02", "rhs_acc_ekp1", "rhs_acc_1p63", "hlc_optic_kobra"];
private _holo_Dovetail_black = [];
private _holo_Dovetail_desert = [];
private _holo_Dovetail_woodland = [];

private _holo_Dovetail = createHashMapFromArray [["nocamo", _holo_Dovetail_nocamo], ["black", _holo_Dovetail_black], ["desert", _holo_Dovetail_desert], ["woodland", _holo_Dovetail_woodland]];
_optics_holo set ["Dovetail", _holo_Dovetail];

// Block: optics type: holo, mount type: RIS
private _holo_RIS_nocamo = ["rhs_acc_ekp8_18", "rhs_acc_okp7_picatinny", "cup_optic_aimpoint_5000", "cup_optic_compm4", "cup_optic_ac11704_black", "cup_optic_holoblack"];
private _holo_RIS_black = [];
private _holo_RIS_desert = ["cup_optic_ac11704_tan", "cup_optic_holodesert"];
private _holo_RIS_woodland = ["cup_optic_ac11704_od", "cup_optic_holowdl"];

private _holo_RIS = createHashMapFromArray [["nocamo", _holo_RIS_nocamo], ["black", _holo_RIS_black], ["desert", _holo_RIS_desert], ["woodland", _holo_RIS_woodland]];
_optics_holo set ["RIS", _holo_RIS];

_arsenal_optics set ["holo", _optics_holo];

private _optics_sniper = createHashMap;

// Block: optics type: sniper, mount type: Dovetail
private _sniper_Dovetail_nocamo = ["cup_optic_pso_3_open"];
private _sniper_Dovetail_black = [];
private _sniper_Dovetail_desert = [];
private _sniper_Dovetail_woodland = [];

private _sniper_Dovetail = createHashMapFromArray [["nocamo", _sniper_Dovetail_nocamo], ["black", _sniper_Dovetail_black], ["desert", _sniper_Dovetail_desert], ["woodland", _sniper_Dovetail_woodland]];
_optics_sniper set ["Dovetail", _sniper_Dovetail];

// Block: optics type: sniper, mount type: G3
private _sniper_G3_nocamo = ["hlc_optic_zf95_g3", "hlc_optic_leupoldm3a_g3"];
private _sniper_G3_black = [];
private _sniper_G3_desert = [];
private _sniper_G3_woodland = [];

private _sniper_G3 = createHashMapFromArray [["nocamo", _sniper_G3_nocamo], ["black", _sniper_G3_black], ["desert", _sniper_G3_desert], ["woodland", _sniper_G3_woodland]];
_optics_sniper set ["G3", _sniper_G3];

// Block: optics type: sniper, mount type: M14
private _sniper_M14_nocamo = ["hlc_optic_lrt_m14"];
private _sniper_M14_black = [];
private _sniper_M14_desert = [];
private _sniper_M14_woodland = [];

private _sniper_M14 = createHashMapFromArray [["nocamo", _sniper_M14_nocamo], ["black", _sniper_M14_black], ["desert", _sniper_M14_desert], ["woodland", _sniper_M14_woodland]];
_optics_sniper set ["M14", _sniper_M14];

// Block: optics type: sniper, mount type: M15
private _sniper_M15_nocamo = ["hlc_optic_artel_m14"];
private _sniper_M15_black = [];
private _sniper_M15_desert = [];
private _sniper_M15_woodland = [];

private _sniper_M15 = createHashMapFromArray [["nocamo", _sniper_M15_nocamo], ["black", _sniper_M15_black], ["desert", _sniper_M15_desert], ["woodland", _sniper_M15_woodland]];
_optics_sniper set ["M15", _sniper_M15];

// Block: optics type: sniper, mount type: RIS
private _sniper_RIS_nocamo = ["rhsusf_acc_m8541"];
private _sniper_RIS_black = [];
private _sniper_RIS_desert = ["rhsusf_acc_m8541_d"];
private _sniper_RIS_woodland = ["rhsusf_acc_m8541_wd"];

private _sniper_RIS = createHashMapFromArray [["nocamo", _sniper_RIS_nocamo], ["black", _sniper_RIS_black], ["desert", _sniper_RIS_desert], ["woodland", _sniper_RIS_woodland]];
_optics_sniper set ["RIS", _sniper_RIS];

_arsenal_optics set ["sniper", _optics_sniper];


_arsenal_optics