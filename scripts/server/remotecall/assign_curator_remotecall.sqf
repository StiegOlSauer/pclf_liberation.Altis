if (!isServer) exitWith {};
diag_log "REMOTECALL assign curator fired for JIP player";
if (!isNull commandant) then {
	unassignCurator blufor_curator;
	sleep 0.5;
	commandant assignCurator blufor_curator;
};