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
	for "_i" from 1 to 2 do {_unit addItemToUniform "rhs_mag_9x18_8_57N181S";};
	_unit addVest "V_TacVest_camo";
	for "_i" from 1 to 15 do {_unit addItemToVest "ACE_morphine";};
	for "_i" from 1 to 4 do {_unit addItemToVest "ACE_epinephrine";};
	for "_i" from 1 to 10 do {_unit addItemToVest "ACE_elasticBandage";};
	for "_i" from 1 to 10 do {_unit addItemToVest "ACE_packingBandage";};
	for "_i" from 1 to 5 do {_unit addItemToVest "RH_30Rnd_556x45_M855A1";};
	for "_i" from 1 to 4 do {_unit addItemToVest "SmokeShell";};
	_unit addBackpack "rhs_sidor";
	for "_i" from 1 to 2 do {_unit addItemToBackpack "ACE_bloodIV_500";};
	for "_i" from 1 to 2 do {_unit addItemToBackpack "ACE_bloodIV";};
	for "_i" from 1 to 2 do {_unit addItemToBackpack "RH_30Rnd_556x45_M855A1";};
	_unit addHeadgear "CUP_H_SLA_Helmet";

	comment "Add weapons";
	_unit addWeapon "RH_M16a1";
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
	for "_i" from 1 to 4 do {_unit addItemToUniform "ACE_fieldDressing";};
	for "_i" from 1 to 2 do {_unit addItemToUniform "ACE_morphine";};
	_unit addVest "rhsusf_spc_corpsman";
	for "_i" from 1 to 18 do {_unit addItemToVest "ACE_fieldDressing";};
	for "_i" from 1 to 9 do {_unit addItemToVest "ACE_morphine";};
	for "_i" from 1 to 6 do {_unit addItemToVest "rhs_mag_30Rnd_556x45_M855A1_Stanag";};
	for "_i" from 1 to 4 do {_unit addItemToVest "SmokeShell";};
	_unit addBackpack "rhsusf_assault_eagleaiii_ocp";
	for "_i" from 1 to 4 do {_unit addItemToBackpack "ACE_bloodIV";};
	for "_i" from 1 to 2 do {_unit addItemToBackpack "ACE_epinephrine";};
	for "_i" from 1 to 8 do {_unit addItemToBackpack "ACE_morphine";};
	_unit addHeadgear "rhsusf_ach_helmet_ocp";

	comment "Add weapons";
	_unit addWeapon "rhs_m4_grip_compm4";
	_unit addPrimaryWeaponItem "rhsusf_acc_compm4";

	comment "Add items";
	_unit linkItem "ItemMap";
	_unit linkItem "ItemCompass";
	_unit linkItem "ItemWatch";
	_unit linkItem "ItemRadio";
};