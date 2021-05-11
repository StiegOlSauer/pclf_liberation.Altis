private _arsenal_optics = createHashMap;
private _optics_combat = createHashMap;

// Block: optics type: combat, mount type: Dovetail
private _combat_Dovetail_nocamo = ["rhs_acc_pso1m2", "rhs_acc_pso1m21", "rhs_acc_1p78", "rhs_acc_1p29"];
private _combat_Dovetail_black = [];
private _combat_Dovetail_desert = [];
private _combat_Dovetail_woodland = [];

private _combat_Dovetail = createHashMapFromArray [["nocamo", _combat_Dovetail_nocamo], ["black", _combat_Dovetail_black], ["desert", _combat_Dovetail_desert], ["woodland", _combat_Dovetail_woodland]];
_optics_combat set ["Dovetail", _combat_Dovetail];

// Block: optics type: combat, mount type: RIS
private _combat_RIS_nocamo = ["rhsusf_acc_g33_t1", "rhsusf_acc_g33_xps3", "rhsusf_acc_elcan", "rhsusf_acc_acog3", "rhsusf_acc_su230", "rhsusf_acc_su230_mrds", "hlc_optic_atacr"];
private _combat_RIS_black = ["rhsusf_acc_acog_rmr", "cup_optic_acog_ta01b_rmr_black", "cup_optic_aimm_m68_blk"];
private _combat_RIS_desert = ["rhsusf_acc_g33_xps3_tan", "rhsusf_acc_acog_d", "rhsusf_acc_su230_c", "rhsusf_acc_su230_mrds_c", "cup_optic_acog_ta01b_rmr_coyote", "cup_optic_aimm_m68_tan"];
private _combat_RIS_woodland = ["rhsusf_acc_acog_wd", "cup_optic_acog_ta01b_rmr_od", "cup_optic_aimm_m68_od"];

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
private _holo_Dovetail_nocamo = ["rhs_acc_pkas", "rhs_acc_okp7_dovetail", "rhs_acc_ekp8_02", "rhs_acc_ekp1", "rhs_acc_1p63", "hlc_optic_kobra"];
private _holo_Dovetail_black = [];
private _holo_Dovetail_desert = [];
private _holo_Dovetail_woodland = [];

private _holo_Dovetail = createHashMapFromArray [["nocamo", _holo_Dovetail_nocamo], ["black", _holo_Dovetail_black], ["desert", _holo_Dovetail_desert], ["woodland", _holo_Dovetail_woodland]];
_optics_holo set ["Dovetail", _holo_Dovetail];

// Block: optics type: holo, mount type: RIS
private _holo_RIS_nocamo = ["rhs_acc_rakurspm", "rhs_acc_ekp8_18", "rhs_acc_okp7_picatinny", "rhsusf_acc_eotech_xps3", "rhsusf_acc_compm4", "rhsusf_acc_mrds", "hlc_optic_docterr"];
private _holo_RIS_black = ["rhs_acc_1p87", "rhsusf_acc_rx01_nofilter", "rhsusf_acc_eotech_552", "cup_optic_zeisszpoint", "cup_optic_vortexrazor_uh1_black", "cup_optic_compm2_black", "cup_optic_eotech553_black", "cup_optic_microt1"];
private _holo_RIS_desert = ["rhsusf_acc_rx01_nofilter_tan", "rhsusf_acc_eotech", "rhsusf_acc_eotech_552_d", "rhsusf_acc_mrds_c", "cup_optic_zeisszpoint_desert", "cup_optic_vortexrazor_uh1_tan", "cup_optic_compm2_desert", "cup_optic_eotech553_coyote", "cup_optic_1p87_ris_desert", "cup_optic_microt1_coyote"];
private _holo_RIS_woodland = ["rhsgref_acc_rx01_nofilter_camo", "rhsusf_acc_eotech_552_wd", "cup_optic_zeisszpoint_wood", "cup_optic_vortexrazor_uh1_od", "cup_optic_compm2_od", "cup_optic_eotech553_od", "cup_optic_1p87_ris_woodland", "cup_optic_microt1_od"];

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

// Block: optics type: sniper, mount type: RIS
private _sniper_RIS_nocamo = ["rhs_acc_dh520x56", "rhsusf_acc_leupoldmk4_2_mrds", "cup_optic_leupold_vx3"];
private _sniper_RIS_black = ["rhsusf_acc_m8541"];
private _sniper_RIS_desert = ["rhsusf_acc_m8541_d", "rhsusf_acc_leupoldmk4_2_d"];
private _sniper_RIS_woodland = ["rhsusf_acc_m8541_wd"];

private _sniper_RIS = createHashMapFromArray [["nocamo", _sniper_RIS_nocamo], ["black", _sniper_RIS_black], ["desert", _sniper_RIS_desert], ["woodland", _sniper_RIS_woodland]];
_optics_sniper set ["RIS", _sniper_RIS];

_arsenal_optics set ["sniper", _optics_sniper];


_arsenal_optics