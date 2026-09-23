unit Mess_reti;

interface
Procedure Echo(mess:string);

implementation
uses Udatalink,udbt;
Procedure Echo(mess:string);
Var tt:string;
begin
tt:=V_recgen.Report;
dmtutti.T_Reti.Edit;
V_recgen.set_Report(tt+'-'+mess);
dmtutti.T_Reti.POst;
dmtutti.T_Reti.Edit;
//  FMainTubi.Memo1.lines.Add(mess);
end;
end.
