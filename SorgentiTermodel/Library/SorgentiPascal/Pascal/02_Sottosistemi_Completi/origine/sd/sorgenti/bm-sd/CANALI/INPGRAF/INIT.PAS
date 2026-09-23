{$R+}
{$B+}    {Boolean complete evaluation on}
{$S+}    {Stack checking on}
{$I+}    {I/O checking on}
{$N-}    {No numeric coprocessor}
{$F+}
{$O+}
{$C DEMANDLOAD}
unit init;

INTERFACE

uses crt,definiz,globfunz,genproc,gruti,halotp4,graph,WM,esiste,init_cca;

PROCEDURE Inizializza;

{---------------------------------------------------------------------------}
implementation


{*************************** INIZIALIZZA ********************************}

PROCEDURE Inizializza;
var dx_w,Dy_w:word;
    ind:integer;

procedure ReadColor;
var f : text;
    St : string[80];
    Str1: string[80];
    cd,i  :integer;

begin

  (* assign(f,'Colori.dat');
   reset(f);
   for i:=1 to 20 do
     begin
     readln(f,St);
     Str1:=copy(St,1,2);
     val(Str1,col[i],cd);
     if cd<>0 then
       begin
       clrscr;
       writeln(W_M(56),chr(7));  { 'Il file colori.dat di configurazione colori e` errato',chr(7));}
       Halt
       end;
     end;
    close(f);*)
end;


begin
  XFilo  :=0;
  YFilo  :=0;
  Snapx  :=true;
  snapz  :=true;
  SnapAng:=true;
  controllo:=true;
  nsimb:=0;
  {nrighetab:=0;}
  PXSez:=0;
  PYSez:=0;
  PZSez:=0;
  limXi:=0;
  limXs:=45434+45434*100/1000;
  limYI:=0;
  limYS:=limxs*750/1000;
  Xsup:=limXS;
  Xinf:=LIMXI;
  YSup:=LimYS;
  YInf:=LimYI;
  L_Xsup:=limXS;
  L_Xinf:=LIMXI;
  L_YSup:=LimYS;
  L_YInf:=LimYI;
  Xsupp:=limXS;
  Xinfp:=LIMXI;
  YSupp:=LimYS;
  YInfp:=LimYI;
  AltSez:='3';
  (*
  if exist(DriveDrive+'duct.cfg') then
  begin
    assign(fc,DriveDrive+'duct.cfg');
    reset(fc);
    read(fc,vrec);
    close(fc);
    device:=vrec.scheda;
    mode:=vrec.modo;
  end
  else
  begin
    clrscr;
    gotoxy(10,12);write(W_M(57)); { 'IL PROGRAMMA NON E` STATO ANCORA CONFIGURATO'); }
    delay(1000);
    halt;
  end;*)
  xw1:=0;xw2:=900;yw1:=45;yw2:=750;
  conf^.rcolore:=15;
  new(dis);
  new(dati);
  new(costant);
  new(mul);
  {new(GTerm);}
  new(Vpezzi);
  initcca;
  for ind:=1 to lungpezzi do Vpezzi^[ind]:=nil;
  for ind:=0 to lungdis   do Dis^[ind]:=nil;
  new(dis^[0]);
  for ind:=1 to lungdati  do Dati^[ind]:=nil;
  new(Hpgl);
  c1:=0;
  initgraphics(@mode);

  Dx_W:=xsp;
  Dy_W:=ysp;
  {writeln(lst,Device,' ',Mode);}
  setworld(@minxw,@minyw,@maxxw,@maxyw);
  int1:=2;int2:=8;
  setlocator(@int1,@int2);
  {mouse_init;}
  setcolor(c1);
  clr;
  real1:=500;real2:=350;
  orglocator(@real1,@real2);
  int1:=4;real1:=10;real2:=10;
  inithcur(@real2,@real1,@int1);
  loadmenu('discan.mnu');
  scelta:=0;
  sw:=0;
  ultcom:=0;
  iso:=false;
  stpl:='';
  fscalag:=0;
  orientg:=0;
  mont_D:=nil;
  Numerazione:=false;
  ReaDColor;
  stored:=false;
  stampa_win:=false;
  {
  if MaxAvail > Imagesize(1,1,xsp,ysp) div 2 then
    begin
    stored:=true;
    GetMem(Buf_image,Imagesize(0,0,xsp,ysp) div 2);

    end;
  }
  (*
  {inqAsp(@real1);}
  inqDrange(@int1,@int2);
  {
  writeln(lst,'xscheda:',int1,'yscheda:',int2,'aspetto:',real1);
  doppio1:=int1;doppio2:=int2;
  real4:=(maxyw-MinYw)/(Maxxw-MinXw);
  real4:=real4*((doppio1+1)/(doppio2+1))/real1;
  real1:=MaxxW/MaxyW;}
  real4:=1000/750/((int1+1)/(int2+1));
  asp:=real4;
  SetAsp(@real4);*)

  {-- Riduzioni --}
  new(vettore);
  new(riduz);
  if exist(Drivearc+'Riduzion.ark') then
    begin
    assign(Frid,Drivearc+'Riduzion.ark');
    reset(frid);
    read(Frid,riDuz^);
    close(frid);
    end
 else Fat_er(W_M(58),true); { 'Mancano le riduzioni',true); }

 rinfr_menu:=true;
 piccolo:=false;
 C_dist:=0;
 C_osnap:=false;
 Grafica:=true;
 Max_Wx:=1000;
 Memo_im:='';
 memo_pi:=false;
 Save_im:=false;
 altW:=round(ysp-(ysp*40./1000));
 real1:=900./1000;
 larW:=round(real1);
{ size:=imagesize(0,0,LarW,altW);}

 NFette:={trunc(size/65000)+1}4;

 Fetta:=round(AltW/Nfette);
 Larw:=round(xsp*real1);
{ size:=imagesize(0,0,LarW,fetta);}
 for ind:=1 to NFette do
 getmem(Punt_im[ind],Size);

 (* cippo *) With Trosnap do
             begin
                Vado := False ;
                Frx := 0;
                Fry := 0;
                FrAng:=0;
             end;
 pianfilt:=false;
end;

end.