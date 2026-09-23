{$R+}    {Range checking off}
{$B-}    {Boolean complete evaluation on}
{$S+}    {Stack checking on}
{$I+}    {I/O checking on}
{$N-}    {No numeric coprocessor}
{$F+}

Unit enter;

Interface

Uses
  {$ifdef dos}
  Crt, {Unit found in TURBO.TPL}
  Dos, {Unit found in TURBO.TPL}
  demo,
  {$endif}
  Turbo3, {Unit found in TURBO3.TPU}
  defuti,WM;


Function Tastoenter(var Dato:Linestr;Nomemask:String;Campo,CampiRiga,NumCampi:Integer):Boolean;
procedure ScriviMask(Nomemask:String);

Implementation



procedure ScriviMask(Nomemask:String);
var ch,ch1:string[3];
begin

end;


Function TastoEnter(var Dato:Linestr;Nomemask:String;Campo,CampiRiga,NumCampi:Integer):Boolean;
var
    i,riga:integer;
    Valore:real;
begin
end;



end.

