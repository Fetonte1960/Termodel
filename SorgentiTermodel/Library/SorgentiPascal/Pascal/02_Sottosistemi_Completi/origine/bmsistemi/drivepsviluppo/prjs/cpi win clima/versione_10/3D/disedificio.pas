unit DisEdificio;

interface
uses sysutils,graphics,UOggetti,ULeggiscriviDati,Udb,libreriagenerale,
     varcarichi,calcolaZ,variabili3d,geometria,chiamateOggetti,progress3D,dialogs,funz_reti,definiz;

type

Ar_RecPia1=array[1..MaxPiani]of RecPia;
var PianiD:^Ar_RecPia1;
    NPiani1: Integer;
 Const buchi=false;
      {$IFDEF CANALI3D}
        canali=true;
      {$ELSE}
        canali=false;
      {$ENDIF}
Var Valid_lineasel_3d:boolean=false;
    Valid_bloccosel_3D:boolean=false;
    lineasel_3d:record
                piano:string;
                x1,y1,z1,x2,y2,z2:real;
                end;
    bloccosel_3d:record
                 x1,y1,z1:real;
                 end;

    Kmintrasm:real=0;
    Kmaxtrasm:real=0;
    Piano_selez:string;
    item_selez:integer=0;
    Modosel_reti:boolean=false;
    Modosel_edificio:boolean=false;
    lineaselr:boolean=false;
    Troncoselr:integer=0;
    Troncoselr1:integer=0;
    x1selr,y1selr,z1selr,x2selr,y2selr,z2selr:real;
    Anteprima_reti:boolean=false;

Procedure Disegnaedificio(percorso:string;ac:boolean);
Function IndPiano(NomePiano: String):Integer;
Procedure Proprieta_PJB(pc,rc,irc,tipo:string;xogg,yogg,zogg,x1ogg,y1ogg,z1ogg:real);
Procedure AnteprimaReti;

implementation
uses U3dsd;
{ TODO -oDiego -cNavigazione canali : visualizza errori }
Procedure viserrori(percorso:string);
Var Ferrori:Textfile;
    buf:string;
begin
form1.Merrorican.Lines.clear;
if fileexists(IncludeTrailingPathDelimiter(percorso) + 'errorican.txt') then
  begin
  assign(ferrori, IncludeTrailingPathDelimiter(percorso) + 'errorican.txt');
  reset(ferrori);
  while not eof (ferrori) do
    begin
    readln(ferrori,buf);
    form1.Merrorican.Lines.Add(buf);
    end;
  close(ferrori);
  end;
end;

Function IndPiano2(NomePiano: String):Integer;
Var ST: String;
    i: Integer;

begin
 i := 1;
 while (i < NPiani1) and (Uppercase(NomePiano) <> Uppercase(PianiD^[i].Cod)) do
  inc(i);
 if Uppercase(NomePiano) = Uppercase(PianiD^[i].Cod) then
  result := i
 else result := 0;
end;

Function IndPiano1(NomePiano: String):Integer;
Var ST: String;
    i: Integer;

begin
 i := 1;
 while (i < NPiani1) and (Uppercase(NomePiano)<> Uppercase(Copy(PianiD^[i].Cod, 1, 30))) do
  inc(i);
 if Uppercase(NomePiano) = Uppercase(Copy(PianiD^[i].Cod, 1, 30)) then
  result := i
 else result := 0;
end;

Function IndPiano(NomePiano: String):Integer;
Var ST: String;
    i: Integer;

begin
 ST := ExtractFileName(NomePiano);
 NomePiano := Copy(ST,1,Length(ST)-4);
 i := 1;
 while (i < NPiani1) and (Uppercase(NomePiano)<> Uppercase(PianiD^[i].Cod)) do
  inc(i);
 if Uppercase(NomePiano) = Uppercase(PianiD^[i].Cod) then
  result := i
 else result := 0;
end;

Function Parete_selez(item:integer;x1,y1,z1,x2,y2,z2:real;colore:Tcolori3d;piano:string):Tcolori3d;
Var dir,dir1,dirz:real;
begin
result:=colore;
if (Modosel_edificio)and(piano_selez=uppercase(piano))then
  begin
  if  ((vicino(x1selr,y1selr,z1selr,x1,y1,z1)and vicino(x2selr,y2selr,z2selr,x2,y2,z2))or
      (vicino(x1selr,y1selr,z1selr,x2,y2,z2)and vicino(x2selr,y2selr,z2selr,x1,y1,z1)))
  then result:=cblu
  else
    begin  //individua le linee spezzate durante il calcolo
    if  vicino(x1selr,y1selr,z1selr,x1,y1,z1)  then
      begin
      calc_d(x1selr,y1selr,z1selr,x2selr,y2selr,z2selr,dir,dirz);
      calc_d(x1,y1,z1,x2,y2,z2,dir1,dirz);
      if abs(dir-dir1)<0.01 then  result:=cblu;
      end;
    if  vicino(x1selr,y1selr,z1selr,x2,y2,z2)  then
      begin
      calc_d(x1selr,y1selr,z1selr,x2selr,y2selr,z2selr,dir,dirz);
      calc_d(x2,y2,z2,x1,y1,z1,dir1,dirz);
      if abs(dir-dir1)<0.01 then  result:=cblu;
      end;
    if  vicino(x2selr,y2selr,z2selr,x1,y1,z1)  then
      begin
      calc_d(x2selr,y2selr,z2selr,x1selr,y1selr,z1selr,dir,dirz);
      calc_d(x1,y1,z1,x2,y2,z2,dir1,dirz);
     if abs(dir-dir1)<0.01 then  result:=cblu;
      end;
    if  vicino(x2selr,y2selr,z2selr,x2,y2,z2)  then
      begin
      calc_d(x2selr,y2selr,z2selr,x1selr,y1selr,z1selr,dir,dirz);
      calc_d(x2,y2,z2,x1,y1,z1,dir1,dirz);
      if abs(dir-dir1)<0.01 then  result:=cblu;
      end;
    end;
  end;
 if result=cblu then
 item_selez:=item;
// showmessage('selezionato');
end;


Procedure Disegnaedificio(percorso:string;ac:boolean);
 Var sr:Tsearchrec;
     NomeFile : String;
     perc:string;
     Trovato : Integer;
     sa:string;

procedure DisegnaTerminale(z, x, y, larg, prof, alt, angolo: double;collegato:boolean);
begin
if collegato then
  Parallelepi(z, x, y, angolo, larg, prof, alt, cblu)
