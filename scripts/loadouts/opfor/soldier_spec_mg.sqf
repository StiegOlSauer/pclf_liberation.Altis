_unit = _this select 0;

removeAllWeapons _unit;
removeBackpack _unit;
removeVest _unit;

_unit addVest "V_PlateCarrierL_CTRG";
_unit addBackpack "B_TacticalPack_oli";

for "_i" from 1 to 2 do {_unit addItemToVest "MiniGrenade";};
for "_i" from 1 to 2 do {
	_unit addItemToVest "ACE_quikclot";
	_unit addItemToVest "ACE_morphine";
	_unit addItemToVest "SmokeShell";
};

_unit addItemToVest "rhs_100Rnd_762x54mmR_green";
for "_i" from 1 to 4 do {_unit addItemToBackpack "hlc_100Rnd_762x51_T_M60E4";};

_unit addWeapon "hlc_lmg_M60E4";
_unit addPrimaryWeaponItem "RH_eotexps3";