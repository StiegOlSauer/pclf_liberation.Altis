private ["_allLocations", "_stateMachine", "_tickValue", "_tickMax"];

_stateMachine = [LP_allLocations, true] call CBA_statemachine_fnc_create;
[
    _stateMachine,
    {}, // onState - executes each time statemachine checks this location (approx every 2-3 seconds)
    {
        diag_log format ["Location %1 is now OPFOR", name _this];
        if (_this getVariable ["LP_compositionSpawned", false]) then {
            private _comp = [_this] call LP_getLocationComposition;
            [locationPosition _this, _comp] call LP_removeComposition;
        };
        (_this getVariable ["LP_rooftopDefences", []]) apply {
            [locationPosition _this, _x] call LP_removeComposition;
        };
        [_this, "StaticWeapon"] call LP_removeObjectsByType;
    }, // onStateEntered
    {}, // onStateLeaving
    "OPFOR"
] call CBA_statemachine_fnc_addState;

[
    _stateMachine,
    {},
    {
        if !(_this getVariable ["LP_compositionSpawned", false]) then {
            private _comp = [_this] call LP_getLocationComposition;
            [locationPosition _this, _comp] call LP_placeComposition;
        };
        private _marker = createMarkerLocal [([_this] call LP_getLocationZoneMarker), locationPosition _this];
        _marker setMarkerColorLocal "ColorGrey";
        _marker setMarkerShapeLocal "Ellipse";
        _marker setMarkerBrushLocal "BDiagonal";
        _marker setMarkerSize [(size _this) # 0 / 2, (size _this) # 1 / 2];

        [_this] spawn {
            params ["_location"];
            for "_i" from 5 to 1 step -1 do {
                sleep _i;
                if ([locationPosition _location, [_location] call LP_getLocationMaxSize, GRLIB_side_friendly] call F_getUnitsCount == 0) exitWith {
                    ["LP_locationIsNotActive", [_location]] call CBA_fnc_serverEvent;
                };
            };
            if ([locationPosition _location, [_location] call LP_getLocationMaxSize, GRLIB_side_friendly] call F_getUnitsCount > 0) then {
                ["LP_locationSpawnConfirmed", [_location]] call CBA_fnc_serverEvent;
            };
        };
    },
    {},
    "activated"
] call CBA_statemachine_fnc_addState;

[
    _stateMachine,
    {}, // onState
    {
        private _marker = [_this] call LP_getLocationZoneMarker;
        _marker setMarkerColor GRLIB_color_enemy_bright;

        LP_active_locations pushBack _this;
        LP_active_markers pushBack [name _this, _marker];
        publicVariable "LP_active_markers";

        private _hc = [] call F_lessLoadedHC;
        if (isNull _hc) then {
            [_this] spawn activate_location;
        } else {
            [_this] remoteExec ["activate_location", _hc];
        };

        if ([_this] call LP_getLocationType in [LP_location_base_small, LP_location_base, LP_location_outpost]) then {
            [_this] call manage_ammoboxes;
        };
    }, // onStateEntered
    {
        LP_active_locations deleteAt (LP_active_locations find _this);
        LP_active_markers deleteAt (LP_active_markers findIf {(_x select 0) == name _this});
        publicVariable "LP_active_markers";
        deleteMarker ([_this] call LP_getLocationZoneMarker);
    }, // onStateLeaving
    "spawned"
] call CBA_statemachine_fnc_addState;

[_stateMachine, {}, {}, {}, "attackedOPFOR"] call CBA_statemachine_fnc_addState;
[_stateMachine, {}, {
    [_this, GRLIB_side_friendly] call LP_setLocationSide;
    ([_this] call LP_getLocationMarker) setMarkerColor GRLIB_color_friendly;
}, {}, "BLUFOR"] call CBA_statemachine_fnc_addState;

/*
 * Transitions
 */

// Direct transition for sectors loaded as BLUFOR from savegame
[
    _stateMachine,
    "OPFOR",
    "BLUFOR",
    {
        side _this == GRLIB_side_friendly
    },
    {},
    "savegameSetup"
] call CBA_statemachine_fnc_addTransition;

[
    _stateMachine,
    "OPFOR",
    "activated",
    {
        (([locationPosition _this, [_this] call LP_getLocationMaxSize, GRLIB_side_friendly] call F_getUnitsCount > 0))
    },
    {},
    "playersSpottedAtLocation"
] call CBA_statemachine_fnc_addTransition;

// Transitions for "activated" state
[_stateMachine, "activated", "spawned", ["LP_locationSpawnConfirmed"], {true}, {}, "locationAttackedByPlayers"] call CBA_statemachine_fnc_addEventTransition;
[_stateMachine, "activated", "OPFOR", ["LP_locationIsNotActive"], {true}, {deleteMarker ([_this] call LP_getLocationZoneMarker)}, "locationIsNoLongerActive"] call CBA_statemachine_fnc_addEventTransition;

// Transitions for "spawned" state
[_stateMachine, "spawned", "activated", ["LP_locationBLUFORDefeated"], {true}, {}, "bluforFleedFromLocation"] call CBA_statemachine_fnc_addEventTransition;
[_stateMachine, "spawned", "BLUFOR", ["LP_locationCapturedBLUFOR"], {true}, {
    diag_log format ["Location %1 is now BLUFOR", name _this];
    [_this] spawn sector_liberated_remote_call;
    if (_this getVariable ["LP_compositionSpawned", false]) then {
        private _comp = [_this] call LP_getLocationComposition;
        [locationPosition _this, _comp] call LP_removeComposition;
    };
    (_this getVariable ["LP_rooftopDefences", []]) apply {
        [locationPosition _this, _x] call LP_removeComposition;
    };
    [_this, "StaticWeapon"] call LP_removeObjectsByType;
}, "bluforCapturedLocation"] call CBA_statemachine_fnc_addEventTransition;
