params ["_locationPosition", "_loadoutHash", "_garrison"];
private ["_base_class", "_squad_comp", "_placeholder_classes", "_condition", "_static_placeholder", "_guard_position"];

private _posts = [];
_guard_position = "CBA_BuildingPos";
_static_placeholder = "Sign_Arrow_F";
_condition = "sleep 3; !alive _unit || (damage _unit) > 0 || (_unit nearEntities [['Man'], 10]) findIf {side _x == GRLIB_side_friendly} != -1";

private _ret = ["guard", false] call PCLF_getAdaptiveSquadComp;
_base_class = _ret select 0;
_squad_comp = _ret select 1;

(_locationPosition nearObjects [_static_placeholder, 1000]) apply {
    _posts pushback (getPos _x);
    deleteVehicle _x;
};

(_locationPosition nearObjects [_guard_position, 1000]) apply {
    if !(_x getVariable ["LP_occupied", false]) then {
        _posts pushback _x;
    };
};

if ((count _posts) == 0) exitWith {[]};
if ((count _posts) > _garrison) then {
    _posts resize _garrison;
};

private _grp = createGroup GRLIB_side_enemy;
private _groups = [_grp];
{
    if (_forEachIndex % 5 == 0) then {
        _grp = createGroup GRLIB_side_enemy;
        _groups pushback _grp;
    };
    _unit = _grp createUnit [_base_class, _locationPosition, [], 0, "NONE"];
    _unit addMPEventHandler ["MPKilled", {_this spawn kill_manager}];
    [_unit, (selectRandom _squad_comp), _forEachIndex, _loadoutHash] call PCLF_swap_loadout;

    [_unit, _x, 0.9, _condition] spawn {
        params ["_unit", "_pos", "_hold", "_condition"];
        _unit setPos (_pos buildingPos 0);
        _pos setVariable ["LP_occupied", true];
        _unit setDir (random 360);
        waitUntil {unitReady _unit};
        if (random 1 < _hold) then {
            _unit disableAI "PATH";
            waitUntil (compile _condition);
            _unit enableAI "PATH";
        } else {
            doStop _unit;
        };
        _unit setUnitPos "UP";
    };
} forEach _posts;

_groups

//nearestObjects [player, ["CBA_BuildingPos"], 200] apply {_x buildingPos 0}
//_veh = createVehicle ["LOP_ISTS_Static_DSHKM",position player,[],0,"NONE"];
