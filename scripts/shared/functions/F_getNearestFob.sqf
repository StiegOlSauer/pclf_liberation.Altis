params [ [ "_source_position", (getpos player) ] ];
private [ "_fobPos" ];

_fobPos = position locationNull;
GRLIB_all_fobs apply {
    _fobPos = [_fobPos, _x] select ((_source_position distance _fobPos) > (_source_position distance _x));
};

_fobPos
