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
	_unit addItemToUniform "SmokeShell";
	_unit addVest "V_TacVest_camo";
	for "_i" from 1 to 6 do {_unit addItemToVest "30Rnd_556x45_Stanag";};
	_unit addBackpack "B_Carryall_oli";
	_unit addItemToBackpack "CUP_Dragon_EP1_M";
	_unit addHeadgear "CUP_H_SLA_Helmet";

	comment "Add weapons";
	_unit addWeapon "hlc_rifle_Colt727";
	_unit addWeapon "CUP_launch_M47";

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
	_unit addItemToUniform "HandGrenade";
	_unit addItemToUniform "SmokeShell";
	_unit addVest "rhsusf_spc_marksman";
	for "_i" from 1 to 6 do {_unit addItemToVest "rhs_mag_30Rnd_556x45_M855A1_Stanag";};
	_unit addBackpack "rhsusf_assault_eagleaiii_ocp";
	_unit addItemToBackpack "rhs_fgm148_magazine_AT";
	_unit addHeadgear "rhsusf_ach_helmet_ocp";

	comment "Add weapons";
	_unit addWeapon "rhs_m4_compm4";
	_unit addPrimaryWeaponItem "rhsusf_acc_anpeq15side";
	_unit addPrimaryWeaponItem "rhsusf_acc_compm4";
	_unit addWeapon "rhs_weap_fgm148";

	comment "Add items";
	_unit linkItem "ItemMap";
	_unit linkItem "ItemCompass";
	_unit linkItem "ItemWatch";
	_unit linkItem "ItemRadio";
};