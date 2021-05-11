if (!isServer) exitWith {};

params [ "_object_recycled", "_price" ];

if ( isNull _object_recycled ) exitWith {};
if ( !(alive _object_recycled) ) exitWith {};

choose_from_arrays = {
    params ["_inputArrays", "_chance"];
    private _arrayTrue = _inputArrays select 0;
    private _arrayFalse = _inputArrays select 1;

    private _item;
    if (floor random 100 >= _chance) then {
        _item = _arrayTrue deleteAt 0;
    } else {
        _item = _arrayFalse deleteAt 0;
    };

    _item
};

// name of arsenal variable, weight (to balance output from arrays of different len)
private _weap_arrays = [
    GRLIB_arsenal_rifles,       3,
    GRLIB_arsenal_carbines,     3,
    GRLIB_arsenal_smgs,         2,
    GRLIB_arsenal_precision,    1,
    GRLIB_arsenal_pistols,      1,
    GRLIB_arsenal_LMG,          2,
    GRLIB_arsenal_MG,           2,
    GRLIB_arsenal_AT,           1,
    GRLIB_arsenal_AA,           1
];

if ((typeOf _object_recycled) == ammocrate_o_typename) then {
    private _new_wpns = [];
    private ["_selected_arr", "_wpn"];

    while {count _new_wpns < GRLIB_items_per_box} do {
        _selected_arr = selectRandomWeighted _weap_arrays;
        _wpn = selectRandomWeighted _selected_arr;
        _new_wpns pushBack (_wpn select 0);
        _selected_arr deleteRange [_selected_arr find _wpn, 2];

        // based on magazine type and color: add magazine for selected weapon
        private _wpn_mag = [_wpn select 1, wpn select 3, true] call PCLF_getMagazine;

        // based on rail type and color: add optics piece for selected weapon
        private _wpn_mag = [_wpn select 1, wpn select 3, true] call PCLF_getOptics;

        // add 5 random muzzle devices and 5 front rail modules
    };

    while {count _new_wpns < _min_magazines} do {
        // if magazine list is empty (or <3), add random magazine from random category (from the list provided by arsenal preset)
    };

    while {count _new_wpns < _min_optics} do {
        // if optics list is empty (or <3), add random optics from random category
    };

    // TODO: vests!
};

// if ((typeOf _object_recycled) == ammocrate_o_typename) then {
// 	for [{_i=0}, {_i<GRLIB_guns_per_box}, {_i=_i+1}] do {
// 		_wpn = GRLIB_allowed_weapons deleteAt _i;
// 		GRLIB_whitelisted_from_arsenal pushBack _wpn;
// 	};
// };
// publicVariable "GRLIB_whitelisted_from_arsenal";

[ missionNamespace, _new_wpns, true ] call BIS_fnc_addVirtualWeaponCargo;

deleteVehicle _object_recycled;
if ( _price > 0 ) then {
	resources_ammo = resources_ammo + _price;
};
please_recalculate = true;
stats_vehicles_recycled = stats_vehicles_recycled + 1;
