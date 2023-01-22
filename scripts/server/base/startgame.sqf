waitUntil { time > 1 };
waitUntil { !isNil "GRLIB_all_fobs" };
waitUntil { !isNil "save_is_loaded" };
waitUntil { !isNil "LP_locationsInitialized" };

private _fobbox = ObjNull;

if (count GRLIB_all_fobs == 0 && GRLIB_build_first_fob) then {
    private _pos = [
        nil,
        LP_allLocations,
        {
            (_this isFlatEmpty [6, -1, 0.8, 5, 0, false]) isNotEqualTo []
        }
    ] call BIS_fnc_randomPos;
    [_pos, true] remoteExec ["build_fob_remote_call", 2];
};
// TODO: Add fallback FOB location

while { count GRLIB_all_fobs == 0 } do { // FIXME: replace with eventhandler on FOB BOX
	if ( GRLIB_isAtlasPresent ) then {
		_fobbox = FOB_box_typename createVehicle [0,0,50];
		_fobbox enableSimulationGlobal false;
		_fobbox allowDamage false;
		_fobbox setposasl [(getpos lhd select 0) + 10, (getpos lhd select 1) + 62, (18.5   + (getposasl lhd select 2))];
		clearItemCargoGlobal _fobbox;
		_fobbox setDir 130;
		sleep 1;
		_fobbox enableSimulationGlobal true;
		_fobbox allowDamage true;
	} else {
		_fobbox = FOB_box_typename createVehicle (getpos base_boxspawn);
		_fobbox setpos (getpos base_boxspawn);
		_fobbox setdir 215;
	};

	[ [_fobbox, 3000 ] , "F_setMass" ] call BIS_fnc_MP;

	sleep 3;

	waitUntil {
		sleep 5;
		!(alive _fobbox) || count GRLIB_all_fobs > 0
	};

	sleep 15;
};

if !(isNull _fobbox) then {
    deleteVehicle _fobbox;
};
