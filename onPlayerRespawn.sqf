if (isNil "GRLIB_respawn_loadout") then {
    removeAllWeapons player;
    removeVest player;
    player unlinkItem "NVGoggles";
    removeHeadgear player;
} else {
    sleep 4;
    player setUnitLoadout GRLIB_respawn_loadout;
};
