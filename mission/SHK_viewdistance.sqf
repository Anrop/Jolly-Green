private "_params";
_params = _this select 3;
if (typename _params == typename []) then {
  {
    player removeAction _x;
  } foreach _params;
  player removeAction (_this select 2);
} else {
  private "_vd";
  _vd = switch _params do {
    case 0: { viewdistance + 1000; };
    case 1: { viewdistance - 1000; };
  };
  setviewdistance _vd;
  hintsilent format ["Viewdistance: %1",_vd];
};