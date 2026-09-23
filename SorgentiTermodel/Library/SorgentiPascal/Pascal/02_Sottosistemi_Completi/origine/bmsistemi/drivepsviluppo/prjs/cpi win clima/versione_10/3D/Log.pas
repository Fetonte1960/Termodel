unit Log;

interface
uses libreriagenerale;

Procedure Wlog(txt:string);
Procedure Initlog(arg:string);
Procedure Closelog;
Procedure WCordLog(txt:string;x,y:real);
Procedure step_deb(mess:string);

implementation
var activelog:boolean=false;
Var FLogLettura,FlogStep:textfile;

Procedure step_deb(mess:string);
begin
assign(FLogStep,i_sl(percorsodrive)+'step.log');
rewrite(FLogStep);
writeln(FLogStep,mess);
close(FLogStep);
end;

Procedure Initlog(arg:string);
begin
exit;
activelog:=true;
assign(FLogLettura,i_sl(percorsodrive)+'Lettura.log');
rewrite(FLogLettura);
writeln(FLogLettura,arg);
end;
Procedure Closelog;
begin
exit;
close(FLogLettura);
activelog:=false;
end;
Procedure Wlog(txt:string);
begin
exit;
if not activelog then exit;
writeln(FLogLettura,txt);
end;
Procedure WCordLog(txt:string;x,y:real);
begin
if not activelog then exit;
writeln(FLogLettura,txt+' X:'+float_to_str(x,1)+' Y:'+float_to_str(Y,1));
end;

end.
