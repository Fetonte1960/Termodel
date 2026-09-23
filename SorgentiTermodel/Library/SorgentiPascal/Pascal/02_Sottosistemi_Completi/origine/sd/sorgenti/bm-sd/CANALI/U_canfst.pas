{$R+}    {Range checking off}
{$B+}    {Boolean complete evaluation on}
{$S+}    {Stack checking on}
{$I+}    {I/O checking on}
{$N-}    {No numeric coprocessor}
{$F+}
{$O+}

Unit U_canfst;

Interface

Uses
copiatabelle,
{$Ifdef Win}
 dummyfunction;
{$else}
  Crt,
  Dos,
{$endif}
  Turbo3, {Unit found in TURBO3.TPU}
  defuti,
  {ut_funz,}
  utilitie,
  definizcan,{defin_ca,}
  WM;

    FUNCTION TRANSFER_TAB(FileName : ST80) : INTEGER;
{    Procedure TRANSFER_TAB(FileName : ST80;Codice:st5);}

    FUNCTION INSERT_LINE(IND : LINK; Posizione : INTEGER) : BOOLEAN;

{===========================================================================}

Implementation
(* Da carichi termici

 FUNCTION TRANSFER_TAB(FileName:ST80;Modo:CHAR):INTEGER;

VAR
  FL:FILE OF TabInterp;
  IOERR,N,i,j:INTEGER;
  ft:text;
BEGIN

filename:=uppercase(Filename);
if filename='TAB31' then
for i:=0 to dim_x do for j:=0 to dim_y do Tabc0^[i,j]:=tab31[i,j]
else if filename='TAB32'
then for i:=0 to dim_x do for j:=0 to dim_y do Tabc0^[i,j]:=tab32[i,j]
else if filename='TAB33' then
for i:=0 to dim_x do for j:=0 to dim_y do Tabc0^[i,j]:=tab33[i,j];

  Modo:=UPCASE(Modo);
  ASSIGN(FL,FileName+'.ASH');
  IF Modo='L' THEN RESET(FL) ELSE REWRITE(FL);

  IOERR:=IOresult;
 IF Modo='L' THEN
 READ(FL,TabC0^)
 ELSE
 WRITE(FL,TabC0^)  ;
 IOERR:=IOresult;
 TRANSFER_TAB:=IOERR;
 CLOSE(FL);

 assign(ft,FileName+'.Pas');
 rewrite(ft);
 writeln(ft,'Const '+Filename+':ARRAY[0..Dim_X,0..Dim_Y] of REAL=(');
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
 close(ft);

END;    { PROC. TRANSFER_TAB }
*)

      {---------------------------  transfer_tab  ----------------------------------}
    FUNCTION TRANSFER_TAB(FileName : ST80):integer;
      VAR
        FL : FILE OF TabAsh;
        IOERR, N : INTEGER;
      BEGIN
      copiaTab(filename);
      exit;
        if Exist(DRIVEARC+FileName+'.ASH') then
         begin
            ASSIGN(FL, DRIVEARC+FileName+'.ASH');
            RESET(FL);
            READ(FL, RecC0);
            CLOSE(FL);
         end
        else
          BEGIN
            WRITE(CHR(7));
{            CLRSCR; GOTOXY(1, 10);}
            WRITELN(W_M(49),' ',DRIVEARC+FileName,'.ASH !'); {'ERRORE nella lettura della tabella '}
            WRITELN(W_M(50));  {'Il programma non pu• proseguire.'}
            {$ifdef win}
            {$else}
            //delay(3000);
            {$endif}
            halt;
          END;

      END;                    { proc. transfer_tab }
(*
    FUNCTION TRANSFER_TAB(FileName : ST80) : INTEGER;
      VAR
        FL : FILE OF TabAsh;
        IOERR, N : INTEGER;
      BEGIN
        ASSIGN(FL, DATA_DRIVE+FileName+'.ASH');
        {$I-} RESET(FL) {$I+} ;
        IOERR := IORESULT;
        {$I-} READ(FL, RecC0) {$I+} ;
        IOERR := IORESULT;
        TRANSFER_TAB := IOERR;
        IF IOErr > 0 THEN
          BEGIN
            WRITE(CHR(7));
            CLRSCR; GOTOXY(1, 10);
            WRITELN(W_M(49),' ',FileName, ' !'); {'ERRORE nella lettura della tabella '}
            WRITELN(W_M(50));  {'Il programma non pu• proseguire.'}
          END;
        CLOSE(FL);
      END;                    { proc. transfer_tab }
*)
      {------------------------------  insert_line  --------------------------------}
    FUNCTION INSERT_LINE(IND : LINK; Posizione : INTEGER) : BOOLEAN;
      VAR
        I, N, O : INTEGER;
        CH : CHAR;

        {--------------------------------  ult_line  ---------------------------------}
      FUNCTION ULT_LINE(IND : LINK) : INTEGER;
        VAR
          I : INTEGER;
          FEND : BOOLEAN;
        BEGIN
          FEND := FALSE;
          I := 0;
          REPEAT
            I := I+1;
            IF SETLEFT(IND.T[I].CodPezzo) = '' THEN
              BEGIN
                I := I-1;
                FEND := TRUE
              END;
          UNTIL FEND OR (I > NCompRamo);
          IF Fend THEN ULT_LINE := I
          ELSE Ult_Line := 0;
        END;                  { func. ult_line }

        {------------------------------  codtab_form  --------------------------------}
      FUNCTION CODTAB_FORM(CodTab : INTEGER) : ST5;
        VAR
          ComSt : ST5;
        BEGIN
          STR(CodTab, ComSt);
          CASE CodTab OF
            0..9 : ComST := '00'+ComSt;
            10..99 : ComSt := '0'+ComSt;
          END;
          CODTAB_FORM := FORMAT(ComSt, 3);
        END;                  { proc. codtab_form }

      BEGIN
        I := ULT_LINE(IND);
        IF I = NCompRamo THEN
          BEGIN
            {$ifdef win}
            {$else}
            //SOUND(100); DELAY(200);
            //NOSOUND;
            {$endif}
            GOTOXY(1, 24);
            WRITE(W_M(42),' ',CODTAB_FORM(IND.CodTab));
            {'Spazio insufficiente per inserire un''altra riga nella tabella nø '}
            GOTOXY(1, 25); WRITE(W_M(36));  {'Premere un tasto per continuare.'}
            {$ifdef dos}
            //READKBD(CH);
            {$endif}
            GOTOXY(1, 24); CLREOL; GOTOXY(1, 25); CLREOL;
            INSERT_LINE := FALSE;
          END
        ELSE
          BEGIN
            IF I >= Posizione THEN
              BEGIN
                FOR N := I DOWNTO Posizione DO IND.T[N+1] := IND.T[N];

                INIT_LINE(IND, N);

              END;            { if i>=1 then .......}
            INSERT_LINE := TRUE;
          END;                { else......... }
      END;                    { func.  insert_line }

end.
