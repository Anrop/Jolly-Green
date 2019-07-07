/*
  SHK_GraveDigger - Keep your hands clean, let us take care of the corpses.
  Author: Shuko (miika@miikajarvinen.fi, shuko@quakenet)
  Version 0.12
  
  This script automatically cleans up dead bodies.
  
  Features:
    - All units except playable units will be handled.
    - No parameters, init field execution, modules or synchronization needed.
    - Option to adjust removal delay and distance to players.
  
  Parameters (all optional):
    Delay        Time for corpses to lie on the ground before being removed. Default is 30s.
    DelayMargin  Time between checks. Default is 10s.
    Distance     Minimum distance to players to remove corpses. Default is 200m.
    BodyLimit    Number of corpses after which clean up is started. Default is 20.
    
  Examples:
    nul = execvm "SHK_GraveDigger\init.sqf"
    nul = [10,5] execvm "SHK_GraveDigger\init.sqf"
    nul = [60,10,300] execvm "SHK_GraveDigger\init.sqf"
    
  Known Issues:
    If vehicle is destroyed, but the driver manages to get out before dying, the empty vehicle will not be removed.
*/
/* for debugging
[] spawn {
  while {true} do {
    hintsilent format ["eh: %1\ngd: %2\nall: %3",count SHK_GraveDigger_HaveEH,count SHK_GraveDigger_Dead,count allunits];
    sleep 0.5;
  };
};
*/
if !isserver exitwith {};
private ["_delay","_delayMargin","_distance","_bodyLimit","_fsmEH","_fsmGD"];
_delay = if (count _this > 0) then {_this select 0} else {30};
_delayMargin = if (count _this > 1) then {_this select 1} else {10};
_distance = if (count _this > 2) then {_this select 2} else {200};
_bodyLimit = if (count _this > 3) then {_this select 3} else {20};

SHK_GraveDigger_Dead = [];
SHK_GraveDigger_HaveEH = [];

SHK_GraveDigger_fnc_addEventhandlers = compile preprocessfile "SHK_GraveDigger\SHK_GraveDigger_fnc_addEventhandlers.sqf";
SHK_GraveDigger_fnc_delete = compile preprocessfile "SHK_GraveDigger\SHK_GraveDigger_fnc_delete.sqf";

_fsmEH = execFSM "SHK_GraveDigger\shk_gravedigger_addeventhandlers.fsm";
_fsmGD = [_delay,_delayMargin,_distance,_bodyLimit] execFSM "SHK_GraveDigger\shk_gravedigger.fsm";