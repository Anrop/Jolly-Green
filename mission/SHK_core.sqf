private ["_i","_paramName"];
if (isNil "param1" && isNumber(missionConfigFile/"defValueParam1")) then {param1 = getNumber (missionConfigFile/"defValueParam1")};
if (isNil "param2" && isNumber(missionConfigFile/"defValueParam2")) then {param2 = getNumber (missionConfigFile/"defValueParam2")};
if (isNil "paramsArray") then {
  paramsArray=[];
	
  private "_c";
	if (isClass (missionConfigFile/"Params")) then
	{
		_c=count (missionConfigFile/"Params");
		for [ {_i=0}, {_i<_c}, {_i=_i+1} ] do
		{
			_paramName = (configName ((missionConfigFile >> "Params") select _i));
			paramsArray=paramsArray+[ getNumber (missionConfigFile >> "Params" >> _paramName >> "default") ];
		};
	};
	_c=count paramsArray;
	if (isNil "param1" && _c>0)then{param1=paramsArray select 0};
	if (isNil "param2" && _c>1)then{param2=paramsArray select 1};
};
for [{_i = 0},{_i < count(paramsArray)},{_i = _i + 1}] do { call compile format ["PARAMS_%1 = %2",(configName ((missionConfigFile >> "Params") select _i)),(paramsArray select _i)]; };

SHK_INIT = false;
SHK_Server = false;
SHK_Client = false;
SHK_JIP = false;

if (isServer) then {
  SHK_Server = true;
  if (!(isNull player)) then { SHK_Client = true };
  SHK_INIT = true;
} else {
  SHK_Client = true;
  if (isNull player) then {
    SHK_JIP = true;
    [] spawn { waitUntil { !(isNull player) }; SHK_INIT = true };
  } else {
    SHK_INIT = true;
  };
};

if SHK_Server then { execvm "init_server.sqf" };
if SHK_Client then { execvm "init_player.sqf" };

execvm "SHK_end.sqf";