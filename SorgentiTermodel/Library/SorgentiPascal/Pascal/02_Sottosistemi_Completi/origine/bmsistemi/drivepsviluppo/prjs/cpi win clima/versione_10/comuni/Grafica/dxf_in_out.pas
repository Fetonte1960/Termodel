unit Dxf_in_out;

interface
uses sysutils,libreriagenerale,dialogs,
//{$Ifdef Tubi}
Definiz,angoli,
//{$else}
Varcarichi;
//{$endif};
Procedure Input_dxf(nomedxf:string;init:boolean);
Procedure output_dxf(nomedxf:string);
Procedure Add_LineaDxf(xl1,yl1,zl1,xl2,yl2,zl2:real;llayer,lcolore,ltlinea:string);
Procedure Add_ArcoDxf(xl1,yl1,zl1,raggio,angin,angfin:real;llayer,lcolore,ltlinea:string);
Procedure Add_CerchioDxf(xl1,yl1,zl1,raggio:real;llayer,lcolore,ltlinea:string);
Procedure Add_BloccoDxf(xl1,yl1,zl1,LAng:real;LNomebl,llayer:string);
Procedure Add_BloccoDxf_Col(xl1,yl1,zl1,LAng:real;LNomebl,llayer,LColore:string);
Procedure Add_BloccoDxf_Col_ing(xl1,yl1,zl1,LAng,lingX,lingY:real;LNomebl,llayer,LColore:string);
Procedure Add_AttribDxf(xl1,yl1,zl1:real;Nome,lValore:string);
Procedure Add_Attrib_Dxf(Nome,lValore:string);
Procedure Add_TestoDxf(xl1,yl1,zl1,LAng:real;Descr,llayer,LColore:string);

Procedure Leggi_POsa;
Procedure SalvaPOsa;
Procedure Aggiorna_Attributi;


Procedure InitSimbDXF;


Procedure InitEntita;
Var Piantaesterna:string='';
    scalaPiantaesterna:real=1;
    salva_rimandi_dxf:boolean=false;
    tutto_grigio:boolean=false;
    scrivi_int:boolean=false;
    entita_iniziale:integer=0;
implementation

//const maxus_h=200;
Var fi,fo,fat,frim:textfile;
    indgest:integer;
//    us_h:array[1..maxUsh]of string[8];
posattrib:array[1..300] of
    record
    valore,nomebl:string[20];
    coordX,coordY:real;
    Visibile:string[20];
    end;
NposA:Integer;
Rif_est:string='';

Procedure InitPOsA;
begin
NPosa:=0;
end;

Procedure Salva_POsa;
Var i:Integer;
begin
assign(fat,i_sl(Percorsodrive)+'posattrib.txt');
rewrite(Fat);
for i:=1 to Nposa do
writeln(fat,inttostr(i)+':',POsattrib[i].Nomebl+':'+Posattrib[i].valore+':'+float_to_str(POsattrib[i].coordX,8)+':'+float_to_str(POsattrib[i].coordY,8)+':'+POsattrib[i].visibile+':');
close(Fat);
end;
Procedure SalvaPOsa;
begin
Salva_POsa;
end;
Procedure InitSimbDXF;
begin
InitPOsa;
Input_dxf(Percorsodrive+'\definizione simboli.dxf',true);
salvaposa;
end;

Procedure Leggi_POsa;
var Buf:string;
begin
if not fileexists(Percorsodrive+'\posattrib.txt') then
  begin
  Nposa:=0;
  exit;
  end;
assign(fat,Percorsodrive+'\posattrib.txt');
reset(Fat);
Nposa:=0;
while not eof(fat) do
  begin inc(NPOsa);
  azzeraidentif;
  readln(fat,buf);
  POsattrib[Nposa].NomeBL:=leggiidentif1(buf);
  POsattrib[Nposa].valore:=leggiidentif1(buf);
  POsattrib[Nposa].coordX:=str_tofloat(leggiidentif1(buf));
  POsattrib[Nposa].coordY:=str_tofloat(leggiidentif1(buf));
  POsattrib[Nposa].visibile:=leggiidentif1(buf);
  end;