else Parallelepi(z, x, y, angolo, larg, prof, alt, crosso);
end;




Procedure Linea_selez(tronco:integer;x1,y1,z1,x2,y2,z2,spes:real;Color:Tcolori3d);
Var dir,dir1,dirz:real;
begin

if (Modosel_reti)and(lineaselr)and(troncoselr=0)then
begin
if    ((vicino(x1selr,y1selr,z1selr,x1,y1,z1)and vicino(x2selr,y2selr,z2selr,x2,y2,z2))or
      (vicino(x1selr,y1selr,z1selr,x2,y2,z2)and vicino(x2selr,y2selr,z2selr,x1,y1,z1)))
then troncoselr:=tronco
else
  begin  //individua le linee spezzate durante il calcolo
  if  vicino(x1selr,y1selr,z1selr,x1,y1,z1)  then
    begin
    calc_d(x1selr,y1selr,z1selr,x2selr,y2selr,z2selr,dir,dirz);
    calc_d(x1,y1,z1,x2,y2,z2,dir1,dirz);
    if abs(dir-dir1)<0.01 then  troncoselr:=tronco;
    end;
  if  vicino(x1selr,y1selr,z1selr,x2,y2,z2)  then
    begin
    calc_d(x1selr,y1selr,z1selr,x2selr,y2selr,z2selr,dir,dirz);
    calc_d(x2,y2,z2,x1,y1,z1,dir1,dirz);
    if abs(dir-dir1)<0.01 then  troncoselr:=tronco;
    end;
  if  vicino(x2selr,y2selr,z2selr,x1,y1,z1)  then
    begin
    calc_d(x2selr,y2selr,z2selr,x1selr,y1selr,z1selr,dir,dirz);
    calc_d(x1,y1,z1,x2,y2,z2,dir1,dirz);
    if abs(dir-dir1)<0.01 then  troncoselr:=tronco;
    end;
  if  vicino(x2selr,y2selr,z2selr,x2,y2,z2)  then
    begin
    calc_d(x2selr,y2selr,z2selr,x1selr,y1selr,z1selr,dir,dirz);
    calc_d(x2,y2,z2,x1,y1,z1,dir1,dirz);
    if abs(dir-dir1)<0.01 then  troncoselr:=tronco;
    end;
  end;
end;

if tronco=0 then  Linea(x1,y1,z1,x2,y2,z2,spes*4,Crosso)
else
  begin
  if (troncoselr1<>0)and(tronco=troncoselr1)
  then Linea(x1,y1,z1,x2,y2,z2,spes*4,Crosso)
  else Linea(x1,y1,z1,x2,y2,z2,spes,Color);
  end;
end;

Procedure Disrete(Nome:string; Cosa: char);
const maxsot=50;
{$I M_Daticad}
Var Buf:CadRec;
    FHT:File of CadRec;
    BufT:RecGTerm;
    FHTT:File of RecGTerm;
    spx, spy, zetabase: real;
    PianoAtt,Nome_piano: String;
    FO3d:file of DatiInt;
    buf_or:DatiInt;

begin
  PianoAtt := '';
  ZetaBase := 0;
  nome_piano:=extractfilename(nome);
  nome_piano:=uppercase(copy(nome_piano,1,length(nome_piano)-4));
  if nome_piano<>'' then
  case cosa of
    'U': begin
         assign(FO3d, I_sl(PercorsoDrive) + Nome_Piano + '.O3D');
         Reset(FO3d);
         read(fO3d,buf_or);
         with buf_or do
         Linea(Xorig-0.1,Yorig,Zorig,Xorig+0.1,Yorig,Zorig,0.2,cmetallo);
         close(FO3d);
          if (valid_lineasel_3d){and(lineasel_3d.piano=nome_piano)} then
            begin
            Linea(lineasel_3d.x1,lineasel_3d.y1,lineasel_3d.z1,lineasel_3d.x2,lineasel_3d.y2,lineasel_3d.Z2,0.05,crosso);
            end;
          assign(fht,Nome);
          reset(Fht);
          while not eof(FHT) do
          begin
            read(FHT,Buf);
            zetabase :=0; //Nuovo pjb
            if (buf.PianoCAD <> PianoAtt) and (buf.PianoCad <> '') then
            begin
              PianoAtt := buf.PianoCad;
              {if IndPiano1(PianoAtt) <> 0 then   //Nuovo pjb
                 zetabase := PianiD^[IndPiano1(PianoAtt)].Quota;}
             end;
            Linea_selez(buf.tronco,buf.x1,buf.y1,(buf.z1+ZetaBase),buf.x2,buf.y2,(buf.Z2+ZetaBase),0.03,cblu);
          end;
          close(fht);
         end;
    'T': begin
          assign(fhtt,Nome);
          reset(Fhtt);
          while not eof(FHTt) do
          begin
            read(FHTt,Buft);
            with buft do
            begin
              zetabase :=0; //Nuovo pjb
              if (buft.Piano <> PianoAtt) and (buft.Piano <> '') then
              begin
                PianoAtt := buft.Piano;
               { if IndPiano2(PianoAtt) <> 0 then    //Nuovo pjb
                   zetabase := PianiD^[IndPiano2(PianoAtt)].Quota;}
              end;
              //if UpperCase(TipoTerm) = UpperCase('Fancoil') then
              //   spx := (Larghezza/1000) / 2
              //else
              spx := (Larghezza) / 2;
              spy := 0;
              Modicord1(spx, spy, 0, 0, (Angolo+180)*pi/180, 1);
              if UpperCase(TipoTerm) = 'DIFFUSORE' then
                begin
                end
              else  
              //if UpperCase(TipoTerm) = UpperCase('Fancoil') then
              //   DisegnaTerminale(ZTerm + Zetabase +((Altezza/1000) / 2), XTerm + spx, Yterm - spy, Larghezza/1000, Profondita/1000, Altezza/1000, (Angolo + 90)*pi/180)
              //else
                 DisegnaTerminale(ZTerm + zetabase + (Altezza / 2), XTerm + spx, Yterm - spy, Larghezza, Profondita, Altezza, -(Angolo + 90)*pi/180,taratura<>'*');
            end;
          end;
          close(fhtt);
         end;
  end;
end;



