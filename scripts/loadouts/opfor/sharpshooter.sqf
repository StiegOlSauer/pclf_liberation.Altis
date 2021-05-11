_unit = _this select 0;

if (combat_readiness < 65) then {
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
	_unit forceAddUniform "LOP_U_SLA_Fatigue_01";
	_unit addItemToUniform "ACE_EarPlugs";
	for "_i" from 1 to 2 do {_unit addItemToUniform "ACE_fieldDressing";};
	_unit addItemToUniform "ACE_morphine";
	for "_i" from 1 to 3 do {_unit addItemToUniform "rhsusf_mag_7x45acp_MHP";};
	for "_i" from 1 to 2 do {_unit addItemToUniform "SmokeShell";};
	_unit addVest "V_TacVest_camo";
	_unit addItemToVest "SmokeShell";
	_unit addItemToVest "HandGrenade";
	for "_i" from 1 to 9 do {_unit addItemToVest "rhs_mag_30Rnd_556x45_M855A1_Stanag";};
	_unit addHeadgear "CUP_H_SLA_Helmet";
	_unit addGoggles "G_Balaclava_blk";

	comment "Add weapons";
	_unit addWeapon "rhs_weap_m16a4_carryhandle";
	_unit addPrimaryWeaponItem "rhsusf_acc_ACOG2_USMC";
	_unit addWeapon "rhsusf_weap_m1911a1";
	_unit addWeapon "Binocular";

	comment "Add items";
	_unit linkItem "ItemMap";
	_unit linkItem "ItemCompass";
	_unit linkItem "ItemWatch";
	_unit linkItem "ItemRadio";

} else {
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
	_unit forceAddUniform "rhs_uniform_cu_ocp";
	_unit addItemToUniform "ACE_EarPlugs";
	for "_i" from 1 to 2 do {_unit addItemToUniform "ACE_fieldDressing";};
	_unit addItemToUniform "ACE_morphine";
	for "_i" from 1 to 2 do {_unit addItemToUniform "rhsusf_mag_17Rnd_9x19_JHP";};
	_unit addVest "rhsusf_iotv_ocp_Teamleader";
	for "_i" from 1 to 8 do {_unit addItemToVest "RH_20Rnd_556x45_Mk262";};
	for "_i" from 1 to 3 do {_unit addItemToVest "SmokeShell";};
	_unit addHeadgear "rhsusf_ach_bare_des";

	comment "Add weapons";
	_unit addWeapon "RH_Mk12mod1";
	_unit addPrimaryWeaponItem "RH_ta648";
	_unit addPrimaryWeaponItem "RH_HBLM";
	_unit addWeapon "rhsusf_weap_glock17g4";
	_unit addWeapon "lerca_1200_tan";

	comment "Add items";
	_unit linkItem "ItemMap";
	_unit linkItem "ItemCompass";
	_unit linkItem "ItemWatch";
	_unit linkItem "ItemRadio";
};