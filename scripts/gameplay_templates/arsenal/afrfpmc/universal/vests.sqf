private _vests_hash = createHashMap;
private _vests_headgear = createHashMap;
private _vests_headgear_black = [
    ["CUP_H_RUS_Altyn_Shield_Down_black", "black"],     11.382857142857143];

_vests_headgear set ["black", _vests_headgear_black];

private _vests_headgear_desert = [
    ["rhs_fieldcap_ml", "desert"],     11.5,
    ["rhs_6b27m_ml_ess", "desert"],     28.96,
    ["rhs_6b27m_ML_ess_bala", "desert"],     28.96,
    ["LOP_H_Booniehat_RACS", "desert"],     22.5,
    ["LOP_H_Beanie_tan", "desert"],     11.5,
    ["LOP_H_6B27M_ess_RACS", "desert"],     28.96,
    ["CUP_H_RUS_6B47_goggles_desert", "desert"],     16,
    ["CUP_H_RUS_6B47_v2_GogglesClosed_BeigeDigital", "desert"],     16];

_vests_headgear set ["desert", _vests_headgear_desert];

private _vests_headgear_nocamo = [
    ["rhs_tsh4_bala", "nocamo"],     13.5,
    ["rhs_fieldcap_digi2", "nocamo"],     11.5,
    ["rhs_Booniehat_flora", "nocamo"],     22.5,
    ["rhs_beanie_green", "nocamo"],     11.5,
    ["CUP_H_RUS_Balaclava_Ratnik_Headphones", "nocamo"],     22.5,
    ["rhs_6b26_ess_green", "nocamo"],     40,
    ["rhs_6b26_ess_bala_green", "nocamo"],     40];

_vests_headgear set ["nocamo", _vests_headgear_nocamo];

private _vests_headgear_woodland = [
    ["rhs_fieldcap_vsr", "woodland"],     11.5,
    ["rhs_Booniehat_digi", "woodland"],     22.5,
    ["rhs_altyn_novisor_ess", "woodland"],     28.96,
    ["rhs_altyn_novisor_bala", "woodland"],     28.96,
    ["rhs_6b27m_green_ess", "woodland"],     28.96,
    ["rhs_6b27m_green_ess_bala", "woodland"],     28.96,
    ["rhs_6b26_ess", "woodland"],     28.96,
    ["rhs_6b26_ess_bala", "woodland"],     28.96,
    ["rhs_6b27m_ess", "woodland"],     28.96,
    ["rhs_6b27m_ess_bala", "woodland"],     28.96,
    ["rhs_6b47", "woodland"],     28.96,
    ["rhs_6b47_bala", "woodland"],     28.96,
    ["rhs_6b7_1m_olive", "woodland"],     28.96,
    ["rhs_6b7_1m_bala2_olive", "woodland"],     28.96,
    ["CUP_H_RUS_Altyn_Shield_Down_khaki", "woodland"],     11.382857142857143];

_vests_headgear set ["woodland", _vests_headgear_woodland];

_vests_hash set ["headgear", _vests_headgear];

private _vests_heavy = createHashMap;
private _vests_heavy_black = [
    ["CUP_V_PMC_CIRAS_Black_Grenadier", "black"],     0.3457142857142857,
    ["CUP_V_CZ_NPP2006_nk_black", "black"],     0.13284493284493284];

_vests_heavy set ["black", _vests_heavy_black];

private _vests_heavy_desert = [
    ["rhs_6b23_ML_6sh92_vog_headset", "desert"],     0.20336134453781513,
    ["rhs_6b23_ML_vydra_3m", "desert"],     0.2833333333333334,
    ["CUP_V_PMC_CIRAS_Coyote_Grenadier", "desert"],     0.3457142857142857,
    ["CUP_V_CZ_NPP2006_nk_des", "desert"],     0.13284493284493284,
    ["CUP_V_RUS_6B45_1_BeigeDigital", "desert"],     0.42100122100122095,
    ["CUP_V_RUS_6B45_2_BeigeDigital", "desert"],     0.4649572649572649];

