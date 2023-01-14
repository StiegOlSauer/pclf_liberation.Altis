params ["_locationGroups", "_location"];
private ["_stateMachine"];

_locationGroups apply {
    _x setVariable ["LP_bound_location", _location];
};
_stateMachine = [_locationGroups, true] call CBA_statemachine_fnc_create;

[
    _stateMachine,
    {}, // onState - executes each time statemachine checks this group (approx every 1-2 seconds)
    {
        private _loc = _this getVariable "LP_bound_location";
        private _alert_level = [_loc, "alert"] call LP_getLocationProperty;
        (units _this) apply {
            private _sdist = _x skillFinal "spotDistance";
            private _stime = _x skillFinal "spotTime";
            _x setVariable ["LP_saved_skill", [_sdist, _stime]];
            _x setSkill ["spotDistance", (_sdist * (1 + _alert_level/100) * 0.2)];
            _x setSkill ["spotTime", (_stime * (1 + _alert_level/100) * 0.2)];
        };
    }, // onStateEntered
    {}, // onStateLeaving
    "Initial"
] call CBA_statemachine_fnc_addState;

[_stateMachine, {}, {
}, {}, "CommandDelayAlerted"] call CBA_statemachine_fnc_addState; // "Corridor" state between Initial and Alerted

[
    _stateMachine,
    {}, // onState - executes each time statemachine checks this location (approx every 2-3 seconds)
    {
        ((units _this) select {alive _x}) apply {
            (_x getVariable "LP_saved_skill") params ["_sdist", "_stime"];
            _x setSkill ["spotDistance", _sdist];
            _x setSkill ["spotTime", _stime];
        };
    }, // onStateEntered
    {}, // onStateLeaving
    "Alerted"
] call CBA_statemachine_fnc_addState;

/*
 * Transitions
 */

[
    _stateMachine,
    "Initial",
    "CommandDelayAlerted",
    {
        private _blufor = [];
        private _location = _this getVariable "LP_bound_location";
        (allGroups select {(side _x) == GRLIB_side_friendly && (leader _x) inArea _location}) apply {_blufor append ((units _x) select {alive _x})};
        _blufor findIf {(_this knowsAbout _x) > 0.2} != -1
    },
    {
        private _commanderMissingDelay = [60, 15] select ((alive (leader _this)) && ((rank (leader _this)) in ["LIEUTENANT", "SERGEANT"]));
        private _delay = 90 + _commanderMissingDelay - (0.45 * combat_readiness);
        _this setVariable ["LP_start_time", (time + _delay)];
    },
    "BLUFORSpotted"
] call CBA_statemachine_fnc_addTransition;

[
    _stateMachine,
    "CommandDelayAlerted",
    "Alerted",
    {
        time >= (_this getVariable "LP_start_time")
    },
    {},
    "LocationAlerted"
] call CBA_statemachine_fnc_addTransition;
