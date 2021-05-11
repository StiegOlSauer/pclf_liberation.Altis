params ["_preset_id"];
private ["_vests", "_mags", "_optics", "_uniforms", "_preset_dir", "_sq"];

private _weaponClasses = ["aa", "at", "rifle", "riflegl", "carbine", "carbinegl", "lmg", "mg", "pistol", "smg", "marksman", "sniper"];
private _starting_wpns = [];
private _weaponsHash = createHashMap;

switch (_preset_id) do {
    case 0: { // PMC backed by AFRF (mostly eastern, mid-to-high tech weapons)
        _preset_dir = "afrfpmc";
    };
    case 1: { // low-to-mid tech weapons for regular army
        _preset_dir = "takistan";
    };
    case 2: { // Weapons of 60s, early 70s
        _preset_dir = "sixties";
    };
    case 3: { // only high-tier stuff
        _preset_dir = "modern_specops";
    };
    case 4: { // mid-eastern terrorists
        _preset_dir = "isis"
    };
};

(GRLIB_eligible_weapon_camo) apply {
    switch (_x) do {
        case "desert": {
            private _ret = [] call compileFinal preprocessFileLineNumbers format ["scripts\gameplay_templates\arsenal\%1\desert\weapons.sqf", _preset_dir];
            {
                _weaponsHash set [_x, (_weaponsHash getOrDefault [_x, []]) + ((_ret select 0) get _x)];
            } foreach (_weaponClasses);
            _starting_wpns = _starting_wpns + (_ret select 1);
        };
        case "woodland": {
            private _ret = [] call compileFinal preprocessFileLineNumbers format ["scripts\gameplay_templates\arsenal\%1\woodland\weapons.sqf", _preset_dir];
            {
                _weaponsHash set [_x, (_weaponsHash getOrDefault [_x, []]) + ((_ret select 0) get _x)];
            } foreach (_weaponClasses);
            _starting_wpns = _starting_wpns + (_ret select 1);
        };
        case "black": {
            private _ret = [] call compileFinal preprocessFileLineNumbers format ["scripts\gameplay_templates\arsenal\%1\black\weapons.sqf", _preset_dir];
            {
                _weaponsHash set [_x, (_weaponsHash getOrDefault [_x, []]) + ((_ret select 0) get _x)];
            } foreach (_weaponClasses);
            _starting_wpns = _starting_wpns + (_ret select 1);
            diag_log _starting_wpns;
        };
        case "nocamo": {
            private _ret = [] call compileFinal preprocessFileLineNumbers format ["scripts\gameplay_templates\arsenal\%1\nocamo\weapons.sqf", _preset_dir];
            {
                _weaponsHash set [_x, (_weaponsHash getOrDefault [_x, []]) + ((_ret select 0) get _x)];
            } foreach (_weaponClasses);
            _starting_wpns = _starting_wpns + (_ret select 1);
        };
    };
};

// Init universal entities: magazines, optics...
_mags = [] call compileFinal preprocessFileLineNumbers format ["scripts\gameplay_templates\arsenal\%1\universal\magazines.sqf", _preset_dir];
_optics = [] call compileFinal preprocessFileLineNumbers format ["scripts\gameplay_templates\arsenal\%1\universal\optics.sqf", _preset_dir];
_uniforms = [] call compileFinal preprocessFileLineNumbers format ["scripts\gameplay_templates\arsenal\%1\universal\uniforms.sqf", _preset_dir];
_vests = [] call compileFinal preprocessFileLineNumbers format ["scripts\gameplay_templates\arsenal\%1\universal\vests.sqf", _preset_dir];
_devices = [] call compileFinal preprocessFileLineNumbers format ["scripts\gameplay_templates\arsenal\%1\universal\devices.sqf", _preset_dir];
_explosives = [] call compileFinal preprocessFileLineNumbers format ["scripts\gameplay_templates\arsenal\%1\universal\explosives.sqf", _preset_dir];

// Init squad compositions
_sq = [] call compileFinal preprocessFileLineNumbers format ["scripts\gameplay_templates\arsenal\%1\squads.sqf", _preset_dir];

[
    _weaponsHash, _starting_wpns, _mags, _optics, _uniforms, _vests, _devices, _explosives, _sq
]
