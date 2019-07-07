private ["_delay","_distance","_bodyLimit","_players","_a","_u","_t"];
_delay = _this select 0;
_distance = _this select 1;
_bodyLimit = _this select 2;

_players = (if ismultiplayer then { playableunits } else { switchableunits });

for "_i" from 0 to (count SHK_GraveDigger_Dead - (1 + _bodyLimit)) do {
  _a = SHK_GraveDigger_Dead select _i;
  _u = _a select 0; // unit
  _t = _a select 1; // time of death
  
  if (time - _t > _delay) then { // body has been on the ground long enough
    if ({((_x distance _u) <= _distance) && (isplayer _x)} count _players == 0) then { // no players around
      if (_u != vehicle _u) then {
        deletevehicle vehicle _u;
      };
      SHK_GraveDigger_HaveEH = SHK_GraveDigger_HaveEH - [_u];
      SHK_GraveDigger_Dead set [_i,0];
      deletevehicle _u;
    };
  };
};
SHK_GraveDigger_Dead = SHK_GraveDigger_Dead - [0];