close(Fat);
end;
Procedure LeggiPOsa;
begin
end;
{*-*-*-*-*-*-*-*-*-*-*-*-*-*  Modicord1        *-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*}

{*-*-*-*-*-*-*-*-*-*-*-*-*-*  Modicord1        *-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*}

Procedure ModiCord1(var Cordx,Cordy:real;Dx,Dy,Rot,ing:real);
Var Dist,Ang:real;
begin
if CordY=0 then
  begin
  if Cordx>=0 then ang:=pi/2 else ang:=(3/2)*pi;
  end
else
  begin
  if Cordy>0 then
    begin
    ang:=arctan(Cordx/abs(Cordy));
    end
  else
  ang:=(pi-arctan(Cordx/abs(Cordy)));
  end;
if ang<0 then ang:=2*pi+ang;

Dist:=sqrt(sqr(Cordx)+sqr(Cordy))*ing;
Ang:=Ang+Rot;
CordX:=sin(ang)*Dist+Dx;
Cordy:=Cos(ang)*Dist+Dy;
end;

Procedure POs_a(Codbl,CodA:string;X,Y:real;visibile:string);
Var i:integer;
begin
//if visibile='' then
//showmessage('Visibile vuoto');
i:=1;
while (i<Nposa) and ((POsattrib[i].valore<>CodA)or(POsattrib[i].Nomebl<>Codbl)) do inc(i);
if (Nposa=0) or  (POsattrib[i].valore<>CodA)or (POsattrib[i].Nomebl<>Codbl)then
  begin
  inc(Nposa);
  POsattrib[Nposa].Nomebl:=CodBL;
  POsattrib[Nposa].valore:=Coda;
  POsattrib[Nposa].coordX:=X;
  POsattrib[Nposa].coordY:=Y;
  POsattrib[Nposa].visibile:=visibile;
  end;
end;
Procedure Set_POs_a(indcor:integer;Codbl,CodA,valA:string;ang:real;Var X,Y:real;Var visibile:string);
Var i:integer;
begin
//??? if (x<>0) or (y<>0) then exit;
i:=1;
while (i<Nposa) and ((POsattrib[i].valore<>CodA)or (POsattrib[i].Nomebl<>Codbl)) do inc(i);
if (Nposa<>0) and  (POsattrib[i].valore=CodA)and (POsattrib[i].Nomebl=Codbl)then
  begin
  X:=POsattrib[i].coordX;
  if coda[1]='&' then
    begin
    x:=x-0.15*Length(ValA)
    end;
  Y:=POsattrib[i].coordY;
  visibile:=POsattrib[i].visibile;
  Modicord1(X,Y,entita_D^[indcor]^.X1,entita_D^[indcor]^.Y1,-ang*PI/180,1);
  if visibile='' then
  showmessage('invisile vuoto');
  //X:=entita_D^[indcor]^.X1+POsattrib[i].coordX;
  //Y:=entita_D^[indcor]^.Y1+POsattrib[i].coordY;
  end
else
  begin
  visibile:='     1';//invisibile
  X:=entita_D^[indcor]^.X1;
  Y:=entita_D^[indcor]^.Y1;
  end
end;

function esadecimale(cifra:integer):string;
begin
case cifra of
0:result:='0';
1:result:='1';
2:result:='2';
3:result:='3';
4:result:='4';
5:result:='5';
6:result:='6';
7:result:='7';
8:result:='8';
9:result:='9';
10:result:='A';
11:result:='B';
12:result:='C';
13:result:='D';
14:result:='E';
15:result:='F';
END;
end;
function Gestore:string;
var Temp1,temp2:integer;
begin
inc(indgest);
temp1:=indgest mod 16;
temp2:=indgest div 16;
result:='';
while (temp2<>0)or(temp1<>0) do
  begin
  result:=esadecimale(temp1)+result;
  temp1:=temp2 mod 16;
  temp2:=temp2 div 16;
  end;
