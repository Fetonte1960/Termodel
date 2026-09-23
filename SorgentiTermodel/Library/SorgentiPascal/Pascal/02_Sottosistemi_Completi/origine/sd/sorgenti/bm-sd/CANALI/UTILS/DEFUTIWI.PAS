unit defuti;
interface
uses
{$Ifdef dos}
  Crt,
  Dos,
{$endif}
{$Ifdef Win}
Wincrt,
OWindows,
{$Endif}
Turbo3; {Unit found in TURBO3.TPU}


    const
       Gmax=20;
       Fill='                                                                                ';
       MaxMenu=21;
       MaxCampi=250;
       MaxInfo=25;
       MIngX=20;
       MIngY=20;
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
       st1   = string[1]  ;
       st40  = string[40] ;
       st20  = string[20] ;
       linestr = string[80];
       DatiMenu=array[1..MaxMenu]of st80;
       Rec = record
               Flag:boolean;
               Tipo:char;
               L:integer;
               x,y:integer;
               BAddr,OAddr:word;
               CifreInt,CifreDec:integer;
            end;

       TabellaRec = array[1..MaxCampi] of Rec;
       TabellaMap = array[1..25] of st80;
       tyinfo=array[1..maxinfo]of
                  record
                     ix,iy:integer
                  end;
     var
       Menu:DatiMenu;
       Nmenu,Xmenu,Ymenu,SceltaMenu : integer;
       ColTesto,ColTesto1,vv        : integer;
       ColFondo,ColFondo1           : integer;
       Tabella                      : TabellaRec;
       info                         : Tyinfo;
       info1                        : Tyinfo;
       mess                         : Array[1..maxinfo] of st80;
       Mappa                        : TabellaMap;
       Ninfo                        : integer;
       Ninfo1                       : integer;
       primocampo,UltimoCampo       : integer;
       nuovocampo                   : integer;
       PrimoAccesso,UltimoAccesso   : integer;
       CtrlKey,verso                : integer;
       nero,blu,verde,celeste,rosso,magenta,marrone,grigiolight,
       grigio,blulight,verdelight,celestelight,rossolight,magentalight,
       giallo,bianco : integer;
       STV,STV1                      : ST3;
var uscita,a,colon:integer;
    nomeprogetto:st80;
    rigamenu:st80;
    fi:text;
    ncol,ncom:integer;
    vcomandi:array[1..20]of
             record
                   comando:st80;
                   colonna:integer;
                   menu:boolean;
             end;
    nome:st80;
    mousepres,mousetemp:boolean;
    mouset:string;
    xprec,yprec:integer;
    M_X,M_y:integer;
    pdes,psin,pcen:boolean;
    col:array[1..20]of integer;
    intero,reale,stringa,carattere:linestr;
    M_TYPE:st80;
    DATA_DRIVE,PianteDrive:ST40;
    glst:text;
    rimedio,causa,rapporto:st8;
    vecchiaexit:pointer;
    Exit_up:boolean;

procedure ReadColor;

procedure WriteMessage(Nome:st80;i:integer);

FUNCTION GETDATE:ST80;

{==========================================================================}
implementation

procedure ReadColor;
var f : text;
    St : st80;
    Str1: st80;
    cd,i  :integer;
begin

   assign(f,'Colori.dat');
   reset(f);
   for i:=1 to 20 do
     begin
     readln(f,St);
     Str1:=copy(St,1,2);
     val(Str1,col[i],cd);
     if cd<>0 then
       begin
       clrscr;
       writeln('Il file colori.dat di configurazione colori e` errato',chr(7));
       Halt
       end;
     end;
    close(f);
end;


procedure WriteMessage(Nome:st80;i:integer);
var f    : text;
    Riga : st80;
    k    : integer;
begin
   assign(f,Nome);
   reset(f);
   for k:=1 to i do readln(f,Riga);
   close(f);
   write(chr(7));
   {$Ifdef Dos}
   textbackground(4);   textcolor(14);
   {$Endif}
   gotoxy(1,21);  write(Riga);
   {$Ifdef Dos}
   textbackground(col[1]);   textcolor(col[2]);
   ClrEol;
   delay(1200);
   {$Endif}


   gotoxy(1,21);     ClrEol;
end;

FUNCTION GETDATE:ST80;
 TYPE
    REgister = Record
               Case integer of

           0:  (AX,BX,CX,DX,BP,SI,DI,DS,ES,FLAGS:WORD);
           1:  (AL,AH,BL,BH,CL,CH,DL,DH: Byte);
            END;
 VAR
    RECPACK:REGister;
    MONTH,DAY:STRING[2];
    YEAR:STRING[4];
    DX,CX:INTEGER;
 BEGIN
 {$Ifdef win}
 {$else}
    WITH RECPACK DO
     BEGIN
        AX:=$2A SHL 8;
     END;
    MSDOS(Dos.Registers(RECPACK));
    WITH RECPACK DO
     BEGIN
        STR(CX:4,YEAR);
        STR((DX MOD 256):2,DAY);
        STR((DX SHR 8):2,MONTH);
     END;
    YEAR:=copy(YEAR,3,2);
    if DAY[1] = ' ' then DAY[1]:='0';
    if MONTH[1] = ' ' then MONTH[1]:='0';
    GETDATE:=DAY+'-'+MONTH+'-'+YEAR;
  {$Endif}
 END;

end.


var
     ULTFIN:FINESTRA;
     POSX,POSY:INTEGER;
     pmainwindow:pwindowsobject;
implementation
end.