Function spes(cod:string):real;
Var i,j:integer;
begin
result:=0;
if nstrutture=0 then exit;
i:=1;
cod:=uppercase(cod);
while (i<Nstrutture)and(uppercase(strutture_d^[i].NFile)<>cod) do inc(i);
if uppercase(strutture_d^[i].NFile)=cod then
for j:=1 to strutture_d^[i].Nstrati do
  begin
  result:=result+strutture_d^[i].Strati[j].Spessore/100;
  end;
end;

Function Filo(l1,l2:string):char;
begin
result:='C';
if l1='' then result:='S';
if l2='' then result:='D';
end;

Const IsAgg='AGGRE-';

Function Aggre(codbase,cod,descr:string):boolean;
begin
codBase:=uppercase(codBase);
cod:=uppercase(cod);
descr:=uppercase(descr);
result:=(cod=codbase);
if not result then
if length(descr)>length(Isagg) then
if copy(descr,1,length(Isagg))=isagg then
  begin
  Descr:=copy(Descr,length(isagg)+1,length(descr)-length(isagg));
  result:=codbase=Descr;
  end;
end;
Function Is_aggre(descr:string):boolean;
begin
descr:=uppercase(descr);
result:=false;
if length(descr)>length(Isagg) then
if copy(descr,1,length(Isagg))=isagg then
result:=true;
end;

//Termografia
Function Colore_term(trasm:real):Tcolori3d;
begin
if trasm=0 then
  begin
  result:=cparete;
  exit;
  end;
if trasm>kmaxtrasm then
kmaxtrasm:=trasm;
if trasm<kmintrasm then
kmintrasm:=trasm;
//if trasm >0.5 then result:=termo10
//else result:=termo1;
if trasm < strtofloat(form1.Label399.Caption) then result:=termo1
else
if trasm < strtofloat(form1.Label400.Caption) then result:=termo2
else
if trasm < strtofloat(form1.Label401.Caption) then result:=termo3
else
if trasm < strtofloat(form1.Label402.Caption) then result:=termo4
else
if trasm < strtofloat(form1.Label403.Caption) then result:=termo5
else
if trasm < strtofloat(form1.Label404.Caption) then result:=termo6
else
if trasm < strtofloat(form1.Label405.Caption) then result:=termo7
else
if trasm < strtofloat(form1.Label406.Caption) then result:=termo8
else
if trasm < strtofloat(form1.Label407.Caption) then result:=termo9
else
if trasm < strtofloat(form1.Label408.Caption) then result:=termo10
else result:=termo11;
end;

Procedure DisegnaFinestra(luc:boolean;pianocor,codice:string;Item,Itemp, Ind_Piano,Ind_amb:integer;X0,Y0,x1,y1:real;count,nfin:integer);
Var i,j:integer;
    lsetto,hsetto,telsetto,psetto,zsetto,spsetto,xa,ya,za,xb,yb,zb,xc,yc,ang_fin:real;
    tiposetto:string;
    dir,dirz, ZbasePiano, largf, altf,xxt,yyt,inclinaz,ttr:real;
const sottofin=0;

function POsfin:boolean;
type TIntFin=record
               item,itempar:integer;
               xf,yf, larg, alt,angolo:real;
              end;
var Buffin:TInTfin;
    fIntfin:file of tintfin;
    i,ff:integer;
begin
if nfin<>0 then  //pareti finestrate
  begin
  result:=true;
  xc:=x0+((x1-x0)/nfin)/2+((x1-x0)/nfin)*(count-1);
  yc:=y0+((y1-y0)/nfin)/2+((y1-y0)/nfin)*(count-1);
  calc_d(x0,y0,0,x1,y1,0,ang_fin,dirz);
  for ff:=1 to Nfinestre do
  if uppercase(finestre_d^[ff].Codice)=uppercase(codice) then break;
  largf :=finestre_d^[ff].Larghezza;
  altf := finestre_d^[ff].Altezza;
  end
else
  begin
  result:=false;
  assign(fIntFin,copy(pianocor,1,length(pianocor)-4)+'.fin');
  reset(fIntfin);
  buffin.item:=0;
  buffin.itemPar:=0;
  while (not eof(fIntfin))and((buffin.item<>-item)or(buffin.itempar<>itemp)) do
  read(fintfin,buffin);
  if (buffin.item=-item)and(buffin.itempar=itemp) then
    begin
    result:=true;
    xc:=buffin.xf;
    yc:=buffin.yf;
    ang_fin:=buffin.angolo*PI/180;
    largf := buffin.larg;
    altf := buffin.Alt;
    end;
  close(fIntfin);
  end;
end;

Procedure add_buco(xb,yb,zb,lb,hb:real);
begin
if buchi then addbuco(xb,yb,zb,lb,hb)
//else UOggetti.Parallelepi(zb,xb,yb, 0, lb, 0.3, hb,cvetro);
end;

Procedure disegnasetto(tipo:string);
var
  ZSetto1,zzc: Real;
  cols:tcolori3d;
  opaco:boolean;
  spsetto1:real;

Procedure Inclina;
Var tt:real;
begin
//inclinaz:=0;
tt:=za;
za:=zzc+(za-zzc)*cos(inclinaz);
ya:=ya-(tt-zzc)*sin(inclinaz);
tt:=zb;
zb:=zzc+(zb-zzc)*cos(inclinaz);
yb:=yb-(tt-zzc)*sin(inclinaz);
end;
begin
spsetto1:=spsetto;
if spsetto1<0.025 then spsetto1:=0.025;
opaco:=((uppercase(tipo)<>'FINESTRA')and(uppercase(tipo)<>'SOPRAL'));
ZSetto1 := ZSetto + ZBasePiano;
if (form1.CBVetri.Checked)or ((opaco)and(not form1.rbscheletro.checked)) then
  begin
  xa:=Psetto;Ya:=0;
  modicord1(xa,ya,xc,yc,dir-pi/2,1);
  xb:=Psetto+lsetto;Yb:=0;
  modicord1(xb,yb,xc,yc,dir-pi/2,1);
  //linea(xa,ya,zsetto1,xb,yb,zsetto1-hsetto,spsetto,crosso);
  nBuchi:=0;

  //Termografia
  if form1.Panel_base.ActivePageIndex=7 then
    begin
    if uppercase(tipo)='PARETE' then Colore_term(finestre_d^[i].kSottoFin)
    else cols:=Colore_term(finestre_d^[i].Trasmittanza);
    end
  else
  if opaco then cols:=clegno else cols:=cvetro;


  ParallelepiIncl(inclinaz,zsetto1-hsetto/2, (xa+xb)/2, (ya+yb)/2, dir-pi, lsetto, spsetto1, hsetto, cols);
  //Parete(ZSetto1-hsetto,0,0,xa,ya,xb,yb,spsetto,HSetto,'C',HSetto,HSetto,Cvetro);
  //colorecor_3d:=cvetro;
  //Paretesemp(ZSetto1-hsetto/2,xa,ya,xb,yb,spsetto,HSetto,'C','');
  //Paretesemp(Q,x1,y1,x2,y2,spes,alt,'C',0);
  end;

