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
	_unit addItemToUniform "hlc_100Rnd_762x51_T_M60E4";
	_unit addVest "V_TacVest_camo";
	_unit addItemToVest "hlc_100Rnd_762x51_T_M60E4";
	for "_i" from 1 to 2 do {_unit addItemToVest "hlc_100Rnd_762x51_M_M60E4";};
	_unit addHeadgear "CUP_H_SLA_Helmet";
	_unit addGoggles "rhs_scarf";

	comment "Add weapons";
	_unit addWeapon "hlc_lmg_m60";

	comment "Add items";
	_unit linkItem "ItemMap";
	_unit linkItem "ItemCompass";
	_unit linkItem "ItemWatch";
	_unit linkItem "ItemRadio";

} else{ 
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
	_unit addVest "rhsusf_spc_mg";
	for "_i" from 1 to 2 do {_unit addItemToVest "SmokeShell";};
	_unit addItemToVest "CUP_100Rnd_TE4_LRT4_White_Tracer_762x51_Belt_M";
	_unit addItemToVest "HandGrenade";
	_unit addBackpack "rhsusf_assault_eagleaiii_coy";
	for "_i" from 1 to 2 do {_unit addItemToBackpack "CUP_100Rnd_TE4_LRT4_White_Tracer_762x51_Belt_M";};
	_unit addHeadgear "rhsusf_ach_helmet_ocp";

	comment "Add weapons";
	_unit addWeapon "CUP_lmg_M240";
	_unit addPrimaryWeaponItem "rhsusf_acc_ELCAN";
	_unit addWeapon "Binocular";

	comment "Add items";
	_unit linkItem "ItemMap";
	_unit linkItem "ItemCompass";
	_unit linkItem "ItemWatch";
	_unit linkItem "ItemRadio";
};