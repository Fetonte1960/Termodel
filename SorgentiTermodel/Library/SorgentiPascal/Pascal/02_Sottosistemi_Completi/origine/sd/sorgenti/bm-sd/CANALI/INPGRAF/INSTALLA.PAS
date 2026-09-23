
unit installa;



interface
uses crt,dos,utilitie,definiz;

var
InitMask:boolean;
  InitMenu:boolean;



procedure gestinst(var uscita:integer);
implementation
var chiave1:integer;

procedure gestinst(var uscita:integer);

VAR
  ftext:text;
  Scelta:INTEGER;
  esci:boolean;


{----------------------------------- INITICONF --------------------------}
procedure initconf;
begin
     with vrec do
     begin
       DescrScheda:='';
       Scheda:='';
       Modo:=0;
       DescrDigitizer:='MICROSOFT SERIAL MOUSE e compatibili';
       Digitizer:='';
       DescrPlotter:='HEWLETT PACKARD mod.7475 e compatibili';
       Plotter:='';
       DescrStampante:='';
       Stampante:='';
     end;
end;

{----------------------------- VISUALIZZA ------------------------------}
procedure visualizza;
TYPE VISUAL=RECORD
            vi:string[40];
            di:string[40];
            pl:string[40];
            st:string[40];
            end;
var
    f:file of frec;
    vrec:frec;
    vis:visual;
    st3:char;

  Campo,Chiave,Error:INTEGER;
  CH:CHAR;
  

begin
 initconf;
 if exist('drivedrive+duct.cfg') then
 begin
   assign(f,'drivedrive+duct.cfg');
   reset(f);
   read(f,vrec);
   with vis do
   begin
     vi:=vrec.descrScheda;
     di:=vrec.descrDigitizer;
     pl:=vrec.descrplotter;
     st:=vrec.DescrStampante;
   end;
   close(f);
  ClrScr;  Campo:=1;

  InitMask:=true;
  InitMenu:=true;
  repeat
    M_UsaMaskera(SEG(vis),OFS(vis),SYSTEM_DRIVE+'Visual.MSK','pm',Campo,chiave,chiave1,
               bianco,grigiolight,InitMask,not InitMask,false,true,InitMenu);

    InitMask:=false;
    InitMenu:=false;
  until (chiave=27)or (chiave1<>11);

 end
 else
  begin
    clrscr;
    gotoxy(10,13);
    WRITE(CHR(7));
    Write('IL PROGRAMMA NON E'' STATO ANCORA CONFIGURATO ! ');
    DELAY(5000);
    uscita:=21;
  end;
end;



{---------------------------  VIDEO ---------------------------------- }


procedure instalVideo;

var st2:char;
    f:file of frec;
    vrecV:frec;