end;

Procedure ArcoDxf(xl1,yl1,raggio,angin,angfin:real;layer,colore,tlinea:string);
Var lx1,ly1,sraggio,sangin,sangfin:string;
    temp:real;
Procedure angacad(Var angolo,angolo1:real);
begin
{
angolo:=-angolo;//antiorario
angolo:=angolo+PI/2; //origine orizzontale
angolo1:=-angolo1;//antiorario
angolo1:=angolo1+PI/2; //origine orizzontale
if angolo < 0 then
  begin
  angolo:=angolo+2*pi;
  angolo1:=angolo1+2*pi;
  end;
if angolo > 2*PI then
  begin
  angolo:=angolo-2*pi;
  angolo1:=angolo1-2*pi;
  end;
}
angolo:=angolo*180/pi;
angolo1:=angolo1*180/pi;
end;
begin
//OutArcoBM(xl1,yl1,raggio,angin,angfin, piano_Ogg(layer));
if tlinea='' then tlinea:='CONTINUOUS';
if tlinea='TR' then tlinea:='ACAD_ISO02W100';
lx1:=float_to_str(xl1,16);
ly1:=float_to_str(yl1,16);
angacad(angin,angfin);
{
if (angfin>angin)and(angfin-angin>180)then  //solo angoli acuti
  begin
  temp:=angin;
  angin:=angfin;
  angfin:=temp;
  end
else
if (angin>angfin)and(angin-angfin<180)then  //solo angoli acuti
  begin
  temp:=angin;
  angin:=angfin;
  angfin:=temp;
  end;
}
sraggio:=float_to_str(raggio,16);
sangin:=float_to_str(angin,16);
sangfin:=float_to_str(angfin,16);
Writeln(fo,'  0');
Writeln(fo,'ARC');
Writeln(fo,'  5');
//Writeln(fo,'7E');
Writeln(fo,Gestore);
Writeln(fo,'  8');
Writeln(fo,Layer);
Writeln(fo,'  6');
Writeln(fo,tlinea);
Writeln(fo,' 62');
if colore='' then colore:='3';
Writeln(fo,'     '+colore);
Writeln(fo,' 10');
Writeln(fo,lx1);
Writeln(fo,' 20');
Writeln(fo,ly1);
Writeln(fo,' 30');
Writeln(fo,'0.0');
Writeln(fo,' 40');
Writeln(fo,sraggio);
Writeln(fo,' 50');
Writeln(fo,sangin);
Writeln(fo,' 51');
Writeln(fo,sangfin);
end;

Procedure LineaDxf(xl1,yl1,zl1,xl2,yl2,zl2:real;layer,colore,tlinea:string);
Var lx1,ly1,lz1,lx2,ly2,lz2:string;
begin
if tlinea='' then tlinea:='CONTINUOUS';
if tlinea='TR' then tlinea:='ACAD_ISO02W100';
//if not pianovalido(layer) then exit;
lx1:=float_to_str(xl1,16);
ly1:=float_to_str(yl1,16);
lz1:=float_to_str(zl1,16);
lx2:=float_to_str(xl2,16);
ly2:=float_to_str(yl2,16);
lz2:=float_to_str(zl2,16);
Writeln(fo,'  0');
Writeln(fo,'LINE');
Writeln(fo,'  5');
//Writeln(fo,'160C3');
Writeln(fo,Gestore);
Writeln(fo,'  8');
Writeln(fo,Layer);
Writeln(fo,'  6');
Writeln(fo,tlinea);
Writeln(fo,' 62');
if colore='' then colore:='3';
Writeln(fo,'     ' + colore);
Writeln(fo,' 10');
Writeln(fo,lx1);
Writeln(fo,' 20');
Writeln(fo,ly1);
Writeln(fo,' 30');
Writeln(fo,lz1);
Writeln(fo,' 11');
Writeln(fo,lx2);
Writeln(fo,' 21');
Writeln(fo,ly2);
Writeln(fo,' 31');
Writeln(fo,lz2);
end;

