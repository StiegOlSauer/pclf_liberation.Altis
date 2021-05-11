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

//_vehicleClassnames = [huron_typename];
private ["_vehicleClassnames", "_ieds", "_curator_addons_set", "_curator_addons_want", "_zeusunits", "_units_to_remove"];
_vehicleClassnames = [];
_ieds = [ "IEDLandBig_F","IEDLandSmall_F","IEDUrbanBig_F","IEDUrbanSmall_F" ];

waituntil {sleep 0.3; alive opfor_curator};

//opfor_curator = allCurators select 0;
opfor_curator addEventHandler [
	"CuratorObjectRegistered",
	{
		_classes = _this select 1;
		_costs = [];
		{
			_cost = [false,0];
			if (_x isKindOf "Man") then {_cost = [true,1]};
			if (_x isKindOf "Tank") then {_cost = [true,10]};
			if ((_x isKindOf "rhsusf_m113tank_base") || (_x isKindOf "CUP_M113_Base")) then {_cost = [true,5]};
			if (_x isKindOf "Car") then {_cost = [true,2.5]};
			if ((_x isKindOf "Wheeled_APC") || (_x isKindOf "CUP_BRDM2_Base") || (_x isKindOf "rhs_btr_base")) then {_cost = [true,5]};
			if (_x isKindOf "Helicopter") then {_cost = [true,15]};
			if ((_x isKindOf "CUP_BM21_Base") || (_x isKindOf "RHS_BM21_MSV_01")) then {_cost = [true,15]};
			if (_x isKindOf "Plane") then {_cost = [true,20]};
			_costs = _costs + [_cost];
		} forEach _classes;
		_costs
	}
];

sleep 1;

removeAllCuratorAddons opfor_curator;
opfor_curator addCuratorAddons ["A3_Modules_F_Curator", "A3_Modules_F_Curator_Curator", "A3_Modules_F_Curator_Chemlights", "A3_Modules_F_Curator_Flares", "A3_Modules_F_Curator_Misc", "A3_Modules_F_Curator_Smokeshells", "CUP_Creatures_Military_SLA", "CUP_WheeledVehicles_BRDM2", "CUP_WheeledVehicles_Datsun", "CUP_WheeledVehicles_Dingo", "CUP_WheeledVehicles_HMMWV", "CUP_WheeledVehicles_LR","CUP_WheeledVehicles_UAZ", "CUP_WheeledVehicles_Ural", "rhsusf_hmmwv", "rhs_c_heavyweapons"];
opfor_curator addCuratorPoints 1;
removeAllCuratorEditingAreas opfor_curator;

opfor_curator  setCuratorCoef ["place", -1];
opfor_curator  setCuratorCoef ["edit", 0];
opfor_curator  setCuratorCoef ["synchronize", 0];
opfor_curator  setCuratorCoef ["delete", 1];
opfor_curator  setCuratorCoef ["destroy", 0];

_curator_addons_set = 1;
_curator_addons_want = 1;

editingMarker1 = createMarker ["editingMarker1", [0,0,0]];
editingMarker2 = createMarker ["editingMarker2", [0,0,0]];
editingMarker3 = createMarker ["editingMarker3", [0,0,0]];

editingMarkers = [editingMarker1, editingMarker2, editingMarker3];

{
	_vehicleClassnames = _vehicleClassnames + [_x select 0];
} foreach (light_vehicles + heavy_vehicles + air_vehicles + static_vehicles + support_vehicles) ;

