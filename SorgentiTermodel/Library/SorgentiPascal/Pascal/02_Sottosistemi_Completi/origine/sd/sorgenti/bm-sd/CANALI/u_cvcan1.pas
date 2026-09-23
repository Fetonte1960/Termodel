{$R+}    {Range checking off}
{$B+}    {Boolean complete evaluation on}
{$S+}    {Stack checking on}
{$I+}    {I/O checking on}
{$N-}    {No numeric coprocessor}
{$F+}

Unit U_CvCan1;


Interface

uses
{$Ifdef Windef}
  dummyfunction,
  textc,
{$else}
  Crt,
  Dos,
  halotp4,
{$endif}
libreriagenerale,utireport,definizcan,definiz,funzbase,Angoli,esiste,Load_d,WM,defuti,u_cvcan;

Procedure Cvcan1(nomerete:string);

{---------------------------------------------------------------------------}
Type TP_cvcan1=^obj_cvcan1;

obj_cvcan1=object
p_Proc:TP_cvcan1;
riga,Main,Br1,Br2:integer;
V_inv:recVert;
INV:Boolean;

Procedure Converti(tr1:integer;UltDir:real;inverti:Boolean;Main_VD,MainInv:Boolean);
end;

Var P_Cvcan1:TP_cvcan1;

Implementation
(*
const Ltabramo=16;

Type

    RigaRamo = RECORD
                 CodPezzo : STRING[5];
                 Descr : STRING[40];
                 CHFlag : CHAR;
                 Portata, Perdita : REAL;
                 A_D : INTEGER;
                 H, W, Ang, Phi : INTEGER;
                 L, R, ComVal : REAL;
                 C0, X, Y : REAL;
               END;

    Link    =^TabRamo;

    TabRamo = RECORD
                T : ARRAY[0..LTabRamo] OF RigaRamo;
                Ps, Pd, Pc : LINK;
                TR : BOOLEAN;
                CodTab : INTEGER;
              END;
 *)
var Tab   : TabRamo;
    Tab1  : Array[0..PezziTr] of RigaRamo;
    Fcan  :file of tabramo;
//    P0    :integer;
    orient,NUsc:integer;
    vrt   :recVert;
    c_Dir,c_DirZ:real;
    Dev,CanVert{,Inverti}:boolean;
    StMes,STMES1:string;
    cont:integer;


{***************************  InitTab1       *******************************}

Procedure InitTab_1;

var i:integer;

begin
  for i:=0 to PezziTr do
  with Tab1[i] do
    begin
    CodPezzo :='';
    Descr    :='';
    CHFlag   :=' ';
    Portata  :=0;
    Perdita  :=0;
    A_D      :=0;
    H        :=0;
    W        :=0;
    Ang      :=0;
    Phi      :=0;
    L        :=0;
    R        :=0;
    ComVal   :=0;
    C0       :=0;
    X        :=0;
    Y        :=0;
    end;
end;


{***************************  Fat_er     *****************************}

Procedure Fat_er(grafica:boolean);

begin
 {$ifdef windef}
 {$else}

 if grafica then CloseGraphics;

 {$endif}

 clrscr;
 gotoXy(5,10);
 write(stMes);
 repeat until keypressed;
 halt;

end;

{-----------------------------------------------------------------------------}


{***************************  Canale     *****************************}

Function Canale(Cod:string):Boolean;

begin
Canale:=False;
Cod :=UPstring(Cod);
while length(Cod)<5 do Cod:=Cod+' ';
if (Cod='310R ')or(Cod='310C ')or(Cod='310F ')or(Cod='     ') then Canale:=true;
end;

{***************************  Vuoto     *****************************}

Function Vuota(Cod:string):Boolean;

begin
Vuota:=False;
Cod :=setleft(Cod);
if Cod='' then Vuota:=true;
end;




{****************************** InitPezzi ***********************************}

procedure initPezzo(var recp:recpezzi);


begin
with recp do
  begin
  Codice:='  ';
  R:=0;
  A:=0;
  B:=0;
  Flag:='';
  Lung:=0;
  Ang:=0;
  Rag:=0;
  Perd:=0;
  port:=0;
  varie:=0;
  end;
end;

{****************************** NewPezzo *************************************}

