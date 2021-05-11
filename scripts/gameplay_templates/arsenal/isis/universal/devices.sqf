private _devs_hash = createHashMap;
private _devs_black = createHashMap;
private _devs_black_muzzle = [
    "rhs_acc_tgpa",     6.25,
    "rhs_acc_ak5",     12.5];

_devs_black set ["muzzle", _devs_black_muzzle];

private _devs_black_rail = [
    "cup_acc_anpeq_2_grey",     6.25];

_devs_black set ["rail", _devs_black_rail];

_devs_hash set ["black", _devs_black];
private _devs_desert = createHashMap;
private _devs_desert_muzzle = [
    "cup_muzzle_mfsup_flashhider_545x39_tan",     12.5,
    "cup_muzzle_tgpa_desert",     6.25,
    "cup_muzzle_snds_m16_desert",     6.25];

_devs_desert set ["muzzle", _devs_desert_muzzle];

private _devs_desert_rail = [
    "rhsusf_acc_grip2_tan",     25,
    "bipod_02_f_tan",     12.5,
    "cup_bipod_vltor_modpod",     12.5,
    "cup_acc_anpeq_2_desert",     6.25,
    "cup_acc_llm01_desert_l",     6.25];

_devs_desert set ["rail", _devs_desert_rail];

_devs_hash set ["desert", _devs_desert];
private _devs_nocamo = createHashMap;
private _devs_nocamo_muzzle = [
    "hlc_muzzle_545sup_ak",     6.25,
    "rhs_acc_dtk1983",     12.5,
    "rhs_acc_pgs64",     12.5,
    "rhs_acc_pbs1",     6.25,
    "rhs_acc_tgpv",     6.25,
    "rhs_acc_dtkakm",     12.5,
    "cup_muzzle_snds_m16",     6.25,
    "hlc_muzzle_mag58_brake",     12.5,
    "hlc_muzzle_gunfighter_comp",     12.5];

_devs_nocamo set ["muzzle", _devs_nocamo_muzzle];

private _devs_nocamo_rail = [
    "rhsusf_acc_grip2",     25,
    "rhs_acc_grip_ffg2",     25,
    "bipod_02_f_blk",     12.5,
    "cup_bipod_vltor_modpod_black",     12.5,
    "acc_flashlight",     100,
    "cup_acc_llm01_l",     6.25];

_devs_nocamo set ["rail", _devs_nocamo_rail];

_devs_hash set ["nocamo", _devs_nocamo];
private _devs_woodland = createHashMap;
private _devs_woodland_muzzle = [
    "cup_muzzle_mfsup_flashhider_545x39_od",     12.5,
    "cup_muzzle_tgpa_woodland",     6.25,
    "cup_muzzle_snds_m16_camo",     6.25];

_devs_woodland set ["muzzle", _devs_woodland_muzzle];

private _devs_woodland_rail = [
    "rhsusf_acc_grip2_wd",     25,
    "bipod_02_f_hex",     12.5,
    "cup_bipod_vltor_modpod_od",     12.5,
    "cup_acc_anpeq_2_camo",     6.25,
    "cup_acc_llm01_od_l",     6.25];

_devs_woodland set ["rail", _devs_woodland_rail];

_devs_hash set ["woodland", _devs_woodland];

_devs_hash

