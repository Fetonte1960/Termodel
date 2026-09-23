{$R+}    {Range checking off}
{$B+}    {Boolean complete evaluation on}
{$S+}    {Stack checking on}
{$I+}    {I/O checking on}
{$N-}    {No numeric coprocessor}
{$F+}
{$O+}


Unit Gruti;

Interface

Uses

  definiz,graph,halotp4,WM,
  Turbo3,ut_loca1; {Unit found in TURBO3.TPU}


    type
       st255 = string[255];
       st240 = string[240];
       st126 = string[126];
       st80  = string[80] ;
       st70  = string[70] ;
       st60  = string[60] ;
       st50  = string[50] ;
       st35  = string[35] ;
       st30  = string[30] ;
       st25  = string[25] ;
       st18  = string[18] ;
       st15  = string[15] ;
       st11  = string[11] ;
       st10  = string[10] ;
       st8   = string[8]  ;
       st6   = string[6]  ;
       st5   = string[5]  ;
       st4   = string[4]  ;
       st3   = string[3]  ;
       st2   = string[2]  ;
       st40  = string[40] ;
       st20  = string[20] ;
       linestr = string[80];




procedure G_Textbackground(colore:integer);
procedure G_Textcolor(colore:integer);
procedure mouse_init;
procedure getmouse(var x,y:integer;var pd,pc,ps:boolean);
procedure setpos(x,y:integer);
Procedure cursor_on;
function  initmouse(var mousetype:st80):integer;
function  M_attivo(var x,y:real;var sw:INTEGER):boolean;
procedure M_Off;
procedure M_ON;
FUNCTION FORMAT(ST:ST126;StLength:INTEGER):ST126;
FUNCTION LINE_INPUT(Xt,Yt,L:INTeger;
                VAR STARTCURPOS:INTEGER;
                    FILLCHAR:CHAR;
                    PRESETFIELD:LINESTR;
                    SETCODE:INTEGER;
                VAR EXITCHAR:CHAR;
                    FlagEND:BOOLEAN;
                VAR ModFlag:BOOLEAN;
                    campo:integer):LINESTR;

function Exist(Nome:st80):boolean;
function ExistS(Nome:st80):boolean;

procedure UsaMaskera(Base,OffSet:word;NomeFile:st80;
                     var Campo,Chiave:integer;
                     dx,dy:integer;W,WVal,all,notzero:boolean);

procedure IOTabella(ISeg,IOfs:word;NDat,DatP,DatR:integer;var Chiave,Riga:integer;
                    mask:st80;SetNRighe,InitMask,IWVal:boolean;Tabx,Taby:integer);


function Gmenu:integer;
procedure loadmenu(nomemenu:st80);
procedure writemenu(y:real;var campoprec:integer;start:boolean);
procedure rinfresca;
procedure installa;

var Mousepres:Boolean;

{-----------------------------------------------------------------------------}

IMPLEMENTATION

const font:string='halo104.fnt';
      maxrighe=25;
      mc4:string='M C 4';
      MC4T:STRING='Duct';

var mousetemp:boolean;
    mouset:st80;
    xprec,yprec,M_X,M_y:real;
    pdes,psin,pcen:boolean;
    Mingx,mingy:integer;
    coltext,colback:integer;
    pagx,pagy:real;

var  gm:array[1..maxrighe]of st15;
     nrighe,righemenu:integer;
     str1,str2:string;
     x,y,real1,real2,real3,real4:real;
     x1,y1,sw,int1,int2,int3,int4:integer;
     c1:integer;

{$I incmenu}
const MaxCampi=150;
type
       Rec = record
               Flag:boolean;
               Tipo:char;
               L:integer;
               x,y:integer;
               BAddr,OAddr:word;
               CifreInt,CifreDec:integer;
            end;

       TabellaRec = array[1..MaxCampi] of Rec;
var       Tabella                      : TabellaRec;
    const
       Gmax=20;
       Fill1='                                                                               ';
       MaxInfo=25;


type       TabellaMap = array[1..25] of st80;
       tyinfo=array[1..maxinfo]of
                  record
                     ix,iy:integer
                  end;
     var

       info                         : Tyinfo;
       info1                        : Tyinfo;
       mess                         : Array[1..maxinfo] of st80;
       Mappa                        : TabellaMap;
       Ninfo                        : integer;
       Ninfo1                       : integer;
       primocampo,UltimoCampo       : integer;
       nuovocampo                   : integer;
       PrimoAccesso,UltimoAccesso   : integer;
       verso                        : integer;
       nero,blu,verde,celeste,rosso,magenta,marrone,grigiolight,
       grigio,blulight,verdelight,celestelight,rossolight,magentalight,
       giallo,bianco : integer;

