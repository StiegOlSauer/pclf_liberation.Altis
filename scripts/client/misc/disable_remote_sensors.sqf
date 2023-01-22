if (GRLIB_remote_sensors == 0) exitWith {};

if (GRLIB_remote_sensors == 2) exitWith {
	if (!isServer && hasInterface) then {
		disableRemoteSensors true;
		diag_log "Remote sensors disabled";
	};
};

while {true} do {
	private _controlsAI = ({(local _x) && !(isPlayer _x)} count allUnits) > 0;
	disableRemoteSensors (_controlsAI && getRemoteSensorsDisabled);

	sleep 60;
};
