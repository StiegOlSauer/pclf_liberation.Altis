if (!isServer) exitWith {};

params [ "_object_recycled", "_price" ];

if ( isNull _object_recycled ) exitWith {};
if ( !(alive _object_recycled) ) exitWith {};

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

if ((typeOf _object_recycled) == ammocrate_o_typename && _price == 0) then {
    private ["_class", "_optics_type"];

    for "_i" from 1 to GRLIB_arsenal_wpn_unlocks_per_box do {
        _class = GRLIB_weapon_classes selectRandomWeighted _wpn_probs;
        _optics_type = ["any", "sniper"] select (_class == "sniper");
        [_class, "", _optics_type] call PCLF_unlockWeapon;
    };

    for "_i" from 1 to GRLIB_arsenal_vest_unlocks_per_box do {
        ["any", "any"] call PCLF_unlockVest;
    };
};

// if ((typeOf _object_recycled) == ammocrate_o_typename) then {
// 	for [{_i=0}, {_i<GRLIB_guns_per_box}, {_i=_i+1}] do {
// 		_wpn = GRLIB_allowed_weapons deleteAt _i;
// 		GRLIB_whitelisted_from_arsenal pushBack _wpn;
// 	};
// };
// publicVariable "GRLIB_whitelisted_from_arsenal";

deleteVehicle _object_recycled;
if ( _price > 0 ) then {
	resources_ammo = resources_ammo + _price;
};
please_recalculate = true;
stats_vehicles_recycled = stats_vehicles_recycled + 1;
