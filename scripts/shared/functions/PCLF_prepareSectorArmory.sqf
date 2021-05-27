private ["_sectorLoadoutHash"];

private _setupTier = {
    params ["_cfg", "_coolness_shift"];
    private ["_wpn", "_camo", "_vestHvy", "_vestLight", "_headgear", "_uniform", "_hash"];

    _hash = createHashMap;
    GRLIB_weapon_classes apply {
        _wpn = [_x, _cfg get "weapons", false, _coolness_shift] call PCLF_getPrimaryWeapon;
        _hash set [_x, _wpn];
    };
    _camo = (_hash get "carbine") select 3; // TL weapon is the reference
    if (_camo == "nocamo") then { _camo = "any" };

    _uniform = [_camo, _cfg get "uniforms", false] call PCLF_getUniform;
    _vestLight = ["normal", _camo, _cfg get "vests", false] call PCLF_getVest;
    _vestHvy = ["heavy", _camo, _cfg get "vests", false] call PCLF_getVest;
    _headgear = ["headgear", _camo, _cfg get "vests", false] call PCLF_getVest;

    _hash set ["uniform", _uniform];
    _hash set ["normal", _vestLight ];
    _hash set ["heavy", _vestHvy];
    _hash set ["headgear", _headgear];

    _hash
};

private _shift = floor (combat_readiness / 2.0);

_sectorLoadoutHash = createHashMapFromArray [
    ["low", ([GRLIB_arsenal_opfor_low, _shift] call _setupTier)],
    ["high", ([GRLIB_arsenal_opfor_low, _shift] call _setupTier)]
];

_sectorLoadoutHash

