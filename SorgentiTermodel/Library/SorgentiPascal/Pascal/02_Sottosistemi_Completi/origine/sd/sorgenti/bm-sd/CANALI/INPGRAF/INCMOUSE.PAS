
var registri:registers;



{************************** EXIST *****************************************}

 function Exist(Nome:st80):boolean;
 var f:file;
 begin
    exist:=false;
    {$I-} assign(f,Nome);reset(f);{$I+}
    if (ioresult=0) then
    begin
      close(f);
      Exist:=true
    end;
 end;


{************************** EXIST *****************************************}

 function ExistS(Nome:st80):boolean;
 var f:file;
 begin
    existS:=false;
    {$I-} assign(f,Nome);rewrite(f);{$I+}
    if (ioresult=0) then
    begin
      close(f);
      ExistS:=true
    end;
 end;

{-------------------------- cursor off -------------------------------------}
procedure cursor_off;
begin
registri.ax:=2;
intr(8,registri);
end;

{-------------------------- cursor on  -------------------------------------}

Procedure cursor_on;
begin
registri.ax:=1;
intr(8,registri);
end;


{--------------------------- INIT MOUSE ------------------------------------}

function  initmouse(var mousetype:st80):integer;
begin
registri.AX:=0;
intr(51,registri);

if registri.AX<>0 then
   begin
   initmouse:=1;
   if registri.BX=2 then mousetype:='Microsoft mouse:2 pulsanti'
                    else mousetype:='Mouse sistem mouse:3 pulsanti';
   end
else
   begin
   initmouse:=0;
   Mousetype:='Mouse non installato ';
   end;
end;


{-------------------------- M_Attivo --------------------------------------}
function M_attivo(var x,y:real;var sw:INTEGER):boolean;
begin
M_attivo:=false;
readlocator(@X,@Y,@sw);
if (sw<>128)or(mousepres) then
  begin
  if sw>127 then M_attivo:=true;
  end
else M_attivo:=false;
  pdes:=false;pcen:=false;psin:=false;
  if sw=132 then psin:=true;
  if sw=130 then pdes:=true;
end;


{------------------------  setpos ------------------------------------------}

procedure setpos(x,y:integer);
begin
registri.ax:=4;
registri.cx:=x;
registri.dx:=y;
intr(51,registri);
end;
{------------------------- get mouse   -------------------------------------}

procedure getmouse(var x,y:integer;var pd,pc,ps:boolean);
var bmask:word;
begin
registri.ax:=3;
intr(51,registri);
x:=registri.cx div MIngX;
y:=registri.dx div MingY;
bmask:=1;
if (registri.bx and bmask)>0 then ps:=true else ps:=false;
bmask:=2;
if (registri.bx and bmask)>0 then pd:=true else pd:=false;
bmask:=4;
if (registri.bx and bmask)>0 then pc:=true else pc:=false;
{gotoxy(1,24);write('x:',x,'  y:',y,'  ps:',ps,'  pc:',pc,'  pd:',pd,'    ');}
end;


{------------------------- Mouse init --------------------------------------}
procedure mouse_init;

begin
  if initmouse(mouset)=0 then mousepres:=false
  else
  begin
  mousepres:=true;
  {rangex(1,MIngX*80);
  rangey(1,MIngY*25);}
  cursor_off;
  {getmouse(xprec,yprec,pdes,pcen,psin)}
  end
end;

{--------------------------- M_On ------------------------------------------}
procedure M_ON;
begin
mousepres:=mousetemp;
end;
{--------------------------- M_Off ------------------------------------------}
procedure M_Off;
begin
mousetemp:=mousepres;
mousepres:=false;
end;



{----------------------------  LINE_INPUT  -----------------------------------}

FUNCTION READ_KBD(VAR CH:CHAR;campo:integer):BOOLEAN;
var M_ATT:boolean;

 function trovacampo(px,py:integer):integer;
 var i,min,cmin,dist:integer;

 begin
   {textcolor(col[7]);textbackground(col[5]);}
   cmin:=1;
   while not(tabella[cmin].flag) do cmin:=cmin+1;
   min:=abs(tabella[cmin].x-px)+abs(tabella[cmin].y-py);

   if UltimoCampo>=2 then
     begin
     for i:=cmin+1 to UltimoCampo do
       begin
       dist:=abs(tabella[i].x-px)+abs(tabella[i].y-py);
       if (dist<min)and(tabella[i].flag) then
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
Spostamento:=false;
if mousepres then
  begin
  nuovocampo:=trovacampo(round(M_X),round(M_Y));
  if nuovocampo<>campo then spostamento:=true
  end
end;

BEGIN
  READ_KBD:=FALSE;
  M_ATT:=false;
  REPEAT
  if (M_Attivo(m_x,M_y,sw)) then
    begin
    M_ATT:=(spostamento)or(pdes)or(pcen)or(psin);
    end;
  UNTIL (KEYpressed)or(M_ATT);
  if M_ATT then
    begin
      READ_KBD:=true;
      if psin then ch:=chr(61)
      else
        begin
        if pcen then ch:=chr(122)
        else
          begin
          if pdes then ch:=chr(27)
          else
            begin
            {if M_y>1 then} ch:=chr(120) {else ch:=chr(27)}
            end
          end
        end
    end
  else
    begin
      READKBD(CH);
      IF KEYpressed AND (ORD(CH)=27) THEN
        BEGIN
          READKBD(CH);
          READ_KBD:=TRUE;
        END
    end
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