Procedure BloccoDxf(Layer,Colore,Tlinea,Nomebl,CodEnt:string;X1,Y1,Z1,ang:real;Nattrib:integer);
begin
Writeln(fo,'  0');
Writeln(fo,'INSERT');
Writeln(fo,'  5');
//Writeln(fo,Codent);
Writeln(fo,gestore);
Writeln(fo,'  8');
Writeln(fo,Layer);
if Nattrib>0 then
  begin
  Writeln(fo,'  6');
  Writeln(fo,TLinea);
  Writeln(fo,' 62');
  Writeln(fo,colore);
  Writeln(fo,' 66');
  Writeln(fo,'     1');
  end;
Writeln(fo,'  2');
Writeln(fo,Nomebl);
Writeln(fo,' 10');
Writeln(fo,float_to_str(X1,16));
Writeln(fo,' 20');
Writeln(fo,float_to_str(Y1,16));
Writeln(fo,' 30');
Writeln(fo,float_to_str(Z1,16));
Writeln(fo,' 50');
Writeln(fo,float_to_str(Ang,16));
if uppercase(nomebl)='RIFEST' then
  begin
  Writeln(fo,' 41');
  Writeln(fo,float_to_str(scalaPiantaesterna,16));
  Writeln(fo,' 42');
  Writeln(fo,float_to_str(scalaPiantaesterna,16));
  Writeln(fo,' 43');
  Writeln(fo,float_to_str(scalaPiantaesterna,16));
  end;
end;

Procedure AttribDxf(Coda,Valore:string;Xa,Ya,Za,Ang:real;visibile:string);
Var x1,y1,xat,yat:real;
begin
Writeln(fo,' 0');
Writeln(fo,'ATTRIB');
Writeln(fo,'  5');
//Writeln(fo,'B7D');
Writeln(fo,Gestore);
Writeln(fo,'  8');
Writeln(fo,'0');

xat:=xa;yat:=ya;
{
if coda[1]='&' then  //giustifica a destra
  begin
  Writeln(fo,' 72');
  Writeln(fo,'     2');
  xa:=0.1*Length(coda);
  ya:=0;
  modicord1(xa,ya,xat,yat,ang_rad(ang),1);
  end;
}
Writeln(fo,' 10');
Writeln(fo,float_to_str(Xa,16));
Writeln(fo,' 20');
Writeln(fo,float_to_str(Ya,16));
Writeln(fo,' 30');
Writeln(fo,float_to_str(Za,16));
Writeln(fo,' 40');
Writeln(fo,'0.15');
//Writeln(fo,'0.1921732441292363');
Writeln(fo,' 50');
Writeln(fo,float_to_str(Ang,16));
Writeln(fo,'  1');
Writeln(fo,Valore);
{
if coda[1]='&' then  //giustifica a destra
  begin
  Writeln(fo,' 11');
  Writeln(fo,float_to_str(Xat,16));
  Writeln(fo,' 21');
  Writeln(fo,float_to_str(Yat,16));
  Writeln(fo,' 31');
  Writeln(fo,float_to_str(Za,16));
  end;
}
Writeln(fo,'  2');
Writeln(fo,Coda);
Writeln(fo,' 70');
//Writeln(fo,'     1'); // 1=invisibile  0=visibile
if visibile='' then visibile:='0';
Writeln(fo,visibile);
end;

Procedure fineblo;
begin
Writeln(fo,'  0');
Writeln(fo,'SEQEND');
Writeln(fo,'  5');
//Writeln(fo,'B87');
Writeln(fo,Gestore);
Writeln(fo,'  8');
Writeln(fo,'P1');
Writeln(fo,'  6');
Writeln(fo,'CONTINUOUS');
Writeln(fo,' 62');
Writeln(fo,'     6');
end;

Procedure InitEntita;//nota per emanuela da aggiungere in tubi
var i:integer;
begin
for i:=1 to Maxentita do
entita_D^[i]:=nil;
end;
Procedure Nuovaent;
begin
if NEntita < MaxEntita then
begin
   inc(Nentita);
   if entita_d^[Nentita]=Nil then
   new(entita_d^[Nentita]);