if (not opaco)or(finestre_d^[i].altezzafin=0) then
begin
  //orizzontali
  zzc:=zsetto1-hsetto/2;
  xa:=Psetto;Ya:=0;za:=zsetto1;
  xb:=Psetto+lsetto;Yb:=0;zb:=zsetto1;
  Inclina;
  modicord1(xa,ya,xc,yc,dir-pi/2,1);
  modicord1(xb,yb,xc,yc,dir-pi/2,1);
  Linea(xa,ya,za,xb,yb,za,spsetto1,Crosso);

  xa:=Psetto{,+lsetto};Ya:=0;za:=zsetto1-hsetto;
  xb:=Psetto+lsetto;Yb:=0;zb:=zsetto1-hsetto;
  Inclina;
  modicord1(xa,ya,xc,yc,dir-pi/2,1);
  modicord1(xb,yb,xc,yc,dir-pi/2,1);
  Linea(xa,ya,za,xb,yb,zb,spsetto1,Crosso);

  //Verticali
  inclinaz:=-inclinaz; //Da chiarire
  xa:=Psetto+lsetto;Ya:=0;za:=zsetto1;
  xb:=Psetto+lsetto;Yb:=0;zb:=zsetto1-hsetto;
  Inclina;
  modicord1(xa,ya,xc,yc,dir-pi/2,1);
  modicord1(xb,yb,xc,yc,dir-pi/2,1);
  Linea(xa,ya,za,xb,yb,zb,spsetto1,Crosso);


  xa:=Psetto;Ya:=0;za:=zsetto1-hsetto;
  xb:=Psetto;Yb:=0;zb:=zsetto1;
  Inclina;
  modicord1(xa,ya,xc,yc,dir-pi/2,1);
  modicord1(xb,yb,xc,yc,dir-pi/2,1);
  Linea(xa,ya,za,xb,yb,zb,spsetto1,Crosso);

  inclinaz:=-inclinaz; //Da chiarire
  
end;
end;

begin
inclinaz:=0;
i:=1;
codice:=uppercase(codice);
colorecor_3d:=Crosso;
xc:=0;
Yc:=0;
if not posfin then exit;
ZBasePiano := 0;
if ind_Piano <> 0 then
   ZBasePiano := PianiD^[ind_Piano].Quota;
if (ind_Amb <> 0)and(not luc) then
   ZBasePiano :=ZBasePiano+ambienti_d^[ind_Amb]^.Quotapav;

while (i<NFinestre)and(codice<>uppercase(finestre_d^[i].Codice)) do inc(i);
if codice=uppercase(finestre_d^[i].Codice) then
with finestre_d^[i] do
//if Uppercase(finpor)='PORTA' then
  begin
  calc_d(x0,y0,0,x1,y1,0,dir,dirz);
  zsetto := 0;
  //disattivato perche inserito in finestre if uppercase(tiposottofin)='NESSUNO' then Zsetto:=AltSottoFin;
  //lucernai
  if luc then
    begin
    Zsetto:=AltSottoFin;
    yyt:=Zsetto+AltezzaFin/2;
    xxt:=0;
    modicord1(xxt,yyt,xc,yc,ang_fin,1);
    calc_d(xc,yc,z_falda(xc,yc,ind_amb),xxt,yyt,z_falda(xxt,yyt,ind_amb),ttr,inclinaz);
    inclinaz:=Pi/2-Inclinaz+pi;
    //inclinaz:=form1.TrackBar6.Position*Pi/2/10;
    //inclinaz:=pi/2;
    xc:=xxt;
    yc:=yyt;
    Zsetto:=z_falda(xc,yc,ind_amb);
    end;
  if (largf <> 0) and (altf <> 0) then
  begin
    psetto:=-largf/2;
    //zsetto:=altezzafin+sottofin;
    //zsetto:=altezzafin+altsottofin;
    lsetto:=largf;
    Hsetto:=altf;
    Spsetto:=TelaioFin;
   // Tiposetto:=setti[j].Tipo;
    if (TipoSottoFin = '')or(uppercase(finpor)='PORTA') then AltSottofin := 0;
    zsetto := zsetto + Hsetto + AltSottoFin;
    disegnasetto(finpor);
  end
  else
  begin
  LargF := LarghezzaFin;
  for j:= Nsetti downto 1 do
  begin
    psetto:=-larghezzafin/2;
    //zsetto:=altezzafin+sottofin;
    //zsetto:=altezzafin+altsottofin;
    lsetto:=setti[j].Larghezza;
    Hsetto:=setti[j].altezza;
    Spsetto:=setti[j].LTelaio;
    Tiposetto:=setti[j].Tipo;
    if  luc then//lucernai
    zsetto := zsetto + Hsetto/2
    else zsetto := zsetto + Hsetto;
    if tiposetto<>'' then
      begin
      disegnasetto(Tiposetto);
      Psetto:=psetto+lsetto;
      lsetto:=setti[j].Larghezza2;
      Hsetto:=setti[j].altezza2;
      Spsetto:=setti[j].LTelaio2;
      Tiposetto:=setti[j].Tipo2;
      if tiposetto<>'' then
        begin
        disegnasetto(Tiposetto);
        Psetto:=psetto+lsetto;
        lsetto:=setti[j].Larghezza3;
        Hsetto:=setti[j].altezza3;
        Spsetto:=setti[j].LTelaio3;
        Tiposetto:=setti[j].Tipo3;
        if tiposetto<>'' then
          begin
          disegnasetto(Tiposetto);
          Psetto:=psetto+lsetto;
          lsetto:=setti[j].Larghezza4;
          Hsetto:=setti[j].altezza4;
          Spsetto:=setti[j].LTelaio4;
          Tiposetto:=setti[j].Tipo4;
          if tiposetto<>'' then
            begin
            disegnasetto(Tiposetto);
            Psetto:=psetto+lsetto;
            lsetto:=setti[j].Larghezza5;
            Hsetto:=setti[j].altezza5;
            Spsetto:=setti[j].LTelaio5;
            Tiposetto:=setti[j].Tipo5;
            if tiposetto<>'' then
              begin
              disegnasetto(Tiposetto);
              end;
            end;
          end;

        end;
      end;
    end;
    end;
    if UpperCase(TipoSottoFin) = '' then
       AltSottofin := 0;
 //addbuco(xc,yc,sottofin+altezzafin/2,Larghezzafin,altezzafin);
  // if not(form1.CBVetri.Checked) then
   add_buco(xc,yc,(zsetto-altsottofin)/2 + altsottofin,Largf,zsetto-altsottofin);
  end;
