private ["_pos","_grp","_dst","_warp","_dir","_newpos","_ldr"];
sleep (15 - (PARAMS_Difficulty * 2));

// Get spawning position
_dst = 650 - (PARAMS_Difficulty * 30);
_pos = [leader gInf,_dst,random 360] call SHK_pos;

// Spawn the group and remove GPS
_grp = [_pos,EAST,_this,[],[],[0,0.2]] call BIS_fnc_spawnGroup;
_grp spawn SHK_fnc_removeGPS;
sleep 3;
_grp setFormation "LINE";

// While the group has members alive, keep moving them towards the players
while {(({alive _x} count (units _grp) > 0) && (!SHK_AllAboard))} do {
  _ldr = leader gInf;
  
  // If groups gets left too far behind of the players, reposition them
  if (((leader _grp) distance _ldr) > (_dst + 50)) then {
    if (!isnil "SHK_intercept_getDir") then {
      _dir = gInf call SHK_intercept_getDir;
    } else {
      _dir = random 360;
    };
    _newpos = [_ldr,_dst,[_dir - 40,_dir + 40]] call SHK_pos;
    
    // Move the members without stacking them on top of each other at the new position
    [leader _grp,_newpos,50] call SHK_moveObjects;
  
    //DEBUG
    /*
    private ["_m","_p"];
    _p = getpos leader _grp;
    _m = createMarker [format["SHK_grp_%1%2%3",(floor(_p select 0)),(floor(_p select 1)),floor time],_p];
    _m setMarkerShape "Icon";
    _m setMarkerType "mil_dot";
    _m setmarkerColor "ColorBlue";    
    */
    
    sleep 1;
  };

  units _grp doMove (getpos _ldr);
  sleep 5;
  
  //DEBUG
  /*
  private ["_m","_p"];
  _p = getpos leader _grp;
  _m = createMarker [format["SHK_grp_%1%2%3",(floor(_p select 0)),(floor(_p select 1)),floor time],_p];
  _m setMarkerShape "Icon";
  _m setMarkerType "mil_dot";
  _m setmarkerColor "ColorRed";
  */
};

// All members of the group are dead, restart the script with same parameters
if (!SHK_AllAboard) then {
  _this spawn SHK_spawnGroup;
};