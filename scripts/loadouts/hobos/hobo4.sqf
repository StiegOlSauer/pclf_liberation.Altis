_unit = _this select 0;

comment "Remove existing items";
removeAllWeapons _unit;
removeAllItems _unit;
removeAllAssignedItems _unit;
removeUniform _unit;
removeVest _unit;
removeBackpack _unit;
removeHeadgear _unit;
removeGoggles _unit;

comment "Add containers";
_unit forceAddUniform "CUP_U_O_CHDKZ_Lopotev";
_unit addItemToUniform "ACE_morphine";
_unit addItemToUniform "ACE_Banana";
for "_i" from 1 to 2 do {_unit addItemToUniform "10Rnd_9x21_Mag";};
_unit addHeadgear "H_Cap_police";
_unit addGoggles "CUP_TK_NeckScarf";

comment "Add weapons";
_unit addWeapon "hgun_Pistol_01_F";

_unit linkItem "ItemWatch";