FUNCTION LINE_INPUT(Xt,Yt,L:INTEGER;
                VAR STARTCURPOS:INTEGER;
                    FILLCHAR:CHAR;
                    PRESETFIELD:LINESTR;
                    SETCODE:INTEGER;
                VAR EXITCHAR:CHAR;
                    FlagEND:BOOLEAN;
                VAR ModFlag:BOOLEAN;
                    campo:integer):LINESTR;
  VAR
    CHL:STRING[80];
    I,O,LP:INTEGER;
    XOFF:INTEGER;        { Offset su x
     rispetto a X start }
    OUTKEY,INSMODE,OK:BOOLEAN;
    CH:CHAR;
    RIGHTSTR:LINESTR;
    ST1:STRING[1];
    Result:RECORD
             AX,BX,CX,DX,BP,SI,DI,DS,ES,Flags:INTEGER;
           END;
    lineatesto,lineatesto1:string;
    posiz:integer;


Procedure G_Write(s:string);
var ct,cf,i:integer;
    p1,p2:real;
    swr:string;
begin
ct:=7;
cf:=0;
for i:=1 to length(s) do
lineatesto[posiz+i-1]:=s[i];

movtcurabs1(@real1,@real2);
lineatesto1:=copy(lineatesto,1,posiz+length(s)-1);
posiz:=posiz+length(s);
swr:=lineatesto1;
text1(@swr);

end;


Procedure G_GOTOXY(xcar,ycar:real);
begin
posiz:=round(xcar-xt+1);
lineatesto1:=copy(lineatesto,1,posiz-1);
real1:=xt;real2:=yt;
movtcurabs1(@real1,@real2);
text1(@lineatesto);
movtcurabs1(@real1,@real2);
SetFillStyle(1,15);
setcolor(0);
text1(@lineatesto1);
SetFillStyle(1,Colsfond);
setcolor(ColText);
end;


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
  {G_textcolor(col[7]);G_textbackground(col[5]);}
  real1:=xt;real2:=yt;
  movtcurabs1(@real1,@real2);
  OUTKEY:=FALSE;
  INSMODE:=FALSE;
  ModFlag:=FALSE;
  EXITCHAR:=' ';
  PRESETFIELD:=COPY(PRESETFIELD,1,L);
  lineatesto:=presetfield;
  LP:=LENGTH(PRESETFIELD);
  CHL:='';
  IF LP<=L THEN CHL:=PRESETFIELD ELSE EXIT;
  FOR I:=LP+1 TO L DO CHL:=CHL+FILLCHAR;

  IF STARTCURPOS=0 THEN XOFF:=LP+1 ELSE XOFF:=STARTCURPOS;
  IF XOFF>L THEN XOFF:=L;
  G_GOTOXY(Xt+XOFF-1,Y);
    REPEAT
      IF READ_KBD(CH,campo) THEN
      BEGIN
        O:=ORD(CH);
        IF O<>82 THEN EXITINSMODE;
        IF FlagEND AND ((O=115) OR (O=116)) THEN
        BEGIN
          IF O=115 THEN O:=75 ELSE O:=77;
          EXITCHAR:=CHR(O);
          OUTKEY:=TRUE;
        END
        ELSE
        CASE O OF
          75:IF XOFF>1 THEN BEGIN XOFF:=XOFF-1;G_GOTOXY(Xt+XOFF-1,Y); END
                       ELSE BEGIN OUTKEY:=TRUE;EXITCHAR:=CH; END;
          77:IF XOFF<L THEN
                        BEGIN
                           XOFF:=XOFF+1;
                           G_GOTOXY(Xt+XOFF-1,Y);
                           if (L > 19) and (XOff = L-4) then write(^G);
                        END
                       ELSE
                        BEGIN
                           OUTKEY:=TRUE;
                           EXITCHAR:=CH;
                        END;
         115:BEGIN XOFF:=1;G_GOTOXY(Xt+XOFF-1,Y); END;
         116:BEGIN
               XOFF:=L;
               WHILE (COPY(CHL,XOFF,1)=FILLCHAR) AND (XOFF>1)  DO XOFF:=XOFF-1;
               IF (XOFF<L) AND NOT ((XOFF=1) AND (COPY(CHL,1,1)=FILLCHAR)) THEN XOFF:=XOFF+1;
               G_GOTOXY(Xt+XOFF-1,Y);
             END;
          82:IF NOT INSMODE THEN
             BEGIN
               RESULT.AX:=256;
               RESULT.CX:=256*3+7;          { Start=3 / End=7 }
               INTR(16,Dos.Registers(RESULT));
               INSMODE:=TRUE;
             END
             ELSE EXITINSMODE;
          83:BEGIN
               ModFlag:=TRUE;
               DELETE(CHL,XOFF,1);
               CHL:=CHL+FILLCHAR;
               G_write(COPY(CHL,XOFF,L-XOFF+1));
               G_GOTOXY(Xt+XOFF-1,Y);
             END
        ELSE BEGIN
               OUTKEY:=TRUE;
               EXITCHAR:=CH;
             END;
        END;    { CASE O OF......... }
        G_GOTOXY(Xt+XOFF-1,Y);
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
          G_GOTOXY(Xt+XOFF-1,Y);
          DELETE(CHL,XOFF,1);
          CHL:=CHL+FILLCHAR;
          G_write(COPY(CHL,XOFF,L-XOFF+1));
          G_GOTOXY(Xt+XOFF-1,Y);
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
              G_WRITE(COPY(CHL,XOFF,L-XOFF+1));
            END
            ELSE
            BEGIN
              G_WRITE(CH);
              CHL[XOFF]:=CH;
            END;
            IF XOFF<L THEN
             begin
                XOFF:=XOFF+1;
                G_GOTOXY(Xt+XOFF-1,Y);
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




