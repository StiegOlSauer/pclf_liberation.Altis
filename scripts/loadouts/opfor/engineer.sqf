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
	for "_i" from 1 to 2 do {_unit addItemToUniform "ACE_fieldDressing";};
	_unit addItemToUniform "ACE_morphine";
	_unit addItemToUniform "rhs_mag_rgd5";
	for "_i" from 1 to 2 do {_unit addItemToUniform "rhs_mag_9x18_8_57N181S";};
	for "_i" from 1 to 3 do {_unit addItemToUniform "SmokeShell";};
	_unit addVest "LOP_V_CarrierRig_WDL";
	_unit addItemToVest "ACE_Clacker";
	for "_i" from 1 to 7 do {_unit addItemToVest "hlc_20rnd_762x51_b_G3";};
	_unit addBackpack "rhsusf_falconii";
	_unit addItemToBackpack "ToolKit";
	for "_i" from 1 to 2 do {_unit addItemToBackpack "DemoCharge_Remote_Mag";};
	_unit addHeadgear "CUP_H_SLA_Helmet";

	comment "Add weapons";
	_unit addWeapon "hlc_rifle_g3sg1";
	_unit addWeapon "rhs_weap_makarov_pm";

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
	_unit addItemToUniform "rhsusf_ANPVS_14";
	_unit addItemToUniform "rhsusf_patrolcap_ocp";
	for "_i" from 1 to 2 do {_unit addItemToUniform "ACE_fieldDressing";};
	_unit addItemToUniform "ACE_morphine";
	_unit addItemToUniform "rhs_mag_m18_red";
	_unit addVest "rhsusf_iotv_ocp_Repair";
	for "_i" from 1 to 6 do {_unit addItemToVest "rhs_mag_30Rnd_556x45_M855A1_Stanag";};
	_unit addItemToVest "rhsusf_mag_15Rnd_9x19_JHP";
	for "_i" from 1 to 2 do {_unit addItemToVest "SmokeShell";};
	_unit addItemToVest "CUP_HandGrenade_M67";
	_unit addItemToVest "DemoCharge_Remote_Mag";
	_unit addBackpack "rhsusf_assault_eagleaiii_ocp";
	_unit addItemToBackpack "ToolKit";
	_unit addItemToBackpack "ACE_wirecutter";
	_unit addItemToBackpack "ACE_Clacker";
	_unit addHeadgear "rhsusf_ach_helmet_ESS_ocp";

	comment "Add weapons";
	_unit addWeapon "rhs_m4_compm4";
	_unit addPrimaryWeaponItem "rhsusf_acc_anpeq15side";
	_unit addPrimaryWeaponItem "rhsusf_acc_compm4";
	_unit addWeapon "rhsusf_weap_m9";

	comment "Add items";
	_unit linkItem "ItemMap";
	_unit linkItem "ItemCompass";
	_unit linkItem "ItemWatch";
	_unit linkItem "ItemRadio";
 };