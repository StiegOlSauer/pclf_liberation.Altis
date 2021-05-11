_unit = _this select 0;

removeAllWeapons _unit;

for "_i" from 1 to 2 do {_unit addItemToVest "MiniGrenade";};
for "_i" from 1 to 2 do {
	_unit addItemToVest "rhsusf_mag_15Rnd_9x19_JHP";
	_unit addItemToVest "ACE_quikclot";
	_unit addItemToVest "ACE_morphine";
};
for "_i" from 1 to 5 do {_unit addItemToVest "RH_30Rnd_556x45_M855A1";};

_unit addWeapon "RH_m16a2";
//_unit addPrimaryWeaponItem "optic_ACO_grn";
_unit addPrimaryWeaponItem "rhsusf_acc_ACOG";
_unit addWeapon "rhsusf_weap_m9";