params ["_vestType", "_camo"];

/*
 * Unlock vest
 * Adds one piece of uniform, vest and headgear to virtual arsenal.
 * Tries to match camo of unlocked items.
 * Params:
 * _vestType - normal or heavy
 * _camo - "any" or valid camo type
*/
private _uniform = "";
private _vest = "";
private _headgear = "";

if (not (_camo in GRLIB_eligible_weapon_camo)) then {
    _camo = "any";
};

if (not (_vestType in ["normal", "heavy"])) then {
    _vestType = selectRandom ["normal", "heavy"];
};

_vest = [_vestType, _camo, GRLIB_arsenal_blufor get "vests", true] call PCLF_getVest;

_camo = _vest select 1;
_uniform = [_camo, GRLIB_arsenal_blufor get "uniforms", true] call PCLF_getUniform;
_headgear = ["headgear", _camo, GRLIB_arsenal_blufor get "vests", true] call PCLF_getVest;

private _itemsToAdd = [];
[_uniform, (_vest select 0), (_headgear select 0)] apply {if (count _x > 0) then {_itemsToAdd pushBack _x}};
[ missionNamespace, _itemsToAdd, true ] call BIS_fnc_addVirtualItemCargo;

_vestType = _vest select 2;
(((GRLIB_arsenal_unlocks get "vests") get _vestType) getOrDefault [_camo, [], true]) pushBack _vest;
(((GRLIB_arsenal_unlocks get "vests") get _vestType) get _camo) pushBack (random 100);

(((GRLIB_arsenal_unlocks get "vests") get "headgear") getOrDefault [_camo, [], true]) pushBack _headgear;
(((GRLIB_arsenal_unlocks get "vests") get "headgear") get _camo) pushBack (random 100);

((GRLIB_arsenal_unlocks get "uniforms") getOrDefault [_camo, [], true]) pushBack _uniform;
