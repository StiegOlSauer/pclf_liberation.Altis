if ( isDedicated ) exitWith {};

params [ "_battlegroup_position" ];
_allLocations = ;
"opfor_bg_marker" setMarkerPosLocal ( getMarkerPos _battlegroup_position );
[ "lib_battlegroup", [ name ((nearestLocations [getMarkerPos _battlegroup_position, ["CBA_NamespaceDummy"], 10000] select {count (name _x) > 0}) select 0) ] ] call BIS_fnc_showNotification;

sleep 600;

"opfor_bg_marker" setMarkerPosLocal markers_reset;
