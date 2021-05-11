// convoyDefend_init.sqf
// © MARCH 2010 - norrin
if (!isServer) exitWith {};

_markerArray = _this select 0;
_convoyArray = _this select 1;
_waypointMarker = _this select 2;
_convoyVclDestroyed = false;
_marker = _markerArray select 0;
_leadVcl = _convoyArray select 0;
_suv = _convoyArray select 1;
_groups = [];
_b = 0;
_c = 0;

{
	(driver _x) setSpeedMode "LIMITED";
	(driver _x) setBehaviour "SAFE";
	_x doMove _marker;
	[_x, _convoyArray, _c] spawn convoy_setFormation; 
	_c = _c + 1;
 } forEach _convoyArray;

_convoyVclDestroyed = false;

while {(!_convoyVclDestroyed) && !(GRLIB_revengeConvoySpawnExit)} do
{
  //hintSilent format ["lead: %1 \ndestination: %2", _leadVcl, _marker];
  {if (!canMove _x) then {_convoyVclDestroyed = true}}forEach _convoyArray;
  if (_leadVcl distance _marker < 10 && _b < (count _markerArray - 1)) then 
  {	
		_b = _b + 1;
		_marker = _markerArray select _b;
		{_x doMove _marker} forEach _convoyArray;
  };
  sleep 1;
};

if (GRLIB_revengeConvoySpawnExit) exitWith {diag_log "REVENGE: exiting convoy control script.";};
{if (canMove _x) then {_x doMove getPos _x}} forEach _convoyArray;

{
  diag_log "REVENGE: GetOut actions started for one vehicle";
  GRLIB_revengeAttacked = true;
  _vcl = _x;
  if ((canMove _vcl) && (_vcl != _suv)) then {
	diag_log "REVENGE: not SUV, bailing out.";
	doStop _vcl;
    _groups = _groups + [(group _vcl)];
    _crew = crew _vcl;
    waitUntil {speed _vcl < 2};
    for [{ _loop1 = 0 },{ _loop1 < count _crew},{ _loop1 = _loop1 + 1}] do {
      _unit = _crew select _loop1;
      if ((_unit != gunner _vcl)) then
      {
		_unit leaveVehicle _vcl;
        sleep 0.2;
      } else {
        _unit assignAsGunner _vcl;
      };
      sleep 0.1;
    };
  };
  if ((canMove _vcl) && (_vcl == _suv)) then {
	sleep 5;
	(driver _vcl) setSpeedMode "FULL";
	_vcl doMove (getMarkerPos _waypointMarker);
	diag_log format ["REVENGE: SUV waypoint set to %1.", (getMarkerPos _waypointMarker)];
	(driver _vcl) setSpeedMode "FULL";
	diag_log "REVENGE: SUV is routing to base at full speed!";
	[_suv] spawn {
		params ["_suv"];
		while {(canMove _suv) && (_suv distance (getMarkerPos _waypointMarker)) > 100} do {
			sleep 5;
			_suv doMove (getMarkerPos _waypointMarker);
		};
	};
  };	
  sleep 0.1;
} forEach _convoyArray;
sleep 1;
//{_x setBehaviour "COMBAT"} forEach _groups;
