
Unit Piante;

Interface

Uses
  Crt, {Unit found in TURBO.TPL}
  Dos, {Unit found in TURBO.TPL}
  Turbo3, {Unit found in TURBO3.TPU}
  defuti,
  utilitie,
  tipiDuct,
  key;

PROCEDURE TRANSFER_ElencoPiante(FileName:ST80;Modo:CHAR);

Procedure Init_EPiante;
var i : integer;
begin
   if exist(DRIVEplt+'\Standard.PNT') then
     TRANSFER_ElencoPiante(DRIVEplt+'\Standard.PNT','L')
   else
    begin
       for i := 1 to MaxEPiante do
        With EPt^[i] do
         begin
            NomeP :='';
            ZMax  := 0;
            ZMin  := 0;
         end;
    end;
end;


  type
    EPianteAr1 = array[1..20] of RecPiante;

  VAR
  fl1:FILE OF EPianteAr1;
  ept1:^EPianteAr1;
  Fl   : FILE OF EPianteAr;
  IOERR: INTEGER;

BEGIN

  Modo:=UpCase(Modo);

  if (not exist(filename) ) and (modo = 'L') then
   begin
      Modo:='S';
      INIT_EPiante;
   end;

   ASSIGN(Fl,FileName);

   IF Modo='S' THEN
     begin
         Rewrite(Fl);
         IOERR:=IOresult;
         Write(Fl,EPt^);
         CLOSE(Fl);
     end

   ELSE
    begin
        {$I-}
        Reset(Fl);
        IOERR:=IOresult;
        Read(Fl,EPt^);
        CLOSE(Fl);
        {$I+}
        if ioerr<>0 then
        begin
          assign(fl1,filename);
          reset(fl1);
          new(ept1);
          fillchar(ept1^,sizeof(ept1^),0);
          read(fl1,ept1^);
          close(fl1);
          fillchar(ept^,sizeof(ept^),0);
          for i:=1 to 20 do
          with ept^[i] do
          begin
            NomeP  :=ept1^[i].nomep;
            ZMin   :=ept1^[i].zmin;
            ZMax   :=ept1^[i].zmax;
          end;
          dispose(ept1);
        end;
    end;



END;  { PROC. TRANSFER_ElencoPiante }


{ ---------------------------- TRANSFER_Sezioni --------------------------- }

PROCEDURE TRANSFER_Sezioni(FileName:ST80;Modo:CHAR);

{ ---------------------------- INIT_SEZ ------------------------------ }

Procedure Init_SEZ;
var i : integer;
begin
   if exist(DATA_DRIVE+DRIVEPLT+'\Standard.SEZ') then
     TRANSFER_Sezioni(DATA_DRIVE+DRIVEPLT+'\Standard.SEZ','L')
   else
    begin
       for i := 1 to MaxSez do
        With Sez[i] do
         begin
            NomeP:='';       XIns:=0;             YIns:=0;
            XOri:=0;         YOri:=0;             ZOri:=0;
            Orient:=0;       Scala:=0;            AS:=0;
            BS:=0;           HS:=0;
         end;
    end;
end;

VAR
  Fl   : FILE OF ElenSez;
  IOERR: INTEGER;

BEGIN

  Modo:=UpCase(Modo);

  if (not exist(filename) ) and (modo = 'L') then
   begin
      Modo:='S';
      INIT_Sez;
   end;

   ASSIGN(Fl,FileName);

   IF Modo='S' THEN
     begin
         Rewrite(Fl);
         IOERR:=IOresult;
         Write(Fl,Sez);
     end

   ELSE
    begin
        Reset(Fl);
        IOERR:=IOresult;
        Read(Fl,Sez);
    end;

   CLOSE(Fl);

END;  { PROC. TRANSFER_Sezioni}

 PROCEDURE GEST_MENU(var Uscita:integer);

{===========================================================================}

Implementation

{-------------------------------  GEST_MENU  ---------------------------------}



PROCEDURE GEST_MENU(var Uscita:integer);

VAR
  ftext   :text;
  Scelta  :INTEGER;


{-------------------------- ElencoPiante -----------------------------}
Procedure ElencoPiante;
var Riga,Campo ,i: integer;
Begin

  TRANSFER_ElencoPiante(DRIVEPLT+'work.PNT','L');

  ClrScr;
  InitMenu := true;
  InitMask:=true;


  repeat

    M_IOTabella(Seg(EPt^),Ofs(EPt^),MaxEPiante,10,3,Chiave,Scelta,Riga,Campo,
                DATA_DRIVE+'piante.msk','pm',true,InitMask,not InitMask,false,initmenu);

  InitMask := false;
  InitMenu:=True;

  until (chiave=27)and(Scelta<>43);

  TRANSFER_ElencoPiante(driveplt+'work.PNT','S');

end;

{-------------------------- ElencoSezioni -----------------------------}
Procedure ElencoSezioni;
var Riga,Campo ,i: integer;

Begin
  TRANSFER_Sezioni(driveplt+'work.SEZ','L');
  ClrScr;
  InitMenu := true;
  InitMask:=true;


  repeat

    M_IOTabella(Seg(Sez),Ofs(Sez),MaxSez,10,11,Chiave,Scelta,Riga,Campo,
                DATA_DRIVE+'sezioni.msk','pm',true,InitMask,not InitMask,false,initmenu);

  InitMask := false;
  InitMenu:=True;

  until (chiave=27)and(Scelta<>44);

  TRANSFER_Sezioni(DRIVEplt+ 'work.SEZ','S');

end;

{---------------------------- START GESTMENU ---------------------------------}


BEGIN

      CASE uscita OF

        43:ELENCOPIANTE;
        44:ELENCOSEZIONI;
      end;
      uscita:=Scelta;

END;  { PROC. GEST_MENU }

End.