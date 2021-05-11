private _GRLIB_ace_medical = false;
if (isClass (configfile >> "CfgPatches" >> "ace_medical")) then {
    _GRLIB_ace_medical = true;
    bis_reviveParam_mode = 0;
    publicVariable "bis_reviveParam_mode";
};

if (_GRLIB_ace_medical) then {
    ["ace_medical_limping", 1, 10, "server"] call CBA_settings_fnc_set;
    ["ace_medical_painCoefficient", 1, 10, "server"] call CBA_settings_fnc_set;
    ["ace_medical_treatment_woundReopenChance", 1, 10, "server"] call CBA_settings_fnc_set;
    ["ace_medical_treatment_clearTraumaAfterBandage", false, 10, "server"] call CBA_settings_fnc_set;
    ["ace_medical_treatment_allowSelfPAK", 0, 10, "server"] call CBA_settings_fnc_set;
    ["ace_medical_treatment_consumeSurgicalKit", 0, 10, "server"] call CBA_settings_fnc_set;
    ["ace_medical_treatment_locationEpinephrine", 0, 10, "server"] call CBA_settings_fnc_set;
    ["ace_medical_treatment_locationPAK", 0, 10, "server"] call CBA_settings_fnc_set;
    ["ace_medical_treatment_locationSurgicalKit", 0, 10, "server"] call CBA_settings_fnc_set;
    ["ace_medical_treatment_medicEpinephrine", 0, 10, "server"] call CBA_settings_fnc_set;
    switch (GRLIB_medlevel) do {
        case 1: {
            ["ace_medical_AIDamageThreshold", 1, 10, "server"] call CBA_settings_fnc_set;
            ["ace_medical_playerDamageThreshold", 2, 10, "server"] call CBA_settings_fnc_set;
            ["ace_medical_bleedingCoefficient",0.5, 10, "server"] call CBA_settings_fnc_set;
            ["ace_medical_fractures", 0, 10, "server"] call CBA_settings_fnc_set;
            ["ace_medical_spontaneousWakeUpChance", 0.75, 10, "server"] call CBA_settings_fnc_set;
            ["ace_medical_treatment_advancedBandages", 1, 10, "server"] call CBA_settings_fnc_set;
            ["ace_medical_treatment_advancedDiagnose", false, 10, "server"] call CBA_settings_fnc_set;
            ["ace_medical_treatment_advancedMedication", false, 10, "server"] call CBA_settings_fnc_set;
            ["ace_medical_treatment_cprSuccessChance", 0.9, 10, "server"] call CBA_settings_fnc_set;
            ["ace_medical_treatment_allowSelfIV", 1, 10, "server"] call CBA_settings_fnc_set;
            ["ace_medical_treatment_allowSelfStitch", 1, 10, "server"] call CBA_settings_fnc_set;
            ["ace_medical_treatment_medicIV", 0, 10, "server"] call CBA_settings_fnc_set;
            ["ace_medical_treatment_medicPAK", 0, 10, "server"] call CBA_settings_fnc_set;
            ["ace_medical_treatment_medicSurgicalKit", 0, 10, "server"] call CBA_settings_fnc_set;
        };
        case 2: {
            ["ace_medical_playerDamageThreshold", 1, 10, "server"] call CBA_settings_fnc_set;
            ["ace_medical_bleedingCoefficient", 1, 10, "server"] call CBA_settings_fnc_set;
            ["ace_medical_fractureChance", 0.33, 10, "server"] call CBA_settings_fnc_set;
            ["ace_medical_fractures", 1, 10, "server"] call CBA_settings_fnc_set;
            ["ace_medical_spontaneousWakeUpChance", 0.2, 10, "server"] call CBA_settings_fnc_set;
            ["ace_medical_treatment_advancedDiagnose", true, 10, "server"] call CBA_settings_fnc_set;
            ["ace_medical_treatment_advancedMedication", true, 10, "server"] call CBA_settings_fnc_set;
            ["ace_medical_treatment_advancedBandages", 2, 10, "server"] call CBA_settings_fnc_set;
            ["ace_medical_treatment_cprSuccessChance", 0.7, 10, "server"] call CBA_settings_fnc_set;
            ["ace_medical_treatment_medicIV", 1, 10, "server"] call CBA_settings_fnc_set;
            ["ace_medical_treatment_medicPAK", 0, 10, "server"] call CBA_settings_fnc_set;
            ["ace_medical_treatment_medicSurgicalKit", 1, 10, "server"] call CBA_settings_fnc_set;
            ["ace_medical_treatment_allowSelfIV", 0, 10, "server"] call CBA_settings_fnc_set;
            ["ace_medical_treatment_allowSelfStitch", 0, 10, "server"] call CBA_settings_fnc_set;

        };
    };
} else { // no ACE is detected
    switch (GRLIB_medlevel) do {
        bis_reviveParam_mode = 1;                           //0: disabled, 1: enabled, 2: controlled by player attributes
        bis_reviveParam_duration = 16;                  //time needed to revive someone (in secs)
        case 1: {
            bis_reviveParam_unconsciousStateMode = 0;   //0: basic, 1: advanced, 2: realistic
            bis_reviveParam_requiredTrait = 0;          //0: none, 1: medic trait is required
            bis_reviveParam_requiredItems = 2;          //0: none, 1: medkit, 2: medkit or first aid kit
            bis_reviveParam_medicSpeedMultiplier = 2;   //speed multiplier for revive performed by medic
            bis_reviveParam_forceRespawnDuration = 3;   //time needed to perform force respawn (in secs)
            bis_reviveParam_bleedOutDuration = 240;     //unconscious state duration (in secs)
        };
        case 2: {
            bis_reviveParam_unconsciousStateMode = 1;   //1: advanced
            bis_reviveParam_requiredTrait = 1;          //1: medic trait is required
            bis_reviveParam_requiredItems = 1;          //1: medkit
            bis_reviveParam_medicSpeedMultiplier = 2;
            bis_reviveParam_forceRespawnDuration = 3;
            bis_reviveParam_bleedOutDuration = 240;
        };
    };
    [] call bis_fnc_reviveInit;
};
