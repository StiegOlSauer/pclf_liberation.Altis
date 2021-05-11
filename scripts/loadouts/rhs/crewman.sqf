_unit = _this select 0;

removeAllWeapons _unit;
removeAllItems _unit;
removeAllAssignedItems _unit;
removeVest _unit;
removeBackpack _unit;
removeHeadgear _unit;
removeGoggles _unit;

_unit addVest "V_TacVest_camo";
_unit addItemToVest "FirstAidKit";
for "_i" from 1 to 3 do { _unit addItemToVest "rhs_30Rnd_762x39mm";};
for "_i" from 1 to 2 do { _unit addItemToVest "MiniGrenade";};
for "_i" from 1 to 2 do { _unit addItemToVest "SmokeShell";};
_unit addItemToVest "Chemlight_green";
_unit addHeadgear "H_Cap_headphones";
_unit addGoggles "G_Balaclava_combat";

_unit addWeapon "rhs_weap_akms";

_unit linkItem "ItemMap";
_unit linkItem "ItemCompass";
_unit linkItem "ItemRadio";