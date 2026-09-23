

Unit ioduct;

Interface

Uses

  {$Ifdef dos}
  Crt, {Unit found in TURBO.TPL}
  Dos, {Unit found in TURBO.TPL}
  {$endif}
  {$Ifdef Win}
  Dummyfunction, 
 {$endif}
  utilitie,
  turbo3,
  wm,
  Defuti,definiz,
  definizcan;


Procedure ConfCopy(var Sct:boolean);


PROCEDURE System_Init;

PROCEDURE DISK(Modo:CHAR);

PROCEDURE DISKPROG(NumeroProg:st18; Modo:CHAR);

PROCEDURE TRANSFER_Misure(FileName:ST80;Modo:CHAR);

PROCEDURE TRANSFER_Costanti(FileName:ST80;Modo:CHAR);

PROCEDURE TRANSFER_Riduzioni(FileName:ST80;Modo:CHAR);

PROCEDURE TRANSFER_ElencoPiante(FileName:ST80;Modo:CHAR);

PROCEDURE TRANSFER_Sezioni(FileName:ST80;Modo:CHAR);

PROCEDURE TRANSFER_DATIPROG1(FileName:ST80;Modo:CHAR);

PROCEDURE TRANSFER_DATIPROG2(FileName:ST80;Modo:CHAR);

(*Procedure INIT_Proget1(NumeroProg:st18);

Procedure INIT_Proget2(NumeroProg:st18);

Procedure Init_EPiante(NumeroProg:st18);*)

Procedure Init_MISURE;

{===========================================================================}

Implementation


procedure ConfCopy(var Sct:boolean);

begin
sct:=conferma('gestduct.i2','',10);
end;
(*
var  ch:char;
 begin
    repeat
      write(chr(7));
      gotoxy(1,1); ClrEol;
      gotoxy(1,1); write(W_M(20));
      {('ATTENZIONE, la linea sara'' ricoperta da quella precedente ! CONFERMI (S/N) ? ');}
      readkbd(ch);
      ch:=UpCase(ch);
{S,N}    until ch in[CH1,CH2];
{S}    if ch = CH1 then Sct:=true
    else Sct:=false;
    gotoxy(1,1); ClrEol;
 end;
*)
{ ---------------------------- INIT_MISURE ------------------------------- }

Procedure Init_MISURE;
var i : integer;
begin
 if not Exist(drivearc+'misure.ark') then
  begin
     Mis^[1].RETT:=100;    Mis^[2].RETT:=150;   Mis^[3].RETT:=200;   Mis^[4].RETT:=250;
     Mis^[5].RETT:=300;    Mis^[6].RETT:=350;   Mis^[7].RETT:=400;   Mis^[8].RETT:=500;
     Mis^[9].RETT:=600;    Mis^[10].RETT:=800;  Mis^[11].RETT:=1000; Mis^[12].RETT:=1200;
     Mis^[13].RETT:=1400;  Mis^[14].RETT:=1600; Mis^[15].RETT:=1800; Mis^[16].RETT:=2000;
     for i:=17 to MaxMis do Mis^[i].RETT:=0;

     Mis^[1].CIRC:=75;     Mis^[2].CIRC:=100;    Mis^[3].CIRC:=125;   Mis^[4].CIRC:=150;
     Mis^[5].CIRC:=175;    Mis^[6].CIRC:=200;    Mis^[7].CIRC:=225;   Mis^[8].CIRC:=250;
     Mis^[9].CIRC:=300;    Mis^[10].CIRC:=350;   Mis^[11].CIRC:=400;  Mis^[12].CIRC:=450;
     Mis^[13].CIRC:=500;   Mis^[14].CIRC:=600;   Mis^[15].CIRC:=700;  Mis^[16].CIRC:=800;
     Mis^[17].CIRC:=900;   Mis^[18].CIRC:=1000;  Mis^[19].CIRC:=1200; Mis^[20].CIRC:=1400;
     Mis^[21].CIRC:=1600;  Mis^[22].CIRC:=1800;  Mis^[23].CIRC:=2000;
     for i:=24 to MaxMis do Mis^[i].CIRC:=0;

  end;
