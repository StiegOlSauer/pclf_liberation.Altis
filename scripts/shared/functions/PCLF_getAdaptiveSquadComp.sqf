params ["_squad_type", "_is_specops"];
private ["_tier", "_base_class", "_squad_comp"];

/*
 * Prepare list of squad roles for spawning
 *
 * By default checks inf/air/armor pressure on OPFOR and chooses proper composition
 * Params:
 * _squad_type - spawn specific squad instead of regular. Overrides default behavior.
 * Possible values:
 *   "patrol" - small-sized squad with lighter armament
 *   "guard" - heavily armed team for occupying military towers
 *   "ambush" - squad will consist of specops troops
 *   "crew" - vehicle crews
 *
 * _is_specops - replaces regular soldiers with their specops counterparts
 */

// Define OPFOR tier for spawning
_squad_comp = [];
_tier = GRLIB_opfor_low_squad_comp;
_base_class = GRLIB_opfor_low_base_soldier_class;
if (combat_readiness >= GRLIB_uptier_readiness) then {
    _tier = GRLIB_opfor_hi_squad_comp;
    _base_class = GRLIB_opfor_hi_base_soldier_class;
};

if (count _squad_type == 0 || _squad_type == "regular") then {
    _tier = _tier get "regular";
    _squad_comp = selectRandomWeighted (_tier selectRandomWeighted [GRLIB_infantry_weight, GRLIB_armor_weight, GRLIB_air_weight]);
} else {
    _squad_comp = _tier get _squad_type;
};

if (count _squad_comp == 0) then {
    ["Unable to compose squad of type: %1", _squad_type] call BIS_fnc_error;
};

[_base_class, _squad_comp]
