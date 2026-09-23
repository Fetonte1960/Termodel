unit IncludiTabelle;

interface
uses SysUtils,copialibreriagenerale;
Procedure Includi(percorso:string);

implementation
 CONST
  DIM_X=16;
  DIM_Y=16;
TYPE
  TabInterp=ARRAY[0..DIM_X,0..DIM_Y] OF REAL48;
VAR
  TabC0:^TabInterp;
Procedure Includi(percorso:string);

 Var sr:Tsearchrec;
     NomeFile : String;
     perc:string;
     Trovato : Integer;
     Fhd,FT:Text;


Procedure creatabella(Filename:string);
Var
  FL:FILE OF TabInterp;
  IOERR,N,i,j:INTEGER;

Const modo='L';
begin
  ASSIGN(FL,percorso+'\'+FileName+'.ASH');
  IF Modo='L' THEN RESET(FL) ELSE REWRITE(FL);

  IOERR:=IOresult;
 IF Modo='L' THEN
 READ(FL,TabC0^)
 ELSE
 WRITE(FL,TabC0^)  ;
 //IOERR:=IOresult;
 //TRANSFER_TAB:=IOERR;
 CLOSE(FL);

//writeln(ft,'Const C_'+Filename+':ARRAY[0..Dim_X,0..Dim_Y] of REAL=(');

 writeln(ft,'Const C_'+Filename+':ARR=(');
 for i:=0 to dim_X do
   begin
   write(ft,'(');
     for j:=0 to Dim_Y do
     begin
     write(ft,float_to_str(Tabc0^[i,j],4));
     if j<>Dim_y then write(ft,',');
     end;
   write(ft,')');
   if i<>Dim_x then write(ft,',');
   writeln(ft,'');
   end;
 writeln(ft,');');

end;

 begin
  New(TabC0);
     Assign(fT,'c:\sd\sorgenti\Bm-sd\canali\Tabelle_ASH.pas');
     rewrite(FT);

     Assign(fhd,'c:\sd\sorgenti\Bm-sd\canali\CopiaTabelle.pas');
     rewrite(Fhd);
     writeln(Fhd,'Unit CopiaTabelle;');
     writeln(Fhd,'Interface');
     writeln(Fhd,'Uses DefinizCan,dialogs,sysutils;');
     writeln(Fhd,'{$I Tabelle_ASH}');
     writeln(Fhd,'Procedure CopiaTab(Nometab:string);');
     writeln(Fhd,'Implementation');
     writeln(Fhd,'Procedure CopiaTab(Nometab:string);');
     writeln(Fhd,'Begin');
     writeln(Fhd,'NomeTab:=uppercase(NomeTab);');

     perc:=percorso+'\*.ASH';
     Trovato := FindFirst(perc,faarchive,sr);
     while Trovato = 0 do
        begin
             nomefile:=uppercase(copy(sr.name,1,Length(sr.Name)-4));
             writeln(Fhd,'If Nometab='''+nomefile+''' Then RecC0.Tabc0:=C_'+Nomefile+' else');
             Creatabella(nomefile);
             Trovato := FindNext(sr);
        end;
     writeln(Fhd,'Showmessage(''Tabella perdite non trovata'');');
     writeln(Fhd,'End;');
     writeln(Fhd,'End.');
     close(FT);
     close(FHd);
 end;

end.
