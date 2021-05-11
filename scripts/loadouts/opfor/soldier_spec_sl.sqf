_unit = _this select 0;

removeAllWeapons _unit;
removeBackpack _unit;
removeVest _unit;

_unit addVest "V_PlateCarrierH_CTRG";
_unit addBackpack "B_TacticalPack_oli";

for "_i" from 1 to 2 do {_unit addItemToVest "MiniGrenade";};
for "_i" from 1 to 2 do {
	_unit addItemToVest "rhsusf_mag_15Rnd_9x19_JHP";
	_unit addItemToVest "ACE_quikclot";
	_unit addItemToVest "ACE_morphine";
	_unit addItemToVest "SmokeShell";
};
for "_i" from 1 to 5 do {_unit addItemToVest "RH_30Rnd_556x45_M855A1";};
for "_i" from 1 to 10 do {_unit addItemToBackpack "1Rnd_HE_Grenade_shell";};

_unit addWeapon "RH_m4a1_ris_m203_des";
_unit addPrimaryWeaponItem "RH_eotech553_tan";
//_unit addPrimaryWeaponItem "rhsusf_acc_ACOG";
_unit addWeapon "rhsusf_weap_m9";