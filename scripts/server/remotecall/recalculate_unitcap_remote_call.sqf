if (!isServer) exitWith {};

_localUnitcap = unitcap - 1;

if (_localUnitcap >= 0) then {
	unitcap = _localUnitcap;
} else {
	unitcap = 0;
};