Function NewPezzo:integer;
var i:integer;
Begin
i:=1;
while (i<UltPezzo)and(VPezzi^[i]^.Codice<>'') do i:=i+1;
if (i=UltPezzo)and(VPezzi^[i]^.Codice<>'') then

  begin

  if i<lungPezzi then

    begin
    i:=i+1;
    UltPezzo:=UltPezzo+1;
    if vpezzi^[i]=nil then new (VPezzi^[i]);
    VPezzi^[i]^.Codice:='';
    NewPezzo:=i;
    end

  else

    begin
    NewPezzo:=0;
    PieniP:=true;
    end;

  end

else newPezzo:=i;

if (i=UltPezzo)and(LungPezzi-ultPezzo<=20) then
  begin
  write(chr(7));
 { richiesta('');
  st1:='';
  str((lungPezzi-ultPezzo),st1);
  richiesta('Attenzione ! Potete inserire ancora '+st1+' pezzi');}
  end

end;


{*-*-*-*-*-*-*-*-*-*-*-*-*-*  Copia         *-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*}
 Var totperd:real=0;
     ramocor:Integer=0;
Procedure Copia(tronco,npezzo,NP:integer;invers:boolean);

{--------------------------------  SETright  ----------------------------------}
FUNCTION SETRIGHT(ST:STRING):STRING;
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

Var i,indiceP:integer;
    codicenew:string;
begin
with Tab1[npezzo] do
  begin
  //try
  VPezzi^[NP]^.indpezzo:=Tab1[npezzo].indp;
  VPezzi^[NP]^.Codice :=setright(CodPezzo);
  //except
  //VPezzi^[NP]^.Codice:='';
  //end;
  VPezzi^[NP]^.Flag   :=CHFlag;
  VPezzi^[NP]^.Port   :=Portata;
  VPezzi^[NP]^.Perd   :=Perdita;
  VPezzi^[NP]^.R      :=A_D;

  if invers then
    begin
    VPezzi^[NP]^.B      :=W;
    VPezzi^[NP]^.A      :=H;
    end
  else
    begin
    VPezzi^[NP]^.B      :=H;
    VPezzi^[NP]^.A      :=W;
    end;

  VPezzi^[NP]^.Ang    :=Ang;
  VPezzi^[NP]^.Lung   :=L;
  VPezzi^[NP]^.Rag    :=R;
  VPezzi^[NP]^.Varie  :=ComVal;
  {writeln(phi);}
  end;


with VPezzi^[NP]^ do
  begin
  if dati^[tronco]^.CodiceTubo<>ramocor then
    begin
    if(ramocor<>0) then
      begin
      WStrTab('');//ramo
      WStrTab(''); //codice
      WStrTab('');//diametro
      WStrTab('');//a
      WStrTab(''); //b
      WStrTab('');//lung
      WStrTab(''); //rag
      WStrTab(''); //angolo
      WStrTab('PerdRamo');  //Varie
      WStrTab('');
      WRealeTab(TotPerd,3);
      FinerigaTabella;
      totperd:=0;
      end;
    ramocor:=dati^[tronco]^.CodiceTubo;
    end;
  WIntTab(dati^[tronco]^.CodiceTubo);//ramo
  codicenew:=Codice;
  IndiceP:=find_Archivio(Codice);
  if indiceP<>0 then codicenew:=archivio^[indiceP].Codice;
  WStrTab(codicenew); //codice
  WRealeTab(R,0);//diametro
  WRealeTab(a,0);//a
  WRealeTab(b,0); //b
  WRealeTab(lung,2);//lung
  WRealeTab(rag,1); //rag
  WRealeTab(Ang,1); //angolo
  WrealeTab(Varie,3);  //Varie
  WRealeTab(Port,3);
  WRealeTab(Perd,3);
  totperd:=totperd+perd;
  {
  WRealeTab(,);
  WStrTab();
  WIntTab();
  }
  end;
FinerigaTabella;
end;

{***************************  InitTab        *******************************}

Procedure InitTab1(Var BufCan:TabRamo);

var i:integer;