var uscita,a,colon:integer;
    nomeprogetto:st80;
    fi:text;
    ncol,ncom:integer;
    vcomandi:array[1..20]of
             record
                   comando:st80;
                   colonna:integer;
                   menu:boolean;
             end;
    nome:st80;

    intero,reale,stringa,carattere:linestr;
    M_TYPE:st80;
    DATA_DRIVE,SYstem_drive:ST40;
    glst:text;
    rimedio,causa,rapporto:st8;
    vecchiaexit:pointer;


{$I incmouse}

{--------------------------------------------------------------------------}
procedure G_Textcolor(colore:integer);
begin
coltext:=colore;
settextclr(@coltext,@colback);
end;
{--------------------------------------------------------------------------}
procedure G_Textbackground(colore:integer);
begin
colback:=colore;
settextclr(@coltext,@colback);
end;
{--------------------------------  SETLEFT  ----------------------------------}
FUNCTION SETLEFT(ST:ST126):ST126;
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
  FORMAT:=ST+COPY(Fill1,1,StLength-LENGTH(ST));
END;      { FUNC.  FORMAT }


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
         real1:=x;
         real2:=y;
         movtcurabs1(@real1,@real2);
         st1:=format('                                   ',l);
         text1(@st1);
         st1:=format(Dato,L);
         movtcurabs1(@real1,@real2);
         text1(@st1);
      end;

{   g_textcolor(col[4]);
   g_textbackground(col[3]);}

   for i:=1 to ninfo do
   with info[i] do
   begin
    { G_gotoxy(ix,iy);
     G_write(mess[i])}
   end;

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

{ procedure StampaMappa(CField:integer);
 var i,j:integer;
 begin
    gotoxy(1,1);
    g_textcolor(col[2]);
    j:=25;
    while (j > 1) and (SetRight(Mappa[j]) = '') do j:=j-1;
    for i:=1 to j do Mappa[i]:=SetRight(Mappa[i]);
    for i:=1 to j do
     begin
        if i >= 22 then
         begin
            g_textcolor(col[20]);
            g_textbackground(col[19]);
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
    g_textcolor(col[2]);
    g_textbackground(col[1]);
 end; }



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

{*****************}
  procedure UsaMaskera(Base,OffSet:word;NomeFile:st80;
                       var Campo,Chiave:integer;
                       dx,dy:integer;W,WVal,all,notzero:boolean);

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
   NPuntiFaccia = 4;

type
   punto  = record
               X,Y,Z : real;
            end;
   faccia = array[1..NPuntiFaccia] of punto;

   RigaTab = record
                Codice : string[20];
                Punti  : Faccia   ;
             end;