end;


{ ---------------------------- TRANSFER_Misure --------------------------- }

PROCEDURE TRANSFER_Misure(FileName:ST80;Modo:CHAR);


VAR

  Fl   : FILE OF RecMisure;
  IOERR: INTEGER;
  i:integer;
BEGIN

  Modo:=UpCase(Modo);

  if (not exist(filename) ) and (modo = 'L') then
   begin
      Modo :='S';
      Init_Misure;
   end;

      ASSIGN(Fl,FileName);

      IF Modo='S' THEN
       begin
         Rewrite(Fl);
         IOERR:=IOresult;
         For i :=1 to MaxMis do Write(Fl,Mis^[i]);
       end

     ELSE
       begin
        Reset(Fl);
        IOERR:=IOresult;
        For i := 1 to MaxMis do Read(Fl,Mis^[i]);
       end;

      CLOSE(Fl);

END;  { PROC. TRANSFER_Misure }

{ ---------------------------- INIT_COSTANTI ------------------------------ }

Procedure Init_COST;
var i : integer;
begin

 if not Exist(drivearc+'costanti.ark') then
  begin
     with costant^ do
      begin
         ColCan:=15;    ColQ:=4;
{S,S}         QCan:=CH1; Por:=CH1;  Altquo:=4;
         C1:=0.7;     C2:=10;    C3:=1.2;    C4:=1.5;     C5:=1;     C6:=0.33;
         C7:=1;       C8:=1.5;   C9:=1.2;    C10:=1.5;    C11:=2.1;  C12:=6;
         C13:=1;      C14:=0.3;  C15:=1;     C16:=1;      C17:=1;    C18:=1;
         C19:=1;      C20:=1;    C21:=1;     C22:=1;      C23:=1;    C24:=1;
         C25:=1;      C26:=1;    C27:=1;     C28:=1;      C29:=1;    C30:=1;
         C31:=1;      C32:=1;    C33:=1;     C34:=1;      C35:=1;    C36:=1;
         C37:=1;      C38:=1;    C39:=1;     C40:=1;      C41:=1;    C42:=1;
         C43:=1;      C44:=1;    C45:=1;     C46:=1;      C46:=1;    C47:=1;
         C48:=1;      C49:=1;    C50:=1;     C51:=1;      C52:=1;    C53:=1;
         C54:=1;      C55:=1;    C56:=1;     C57:=1;      C58:=1;    C59:=1;
         C60:=1;      C61:=1;    C62:=1;     C63:=1;      C64:=1;    C65:=1;
         C66:=1;      C67:=1;    C68:=1;     C69:=1;      C70:=1;
      end;
  end;
end;


{ ---------------------------- TRANSFER_Costanti -------------------------- }

PROCEDURE TRANSFER_Costanti(FileName:ST80;Modo:CHAR);


VAR

  Fl   : FILE OF RecCostDis;
  IOERR: INTEGER;

BEGIN

  Modo:=UpCase(Modo);

  if (not exist(filename) ) and (modo = 'L') then
   begin
      Modo :='S';
      Init_Cost;
   end;

      ASSIGN(Fl,FileName);

      IF Modo='S' THEN
       begin
         Rewrite(Fl);
         IOERR:=IOresult;
         Write(Fl,costant^);
       end

     ELSE
       begin
        Reset(Fl);
        IOERR:=IOresult;
        Read(Fl,costant^);
       end;

      CLOSE(Fl);

END;  { PROC. TRANSFER_Costanti }

{ ---------------------------- INIT_Riduzioni ------------------------------ }