end;
function colorepar(codamb,cod,lato,conf,descr:string;NPiano,NumAmb,NumPar:integer):Tcolori3d;
Var i:integer;
begin
if ((form1.cbschelpiani.checked)and(form1.cbPiano.text<>'')and(form1.cbPiano.text<>PianiD^[NPiano].Cod))or
   ((form1.cbfiltroloc.checked)and(form1.edit12.text<>'')and(form1.edit12.text<>codamb))
then  result:=cschel
else
  begin
  if (sa<>'')and(not(aggre(sa,codamb,descr))) then
  result:=cschel
  else
    begin
    if form1.Panel_base.ActivePageIndex=7 then
      try  //In alcuni casi da errore (access violation)
      begin
      if numamb<>0 then
        begin
        for i:=1 to nstrutture do
        if uppercase(strutture_D^[i]^.NFile)=uppercase(ambienti_D^[NumAmb]^.par[numpar].Cod) then break;
        result:=Colore_term(strutture_D^[i]^.Trasmitt);
        end
      else
      result:=cblu;
      end
      except
      result:=cblu;
      end  //try
    else
      begin
      if lato[1]='L' then result:=crosso
      else result:=cParete;
      end;
    end;
  end;
end;

function alt_sof(inda:integer):real;
begin
result:=ambienti_d^[inda]^.HSoffitto;
if result=0 then result:=3;
end;

Procedure DisPiano(Nome:string;Modo, NumPiano:integer);
Type
FRONTHT = Record
                Item    :integer;
                Colore  :Tcolor;
                NZon    :integer;
                NAmb    :string[10];
                NAmb2    :string[10];
                x0      : real;
                y0      : real;
                x1      : real;
                y1      : real;
           end;
type Tfht= File of FrontHt;
Var Buf:FrontHt;
    FHT:Tfht;
    i,j,k,l,m,err{, NumPiano},ind_e:integer;
    trov,trpav,trsol:boolean;
    Na1,na2,ox,oy,fing,incf, QuotaPiano,Quota_piano,HPiano,dirpav,upa,upb:Real;
    NomePiano: String;
 (*
Procedure read_fht(var bb:frontht);
begin
read(fht,bb);
{bb.x0:=bb.x0+piani_d^[numpiano].AllineaX;
bb.y0:=bb.y0+piani_d^[numpiano].AllineaY;
bb.x1:=bb.x1+piani_d^[numpiano].AllineaX;
bb.y1:=bb.y1+piani_d^[numpiano].AllineaY;}
end;
*)
begin

//NumPiano := IndPiano(NomeFile);
if NumPiano <> 0 then
 with PianiD^[NumPiano] do
  begin
   Quota_Piano :=Quota;
   HPiano := AltL;
   NomePiano := UpperCase(Cod);
  end;

if Nambienti=0 then exit;

