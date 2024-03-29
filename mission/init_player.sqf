waituntil {!isnull player};

if (PARAMS_Viewdistance == 0) then {
  setviewdistance 3000;
  private ["_id1","_id2","_id3"];
  _id1 = player addAction ["Increase Viewdistance","SHK_viewDistance.sqf",0,1,false,false];
  _id2 = player addAction ["Decrease Viewdistance","SHK_viewDistance.sqf",1,1,false,false];
  _id3 = player addAction ["Remove VD actions","SHK_viewDistance.sqf",[_id1,_id2],1,false,true];
  // Remove VD actions after 3 minutes
  [_id1,_id2,_id3] spawn {
      sleep 180;
      {player removeAction _x} foreach _this;
  };
} else {
  setviewdistance PARAMS_Viewdistance;
};

player setVariable ["BIS_noCoreConversations", true];

if (group player == gInf) then {
  PapaBear = [West,"HQ"];
  if (isnil "SHK_End") then {
    PapaBear sideChat "You are unconscious from the crash. You are not suppose to see the map.";
  } else {
    PapaBear sideChat "Please, restart the mission, because it is required to have players in both groups.";
  };
};

waituntil {SHK_heliMoved};
switch PARAMS_Map do {
  case 2: {
    private "_ldr";
    _ldr = leader gInf;
    _ldr linkItem "ItemMap";
  };
  case 3: { {_x linkItem "ItemMap"} foreach units gInf };
};
switch PARAMS_Compass do {
  case 2: { (leader gInf) linkItem "ItemCompass" };
  case 3: { {_x linkItem "ItemCompass" } foreach units gInf };
};

waituntil {time > 4};
titleRSC ["missionName","PLAIN"];
