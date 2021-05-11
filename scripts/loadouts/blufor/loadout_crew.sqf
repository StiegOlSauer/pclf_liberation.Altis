_unit = _this select 0;

private ["_mainWeapon", "_mainMags1", "_mainMags2", "_optics", "_opticsCompat","_weaponCandidate", "_tmpArray"];

//Helpers
// Format of getted compatible optics config
//[bin\config.bin/CfgWeapons/hlc_g3_base/WeaponSlotsInfo/CowsSlot/compatibleItems/HLC_Optic_ZFSG1,bin\config.bin/CfgWeapons/hlc_g3_base/WeaponSlotsInfo/CowsSlot/compatibleItems/hlc_optic_accupoint_g3,bin\config.bin/CfgWeapons/hlc_g3_base/WeaponSlotsInfo/CowsSlot/compatibleItems/hlc_optic_PVS4G3]

//get all first optic slots for all weapons. Check that when integrating new addons
//allOptics = [];datVariable2 = "";{datVariable2 = (((format ["%1",(configProperties [configFile >> "CfgWeapons" >> _x >> "WeaponSlotsInfo" >> "CowsSlot" >> "compatibleItems"])]) splitString ",") select 0) splitString "/"; datVariable2 = datVariable2 select ((count datVariable2) - 1);allOptics append [datVariable2];} foreach GRLIB_whitelisted_from_arsenal;

//bring random weapon from unlocked
_weaponCandidate = "";
_mainWeapon = "";
_optics = "";
_tmpArray = GRLIB_whitelisted_from_arsenal - GRLIB_arsenal_aaSystems - GRLIB_arsenal_pistols - GRLIB_arsenal_launchers - GRLIB_arsenal_machineguns - GRLIB_arsenal_autoRifles - GRLIB_arsenal_sniperRifles - GRLIB_arsenal_marksmanRifles - GRLIB_arsenal_rifles - GRLIB_arsenal_specWeapons - GRLIB_arsenal_atSystems;

//diag_log format ["LOADOUTS: _tmpArray for main gun: %1", _tmpArray];
while {_mainWeapon == ""} do {
	_weaponCandidate = selectRandom GRLIB_arsenal_carbines;
	diag_log format ["LOADOUTS: main gun candidate: %1", _weaponCandidate];
	if (_weaponCandidate in _tmpArray) then {_mainWeapon = _weaponCandidate};
	sleep 0.1;
};
diag_log format ["LOADOUTS: main gun winner: %1", _mainWeapon];

//two types of magazines for primary weapon for cases of GLs with lots of smoke grenades
_mainMags1 = selectRandom (getArray (configFile / "CfgWeapons" / _mainWeapon / "magazines"));
_mainMags2 = selectRandom ((getArray (configFile / "CfgWeapons" / _mainWeapon / "magazines")) - [_mainMags1]);

diag_log format ["LOADOUTS: magazines: %1, %2, %3", _mainMags1, _mainMags2];

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
_unit forceAddUniform "rhsgref_uniform_para_ttsko_oxblood";
for "_i" from 1 to 2 do {_unit addItemToUniform "ACE_fieldDressing";};
for "_i" from 1 to 2 do {_unit addItemToUniform "ACE_quikclot";};
_unit addItemToUniform "ACE_morphine";
for "_i" from 1 to 2 do {_unit addItemToUniform "HandGrenade";};
_unit addVest "rhs_6sh46";
_unit addItemToVest _mainMags1;
_unit addItemToVest _mainMags2;

_unit addHeadgear "rhs_tsh4_ess";
_unit addGoggles "G_Balaclava_oli";

comment "Add weapons";
_unit addWeapon _mainWeapon;

comment "Add items";
_unit linkItem "ItemMap";
_unit linkItem "ItemCompass";
_unit linkItem "ItemWatch";
_unit linkItem "ItemRadio";