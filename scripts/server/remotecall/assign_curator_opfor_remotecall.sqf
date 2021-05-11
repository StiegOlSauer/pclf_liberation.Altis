if (!isServer) exitWith {};
diag_log "REMOTECALL assign OPFOR curator fired for JIP player";
if (!isNull opfor_commander) then {
	unassignCurator opfor_curator;
	sleep 0.5;
	opfor_commander assignCurator opfor_curator;
};