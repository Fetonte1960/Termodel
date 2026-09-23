{$R+}    {Range checking off}
{$B+}    {Boolean complete evaluation on}
{$S+}    {Stack checking on}
{$I+}    {I/O checking on}
{$N-}    {No numeric coprocessor}
{$M 65000,16384,655360} {Turbo 3 default stack and heap}
{$F+}
{$O+}

unit installa;



interface
uses crt,dos,definiz,utilitie,defuti,{graph,}WM;





procedure gestinst(var uscita:integer);

implementation
type recstamp=record
          STepson:string[1];
          STlaser:string[1];
          LungMod:integer;
          Ruotata:string[1];
          PortaP :Integer;
          end;

type recplot=record
          tipo     :integer;
          TipoCarta:string[14];
          ruotata  :string[1];
          pORTA    :INTEGER;
          Penne    :array[1..8] of integer;
          end;
var
Vstamp          :recstamp;
  Vplot         :ReCplot;
  Fplot         :file of reCplot;
  Fstamp        :file of recstamp;
var chiave1:integer;
    esci:boolean;
    i:integer;
    initmask,initmenu:boolean;
    ft:text;
    drive,driveC,driveI:string;

procedure gestinst(var uscita:integer);

VAR
  ftext:text;
  Scelta:INTEGER;
  esci:boolean;



{----------------------------------- INITICONF --------------------------}
Procedure initstamp;
begin
  with vstamp do
  begin
  STepson:='';
  STlaser:='';
  LungMod:=0;
  Ruotata:='';
  PortaP :=0;
  end;
end;


Procedure initPlot;
begin
   with vplot do
   begin
   tipo:=0;
   TipoCarta:='';
   ruotata  :='';
   PORTA:=0;
   for i:=1 to 8 do Penne[i]:=0;
   end;
end;

Procedure init7475;
begin
   with vplot do
   begin
   tipo:=1;
   TipoCarta:='A3';
{N}   ruotata  :=CH2;
   PORTA:=1;
   for i:=1 to 8 do Penne[i]:=1;
   end;
end;
Procedure init7550;
begin
   with vplot do
   begin
   TIPO:=2;
   TipoCarta:='A3';
{N}   ruotata  :=CH2;
   PORTA:=1;
   for i:=1 to 8 do Penne[i]:=1;
   end;
end;
Procedure init7580;
begin
   with vplot do
   begin
   Tipo:=3;
   TipoCarta:='A1';
{N}   ruotata  :=CH2;
   PORTA:=1;
   for i:=1 to 8 do Penne[i]:=1;
   end;
end;
Procedure init7585;
begin
   with vplot do
   begin
   tipo:=4;
   TipoCarta:='A0';
{N}   ruotata  :=CH2;
   PORTA:=1;
   for i:=1 to 8 do Penne[i]:=1;
   end;
end;
Procedure init7586;
begin
   with vplot do
   begin
   tipo:=5;
   TipoCarta:='A0';
{N}   ruotata  :=CH2;
   PORTA:=1;
   for i:=1 to 8 do Penne[i]:=1;
   end;
end;
Procedure initDFPRO;
begin
   with vplot do
   begin
   tipo:=6;
   TipoCarta:='A1';
{N}   ruotata  :=CH2;
   PORTA:=1;
   for i:=1 to 8 do Penne[i]:=1;
   end;
end;
Procedure initDFMAS;
begin
   with vplot do
   begin
   tipo:=7;
   TipoCarta:='A0';
{N}   ruotata  :=CH2;
   PORTA:=1;
   for i:=1 to 8 do Penne[i]:=1;
   end;
end;
{----------------------------- VISUALIZZA ------------------------------}
procedure visualizza;
TYPE VISUAL=RECORD
            vi:string[40];
            di:string[80];
            pl:string[40];
            st:string[40];
            end;
type st80=string[80];


var
    vis:visual;
    st3:char;
    stm:string;
    DRIVER,MODO:INTEGER;

  Campo,Chiave,Error:INTEGER;
  CH:CHAR;
  f:text;
  a:integer;
