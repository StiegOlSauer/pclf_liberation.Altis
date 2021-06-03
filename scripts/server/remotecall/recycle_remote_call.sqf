if (!isServer) exitWith {};

params [ "_object_recycled", "_price" ];

if ( isNull _object_recycled ) exitWith {};
if ( !(alive _object_recycled) ) exitWith {};

if ((typeOf _object_recycled) == ammocrate_o_typename && _price == 0) then {
   [] call PCLF_unlockEquipment;
};

// if ((typeOf _object_recycled) == ammocrate_o_typename) then {
// 	for [{_i=0}, {_i<GRLIB_guns_per_box}, {_i=_i+1}] do {
// 		_wpn = GRLIB_allowed_weapons deleteAt _i;
// 		GRLIB_whitelisted_from_arsenal pushBack _wpn;
// 	};
// };
// publicVariable "GRLIB_whitelisted_from_arsenal";

deleteVehicle _object_recycled;
if ( _price > 0 ) then {
	resources_ammo = resources_ammo + _price;
};
please_recalculate = true;
stats_vehicles_recycled = stats_vehicles_recycled + 1;
