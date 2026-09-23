Unit Main_dos;

Interface
uses inputc;


Const dos_Zoom=3;
      dos_Tronco=4;

procedure esegui(scelta:integer);
procedure Prog_init;

Implementation

Procedure Esegui(scelta:integer);
Var fine:boolean;
begin
inputc.Esegui(scelta);
end;

procedure Prog_init;
begin
inputc.Prog_init;
end;


{--------------------------------------------------------------------------}
end.