Procedure Init_Riduz;
var i : integer;
begin

 if not Exist(drivearc+'Riduzioni.ark') then
  begin
     with Riduz^ do
      begin
         CodRidR:='271R';
         LungRidR:=0;  AngRidR:=0;
         CodRidC:='271C';
         LungRidC:=0;  AngRidC:=0;
         CodAllR:='021R';
         LungAllR:=0;  AngAllR:=0;
         CodAllC:='021C';
         LungAllC:=0;  AngAllC:=0;
         CodTrasRC:='42C1';
         LungTrasRC:=0;
         CodTrasCR:='41R1';
         LungTrasCR:=0;
         CodRotR:='441R';
         LungRotR:=0;
         RagCurv:=1;
         RagStac:=1;
         RagTee:=1;
      end;
  end;
end;


{ --------------------------- TRANSFER_Riduzioni -------------------------- }

PROCEDURE TRANSFER_Riduzioni(FileName:ST80;Modo:CHAR);


VAR

  Fl   : FILE OF RecRiduz;
  IOERR: INTEGER;

BEGIN

  Modo:=UpCase(Modo);

  if (not exist(filename) ) and (modo = 'L') then
   begin
      Modo :='S';
      Init_Riduz;
   end;

      ASSIGN(Fl,FileName);

      IF Modo='S' THEN
       begin
         Rewrite(Fl);
         IOERR:=IOresult;
         Write(Fl,Riduz^);
       end

     ELSE
       begin
        Reset(Fl);
        IOERR:=IOresult;
        Read(Fl,Riduz^);
       end;

      CLOSE(Fl);

END;  { PROC. TRANSFER_Riduzioni }


{ ---------------------------- TRANSFER_ElencoPiante --------------------------- }

PROCEDURE TRANSFER_ElencoPiante(FileName:ST80;Modo:CHAR);

{ ---------------------------- INIT_EPIANTE ------------------------------ }

Procedure Init_EPiante;
var i : integer;
begin
   for i := 1 to MaxEPiante do
    With Ept^[i] do
     begin
        NomeP :='';
        ZMax  := 0;
        ZMin  := 0;
     end;
end;

VAR
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
         Write(Fl,Ept^);
     end

   ELSE
    begin
        Reset(Fl);
        IOERR:=IOresult;
        Read(Fl,Ept^);
    end;

   CLOSE(Fl);

END;  { PROC. TRANSFER_ElencoPiante }

{ ---------------------------- TRANSFER_Sezioni --------------------------- }

PROCEDURE TRANSFER_Sezioni(FileName:ST80;Modo:CHAR);

{ ---------------------------- INIT_SEZ ------------------------------ }

Procedure Init_SEZ;
var i : integer;
begin
   if exist(DRIVEprog+'Standard.SEZ') then
     TRANSFER_Sezioni(DRIVEPROG+'Standard.SEZ','L')
   else
    begin
       for i := 1 to MaxSez do
        With Sez^[i] do
         begin
            NomeP:='';       XIns:=0;             YIns:=0;
            XOri:=0;         YOri:=0;             ZOri:=0;
            Orient:=0;       Scala:=0;            A_S:=0;
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
         Write(Fl,Sez^);
     end

   ELSE
    begin
        Reset(Fl);
        IOERR:=IOresult;
        Read(Fl,Sez^);
    end;

   CLOSE(Fl);

END;  { PROC. TRANSFER_Sezioni}

PROCEDURE TRANSFER_DATIPROG1(FileName:ST80;Modo:CHAR);

Procedure  INIT_Proget1;
type RecGen=RECORD
           Progetto,Committ,Progettista:STRING[50];
           Revisione:Integer;
           Data:STRING[20];
           Luogo:STRING[32];
         END;

var fg:file of recgen;
    ft:text;
    vg:recgen;
    drive:string[80];
