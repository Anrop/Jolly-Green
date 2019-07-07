// SHK_closestPlayer = compile preprocessfile "SHK_closestPlayer.sqf";
// obj1 call SHK_closestPlayer;
// [obj1,side] call SHK_closestPlayer;
private ["_o","_s","_p","_b"];
_o = _this;
_b = false;
if (typename _o == typename []) then {
  _s = _o select 1;
  _o = _o select 0;
  _b = true;
};
_p = objNull;
{
  if (alive _x && isplayer _x) then {
    if (_x distance _o < _x distance _p) then {
      if _b then {
        if (side _x == _s) then {
          _p = _x;
        };
      } else {
        _p = _x;
      };
    };
  };
} foreach (if ismultiplayer then {playableunits} else {switchableunits});
_p