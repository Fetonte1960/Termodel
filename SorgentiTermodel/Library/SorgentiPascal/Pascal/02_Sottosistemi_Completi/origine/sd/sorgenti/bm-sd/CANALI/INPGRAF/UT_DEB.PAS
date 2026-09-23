{$A+,B-,D+,E+,F-,I+,L+,N-,O-,R-,S+,V+}
{$M 16384,0,655360}
unit ut_deb;

interface


procedure initdeb;
Procedure Deb(testo:String;Num:real);
procedure closedeb;

implementation

{----------------------------------------------------------------------------}
var fdeb:text;

procedure initdeb;
begin
assign(fdeb,'debug_C.txt');
rewrite(fdeb);
end;

Procedure Deb(testo:String;Num:real);
begin
write(fdeb,testo);
if num<>0 then writeln(fdeb,Num:6:2)
else writeln(fdeb);
flush(fdeb);
end;

procedure closedeb;
begin
close(fdeb);
end;
end.