begin
   if exist(DRIVEPROG+'Standard.GN1') then
     TRANSFER_DATIPROG1(DRIVEPROG+'Standard.GN1','L')
   else
    begin
      assign(ft,get_drive+'\driveprg.int');
      reset(ft);
      read(ft,drive);
      close(ft);
      drive:=drive+'\'+nomecommessa+'\';
      WITH DPr1^ DO
        BEGIN
          Cliente := ''; Localita := ''; Progettista := ''; Impianto := '';
          NOrdine := ''; Disegno := ''; Riferimento := '';
          Edificio := ''; Sistema := ''; Zona := '';
          Circuito := '';
          AltSulMare := 0; Altezza := 0;
          TempAria := 20; UmRel := 0;
          if exist(drive+'gen.dat') then
          begin
            assign(fg,drive+'gen.dat');
            reset(fg);
            read(fg,vg);
            close(fg);
            Cliente:=vg.committ;
            Progettista:=vg.progettista;
          end;
        END;
    end;
end;

VAR
  Fl   : FILE OF DATIPROG1;
  IOERR: INTEGER;

BEGIN

  Modo:=UpCase(Modo);

  if (not exist(filename) ) and (modo = 'L') then
   begin
      Modo :='S';
      Init_Proget1;
   end;

      ASSIGN(Fl,FileName);

      IF Modo='S' THEN
       begin
         Rewrite(Fl);
         IOERR:=IOresult;
         Write(Fl,DPr1^);
       end

     ELSE
       begin
        Reset(Fl);
        IOERR:=IOresult;
        Read(Fl,DPr1^);
       end;

      CLOSE(Fl);

END;  { PROC. TRANSFER_DATIPROG1 }

PROCEDURE TRANSFER_DATIPROG2(FileName:ST80;Modo:CHAR);

Procedure  INIT_Proget2;
begin
   if exist(DRIVEPROG+'Standard.GN2') then
     TRANSFER_DATIPROG2(DRIVEPROG+'Standard.GN2','L')
   else
    begin
       With DPR2^ do
        begin
          Visc := 0.0181598; Dens := 1.204;
          RivestInt := '';
          SpessRivest := 0; Rugosita := 0.15;
          TipoSezione := '';
          Rapp := 0.5; DimW := 2000; DimH := 2000;
          DPuMTronco := 0.8; MinTronco := 0.7; MaxTronco := 1.5; VelTronco := 12;
          DPuMRami := 0.8; MinRami := 0.7; MaxRami := 1.5; VelRami := 12;
          SbilDPu := 10; SerrTermMax := 30; SerrDPuMin := 10;
          VCostante := 0;
        end;
   end;
end;


VAR
  Fl   : FILE OF DATIPROG2;
  IOERR: INTEGER;

BEGIN

  Modo:=UpCase(Modo);

  if (not exist(filename) ) and (modo = 'L') then
   begin
      Modo :='S';
      Init_Proget2;
   end;

      ASSIGN(Fl,FileName);

      IF Modo='S' THEN
       begin
         Rewrite(Fl);
         IOERR:=IOresult;
         Write(Fl,DPr2^);
       end

     ELSE
       begin
        Reset(Fl);
        IOERR:=IOresult;
        Read(Fl,DPr2^);
       end;

      CLOSE(Fl);

END;  { PROC. TRANSFER_DATIPROG2 }

{--------------------------------  System_Init  ------------------------------}

PROCEDURE System_Init;

BEGIN

  INIT_MISURE;

END;      { PROC. System_Init }



{-------------------------------- DISK  --------------------------------}

PROCEDURE DISK(Modo:CHAR);

BEGIN
  Modo:=UpCase(Modo);

  IF NOT (Modo IN ['L','S']) THEN EXIT;

  TRANSFER_MISURE(DRIVEARC+'Misure.ark',MODO);

END;

{-------------------------------- DISKPROG -----------------------------}

PROCEDURE DISKPROG(NumeroProg:st18; Modo:CHAR);

BEGIN
  Modo:=UpCase(Modo);

  IF NOT (Modo IN ['L','S']) THEN EXIT;

  TRANSFER_DATIPROG1(DRIVEARC+ Numeroprog+'.GN1',MODO);
  TRANSFER_DATIPROG2(DRIVEARC+ Numeroprog+'.GN2',MODO);
  TRANSFER_ElencoPiante(DRIVEPLT+ Numeroprog+'.PNT',MODO);

END;     { PROC. DISKPROG }


End.