var buf:rigatab;

  const
     x='';
     inf='¨';

  var
     f:file of rigatab;
     ch:char;
     variabile:String[240];
     I,J,Cx,Cy:integer;
     flag1,ncar:integer;
     larga,alta:real;
  begin
     int1:=1;int2:=1;int3:=0;int4:=1;
     settext(@int1,@int2,@int3,@int4);
     int1:=7;
     int2:=0;
     settextclr(@int1,@int2);
     int1:=1;
     setlnstyle(@int1);
     int1:=15;
     setcolor(int1);
     ninfo:=0;
     UltimoAccesso:=0;
     I:=0;Cx:=0;Cy:=1;
     assign(f,NomeF);
     reset(f);
     while not(eof(f)) do
      begin
         read(f,buf);
         with buf do
         if (codice='L')or (codice='D')or(codice='DX')or (codice='END') then
         begin
         if codice='L' then
           begin
           int1:=1;
           setlnstyle(@int1);
           int1:=7;
           setcolor(int1);
           real1:=punti[1].x+dx;
           real2:=punti[1].y+dy;
           real3:=punti[2].x+dx;
           real4:=punti[2].y+dy;
           movabs1(@real1,@real2);
           lnabs1(@real3,@real4);
           end;
         if codice='D' then
           begin
           larga:=punti[2].x;
           alta:=punti[3].y;
           int1:=1;
           setcolor(col[1]);
           real1:=dx+larga;
           real2:=dy+alta;
           real3:=dx;
           real4:=dy;
           if stored then
             begin
             XImage:=round(real1*inx);
             YImage:=round(ysp-real2*iny);
             GetImage(round(real1*inx),round(ysp-real2*iny),round(real3*inx),round(ysp-real4*iny),Buf_Image);
             end;
           bar1(@real3,@real4,@real1,@real2);
           end
         end
         else
         begin
          if codice[1]= x then
          begin
             I:=I+1;
             with Tabella[I] do
              begin
                 Tipo:=codice[2];
                 x:=round(punti[1].x)+dx-1;
                 y:=round(punti[1].y)+dy;
                 ncar:=2;
                 variabile:='';
                 repeat
                    ncar:=ncar+1;
                    ch:=codice[ncar];
                    if ch in ['0'..'9'] then variabile:=variabile+ch;
                 until not(ch in['0'..'9']);

                 flag1:=0;
                 val(variabile,L,flag1);
                 if (flag1 <> 0) or (length(variabile) = 0) then L:=0;

                 if ch = ':' then
                  begin
                     variabile:='';
                     repeat
                        ncar:=ncar+1;
                        ch:=codice[ncar];
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
                 UltimoCampo:=I;
                 if Tipo in ['$','R','I','C'] then UltimoAccesso:=I;
             end;
          end
          else
            begin
              real1:=punti[1].x+dx;
              real2:=punti[1].y+dy;
              G_textcolor(col[2]);
              G_textbackground(col[1]);
              movtcurabs1(@real1,@real2);
              real1:=15;real2:=1;int1:=0;
              setstext(@real1,@real2,@int1);
              stext(@codice);
            end
         end
        end;


     close(f);


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
  g_textcolor(col[4]);
  g_textbackground(col[3]);
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

              real1:=x;
              real2:=y;

              movtcurabs1(@real1,@real2);
              st1:=format('                                   ',l);
              text1(@st1);
              st1:=format(Dato,L);
              movtcurabs1(@real1,@real2);
              st1:=format(Dato,L);
              text1(@st1);

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
          dato:=format(dato,l);
          g_textbackground(col[5]);
          g_textcolor(col[7]);
          writecampi(campo,true);
          Dato:=LINE_INPUT(X,Y,L,StartPos,' ',Dato,SetCode,ExitChar,FALSE,F,campo);
          Chiave:=ord(ExitChar);
          g_textbackground(col[3]);
          g_textcolor(col[4]);
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
                g_textbackground(col[3]);
                g_textcolor(col[4]);
                writecampi(I,true);
              end;

       end;
  end;


 begin
    {col[1]:=1;
    col[2]:=7;
    col[3]:=1;
    col[4]:=15;
    col[5]:=7;
    col[7]:=0;
    ctrlkey:=1;}
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
           {StampaMappa(CField);}
           g_textcolor(col[4]);
           g_textbackground(col[3]);
           WriteAllCampi;
        end;
     end
    else
     begin
        g_textbackground(col[3]);
        CarAddress(Base,OffSet);
        WriteAllCampi;
     end;

    while not(tabella[campo].flag) do
    if campo=ultimocampo then campo:=1 else campo:=campo+1;

    g_textbackground(col[1]);
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


(*

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
    if Conferma('mc4.msg','  ' + PStr^ + '  !  '+W_M(125),4) then
                                               {CONFERMA (S/N) }
     begin
        L:=Pos('.',Mask);
        assign(g,Copy(Mask,1,L)+'fil');   reset(g);
        while not(eof(g)) do
         begin
            readln(g,Est);
            gotoxy(1,21);
            write(W_M(126),PStr^+Est); ClrEol;
            {'Cancellazione file '}
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

    if Conferma('mc4.msg','  ' + Files.Src + ' a file ' + Files.Dst + '  !  '+W_M(125),3) then
                                                                             { CONFERMA (S/N) }
     begin
        L:=Pos('.',Mask);
        assign(g,Copy(Mask,1,L)+'fil');   reset(g);
        while not(eof(g)) do
         begin
            readln(g,Est);
            gotoxy(1,21);
            write(W_M(127),Files.Src+Est);   ClrEol;
            { 'copia file ' }
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


  *)

