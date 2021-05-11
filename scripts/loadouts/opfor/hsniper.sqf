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
	_unit addVest "LOP_V_6Sh92_Radio_OLV";
	_unit addItemToVest "SmokeShell";
	_unit addItemToVest "HandGrenade";
	for "_i" from 1 to 10 do {_unit addItemToVest "rhsusf_5Rnd_762x51_m118_special_Mag";};
	_unit addHeadgear "H_Watchcap_camo";
	_unit addGoggles "G_Bandanna_oli";

	comment "Add weapons";
	_unit addWeapon "rhs_weap_m24sws_blk";
	_unit addPrimaryWeaponItem "rhsusf_acc_LEUPOLDMK4";
	_unit addPrimaryWeaponItem "RH_HBLM";
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
	for "_i" from 1 to 7 do {_unit addItemToVest "rhsusf_5Rnd_300winmag_xm2010";};
	for "_i" from 1 to 3 do {_unit addItemToVest "SmokeShell";};
	_unit addHeadgear "rhsusf_ach_bare_des";

	comment "Add weapons";
	_unit addWeapon "rhs_weap_XM2010_d_leu";
	_unit addPrimaryWeaponItem "rhsusf_acc_LEUPOLDMK4_2";
	_unit addPrimaryWeaponItem "rhsusf_acc_harris_bipod";
	_unit addWeapon "rhsusf_weap_glock17g4";
	_unit addWeapon "lerca_1200_tan";

	comment "Add items";
	_unit linkItem "ItemMap";
	_unit linkItem "ItemCompass";
	_unit linkItem "ItemWatch";
	_unit linkItem "ItemRadio";
};