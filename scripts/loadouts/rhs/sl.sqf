_unit = _this select 0;

removeAllWeapons _unit;
removeAllItems _unit;
removeAllAssignedItems _unit;
removeUniform _unit;
removeVest _unit;
removeBackpack _unit;
removeHeadgear _unit;
removeGoggles _unit;

_unit forceAddUniform "U_BG_Guerrilla_6_1";
for "_i" from 1 to 2 do {_unit addItemToUniform "ACE_fieldDressing";};
for "_i" from 1 to 2 do {_unit addItemToUniform "ACE_morphine";};
for "_i" from 1 to 2 do {_unit addItemToUniform "rhsusf_mag_15Rnd_9x19_JHP";};
for "_i" from 1 to 2 do {_unit addItemToUniform "SmokeShell";};
_unit addVest "LOP_V_6B23_6Sh92_OLV";
for "_i" from 1 to 6 do {_unit addItemToVest "hlc_30Rnd_762x39_b_ak";};
for "_i" from 1 to 2 do {_unit addItemToVest "rhs_mag_rgn";};
_unit addHeadgear "H_Booniehat_oli";
_unit addGoggles "G_Bandanna_beast";

_unit addWeapon "hlc_rifle_RK62";
_unit addWeapon "rhs_weap_m72a7";
_unit addWeapon "rhsusf_weap_m9";
_unit addWeapon "Binocular";

_unit linkItem "ItemMap";
_unit linkItem "ItemCompass";
