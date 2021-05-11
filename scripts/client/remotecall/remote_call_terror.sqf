if ( isDedicated ) exitWith {};

//if ( isNil "sector_timer" ) then { sector_timer = 0 };

params [ "_sector" ];

[ "lib_sector_terror", [ markerText _sector ] ] call BIS_fnc_showNotification;
//"opfor_capture_marker" setMarkerPosLocal ( markerpos _sector );

{ _x setMarkerColorLocal "ColorOPFOR"; } foreach (sectors_allSectors - blufor_sectors);
{ _x setMarkerColorLocal "ColorBLUFOR"; } foreach blufor_sectors;