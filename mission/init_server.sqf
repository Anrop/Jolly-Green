waituntil {SHK_heliMoved};

SHK_fnc_removeGPS = {
  if (_this != gPilot) then
  {
    {
      if (_x hasWeapon "ItemGPS") then {
        _x unassignItem "ItemGPS";
        _x removeItem "ItemGPS";
      };
    } foreach (units _this);
  };
};

gInf execvm "SHK_intercept.sqf";

SHK_spawnGroup = compile preprocessFileLineNumbers "spawnGroup.sqf";
SHK_moveObjects = compile preprocessFileLineNumbers "SHK_moveObjects.sqf";

private ["_grps"];
_grps = switch PARAMS_Difficulty do {
  case 1:
  {
    [
      ["O_Soldier_SL_F","O_Soldier_AR_F","O_Soldier_LAT_F"],
      ["O_Soldier_TL_F","O_Soldier_AR_F","O_Soldier_LAT_F"],
      ["O_Soldier_TL_F","O_Soldier_LAT_F","O_Soldier_F"],
      ["O_Soldier_TL_F","O_Soldier_LAT_F","O_Soldier_F"],
      ["O_Soldier_TL_F","O_Soldier_F","O_Soldier_F"],
      ["O_Soldier_TL_F","O_Soldier_F","O_Soldier_F"],
      ["O_Soldier_SL_F","O_Soldier_AR_F","O_Soldier_F"],
      ["O_Soldier_SL_F","O_medic_F","O_medic_F"]
    ]
  };
  case 2:
  {
    [
      ["O_Soldier_SL_F","O_Soldier_AR_F","O_Soldier_LAT_F"],
      ["O_Soldier_TL_F","O_Soldier_AR_F","O_Soldier_LAT_F"],
      ["O_Soldier_TL_F","O_Soldier_LAT_F","O_Soldier_F"],
      ["O_Soldier_TL_F","O_Soldier_LAT_F","O_Soldier_F"],
      ["O_Soldier_TL_F","O_Soldier_F","O_Soldier_F"],
      ["O_Soldier_TL_F","O_Soldier_F","O_Soldier_F"],
      ["O_Soldier_SL_F","O_Soldier_AR_F","O_Soldier_F"],
      ["O_Soldier_SL_F","O_Soldier_AR_F","O_Soldier_F"],
      ["O_Soldier_SL_F","O_medic_F","O_medic_F"],
      ["O_MRAP_02_F"],
      ["O_MRAP_02_F"]
    ]
  };
  case 3:
  {
    [
      ["O_Soldier_SL_F","O_Soldier_AR_F","O_Soldier_LAT_F"],
      ["O_Soldier_SL_F","O_Soldier_AR_F","O_Soldier_LAT_F"],
      ["O_Soldier_TL_F","O_Soldier_AR_F","O_Soldier_LAT_F"],
      ["O_Soldier_TL_F","O_Soldier_LAT_F","O_Soldier_F"],
      ["O_Soldier_TL_F","O_Soldier_LAT_F","O_Soldier_F"],
      ["O_Soldier_TL_F","O_Soldier_F","O_Soldier_F"],
      ["O_Soldier_TL_F","O_Soldier_F","O_Soldier_F"],
      ["O_Soldier_SL_F","O_Soldier_AR_F","O_Soldier_F"],
      ["O_Soldier_SL_F","O_Soldier_AR_F","O_Soldier_F"],
      ["O_Soldier_SL_F","O_medic_F","O_medic_F"],
      ["O_MRAP_02_hmg_F"],
      ["O_MRAP_02_F"]
    ]
  };
  case 4:
  {
    [
      ["O_Soldier_SL_F","O_Soldier_AR_F","O_Soldier_LAT_F"],
      ["O_Soldier_SL_F","O_Soldier_AR_F","O_Soldier_LAT_F"],
      ["O_Soldier_TL_F","O_Soldier_AR_F","O_Soldier_LAT_F"],
      ["O_Soldier_TL_F","O_Soldier_AR_F","O_Soldier_LAT_F"],
      ["O_Soldier_TL_F","O_Soldier_LAT_F","O_Soldier_F"],
      ["O_Soldier_TL_F","O_Soldier_LAT_F","O_Soldier_F"],
      ["O_Soldier_TL_F","O_Soldier_F","O_Soldier_F"],
      ["O_Soldier_TL_F","O_Soldier_F","O_Soldier_F"],
      ["O_Soldier_SL_F","O_Soldier_AR_F","O_Soldier_F"],
      ["O_Soldier_SL_F","O_Soldier_AR_F","O_Soldier_F"],
      ["O_Soldier_SL_F","O_medic_F","O_medic_F"],
      ["O_MRAP_02_hmg_F"],
      ["O_MRAP_02_F"],
      ["O_MRAP_02_F"]
    ]
  };
  case 5:
  {
    [
      ["O_Soldier_SL_F","O_Soldier_AR_F","O_Soldier_LAT_F"],
      ["O_Soldier_SL_F","O_Soldier_AR_F","O_Soldier_LAT_F"],
      ["O_Soldier_TL_F","O_Soldier_AR_F","O_Soldier_LAT_F"],
      ["O_Soldier_TL_F","O_Soldier_AR_F","O_Soldier_LAT_F"],
      ["O_Soldier_TL_F","O_Soldier_LAT_F","O_Soldier_F"],
      ["O_Soldier_TL_F","O_Soldier_LAT_F","O_Soldier_F"],
      ["O_Soldier_TL_F","O_Soldier_LAT_F","O_Soldier_F"],
      ["O_Soldier_TL_F","O_Soldier_F","O_Soldier_F"],
      ["O_Soldier_TL_F","O_Soldier_F","O_Soldier_F"],
      ["O_Soldier_SL_F","O_Soldier_AR_F","O_Soldier_F"],
      ["O_Soldier_SL_F","O_Soldier_AR_F","O_Soldier_F"],
      ["O_Soldier_SL_F","O_Soldier_AR_F","O_Soldier_F"],
      ["O_Soldier_SL_F","O_medic_F","O_medic_F"],
      ["O_Soldier_SL_F","O_medic_F","O_medic_F"],
      ["O_APC_Tracked_02_cannon_F"],
      ["O_MRAP_02_F"],
      ["O_MRAP_02_F"],
      ["O_MRAP_02_F"]
    ]
  };
};

{
  _x spawn SHK_spawnGroup;
  sleep 2;
} foreach _grps;

// Paratroops
SHK_paraTroops = compile preprocessfile "paraTroops.sqf";
SHK_spawnParaTroop = {
  private ["_pos","_sh"];
  _pos = getpos leader gInf;
  _sh = _pos spawn SHK_paraTroops;
  waituntil {scriptDone _sh};
  sleep 10 + (100/(PARAMS_Difficulty + 1));
  [] spawn SHK_spawnParaTroop;
};
[] spawn SHK_spawnParaTroop;

if (PARAMS_Difficulty > 2) then {
  [] spawn SHK_spawnParaTroop;
};

[60,10,150,50] execvm "SHK_GraveDigger\init.sqf";