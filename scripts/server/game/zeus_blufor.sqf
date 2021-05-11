/*
Zeus classnames:
===CR65-:
Misc: "A3_Weapons_F_Explosives", "A3_Modules_F_Curator_Curator",
Men: "CUP_Creatures_Military_SLA", "lop_faction_sla", "rhs_cti_insurgents",
Wheeled: "CUP_WheeledVehicles_BRDM2", "CUP_WheeledVehicles_Datsun", "CUP_WheeledVehicles_Dingo", "CUP_WheeledVehicles_HMMWV", "CUP_WheeledVehicles_LR","CUP_WheeledVehicles_UAZ", "CUP_WheeledVehicles_Ural", "rhsusf_hmmwv",
APC: "rhs_c_btr",
Static: "rhs_c_heavyweapons",

===CR65+:
Men: "CUP_Creatures_Military_SLA", "lop_faction_sla", "rhs_cti_insurgents",
Air: "CUP_AirVehicles_UH60", "CUP_AirVehicles_AV8B", "CUP_AirVehciles_AH1Z", "CUP_AirVehciles_UH1Y", "CUP_AirVehicles_UH1H",
APC: "CUP_TrackedVehicles_M113", "CUP_WheeledVehicles_Stryker", "CUP_WheeledVehicles_LAV25", "rhsusf_m113", "RHS_US_A2Port_Armor",
Wheeled: "rhsusf_hmmwv", "CUP_WheeledVehicles_HMMWV", "CUP_WheeledVehicles_RG31",
Tank: "rhsusf_m1a1", "rhsusf_m1a2",
Arty: "rhsusf_c_m109", "A3_Static_F_Mortar_01",
Static: "rhsusf_c_statics"
*/

waitUntil { !isNil "huron_typename" };
private ["_vehicleClassnames", "_ieds", "_zeusunits", "_units_to_remove", "_bluforEditingAreas", "_previousAmountOfAreas"];

_vehicleClassnames = [];
_ieds = ["IEDLandBig_F","IEDLandSmall_F","IEDUrbanBig_F","IEDUrbanSmall_F"];

waituntil {sleep 0.5; alive blufor_curator};
//waituntil {sleep 0.5; !isNull commandant};

//blufor_curator addEventHandler ["CuratorObjectPlaced",{GRLIB_curatorUnitSpawned = _this select 1;publicVariable "GRLIB_curatorUnitSpawned";}];
//blufor_curator addEventHandler ["CuratorObjectSelectionChanged",{GRLIB_curatorMenu = _this select 1;publicVariable "GRLIB_curatorMenu";}];

//[-1, {player globalChat _this}, "TEST"] call CBA_fnc_globalExecute;
//blufor_curator addEventHandler ["CuratorObjectPlaced",{diag_log "loadout EH fired on server";[0,{diag_log "loadout EH fired";[_this] spawn F_curatorBluforLoadout}, _this select 1] call CBA_fnc_globalExecute;}];
//blufor_curator addEventHandler ["CuratorObjectSelectionChanged",{diag_log "menu EH fired on server";[0,{diag_log "menu EH fired";[_this] spawn uav_open_build_menu}, _this select 1] call CBA_fnc_globalExecute;}];

//blufor_curator addEventHandler ["CuratorObjectPlaced",{[_this select 1] remoteExec ["F_curatorBluforLoadout",0]}];
//blufor_curator addEventHandler ["CuratorObjectPlaced",{[_this select 1] spawn remote_call_zeusGearSelect}];
//blufor_curator addEventHandler ["CuratorObjectPlaced",{[_this select 1] spawn F_curatorBluforLoadout}];
//blufor_curator addEventHandler ["CuratorObjectSelectionChanged",{[_this select 1] spawn uav_open_build_menu}];
//blufor_curator addEventHandler ["CuratorObjectSelectionChanged",{[_this select 1] remoteExec ["uav_open_build_menu",0]}];

sleep 1;

blufor_curator addCuratorCameraArea [1, getMarkerPos "respawn_west", 20000];

