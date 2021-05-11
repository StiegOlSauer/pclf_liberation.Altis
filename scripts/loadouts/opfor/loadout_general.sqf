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
_unit forceAddUniform "rhsgref_uniform_specter";
for "_i" from 1 to 2 do {_unit addItemToUniform "ACE_fieldDressing";};
_unit addItemToUniform "30Rnd_45ACP_Mag_SMG_01";
_unit addVest "rhs_vest_commander";
for "_i" from 1 to 4 do {_unit addItemToVest "30Rnd_45ACP_Mag_SMG_01";};
_unit addHeadgear "rhsgref_fieldcap_ttsko_digi";

comment "Add weapons";
_unit addWeapon "SMG_01_F";
_unit addPrimaryWeaponItem "RH_cmore";

comment "Add items";
_unit linkItem "ItemMap";
_unit linkItem "ItemCompass";
_unit linkItem "ItemWatch";
_unit linkItem "ItemRadio";
