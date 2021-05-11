_unit = _this select 0;

private ["_mainWeapon", "_mainMags1", "_mainMags2", "_optics", "_opticsCompat", "_launcher", "_weaponCandidate", "_tmpArray"];

//Helpers
// Format of getted compatible optics config
//[bin\config.bin/CfgWeapons/hlc_g3_base/WeaponSlotsInfo/CowsSlot/compatibleItems/HLC_Optic_ZFSG1,bin\config.bin/CfgWeapons/hlc_g3_base/WeaponSlotsInfo/CowsSlot/compatibleItems/hlc_optic_accupoint_g3,bin\config.bin/CfgWeapons/hlc_g3_base/WeaponSlotsInfo/CowsSlot/compatibleItems/hlc_optic_PVS4G3]

//get all first optic slots for all weapons. Check that when integrating new addons
//allOptics = [];datVariable2 = "";{datVariable2 = (((format ["%1",(configProperties [configFile >> "CfgWeapons" >> _x >> "WeaponSlotsInfo" >> "CowsSlot" >> "compatibleItems"])]) splitString ",") select 0) splitString "/"; datVariable2 = datVariable2 select ((count datVariable2) - 1);allOptics append [datVariable2];} foreach GRLIB_whitelisted_from_arsenal;

//bring random weapon from unlocked
_weaponCandidate = "";
_mainWeapon = "";
_launcher = "";
_optics = "";
_tmpArray = GRLIB_whitelisted_from_arsenal - GRLIB_arsenal_aaSystems - GRLIB_arsenal_pistols - GRLIB_arsenal_launchers - GRLIB_arsenal_machineguns - GRLIB_arsenal_autoRifles - GRLIB_arsenal_sniperRifles - GRLIB_arsenal_marksmanRifles - GRLIB_arsenal_carbines - GRLIB_arsenal_specWeapons - GRLIB_arsenal_atSystems;

//diag_log format ["LOADOUTS: _tmpArray for main gun: %1", _tmpArray];
while {_mainWeapon == ""} do {
	_weaponCandidate = selectRandom GRLIB_arsenal_rifles;
	diag_log format ["LOADOUTS: main gun candidate: %1", _weaponCandidate];
	if (_weaponCandidate in _tmpArray) then {_mainWeapon = _weaponCandidate};
	sleep 0.1;
};
diag_log format ["LOADOUTS: main gun winner: %1", _mainWeapon];

if (15 > random 100) then {

	if (_mainWeapon in ["hlc_rifle_M14", "hlc_rifle_M14_Bipod", "hlc_rifle_m14dmr", "hlc_rifle_M21"]) then {
		_optics = selectRandom GRLIB_arsenal_opticsSniperM14;
		diag_log format ["LOADOUTS: going to attach optics: %1", _optics];
	} else {
		_opticsCompat = (((format ["%1",(configProperties [configFile >> "CfgWeapons" >> _mainWeapon >> "WeaponSlotsInfo" >> "CowsSlot" >> "compatibleItems"])]) splitString ",") select 0) splitString "/";
		_opticsCompat = _opticsCompat select ((count _opticsCompat) - 1);
		if (_opticsCompat == "CUP_optic_SB_3_12x50_PMII") then {_optics = selectRandom GRLIB_arsenal_opticsNATO};
		if (_opticsCompat == "HLC_Optic_PSO1") then {_optics = selectRandom GRLIB_arsenal_opticsAK};
		if (_opticsCompat == "HLC_Optic_ZFSG1") then {_optics = selectRandom GRLIB_arsenal_opticsG3};
		if (_opticsCompat == "hlc_optic_suit") then {_optics = "hlc_optic_suit"}; //HLC FALs have only one SUITable optics :(
		if (_opticsCompat == "rhs_acc_pso1m2") then {_optics = "rhs_acc_pso1m2"}; //for AS VAL and VSS
		diag_log format ["LOADOUTS: going to attach optics: %1", _optics];
	};
};

_tmpArray = GRLIB_whitelisted_from_arsenal - GRLIB_arsenal_aaSystems - GRLIB_arsenal_pistols - GRLIB_arsenal_machineguns - GRLIB_arsenal_autoRifles - GRLIB_arsenal_sniperRifles - GRLIB_arsenal_marksmanRifles - GRLIB_arsenal_carbines - GRLIB_arsenal_rifles - GRLIB_arsenal_specWeapons - GRLIB_arsenal_atSystems;

while {_launcher == ""} do {
	_weaponCandidate = selectRandom GRLIB_arsenal_launchers;
	diag_log format ["LOADOUTS: launcher candidate: %1", _weaponCandidate];
	if (_weaponCandidate in _tmpArray) then {_launcher = _weaponCandidate};
	sleep 0.1;
};
diag_log format ["LOADOUTS: launcher winner: %1", _launcher];

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
_unit forceAddUniform "LOP_U_US_Fatigue_02";
for "_i" from 1 to 2 do {_unit addItemToUniform "ACE_fieldDressing";};
for "_i" from 1 to 2 do {_unit addItemToUniform "ACE_quikclot";};
_unit addItemToUniform "ACE_morphine";
for "_i" from 1 to 2 do {_unit addItemToUniform "HandGrenade";};
_unit addVest "rhsgref_otv_khaki";
for "_i" from 1 to 3 do {_unit addItemToVest _mainMags1;};
for "_i" from 1 to 2 do {_unit addItemToVest _mainMags2;};

_unit addHeadgear "LOP_H_6B27M_ess_CDF";

comment "Add weapons";
_unit addWeapon _mainWeapon;
_unit addPrimaryWeaponItem _optics;
_unit addWeapon _launcher;

comment "Add items";
_unit linkItem "ItemMap";
_unit linkItem "ItemCompass";
_unit linkItem "ItemWatch";
_unit linkItem "ItemRadio";