begin
  for i:=0 to LTabRamo do
  with BufCan.T[i] do
    begin
    indp:=0;
    CodPezzo :='';
    Descr    :='';
    CHFlag   :=' ';
    Portata  :=0;
    Perdita  :=0;
    A_D      :=0;
    H        :=0;
    W        :=0;
    Ang      :=0;
    Phi      :=0;
    L        :=0;
    R        :=0;
    ComVal   :=0;
    C0       :=0;
    X        :=0;
    Y        :=0;
    end;
with BufCan do
  begin
  ps:=0;
  pc:=0;
  pd:=0;
  tr:=false;
  CodTab:=0;
  end;
end;

{*-*-*-*-*-*-*-*-*-*-*-*-*-*  Scambia        *-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*}

Procedure Scambia(npezzo:integer;Var invers:boolean);

Var Temp:real;
    Codice1:string;

begin
if invers then
with VPezzi^[NPezzo]^ do
  begin
  Temp:=a;
  a:=b;
  b:=temp;
  Codice1:=Format(UpString(Codice),5);
  if (Codice1='441R ')or(Codice1='443R ')or(Codice1='431R ')or(Codice1='433R ')or
     (Codice1='451R ')or(Codice1='453R ') then invers:=false;
  end;

end;

 {*-*-*-*-*-*-*-*-*-*-*-*-*-*  Trascrivi     *-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*}

Procedure Trascrivi(tr:integer;Var Main_vd,MainInv:boolean;Var Ultdir:real;var Inverti:boolean);

var i,j,k:integer;

    Temp,Temp1:Array[1..Pezzitr] of Integer;
    TempCod,TempCod1:STring[5];
    uguale,trovato:boolean;
    ultp,ultTrov:integer;

begin
for i:=1 to PezziTR do
  begin
  Temp1[i]:=0;
  Temp[i]:=0;
  end;


if Dati^[tr]^.Pezzi[0]=0 then  Dati^[tr]^.Pezzi[0]:=NewPezzo;
if Dati^[tr]^.Pezzi[0]=0 then
  begin
  stMes:=W_M(140);
  Fat_Er(false);
  end;
{'Non c`e spazio per inserire gli adattamenti e le serrande',false);}
InitPezzo(VPezzi^[Dati^[tr]^.Pezzi[0]]^);

if tr<>RisultCalc^.Origine then
  begin
  if Main_VD then Copia(tr,0,Dati^[tr]^.Pezzi[0],MainInv)
  else Copia(tr,0,Dati^[tr]^.Pezzi[0],inverti);
  end;


{writeln(lst,VPezzi^[Dati^[tr].Pezzi[0]].Codice,' ',Inverti);}
{writeln(lst,Dati^[tr].Num);}

k:=dati^[tr]^.ti;  {-- Cerca i pezzi collegati col disegno --}
UltTrov:=0;
repeat
if dis^[k]^.Npezzo<>0 then
  begin

  TempCod:=VPezzi^[Dati^[tr]^.Pezzi[dis^[k]^.Npezzo]]^.Codice;
  TempCod :=UPstring(TempCod);
  while length(TempCod)<5 do TempCod:=TempCod+' ';

  i:=UltTrov+1;
  trovato:=false;
  if i<=Pezzitr then
    repeat

    TempCod1:=UPString(Tab1[i].CodPezzo);
    while length(TempCod1)<5 do TempCod1:=TempCod1+' ';

    if (TempCod1=TempCod) Then
      begin
      if i=Pezzitr then
        begin
        dis^[k]^.Npezzo:=i;
        trovato:=true;
        Ulttrov:=i;
        end
      else
        begin

        if Canale(Tab1[i+1].CodPezzo)or(Tab1[i].Descr='') then
          begin
          if (Canale(Tab1[i-1].CodPezzo))or(vuota(Tab1[i+1].CodPezzo))or
             (Tab1[i].Descr='') then
            begin
            dis^[k]^.Npezzo:=i;
            trovato:=true;
            Ulttrov:=i;
            end;
          end
        end;
      end;

    i:=i+1;
    until (trovato)or(i>Pezzitr);