VAR
  Campo,Chiave,Error:INTEGER;
  CH:CHAR;
  b:integer;


 begin
    b:=0;
    initconf;
    ClrScr;  Campo:=1;

    InitMask:=true;
    InitMenu:=true;

  repeat
    M_UsaMaskera(SEG(b),OFS(b),'VIDEO.MSK','pm',Campo,chiave,chiave1,
               bianco,grigiolight,InitMask,not InitMask,false,true,InitMenu);

    InitMask:=false;
    InitMenu:=false;
   with Vrec do
    case b of
         1:begin
            scheda:='drivedrive+videadag.dev';
            descrscheda:='Adage PG90 Model 10';
            modo:=0;
           end;
         2:begin
            scheda:='drivedrive+videparl.dev';
            descrscheda:='AST VGA Plus';
            modo:=1;
           end;
         3:begin
            scheda:='drivedrive+videatip.dev';
            descrscheda:='ATI VGA WONDER (Planar Modes)';
            modo:=0;
           end;
         4:begin
            scheda:='drivedrive+videavip.dev';
            descrscheda:='ATI VIP, The Improved VGA';
            modo:=0;
           end;
         5:begin
            scheda:='drivedrive+videicba.dev';
            descrscheda:='AT & T Image Capture Board';
            modo:=0;
           end;
         6:begin
            scheda:='drivedrive+videinda.dev';
            descrscheda:='COMPAQ Portable 3';
            modo:=6;
           end;
         7:begin
            scheda:='drivedrive+videaill.dev';
            descrscheda:='Control System ARTIST Illustrator';
            modo:=1;
           end;
         8:begin
            scheda:='drivedrive+videincl.dev';
            descrscheda:='HERCULES InColor';
            modo:=0;
           end;
         9:begin
            scheda:='drivedrive+videherc.dev';
            descrscheda:='Herchules Monocrome Graphics';
            modo:=7;
           end;
        10:begin
            scheda:='drivedrive+vide3270.dev';
            descrscheda:='IBM 3270 PC';
            modo:=3;
           end;
        11:begin
            scheda:='';
            descrscheda:='IBM 8514';
            modo:=0;
           end;
        12:begin
            descrscheda:='IBM Ehanced Graphics Adapter (EGA)';
            scheda:='drivedrive+videibme.dev';
            modo:=4;
           end;
        13:begin
            descrscheda:='IBM Personal System /2 VGA';
            scheda:='drivedrive+videibmv.dev';
            modo:=7;
           end;
        14:begin
            scheda:='';
            descrscheda:='IBM Professional Graphics Adapter';
            modo:=0;
           end;
        15:begin
            scheda:='drivedrive+videmvp.dev';
            descrscheda:='Matrox MVP-AT';
            modo:=1;
           end;
        16:begin
            scheda:='drivedrive+videmet8.dev';
            descrscheda:='Metheus 1008 Display Processor';
            modo:=7;
           end;
        17:begin
            scheda:='drivedrive+videnine.dev';
            descrscheda:='Number Nine Revolution';
            modo:=0;
           end;
        18:begin
            scheda:='drivedrive+videa480.dev';
            descrscheda:='Paradise Autoswitch 480';
            modo:=6;
           end;
        19:begin
            scheda:='drivedrive+videparl.dev';
            descrscheda:='Paradise VGA Professional';
            modo:=1;
           end;
        20:begin
            scheda:='drivedrive+videparp.dev';
            descrscheda:='Paradise Professional VGA Planar Modes';
            modo:=0;
           end;
        21:begin
            scheda:='drivedrive+videprin.dev';
            descrscheda:='Sigma designs Laser View';
            modo:=0;
           end;
        22:begin
            scheda:='drivedrive+videtosh.dev';
            descrscheda:='Toshiba Video Plasma T3100';
            modo:=2;
           end;
        23:begin
            scheda:='drivedrive+videudc.dev';
            descrscheda:='Univision UDC-800';
            modo:=0;
           end;
        24:begin
            scheda:='drivedrive+videvcda.dev';
            descrscheda:='Virtual Raster Interface Cordata LP 300 X';
            modo:=0;
           end;
        25:begin
            scheda:='drivedrive+videvdem.dev';
            descrscheda:='Virtual Raster Interface (EMS)';
            modo:=0;
           end;
        26:begin
            scheda:='drivedrive+videWyse.dev';
            descrscheda:='WYSE WY-700';
            modo:=7;
           end;
     end; {case b}
   until (chiave=27) or (chiave1<>12);
   initmenu:=true;
   if (exist('drivedrive+duct.cfg'))and (b>0) then
   begin
     assign(f,'drivedrive+duct.cfg');
     reset(f);
     read(f,vrecV);
     vrecV.Scheda:=vrec.Scheda;
     vrecV.DescrScheda:=vrec.DescrScheda;
     vrecV.modo:=vrec.modo;
     rewrite(f);
     write(f,vrecV);
     close(f);
   end
   else
   if b>0 then
   begin
     assign(f,'drivedrive+duct.cfg');
     rewrite(f);
     write(f,vrec);
     close(f);
   end;
 end;

{-------------------------------- STAMPANTI ---------------------------- }

Procedure InstalStampanti;

