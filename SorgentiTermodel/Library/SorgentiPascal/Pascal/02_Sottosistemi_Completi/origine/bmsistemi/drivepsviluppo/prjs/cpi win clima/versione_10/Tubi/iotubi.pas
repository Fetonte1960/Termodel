
Unit iotubi;

Interface

Uses
  {Crt, {Unit found in TURBO.TPL}
  {Dos,} {Unit found in TURBO.TPL}
  {printer,
  Turbo3,} {Unit found in TURBO3.TPU}
  definiz,varcarichi{,defuti,
  utilitie,wp},UUtigen, LibreriaGenerale;




procedure ConfCopy(var Sct:boolean);


PROCEDURE RESET_PUN;

PROCEDURE System_Init;
PROCEDURE Prog_Init;
PROCEDURE INIT_Term;

{------------------------------  INIT_GENERALITA  ----------------------------}

PROCEDURE TRANSFER_GENERALITA(FileName:ST80;Modo:CHAR);

PROCEDURE TRANSFER_TUBAZ(FileName:ST80;Modo:CHAR);

PROCEDURE TRANSFER_Perd(FileName:ST80;Modo:CHAR);

PROCEDURE TRANSFER_Term(FileName:ST80;Modo:CHAR);

PROCEDURE TRANSFER_Mont(FileName:ST80;Modo:CHAR);

PROCEDURE TRANSFER_Flu(FileName:ST80;Modo:CHAR);

PROCEDURE TRANSFER_FluM(FileName:ST80;Modo:CHAR);

PROCEDURE DISK(Modo:CHAR);
PROCEDURE DISKPROG(Modo:CHAR);
PROCEDURE DISKARK(Modo:CHAR);


PROCEDURE CONTA;
{-----------------------------  MAIN of DISK  --------------------------------}

procedure SaveNProg;

procedure ReadNProg;

procedure EraseNProg;

{===========================================================================}

Implementation


procedure ConfCopy(var Sct:boolean);

var  ch:char;
 begin
 {***  sct:=conferma('tubi.msg','',5);}
    (*repeat
      write(chr(7));
      gotoxy(1,1); ClrEol;
      gotoxy(1,1); write(w_m(23));
{      gotoxy(1,1); write ('ATTENZIONE, la linea sara'' ricoperta da quella precedente ! CONFERMI (S/N) ? ');}
      read(kbd,ch);
      ch:=UpCase(ch);
    until ch in[cyes,cno];
{    until ch in['S','N'];}
    if ch = cyes then Sct:=true
    else Sct:=false;
    gotoxy(1,1); ClrEol;*)
 end;

{--------------------------------- RESET_PUN -------------------------------}
Procedure Reset_pun;
begin
Generalita_D:=nil;
//Tubaz_D     :=nil;
//Perd_d      :=nil;
Term_D      :=nil;
Mont_D      :=nil;
Flu_D       :=nil;
FluM_D      :=nil;
Valv_D      :=nil;
end;

{--------------------------------  Init_Tubaz    ----------------------------}

PROCEDURE INIT_TUBAZ;
var i,j:integer;
BEGIN
  IF TUBAZ_D=NIL THEN NEW(Tubaz_D);
  For i:=1 to MaxTubaz do
  WITH Tubaz_D^[i] DO
    begin
    Cod:='';
    Descr:='';
    //Dens:=0;
    //rug:=0;
    for j:=1 to maxsez do
      begin
      sez[j].dnom:='';
      sez[j].dint:=0;
      sez[j].spes:=0;
      sez[j].form:=0;
      end;
    end;

END;   { PROC.   INIT_Tubaz }

{------------------------------ INIT_Valv ---------------------------------}
PROCEDURE INIT_VALV;
var i,j:integer;
BEGIN
  IF VALV_D=NIL THEN NEW(VALV_D);

  for i:= 1 to maxcod do
  with Valv_D^[i] do
  begin
    cod:='';
    dmin:=0;
    dmax:=0;
    for j:=1 to maxtacche do
    begin
      tacche[j].cod:='';
      tacche[j].kv1:=0;
      tacche[j].kv2:=0;
      tacche[j].kv3:=0;
    end;
  end;
END;
{------------------------------ INIT_Perd ---------------------------------}
PROCEDURE INIT_Perd;
var i,j:integer;
BEGIN
exit;
  IF Perd_D=NIL THEN NEW(Perd_D);
  For i:=1 to MaxPerd do
  WITH Perd_D^[i] DO
    begin
    Cod  :='';
    Descr:='';
    LEQ  :=0;
    Zeta :=0;
    Rit  :='';
    end;

END;   { PROC.   INIT_PERD }

{------------------------------ INIT_Term ---------------------------------}
PROCEDURE INIT_Term;
var i,j:integer;
BEGIN
  IF Term_D=NIL THEN NEW(Term_D);
  For i:=1 to MaxTerm do
  WITH Term_D^[i] DO
    begin
    Cod     :='';
    Port    :=0;
    Pot     :=0;
    PortEff :=0;
    Perd    :=0;
    CodPerd :='';
    end;

END;   { PROC.   INIT_Term }
{------------------------------ INIT_mont ---------------------------------}
PROCEDURE INIT_mont;
var i,j:integer;
BEGIN
  IF mont_D=NIL THEN NEW(mont_D);
  For i:=1 to Maxmont do
  WITH mont_D^[i] DO
    begin
    Cod      :='';
    TipTub   :='';
    CodTub   :='';
    LungTub  :=0;
    CodPerd1 :='';
    NumPerd1 :=0;
    CodPerd2 :='';
    NumPerd2 :=0;
    CodPerd3 :='';
    NumPerd3 :=0;
    end;

END;   { PROC.   INIT_mont }
{------------------------------ INIT_FLU --------------------------}

PROCEDURE INIT_Flu;
var i,j:integer;
BEGIN
  IF Flu_D=NIL THEN NEW(Flu_D);
  For i:=1 to MaxFlu do
  WITH Flu_D^[i] DO
    begin
         cod      :='';
         tm       :=0;
         pm       :=0;
         dens     :=0;
         visc     :=0;
         calsp    :=0;
         pesmol   :=0;
         callat   :=0;
     end;

END;

{------------------------------ INIT_FLUM --------------------------}

PROCEDURE INIT_FluM;
var i,j:integer;
BEGIN
  IF FluM_D=NIL THEN NEW(FluM_D);
  WITH FluM_D^ DO
    begin
        cod      :='Acqua';
         //cod      :=w_m(30);
         tm       :=80;
         pm       :=0;
         dens     :=973.0719;
         visc     :=0.0009240;
         calsp    :=4.19;
         pesmol   :=0;
         callat   :=0;
         deltaT   :=10;
     end;

END;
{--------------------------- INIT GENERALITA -------------------------------}

PROCEDURE INIT_GENERALITA;
TYPE RecGenCart=RECORD
           Progetto,Committ,Progettista:STRING[50];
           Revisione:Integer;
           Data:STRING[20];
           Luogo:STRING[32];
         END;


VAR
  F2:file of recgencart;
  vgcart:recgencart;
  ft:text;
  drive:string[80];

BEGIN
  {
  assign(ft,get_drive+'\driveprg.int');
  reset(ft);
  read(ft,drive);
  close(ft);
  drive:=drive+'\'+nomecommessa+'\';
  }
  IF GENERALITA_D=NIL THEN NEW(GENERALITA_D);
  WITH GENERALITA_D^ DO
  BEGIN
    Progetto:='';
    Committ:='';
    Revisione:=0;
    Progettista:='';
    Data:='';
    Luogo:='';
    Ritorno:=cyes;
    dps:=200;
    maxvels:=0.8;
    dpe:=400;
    maxvele:=1;
    valvtipo:='';
    perdmin:=0.1;
    Tolleranza:=0.1;
    Iterazioni:=10;
  END;
  (*
  if exist(drive+'gen.dat') then
  begin
    assign(f2,drive+'gen.dat');
    reset(f2);
{    read(f2,vgcart);}
    close(f2);
    with generalita_d^ do
    begin
      Progetto:=vgcart.progetto;
      Committ:=vgcart.committ;
      Progettista:=vgcart.Progettista;
      Revisione:=vgcart.Revisione;
      Data:=vgcart.Data;
      Luogo:=vgcart.Luogo;
    end;

  end;
  *)
END;   { PROC.   INIT_GENERALITA }


{--------------------------------  System_Init  ------------------------------}
PROCEDURE System_Init;

BEGIN
  Init_Generalita;
//  INIT_TUBAZ;
  INIT_PERD;
  INIT_TERM;
  INIT_mont;
  INIT_Flu;
  INIT_FluM;
  INIT_VALV;
END;      { PROC. System_Init }

{--------------------------------  Prog_Init  ------------------------------}
PROCEDURE Prog_Init;

BEGIN

  Init_Generalita;
  INIT_TERM;
  INIT_FluM;
END;      { PROC. Prog_Init }


{-----------------------------  TRANSFER_GENERALITA  -------------------------}

PROCEDURE TRANSFER_GENERALITA(FileName:ST80;Modo:CHAR);

TYPE RecGenCart=RECORD
           Progetto,Committ,Progettista:STRING[50];
           Revisione:Integer;
           Data:STRING[20];
           Luogo:STRING[32];
         END;


VAR
  Fl:FILE OF RecGen;
  F2:file of recgencart;
  vgcart:recgencart;
  ft:text;
  IOERR:INTEGER;

BEGIN
  Modo:=UpCase(Modo);
  if (not exist(filename) ) and (modo = 'L') then
  begin
    modo:='S';
  end;
  ASSIGN(Fl,FileName);
  IF Modo= 'S' THEN
  begin
    REWRITE(Fl);
    WRITE(Fl,GENERALITA_D^);
  end
  ELSE
  begin
    RESET(Fl);
{    READ(Fl,GENERALITA_D^) ;}
  end;
  CLOSE(Fl);
END;  { PROC. TRANSFER_GENERALITA }



{-----------------------------  TRANSFER_TUBAZ  -------------------------}

PROCEDURE TRANSFER_TUBAZ(FileName:ST80;Modo:CHAR);

VAR
  Fl:FILE OF RecTubaz;
  I,IOERR:INTEGER;
BEGIN
  Modo:=UpCase(Modo);
  if (not exist(filename) ) and (modo = 'L') then modo:='S';

  ASSIGN(Fl,FileName);
  if Modo = 'S' then
   begin
      rewrite(Fl);
      for i:=1 to MaxTubaz do
       if SETLEFT(Tubaz_D^[I].Cod) > '' then WRITE(Fl,Tubaz_D^[I]);
      close(Fl);
   end
  else
   begin
        RESET(Fl);
      IOERR:=IOresult;
      I:=0;
      WHILE  not(EOF(Fl)) DO
      BEGIN
        I:=I+1;
        READ(Fl,Tubaz_D^[I]);
      END;
      close(Fl);
   end;
  NTubaz:=I;
END;  { PROC. TRANSFER_Tubaz }

{-----------------------------  TRANSFER_Perd  -------------------------}

PROCEDURE TRANSFER_Perd(FileName:ST80;Modo:CHAR);

VAR
  Fl:FILE OF RecPerd;
  I,IOERR:INTEGER;
BEGIN
  Modo:=UpCase(Modo);
  if (not exist(filename) ) and (modo = 'L') then modo:='S';

  ASSIGN(Fl,FileName);
  if Modo = 'S' then
   begin
      rewrite(Fl);
      for i:=1 to MaxPerd do
       if SETLEFT(Perd_D^[I].Cod) > '' then WRITE(Fl,Perd_D^[I]);
      close(Fl);
   end
  else
   begin
        RESET(Fl);
      IOERR:=IOresult;
      I:=0;
      WHILE  not(EOF(Fl)) DO
      BEGIN
        I:=I+1;
        READ(Fl,Perd_D^[I]);
      END;
      close(Fl);
   end;
  NPerd:=I;
END;  { PROC. TRANSFER_Perd }


{-----------------------------  TRANSFER_Term  -------------------------}

PROCEDURE TRANSFER_Term(FileName:ST80;Modo:CHAR);

VAR
  Fl:FILE OF RecTerm;
  I,IOERR:INTEGER;
BEGIN
  Modo:=UpCase(Modo);
  if (not exist(filename) ) and (modo = 'L') then modo:='S';

  ASSIGN(Fl,FileName);
  if Modo = 'S' then
  begin
    rewrite(Fl);
    for i:=1 to MaxTerm do
    if SETLEFT(Term_D^[I].Cod) > '' then WRITE(Fl,Term_D^[I]);
    close(Fl);
  end
  else
  begin
    fillchar(Term_D^,sizeof(Term_D^),0);
    RESET(Fl);
    IOERR:=IOresult;
    I:=0;
    WHILE  not(EOF(Fl)) DO
    BEGIN
      I:=I+1;
      READ(Fl,Term_D^[I]);
    END;
    close(Fl);
  end;
  NTerm:=I;
END;  { PROC. TRANSFER_Term }

{-----------------------------  TRANSFER_mont  -------------------------}

PROCEDURE TRANSFER_mont(FileName:ST80;Modo:CHAR);

VAR
  Fl:FILE OF Recmont;
  I,IOERR:INTEGER;
BEGIN
  Modo:=UpCase(Modo);
  if (not exist(filename) ) and (modo = 'L') then modo:= 'S';

  ASSIGN(Fl,FileName);
  if Modo = 'S' then
   begin
      rewrite(Fl);
      for i:=1 to Maxmont do
       if SETLEFT(mont_D^[I].Cod) > '' then WRITE(Fl,mont_D^[I]);
      close(Fl);
   end
  else
   begin
        RESET(Fl);
      IOERR:=IOresult;
      I:=0;
      WHILE  not(EOF(Fl)) DO
      BEGIN
        I:=I+1;
        READ(Fl,mont_D^[I]);
      END;
      close(Fl);
   end;
  Nmont:=I;
END;  { PROC. TRANSFER_mont }

{-----------------------------  TRANSFER_Flu  -------------------------}

PROCEDURE TRANSFER_Flu(FileName:ST80;Modo:CHAR);

VAR
  Fl:FILE OF RecFlu;
  I,IOERR:INTEGER;
BEGIN
  Modo:=UpCase(Modo);
  if (not exist(filename) ) and (modo = 'L') then modo:='S';

  ASSIGN(Fl,FileName);
  if Modo = 'S' then
   begin
      rewrite(Fl);
      for i:=1 to MaxFlu do
       if SETLEFT(Flu_D^[I].Cod) > '' then WRITE(Fl,Flu_D^[I]);
      close(Fl);
   end
  else
   begin
        RESET(Fl);
      IOERR:=IOresult;
      I:=0;
      WHILE  not(EOF(Fl)) DO
      BEGIN
        I:=I+1;
        READ(Fl,Flu_D^[I]);
      END;
      close(Fl);
   end;
  NFlu:=I;
END;  { PROC. TRANSFER_Flu }
{-----------------------------  TRANSFER_FluM  -------------------------}

PROCEDURE TRANSFER_FluM(FileName:ST80;Modo:CHAR);

VAR
  Fl:FILE OF RecFluM;
  I,IOERR:INTEGER;
BEGIN




  Modo:=UpCase(Modo);
  if (not exist(filename) ) and (modo = 'L') then modo:='S';


  ASSIGN(Fl,FileName);
  if Modo = 'S' then
   begin
      rewrite(Fl);
       if SETLEFT(FluM_D^.Cod) > '' then WRITE(Fl,FluM_D^);
      close(Fl);
   end
  else
   begin
        RESET(Fl);
      IOERR:=IOresult;
      I:=0;
      WHILE  not(EOF(Fl)) DO
      BEGIN
        READ(Fl,FluM_D^);
      END;
      close(Fl);
   end;
END;  { PROC. TRANSFER_FluM }

{----------------------------------  DISK  -----------------------------------}

PROCEDURE DISK(Modo:CHAR);

{-----------------------------  MAIN of DISK  --------------------------------}

BEGIN
  Modo:=UpCase(Modo);
  IF NOT (Modo IN ['L','S']) THEN EXIT;
  TRANSFER_GENERALITA(DRIVEPROG+NumeroProg+'.GEN',Modo);
  TRANSFER_TUBAZ(DRIVEARC+'Archivio.TBZ',Modo);
  TRANSFER_Perd(DRIVEARC+'Archivio.PRD',Modo);
  TRANSFER_Term(DRIVEPROG+NumeroProg+'.TRM',Modo);
  TRANSFER_Mont(DRIVEARC+'Archivio.MNT',Modo);
  TRANSFER_Flu(DRIVEARC+'Archivio.FLU',Modo);
  TRANSFER_FluM(DRIVEPROG+NumeroProg+'.FLU',Modo);
END;     { PROC. DISK }

PROCEDURE DISKPROG(Modo:CHAR);

{-----------------------------  MAIN of DISKPROG  ---------------------------}

BEGIN
  Modo:=UpCase(Modo);
  IF NOT (Modo IN ['L','S']) THEN EXIT;
  TRANSFER_GENERALITA(DRIVEPROG+NumeroProg+'.GEN',Modo);
  TRANSFER_Term      (DRIVEPROG+NumeroProg+'.TRM',Modo);
  TRANSFER_FluM      (DRIVEPROG+NumeroProg+'.FLU',Modo);
END;     { PROC. DISK }

PROCEDURE DISKARK(Modo:CHAR);

{-----------------------------  MAIN of DISKARK  ---------------------------}

BEGIN
  Modo:=UpCase(Modo);
  IF NOT (Modo IN ['L','S']) THEN EXIT;
  TRANSFER_TUBAZ(DRIVEARC+'Archivio.TBZ',Modo);
  TRANSFER_Perd(DRIVEARC+'Archivio.PRD',Modo);
  TRANSFER_Mont(DRIVEARC+'Archivio.MNT',Modo);
  TRANSFER_Flu(DRIVEARC+'Archivio.FLU',Modo);
END;     { PROC. DISK }


procedure conta;
begin
end;

procedure SaveNProg;

var NPR:text;
begin
   assign(NPR,driveprog+'Prog.dat');
   rewrite(NPR);
   write(NPR,NumeroProg);
   close(NPR);
end;



procedure ReadNProg;

var NPR:text;
begin
   if Exist(driveprog+'Prog.dat') then
    begin
       assign(NPR,driveprog+'Prog.dat');
       reset(NPR);
       read(NPR,NumeroProg);
       close(NPR);
       DISK('L');
    end;
end;


procedure EraseNProg;

var NPR:file;

begin
   if Exist(driveprog+'Prog.dat') then
    begin
       assign(NPR,driveprog+'Prog.dat');
       erase(NPR);
    end;
end;


End.