end;
with entita_d^[Nentita]^ do
  begin
  Colore:='3';
  TLinea:='CONTINUOUS';
  codent:='B7D';//valore d'emergenza
  Valido:='S';
  Nattrib:=0;
  end;
end;
Procedure Add_AttribDxf(xl1,yl1,zl1:real;Nome,lValore:string);
begin
inc(Entita_d^[NEntita]^.Nattrib);
with Entita_d^[NEntita]^.Attrib[Entita_d^[NEntita]^.Nattrib] do
  begin
  Xa:=xl1;
  Ya:=Yl1;
  Za:=Zl1;
  Coda:=Nome;
  Valore:=LValore;
  end;
end;
Procedure Add_Attrib_Dxf(Nome,lValore:string);
begin
Add_AttribDxf(0,0,0,Nome,lValore);
end;
Procedure Add_BloccoDxf_Col_ing(xl1,yl1,zl1,LAng,lingX,lingY:real;LNomebl,llayer,LColore:string);
begin
NuovaEnt;
with Entita_d^[NEntita]^ do
  begin
  Cod:='B';
  x1:=xl1;
  y1:=yl1;
  z1:=zl1;
  x2:=LingX;//usato come ingrandimento  X del blocco
  y2:=LingY;//usato come ingrandimento  y del blocco
  ang:=Lang;
  NomeBl:=LNomeBl;
  Layer:=LLayer;
  colore:=Lcolore;
  end;
End;
Procedure Add_BloccoDxf_Col(xl1,yl1,zl1,LAng:real;LNomebl,llayer,LColore:string);
begin
Add_BloccoDxf_Col_ing(xl1,yl1,zl1,LAng,1,1,LNomebl,llayer,LColore);
end;
Procedure Add_BloccoDxf(xl1,yl1,zl1,LAng:real;LNomebl,llayer:string);
begin
Add_BloccoDxf_Col(xl1,yl1,zl1,LAng,LNomebl,llayer,'1');
end;


Procedure Add_ArcoDxf(xl1,yl1,zl1,raggio,angin,angfin:real;llayer,lcolore,ltlinea:string);
begin
NuovaEnt;
with Entita_d^[NEntita]^ do
  begin
  Cod:='A';
  x1:=xl1;
  y1:=yl1;
  z1:=zl1;
  ang:=raggio;
  x2:=angin;
  y2:=angfin;
  layer:=llayer;
  colore:=Lcolore;
  Tlinea:=Ltlinea;
  end;
end;
Procedure Add_CerchioDxf(xl1,yl1,zl1,raggio:real;llayer,lcolore,ltlinea:string);
begin
Add_ArcoDxf(xl1,yl1,zl1,raggio,0,2*pi-0.01,llayer,lcolore,ltlinea);
end;
Procedure Add_LineaDxf(xl1,yl1,zl1,xl2,yl2,zl2:real;llayer,lcolore,ltlinea:string);
begin
NuovaEnt;
with Entita_d^[NEntita]^ do
  begin
  Cod:='L';
  x1:=xl1;
  y1:=yl1;
  z1:=zl1;
  x2:=xl2;
  y2:=yl2;
  z2:=zl2;
  layer:=llayer;
  colore:=Lcolore;
  Tlinea:=Ltlinea;
  end;
end;
Procedure Add_TestoDxf(xl1,yl1,zl1,LAng:real;Descr,llayer,LColore:string);
begin
Add_BloccoDxf_col(xl1,yl1,zl1,LAng,'TESTO',llayer,LColore);
Add_Attrib_Dxf('TESTO',Descr);
end;
Procedure output_dxf(nomedxf:string);

Var buf,buf1,temp,visibile,codrim,colore_E:string;
    i,j:integer;
begin
if tutto_grigio then colore_E:='9';
//maxUs_h:=0;
if salva_rimandi_dxf then
  begin
  assign(frim,copy(nomedxf,1,length(nomedxf)-3)+'rim');
  rewrite(frim);
  end;
