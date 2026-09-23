{$R+}    {Range checking off}
{$B+}    {Boolean complete evaluation on}
{$S+}    {Stack checking on}
{$I+}    {I/O checking on}
{$N-}    {No numeric coprocessor}
{$F+}

Unit Sel_Line;

Interface

Uses
  Crt, {Unit found in TURBO.TPL}
  Dos, {Unit found in TURBO.TPL}
  Turbo3, {Unit found in TURBO3.TPU}
  demo,defuti;


 function keypressed_n:boolean;
 FUNCTION READ_KBD(VAR CH:CHAR;campo:integer):BOOLEAN;
 FUNCTION LINE_INPUT(X,Y,L:INTEGER;
                VAR STARTCURPOS:INTEGER;
                    FILLCHAR:CHAR;
                    PRESETFIELD:LINESTR;
                    SETCODE:INTEGER;
                VAR EXITCHAR:CHAR;
                    FlagEND:BOOLEAN;
                VAR ModFlag:BOOLEAN;
                    campo:integer;
                    nomemask:st80;
                    Var ridis:boolean):LINESTR;

Implementation
{$I funzuti }
function keypressed_n:boolean;
begin

  if play and keypressed then
    begin
    clrscr;
    halt;
    end;
  if play then keypressed_n:= (nastro.tempo<=timecorr) and (not nastro.mouse)
  else  keypressed_n:=keypressed;
end;


{----------------------------  LINE_INPUT  -----------------------------------}

FUNCTION READ_KBD(VAR CH:CHAR;campo:integer):BOOLEAN;
var M_ATT:boolean;

 function trovacampo(px,py:integer):integer;
 var i,min,cmin,dist:integer;

 begin
   textcolor(col[7]);textbackground(col[5]);
   cmin:=1;
   while not(Tabella^[cmin].flag) do cmin:=cmin+1;
   min:=abs(Tabella^[cmin].x-px)+abs(Tabella^[cmin].y-py);

   if UltimoCampo>=2 then
     begin
     for i:=cmin+1 to UltimoCampo do
       begin
       dist:=abs(Tabella^[i].x-px)+abs(Tabella^[i].y-py);
       if (dist<min)and(Tabella^[i].flag) then
         begin
         min:=dist;
         cmin:=i
         end
       end;
     trovacampo:=cmin
     end
   else trovacampo:=1
 end;





function spostamento:boolean;
begin
nuovocampo:=trovacampo(M_X,M_Y);
if nuovocampo<>campo then spostamento:=true
else spostamento:=false
end;
{$I mouse}

BEGIN
  READ_KBD:=FALSE;
  M_ATT:=false;
  REPEAT
  if M_Attivo then M_ATT:=(spostamento)or(pdes)or(pcen)or(psin)or(M_Y<2)
  UNTIL (KEYpressed_N)or(M_ATT);
  if M_ATT then
    begin
      READ_KBD:=true;
      if psin then ch:=chr(122)
      else
        begin
        if pcen then ch:=chr(121)
        else
          begin
          if pdes then ch:=chr(123)
          else
            begin
            if M_y>1 then ch:=chr(120) {else ch:=chr(27)}
            end
          end
        end
    end
  else
    begin
      if play then
      begin
        ch:=nastro.car;
        if not eof(fnastro) then
          begin
          read(fnastro,nastro);
          NumStep:=NumStep+1;
          end
        else closeplay;
      end
      else
      begin
        turbo3.READkbd(CH);
        if rec then
          begin
          nastro.car:=ch;
          nastro.mouse:=false;
          nastro.tempo:=timecorr;
          write(fnastro,nastro);
          end;
      end;
      IF KEYpressed_N AND (ORD(CH)=27) THEN
        BEGIN
        READ_KBD:=TRUE;
          if play then
          begin
            ch:=nastro.car;
            if not eof(fnastro) then
              begin
              read(fnastro,nastro);
              NumStep:=NumStep+1;
              end
            else closeplay;
          end
          else
          begin
            READKBD(CH);
            if rec then
              begin
              nastro.car:=ch;
              nastro.mouse:=false;
              write(fnastro,nastro);
              end;
          end;
        END
    end;
