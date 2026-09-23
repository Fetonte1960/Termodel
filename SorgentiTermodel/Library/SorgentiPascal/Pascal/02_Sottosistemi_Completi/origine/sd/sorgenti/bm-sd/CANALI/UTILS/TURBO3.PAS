{$R+}    {Range checking off}
{$B+}    {Boolean complete evaluation on}
{$S+}    {Stack checking on}
{$I+}    {I/O checking on}
{$N-}    {No numeric coprocessor}
{$M 65000,16384,655360} {Turbo 3 default stack and heap}
{$F+}
{$O+}

Unit turbo3;

Interface

{$ifdef dos}
uses
  Crt,
  Dos;

Procedure ReadKbd(Var ch:Char);
{$endif}
Implementation
{$ifdef dos}
Procedure ReadKbd(Var ch:Char);
begin
ch:=readkey;
if ch=#0 then ch:=#27;
end;
{$endif}
end.