if FileExists(Nome) then
begin
  assign(fht,Nome);
  reset(Fht);
  case  modo of
  0:Begin
    //Calcolo dei parametri tridimensionali
    while not eof(FHT) do
      begin
      read(FHT,Buf);
      with buf do
        begin
        for i:=1 to NAmbienti do
        if UpperCase(ambienti_d^[i]^.Piano) = NomePiano then
        for j:= 1 to ambienti_d^[i]^.NPar do
        if (ambienti_d^[i]^.Par[j].Item=Item)and(ambienti_d^[i]^.Par[j].Lato<>'-') then
        MaxZ(x0,y0,x1,y1,i);
        end;
      end;
    end;
  1:begin
      while not eof(FHT) do
      begin
      read(FHT,Buf);
      with buf do
      if Namb<>Namb2 then //limina le pareti fittizie che uniscono i  locali flottanti
      try
        begin
        for i:=1 to NAmbienti do
        if UpperCase(ambienti_d^[i]^.Piano) = NomePiano then
          begin
          quotapiano:=quota_piano+ambienti_d^[i]^.quotapav;
          upa:=0;Upb:=0;
          for j:= 1 to ambienti_d^[i]^.NPar do
          if (ambienti_d^[i]^.codnum=namb)and(ambienti_d^[i]^.Par[j].Item=Item)and(ambienti_d^[i]^.Par[j].Lato<>'-') then
            begin
            with ambienti_d^[i]^.Par[j] do
              begin
              //if ((alt>alt2)and(Z_Falda(x0,y0,i)>Z_Falda(x1,y1,i)))or
              //   ((alt<alt2)and(Z_Falda(x0,y0,i)<Z_Falda(x1,y1,i)))then
              //Parete(QuotaPiano,x0,y0,x1,y1,spes(Cod),3,Filo(Namb,NAmb2),alt2,alt,colorePar(ambienti_d^[i]^.codnum,cod,lato,confine))
              //else
              AzzeraBuchi;

              k:=j+1;
              while (k<=ambienti_d^[i]^.NPar)and(ambienti_d^[i]^.Par[k].lato='-') do
                begin
                if uppercase(ambienti_d^[i]^.Par[k].Tipo)='FINESTRA' then
                  begin
                  if ambienti_d^[i]^.Par[k].Item=0 then  //pareti finestrate
                    begin
                    for m:=1 to trunc(ambienti_d^[i]^.Par[k].num) do
                    disegnafinestra(false,nome,ambienti_d^[i]^.Par[k].Cod,ambienti_d^[i]^.Par[k].Item,buf.item,NumPiano,i,Buf.x0,Buf.y0,Buf.x1,Buf.y1,m, trunc(ambienti_d^[i]^.Par[k].num));
                    end
                  else
                  disegnafinestra(false,nome,ambienti_d^[i]^.Par[k].Cod,ambienti_d^[i]^.Par[k].Item,buf.item,NumPiano,i,Buf.x0,Buf.y0,Buf.x1,Buf.y1,0,0);
                  end;
                inc(k);
                end;
              //disegnafinestra('Fin3Ant6',item,x0,y0,x1,y1);
              Parete(QuotaPiano,upa,upb,Buf.x0,Buf.y0,Buf.x1,Buf.y1,spes(Cod),3,Filo(Namb,NAmb2),alt,alt2,
                     Parete_selez(buf.Item,buf.x0,Buf.y0,0,Buf.x1,Buf.y1,0,colorePar(ambienti_d^[i]^.codnum,cod,lato,confine,ambienti_d^[i]^.Denom,NumPiano,i,j),NomePiano)
                     );
              upa:=upa+alt;
              upb:=upb+alt2;
              end;
            end
          else
          //Lucernai
            begin
            if (ambienti_d^[i]^.codnum=namb)and(ambienti_d^[i]^.Par[j].Item=0)and(ambienti_d^[i]^.Par[j].Lato<>'-') then
              begin
              k:=j+1;
              while (k<=ambienti_d^[i]^.NPar)and(ambienti_d^[i]^.Par[k].lato='-') do
                begin
                if uppercase(ambienti_d^[i]^.Par[k].Tipo)='FINESTRA' then
                disegnafinestra(true,nome,ambienti_d^[i]^.Par[k].Cod,ambienti_d^[i]^.Par[k].Item,buf.item,NumPiano,i,x0,y0,x1,y1,0,0);
                inc(k);
                end;
              end ;
            end;
          //endlucernai
          end;
        end;
        except
        //showmessage('Errore');
        end;
      end;
    end;
  2:begin //pareti
    for i:=1 to NAmbienti do
    if UpperCase(ambienti_d^[i]^.Piano) = NomePiano then
      begin
      quotapiano:=quota_piano+ambienti_d^[i]^.quotapav;
      Nprof:=0;
      reset(Fht);
      while not eof(FHT) do
        begin
        read(FHT,Buf);
        with buf do
          begin
          if (Namb=ambienti_d^[i]^.CodNum) then
            begin
            inc(nprof);
            prof[NProf].x2:=x0;
            prof[NProf].y2:=y0;
            prof[NProf].x1:=x1;
            prof[NProf].y1:=y1;
            //prof[NProf].:=;
            end;
          end;
        end;
      if NProf<>0 then
        begin
        dirpav:=0;
        if indesp_amb(i)<>0 then dirpav:=-confine_d^[indesp_amb(i)].Orient*pi/180;
        modiprof(dirpav,1);
        trpav:=false;
        trsol:=false;
        for j:= 1 to ambienti_d^[i]^.NPar do
        with ambienti_d^[i]^.Par[j] do
          begin
          if (lato='OR')then
            begin
            ind_e:=Indesp(confine);
 //          if Indesp(confine) <> 0 then
 //           begin
              //if confine_d^[indesp(confine)].Inclin=180 then
              if (Uppercase(confine)<>'ESTERNO')and(Indesp(confine) =0) then
                begin
                if not(trpav) then
                  begin
                  Pavimento(0,QuotaPIano,colorePar(ambienti_d^[i]^.codnum,cod,'L',confine,ambienti_d^[i]^.Denom,NumPiano,i,j),0,0,1,0,dirpav);
                  trpav:=true;
                  end
                else
                  begin
                  Pavimento(0,QuotaPIano+ambienti_d^[i]^.hsoffitto,colorePar(ambienti_d^[i]^.codnum,cod,'L',confine,ambienti_d^[i]^.Denom,NumPiano,i,j),0,0,1,0,dirpav);
                  trsol:=true;

                  end
                end
              else
                begin
                if (Uppercase(confine)<>'ESTERNO')and(confine_d^[indesp(confine)].Inclin>0)and(confine_d^[indesp(confine)].Inclin<90) then
                  begin
                  if form1.CBHmedia.Checked then
                  Pavimento(0,ambienti_d^[i]^.hsoffitto+quotapiano,colorePar(ambienti_d^[i]^.codnum,cod,lato,confine,ambienti_d^[i]^.Denom,NumPiano,i,j),0,0,1,0,dirpav)
                  else Pavimento(0,-zz_max(i)+quotapiano-ambienti_d^[i]^.Quotapav,colorePar(ambienti_d^[i]^.codnum,cod,lato,confine,ambienti_d^[i]^.Denom,NumPiano,i,j),0,0,1,confine_d^[indesp(confine)].Inclin,dirpav);
                  trsol:=true;
                  end
                else
                  begin
                  if (trpav) then
                    begin
                    Pavimento(0,QuotaPIano+ambienti_d^[i]^.hsoffitto,colorePar(ambienti_d^[i]^.codnum,cod,lato,confine,ambienti_d^[i]^.Denom,NumPiano,i,j),0,0,1,0,dirpav);
                    trsol:=true;
                    end
                  else
                    begin
                    Pavimento(0,QuotaPIano,colorePar(ambienti_d^[i]^.codnum,cod,lato,confine,ambienti_d^[i]^.Denom,NumPiano,i,j),0,0,1,0,dirpav);
                    trpav:=true;
                    end;
                  end;
                end;
//              end;
            end;
        (*
        if i=1 then Pavimento(0,-1.5,'',ox,oy,fing,incf)
        else Pavimento(0,-1.5,'',ox,oy,fing,incf);
        *)
          end;
        if not trpav then
        Pavimento(0,QuotaPIano,colorePar(ambienti_d^[i]^.codnum,'','L','',ambienti_d^[i]^.Denom,NumPiano,0,0),0,0,1,0,dirpav);
        if not trsol then
        Pavimento(0,QuotaPIano+alt_sof(i),colorePar(ambienti_d^[i]^.codnum,'','L','',ambienti_d^[i]^.Denom,NumPiano,0,0),0,0,1,0,dirpav);

        end;
      end;
    end;
  end;
  close(fht);
 end; {End FileExists}
end;
Procedure DisegnaPannelli;
//scrittura file per il 3D
// promemoria x diego incluso anche in spirali
Type Ttubo3d=record
             xx1p,yy1p,zz1p,xx2p,yy2p,zz2p:real;
             pianolN:string[35];
             end;
var  FTubo3d:file of TTubo3d;
     Buftubo3d:TTubo3d;
     Zeta_base:real;