Composto:=false;
END;        { FUNC. READ_KBD }


FUNCTION LINE_INPUT(X,Y,L:INTEGER;
                VAR STARTCURPOS:INTEGER;
                    FILLCHAR:CHAR;
                    PRESETFIELD:LINESTR;
                    SETCODE:INTEGER;
                VAR EXITCHAR:CHAR;
                    FlagEND:BOOLEAN;
                VAR ModFlag:BOOLEAN;
                    campo:integer;
                    nomemask:st80;
                    Var ridis:boolean):LINESTR;
  VAR
    CHL:STRING[80];
    I,O,LP:INTEGER;
    XOFF:INTEGER;        { Offset su x rispetto a X start }
    OUTKEY,INSMODE,OK:BOOLEAN;
    CH:CHAR;
    RIGHTSTR:LINESTR;
    ST1:STRING[1];
    Result:RECORD
             AX,BX,CX,DX,BP,SI,DI,DS,ES,Flags:INTEGER;
           END;
    ChlTemp:String;


PROCEDURE EXITINSMODE;
BEGIN
  IF INSMODE THEN
  BEGIN
    INSMODE:=FALSE;
    RESULT.AX:=256;
    RESULT.CX:=256*6+7;          { Start=6 / End=7 }
    INTR(16,Dos.Registers(RESULT));
  END;
END;      { PROC. EXITINSMODE }

