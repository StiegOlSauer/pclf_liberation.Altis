params [["_multiplier", 1]];
private ["_class", "_optics_type"];
    // Array of probabilities for weapons of different classes
private _wpn_probs = [
        0.1,    //aa
        0.3,    //lat
        0.2,    //hat
        2,      //rifle
        0.5,    //riflegl
        2,      //carbine
        0.5,    //carbinegl
        1,      //lmg
        0.5,    //mg
        2,      //pistol
        1,      //smg
        0.5,    //marksman
        0.1     //sniper
    ];

    private _vest_probs = [
        0.5,    //heavy
        1.5     //normal
    ];

    for "_i" from 1 to (GRLIB_arsenal_wpn_unlocks_per_box * _multiplier) do {
        _class = GRLIB_weapon_classes selectRandomWeighted _wpn_probs;
        _optics_type = ["any", "sniper"] select (_class == "sniper");
        [_class, "", _optics_type] call PCLF_unlockWeapon;
    };

    for "_i" from 1 to (GRLIB_arsenal_vest_unlocks_per_box * _multiplier) do {
        ["any", "any"] call PCLF_unlockVest;
};