LeggiPOsa;
indgest:=100000;
assign(fo,Nomedxf);
try
  rewrite(fo);
  assign(fi, IncludeTrailingPathDelimiter(Percorsodrive) + 'intestazionedxf.txt');
  try
    reset(fi);
    while (not eof(fi))and(uppercase(buf)<>'ENTITIES') do
    begin
      readln(fi,Buf);
      if{ buf='  5' }false then
        begin
        Writeln(fo,Buf);
        readln(fi,Buf);
        Writeln(fo,gestore);
        end
      else
        begin
        if (piantaesterna<>'') and (uppercase(buf)='C:\TEMP\RIFEST.DWG') then
        buf:=piantaesterna;
        Writeln(fo,Buf);
        end;
    end;
    CloseFile(Fi);
  except
    CloseFile(Fi);
  end;

  for i:=entita_iniziale+1 to Nentita do    //normalmente entita_iniziale é 0
  with entita_d^[i]^ do
  if Valido='S' then
    begin
    if not tutto_grigio then colore_e:=colore;
    if cod='L' then LineaDxf(x1,y1,z1,x2,y2,z2,layer,colore_e,tlinea)
    else
    if cod='B' then
      begin
      BloccoDxf(Layer,Colore_e,Tlinea,Nomebl,CodEnt,X1,Y1,Z1,Ang,Nattrib);
      for j:=1 to Nattrib do
      with entita_d^[i]^.Attrib[j] do
        begin
        if (salva_rimandi_dxf)and(pos('RIMRETE',uppercase(nomebl))<>0)and(uppercase(coda)='CODICE') then codrim:=valore;
        Set_POs_a(i,entita_d^[i]^.NomeBl,CodA,valore,ang,Xa,Ya,visibile);
        AttribDxf(Coda,Valore,Xa,Ya,Za,ang,visibile);
        end;
      if Nattrib>0 then fineblo;

      if (salva_rimandi_dxf)and(pos('RIMRETE',uppercase(nomebl))<>0) then
      writeln(frim,nomebl,':',codrim,':',float_to_str(x1,6),':',float_to_str(y1,6),':',float_to_str(z1,6),':',float_to_str(ang,6),':');
      end
    else
    if cod='A' then  ArcoDxf(x1,y1,ang,x2,y2,layer,colore_e,tlinea);
    end;
  Writeln(fo,'   0');
  Writeln(fo,'ENDSEC');
  Writeln(fo,'  0');
  Writeln(fo,'EOF');
  close(fo);
  if salva_rimandi_dxf then close(frim);

except
  if salva_rimandi_dxf then close(frim);
  close(fo);
end;
salva_rimandi_dxf:=false;
end;

Function TipoPiano(Layer:string):string;
Var pp:integer;

begin
result:='';
pp:=pos('_',Layer);
if pp<>0 then result:=uppercase(copy(Layer,pp+1,length(layer)-pp));
end;

Procedure Pulisci_dxf;
Var i:Integer;
begin
for i:=1 to NEntita do
with entita_d^[Nentita]^ do
  begin
  If (TipoPiano(Layer)='RITORNO') then
  Valido:='N';
  If (TipoPiano(Layer)='QUOTE') then
  Valido:='N';
  end;
end;
Procedure Input_dxf(nomedxf:string;init:boolean);

Var buf,buf1,temp,visibile,giustifia:string;
    PrimoPar:boolean;

Function Cerca2Par(par1,Par2:string;Var pp1:boolean):string;
begin
buf:='';
  while (not eof(fi))and(par1<>formst(buf))and(par2<>formst(buf)) do
    begin
    readln(fi,Buf);
    readln(fi,Buf1);
    end;
pp1:=par1=formst(buf);
result:=buf1;
end;

Function CercaPar(par:string):string;
begin
buf:='';
Buf1:='';
  while (not eof(fi))and(formst(buf1)<>'ENDSEC')and(par<>formst(buf)) do
    begin
    readln(fi,Buf);
    readln(fi,Buf1);
    end;