BEGIN
  Ridis:=false;
  textcolor(col[7]);textbackground(col[5]);
  OUTKEY:=FALSE;
  INSMODE:=FALSE;
  ModFlag:=FALSE;
  EXITCHAR:=' ';
  FILLCHAR:=' ';
  PRESETFIELD:=COPY(PRESETFIELD,1,L);
  LP:=LENGTH(PRESETFIELD);
  CHL:='';
  IF LP<=L THEN CHL:=PRESETFIELD ELSE EXIT;
  FOR I:=LP+1 TO L DO CHL:=CHL+FILLCHAR;

  IF STARTCURPOS=0 THEN XOFF:=LP+1 ELSE XOFF:=STARTCURPOS;
  IF XOFF>L THEN XOFF:=L;
  GOTOXY(X+XOFF-1,Y);
    REPEAT
      IF READ_KBD(CH,campo) THEN
      BEGIN
        O:=ORD(CH);
        {gotoxy(1,1);write(o);clreol;}
        IF O<>82 THEN EXITINSMODE;
        IF FlagEND AND ((O=115) OR (O=116)) THEN
        BEGIN
          IF O=115 THEN O:=75 ELSE O:=77;
          EXITCHAR:=CHR(O);
          OUTKEY:=TRUE;
        END
        ELSE
        CASE O OF
          75:IF XOFF>1 THEN BEGIN XOFF:=XOFF-1;GOTOXY(X+XOFF-1,Y); END
                       ELSE BEGIN OUTKEY:=TRUE;EXITCHAR:=CH; END;
          77:IF XOFF<L THEN
                        BEGIN
                           XOFF:=XOFF+1;
                           GOTOXY(X+XOFF-1,Y);
                           if (L > 19) and (XOff = L-4) then write(^G);
                        END
                       ELSE
                        BEGIN
                           OUTKEY:=TRUE;
                           EXITCHAR:=CH;
                        END;
         115:BEGIN XOFF:=1;GOTOXY(X+XOFF-1,Y); END;
         116:BEGIN
               XOFF:=L;
               WHILE (COPY(CHL,XOFF,1)=FILLCHAR) AND (XOFF>1)  DO XOFF:=XOFF-1;
               IF (XOFF<L) AND NOT ((XOFF=1) AND (COPY(CHL,1,1)=FILLCHAR)) THEN XOFF:=XOFF+1;
               GOTOXY(X+XOFF-1,Y);
             END;
          82:(*IF (NOMEMASK<>'')AND(campo<>0)and
             (exist(Nomelista(Nomemask,Tabella^[campo].NCampotab))) then
               begin
               ChlTemp:=SelectCampo(NomeMask,Tabella^[campo].NCampoTab);
               if chltemp<>'' then Chl:=ChlTemp;
               Ridis:=true;
               outkey:=true;
               ExitChar:=#13;
               end
             else*)
             begin
               IF NOT INSMODE THEN
               BEGIN
                 RESULT.AX:=256;
                 RESULT.CX:=256*3+7;          { Start=3 / End=7 }
                 INTR(16,Dos.Registers(RESULT));
                 INSMODE:=TRUE;
               END
               ELSE EXITINSMODE;
             end;
          83:BEGIN
               ModFlag:=TRUE;
               DELETE(CHL,XOFF,1);
               CHL:=CHL+FILLCHAR;
               WRITE(COPY(CHL,XOFF,L-XOFF+1));
               GOTOXY(X+XOFF-1,Y);
             END
        ELSE BEGIN
               OUTKEY:=TRUE;
               EXITCHAR:=CH;
             END;
        END;    { CASE O OF......... }
        GOTOXY(X+XOFF-1,Y);
      END
      ELSE BEGIN            { read_kbd ha prodotto un codice semplice }
        O:=ORD(CH);
        IF (O>0) AND (O<32) THEN
        BEGIN
        IF (O=8) THEN
        BEGIN
         IF XOFF>1 THEN
         BEGIN
          ModFlag:=TRUE;
          EXITINSMODE;
          XOFF:=XOFF-1;
          GOTOXY(X+XOFF-1,Y);
          DELETE(CHL,XOFF,1);
          CHL:=CHL+FILLCHAR;
          WRITE(COPY(CHL,XOFF,L-XOFF+1));
          GOTOXY(X+XOFF-1,Y);
         END;
        END ELSE
        BEGIN
          OUTKEY:=TRUE;
          EXITCHAR:=CH;
        END;
        END
        ELSE BEGIN
          OK:=FALSE;
          CASE SETCODE OF
            1:CASE CH OF
                '0'..'9','.':OK:=TRUE;
              END;
            2:CASE CH OF
                '0'..'9','.','E','e','+','-':OK:=TRUE;
              END;
            3:CASE ORD(CH) OF
                32..255:OK:=TRUE;
              END;
            4:OK:=TRUE;   { Spazio per inserire un set specializzato }
          END;
          IF OK THEN
          BEGIN
            ModFlag:=TRUE;
            IF INSMODE THEN
            BEGIN
              INSERT(CH,CHL,XOFF);
              WRITE(COPY(CHL,XOFF,L-XOFF+1));
            END
            ELSE
            BEGIN
              WRITE(CH);
              CHL[XOFF]:=CH;
            END;
            IF XOFF<L THEN
             begin
                XOFF:=XOFF+1;
                GOTOXY(X+XOFF-1,Y);
                if (L > 19) and (XOff = L-4) then write(#7);
             end
            else
             begin
                OutKey:=true;
                ExitChar:=#77;
             end;

          END;
        END;
      END;    { IF  READ_KBD THEN......... }
    UNTIL OUTKEY;
    STARTCURPOS:=XOFF;
    EXITINSMODE;
    XOFF:=L;
    WHILE (COPY(CHL,XOFF,1)=FILLCHAR) AND (XOFF>1) DO XOFF:=XOFF-1;
    IF (XOFF=1) AND (COPY(CHL,1,1)=FILLCHAR) THEN LINE_INPUT:=''
                                             ELSE LINE_INPUT:=COPY(CHL,1,XOFF);
END;        { PROC. LINE_INPUT }
end.