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
	for "_i" from 1 to 2 do {_unit addItemToUniform "rhsusf_mag_7x45acp_MHP";};
	_unit addVest "rhs_6b13_Flora_6sh92_vog";
	for "_i" from 1 to 2 do {_unit addItemToVest "SmokeShell";};
	_unit addItemToVest "SmokeShellYellow";
	_unit addItemToVest "SmokeShellRed";
	_unit addItemToVest "SmokeShellGreen";
	for "_i" from 1 to 6 do {_unit addItemToVest "rhs_30Rnd_545x39_AK";};
	_unit addHeadgear "CUP_H_SLA_Boonie";

	comment "Add weapons";
	_unit addWeapon "hlc_rifle_aks74";
	_unit addPrimaryWeaponItem "rhs_acc_ekp1";
	_unit addWeapon "rhsusf_weap_m1911a1";

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
	for "_i" from 1 to 2 do {_unit addItemToUniform "ACE_fieldDressing";};
	_unit addItemToUniform "ACE_morphine";
	for "_i" from 1 to 3 do {_unit addItemToUniform "rhsusf_mag_17Rnd_9x19_JHP";};
	_unit addVest "rhsusf_spc_squadleader";
	for "_i" from 1 to 6 do {_unit addItemToVest "rhs_mag_30Rnd_556x45_M855A1_Stanag";};
	for "_i" from 1 to 2 do {_unit addItemToVest "HandGrenade";};
	_unit addItemToVest "SmokeShell";
	_unit addItemToVest "SmokeShellYellow";
	_unit addItemToVest "SmokeShellRed";
	_unit addItemToVest "SmokeShellGreen";
	_unit addHeadgear "rhsusf_ach_helmet_headset_ess_ocp";

	comment "Add weapons";
	_unit addWeapon "rhs_weap_m16a4_carryhandle_grip";
	_unit addPrimaryWeaponItem "rhsusf_acc_anpeq15side";
	_unit addPrimaryWeaponItem "RH_pas13cl";
	_unit addWeapon "rhsusf_weap_glock17g4";
	_unit addWeapon "Binocular";

	comment "Add items";
	_unit linkItem "ItemMap";
	_unit linkItem "ItemCompass";
	_unit linkItem "ItemWatch";
	_unit linkItem "ItemRadio";
};