result:=buf1;
end;

begin
Nentita:=entita_iniziale;
temp:='';

if not fileexists(nomedxf) then exit;
assign(fi,Nomedxf);
try
  reset(fi);
  if scrivi_int then assign(fo, IncludeTrailingPathDelimiter(Percorsodrive) + 'intestazionedxf.txt');
  try
    if scrivi_int then rewrite(fo);
    while (not eof(fi))and(buf<>'ENTITIES') do
    begin
      readln(fi,Buf);
      if scrivi_int then Writeln(fo,Buf);
    end;
    if scrivi_int then CloseFile(fo);
  except
    if scrivi_int then CloseFile(fo);
  end;

  while (not eof(fi))or (uppercase(temp)<>'') do
    begin
    if (uppercase(temp)<>'') then buf:=temp
    else
    while (not eof(fi))and(buf<>'LINE')and(buf<>'INSERT'){and(buf<>'POLYLINE')} do
    readln(fi,Buf);
    temp:='';
    if buf='LINE' then
      begin
      Nuovaent;
      with entita_d^[Nentita]^ do
        begin
        Nattrib:=0;
        Cod:='L';
        codent:=Cercapar('5');
        Layer:=Cercapar('8');
        Tlinea:='CONTINUOUS';
        Colore:=Cerca2par('6','62',Primopar);
        if primopar then
          begin
          if formst(colore)<>'CONTINUOUS' then
          Tlinea:=colore;
          Colore:=Cercapar('62');
          end;

        x1:=str_tofloat(Cercapar('10'));
        y1:=str_tofloat(Cercapar('20'));
        z1:=str_tofloat(Cercapar('30'));
        x2:=str_tofloat(Cercapar('11'));
        y2:=str_tofloat(Cercapar('21'));
        Z2:=str_tofloat(Cercapar('31'));
        end;
       end
    else
      begin
      if buf='INSERT' then
        begin
        Nuovaent;
        with entita_d^[Nentita]^ do
          begin
          codent:=Cercapar('5');
          Layer:=Cercapar('8');
          Tlinea:='CONTINUOUS';
          Cod:='B';
          Nattrib:=0;
          NomeBl:=Cercapar('2');
          if uppercase(copy(Nomebl,1,4))='LOC_' then NomeBL:='LOC';
          x1:=str_tofloat(Cercapar('10'));
          y1:=str_tofloat(Cercapar('20'));
          Z1:=str_tofloat(Cercapar('30'));
          ang:=0;
          temp:=Cerca2par('50','0',Primopar);
          if primopar then
            begin
            ang:=str_tofloat(temp);
            temp:=Cercapar('0');//ATTRIB
            end;
          if Uppercase(temp)='ATTRIB' then
          repeat
            if  Uppercase(Temp)='ATTRIB' then
              begin

              inc(Nattrib);
              with entita_d^[Nentita]^.Attrib[Nattrib] do
                begin
                Xa:=str_tofloat(Cercapar('10'));
                Ya:=str_tofloat(Cercapar('20'));
                Za:=str_tofloat(Cercapar('30'));
                Valore:=Cercapar('1');
                CodA:=Cercapar('2');
                Visibile:=Cercapar('70');
                temp:=Cercapar('0');//ATTRIB
                if init then
                POs_a(entita_d^[Nentita]^.NomeBl,coda,Xa-entita_d^[Nentita]^.x1,Ya-entita_d^[Nentita]^.y1,visibile);
                end;

              end;
          until Uppercase(Temp)<>'ATTRIB';
          end;
        end
      else readln(fi,Buf);
      if Uppercase(Temp)='ATTRIB' then temp:='';
      end;
    end;
  Close(fi);
except
  Close(fi);
end;
Pulisci_dxf;
if init then
salvaposa;
//output_dxf(Nomedxf);
end;
Procedure Aggiorna_Attributi;
begin
input_dxf(I_sl(percorsodrive)+'definizione simboli.dxf',true);
salva_Posa;
end;
end.
