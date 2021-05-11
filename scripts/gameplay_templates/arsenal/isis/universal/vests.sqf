private _vests_hash = createHashMap;
private _vests_headgear = createHashMap;
private _vests_headgear_black = [
    ["LOP_H_SSh68Helmet_BLK", "black"],     36.2];

_vests_headgear set ["black", _vests_headgear_black];

private _vests_headgear_desert = [
    ["LOP_H_Shemag_TAN", "desert"],     13.5,
    ["PO_H_SSh68Helmet_Partizan_2", "desert"],     36.2,
    ["LOP_H_SSh68Helmet_TAN", "desert"],     36.2,
    ["rhsgref_hat_m1941cap", "desert"],     11.5,
    ["rhssaf_bandana_digital_desert", "desert"],     18,
    ["rhssaf_bandana_smb", "desert"],     18];

_vests_headgear set ["desert", _vests_headgear_desert];

private _vests_headgear_nocamo = [
    ["LOP_H_Turban_mask", "nocamo"],     45,
    ["LOP_H_Shemag_BLK", "nocamo"],     13.5,
    ["LOP_H_Shemag_GRE", "nocamo"],     13.5,
    ["LOP_H_Shemag_RED1", "nocamo"],     13.5];

_vests_headgear set ["nocamo", _vests_headgear_nocamo];

private _vests_headgear_woodland = [
    ["LOP_H_Shemag_OLV", "woodland"],     13.5,
    ["LOP_H_SSh68Helmet_ANA", "woodland"],     36.2,
    ["PO_H_SSh68Helmet_M81_1", "woodland"],     36.2,
    ["PO_H_SSh68Helmet_M81_2", "woodland"],     36.2,
    ["PO_H_SSh68Helmet_Partizan_1", "woodland"],     36.2,
    ["PO_H_SSh68Helmet_wz93", "woodland"],     36.2,
    ["rhsgref_helmet_M1_bare", "woodland"],     36.2,
    ["rhssaf_bandana_md2camo", "woodland"],     18];

_vests_headgear set ["woodland", _vests_headgear_woodland];

_vests_hash set ["headgear", _vests_headgear];

private _vests_heavy = createHashMap;
private _vests_heavy_black = [
    ["LOP_V_CarrierRig_BLK", "black"],     0.3457142857142857];

_vests_heavy set ["black", _vests_heavy_black];

private _vests_heavy_desert = [
    ["rhs_6b5_rifleman_khaki", "desert"],     0.3257631257631258,
    ["rhs_6b5_sniper_khaki", "desert"],     0.49285714285714294,
    ["LOP_V_CarrierRig_TRI", "desert"],     0.3457142857142857,
    ["LOP_V_CarrierRig_TAN", "desert"],     0.3457142857142857];

_vests_heavy set ["desert", _vests_heavy_desert];

private _vests_heavy_woodland = [
    ["rhs_6b5_rifleman", "woodland"],     0.3257631257631258,
    ["rhs_6b5_sniper", "woodland"],     0.49285714285714294,
    ["rhs_6b5_rifleman_ttsko", "woodland"],     0.3257631257631258,
    ["rhs_6b5_sniper_ttsko", "woodland"],     0.49285714285714294,
    ["LOP_V_CarrierRig_WDL", "woodland"],     0.3457142857142857,
    ["LOP_V_CarrierRig_OLV", "woodland"],     0.3457142857142857,
    ["LOP_V_CarrierRig_ANA", "woodland"],     0.3457142857142857];

_vests_heavy set ["woodland", _vests_heavy_woodland];

_vests_hash set ["heavy", _vests_heavy];

private _vests_normal = createHashMap;
private _vests_normal_black = [
    ["CUP_V_O_SLA_6B3_1_URB", "black"],     0.3991208791208792,
    ["CUP_V_O_SLA_6B3_3_URB", "black"],     0.3991208791208792,
    ["CUP_V_B_Interceptor_Base_Grey", "black"],     0.36342857142857143,
    ["CUP_V_B_Interceptor_Grenadier_Grey", "black"],     0.2595918367346939,
    ["CUP_V_B_Interceptor_Rifleman_Grey", "black"],     0.36342857142857143,
    ["LOP_V_Carrier_BLK", "black"],     1.2066666666666666,
    ["LOP_V_CarrierLite_BLK", "black"],     0.259047619047619];

_vests_normal set ["black", _vests_normal_black];

private _vests_normal_desert = [
    ["LOP_V_CarrierLite_TAN", "desert"],     0.259047619047619,
    ["CUP_V_O_SLA_6B3_1_DES", "desert"],     0.3991208791208792,
    ["CUP_V_O_SLA_6B3_3_DES", "desert"],     0.3991208791208792,
    ["CUP_V_CDF_6B3_1_DST", "desert"],     0.3991208791208792,
    ["CUP_V_B_Interceptor_Base_Coyote", "desert"],     0.36342857142857143,
    ["CUP_V_B_Interceptor_Grenadier_Coyote", "desert"],     0.2595918367346939,
    ["CUP_V_B_Interceptor_Rifleman_Coyote", "desert"],     0.36342857142857143,
    ["CUP_V_B_Interceptor_Base_DCU", "desert"],     0.36342857142857143,
    ["CUP_V_B_Interceptor_Grenadier_DCU", "desert"],     0.2595918367346939,
    ["CUP_V_B_Interceptor_Rifleman_DCU", "desert"],     0.36342857142857143,
    ["LOP_V_Carrier_TAN", "desert"],     1.2066666666666666,
    ["LOP_V_CarrierLite_TRI", "desert"],     0.259047619047619];

_vests_normal set ["desert", _vests_normal_desert];

private _vests_normal_woodland = [
    ["LOP_V_CarrierLite_OLV", "woodland"],     0.259047619047619,
    ["rhsgref_otv_khaki", "woodland"],     0.24461538461538465,
    ["LOP_V_Carrier_OLV", "woodland"],     1.2066666666666666,
    ["rhssaf_vest_otv_md2camo", "woodland"],     0.3057692307692308,
    ["CUP_V_O_SLA_6B3_1_WDL", "woodland"],     0.3991208791208792,
    ["CUP_V_RUS_6B3_1", "woodland"],     0.3991208791208792,
    ["CUP_V_O_SLA_6B3_3_WDL", "woodland"],     0.3991208791208792,
    ["CUP_V_CDF_6B3_1_MNT", "woodland"],     0.3991208791208792,
    ["CUP_V_B_Interceptor_Base_M81", "woodland"],     0.36342857142857143,
    ["CUP_V_B_Interceptor_Grenadier_M81", "woodland"],     0.2595918367346939,
    ["CUP_V_B_Interceptor_Rifleman_M81", "woodland"],     0.36342857142857143,
    ["CUP_V_B_Interceptor_Base_Olive", "woodland"],     0.36342857142857143,
    ["CUP_V_B_Interceptor_Grenadier_Olive", "woodland"],     0.2595918367346939,
    ["CUP_V_B_Interceptor_Rifleman", "woodland"],     0.36342857142857143,
    ["LOP_V_Carrier_WDL", "woodland"],     1.2066666666666666,
    ["LOP_V_Carrier_ANA", "woodland"],     1.2066666666666666,
    ["LOP_V_CarrierLite_LIZ", "woodland"],     0.259047619047619,
    ["LOP_V_CarrierLite_WDL", "woodland"],     0.259047619047619,
    ["LOP_V_CarrierLite_TURK", "woodland"],     0.259047619047619];

_vests_normal set ["woodland", _vests_normal_woodland];

_vests_hash set ["normal", _vests_normal];


_vests_hash

