
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


Procedure ReadKbd(Var ch:Char);
Begin
if play then
  begin
  repeat until timecorr >Nastro.Tempo;
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
  if rec then
  if Not(Composto) then nastro.tempo:=timecorr;
  turbo3.READKBD(CH);
  if rec then
    begin
    If (ord(ch)=27)and(keypressed) then composto:=true else composto:=false;
    nastro.car:=ch;
    nastro.mouse:=false;
    write(fnastro,nastro);
    end;
  end;
end;

{----------------------------  LINE_INPUT  -----------------------------------}

FUNCTION READ_KBD(VAR CH:CHAR;campo:integer):BOOLEAN;
var M_ATT:boolean;

 function trovacampo(px,py:integer):integer;
 var i,min,cmin,dist:integer;

 begin
   textcolor(col[7]);textbackground(col[5]);
   cmin:=1;
   while not(tabella^[cmin].flag) do cmin:=cmin+1;
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
            if M_y>1 then ch:=chr(120) else ch:=chr(27)
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
        READKBD(CH);
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


PROCEDURE LEGGI_KBD(VAR CH:Integer);
var
  Cha:char;
BEGIN
    REPEAT
    UNTIL KEYpressed;
      READKBD(CHA);
      CH:=ORD(CHA);
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
    ChlTemp,chltemp1:String;
    campopostins,rigains:integer;
    n_lista:string;

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

      123,82:begin
               n_lista:='';
               chltemp:='';
               chltemp1:='';
               n_lista:=Nomelista(Nomemask,Tabella^[campo].NCampotab);
               if (n_lista>'')and exist(n_lista) and
               (NOMEMASK<>'')AND(campo<>0)
               (*exist(Nomelista(Nomemask,Tabella^[campo].NCampotab)))*) then
               begin
                 SelectCampo(NomeMask,Tabella^[campo].NCampoTab,chltemp,chltemp1);
                 if ar_ins^[Tabella^[campo].NCampoTab].ncampoagg=0 then
                 begin
                   if chltemp<>'' then Chl:=ChlTemp;
                 end
                 else
                 begin
                   if chltemp1<>'' then
                   begin
                     Chl:=ChlTemp1;
                     if ar_ins^[Tabella^[campo].NCampoTab].ncampiriga>0 then
                     begin
                       rigains:=campo div ar_ins^[Tabella^[campo].NCampoTab].ncampiriga;
                       if campo mod ar_ins^[Tabella^[campo].NCampoTab].ncampiriga<> 0 then
                       rigains:=rigains+1;
                       campopostins:=(rigains-1)*ar_ins^[Tabella^[campo].NCampoTab].ncampiriga+
                                ar_ins^[Tabella^[campo].NCampoTab].ncampoagg;
                     end
                     else campopostins:=ar_ins^[Tabella^[campo].NCampoTab].ncampoagg;
                     aggiornadato(chltemp,campopostins);
                     writecampi(campopostins,true);
                   end;
                 end;
                 Ridis:=true;
                 outkey:=true;
                 ExitChar:=#82;
               end
               else
               begin
                 if O =82 then
                 begin
                   IF NOT INSMODE THEN
                   BEGIN
                     RESULT.AX:=256;
                     RESULT.CX:=256*3+7;          { Start=3 / End=7 }
                     INTR(16,Dos.Registers(RESULT));
                     INSMODE:=TRUE;
                   END
                   ELSE EXITINSMODE;
                 end
                 else
                 begin
                   OUTKEY:=TRUE;
                   EXITCHAR:=CH;
                 end;
               end;
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
            5:ok:=false;
          END;
          IF OK THEN
          BEGIN
            tabella^[campo].modificato:=true;
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
