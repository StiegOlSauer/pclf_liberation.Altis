params [
    "_roleOrClass",
    ["_type", "auto"],
    ["_camo", "any"],
    ["_config", "auto"]
];
private ["_chosen_pattern"];

if !(_roleOrClass in LP_opfor_vehicle_roles) exitWith {[_roleOrClass, "any"]};

if (_config == "auto") then {
    _config = [GRLIB_opfor_low_vehicles, GRLIB_opfor_low_vehicles] select (combat_readiness >= GRLIB_uptier_readiness); //FIXME: use correct OPFOR arsenal when high-tier is ready
};

private _vehs = [];
if (_type == "auto") then {
    _vehs = _config get _roleOrClass;
} else {
    _vehs = (_config get _roleOrClass) select { ((_x select 0) get "type") == _type };
};

private _v = selectRandomWeighted _vehs;

_chosen_pattern = _v getOrDefault [_camo, [], true];
if ((count _chosen_pattern) == 0) then {
    GRLIB_eligible_weapon_camo apply {
        _chosen_pattern = _v getOrDefault [_x];
        if ((count _chosen_pattern) > 0) exitWith {};
    };
};

[(_v get "class"), ["", (selectRandom _chosen_pattern)] select ((count _chosen_pattern) > 0)]