{------------------------IOTabella------------------------------------}
 procedure IOTabella(ISeg,IOfs:word;NDat,DatP,DatR:integer;var Chiave,Riga:integer;
                     mask:st80;SetNRighe,InitMask,IWVal:boolean;Tabx,Taby:integer);
  {... ISeg & IOfs contengono il SEG e l'OFS della tabella
   ... NDat Š il numero totale di righe
   ... DatP Š il numero di righe per pagina
   ... DatR Š il numero di CAMPI per riga
   ... Riga contiene il N. della riga da cui si Š usciti
   ... IWVal e' true se si fa riferimento all'ultima tabella usata :
       in tal caso si puo' specificare con riga la riga di accesso alla tabella
   ... SetNRighe = true se si vogliono numerare  le righe della tabella
                   in tal caso occorre che il primo campo della tabella
                   venga introdotto in riga 8.
                                                               }

  type buffer = array[1..80] of char;
  var ROfs:word;DOfs,i,j,k,campo,Lin,NPag,Limite : integer;
      IBase                                 : word;
      ExRet                                 : boolean;
      PPrec,PSucc                           : ^char;
      PBuff,PBuffMask                       : ^Buffer;
      Pagina                                : string[2];
      Npagina                               : integer;

  begin           {maskera}
      new(PBuff);     IBase:=IOfs;
      if IWVal then
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
           end
       end
      else
       begin
          i:=1;
          Campo:=1;
       end;

      Riga:=0;  ExRet:=true;

        repeat
           if SetNRighe and ExRet and not InitMask then
            begin
               (*TextColor(col[2]);
               gotoxy(70,1);*)
               if (DatP <> 1) then NPagina:=(1+(i div DatP))
               else NPagina:=(i div DatP);
               Str(Npagina:2,Pagina);
               real1:=900;
               real2:=690;
               G_textcolor(col[4]);
               G_textbackground(col[1]);
               movtcurabs1(@real1,@real2);
               text1(@Pagina);
            end;
           ExRet:=false;
           {
           with Tabella[Campo] do
            begin
               PBuffMask:=ptr(BAddr,OAddr);
               PBuff^:=PBuffMask^;
            end;
           }
           UsaMaskera(ISeg,IOfs,mask,Campo,Chiave,Tabx,Taby,InitMask,IWVal,true,true);
           if InitMask then
            begin
               DOfs:=SpaceTab(IOfs);
               ROFs:=DOfs div DatP; {..spazio occupato da una riga..}
            end;
           InitMask:=false;
           IWVal:=false;
           Lin:=(Campo div DatR)+1;
           if Campo mod DatR = 0 then Lin:=Lin-1;

           if { (PBuff^ <> PBuffMask^) or} (Chiave in [59..68]) then {CalcMask(IBase,NDat,DatR,Lin,Campo,Chiave,Mask)};
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

                      IWVal:=true;
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
                      if campo < UltimoAccesso then CampoSucc(campo)
                      else
                       begin
                          if i < NDat-DatP then
                           begin
                              i:=i+DatP;
                              IOfs:=IOfs+DOfs;
                              Campo:=0;   CampoSucc(Campo);
                              IWVal:=true;   ExRet:=true;
                           end
                          else write(chr(7));
                       end
                   end;
                27,59..62,65..68:;
                75:
                   begin
                      if campo > 1 then CampoPrec(campo)
                      else
                       begin
                          if i > 1 then
                           begin
                              i:=i-DatP;
                              IOfs:=IOfs-DOfs;
                              Campo:=DatP*DatR+1;   CampoPrec(Campo);
                              IWVal:=true;   ExRet:=true;
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
                           IWVal:=true;   ExRet:=true;
                        end
                       else write(#7);
                    end;
                72:  {..freccia in su'...}
                   if campo > DatR then campo:=campo-DatR
                   else
                    begin
                       if i > 1 then
                        begin
                           i:=i-DatP;
                           IOfs:=IOfs-DOfs;
                           Campo:=Campo+DatR*(DatP-1);
                           IWVal:=true;   ExRet:=true;
                        end
                       else write(#7);
                    end;
                81:
                   if i < NDat-DatP then
                    begin
                       i:=i+DatP;
                       IOfs:=IOfs+DOfs;
                       Campo:=0;   CampoSucc(Campo);
                       IWVal:=true;   ExRet:=true;
                    end
                   else write(chr(7));
                73:
                   if i > 1 then
                    begin
                       i:=i-DatP;
                       IOfs:=IOfs-DOfs;
                       Campo:=0;   CampoSucc(Campo);
                       IWVal:=true;   ExRet:=true;
                    end
                   else write(chr(7));
           end; { case }
        until (chiave in [27,59..68]);
        Riga:=i+(Campo div DatR);
        if Campo mod DatR = 0 then Riga:=Riga-1;
        dispose(PBuff);
    end;       {maskera}


end.