//scrittura file 3D
ultimo_piano:string;
i:integer;
begin
ultimo_piano:='';
zeta_base:=0;

 if Form1.CBSpirali.Checked then
  begin
     perc:=percorso+'\*.PNN';

     Trovato := FindFirst(perc,faarchive,sr);
     while Trovato = 0 do
        begin
             NomeFile := percorso + '\' + sr.Name;
             assign(ftubo3d,nomefile);
             reset(ftubo3d);
             while not eof(ftubo3d) do
               begin
               read(ftubo3d,BufTubo3d);
               with BufTubo3d do
                 begin
                 if ultimo_piano<>uppercase(pianoLN) then
                   begin
                   zeta_base:=0;
                   ultimo_piano:=uppercase(pianoLN);
                   for i:=1 to npiani do
                   if uppercase(piani_d^[i].Cod)<>ultimo_piano then
                   zeta_base:=zeta_base+piani_d^[i].AltL
                   else break;
                   end;
                 Linea(xx1p,yy1p,(zz1p+Zeta_Base),xx2p,yy2p,(Zz2p+Zeta_Base),0.03,cblu);
                 end;
               end;
             close(ftubo3d);
             Trovato := FindNext(sr);
        end;
  end;
end ;

Var i, k, j:integer;
    ZCorr: real;

 begin
 kminTrasm:=9999;
 kmaxtrasm:=0;


 if not(fileexists(IncludeTrailingPathDelimiter(Percorsodrive) + 'PathProg.txt')) then exit ;
 with form1 do
   begin
   //height:=768;
   //width:=1024;
   GBVarie.Visible:=false;
   end;

 if Canali then Form1.tscanali.TabVisible:=true
 else  Form1.tscanali.TabVisible:=false;
 form1.cbvetri.visible:=false;
 form1.cbvetri.checked:=true;
 initUdb(percorso_progetti);
 tabt:=false;
 Leggi_Locali(dm1.tt1,dm1.tt3,dm1.DataSource1);
 // Leggi_frontiere(dm1.tt1,dm1.tt3);
 Leggi_strutture(dm1.tt1,dm1.tt3,dm1.DataSource1);
 Leggi_confine(dm1.tt1,dm1.tt3,dm1.DataSource1);
 Leggi_piani(dm1.tt1,dm1.tt3,dm1.DataSource1);
 Leggi_Update(dm1.tt1,dm1.tt3,dm1.DataSource1);
  i := 1;
 NPiani1 := 0;
 while (i <= NPiani) do
 begin
  if Piani_D^[i].Piani_Uguali = 0 then Piani_D^[i].Piani_Uguali := 1;
  for j := 1 to Piani_D^[i].Piani_Uguali do
  begin
   inc(NPiani1);
   PianiD^[NPiani1] := Piani_D^[i];
  end;
  inc(i);
 end;
 ZCorr := 0;
 if form1.cbPiano.text='' then
 form1.cbPiano.Items.clear;
 for i := 1 to NPiani1 do
   with PianiD^[i] do
   begin
     if (form1.cbPiano.text='')and((i=1)or(PianiD^[i].Cod<>PianiD^[i-1].Cod))
     then form1.cbPiano.Items.add(PianiD^[i].Cod);
     Quota := ZCorr;
     ZCorr := ZCorr + AltL;
   end;
 Leggi_Finestre(dm1.tt1,dm1.tt3,dm1.DataSource1);
 initconfini;
 sa:=form1.cblocale.text;
 if ac then
   begin
   form1.cblocale.Items.Clear;
   for k:=1 to Nambienti do
   if not is_aggre(ambienti_d^[k].denom) then
   form1.cblocale.Items.add(ambienti_d^[k].CodNum);
   form1.cblocale.text:=sa;
   end;
    { perc:=percorso+'\*.int';

     Trovato := FindFirst(perc,faarchive,sr);
     while Trovato = 0 do
        begin
             NomeFile := percorso + '\' + sr.Name;
             DisPiano(NomeFile,1);
             Trovato := FindNext(sr);
        end;  }

if (form1.Panel_base.ActivePageIndex<>8)and(form1.Panel_base.ActivePageIndex<>6) then
  begin
     //Calcola parametri tridimesionali
     for i := 1 to NPiani1 do
     if (form1.cbPiano.text='')or(form1.cbschelpiani.checked)or(form1.cbPiano.text=PianiD^[i].Cod) then
     begin
        NomeFile := percorso + '\' + PianiD^[i].Cod + '.int';
        DisPiano(NomeFile,0, i);
     end;
    setZMax;

    //Disegna finestre
    for i := 1 to NPiani1 do
     if (form1.cbPiano.text='')or(form1.cbschelpiani.checked)or(form1.cbPiano.text=PianiD^[i].Cod) then
     begin
        NomeFile := percorso + '\' + PianiD^[i].Cod + '.int';
        DisPiano(NomeFile,1, i);
     end;

  {   Trovato := FindFirst(perc,faarchive,sr);
     while Trovato = 0 do
        begin
             NomeFile := percorso + '\' + sr.Name;
             DisPiano(NomeFile,2);
             Trovato := FindNext(sr);
        end;        }
     //Disegna pareti
     for i := 1 to NPiani1 do
     if (form1.cbPiano.text='')or(form1.cbschelpiani.checked)or(form1.cbPiano.text=PianiD^[i].Cod) then
     begin
        NomeFile := percorso + '\' + PianiD^[i].Cod + '.int';
        Progress_3d(round((i-1)/Npiani1*100),'Aggiornamento disegno 3D');
        DisPiano(NomeFile,2, i);
     end;
  end;
  if (Form1.CB_Reti.Checked)and(not anteprima_reti) then
  begin
     Disegnapannelli;
     perc:=percorso+'\*.U3D';

     Trovato := FindFirst(perc,faarchive,sr);
     while Trovato = 0 do
        begin
             NomeFile := percorso + '\' + sr.Name;
             DisRete(NomeFile, 'U');
             Trovato := FindNext(sr);
        end;

     perc:=percorso+'\*.T3D';

     Trovato := FindFirst(perc,faarchive,sr);
     while Trovato = 0 do
        begin
             NomeFile := percorso + '\' + sr.Name;
             DisRete(NomeFile, 'T');
             Trovato := FindNext(sr);
        end;

    perc:=percorso+'\*.3DM';

     Trovato := FindFirst(perc,faarchive,sr);
     while Trovato = 0 do
        begin
             NomeFile := percorso + '\' + sr.Name;
             if canali then Disegnacanali(NomeFile,cMetallo);
             Trovato := FindNext(sr);
        end;
  end;
 disposeUdb;
 tabt:=true;
 end;