{  writeln(lst,trovato,':',dis^[k].Npezzo);}

  if not trovato then
    begin
    if dis^[k]^.Rid<>'' then
      begin
      dis^[k]^.Rid:='';
      dis^[k]^.NPezzo:=0;
      end
    else
      begin
      clrscr;
      gotoxy(5,10);
      { TODO -oDiego -cControlli da inserire : irregolarità sullaconversione del pezzo }
      writeln(W_M(141)+' ',Dati^[tr]^.num,' ',W_M(142),tempcod,W_M(143));
      {'Nodo ',Dati^[tr].num,': irregolarita sulla conversione, pezzo "',tempcod,'" mancante ');}
      repeat until keypressed;
      halt;
      end;
    end;
  end;

k:=dis^[k]^.NLinea;
until k=0;

i:=0;     {-- Rende della stessa lunghezza le tabelle e copia --}
repeat
i:=i+1;

tab1[i].CodPezzo:=setleft( tab1[i].CodPezzo);


if (Tab1[i].CodPezzo<>'')and(Dati^[tr]^.Pezzi[i]=0) then
  begin
  Dati^[tr]^.Pezzi[i]:=NewPezzo;
  if Dati^[tr]^.Pezzi[i]=0 then
    begin
    W_M(140);
    Fat_Er(false);
    end;
  {'Non c`e spazio per inserire gli adattamenti e le serrande',false);}
  end;


if (Tab1[i].CodPezzo<>'') then Copia(tr,i,Dati^[tr]^.Pezzi[i],False);

if (Tab1[i].CodPezzo='')and(Dati^[tr]^.Pezzi[i]<>0) then
  begin
  Vpezzi^[Dati^[tr]^.Pezzi[i]]^.Codice:='';
  Dati^[tr]^.Pezzi[i]:=0;
  end;

{
if Dati^[tr].Pezzi[i]<>0 then writeln(lst,VPezzi^[Dati^[tr].Pezzi[i]].codice);
}

until(i=Pezzitr);




ultp:=0;
i:=Dati^[tr]^.Ti;

{writeln(lst,'prima',inverti,' UltDir:',Ultdir:3:2);}

Repeat
if Dis^[i]^.Npezzo<>0 then
  begin
  {Dis^[i].Npezzo:=Temp[Dis^[i].Npezzo];}
  For ultp:=Ultp+1 to Dis^[i]^.Npezzo-1 do Scambia(Dati^[tr]^.Pezzi[Ultp],Inverti);
  if Dis^[i]^.Nlinea<>0 then
  CalcDirez1(i,Dis^[i]^.Nlinea,C_Dir,C_DirZ,UltDir,true,CanVert,Inverti);
  //else
  Scambia(Dati^[tr]^.Pezzi[Dis^[i]^.NPezzo],Inverti);
  {writeln(lst,VPezzi^[Dati^[tr].Pezzi[Dis^[i].NPezzo]].Codice,' ',Inverti,' UltDir:',Ultdir:3:2);}
  end;

CalcDirez(i,C_dir,C_DirZ);
if abs(abs(C_dirz)-Pi/2)>0.1 then UltDir:=C_dir;

i:=Dis^[i]^.NLinea;
until i=0;

end;


{*-*-*-*-*-*-*-*-*-*-*-*-*-*  Converti     *-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*}
Procedure Ft_er(stMes1:string);
begin
stMES:=w_M(60)+STMES1+' ';
STMES1:=W_M(112);
stmes:=stmes+stMes1;
Fat_er(false);
end;

Procedure obj_cvcan1.Converti(tr1:integer;UltDir:real;inverti:Boolean;Main_VD,MainInv:Boolean);


{*-*-*-*-*-*-*-*-*-*-*-*-*-* Main Converti *-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*}
Var i,k:integer;

begin
{ST_DISP('');}

//gotoxy(10,12);
//write(w_m(53),tr1);{*TR*}
//clreol;

InitTab_1;
//Read(Fcan,Tab);
tab:=Tabcalc^[dati^[tr1]^.indtabcalc]^;
for i:=0 to (LTabRamo-1) do Tab1[i]:=Tab.T[i];
if (Tab.pd=0)and(tab.ps=0)and(tab.pc<>0)then
  begin
  //Read(Fcan,Tab);
  for i:=1 to (LTabRamo-1) do Tab1[i+(LTabRamo-1)]:=Tab.T[i];
  end;

