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
_unit forceAddUniform "CUP_U_C_Rocker_03";
_unit addItemToUniform "ACE_morphine";
_unit addItemToUniform "ACE_Banana";
for "_i" from 1 to 2 do {_unit addItemToUniform "CUP_20Rnd_B_765x17_Ball_M";};
_unit addHeadgear "H_Bandanna_surfer_blk";

comment "Add weapons";
_unit addWeapon "CUP_hgun_SA61";
