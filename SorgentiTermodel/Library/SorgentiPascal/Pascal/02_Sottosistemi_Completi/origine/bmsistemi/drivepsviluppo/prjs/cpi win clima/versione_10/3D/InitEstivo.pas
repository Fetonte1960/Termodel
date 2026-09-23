unit InitEstivo;

interface
Uses Varcarichi,Varcarichi_estivo_14,mainform,warning,udb,UmessaggiCarichi;
Procedure Init_estivo;
Procedure Run_estivo;
Procedure Run_Calcolo_estivo;
implementation

Procedure Run_estivo;
  begin
  //PercorsoDrive := StrPas(Percdrv);
  //Percorso_RisorseGen := StrPas(PathRisorse);
  Calcolo_estivo:=true;
  tabt:=false;
  c12mesi:=false;
  FMainEstivo := TFMainEstivo.Create(Nil);
  Init_mess(FMainEstivo.Memo1);
  FMainEstivo.show;
  tabt:=true;
  end;
Procedure Run_Calcolo_estivo;
  begin
  Calcolo_estivo:=true;
  tabt:=false;
  //PercorsoDrive := StrPas(Percdrv);
  //Percorso_RisorseGen := StrPas(PathRisorse);
  FMainEstivo := TFMainEstivo.Create(Nil);
  Init_mess(FMainEstivo.Memo1);
  FMainEstivo.show;
  tabt:=true;
  end;
Procedure Init_estivo;
  begin
  Init_Puntatori;
  end;
end.
