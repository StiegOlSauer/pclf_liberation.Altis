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
_unit forceAddUniform "LOP_U_AFR_Civ_03";
_unit addItemToUniform "ACE_morphine";
_unit addItemToUniform "ACE_Banana";
for "_i" from 1 to 2 do {_unit addItemToUniform "rhsusf_mag_7x45acp_MHP";};
_unit addGoggles "CUP_FR_NeckScarf2";

comment "Add weapons";
_unit addWeapon "rhsusf_weap_m1911a1";

_unit linkItem "ItemWatch";
