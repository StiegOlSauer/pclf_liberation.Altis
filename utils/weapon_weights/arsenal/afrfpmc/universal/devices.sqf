private _devs_hash = createHashMap;
private _devs_black = createHashMap;
private _devs_black_muzzle = [
    "rhs_acc_ak5",     12.5,
    "cup_muzzle_snds_kzrzp_ak545",     6.25,
    "rhs_acc_tgpa",     6.25,
    "cup_muzzle_snds_kzrzp_ak762",     6.25];

_devs_black set ["muzzle", _devs_black_muzzle];

_devs_hash set ["black", _devs_black];
private _devs_desert = createHashMap;
private _devs_desert_muzzle = [
    "cup_muzzle_mfsup_flashhider_545x39_tan",     12.5,
    "cup_muzzle_snds_kzrzp_ak545_desert",     6.25,
    "cup_muzzle_tgpa_desert",     6.25,
    "cup_muzzle_mfsup_flashhider_762x39_tan",     12.5,
    "cup_muzzle_snds_kzrzp_ak762_desert",     6.25,
    "cup_muzzle_mfsup_flashhider_pk_tan",     12.5,
    "cup_muzzle_snds_kzrzp_pk_desert",     6.25,
    "rhsusf_acc_rotex5_tan",     6.25,
    "cup_muzzle_snds_m16_desert",     6.25,
    "muzzle_snds_b_arid_f",     6.25,
    "cup_muzzle_mfsup_flashhider_762x51_tan",     12.5];

_devs_desert set ["muzzle", _devs_desert_muzzle];

private _devs_desert_rail = [
    "cup_bipod_vltor_modpod",     12.5,
    "bipod_01_f_snd",     12.5,
    "rhsusf_acc_grip2_tan",     25,
    "rhsusf_acc_rvg_de",     25,
    "rhsusf_acc_grip3_tan",     25,
    "cup_acc_anpeq_15",     6.25,
    "cup_acc_anpeq_15_flashlight_tan_l",     6.25];

_devs_desert set ["rail", _devs_desert_rail];

_devs_hash set ["desert", _devs_desert];
private _devs_nocamo = createHashMap;
private _devs_nocamo_muzzle = [
    "hlc_muzzle_545sup_ak",     6.25,
    "hlc_muzzle_snds_arsenalcomp",     12.5,
    "hlc_muzzle_sf3p_762r",     12.5,
    "rhs_acc_uuk",     12.5,
    "rhs_acc_dtk1983",     12.5,
    "rhs_acc_dtk1",     12.5,
    "rhs_acc_dtk2",     12.5,
    "rhs_acc_dtk3",     12.5,
    "rhs_acc_dtk4short",     6.25,
    "rhs_acc_pgs64",     12.5,
    "rhs_acc_pbs1",     6.25,
    "rhs_acc_dtk4screws",     6.25,
    "rhs_acc_tgpv",     6.25,
    "rhs_acc_dtkakm",     12.5,
    "rhs_acc_dtk1l",     12.5,
    "cup_muzzle_mfsup_flashhider_pk_black",     12.5,
    "cup_muzzle_snds_kzrzp_pk",     6.25,
    "cup_muzzle_snds_groza",     6.25,
    "cup_muzzle_snds_sr3m",     6.25,
    "hlc_muzzle_sf3p_556",     12.5,
    "rhsusf_acc_rotex5_grey",     6.25,
    "hlc_muzzle_gunfighter_comp",     12.5,
    "cup_muzzle_snds_m16",     6.25,
    "hlc_muzzle_556nato_kac",     6.25,
    "muzzle_snds_b",     6.25,
    "hlc_muzzle_300blk_kac",     6.25,
    "cup_muzzle_mfsup_flashhider_762x51_black",     12.5,
    "hlc_muzzle_mag58_brake",     12.5,
    "hlc_muzzle_agendasix10mm",     6.25,
    "muzzle_snds_l",     6.25];

_devs_nocamo set ["muzzle", _devs_nocamo_muzzle];

private _devs_nocamo_rail = [
    "rhsusf_acc_harris_bipod",     12.5,
    "rhsusf_acc_grip1",     8.333333333333334,
    "hlc_bipod_utgshooters",     12.5,
    "cup_bipod_vltor_modpod_black",     12.5,
    "bipod_01_f_blk",     12.5,
    "rhs_acc_grip_ffg2",     25,
    "rhs_acc_grip_rk6",     25,
    "rhsusf_acc_grip2",     25,
    "rhsusf_acc_kac_grip",     25,
    "rhsusf_acc_rvg_blk",     25,
    "rhsusf_acc_grip3",     25,
    "ace_acc_pointer_red",     3.125,
    "ace_acc_pointer_green",     3.125,
    "cup_acc_anpeq_15_black",     6.25,
    "cup_acc_anpeq_15_flashlight_black_l",     6.25,
    "rhsusf_acc_m952v",     100,
    "rhs_acc_2dpzenit_ris",     100,
    "rhs_acc_perst1ik_ris",     6.25,
    "rhs_acc_perst3",     6.25];

_devs_nocamo set ["rail", _devs_nocamo_rail];

_devs_hash set ["nocamo", _devs_nocamo];
private _devs_woodland = createHashMap;
private _devs_woodland_muzzle = [
    "cup_muzzle_mfsup_flashhider_545x39_od",     12.5,
    "cup_muzzle_snds_kzrzp_ak545_woodland",     6.25,
    "cup_muzzle_tgpa_woodland",     6.25,
    "cup_muzzle_mfsup_flashhider_762x39_od",     12.5,
    "cup_muzzle_snds_kzrzp_ak762_woodland",     6.25,
    "cup_muzzle_mfsup_flashhider_pk_od",     12.5,
    "cup_muzzle_snds_kzrzp_pk_woodland",     6.25,
    "cup_muzzle_snds_m16_camo",     6.25,
    "rhsgref_sdn6_suppressor",     6.25,
    "cup_muzzle_mfsup_flashhider_762x51_od",     12.5];

_devs_woodland set ["muzzle", _devs_woodland_muzzle];

private _devs_woodland_rail = [
    "cup_bipod_vltor_modpod_od",     12.5,
    "bipod_01_f_mtp",     12.5,
    "rhsusf_acc_grip2_wd",     25,
    "cup_acc_anpeq_15_od",     6.25,
    "cup_acc_anpeq_15_flashlight_od_l",     6.25];

_devs_woodland set ["rail", _devs_woodland_rail];

_devs_hash set ["woodland", _devs_woodland];

_devs_hash

