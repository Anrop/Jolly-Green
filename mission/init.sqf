// Include the mission core scripts with client/server inits, mission end handler and parameter renamer
#include "SHK_core.sqf"

// Init variables
if (!isnil "SHK_allAboard") then {SHK_allAboard = false};

// Make sure there are players on both groups
if (isnil "gPilot") then {gPilot = grpNull};
if (isnil "gInf") then {gInf = grpNull};
if (isnull gPilot || isnull gInf) then {
  [[
    ["Restart","Restart Mission","The mission requires to have players in both groups. Please, restart mission."]
  ],[
  ]] call compile preprocessfile "SHK_taskmaster.sqf";
  
  SHK_End = 1;
  publicvariable "SHK_End";
  
} else {
  // Create tasks
  [[
    ["CSAR","Rescue Troops","Your mission is a Combat Search and Rescue. Jolly Green 28 went down, at a location we haven't been able to confirm yet. Hopefully the crew and the troops made it alive. Your task is to pick them up once they are located or they are able to radio (= voice com or ingame chat) in an extraction zone.<br /><br />You start from <marker name='mStart'>here</marker>.",gPilot,[],"assigned"],
    ["EE","Escape and Evade","Your mission is to Escape and Evade (EE) the enemy, find an extraction zone and contact base with the location of it.",gInf,[],"assigned"]
  ],[
    ["Mission Overview", "A UH-80 Ghost Hawk (Jolly Green 28) was forced to land in enemy territory due to being damaged by ground fire. The JFC decided there was no time for a TRAP mission, so they have ordered a CSAR instead. Enemy forces are very likely to search for the crash site."],
    ["About","Meant to be played with least amount of UI cheating, Expert difficulty preferred. There is no predefined extraction zone the players need to find. Mission will end once all the troops are in the rescue chopper and it's at least 1km from the wreck.<br /><br />Custom view distance actions, if chosen, will be automatically removed after 3 minutes.<br /><br />Version: 20150528<br />Made by: Shuko of LDD Kyllikki<br />Contact: shuko@Quakenet<br />www.kyllikki.fi<br /><br /><img image='lddk.jpg' width='100' height='100'>"]
  ]] call compile preprocessfile "SHK_taskmaster.sqf";
};

// Set mission time to match the one given in parameters
if (PARAMS_Hour == 99) then {
  skiptime ((18.5 - daytime + 24) % 24);
} else {
  skiptime ((PARAMS_Hour - daytime + 24) % 24);
};

// Add some AT to the chopper wreck
heliWreck addMagazineCargo ["NLAW_F",6];
heliWreck addWeaponCargo ["launch_NLAW_F",2];
heliWreck allowDamage false;

// Weather
skipTime -24;
switch PARAMS_Rain do {
  case 0: { 0 setOvercast 0; 0 setRain 0 };
  case 1: { 0 setOvercast 1; 0 setRain 0.2 };
  case 2: { 0 setOvercast 1; 0 setRain 0.4 };
  case 3: { 0 setOvercast 1; 0 setRain 0.6 };
  case 4: { 0 setOvercast 1; 0 setRain 0.8 };
  case 5: { 0 setOvercast 1; 0 setRain 1 };
};
switch PARAMS_Fog do {
  case 0: { 0 setFog 0 };
  case 1: { 0 setFog 0.2 };
  case 2: { 0 setFog 0.4 };
  case 3: { 0 setFog [0.6,0.01,0.4] };
  case 4: { 0 setFog 0.8 };
  case 5: { 0 setFog 1 };
};
skipTime 24;
simulWeatherSync;