if (Tab.pd=0)and(tab.ps=0)and(tab.pc<>0)then
  begin
         {- Per evitare la creazione di una variabile temporanea -}

  str(Tab.CodTab,StMes1);
  Ft_er(StMes1);
  {('Nodo:'+StMes+' ,Impossibile inserire Nuovi pezzi',false);}
  end;


dati^[tr1]^.Num:=Tab.CodTab;
{
for i:=0 to pezzitr do  writeln(lst,Tab1[i].Codpezzo);
}

Trascrivi(tr1,Main_vd,MainInv,Ultdir,Inverti);


Main:=0;
Br1:=0;
Br2:=0;

NUsc:=1;

if Dati^[tr1]^.pros[2]<>0 then

begin

if dati^[tr1]^.pros[3]=0 then  {--- TEE ----}
  begin
  Nusc:=2;
  end

else          {---- CROCE  ---}

  begin
  nusc:=3
  end;
end;

i:=Dati^[tr1]^.Ti;
while Dis^[i]^.NLinea<>0 do i:=Dis^[i]^.NLInea;

if NUsc>1 then
  begin
  SETBRANCH(i,Nusc,Main,Br1,Br2,Orient,Vrt,UltDir,Inverti,V_inv,Main_VD);

  MainInv:=Inverti;

  K:=0;     {-- Inverte l`ingresso degli stacchi --}
  Repeat
  K:=K+1;
  if inverti<>V_Inv[k] then
    begin
    INV:=True;
    Scambia(Dati^[tr1]^.Pezzi[Dis^[i]^.NPezzo],INV);
    MainInv:=Not(mainInv);
    end;
  Until (inverti<>V_Inv[k])or(K=NUsc);
  end;

if Main<>0 then Tab.Pc:=p0;
if Br2<>0 then  Tab.Ps:=p0;
if Br1<>0 then  Tab.Pd:=p0;


if Main<>0 then
  begin
  new(P_proc);
  P_proc^.Converti(Dati^[tr1]^.pros[Main],UltDir,V_inv[Main],Main_VD,MainInv);
  dispose(P_proc);
  end;
if Br2<>0 then
  begin
  new(P_proc);
  P_proc^.Converti(Dati^[tr1]^.pros[Br2],UltDir,V_Inv[Br2],false,false);
  dispose(P_proc);
  end;
if Br1<>0 then
  begin
  new(P_proc);
  P_proc^.Converti(Dati^[tr1]^.pros[Br1],UltDir,V_Inv[Br1],false,false);
  dispose(P_proc);
  end;

end;

{***************************  StartConvers     *****************************}

Procedure StartConvers;


{*-*-*-*-*-*-*-*-*-*-*-*-*-*      MAIN     *-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*}

begin
   Cont:=0;
//   New(P0);
//   Assign(FCan,driveprog+NomeProg+'.Can');
//   ReSet(FCan);
   {St_disp('');}
   P_cvcan1^.Converti(RisultCalc^.Origine,NotVert,false,false,false);
   //dispose(P_cvcan1);
//   Close(FCan);
end;


Procedure Cvcan1(nomerete:string);

var q,i:integer;
    fc:text;

Begin
InitFileReport(I_sl(percorsodrive)+nomerete+'_Canali.rep');
Iniziotabella('TC',11);

//textcolor(7);
//textbackground(1);
//window(1,3,80,25);
{clrscr;}
//gotoxy(10,10);
//write(w_m(61));{*TR*}
{FILETRADUZ:='DUCT';
assign(fc,'drive1.int');
reset(fc);
read(fc,datadrive);
close(fc);
DataDrive:=datadrive+'\DatiCCA\';}
//LoadNome;

//if exist(Driveprog+NomeProg+'.Ret') then
//  begin
//  new(dis);
//  new(dati);
//  new(Vpezzi);
//  for i:=1 to lungpezzi do Vpezzi^[i]:=nil;
//  for i:=0 to lungdis   do Dis^[i]:=nil;
//  new(dis^[0]);
//  for i:=1 to lungdati  do Dati^[i]:=nil;
//  Grafica:=false;
//  LoadDis(Driveprog+Nomeprog);
  StartConvers;
//  SaveDis(Driveprog+Nomeprog);
//  end
Finetabella;
CloseFileReport;
end;
end.
