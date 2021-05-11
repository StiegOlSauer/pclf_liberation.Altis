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
	for "_i" from 1 to 2 do {_unit addItemToUniform "SmokeShell";};
	for "_i" from 1 to 2 do {_unit addItemToUniform "rhs_mag_9x18_8_57N181S";};
	_unit addVest "V_TacVest_camo";
	for "_i" from 1 to 3 do {_unit addItemToVest "hlc_75Rnd_762x39_m_rpk";};
	_unit addBackpack "rhs_sidor";
	for "_i" from 1 to 6 do {_unit addItemToBackpack "hlc_45Rnd_762x39_t_rpk";};
	_unit addItemToBackpack "rhs_mag_9x18_8_57N181S";
	_unit addHeadgear "CUP_H_SLA_Helmet";
	_unit addGoggles "CUP_FR_NeckScarf2";

	comment "Add weapons";
	_unit addWeapon "hlc_rifle_rpk";
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
	_unit addItemToUniform "ACE_EarPlugs";
	for "_i" from 1 to 2 do {_unit addItemToUniform "ACE_fieldDressing";};
	_unit addItemToUniform "ACE_morphine";
	_unit addItemToUniform "HandGrenade";
	_unit addVest "rhsusf_spc_mg";
	_unit addItemToVest "HandGrenade";
	for "_i" from 1 to 2 do {_unit addItemToVest "rhsusf_100Rnd_556x45_soft_pouch";};
	for "_i" from 1 to 2 do {_unit addItemToVest "SmokeShell";};
	_unit addBackpack "rhsusf_assault_eagleaiii_coy";
	for "_i" from 1 to 4 do {_unit addItemToBackpack "rhsusf_100Rnd_556x45_soft_pouch";};
	_unit addHeadgear "rhsusf_ach_helmet_ocp";

	comment "Add weapons";
	_unit addWeapon "hlc_m249_pip3";
	_unit addPrimaryWeaponItem "RH_compm4s";
	_unit addWeapon "Binocular";

	comment "Add items";
	_unit linkItem "ItemMap";
	_unit linkItem "ItemCompass";
	_unit linkItem "ItemWatch";
	_unit linkItem "ItemRadio";
};