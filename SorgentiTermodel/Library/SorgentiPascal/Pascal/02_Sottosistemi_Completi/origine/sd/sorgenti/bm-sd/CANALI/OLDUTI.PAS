
Unit utilitie;

Interface

Uses
{$Ifdef Win}
  Wincrt,
{$else}
  Crt,
  Dos,
{$endif}
  Turbo3, {Unit found in TURBO3.TPU}
  defuti,TIPIDUCT,WM;

(*
function UpString(St:st126):st126;

function Exist(Nome:st80):boolean;

function ExistDir(Nome:st80):boolean;

FUNCTION READ_KBD(VAR CH:CHAR;campo:integer):BOOLEAN;

PROCEDURE LEGGI_KBD(VAR CH:Integer);

FUNCTION LINE_INPUT(X,Y,L:INTEGER;
                VAR STARTCURPOS:INTEGER;
                    FILLCHAR:CHAR;
                    PRESETFIELD:LINESTR;
                    SETCODE:INTEGER;
                VAR EXITCHAR:CHAR;
                    FlagEND:BOOLEAN;
                VAR ModFlag:BOOLEAN;
                    campo:integer):LINESTR;

FUNCTION SETLEFT(ST:STring):STring;

FUNCTION SETRIGHT(ST:ST126):ST126;

FUNCTION FORMAT(ST:ST126;StLength:INTEGER):ST126;

Function FormST(ST:ST126):St126;

function WritePrezzo(I:real):st20;

function Conferma(Nome,Aggiunta:st80;i:integer):boolean;

procedure WriteCampi(i:integer;NotZero:boolean);

procedure CarAddress(Base,OffSet:word);

procedure StampaMappa(CField:integer);

procedure UsaMaskera(Base,OffSet:word;NomeFile:st80;
                     var Campo,Chiave:integer;
                     CField,CText:integer;W,WVal,all,notzero:boolean);

procedure M_UsaMaskera(M_Base,M_OffSet:word;M_NomeFile,menu:st80;
                     var M_Campo,M_Chiave,chiave1:integer;
                     M_CField,M_CText:integer;M_W,M_WVal,M_all,M_notzero,initmenu:boolean);



function SpaceTab(InADDR:word):integer;

procedure IOTabella(ISeg,IOfs:word;NDat,DatP,DatR:integer;var Chiave,Riga,campo:integer;
                     mask:st80;SetNRighe,InitMask,IWVal,IWCampo:boolean);
  {... ISeg & IOfs contengono il SEG e l'OFS della tabella
   ... NDat ä il numero totale di righe
   ... DatP ä il numero di righe per pagina
   ... DatR ä il numero di elementi per riga
   ... Riga contiene il N. della riga da cui si ä usciti
   ... IWVal e' true se si fa riferimento all'ultima tabella usata :
       in tal caso si puo' specificare con riga la riga di accesso alla tabella
   ... IWCampo e' true se si fa riferimento all'ultima tabella usata :
       in tal caso si puo' specificare con campo il campo di accesso alla tabella
       il Campo ha precedenza sulla riga se IWCampo e' true ,cioe` il cursore
       si posizionera' sulla tabella in base al valore del campo e non della riga
   ... SetNRighe = true se si vogliono numerare  le righe della tabella

                   in tal caso occorre che il primo campo della tabella
                   venga introdotto in riga 8.
                                                               }


procedure Frame(UpperLeftX, UpperLeftY, LowerRightX, LowerRightY: Integer);

procedure testata(Fondo,Testo:integer;titolo:st80);

procedure scelta_Menu(Menu:datimenu;nmenu,x,y,FondoT,TestoT,Testo:integer;var n:integer;descr_Menu:st80);

function UsaMenu(NomeFile:st80;Nmenu:integer):integer;

procedure testmenu(nomemsk:st80);

function scorretestata(nomemnu:st80):integer;

procedure M_IOTabella(M_ISeg,M_IOfs:word;M_NDat,M_DatP,M_DatR:integer;var M_Chiave,chiave1,M_Riga,M_Campo:integer;
          M_mask,menu:st80;M_SetNRighe,M_InitMask,M_IWVal,M_IWCampo,InitMenu:boolean);

procedure GetVideo;
procedure SetCursor(inizio,fine:integer);{ setta le dimensioni del cursore }
procedure CrsOn; { Riporta il cursore allo stato normale }
procedure CrsOff;

procedure mouse_init;
procedure rangey(ymin,ymax:integer);
procedure rangex(xmin,xmax:integer);
procedure getmouse(var x,y:integer;var pd,pc,ps:boolean);
procedure setpos(x,y:integer);
Procedure cursor_on;
function  initmouse(var mousetype:string):integer;
function  M_attivo:boolean;
procedure M_Off;
procedure M_ON;
procedure gesterror;
procedure errori(rap,cs,rim:st8);
function IntToHex(IntNum:integer):st4;
*)
{===========================================================================}

Implementation

{$I mouse}

var scrn_char : char;
    attrib,Mode_video,colnum,page_disp:byte;

 TYPE
    REgister = Record
               Case integer of

           0:  (AX,BX,CX,DX,BP,SI,DI,DS,ES,FLAGS:WORD);
           1:  (AL,AH,BL,BH,CL,CH,DL,DH: Byte);
            END;
 var parms : register;




procedure GetVideo;

begin
   parms.AX:=$0f00;
   intr(16,Dos.Registers(parms));
   mode_video:=Lo(parms.AX);
   colnum:=Hi(parms.AX);
   page_disp:=Hi(parms.BX);
end;


procedure SetCursor(inizio,fine:integer);(* setta le dimensioni del cursore *)

begin
   parms.AX:=$0100;
   parms.CX:=inizio shl 8 or fine;
   intr(16,Dos.Registers(parms));
end;


procedure CrsOn; (* Riporta il cursore allo stato normale *)

var line_set:integer;

begin
   line_set:=$0607;

   parms.AX:=$0100;
   parms.CX:=line_set;
   intr(16,Dos.Registers(parms));
end;


procedure CrsOff;

var line_set:integer;

begin
    line_set:=$0E0D;

   parms.AX:=$0100;
   parms.CX:=line_set;
   intr(16,Dos.Registers(parms));
end;


procedure PrintScreen;

