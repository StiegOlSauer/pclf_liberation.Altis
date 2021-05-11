_unit = _this select 0;

removeAllWeapons _unit;
removeAllItems _unit;
removeAllAssignedItems _unit;
removeVest _unit;
removeBackpack _unit;
removeHeadgear _unit;
removeGoggles _unit;

_unit addVest "V_Chestrig_oli";
_unit addItemToVest "FirstAidKit";
for "_i" from 1 to 2 do {_unit addItemToVest "MiniGrenade";};
for "_i" from 1 to 2 do {_unit addItemToVest "rhsusf_mag_7x45acp_MHP";};
for "_i" from 1 to 6 do {_unit addItemToVest "hlc_30Rnd_762x39_b_ak";};
_unit addHeadgear "H_Cap_blk";
_unit addGoggles "G_Balaclava_oli";

_unit addWeapon "hlc_rifle_ak47";
_unit addWeapon "rhsusf_weap_m1911a1";
_unit linkItem "ItemMap";
_unit linkItem "ItemCompass";