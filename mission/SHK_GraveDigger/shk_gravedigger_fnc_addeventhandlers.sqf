{
  _x addEventHandler ["killed", "SHK_GraveDigger_Dead set [count SHK_GraveDigger_Dead, [_this select 0,time]]"];
  SHK_GraveDigger_HaveEH set [count SHK_GraveDigger_HaveEH,_x];
} foreach _this;