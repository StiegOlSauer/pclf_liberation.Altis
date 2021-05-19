params ["_vestType", "_camo", "_config", "_evict"];

/*
 * Vests:
 * Type (normal, heavy, headgear) 1:N Camoflage (nocamo, desert, etc) 1:N Vest items
 *
*/
private _vest = "";

if (_camo == "any") then {
    _camo = selectRandom GRLIB_eligible_weapon_camo;
};

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