removeAllCuratorAddons blufor_curator;
blufor_curator addCuratorAddons ["A3_Modules_F_Curator", "A3_Modules_F_Curator_Curator", "A3_Modules_F_Curator_Chemlights", "A3_Modules_F_Curator_Flares", "A3_Modules_F_Curator_Misc", "A3_Modules_F_Curator_Smokeshells", "rhsusf_c_troops"];//rhsusf_c_troops A3_Characters_F , "rhsusf_infantry", "rhsusf_infantry2" A3_Characters_F_BLUFOR
//blufor_curator addCuratorAddons ["A3_Modules_F_Curator", "A3_Modules_F_Curator_Curator", "A3_Modules_F_Curator_CAS", "A3_Modules_F_Curator_Animals", "A3_Modules_F_Curator_Chemlights", "A3_Modules_F_Curator_Effects", "A3_Modules_F_Curator_Environment", "A3_Modules_F_Curator_Flares", "A3_Modules_F_Curator_Intel", "A3_Modules_F_Curator_Misc", "A3_Modules_F_Curator_Multiplayer", "A3_Modules_F_Curator_Objectives", "A3_Modules_F_Curator_Ordnance", "A3_Modules_F_Curator_Respawn", "A3_Modules_F_Curator_Smokeshells", "rhsusf_c_troops"];//rhsusf_c_troops A3_Characters_F , "rhsusf_infantry", "rhsusf_infantry2" A3_Characters_F_BLUFOR
blufor_curator addCuratorPoints 1;
removeAllCuratorEditingAreas blufor_curator;

blufor_curator  setCuratorCoef ["place", 0];
blufor_curator  setCuratorCoef ["edit", 0];
blufor_curator  setCuratorCoef ["synchronize", 0];
blufor_curator  setCuratorCoef ["delete", 0];
blufor_curator  setCuratorCoef ["destroy", 0];

_bluforEditingAreas = [];
_previousAmountOfAreas = 0;
{
	_vehicleClassnames = _vehicleClassnames + [_x select 0];
} foreach (light_vehicles + heavy_vehicles + air_vehicles + static_vehicles + support_vehicles) ;

waitUntil {!isNull (getAssignedCuratorUnit blufor_curator)};

while {true} do {

	waitUntil {sleep 0.5; alive blufor_curator};
	
	_zeusunits = [];
	{
		if (side _x == WEST ) then {
			{
				if (alive _x) then {_zeusunits pushback _x;};
			} foreach (units _x);
		};
	} foreach allGroups;	

	{
		if ((typeof _x in _vehicleClassnames) && (alive _x) && (count (crew _x) == 0)) then {
			_zeusunits pushback _x;
		};
		
		if ((typeof _x in _vehicleClassnames) && (count (crew _x) > 0) && alive _x ) then {
			_crew = crew _x;
			if ((side (_crew select 0) == west)) then {
				_zeusunits pushback _x;
			};
		};
		
		if (!(typeof _x in _vehicleClassnames) && alive _x ) then {
			_crew = crew _x;
			if ((side (_crew select 0) == west)) then {
				_zeusunits pushback _x;
			};
		};
		
		if (typeof _x == FOB_typename) then {_zeusunits pushback _x;};
		
	} foreach vehicles;
	
	{
		_zeusunits append [nearestObject [_x, FOB_typename]];
	} foreach GRLIB_all_fobs;
	
	
	_zeusunits = _zeusunits - (curatorEditableObjects blufor_curator) - [getAssignedCuratorUnit blufor_curator];

	_units_to_remove = [];
	{
		if ( !(alive _x) ) then {
			_units_to_remove pushback _x;
		};
	} foreach (curatorEditableObjects blufor_curator);

	blufor_curator addCuratorEditableObjects [_zeusunits,true];
	blufor_curator removeCuratorEditableObjects [_units_to_remove,true];
	
	if (unitcap <=10) then {
		blufor_curator  setCuratorCoef ["place", -1e8];
	} else {
		blufor_curator  setCuratorCoef ["place", 0];
	};
	
	{
		_bluforEditingAreas append [(getPos _x)];
	} foreach (call F_getMobileRespawns);
	
	_bluforEditingAreas append GRLIB_all_fobs;
	
	_i = 0;
	{
		blufor_curator addCuratorEditingArea [_i, _x, 100];
		_i = _i + 1;
	} foreach _bluforEditingAreas;	
	
	if (_previousAmountOfAreas > _i) then {
		for [{_j=_previousAmountOfAreas},{_j>_i},{_j=_j-1}] do {
			blufor_curator removeCuratorEditingArea _j;
		};
	};
	_previousAmountOfAreas = _i;
	
	blufor_curator  setCuratorCoef ["edit", 0];
	sleep 10;
};
