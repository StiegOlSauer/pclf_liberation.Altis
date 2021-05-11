private [ "_maxdist", "_truepos", "_built_object_remote", "_pos", "_grp", "_classname", "_idx", "_unitrank", "_posfob", "_ghost_spot", "_vehicle", "_dist", "_actualdir", "_near_objects", "_near_objects_25", "_debug_colisions" ];

build_confirmed = 0;
_maxdist = GRLIB_fob_range;
_truepos = [];
_debug_colisions = false;

if (isNil "manned") then { manned = false };
if (isNil "gridmode" ) then { gridmode = 0 };
if (isNil "repeatbuild" ) then { repeatbuild = false };
if (isNil "build_rotation" ) then { build_rotation = 0 };

waitUntil { sleep 1; !isNil "dobuild" };

while { true } do {
	waitUntil { sleep 1; dobuild != 0 };

	_classname = "";
	_classname = ((build_lists select buildtype) select buildindex) select 0;
	_price = ((build_lists select buildtype) select buildindex) select 2;
	[ [ _price, _classname, buildtype ] , "build_remote_call" ] call BIS_fnc_MP;	

	_posfob = getpos GRLIB_chosenFOB;	
		
		sleep 0.5;
		_truepos = (getpos GRLIB_chosenFOB) findEmptyPosition [5, 125, _classname];
		_vehicle = _classname createVehicle _truepos;
		_vehicle allowDamage false;			
		_vehicle setpos _truepos;
		clearWeaponCargoGlobal _vehicle;
		clearMagazineCargoGlobal _vehicle;
		clearItemCargoGlobal _vehicle;
		clearBackpackCargoGlobal _vehicle;
		if ((typeOf _vehicle) == "B_Truck_01_Repair_F") then {
			//["ACE_Track", _vehicle] call ace_cargo_fnc_addCargoItem;
			//["AddCargoByClass", ["ACE_Track", _vehicle, 5]] call ace_common_fnc_localEvent;
			//["AddCargoByClass", ["ACE_Wheel", _vehicle, 5]] call ace_common_fnc_localEvent;
		};
		if ( buildtype == 6 || buildtype == 99 ) then {
			_vehicle setVectorUp [0,0,1];
		} else {
			_vehicle setVectorUp surfaceNormal position _vehicle;
		};
				if ( _classname == FOB_box_typename ) then {
			[ [_vehicle, 3000 ] , "F_setMass" ] call BIS_fnc_MP;
		};
		sleep 1;
		_vehicle allowDamage true;
		_vehicle setDamage 0;
		if(buildtype != 6) then {
			_vehicle addMPEventHandler ["MPKilled", {_this spawn kill_manager}];
		};	
	dobuild = 0;
	blufor_curator addCuratorEditableObjects [[_vehicle],true];
//	[_vehicle, true] remoteExec ["blufor_curator addCuratorEditableObjects",2];
	manned = false;
};