begin
   inline($55/$CD/$05/$5D); (* chiamata diretta dell'interupt 5 *)
end;





procedure ReadScreen;

begin
   parms.ax:=$0800;
   parms.BX:=0;
   intr(16,Dos.Registers(parms));
   scrn_char:=chr(Lo(parms.AX));
   attrib:=Hi(parms.AX);
end;


procedure VisProgetto(NProg:St18);
 begin
    window(1,2,80,25);
    gotoxy(1,1);ClrEol;
    TextBackground(col[17]);TextColor(col[18]);
    gotoxy(1,1);
    write(W_M(1),NProg);  {' Progetto N. '}
    TextBackground(col[1]);
    window(1,3,80,25);
 end;

function Conferma(Nome,Aggiunta:st80;i:integer):boolean;
var f      : text;
    Riga   : st80;
    k      : integer;
    ch,chX : char;
begin
   assign(f,Nome);
   reset(f);
   for k:=1 to i do readln(f,Riga);
   close(f);
   Riga:=Riga + Aggiunta;
   { write(chr(7));}
   textbackground(4);   textcolor(14);

   repeat
      gotoxy(1,21);  write(Riga);
      textbackground(col[1]);   textcolor(col[2]);   ClrEol;
      repeat
         readkbd(ch);
{S,N}         if not (UpCase(ch) in [CH1,CH2]) then write(#7);
{S,N}      until UpCase(ch) in [CH1,CH2];
      textbackground(4);   textcolor(14);
      write('--> ',ch);
      readkbd(chX);
   until chX = #13;

   gotoxy(1,21);
   textbackground(col[1]);   textcolor(col[2]);   ClrEol;
{S}   Conferma:=(UpCase(ch) =CH1);
end;


 function UpString(St:st126):st126;
 var c,i:integer;
 begin
    c := LENGTH(St);
    FOR i := 1 TO c DO
      St[i] := UPCASE(St[i]);
    UpString:=St;
 end;

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

function ExistDir(Nome:st80):boolean;
 var f:file;
 begin
    {$I-}   chdir(Nome);  {$I+}
    if IOResult = 0 then
     begin
        ExistDir:=true;
     end
    else ExistDir:=false;
 end;



{----------------------------  LINE_INPUT  -----------------------------------}

FUNCTION READ_KBD(VAR CH:CHAR;campo:integer):BOOLEAN;
var M_ATT:boolean;

 function trovacampo(px,py:integer):integer;
 var i,min,cmin,dist:integer;

 begin
   textcolor(col[7]);textbackground(col[5]);
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
nuovocampo:=trovacampo(M_X,M_Y);
if nuovocampo<>campo then spostamento:=true
else spostamento:=false
end;

BEGIN
  READ_KBD:=FALSE;
  M_ATT:=false;
  REPEAT
  if M_Attivo then M_ATT:=(spostamento)or(pdes)or(pcen)or(psin)or(M_Y<2)
  UNTIL (KEYpressed)or(M_ATT);
  if M_ATT then
    begin
      READ_KBD:=true;
      if psin then ch:=chr(121)
      else
        begin
        if pcen then ch:=chr(122)
        else
          begin
          if pdes then ch:=chr(123)
          else
            begin
            if (M_y>1)or(not(exit_up)) then ch:=chr(120) else ch:=chr(27)
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


FUNCTION LINE_INPUT(X,Y,L:INTEGER;
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
    XOFF:INTEGER;        { Offset su x rispetto a X start }
    OUTKEY,INSMODE,OK:BOOLEAN;
    CH:CHAR;
    RIGHTSTR:LINESTR;
    ST1:STRING[1];
    Result:RECORD
             AX,BX,CX,DX,BP,SI,DI,DS,ES,Flags:INTEGER;
           END;


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


{--------------------------------  SETLEFT  ----------------------------------}
FUNCTION SETLEFT(ST:STRING):STRING;
BEGIN
  WHILE (COPY(ST,1,1)=' ') AND (ST>'') DO ST:=COPY(ST,2,LENGTH(ST)-1);
  SETLEFT:=ST;
END;     { FUNC. SETLEFT }

{--------------------------------  SETright  ----------------------------------}
FUNCTION SETRIGHT(ST:ST126):ST126;
VAR
  I:INTEGER;
BEGIN
  I:=LENGTH(ST);
  while (I > 1) and (ST[i] = ' ') do i:=i-1;
  if i = 1 then
   begin
     if st[i] = ' ' then i:=0;
   end;

  if i = 0 then SetRight:=''
  else SETRIGHT:=COPY(ST,1,I);

END;     { FUNC. SETRIGHT }



{----------------------------  FORMAT_STRING  --------------------------------}
FUNCTION FORMAT(ST:ST126;StLength:INTEGER):ST126;
BEGIN
  ST:=COPY(ST,1,StLength);
  FORMAT:=ST+COPY(Fill,1,StLength-LENGTH(ST));
END;      { FUNC.  FORMAT }

Function FormST(ST:ST126):St126;
begin
   St:=(SetLeft(SetRight(St)));
   FormSt:=UpString(St);
end;


function WritePrezzo(I:real):st20;   { --- st18 --- }
var Riga :st20;
    Riga1:st20;
    j,L,k:integer;

begin
   Riga:='';   Riga1:='';
   Str(I:20:0,Riga);
   Riga:=SetLeft(Riga);

   L:=length(Riga);

   while L mod 3 <> 0 do
    begin
       Riga:=' '+Riga;
       L:=length(Riga);
    end;
   j:=1;
   k:=1;
   if L > 3 then
    begin
       repeat
          if j mod 3 = 0 then
           begin
              Riga1[k]:=Riga[j];
              Riga1:=Riga1+riga1[k];
              if j < L then
               begin
                  Riga1[k+1]:='.';
                  Riga1:=Riga1+riga1[k+1];
                  k:=k+2;
               end;
           end
          else
          begin
             Riga1[k]:=Riga[j];
             riga1:=riga1+riga1[k];
             k:=k+1;
          end;
         j:=j+1;

       Until (j > L) or (Riga[j]='');;
       riga1:=setleft(riga1);
       WritePrezzo:=Riga1;
    end
   else WritePrezzo:=Riga;
end;

 procedure WriteCampi1(xmin,ymin,xmax,ymax:integer);
  var I,A:integer;
      Dato:LineStr;
      pint:^integer;
      preal:^real;
      pchar:^char;
      pstr:^string;
      notzero:boolean;
  begin
     notzero:=true;
     for i:=1 to UltimoCampo do
      begin
         with Tabella[I] do
          begin
             case Tipo of
               'I','i':
                 begin
                    PInt:=ptr(BAddr,OAddr);
                    if notzero and (PInt^ = 0) then Dato:='  '
                    else
                     begin
                        str(PInt^:L,Dato);
                        Dato:=setleft(Dato);
                     end;
                 end;
               'R','r':
                 begin
                    PReal:=ptr(BAddr,OAddr);
                    if notzero and (PReal^ = 0) then Dato:='  '
                    else
                     begin
                        str(PReal^:L:CifreDec,Dato);
                        Dato:=setleft(Dato);
                     end;
                 end;
               '$','s':
                 begin
                    PStr:=ptr(BAddr,OAddr);
                    Dato:=PStr^;Dato:=setleft(dato);
                 end;
               'C','c':
                 begin
                    PChar:=ptr(BAddr,OAddr);
                    Dato:=' ';
                    Dato[1]:=PChar^;
                 end;
               else Dato:='';
             end;
             if (y>=ymin)and(y<=ymax)       and
             ( ( (x>=xmin)and(x<=xmax) )    or
               ( (x+l>=xmin)and(x+l<=xmax) )or
               ( (x<=xmin)and(x+l>=xmax)) )
              then
               begin
               gotoxy(x,y);
               write(format(Dato,L))
               end
          end;
      end;

   textcolor(col[4]);
   textbackground(col[3]);


    for i:=1 to ninfo do
    with info[i] do
      begin
      A:=length(mess[i]);
      if (iy>=ymin)and(iy<=ymax)       and
        ( ( (ix>=xmin)and(ix<=xmax) )    or
         ( (ix+A>=xmin)and(ix+A<=xmax) )or
       ( (ix<=xmin)and(ix+A>=xmax)) )
      then
        begin
         gotoxy(ix,iy);
         write(mess[i])
        end;
      end;
  end;


 procedure WriteCampi(i:integer;NotZero:boolean);
  var
      Dato:LineStr;
      PInt :^integer;
      PStr :^st240;
      PReal:^real;
      PChar:^char;
  begin
     with Tabella[I] do
      begin
         case Tipo of
          'I','i':
            begin
               PInt:=ptr(BAddr,OAddr);
               if notzero and (PInt^ = 0) then Dato:='  '
               else
                begin
                   str(PInt^:L,Dato);
                   Dato:=setleft(Dato);
                end;
            end;
          'R','r':
            begin
               PReal:=ptr(BAddr,OAddr);
               if notzero and (PReal^ = 0) then Dato:='  '
               else
                begin
                   str(PReal^:L:CifreDec,Dato);
                   Dato:=setleft(Dato);
                end;
            end;
          '$','s':
            begin
               PStr:=ptr(BAddr,OAddr);
               Dato:=PStr^;Dato:=setleft(dato);
            end;
          'C','c':
            begin
               PChar:=ptr(BAddr,OAddr);
               Dato[1]:=PChar^;
            end;
          else Dato:='';
         end;
         gotoxy(x,y);write(format(Dato,L));
      end;

   textcolor(col[4]);
   textbackground(col[3]);

   for i:=1 to ninfo do
   with info[i] do
   begin
     gotoxy(ix,iy);
     write(mess[i])
   end;

  end;



 procedure CarAddress(Base,OffSet:word);
  var i:integer;
  begin
    for I:=1 to UltimoCampo do
     with Tabella[i] do
      begin
         BAddr:=Base;OAddr:=OffSet;
         case Tipo of
          'I','i':
            begin
               CifreInt:=L;
               OffSet:=OffSet+2;
            end;
          'R','r':
            begin
               CifreInt:=L;
               OffSet:=OffSet+6;
            end;
          '$','s':OffSet:=OffSet+L+1;
          'C','c':OffSet:=OffSet+L;
          else
         end;
      end;
  end;
 procedure StampaMappa1(xmin,ymin,xmax,ymax,CField:integer);
 var i,j,k:integer;
 begin
    gotoxy(1,1);
    TextColor(col[2]);
    j:=25;
    while (j > 1) and (SetRight(Mappa[j]) = '') do j:=j-1;
    for i:=1 to j do Mappa[i]:=SetRight(Mappa[i]);
    for i:=1 to j do
     begin
        if i >= 23 then
         begin
            textcolor(col[20]);
            textbackground(col[19]);
         end;
        if (i>=ymin)and(i<=ymax) then
        begin
        if length(mappa[i])<xmin then
          begin
          gotoxy(xmin,i);
          for k:=xmin to xmax do write(' ');
          end
        else
          begin
          if length(mappa[i])>=xmax then
            begin
            gotoxy(xmin,i);
            for k:=xmin to xmax do write(mappa[i][k])
            end
          else
            begin
            gotoxy(xmin,i);
            for k:=xmin to length(mappa[i]) do write(mappa[i][k]);
            for k:=length(mappa[i])+1 to xmax do write(' ')
            end
          end
        end
     end;
    textcolor(col[2]);
    textbackground(col[1]);
 end;



 procedure StampaMappa(CField:integer);
 var i,j:integer;
 begin
    gotoxy(1,1);
    TextColor(col[2]);
    j:=25;
    while (j > 1) and (SetRight(Mappa[j]) = '') do j:=j-1;
    for i:=1 to j do Mappa[i]:=SetRight(Mappa[i]);
    for i:=1 to j do
     begin
        if i >= 22 then
         begin
            textcolor(col[20]);
            textbackground(col[19]);
         end;
        if i < j then
          begin
          write(Mappa[i]);
          clreol;
          writeln('');
          end
        else
         begin
         clreol;
         write(Mappa[i]);
         end
     end;
    textcolor(col[2]);
    textbackground(col[1]);
 end;


  procedure CampoSucc(var Campo:integer);
   begin
      repeat
         if Campo >= UltimoCampo then Campo:=1
         else Campo:=Campo+1;
      until Tabella[Campo].Flag;
   end;

  procedure CampoPrec(var Campo:integer);
   begin
      repeat
         if Campo > 1 then Campo:=Campo-1
         else Campo:=UltimoCampo;
      until Tabella[Campo].Flag;
   end;



  procedure UsaMaskera(Base,OffSet:word;NomeFile:st80;
                       var Campo,Chiave:integer;
                       CField,CText:integer;W,WVal,all,notzero:boolean);

  var f     : text;
      PInt  : ^integer;
      PStr  : ^st240;
      PReal : ^real;
      PChar : ^char;



 procedure InitTabella;
  var i:integer;
  begin
     for i:=1 to 25 do Mappa[i]:=format(' ',79);
     for i:=1 to MaxCampi do
      with Tabella[i] do
       begin
          Flag:=false;
          Tipo:='n';
          L:=0;
          x:=0;y:=0;
          BAddr:=0;OAddr:=0;
          CifreInt:=0;CifreDec:=0;
       end;
  end;



 procedure LeggiMask(NomeF:st80);
  const
     x='ù';
     inf='®';
  var
     f:text;
     ch:char;
     variabile:String[240];
     I,J,Cx,Cy:integer;
     flag1:integer;
  begin
     ninfo:=0;
     UltimoAccesso:=0;
     I:=0;Cx:=0;Cy:=1;
     assign(f,NomeF);
     reset(f);
     while not(eof(f)) do
      begin
         read(f,ch);
         Cx:=Cx+1;
         if ch = x then
          begin
             I:=I+1;
             with Tabella[I] do
              begin
                 read(f,Tipo);
                 x:=Cx;y:=Cy;
                 Cx:=Cx+1;

                 variabile:='';
                 repeat
                    read(f,ch);
                    Cx:=Cx+1;
                    if ch in ['0'..'9'] then variabile:=variabile+ch;
                 until not(ch in['0'..'9']);

                 flag1:=0;
                 val(variabile,L,flag1);
                 if (flag1 <> 0) or (length(variabile) = 0) then L:=0;

                 if ch = ':' then
                  begin
                     variabile:='';
                     repeat
                        read(f,ch);
                        Cx:=Cx+1;
                        if ch in ['0'..'9'] then variabile:=variabile+ch;
                     until not(ch in['0'..'9']);
                     flag1:=0;
                     val(variabile,CifreDec,flag1);
                     if (flag1 <> 0) or (length(variabile) = 0) then CifreDec:=0;
                  end;

                 BAddr:=Base;OAddr:=OffSet;
                 case Tipo of
                   'I','i':
                     begin
                        CifreInt:=L;
                        OffSet:=OffSet+2;
                        Flag:=(Tipo = 'I');
                     end;
                   'R','r':
                     begin
                        if L > 0 then L:=L+1;
                        OffSet:=OffSet+6;
                        CifreInt:=L;
                        Flag:=(Tipo = 'R');
                     end;
                   '$','s':
                     begin
                        OffSet:=OffSet+L+1;
                        Flag:=(Tipo = '$');
                     end;
                   'C','c':
                     begin
                        OffSet:=OffSet+L;
                        Flag:=(Tipo = 'C');
                     end;
                   else
                 end;
(*                 writeln('ultimoCampo ',ultimocampo);delay(1000);*)
                 UltimoCampo:=I;
                 if Tipo in ['$','R','I','C'] then UltimoAccesso:=I;
             end;
          end;

         if ch = chr(13) then
          begin
             Cy:=Cy+1;
             Cx:=-1;
          end;

         if (ch <> #13) and (ch <> ' ') and (ch <> #10)  then
          begin
          if ch=inf then
            begin
            ninfo:=ninfo+1;
            with info[ninfo] do
              begin
              ix:=cx;iy:=cy;
              end
            end
          else
{            write(lst,' cy  ',cy,'  cx  ',cx);}
            if W then Mappa[Cy][Cx]:=ch;
          end;
      end;

     close(f);

     for i:=Cy+1 to 25 do Mappa[i]:='';


  end;


 function AggiornaDato(Dato:linestr;I:integer):boolean;
  var flag1:integer;
      Error:boolean;
      DatoInit:linestr;
  begin
     DatoInit:=Dato;
     flag1:=0;Error:=false;
     with Tabella[I] do
      begin
         case Tipo of
           'I','i':
             begin
                PInt:=ptr(BAddr,OAddr);
                Dato:=SetLeft(Dato);
                if Dato = '' then Dato:='0';
                val(Dato,PInt^,flag1);
                PInt^:=PInt^*CtrlKey;
                Error:=(flag1 <> 0);
             end;
           'R','r':
             begin
                PReal:=ptr(BAddr,OAddr);
                Dato:=SetLeft(Dato);
                if Dato = '' then Dato:='0';
                val(Dato,PReal^,flag1);
                PReal^:=PReal^*CtrlKey;
                Error:=(flag1 <> 0);
             end;
           '$','s':
             begin
                PStr:=ptr(BAddr,OAddr);
                PStr^:=Dato;
                if CtrlKey = 0 then PStr^:='';
             end;
           'C','c':
             begin
                PChar:=ptr(BAddr,OAddr);
                PChar^:=Dato[1];
                if CtrlKey = 0 then PChar^:=' ';
             end;
           else Dato:='';
         end;
      end;
      if Error then Dato:=DatoInit;
      AggiornaDato:=not(Error);
  end;

 procedure WriteAllCampi;
  var I:integer;
      Dato:LineStr;
  begin
  textcolor(col[4]);
  textbackground(col[3]);
     for i:=1 to UltimoCampo do
      begin
         with Tabella[I] do
          begin
             case Tipo of
               'I','i':
                 begin
                    PInt:=ptr(BAddr,OAddr);
                    if notzero and (PInt^ = 0) then Dato:='  '
                    else
                     begin
                        str(PInt^:L,Dato);
                        Dato:=setleft(Dato);
                     end;
                 end;
               'R','r':
                 begin
                    PReal:=ptr(BAddr,OAddr);
                    if notzero and (PReal^ = 0) then Dato:='  '
                    else
                     begin
                        str(PReal^:L:CifreDec,Dato);
                        Dato:=setleft(Dato);
                     end;
                 end;
               '$','s':
                 begin
                    PStr:=ptr(BAddr,OAddr);
                    Dato:=PStr^;Dato:=setleft(dato);
                 end;
               'C','c':
                 begin
                    PChar:=ptr(BAddr,OAddr);
                    Dato:=' ';
                    Dato[1]:=PChar^;
                 end;
               else Dato:='';
             end;
             gotoxy(x,y);write(format(Dato,L));
          end;
      end;
  end;


 procedure LeggiDato(var Dato:linestr;I:integer);
  begin
     with Tabella[I] do
      begin
         case Tipo of
           'I','i':
             begin
                PInt:=ptr(BAddr,OAddr);
                if (PInt^ = 0) and notzero then Dato:=''
                else str(PInt^:L,Dato);
                Dato:=SetLeft(Dato);
             end;
           'R','r':
             begin
                PReal:=ptr(BAddr,OAddr);
                if (PReal^ = 0) and notzero then Dato:=''
                else str(PReal^:L:CifreDec,Dato);
                Dato:=SetLeft(Dato);
             end;
           '$','s':
             begin
                PStr:=ptr(BAddr,OAddr);
                Dato:=SetLeft(PStr^);
             end;
           'C','c':
             begin
                PChar:=ptr(BAddr,OAddr);
                Dato:=' ';
                Dato[1]:=PChar^;
             end;
           else Dato:='';
         end;
         Dato:=format(Dato,L);
      end;

  end;

procedure salvacampo(campo:integer);

begin
case tabella[campo].tipo of
  'I','i':leggidato(intero,campo);
  'R','r':leggidato(reale,campo);
  '$','s':leggidato(stringa,campo);
  'C','c':leggidato(carattere,campo)
end;
end;

procedure Caricacampo(var dt:linestr;campo:integer);
begin
case tabella[campo].tipo of
  'I','i':dt:=setright(intero);
  'R','r':dt:=setright(reale);
  '$','s':dt:=stringa;
  end;
end;

 procedure UsaMask;
  var ch:char;
      i:integer;
      Dato:linestr;
      ExitChar:char;
      F:boolean;
      SetCode,StartPos:integer;
      Fine,NoRead:boolean;
  begin
     Fine:=false;NoRead:=false;
     while not(Fine) do
      with Tabella[Campo] do
       begin
          i:=Campo;
          StartPos:=1;

          if not(NoRead) then LeggiDato(Dato,Campo)
          else NoRead:=false;

          if Tipo in ['$','C','s','c'] then SetCode:=3
          else SetCode:=2;

          Dato:=SetLeft(Dato);
          textbackground(col[5]);
          textcolor(col[7]);
          writecampi(campo,true);
          Dato:=LINE_INPUT(X,Y,L,StartPos,' ',Dato,SetCode,ExitChar,FALSE,F,campo);
          Chiave:=ord(ExitChar);
          textbackground(col[3]);
          textcolor(col[4]);
          writecampi(campo,true);
          if (all)and(chiave<>120)and(chiave<>121)and(chiave<>123)and(chiave<>122) then fine:=true
          else
           begin
              if chiave=122 then chiave:=61;
              case Chiave of
                27,59..68:
                   Fine:=true;
                77,13:
                      begin
                      CampoSucc(Campo)
                      end;

                75:
                      begin
                      CampoPrec(Campo)
                      end;

                120:campo:=nuovocampo;
                121:caricacampo(dato,campo);
                123:salvacampo(campo);
                else
              end;
           end;

          if not(AggiornaDato(Dato,I)) then
           begin
              write(chr(7));
              Campo:=I;
              Fine:=false;
              NoRead:=true;
           end

           else
              begin
                textbackground(col[3]);
                textcolor(col[4]);
                writecampi(I,true);
              end;

       end;
  end;


 begin
    intero:='';
    reale:='';
    stringa:='';
    carattere:='';
    if not WVal then    {.. maschera da inizializzare ..}
     begin
       if W then
        begin
           InitTabella;

           LeggiMask(NomeFile);
           StampaMappa(CField);
           TextColor(col[4]);
           textbackground(col[3]);
           WriteAllCampi;
        end;
     end
    else
     begin
        textbackground(col[3]);
        CarAddress(Base,OffSet);
        WriteAllCampi;
     end;

    while not(tabella[campo].flag) do
    if campo=ultimocampo then campo:=1 else campo:=campo+1;

    textbackground(col[1]);
    if UltimoAccesso > 0 then UsaMask;
 end;


  function SpaceTab(InADDR:word):integer;
  var OfsAddr:word;i:integer;
  begin
     with Tabella[UltimoCampo] do
      begin
         OfsAddr:=OAddr-InADDR;
         case Tipo of
          '$','s':OfsAddr:=OfsAddr+L+1;
          'C','c':OfsAddr:=OfsAddr+L;
          'R','r':OfsAddr:=OfsAddr+6;
          'I','i':OfsAddr:=OfsAddr+2;
         end;
      end;
     SpaceTab:=OfsAddr;
  end;

procedure CalcMask(IBase:word;NDat,DatR,Riga,Campo:integer;var Chiave:integer;Mask:st80);
var
    PInt  : ^integer;
    PStr  : ^st240;
    PReal : ^real;
    PChar : ^char;
    L     : integer;

function TotaleColonna(c:integer):real;
var I              : integer;
    Tot            : real;
    DBase          : integer;
    Intero         : boolean;
    base,offs      : integer;
begin
   with Tabella[c] do
    begin
       base:=BAddr;    Offs:=IBase+(OAddr-Tabella[1].OAddr);
    end;

   with Tabella[DatR] do
    begin
       DBase:=OAddr-Tabella[1].OAddr;
       case Tipo of
         'I','i':DBase:=DBase+2;
         'R','r':DBase:=DBase+6;
         '$','s':DBase:=DBase+L+1;
         'C','c':DBase:=DBase+L;
       end;
    end;

   Intero:=(Tabella[c].Tipo in ['I','i']);

   Tot:=0;
   for i:=1 to NDat do
    begin
       if not Intero then
        begin
           PReal:=ptr(Base,Offs+(i-1)*DBase);
           Tot:=Tot+PReal^;
        end
       else
        begin
           PInt:=ptr(Base,Offs+(i-1)*DBase);
           Tot:=Tot+PInt^;
        end;
    end;
   TotaleColonna:=Tot;
end;


 procedure CancellaProgetto(var Chiave:integer;Riga:integer);
 var c,L : integer;
     f   : file;
     g   : text;
     Est : st8;
 begin
    c:=DatR*(Riga-1)+1;
    with Tabella[c+1] do PStr:=ptr(BAddr,OAddr);
    if PStr^ = '' then exit;
    if Conferma('mc4.msg','  ' + PStr^ + ' '+W_M(20),4) then   {  !  CONFERMA (S/N)}
     begin
        L:=Pos('.',Mask);
        assign(g,Copy(Mask,1,L)+'fil');   reset(g);
        while not(eof(g)) do
         begin
            readln(g,Est);
            gotoxy(1,21);
            write(W_M(21),PStr^+Est); ClrEol;    { 'Cancellazione file '}
            if exist(PStr^+Est) then
             begin
                assign(f,PStr^+Est);    erase(f);
             end;
         end;
        close(g);
        gotoxy(1,21);
        ClrEol;
     end
    else Chiave:=0;
 end;

 procedure Copia;
 const
     BufSize = 50 ;
     RecSize = 128;
 type Dati = record
                Src,Dst : st18;
             end;
 var
     f , Source, Destination  : file       ;
     Buffer                   : array[1..RecSize,1..BufSize] of byte;
     g                        : text       ;
     Est                      : st8        ;
     Tab1                     : ^TabellaRec ;
     Map1                     : ^TabellaMap ;
     pc1,uc1,pa1,ua1,RecsRead : integer    ;
     Campo,L                  : integer    ;
     Files                    : Dati       ;
 begin
    with Files do
     begin
        Src := '';    Dst := '';
     end;

    new(Tab1);        new(Map1);
    Tab1^:=Tabella;   Map1^:=Mappa;
    pc1:=PrimoCampo;  pa1:=PrimoAccesso;
    uc1:=UltimoCampo; ua1:=UltimoAccesso;

    Campo:=1;
    UsaMaskera(Seg(Files),Ofs(Files),'copia.msk',Campo,Chiave,grigiolight,bianco,
               true,false,false,true);

    Tabella    :=Tab1^;   Mappa        :=Map1^;
    PrimoCampo :=pc1;     PrimoAccesso :=Pa1;
    UltimoCampo:=Uc1;     UltimoAccesso:=Ua1;
    dispose(Tab1);    dispose(Map1);

    if Conferma('mc4.msg','  ' + Files.Src + ' a file ' + Files.Dst + '  '+W_M(20),3) then
     begin
        L:=Pos('.',Mask);
        assign(g,Copy(Mask,1,L)+'fil');   reset(g);
        while not(eof(g)) do
         begin
            readln(g,Est);
            gotoxy(1,21);
            write(W_M(22),Files.Src+Est);   ClrEol;  {'copia file '}
            if exist(Files.Src+Est) then
             begin
                assign(Source,Files.Src+Est);         reset(Source);
                assign(Destination,Files.Dst+Est);    rewrite(Destination);
                repeat
                   BlockRead(Source,Buffer,BufSize,RecsRead);
                   BlockWrite(Destination,Buffer,RecsRead);
                until RecsRead = 0;
                close(Source);      close(Destination);
             end;
         end;
        close(g);
        gotoxy(1,21);
        ClrEol;
     end;
 end;


 begin
    L:=Length(Mask);
    if UpString(Copy(Mask,L-3,4)) = '.PRG' then
     begin
        case Chiave of
          63 : CancellaProgetto(Chiave,Riga);
          60 : begin
                  Copia; Chiave:=0;
               end;
        end;
     end;

 end;




{------------------------IOTabella------------------------------------}
 procedure IOTabella(ISeg,IOfs:word;NDat,DatP,DatR:integer;var Chiave,Riga,campo:integer;
                     mask:st80;SetNRighe,InitMask,IWVal,IWCampo:boolean);
  {... ISeg & IOfs contengono il SEG e l'OFS della tabella
   ... NDat ä il numero totale di righe
   ... DatP ä il numero di righe per pagina
   ... DatR ä il numero di CAMPI per riga
   ... Riga contiene il N. della riga da cui si ä usciti
   ... IWVal e' true se si fa riferimento all'ultima tabella usata :
       in tal caso si puo' specificare con riga la riga di accesso alla tabella
   ... IWCampo e' true se si fa riferimento all'ultima tabella usata :
       in tal caso si puo' specificare con campo il campo di accesso alla tabella
       il Campo ha precedenza sulla riga se IWCampo e' true ,cioe` il cursore
       si posizionera' sulla tabella in base al valore del campo e non della riga
   ... SetNRighe = true se si vogliono numerare  le righe della tabella
                   in tal caso occorre che il primo campo della tabella
                   venga introdotto in riga 8.
                                                               }

  type buffer = array[1..80] of char;
  var ROfs:word;DOfs,i,j,k,Lin,NPag,Limite : integer;
      IBase                                 : word;
      ExRet                                 : boolean;
      PPrec,PSucc                           : ^char;
      PBuff,PBuffMask                       : ^Buffer;

      x:integer;

  begin           {maskera}
      new(PBuff);     IBase:=IOfs;

      if IWCampo then
       begin
          CarAddress(ISeg,IOfs);

          IF CAMPO >0 THEN
           begin
              NPag:=(Riga div DatP) + 1;
              if Riga mod DatP = 0 then NPag:=NPag - 1;

              i:=(NPag-1)*DatP+1;

              DOfs:=SpaceTab(IOfs);
              ROFs:=DOfs div DatP; {..spazio occupato da una riga..}
              IOfs:=IOfs + (NPag-1) * DOfs;



           end;
       end;

      if IWVal and not IWCampo then
       begin
          CarAddress(ISeg,IOfs);
          if Riga > 0 then
           begin
              Campo:=DatR*((Riga-1) mod DatP) + 1;

              NPag:=(Riga div DatP) + 1;
              if Riga mod DatP = 0 then NPag:=NPag - 1;

              i:=(NPag-1)*DatP+1;

              DOfs:=SpaceTab(IOfs);
              ROFs:=DOfs div DatP; {..spazio occupato da una riga..}
              IOfs:=IOfs + (NPag-1) * DOfs;

           end;
       end ;
       if (not iwval)and (not iwcampo) then
         begin
           i:=1;
           Campo:=1;
         end;


      Riga:=0;  ExRet:=true;

        repeat
           if SetNRighe and ExRet and not InitMask then
            begin
               TextColor(col[2]);

               if (DatP <> 1) then
                for vv:=1 to DatP do
                 begin
                   str( (i-1+vv),stv);
                   stv1:= format(stv,3);
                   gotoxy(3,7+vv);
                   write (stv1);
                 end
               else
                  begin
                    gotoxy(3,8);write(stv1);
                  end;
               TextColor(col[7]);
            end;
           ExRet:=false;

           with Tabella[Campo] do
            begin
               PBuffMask:=ptr(BAddr,OAddr);
               PBuff^:=PBuffMask^;
            end;
           UsaMaskera(ISeg,IOfs,mask,Campo,Chiave,grigiolight,giallo,InitMask,IWVal,true,true);
           if InitMask then
            begin
               DOfs:=SpaceTab(IOfs);
               ROFs:=DOfs div DatP; {..spazio occupato da una riga..}
            end;

           InitMask := false;
           IWVal    := false;
           IWCampo  := false;

           Lin:=(Campo div DatR)+1;
           if Campo mod DatR = 0 then Lin:=Lin-1;

           if (PBuff^ <> PBuffMask^) or (Chiave in [59..68]) then CalcMask(IBase,NDat,DatR,Lin,Campo,Chiave,Mask);
           case Chiave of
                63:{..cancellazione linea..}
                   begin
                      Limite:=(NDat-1)-(i-1);
                      for j:=Lin to Limite do
                       begin
                          for k:=0 to ROfs-1 do
                           begin
                              PPrec:=ptr(ISeg,IOfs+(j-1)*ROfs+k);
                              PSucc:=ptr(ISeg,IOfs+j*ROfs+k);
                              PPrec^:=PSucc^;
                           end;
                       end;
                      for k:=0 to ROfs-1 do
                       begin
                          PSucc:=ptr(ISeg,IOfs+Limite*ROfs+k);
                          PSucc^:=chr(0);
                       end;

                      IWVal:=true; IWCampo :=true;
                   end;
                64:{..inserzione linea..}
                   begin
                      Limite:=(NDat-1)-(i-1);
                      for j:=Limite downto Lin do
                       begin
                          for k:=0 to ROfs-1 do
                           begin
                              PPrec:=ptr(ISeg,IOfs+(j-1)*ROfs+k);
                              PSucc:=ptr(ISeg,IOfs+j*ROfs+k);
                              PSucc^:=PPrec^;
                           end;
                       end;

                      for k:=0 to ROfs-1 do
                       begin
                          PSucc:=ptr(ISeg,IOfs+(Lin-1)*ROfs+k);
                          PSucc^:=chr(0);
                       end;

                      IWVal:=true;
                   end;

                13,77:
                   begin
(*                      writeln('campo ',campo, ' ultimoaccesso  ',ultimoaccesso);
                      delay(2000);*)

                      if campo < UltimoAccesso then CampoSucc(campo)
                      else
                       begin

                          if i < NDat-DatP then
                           begin
                              i:=i+DatP;
                              IOfs:=IOfs+DOfs;
                              Campo:=0;   CampoSucc(Campo);

                              IWVal:=true;   ExRet:=true; IWCampo :=true;
                           end
                          else write(chr(7));
                       end
                   end;
                27,59..62,65..68:;
                75:
                   begin
                      if campo > 1 then
                       begin
                          CampoPrec(campo);
                       end
                      else
                       begin
                          if i > 1 then
                           begin
                              i:=i-DatP;
                              IOfs:=IOfs-DOfs;
                              Campo:=DatP*DatR+1;   CampoPrec(Campo);
                              IWVal:=true;   ExRet:=true; IWCampo :=true;
                           end
                          else write(chr(7));
                       end
                   end;
                80:  {..freccia in giu'..}
                   if campo <= (DatP-1)*DatR then campo:=campo+DatR
                   else
                    begin
                       if i < NDat-DatP then
                        begin
                           i:=i+DatP;
                           IOfs:=IOfs+DOfs;
                           if Campo = DatP*DatR then Campo:=DatR
                           else Campo:=Campo mod DatR;
                           IWVal:=true;   ExRet:=true;  IWCampo :=true;
                        end
                       else write(#7);
                    end;
                72:  {..freccia in su'...}
                   if campo > DatR then  campo:=campo-DatR
                   else
                    begin
                       if i > 1 then
                        begin
                           i:=i-DatP;
                           IOfs:=IOfs-DOfs;
                           Campo:=Campo+DatR*(DatP-1);
                           IWVal:=true;   ExRet:=true; IWCampo :=true;
                        end
                       else write(#7);
                    end;
                81:{PgDn}
                   if i < NDat-DatP then
                    begin
                       i:=i+DatP;
                       IOfs:=IOfs+DOfs;
                       Campo:=0;   CampoSucc(Campo);
                       IWVal:=true;   ExRet:=true; IWCampo :=true;
                    end
                   else write(chr(7));
                73:{pgUp}
                   if i > datP then
                    begin
                       i:=i-DatP;
                       IOfs:=IOfs-DOfs;
                       Campo:=0;   CampoSucc(Campo);
                       IWVal:=true;   ExRet:=true; IWCampo :=true;
                    end
                   else write(chr(7));
           end; { case }
        until (chiave in [27,59..68]);
        Riga:=i+(Campo div DatR);
        if Campo mod DatR = 0 then Riga:=Riga-1;
        dispose(PBuff);
    end;       {maskera}




  procedure Frame(UpperLeftX, UpperLeftY, LowerRightX, LowerRightY: Integer);
   var
      i: Integer;
   begin
      GotoXY(UpperLeftX, UpperLeftY);  Write(chr(218));
      for i:=UpperLeftX+1 to LowerRightX-1 do Write(chr(196));
      Write(chr(191));
      for i:=UpperLeftY+1 to LowerRightY-1 do
      begin
         GotoXY(UpperLeftX , i);  Write(chr(179));
         GotoXY(LowerRightX, i);  Write(chr(179));
      end;
      GotoXY(UpperLeftX, LowerRightY);
      Write(chr(192));
      for i:=UpperLeftX+1 to LowerRightX-1 do Write(chr(196));
      Write(chr(217));
   end  { Frame };



 procedure testata(Fondo,Testo:integer;titolo:st80);
  begin
     Window(1,1,80,2);
     textbackground(Fondo);
     gotoxy(1,1);ClrEol;
     textcolor(Testo);
     gotoxy(1,1);
     gotoxy(1,1);writeln(Titolo);
     TextBackground(nero);
     Window(1,3,80,25);
  end;


  procedure scelta_Menu(Menu:datimenu;nmenu,x,y,FondoT,TestoT,Testo:integer;var n:integer;descr_Menu:st80);
   var
      i,lx:integer;
      ch:char;

procedure scorrimento(var n:integer;nmenu,vx,vy:integer;descr_Menu:st80);
     var
        k,y,i,j:integer;
        ch:char;
        min,max:integer;
        fine:boolean;
        ordchar:integer;

procedure new_riga(nuova:integer);
begin
if i<>nuova then
  begin
    textcolor(col[13]);
    gotoxy(1,y);ClrEol;
    gotoxy(vx,y);write(Menu[i]);
    i:=nuova;
    y:=min+i-1;
    if i<1 then
      begin
      y:=max;
      i:=nmenu;
      end;
    if i>nmenu then
      begin
        y:=min;
        i:=1;
      end;
    textbackground(col[14]);
    gotoxy(1,y);ClrEol;
    gotoxy(vx,y);textcolor(col[15]);
    write(Menu[i]);
    textbackground(col[12]);
  end;
end;

begin

         textbackground(col[12]);
         for i:=1 to nmenu do
          begin
             gotoxy(vx,vy+i-1);
             textcolor(col[13]);write(Menu[i]);
          end;
         textbackground(col[14]);
         gotoxy(1,vy);ClrEol;
         textcolor(col[15]);
         gotoxy(vx,vy);write(Menu[1]);
         textbackground(col[12]);
         gotoxy(vx+1,vy);
         i:=1;
         min:=vy;
         max:=vy+nmenu-1;
         y:=min;
         fine:=false;
         if M_attivo then delay(200);
         repeat
          if M_attivo then
            begin
              if pdes then
                begin
                  n:=0;
                  fine:=true;
                  ordchar:=61
                end
              else
              begin
               if psin then ordchar:=13
               else
                 begin
                   if M_Y<1 then new_riga(1)
                   else
                     begin
                       if M_Y>max then new_riga(max)
                       else new_riga(M_Y)
                     end;
                 ordchar:=61
                 end
               end
            end
            else
            begin
            if keypressed then
              begin
                readkbd(ch);
                ordchar:=ord(ch)
              end
            else ordchar:=61
            end;

             case ordchar of
               49..55:
                  begin
                     n:=ord(ch)-48;
                     fine:=true;
                  end;
               27:
                  begin
                     if keypressed then
                     begin
                       readkbd(ch);
                       case ch of
                         'P':new_riga(i+1);
                         'H':new_riga(i-1);
                         'M':begin
                               verso:=1;
                               fine:=true;
                               n:=0
                             end;
                          'K':begin
                               verso:=2;
                               fine:=true;
                               n:=0
                              end;

                       end
                     end
                     else
                     begin
                     fine:=true;
                     n:=0;
                     end
                  end;
               13:
                 begin
                    n:=i;
                    fine:=true;
                 end;
            end;
           gotoxy(vx+1,y);
       until fine;
   end;    { Scorrimento }


{----------------------  MAIN of SceltaMenu  ------------------------}
   begin
 {     window(1,3,80,25);
      ClrScr;}

      lx:=0;
      for i:=1 to Nmenu do
       if length(Menu[i])>lx then lx:=length(Menu[i]);
      if length(descr_Menu)>lx then lx:=length(descr_Menu); { lx=largezza max }
      if x+lx+3>82 then x:=79-lx;
      if y+nmenu+2>24 then y:=22-nmenu;
      Window(x-2,y-1,x+lx+1,y+Nmenu);
      clrscr;
      Window(x-2,y-1,x+lx+1,y+Nmenu);
      textbackground(col[12]);
      textcolor(col[16]);
      clrscr;
      frame(1,1,lx+3,Nmenu+2);

      Window(x,y,x+lx-1,y+Nmenu+1);
      textbackground(col[12]);
      textcolor(col[13]);
      scorrimento(n,nmenu,1,1,descr_Menu);
      Window(1,3,80,25);
      textbackground(col[1]);
      stampamappa1(x-2,y-2,x+lx+1,y+Nmenu-2,7);
      textcolor(col[4]);
      textbackground(col[3]);
      Writecampi1(x-2,y-2,x+lx+1,y+Nmenu-2);
      Window(1,2,80,2);
      gotoxy(1,1);
      textbackground(col[17]);
      textcolor(col[18]);
      write(nomeprogetto);
      clreol;

   end;   { SceltaMenu }


  function UsaMenu(NomeFile:st80;Nmenu:integer):integer;
   var DeMenu:st80;
       ch:char;

   procedure LoadMenu(NomeFile:st80);
    var
       f:text;
       i,Lmax:integer;
    begin
       assign(f,NomeFile);
       reset(f);
      { readln(f,DeMenu);}
       i:=0;Lmax:=0;
       while not(eof(f)) do
        begin
           i:=i+1;
           Nmenu:=I;
           readln(f,Menu[i]);
        end;
       close(f);

       for i:=1 to Nmenu do if Lmax < Length(Menu[i]) then Lmax:=Length(Menu[i]);
       if Lmax < Length(DeMenu) then Lmax:=Length(DeMenu);

       XMenu:=(80-Lmax) div 2;
       Ymenu:=(24-NMenu) div 2;
       if YMenu < 5 then YMenu:=5;
    end;  { LoadMenu }

   {----------------- MAIN of UsaMenu ----------------}
   begin
      LoadMenu(NomeFile);
      Scelta_Menu(Menu,Nmenu,colon,3,nero,nero,grigiolight,SceltaMenu,'');
      UsaMenu:=SceltaMenu;
   end;    { UsaMenu }

{***************** MENU A TENDINA ***************************************}

{------- carica i comandi contenuti in una testata ------------}

procedure testmenu(nomemsk:st80);
var fineriga:boolean;
maxcol:integer;
sopz:st80;
begin
assign(fi,nomemsk+'.msk');
reset(fi);
readln(fi,rigamenu);
close(fi);
maxcol:=length(rigamenu);
ncol:=0;
ncom:=0;
fineriga:=false;

repeat

  repeat
  NCol:=NCol+1;
  if NCol>maxcol then fineriga:=true
  until (rigamenu[NCol]<>' ')or(fineriga);

  if not fineriga then
    begin
    ncom:=ncom+1;
    vcomandi[ncom].colonna:=ncol;
    nome:='';
      repeat
      nome:=nome+rigamenu[NCol];
      NCol:=NCol+1;
      if NCol>maxcol then fineriga:=true
      until (rigamenu[NCol]=' ')or(fineriga);
    vcomandi[ncom].comando:=nome;
    str(ncom:1,sopz);
    if exist(nomemsk+sopz+'.mnu') then vcomandi[ncom].menu:=true
    else vcomandi[ncom].menu:=false;

    end;

until fineriga;

end;

{--------- scorre i  menu a pop up -----------------------------------}

function scorretestata(nomemnu:st80):integer;

var ch:char;fine,entra:boolean;
    nopz,i,intvar,intvar1,ordchar:integer;
    sopz,sopz1  :st80;
    findopz:integer;

Procedure new_opz(nuova:integer);
begin
if nopz<>nuova then
  begin
  textcolor(col[9]);
  textbackground(col[8]);
  gotoxy(vcomandi[nopz].colonna-1,1);
  write(' '+nome+' ');
  nopz:=nuova;
  if nopz>ncom then nopz:=1;
  if nopz<1 then nopz:=ncom;
  nome:=vcomandi[nopz].comando;
  textcolor(col[11]);
  textbackground(col[10]);
  gotoxy(vcomandi[nopz].colonna-1,1);
  write(' '+nome+' ');
  end
end;


begin
  CrsOff;
  verso:=0;
  entra:=false;
  nopz:=1;
  window(1,1,80,25);
  nome:=vcomandi[1].comando;
  textcolor(col[11]);
  textbackground(col[10]);
  gotoxy(vcomandi[1].colonna,1);
  write(nome);

  fine:=false;
          repeat
             if (entra)and(vcomandi[nopz].menu) then
               begin
               ordchar:=13;
               entra:=false
               end
             else
               begin
               if M_attivo then
                 begin
                 if pdes then
                   begin
                   uscita:=0;
                   fine:=true;
                   ordchar:=61;
                   textcolor(col[9]);
                   textbackground(col[8]);
                   gotoxy(vcomandi[nopz].colonna-1,1);
                   write(' '+nome+' ');
                   scorretestata:=0
                   end
                 else
                   begin
                   if psin then ordchar:=13
                   else
                     begin
                       Findopz:=0;
                       repeat
                       Findopz:=Findopz+1;
                       until (VComandi[Findopz+1].colonna>M_x+1)or(Findopz=Ncom);
                       New_opz(Findopz);
                       ordchar:=61;
                     end
                   end
                 end
               else
                 begin
                   if (verso=0)then
                     begin
                       if keypressed then
                         begin
                         readkbd(ch);
                         ordchar:=ord(ch)
                         end
                         else ordchar:=61
                     end
                   else ordchar:=27
                 end
               end;

             case ordchar of
               49..55:
                  begin
                  fine:=true;
                  end;

               27:if (keypressed)or(verso<>0) then
                  begin
                     if verso=0 then readkbd(ch)
                     else
                     begin
                       if verso=1 then ch:='M'
                       else ch:='K';
                       verso:=0;
                       entra:=true;
                     end;
                     if ch='M' then  new_opz(nopz+1);
                     if ch='K' then  new_opz(nopz-1);

                  end
                else
                  begin
                  fine:=true;
                  textcolor(col[9]);
                  textbackground(col[8]);
                  gotoxy(vcomandi[nopz].colonna-1,1);
                  write(' '+nome+' ');
                  scorretestata:=0
                  end;
               13:
                 begin
                 window(1,2,80,25);
                 colon:=vcomandi[nopz].colonna;
                 str(nopz:1,sopz);
                 if vcomandi[nopz].menu then
                   begin
                   uscita:=usamenu(nomemnu+sopz+'.mnu',0);
                   if m_attivo then delay(200);
                   if uscita<>0 then fine:=true
                   end
                 else
                  begin
                  uscita:=0;
                  fine:=true
                  end;
                 str(nopz:1,sopz);
                 str(uscita:1,sopz1);
                 val(sopz+sopz1,intvar,intvar1);
                 scorretestata:=intvar;
                 textbackground(col[1]);
                 window(1,1,80,25);
                 end;
            end;
       until fine;
window(1,3,80,25);
CrsOn;
end;

{------------------------ M_IOTabella ------------------------------------}
 procedure M_IOTabella(M_ISeg,M_IOfs:word;M_NDat,M_DatP,M_DatR:integer;var M_Chiave,chiave1,M_Riga,M_Campo:integer;
          M_mask,menu:st80;M_SetNRighe,M_InitMask,M_IWVal,M_IWCampo,InitMenu:boolean);
  {... ISeg & IOfs contengono il SEG e l'OFS della tabella
   ... NDat ä il numero totale di righe
   ... DatP ä il numero di righe per pagina
   ... DatR ä il numero di CAMPI per riga
   ... Riga contiene il N. della riga da cui si ä usciti
   ... IWVal e' true se si fa riferimento all'ultima tabella usata :
       in tal caso si puo' specificare con riga la riga di accesso alla tabella
   ... IWCampo e' true se si fa riferimento all'ultima tabella usata :
       in tal caso si puo' specificare con campo il campo di accesso alla tabella
       il Campo ha precedenza sulla riga se IWCampo e' true ,cioe` il cursore
       si posizionera' sulla tabella in base al valore del campo e non della riga
   ... SetNRighe = true se si vogliono numerare  le righe della tabella
                   in tal caso occorre che il primo campo della tabella
                   venga introdotto in riga 8.
                                                               }
begin
 Exit_up:=true;
 if initmenu then
 begin
 textbackground(col[17]);
 textcolor(col[18]);
 window(1,1,80,2);
 gotoxy(1,2);
 write(nomeprogetto);
 clreol;
 textcolor(col[9]);
 textbackground(col[8]);
 gotoxy(1,1);
 testmenu(menu);
 write(rigamenu);
 clreol
 end;
 chiave1:=0;
  repeat
    textbackground(col[1]);
    window(1,3,80,25);
    if M_attivo then delay(200);
    IOTabella(M_ISeg,M_IOfs,M_NDat,M_DatP,M_DatR,M_Chiave,M_Riga,M_Campo,
                           M_mask,M_SetNRighe,M_InitMask,M_IWVal,M_IWCampo);
    M_InitMask:=false;
    initmenu:=false;
    if M_chiave =27 then chiave1:=scorretestata(menu)
    else chiave1:=0;
  until (M_chiave<>27)or(chiave1<>0);
Exit_up:=False;
end;

{------------------------ M_usamaschera ------------------------------------}
procedure M_UsaMaskera(M_Base,M_OffSet:word;M_NomeFile,menu:st80;
                     var M_Campo,M_Chiave,chiave1:integer;
                     M_CField,M_CText:integer;M_W,M_WVal,M_all,M_notzero,initmenu:boolean);

begin
 Exit_up:=true;
 if initmenu then
 begin
 textbackground(col[17]);
 textcolor(col[18]);
 window(1,1,80,2);
 gotoxy(1,2);
 write(nomeprogetto);
 clreol;
 textcolor(col[9]);
 textbackground(col[8]);
 gotoxy(1,1);
 testmenu(menu);
 write(rigamenu);
 clreol
 end;
 chiave1:=0;
  repeat
    textbackground(col[1]);
    window(1,3,80,25);
    if M_attivo then delay(200);
    UsaMaskera(M_Base,M_OffSet,M_NomeFile,
    M_Campo,M_Chiave,grigiolight,bianco,M_W,M_WVal,M_all,M_notzero);


    M_w:=false;
    initmenu:=false;
    if M_chiave =27 then chiave1:=scorretestata(menu)
    else chiave1:=0;
  until (M_chiave<>27)or(chiave1<>0);
Exit_up:=false;
end;
{$I ERROR}
End.
