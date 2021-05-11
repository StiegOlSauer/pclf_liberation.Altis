params ["_vestType", "_camo", "_config", "_evict"];

/*
 * Vests:
 * Type (normal, heavy, headgear) 1:N Camoflage (nocamo, desert, etc) 1:N Vest items
 *
*/
private _vest = "";
// private _config = GRLIB_arsenal_blufor get "vests";
//
// if (_side == GRLIB_side_enemy) then {
//     _config = GRLIB_arsenal_opfor_low get "vests";
// };

if (_camo == "any") then {
    _camo = selectRandom GRLIB_eligible_weapon_camo;
};

// private _vestsOfTypeX = _config get _vestType;
// private _vestsOfColorX = _vestsOfTypeX get _camo;
// if (count _vestsOfColorX > 0) then {
//     _vest = selectRandomWeighted _vestsOfColorX;
//     if (_evict) then {
//         _vestsOfColorX deleteAt (_vestsOfColorX find _vest);
//         _vestsOfTypeX set [_camo, _vestsOfColorX];
//         _config set [_vestType, _vestsOfTypeX];
//     };
// } else {
//     {
//         if (count _vest > 0) exitWith {_vest};
//         _vest = [_y, _evict, true] call PCLF_fnc_searchAndDelete;
//     } forEach _vestsOfTypeX;
// };

scopeName "main";
{
    private _vestsOfTypeX = _config getOrDefault [_x, []];
    if (count _vestsOfTypeX == 0) then {continue};
    {
        private _vestsOfColorX = _vestsOfTypeX getOrDefault [_x, []];
        _vest = [_vestsOfColorX, _evict, true] call PCLF_fnc_searchAndDelete;
        if (count _vest > 0) then { breakTo "main" };
    } forEach ([_camo] + ((GRLIB_eligible_weapon_camo - [_camo]) call BIS_fnc_arrayShuffle));
} forEach ([_vestType] + ((["normal", "heavy"] - [_vestType]) call BIS_fnc_arrayShuffle));

_vest