while {true} do {

	waitUntil {sleep 0.5; alive opfor_curator};
	
	_zeusunits = [];
	{
		if ((side _x == EAST) || (side _x == resistance)) then {
			{
				if (alive _x) then {_zeusunits pushback _x;};
			} foreach (units _x);
		};
	} foreach allGroups;
	
	{
		if ((!(typeof _x in _vehicleClassnames) || (typeof _x in _ieds)) && (typeof _x != ammobox_o_typename) && alive _x ) then {
			_crew = crew _x;
			if !(side (_crew select 0) == west) then {
				_zeusunits pushback _x;
			};
			if (typeof _x in _ieds) then {
				_zeusunits pushback _x;
			};
		};
	} foreach vehicles;

//	_zeusunits = _zeusunits + switchableUnits;
//	_zeusunits = _zeusunits + playableUnits;
	_zeusunits = _zeusunits - (curatorEditableObjects opfor_curator);

	_units_to_remove = [];
	{
		if ( !(alive _x) ) then {
			_units_to_remove pushback _x;
		};
	} foreach (curatorEditableObjects opfor_curator);

	opfor_curator addCuratorEditableObjects [_zeusunits,true];
	opfor_curator removeCuratorEditableObjects [_units_to_remove,true];
	
	if (combat_readiness <= 10) then {
		opfor_curator setCuratorCoef ["place", -1e8];		
		_curator_addons_want = 1;			
	};
	if ((combat_readiness > 10) && (combat_readiness <= 25)) then {
		opfor_curator  setCuratorCoef ["place", -0.25];
		opfor_curator  setCuratorCoef ["delete", 0.25];
		opfor_curator  setCuratorCoef ["destroy", 0.25];
		_curator_addons_want = 1;			
	};
	if ((combat_readiness > 25) && (combat_readiness <= 45)) then {
		opfor_curator  setCuratorCoef ["place", -0.15];
		opfor_curator  setCuratorCoef ["delete", 0.15];
		opfor_curator  setCuratorCoef ["destroy", 0.15];
		_curator_addons_want = 1;			
	};
	if ((combat_readiness > 45) && (combat_readiness < 65)) then {
		opfor_curator  setCuratorCoef ["place", -0.1];
		opfor_curator  setCuratorCoef ["delete", 0.1];
		opfor_curator  setCuratorCoef ["destroy", 0.1];
		_curator_addons_want = 1;			
	};
	if ((combat_readiness >= 65) && (combat_readiness <= 85)) then {
		opfor_curator  setCuratorCoef ["place", -0.075];
		opfor_curator  setCuratorCoef ["delete", 0.075];
		opfor_curator  setCuratorCoef ["destroy", 0.075];
		_curator_addons_want = 2;			
	};
	if ((combat_readiness > 85) && (combat_readiness < 100)) then {
		opfor_curator  setCuratorCoef ["place", -0.05];
		opfor_curator  setCuratorCoef ["delete", 0.05];
		opfor_curator  setCuratorCoef ["destroy", 0.05];
		_curator_addons_want = 2;			
	};
	if (combat_readiness >= 100) then {
		opfor_curator setCuratorCoef ["place", -0.025];
		opfor_curator  setCuratorCoef ["delete", 0.025];
		opfor_curator  setCuratorCoef ["destroy", 0.025];
		_curator_addons_want = 2;			
	};
	
	if (_curator_addons_set != _curator_addons_want) then {
		switch (_curator_addons_want) do {
			case 1: {
				removeAllCuratorAddons opfor_curator;
				opfor_curator addCuratorAddons ["A3_Modules_F_Curator", "A3_Modules_F_Curator_Curator", "A3_Modules_F_Curator_Chemlights", "A3_Modules_F_Curator_Flares", "A3_Modules_F_Curator_Misc", "A3_Modules_F_Curator_Smokeshells", "CUP_Creatures_Military_SLA", "CUP_WheeledVehicles_BRDM2", "CUP_WheeledVehicles_Datsun", "CUP_WheeledVehicles_Dingo", "CUP_WheeledVehicles_HMMWV", "CUP_WheeledVehicles_LR","CUP_WheeledVehicles_UAZ", "CUP_WheeledVehicles_Ural", "rhsusf_hmmwv", "rhs_c_heavyweapons"];
				_curator_addons_set = _curator_addons_want;
			};
			case 2: {
				removeAllCuratorAddons opfor_curator;
				opfor_curator addCuratorAddons ["A3_Modules_F_Curator", "A3_Modules_F_Curator_Curator", "A3_Modules_F_Curator_Chemlights", "A3_Modules_F_Curator_Flares", "A3_Modules_F_Curator_Misc", "A3_Modules_F_Curator_Smokeshells", "CUP_Creatures_Military_SLA", "CUP_WheeledVehicles_BRDM2", "CUP_WheeledVehicles_Datsun", "CUP_WheeledVehicles_Dingo", "CUP_WheeledVehicles_HMMWV", "CUP_WheeledVehicles_LR","CUP_WheeledVehicles_UAZ", "CUP_WheeledVehicles_Ural", "rhsusf_hmmwv", "rhs_c_heavyweapons", "CUP_AirVehicles_UH60", "CUP_AirVehicles_AV8B", "CUP_TrackedVehicles_M113", "CUP_WheeledVehicles_Stryker", "CUP_WheeledVehicles_LAV25", "rhsusf_m113", "RHS_US_A2Port_Armor", "CUP_WheeledVehicles_RG31", "rhsusf_m1a1", "rhsusf_m1a2", "rhsusf_c_m109", "A3_Static_F_Mortar_01", "rhsusf_c_statics", "CUP_AirVehciles_AH1Z", "CUP_AirVehciles_UH1Y", "CUP_AirVehicles_UH1H"];
				_curator_addons_set = _curator_addons_want;
			};
		};
	};
	
	
	if ((count active_sectors) == 0) then {
		editingMarker1 setMarkerPos [0,0,0];
		editingMarker2 setMarkerPos [0,0,0];
		editingMarker3 setMarkerPos [0,0,0];
	};
	
	if ((count active_sectors) == 1) then {
		editingMarker1  setMarkerPos (markerpos (active_sectors select 0));
		editingMarker2 setMarkerPos [0,0,0];
		editingMarker3 setMarkerPos [0,0,0];
	};
	
	if ((count active_sectors) == 2) then {
		editingMarker1  setMarkerPos (markerpos (active_sectors select 0));
		editingMarker2  setMarkerPos (markerpos (active_sectors select 1));
		editingMarker3 setMarkerPos [0,0,0];
	};
	
	if ((count active_sectors) >= 3) then {
		editingMarker1  setMarkerPos (markerpos (active_sectors select 0));
		editingMarker2  setMarkerPos (markerpos (active_sectors select 1));
		editingMarker3  setMarkerPos (markerpos (active_sectors select 2));
	};
	
	opfor_curator addCuratorEditingArea [1,getMarkerPos editingMarker1,250];
	opfor_curator addCuratorEditingArea [2,getMarkerPos editingMarker2,250];
	opfor_curator addCuratorEditingArea [3,getMarkerPos editingMarker3,250];
	
	sleep 20;
};