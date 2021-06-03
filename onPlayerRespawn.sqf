if (isNil "GRLIB_respawn_loadout") then {
    removeAllWeapons player;
    removeVest player;
    player unlinkItem "NVGoggles";
    removeHeadgear player;
} else {
    player setUnitLoadout GRLIB_respawn_loadout;
};
