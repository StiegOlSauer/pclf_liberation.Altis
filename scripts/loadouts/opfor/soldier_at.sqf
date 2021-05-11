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
	for "_i" from 1 to 2 do {_unit addItemToUniform "SmokeShell";};
	_unit addVest "V_TacVest_camo";
	for "_i" from 1 to 5 do {_unit addItemToVest "rhs_30Rnd_762x39mm";};
	_unit addBackpack "rhs_rpg_empty";
	for "_i" from 1 to 3 do {_unit addItemToBackpack "rhs_rpg7_PG7VL_mag";};
	_unit addItemToBackpack "rhs_rpg7_OG7V_mag";
	_unit addHeadgear "CUP_H_SLA_Helmet";

	comment "Add weapons";
	_unit addWeapon "rhs_weap_m92";
	_unit addWeapon "rhs_weap_rpg7";

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
	for "_i" from 1 to 6 do {_unit addItemToVest "RH_30Rnd_556x45_M855A1";};
	_unit addBackpack "rhsusf_assault_eagleaiii_ocp";
	_unit addItemToBackpack "rhs_mag_smaw_HEAA";
	_unit addItemToBackpack "rhs_mag_smaw_SR";
	_unit addHeadgear "rhsusf_ach_helmet_ocp";

	comment "Add weapons";
	_unit addWeapon "RH_m4";
	_unit addPrimaryWeaponItem "rhsusf_acc_compm4";
	_unit addWeapon "rhs_weap_smaw_green";
	_unit addSecondaryWeaponItem "rhs_weap_optic_smaw";

	comment "Add items";
	_unit linkItem "ItemMap";
	_unit linkItem "ItemCompass";
	_unit linkItem "ItemWatch";
	_unit linkItem "ItemRadio";
};