Procedure Proprieta_PJB(pc,rc,irc,tipo:string;xogg,yogg,zogg,x1ogg,y1ogg,z1ogg:real);
Var i,j,riga,rigaloc:integer;
begin
if irc='EDIFICIO' then
  begin
  form1.panel_base.Visible:=true;
  piano_selez:=uppercase(PC);
  leggi_mem_locali;
  if tipo='L' then
    begin
    item_selez:=0;
    Modosel_edificio:=true;
    x1selr:=xogg;
    y1selr:=yogg;
    z1selr:=0;
    x2selr:=x1ogg;
    y2selr:=y1ogg;
    z2selr:=0;

    form1.display(false);
    //Linea(x1selr,y1selr,z1selr,x2selr,y2selr,z2selr,0.4,Crosso);
    Modosel_edificio:=false;
    riga:=1;
    if item_selez<>0 then
    for i:=1 to nambienti do
    for j:=1 to ambienti_d^[i].NPar do
    with ambienti_d^[i]^.Par[j] do
    if (item=item_selez)and(piano_selez=uppercase(ambienti_d^[i].Piano)) then
      begin
      form1.panel_base.ActivePageIndex:=9;
      with form1.SG_Pareti do
        begin
        //form1.gb_pareti_1.caption:='Locale:'+ambienti_d^[i]^.CodNum;
        cells[0,0]:='Locale';
        cells[1,0]:='Confine';
        cells[2,0]:='Lato';
        cells[3,0]:='Lung.';
        cells[4,0]:='H1';
        cells[5,0]:='H2';
        cells[6,0]:='Sup.';
        cells[7,0]:='Cod.';
        cells[8,0]:='item';
        rigaloc:=1;
          repeat
          rowcount:=riga+1;
          cells[0,riga]:=ambienti_d^[i]^.CodNum;
          cells[1,riga]:=ambienti_d^[i]^.Par[j+rigaLoc-1].Confine;
          cells[2,riga]:=ambienti_d^[i]^.Par[j+rigaLoc-1].Lato;
          if ambienti_d^[i]^.Par[j+rigaLoc-1].Lato='-' then cells[2,rigaLoc]:=ambienti_d^[i]^.Par[j+rigaLoc-1].tipo;
          cells[3,riga]:=float_to_str(ambienti_d^[i]^.Par[j+rigaLoc-1].Num,3);
          cells[4,riga]:=float_to_str(ambienti_d^[i]^.Par[j+rigaLoc-1].alt,3);
          cells[5,riga]:=float_to_str(ambienti_d^[i]^.Par[j+rigaLoc-1].alt2,3);
          cells[6,riga]:=float_to_str(ambienti_d^[i]^.Par[j+rigaLoc-1].sup,3);
          cells[7,riga]:=ambienti_d^[i]^.Par[j+rigaloc-1].Cod;
          cells[8,riga]:=inttostr(ambienti_d^[i]^.Par[j+rigaLoc-1].item);
          inc(riga);
          inc(rigaloc);
          until ambienti_d^[i]^.Par[j+rigaLoc-1].Lato<>'-';
        end;

      {
      form1.P_item_1.Text:=inttostr(Item);
      form1.P_H1_1.Text:=float_to_str(alt,2);
      form1.P_H2_1.Text:=float_to_str(alt2,2);
      }
      end;
    item_selez:=0;
    end;

    if tipo='B' then
      begin
      for i:=1 to nambienti do
      with ambienti_D^[i]^ do
      if (piano_selez=piano)and(vicino(xogg,yogg,0,x1,y1,0)) then
      showmessage('trovato');
      end;

  end
else
  begin
  if not fileexists(I_sl(percorsodrive)+rc+'.U3d') then
    begin
    showmessage('Non è possibile visualizzare le proprietà della rete, i calcoli non sono aggiornati !');
    exit;
    end;
  form1.panel_base.Visible:=true;
  Modosel_reti:=true;
  lineaselr:=tipo='L';
  x1selr:=xogg;
  y1selr:=yogg;
  z1selr:=zogg;
  x2selr:=x1ogg;
  y2selr:=y1ogg;
  z2selr:=z1ogg;
  Caricadistubi_1(rc,pc,true);
  form1.panel_base.ActivePageIndex:=6;
  form1.display(false);
  if troncoselr<>0 then
    begin
    troncoselr1:=troncoselr;
    with dati^[troncoselr1]^ do
      begin
      form1.Edit1.Text:=float_to_str(lungh,1);
      form1.Edit5.Text:=float_to_str(porteff,3);
      form1.Edit4.Text:=Coddiam;
      form1.Ed_velocita.Text:=float_to_str(Velocita,2);
      form1.Ed_Tipotubo.Text:=Tipo;
      form1.Ed_pcar.Text:=float_to_str(pd,2);
      form1.Edit8.Text:=float_to_str(pl,2);

      form1.MPerdite.Clear;
      for i:=1 to npconc do
        begin
        form1.MPerdite.Lines.Add(inttostr(pconc[i].N)+' : '+pconc[i].Cod)
        end;
      end;
    if dati^[troncoselr1]^.Term<>0 then
    with Gterm^[dati^[troncoselr1]^.Term]^ do
      begin
      form1.Edit2.Text:=float_to_str(port,3);
      form1.Edit3.Text:=float_to_str(perd,3);
      form1.Edit6.Text:=float_to_str(pot,0);
      form1.Edit7.Text:=float_to_str(sbil,3);
      end
    else
      begin
      form1.Edit2.Text:='';
      form1.Edit3.Text:='';
      form1.Edit6.Text:='';
      form1.Edit7.Text:='';
      end;
    form1.display(false);
    end;
  Modosel_reti:=false;
  Troncoselr:=0;
  Troncoselr1:=0;
  end;
end;
Procedure AnteprimaReti;
var i:integer;
begin
if not form1.Visible then exit;
anteprima_reti:=true;
form1.panel_base.ActivePageIndex:=0;
form1.rbscheletro.checked:=true;
form1.display(false);
for i:=1 to ultriga_i do
anteprima_reti:=false;
end;

end.