_vests_heavy set ["desert", _vests_heavy_desert];

private _vests_heavy_nocamo = [
    ["rhs_6b23_rifleman", "nocamo"],     40];

_vests_heavy set ["nocamo", _vests_heavy_nocamo];

private _vests_heavy_woodland = [
    ["rhs_6b23_vydra_3m", "woodland"],     0.2833333333333334,
    ["rhs_6b23_6sh116_flora", "woodland"],     0.17430972388955582,
    ["rhs_6b23_6sh116_vog_flora", "woodland"],     0.16218487394957984,
    ["rhs_6b23_6sh116", "woodland"],     0.17430972388955582,
    ["rhs_6b23_6sh116_vog", "woodland"],     0.16218487394957984,
    ["rhs_6b23_digi_6sh92_vog", "woodland"],     0.20336134453781513,
    ["rhs_6b23_digi_6sh92_Vog_Spetsnaz", "woodland"],     0.20336134453781513,
    ["rhs_6b23_6sh116_od", "woodland"],     0.17430972388955582,
    ["rhs_6b23_6sh116_vog_od", "woodland"],     0.16218487394957984,
    ["rhs_6b13_EMR_6sh92", "woodland"],     0.2155,
    ["rhs_6b13_EMR_6sh92_vog", "woodland"],     0.18916666666666665,
    ["rhs_6b13_crewofficer", "woodland"],     0.4825,
    ["rhs_6b13_6sh92", "woodland"],     0.2155,
    ["rhs_6b13_6sh92_vog", "woodland"],     0.18916666666666665,
    ["CUP_V_PMC_CIRAS_OD_Grenadier", "woodland"],     0.3457142857142857,
    ["CUP_V_CZ_NPP2006_nk_vz95", "woodland"],     0.13284493284493284,
    ["CUP_V_RUS_6B45_1", "woodland"],     0.42100122100122095,
    ["CUP_V_RUS_6B45_2", "woodland"],     0.4649572649572649];

_vests_heavy set ["woodland", _vests_heavy_woodland];

_vests_hash set ["heavy", _vests_heavy];

private _vests_normal = createHashMap;
private _vests_normal_black = [
    ["CUP_V_PMC_CIRAS_Black_Empty", "black"],     0.6057142857142858];

_vests_normal set ["black", _vests_normal_black];

private _vests_normal_desert = [
    ["rhs_6b23_ML_6sh92_headset", "desert"],     0.2285714285714286,
    ["rhs_6b23_ML_crew", "desert"],     0.2944444444444445,
    ["rhs_6b23_ML_medic", "desert"],     0.23269230769230773,
    ["LOP_V_6B23_6Sh92_TAN_DMPi", "desert"],     0.2285714285714286,
    ["LOP_V_6B23_Medic_TAN", "desert"],     0.23269230769230773,
    ["LOP_V_6B23_6Sh92_TAN_ACU", "desert"],     0.2285714285714286,
    ["CUP_V_B_PASGT_desert", "desert"],     0.49800000000000005,
    ["CUP_V_PMC_CIRAS_Coyote_Empty", "desert"],     0.6057142857142858];

_vests_normal set ["desert", _vests_normal_desert];

private _vests_normal_woodland = [
    ["rhs_6b43", "woodland"],     0.9,
    ["rhs_6b23_digi_6sh92_headset", "woodland"],     0.2285714285714286,
    ["rhs_6b23_digi_6sh92_headset_spetsnaz", "woodland"],     0.2285714285714286,
    ["rhs_6b23_digi_crew", "woodland"],     0.2944444444444445,
    ["rhs_6b23_digi_medic", "woodland"],     0.23269230769230773,
    ["CUP_V_B_PASGT_OD", "woodland"],     0.49800000000000005,
    ["CUP_V_PMC_CIRAS_OD_Empty", "woodland"],     0.6057142857142858];

_vests_normal set ["woodland", _vests_normal_woodland];

_vests_hash set ["normal", _vests_normal];


_vests_hash

