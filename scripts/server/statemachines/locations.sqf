private ["_allLocations", "_stateMachine"];

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
    {}, // onStateLeaving
    "spawned"
] call CBA_statemachine_fnc_addState;

// resolving - waits until contested location falls into OPFOR or BLUFOR hands, manages cleanup and additional spawn
[
    _stateMachine,
    {
			private _defaultWaitTimer = 30;
			if ([_this, "contested"] call LP_isTimerExpired) then {
				private _locationSize = [_this] call LP_getLocationMaxSize;
				if (([locationPosition _this, _locationSize / 3] call F_sectorOwnership) == GRLIB_side_friendly) exitWith {
					((locationPosition _this) nearEntities [ ["Man"], _locationSize]) apply {[_x] spawn prisonner_ai};
					["LP_locationCapturedBLUFOR", [_location]] call CBA_fnc_serverEvent;
				};

				private _bluforNearLocation = [locationPosition _this, _locationSize, GRLIB_side_friendly] call F_getUnitsCount;
				if (_bluforNearLocation == 0 && {[_this, "cleanup"] call LP_isTimerExpired}) exitWith {
					["LP_locationBLUFORDefeated", [_this]] call CBA_fnc_serverEvent;
				};
				[_this, "contested", _defaultWaitTimer] call LP_setLocationTimer;
				[
				 _this, "cleanup",
				 (_defaultWaitTimer - 5 + (_bluforNearLocation * _defaultWaitTimer)),
				 (_bluforNearLocation * 10)
				] call LP_setLocationGreaterTimer;
			};
		}, // onState
    {
			[_this, "contested", 50] call LP_setLocationTimer;
			[_this, "cleanup", 90] call LP_setLocationTimer;
    }, // onStateEntered
    {
			[_this, "cleanup"] call LP_resetTimer;
			[_this, "contested"] call LP_resetTimer;
			LP_active_locations deleteAt (LP_active_locations find _this);
      LP_active_markers deleteAt (LP_active_markers findIf {(_x select 0) == name _this});
      publicVariable "LP_active_markers";
      deleteMarker ([_this] call LP_getLocationZoneMarker);

			[_this] spawn {
				params ["_location"];
				waitUntil {sleep 1;(allPlayers inAreaArray _location) isEqualTo []};

				([_location] call LP_getLocationSpawnedEntities) params ["_locationGroups", "_locationVehicles", "_locationCivs"];
				_locationCivs apply {deleteVehicle _x};
				_locationGroups apply {
					(units _x) apply {deleteVehicle _x};
				};

				 private _remainingVehs = [];
				 (_locationVehicles select {alive _x}) apply {_remainingVehs pushBack (typeOf _x)};
				 [_location, "vehicles", _remainingVehs] call LP_setLocationProperty;
				 _locationVehicles apply {[_x] call F_cleanOpforVehicle};
				 [_location, [], [], []] call LP_storeLocationSpawnedEntities;
			};
    }, // onStateLeaving
    "resolving"
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
[
 _stateMachine, "activated", "spawned", ["LP_locationSpawnConfirmed"], {true}, {}, "locationAttackedByPlayers"
] call CBA_statemachine_fnc_addEventTransition;

[
 _stateMachine,
 "activated",
 "OPFOR",
 ["LP_locationIsNotActive"],
 {true},
 {
	 deleteMarker ([_this] call LP_getLocationZoneMarker);
 },
 "locationIsNoLongerActive"
] call CBA_statemachine_fnc_addEventTransition;

// Transitions for "spawned" state
[_stateMachine, "resolving", "activated", ["LP_locationBLUFORDefeated"], {true}, {}, "bluforFleedFromLocation"] call CBA_statemachine_fnc_addEventTransition;

[
    _stateMachine,
    "spawned",
    "resolving",
    {true},
    {},
    "locationIsContested"
] call CBA_statemachine_fnc_addTransition;

[_stateMachine, "resolving", "BLUFOR", ["LP_locationCapturedBLUFOR"], {true}, {
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
