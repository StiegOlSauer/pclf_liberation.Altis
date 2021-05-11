private _weapons_hash = createHashMap;

/*
 * 100 / (
 * RIS mount: /1.5;
 * Rareness: modern /2; specops used: /1.5; unusual hardware: /3.5;
 * Mounts: allows muzzle devs: /1.5; has preinstalled optics: /1.5; allows optics: /2;
 * front rail: /1,5; can mount grip/bipod: /1.5;
 * Integrated hardware: bipod: /2, int.toprail: /2, GL /2.5, int.front grip: /2;
 * Mechanics: balanced /4; high ROF: /2;
 * silenced: /1.5;
 * powerful cartridge: /2;
 * hi-cap mag: /2 (for pistols, precision rifles and shotguns)
 * )
*/


private _aas = [

];
_weapons_hash set ["aa", _aas];

private _carbines = [

];
_weapons_hash set ["carbine", _carbines];

private _carbinegls = [

    ["CUP_arifle_Sa58RIS2_gl_woodland", "SA58", "RIS", "woodland", true, false],     2.9629629629629632
];
_weapons_hash set ["carbinegl", _carbinegls];

private _hats = [

];
_weapons_hash set ["hat", _hats];

private _lats = [

];
_weapons_hash set ["lat", _lats];

private _lmgs = [

];
_weapons_hash set ["lmg", _lmgs];

private _mgs = [

    ["CUP_lmg_M60E4_jungle", "M240", "RIS", "woodland", false, false],     1.851851851851852,
    ["hlc_lmg_mg42kws_g", "MG42", "RIS", "woodland", false, false],     2.777777777777778
];
_weapons_hash set ["mg", _mgs];

private _marksmans = [

    ["CUP_srifle_SVD_wdl", "SVD", "Dovetail", "woodland", true, false],     33.333333333333336,
    ["CUP_srifle_SVD_wdl_top_rail", "SVD", "RIS", "woodland", true, false],     22.222222222222225
];
_weapons_hash set ["marksman", _marksmans];

private _pistols = [

];
_weapons_hash set ["pistol", _pistols];

private _rifles = [

];
_weapons_hash set ["rifle", _rifles];

private _riflegls = [

];
_weapons_hash set ["riflegl", _riflegls];

private _smgs = [

];
_weapons_hash set ["smg", _smgs];

private _snipers = [

];
_weapons_hash set ["sniper", _snipers];


private _starting = [

];

[_weapons_hash, _starting]
