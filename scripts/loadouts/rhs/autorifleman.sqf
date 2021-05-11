_unit = _this select 0;

removeAllWeapons _unit;
removeAllItems _unit;
removeAllAssignedItems _unit;
removeUniform _unit;
removeVest _unit;
removeBackpack _unit;
removeHeadgear _unit;
removeGoggles _unit;

comment "Add containers";
_unit forceAddUniform "rhsgref_uniform_ttsko_mountain";
for "_i" from 1 to 2 do {_unit addItemToUniform "ACE_fieldDressing";};
for "_i" from 1 to 2 do {_unit addItemToUniform "ACE_morphine";};
for "_i" from 1 to 2 do {_unit addItemToUniform "SmokeShell";};
_unit addVest "LOP_V_CarrierLite_OLV";
for "_i" from 1 to 2 do {_unit addItemToVest "rhs_mag_rgn";};
_unit addItemToVest "hlc_75Rnd_762x39_m_rpk";
for "_i" from 1 to 3 do {_unit addItemToVest "hlc_45Rnd_762x39_m_rpk";};
_unit addBackpack "rhs_sidor";
for "_i" from 1 to 6 do {_unit addItemToBackpack "hlc_45Rnd_762x39_m_rpk";};
_unit addHeadgear "rhsgref_ssh68_emr";
_unit addGoggles "G_Balaclava_blk";

comment "Add weapons";
_unit addWeapon "hlc_rifle_rpk";
_unit addWeapon "Binocular";

comment "Add items";
_unit linkItem "ItemMap";
_unit linkItem "ItemCompass";
