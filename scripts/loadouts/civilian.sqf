_unit = _this select 0;

_loadout = round (random 2);

removeAllWeapons _unit;
removeAllItems _unit;
removeAllAssignedItems _unit;
removeUniform _unit;
removeVest _unit;
removeBackpack _unit;
removeHeadgear _unit;
removeGoggles _unit;

switch (_loadout) do {

	case 0: {
		comment "Add containers";
		_unit forceAddUniform "U_BG_Guerilla2_2";
		for "_i" from 1 to 2 do {_unit addItemToUniform "ACE_fieldDressing";};
		_unit addItemToUniform "ACE_morphine";
		for "_i" from 1 to 2 do {_unit addItemToUniform "RH_8Rnd_762_tt33";};
		_unit addVest "V_BandollierB_oli";
		for "_i" from 1 to 8 do {_unit addItemToVest "rhsusf_5Rnd_00Buck";};
		for "_i" from 1 to 3 do {_unit addItemToVest "RH_8Rnd_762_tt33";};
		_unit addHeadgear "CUP_H_FR_Cap_Headset_Green";
		_unit addGoggles "G_Bandanna_khk";

		comment "Add weapons";
		_unit addWeapon "rhs_weap_M590_5RD";
		_unit addWeapon "RH_tt33";

		comment "Add items";
		_unit linkItem "ItemMap";
		_unit linkItem "ItemCompass";
		_unit linkItem "ItemWatch";
		_unit linkItem "ItemRadio";
	};
	
	case 1: {
		comment "Add containers";
		_unit forceAddUniform "U_BG_Guerilla3_1";
		for "_i" from 1 to 2 do {_unit addItemToUniform "ACE_fieldDressing";};
		_unit addItemToUniform "ACE_morphine";
		for "_i" from 1 to 2 do {_unit addItemToUniform "RH_8Rnd_9x18_Mak";};
		_unit addVest "V_BandollierB_khk";
		for "_i" from 1 to 8 do {_unit addItemToVest "CUP_5x_22_LR_17_HMR_M";};
		_unit addHeadgear "H_Bandanna_khk";
		_unit addGoggles "G_Aviator";

		comment "Add weapons";
		_unit addWeapon "CUP_srifle_CZ550";
		_unit addWeapon "RH_mak";

		comment "Add items";
		_unit linkItem "ItemMap";
		_unit linkItem "ItemCompass";
		_unit linkItem "ItemWatch";
		_unit linkItem "ItemRadio";
	};
	
	case 2: {
		comment "Add containers";
		_unit forceAddUniform "CUP_U_C_Citizen_01";
		for "_i" from 1 to 2 do {_unit addItemToUniform "ACE_fieldDressing";};
		_unit addItemToUniform "ACE_morphine";
		_unit addVest "CUP_V_O_TK_CrewBelt";
		for "_i" from 1 to 8 do {_unit addItemToVest "RH_6Rnd_454_Mag";};
		_unit addGoggles "G_Bandanna_beast";

		comment "Add weapons";
		_unit addWeapon "RH_bullb";

		comment "Add items";
		_unit linkItem "ItemMap";
		_unit linkItem "ItemCompass";
		_unit linkItem "ItemWatch";
		_unit linkItem "ItemRadio";
	};
};