begin
   if exist('stamp.cfg')then
    begin
      assign(fstamp,'stamp.cfg');
      reset(fstamp);
      read(fstamp,vstamp);
      close(fstamp);
      if vstamp.stepson[1]='*' then vis.st:=W_M(10);  {'EPSON FX80 O COMPATIBILE';}
      if vstamp.stLASER[1]='*' then vis.st:=W_M(11);  {'HP LASER JET III O COMPATIBILE';}
    end
    else vis.st:=W_M(12);  {'NESSUNA';}
   if exist('plot.cfg')then
     begin
      assign(fplot,'plot.cfg');
      reset(fplot);
      read(fplot,vplot);
      close(fplot);
      case vplot.tipo of
      1:vis.pl:='HP 7475';
      2:vis.pl:='HP 7550';
      3:vis.pl:='HP 7580';
      4:vis.pl:='HP 7585';
      5:vis.pl:='HP 7586';
      6:vis.pl:='HP DRAFT PRO';
      7:vis.pl:='HP DRAFT MASTER';
      END;
     end
     else vis.pl:=W_M(13); {'NESSUNO';}
   ST3:=' ';
   {detectgraph(driver,modo);}
    if exist('video.cfg') then
    begin
      ASSIGN(F,'video.cfg');
      reset(f);
      read(f,st3);
      close(f);
{S}      if upcase(st3)=CH1 then driver:=6;
   end;
   case driver of
     1:vis.vi:='IBM COLOR GRAPHICS CGA';
     2:vis.vi:='IBM MNOCROME GRAPHICS CARD MCCA';
     3:vis.vi:='IBM EHANCED GRAPHICS ADAPTER EGA';
     4:vis.vi:='IBM EHANCED GRAPHICS ADAPTER EGA64';
     5:vis.vi:='IBM EHANCED GRAPHICS ADAPTER MONOCROME EGAMono';
     6:vis.vi:='IBM 8514 1024 x 768';
     7:vis.vi:='HERCULES MONOCROME';
     8:vis.vi:='ATT400';
     9:vis.vi:='IBM VIDEO GRAPHICS ARRAY VGA';
    10:vis.vi:='IBM PC3270';
   END;


    a:=initmouse(stm);
    vis.di:=copy(upstring(stm),1,40);
    InitMask:=TRUE;
    InitMenu:=TRUE;
    CAMPO:=1;
    CHIAVE:=1;
    CLRSCR;

  repeat
    M_UsaMaskera(SEG(vis),OFS(vis),drive+'Visual.MSK','pm',Campo,chiave,chiave1,
               bianco,grigiolight,InitMask,not InitMask,false,true,InitMenu);

    InitMask:=false;
    InitMenu:=false;
  until (chiave=27)or (chiave1<>11);

end;



{-------------------------------- STAMPANTI ---------------------------- }

Procedure InstalStampanti;


VAR
  Campo,Chiave,Error:INTEGER;
  CH:CHAR;



 begin
    if exist('stamp.cfg')then
    begin
      assign(fstamp,'stamp.cfg');
      reset(fstamp);
      read(fstamp,vstamp);
      close(fstamp);
    end else initstamp;

    ClrScr;  Campo:=1;

    InitMask:=true;
    InitMenu:=true;

  repeat
    M_UsaMaskera(SEG(vstamp),OFS(vstamp),drive+'stamp.MSK','pm',Campo,chiave,chiave1,
               bianco,grigiolight,InitMask,not InitMask,false,true,InitMenu);

    InitMask:=false;
    InitMenu:=false;


   until (chiave=27) or (chiave1<>12);
   initmenu:=true;
   assign(fstamp,drivec+'stamp.cfg');
   rewrite(fstamp);
   write(fstamp,vstamp);
   close(fstamp);
   assign(fstamp,drivei+'stamp.cfg');
   rewrite(fstamp);
   write(fstamp,vstamp);
   close(fstamp);
 end;


 {-------------------------------- PLOTTER ---------------------------- }

Procedure InstalPLOTTER;


