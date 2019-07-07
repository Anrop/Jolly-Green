/*
  Original version by HeinBloed (www.gdt-server.net)
  Modified by Shuko (www.kyllikki.fi)
  
  Usage:
    Call with the followed code: _this execvm "spectator.sqf";
    in the files called (create if doesn't exist) in your mission folder.
      onPlayerKilled.sqs
      onPlayerRespawnAsSeagull.sqs
*/


private ["_player","_killer"];
_player = _this select 0;
_killer = _this select 1;

if (alive _killer) then { spectator_target = vehicle _killer }
else { spectator_target = _player };

spectator_players = [];
{
  if (alive _x) then {
    spectator_players set [count spectator_players,_x];
  };
} foreach playableunits;
spectator_playercount = count spectator_players - 1;
spectator_currentplayer = 0;

spectator_cam_on = true;
spectator_nvg = false;
setaperture -1;

spectator_cam = "camconstruct" camcreate [getpos spectator_target select 0, (getpos spectator_target select 1) - 6, 2];
spectator_cam camConstuctionSetParams [getpos spectator_target, 20000, 10000];
spectator_cam cameraeffect ["internal","back"];

cutText ["","WHITE IN",2];
sleep 3;

["Left Mouse Button: Toggle freecam and unitcam<br />Right Mouse Button: Change point of view<br />Mouse Wheel: Cycle units", "Spectator Mode", nil, false] call BIS_fnc_GUImessage;

(finddisplay 46) displayaddeventhandler ["MouseButtonDown", "
	if (((_this select 1) == 0) and (not spectator_cam_on)) then {
		spectator_cam cameraeffect [""internal"",""back""];
		spectator_cam setpos [((getpos spectator_target) select 0) + ((sin (getdir spectator_target)) * ( - 10)),
                          ((getpos spectator_target) select 1) + ((cos (getdir spectator_target)) * (- 10)),
                          ((getpos spectator_target) select 2) + 2];
		spectator_cam setdir getdir spectator_target;		
		spectator_cam_on = true;
  };
"];
(finddisplay 46) displayaddeventhandler ["keydown", "
	if ((_this select 1) in (actionkeys ""NightVision"")) then {
		if (spectator_nvg) then {camUseNVG false;spectator_nvg = false;}
		else {camUseNVG true;spectator_nvg = true;};
  };
"];
(finddisplay 46) displayaddeventhandler ["MouseButtonDown", "
	if (((_this select 1) == 1) and spectator_cam_on) then {
		if not (alive (spectator_players select spectator_currentplayer)) then {
			while {not (alive (spectator_players select spectator_currentplayer))} do {
				spectator_currentplayer = spectator_currentplayer + 1;
				if (spectator_currentplayer > spectator_playercount) then {spectator_currentplayer = 0};
			};
			spectator_target = vehicle (spectator_players select spectator_currentplayer);
		};
		spectator_cam cameraeffect [""terminate"",""back""];
		cutText [format[""%1"", name spectator_target],""PLAIN DOWN""];
		spectator_target switchCamera ""EXTERNAL"";
		spectator_cam_on = false;
  };
"];
(findDisplay 46) displayAddEventHandler ["mousezchanged", "
	if ({alive _x} count spectator_players > 0) then {
		if ((_this select 1)  < 0) then {
			spectator_currentplayer = spectator_currentplayer - 1;
			if (spectator_currentplayer < 0) then {spectator_currentplayer = spectator_playercount};
			while {not (alive (spectator_players select spectator_currentplayer))} do {
				spectator_currentplayer = spectator_currentplayer - 1;
				if (spectator_currentplayer < 0) then {spectator_currentplayer = spectator_playercount};
			};
			spectator_target = vehicle (spectator_players select spectator_currentplayer);		
		} else {
			spectator_currentplayer = spectator_currentplayer + 1;
			if (spectator_currentplayer > spectator_playercount) then {spectator_currentplayer = 0};
			while {not (alive (spectator_players select spectator_currentplayer))} do {
				spectator_currentplayer = spectator_currentplayer + 1;
				if (spectator_currentplayer > spectator_playercount) then {spectator_currentplayer = 0};
			};
			spectator_target = vehicle (spectator_players select spectator_currentplayer);	
		};
		cutText [format[""%1"", name spectator_target],""PLAIN DOWN""];
		if spectator_cam_on then {
		  spectator_cam setpos [((position spectator_target) select 0) + ((sin (getdir spectator_target)) * ( - 10)), ((position spectator_target) select 1) + ((cos (getdir spectator_target)) * (- 10)), ((position spectator_target) select 2) + 2];
		  spectator_cam setdir getdir spectator_target;
		} else {spectator_target switchCamera ""EXTERNAL"";};
	};
"];