const  elstamp:array[1..21]of string=
       ('drivedrive+prinact2.drv','drivedrive+prinastt.drv',
       'drivedrive+princolm.drv','drivedrive+princna2.drv',
       'drivedrive+princonr.drv',
        'drivedrive+princlsr.drv','drivedrive+prinepgq.drv',
        'drivedrive+prinepjx.drv','drivedrive+prinfusu.drv',
        'drivedrive+prinepsn.drv',
        'drivedrive+prinfusu.drv','drivedrive+pringeni.drv',
        'drivedrive+pringncm.drv','drivedrive+prindjet.drv',
        'drivedrive+prinlasr.drv',
        'drivedrive+prinljtp.drv','drivedrive+princljt.drv',
        'drivedrive+prinklsr.drv','drivedrive+prinfusu.drv',
        'drivedrive+prinpans.drv',
        'drivedrive+prinxjet.drv');

       descrstamp:array[1..21] of string[40]=
 ('ACT Chromajet II','AST TurboLaser','CALCOMP Color Master or PlotMaster',
  'CANON LPB-8A2','Conographics Conovision 2800','CORDATA LP-300X Laser Printer',
   'EPSON GQ-3500','EPSON JX-80','EPSON LQ 2500','EPSON MX-80','FUJITSU DL 2400',
   'GENICOM 1000 Series','GENICOM 3184','HEWLETT PACKARD DeskJet','HELWETT PACKARD LaserJet',
   'HP LaserJet plus e  Series II','IBM Color JetPrinter 3852','KYOCERA F-1010 Compact Laser',
   'NEC Pinwriter P5XL','PANASONIC KX-P4450 Laser Printer','XEROX 4020');

 var st2:char;
    f:file of frec;
    vrecS:frec;

VAR
  Campo,Chiave,Error:INTEGER;
  CH:CHAR;
  b:integer;



 begin
    b:=0;
    initconf;
    ClrScr;  Campo:=1;

    InitMask:=true;
    InitMenu:=true;

  repeat
    M_UsaMaskera(SEG(b),OFS(b),'stamp.MSK','pm',Campo,chiave,chiave1,
               bianco,grigiolight,InitMask,not InitMask,false,true,InitMenu);

    InitMask:=false;
    InitMenu:=false;
    vrec.Stampante:= elstamp[b];
    vrec.descrstampante:=descrstamp[b];

   until (chiave=27) or (chiave1<>12);
   initmenu:=true;
   if (exist('drivedrive+duct.cfg'))and (b>0) then
   begin
     assign(f,'drivedrive+duct.cfg');
     reset(f);
     read(f,vrecS);
     vrecS.Stampante:=vrec.Stampante;
     vrecS.DescrStampante:=vrec.DescrStampante;
     rewrite(f);
     write(f,vrecS);
     close(f);
   end
   else
   if b>0 then
   begin
     assign(f,'drivedrive+duct.cfg');
     rewrite(f);
     write(f,vrec);
     close(f);
   end;
 end;

{-------------------------------- DIGITIZER -----------------------}

PROCEDURE Instaldigitizer;

VAR
  Campo,Chiave,Error:INTEGER;
  CH:CHAR;
  b:integer;

begin
    b:=0;
    ClrScr;  Campo:=1;

    InitMask:=true;
    InitMenu:=true;

  repeat
    M_UsaMaskera(SEG(b),OFS(b),'digit.MSK','pm',Campo,chiave,chiave1,
               bianco,grigiolight,InitMask,not InitMask,false,true,InitMenu);

    InitMask:=false;
    InitMenu:=false;

   until (chiave=27) or (chiave1<>12);

end;



{*********************************** MAIN ********************************}

BEGIN
  esci:=false;
  REPEAT

      CASE uscita OF
       11:VISUALIZZA;
       12:INSTALVIDEO;
       13:INSTALDIGITIZER;
       14:INSTALSTAMPANTI;
       else esci:=true;
       end;
       if uscita in[11..14] then uscita:=chiave1;

  UNTIL esci;
END;  { PROC. GEST_MENU }


end.