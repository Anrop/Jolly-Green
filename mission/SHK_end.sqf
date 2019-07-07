if isserver then {
  while {isnil "SHK_End"} do {
    if (SHK_AllAboard && (heli distance heliWreck > 1000)) exitwith {SHK_End = 2}; // all players in the chopper
    if ({isplayer _x && alive _x} count playableunits < 1) exitwith {SHK_End = 3}; // all players dead
    if ((damage heli > 0.7) || (fuel heli == 0)) exitwith {SHK_End = 4}; // chopper broke down
    if ({isplayer _x && alive _x} count units gPilot < 1) exitwith {SHK_End = 5}; // pilots died
    if ({isplayer _x && alive _x} count units gInf < 1) exitwith {SHK_End = 6}; // infantry died
    sleep 3;
    SHK_AllAboard = (({alive _x && isplayer _x && vehicle _x == heli} count playableunits) == ({alive _x && isplayer _x} count playableunits));
  };
  switch SHK_End do {
    case 2: {
      ["CSAR","succeeded"] call SHK_Taskmaster_upd;
      ["EE","succeeded"] call SHK_Taskmaster_upd;
    };
    default {
      ["CSAR","failed"] call SHK_Taskmaster_upd;
      ["EE","failed"] call SHK_Taskmaster_upd;
    };
  };
  publicvariable "SHK_End";
  sleep 3;
};
waituntil {!isnil "SHK_End"};
sleep 3;
switch SHK_End do {
  case 1: { // restart missions, need players in both groups
    ["end1",false,2] call BIS_fnc_endMission;
  };
  case 2: { // missions completed
    "end2" call BIS_fnc_endMission;
  };
  default { // mission failed for one of many reasons
    sleep 3;
    private ["_msg","_h","_m","_s","_d"];
    _msg = "";
    _h = floor(time / 3600);
    _m = floor((time/60)-(_h*60));
    _s = floor(time mod 60);
    if (_h != 0) then { _msg = _msg + str _h; _msg = _msg + "h "; };
    if (_m != 0) then { _msg = _msg + str _m; _msg = _msg + "m "; };
    if (_s != 0) then { _msg = _msg + str _s; _msg = _msg + "s"; };
    _d = round( (leader gInf) distance heliWreck);
    cuttext [format["Survived: %1 (%2 meters)",_msg,_d],"Plain down"];
    sleep 3;
    ["end3",false,2] call BIS_fnc_endMission;
  };
};
