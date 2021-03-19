call compile preprocessfilelinenumbers "shk_pos\shk_pos_init.sqf";

SHK_heliMoved = false;

"mArea" setMarkerAlpha 0;
"mBL" setMarkerAlpha 0;

SHK_startPos = ["mArea",0,"mBL",heli] call SHK_pos;

private "_b";
_b = "Bo_GBU12_LGB" createVehicle [(SHK_startPos select 0),(SHK_startPos select 1),5]; //Bo_GBU12_LGB
[_b] spawn {
  waituntil {isNull (_this select 0)};
  heliWreck setpos [(SHK_startPos select 0),(SHK_startPos select 1),0];
  heliWreck setvectorup [0,0,1];
  heliWreck setdir (random 360);
  heliWreck setvelocity [0,0,0];
};

private _heliPos = getPos heli;
heli setPos [(_heliPos select 0),(_heliPos select 1),0];
heli setVectorUp [0,0,1];
heli setVelocity [0,0,0];
