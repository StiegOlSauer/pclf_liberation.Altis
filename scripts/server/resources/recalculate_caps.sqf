base_infantry_cap = 50 * GRLIB_resources_multiplier;
base_fuel_cap = 20 * GRLIB_resources_multiplier;

infantry_cap = base_infantry_cap;
fuel_cap = base_fuel_cap;

{
    private _locType = [_x] call LP_getLocationType;
	if ( _locType in LP_locations_civilian ) then {
		infantry_cap = infantry_cap + (10 * GRLIB_resources_multiplier);
	};
	if ( _locType == LP_location_factory ) then {
		fuel_cap = fuel_cap + (20 * GRLIB_resources_multiplier);
	};
} foreach ([] call LP_getBLUFORLocations);

unitcap_respawns_limit = (25 * GRLIB_resources_multiplier) + (10 * (count GRLIB_all_fobs) * GRLIB_resources_multiplier);
