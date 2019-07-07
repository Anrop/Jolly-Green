/*
  SHK_paraTroops
  
  Version 0.1
  Author: Shuko (shuko@quakenet, miika@miikajarvinen.fi)
  
  Syntax:
    nul = targetPosOrObject execvm "SHK_paraTroops.sqf";
    
*/

if (!isServer) exitWith {};

_fnc_closestPlayer = {
  private ["_o","_s","_p"];
  _o = _this;
  _p = objNull;
  {
    if (alive _x && isplayer _x && !(vehicle _x isKindOf "Air")) then {
      if (_x distance _o < _x distance _p) then {
        _p = _x;
      };
    };
  } foreach (if ismultiplayer then {playableunits} else {switchableunits});
  _p
};

private ["_pos","_dir","_chute","_dest","_transport","_transportGrp","_wp","_grp"];

_dest = _this;
if (typename _dest == typename objNull) then { _dest = getpos _dest; };

_pos = [_dest, 2200, random 360] call BIS_fnc_relPos;
_dir = [_pos,_dest] call BIS_fnc_dirTo;

_transport = [_pos,0,"O_Heli_Light_02_unarmed_F",EAST] call BIS_fnc_spawnVehicle;
_transportGrp = (_transport select 2);
_transport = _transport select 0;
{_x setBehaviour "CARELESS"; _x flyinHeight 60;} forEach units _transportGrp;

_transportGrp move _dest;

_grp = [_pos, EAST, (configfile >> "CfgGroups" >> "EAST" >> "OPF_F" >> "Infantry" >> "OIA_InfSquad"),[],[],[0.25,0.4]] call BIS_fnc_spawnGroup;
{_x MoveInCargo _transport; _x assignasCargo _transport} forEach units _grp;

_dest = getpos (_transport call _fnc_closestPlayer);
while {_dest distance _transport > 400} do {
  _dest = getpos (_transport call _fnc_closestPlayer);
  sleep 2;
};

// Initial Drop
{
  unAssignVehicle _x; 
  _x allowDamage false; 
  moveOut _x; 
  sleep 0.35; 
  _chute = createVehicle ["NonSteerable_Parachute_F", (getPos _x), [], 0, "NONE"];
  _chute setPos (getPos _x);
  _x moveinDriver _chute;
  _x allowDamage true;
  sleep 0.5;
} forEach units _grp;
 
_transportGrp move _pos;

// CleanUp
[_transport,_transportGrp,_dest] spawn {
  private ["_transport","_transportGrp","_dest","_i"];
  _transport = _this select 0;
  _transportGrp = _this select 1;
  _dest = _this select 2;
  _i = 0;
  waitUntil {sleep 1;_i = _i + 1; ((getpos _transport) distance _dest > 1500) || _i >= 70};

  {deleteVehicle _x} foreach units _transportGrp;
  deleteGroup _transportGrp;
  deleteVehicle _transport;
};

// Wait until troops have landed
waituntil {{alive _x && isTouchingGround _x} count units _grp == {alive _x} count units _grp};
{
  _x setdamage 0;
} foreach units _grp;

while {{alive _x} count units _grp > 0} do {
  _grp move (getpos leader gInf);
  sleep 10;
};
