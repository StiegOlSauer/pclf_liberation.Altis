private ["_cfg", "_items"];

// Add every part of "unlocks" hashmap into corresponding section of BI arsenal
_cfg = GRLIB_arsenal_unlocks get "weapons";

{
    for "_i" from 0 to (count _y)-1 step 2 do {
        private _w = _y select _i;
        [missionNamespace, _w select 0, true] call BIS_fnc_addVirtualWeaponCargo;
    };
} forEach _cfg;

_cfg = GRLIB_arsenal_unlocks get "vests";
_items = [];
{
    {
        for "_i" from 0 to (count _y)-1 step 2 do {
            private _v = _y select _i;
            [missionNamespace, _v select 0, true] call BIS_fnc_addVirtualItemCargo;
        };
    } forEach _y;
} forEach _cfg;

_cfg = GRLIB_arsenal_unlocks get "uniforms";
{
    [missionNamespace, _y, true] call BIS_fnc_addVirtualItemCargo;
} forEach _cfg;

_items = [];
_cfg = GRLIB_arsenal_unlocks get "devices";
{
    {
        _items append _y;
    } forEach _y;
} forEach _cfg;
[missionNamespace, _items, true] call BIS_fnc_addVirtualItemCargo;

_cfg = GRLIB_arsenal_unlocks get "optics";
{
    {
        {
            [missionNamespace, _y, true] call BIS_fnc_addVirtualItemCargo;
        } forEach _y;
    } forEach _y;
} forEach _cfg;