VAR
  Campo,Chiave,Error:INTEGER;
  CH:CHAR;
  nfile:string;

  map:tabellamap;
  tab:tabellarec;
  ec:boolean;
  b:integer;


 begin
    ec:=false;
    if exist('plot.cfg')then
     begin
      ec:=true;
      assign(fplot,'plot.cfg');
      reset(fplot);
      read(fplot,vplot);
      b:=vplot.tipo;
      close(fplot);
     end else initplot;
    nfile:='';
    ClrScr;  Campo:=1;
    InitMask:=true;
    InitMenu:=true;

  repeat
    M_UsaMaskera(SEG(vplot.tipo),OFS(vplot.tipo),drive+'elplot.MSK','pm',Campo,chiave,chiave1,
               bianco,grigiolight,InitMask,not InitMask,false,true,InitMenu);

    InitMask:=false;
    InitMenu:=false;

   if chiave=61 then
   begin
     ClrScr;  Campo:=1;

     InitMask:=true;
     InitMenu:=true;
     map:=mappa^;
     tab:=Tabella^;
     if vplot.tipo<>b then ec:=false;
     case vplot.tipo of
      1:begin
          nfile:=drive+'7475.msk';
          if not(ec) then init7475;
        end;
      2:begin
          nfile:=drive+'7550.msk';
          if not(ec) then init7550;
        end;
      3:begin
          nfile:=drive+'7580.msk';
          if not(ec) then init7580;
        end;
      4:begin
          nfile:=drive+'7585.msk';
          if not(ec) then init7585;
        end;
      5:begin
          nfile:=drive+'7586.msk';
          if not(ec) then init7586;
        end;
      6:begin
          nfile:=drive+'dfpro.msk';
          if not(ec) then initdfpro;
        end;
      7:begin
          nfile:=drive+'dfmas.msk';
          if not(ec) then initdfmas;
        end;
     end;

     repeat
        M_UsaMaskera(SEG(vplot),OFS(vplot),nfile,'pm',Campo,chiave,chiave1,
               bianco,grigiolight,InitMask,not InitMask,false,true,InitMenu);
       InitMask:=false;
       InitMenu:=false;
     until(chiave=27) and (chiave1<>15) or (chiave=61);
    if chiave=61 then
    begin

      mappa^:=map;
      Tabella^:=tab;
      clrscr;
      stampamappa(grigiolight);
      campo:=1;
      b:=vplot.tipo;;
    end;
   end;
   until (chiave=27) and (chiave1<>15);
   initmenu:=true;
   assign(fplot,drivec+'plot.cfg');
   rewrite(fplot);
   write(fplot,vplot);
   close(fplot);
   assign(fplot,drivei+'plot.cfg');
   rewrite(fplot);
   write(fplot,vplot);
   close(fplot);
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
    M_UsaMaskera(SEG(b),OFS(b),drive+'digit.MSK','pm',Campo,chiave,chiave1,
               bianco,grigiolight,InitMask,not InitMask,false,true,InitMenu);

    InitMask:=false;
    InitMenu:=false;

   until (chiave=27) or (chiave1<>12);

end;


PROCEDURE InstalVIDEO;

VAR
  Campo,Chiave,Error:INTEGER;
  CH:STring[1];
  b:integer;
  F:TEXT;
begin
    ch:='';
    if exist('video.cfg') then
    begin
      ASSIGN(F,'video.cfg');
      reset(f);
      read(f,ch);
      close(f);
    end else ch[1]:=' ';
    ClrScr;  Campo:=1;
    InitMask:=true;
    InitMenu:=true;

  repeat
    M_UsaMaskera(SEG(CH),OFS(CH),drive+'VIDEO.MSK','pm',Campo,chiave,chiave1,
               bianco,grigiolight,InitMask,not InitMask,false,true,InitMenu);

    InitMask:=false;
    InitMenu:=false;

   until (chiave=27) or (chiave1<>12);
   ASSIGN(F,drivec+'video.cfg');
   rewrite(f);
   writeln(f,ch);
   close(f);
   ASSIGN(F,drivei+'video.cfg');
   rewrite(f);
   writeln(f,ch);
   close(f);

end;



{*********************************** MAIN ********************************}



BEGIN
  if exist('drive1.int') then
  begin
    assign(ft,'drive1.int');
    reset(ft);
    read(ft,drive);
    close(ft);
  end
  else drive:='';
  drivec:=drive+W_M(15);   {'\cca\';}
  drivei:=drive+W_M(16);   {'\cca\inpgraf\';}
  drive:=drive+W_M(17);    {'\daticca\';}
  esci:=false;
  REPEAT

      CASE uscita OF
       11:VISUALIZZA;
       12:INSTALVIDEO;
       13:INSTALDIGITIZER;
       14:INSTALSTAMPANTI;
       15:INSTALplotter;
       else esci:=true;
       end;
       if uscita in[11..15] then uscita:=chiave1;

  UNTIL esci;
END;  { PROC. GEST_MENU }


end.