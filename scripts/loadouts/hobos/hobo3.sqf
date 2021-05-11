_unit = _this select 0;

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
_unit forceAddUniform "U_I_C_Soldier_Bandit_4_F";
_unit addItemToUniform "ACE_morphine";
_unit addItemToUniform "ACE_Banana";
for "_i" from 1 to 4 do {_unit addItemToUniform "rhsusf_5Rnd_00Buck";};
_unit addGoggles "G_Squares_Tinted";

comment "Add weapons";
_unit addWeapon "rhs_weap_M590_5RD";
