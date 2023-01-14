if ( isDedicated ) exitWith {};

if ( isNil "sector_timer" ) then { sector_timer = 0 };

params [ "_sector", "_status" ];

if ( _status == 0 ) then {
	[ "lib_sector_captured", [ _sector ] ] call BIS_fnc_showNotification;
};

if ( _status == 1 ) then {
	[ "lib_sector_attacked", [ _sector ] ] call BIS_fnc_showNotification;
// 	"opfor_capture_marker" setMarkerPosLocal ( position _sector );
	sector_timer = GRLIB_vulnerability_timer;
};

if ( _status == 2 ) then {
	[ "lib_sector_lost", [ _sector ] ] call BIS_fnc_showNotification;
// 	"opfor_capture_marker" setMarkerPosLocal markers_reset;
	sector_timer = 0;
};

if ( _status == 3 ) then {
	[ "lib_sector_safe", [ _sector ] ] call BIS_fnc_showNotification;
// 	"opfor_capture_marker" setMarkerPosLocal markers_reset;
	sector_timer = 0;
};
