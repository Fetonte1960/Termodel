unit Uarchpezzi;

interface
uses graphics,types,definizcan,definiz,dummyfunction,sysutils,pezzi,funzdim,interf3d,Uoggetti,
      Variabili3d;
const maxpezzi=241;
Procedure  InitForm;
Procedure CambiaNuscite;
Procedure Cambiacodice;
implementation
uses u3dsd;

const fing=0.1;
      spx=90;
      spy=90;
Function Ingx(xx:real):real;
begin
result:=xx*fing+spx;
end;
Function IngY(yy:real):real;
begin
result:=yy*fing+spy;
end;
Function Ing(vl:real):real;
begin
result:=vl*fing;
end;


Procedure linea(x1,y1,x2,y2:real;cnv:Tcanvas);
begin
cnv.Moveto(Round(Ingx(x1)),Round(IngY(y1)));
cnv.Lineto(Round(Ingx(x2)),Round(IngY(y2)));
end;
Procedure Arco(x1,y1,r,an1,an2:real;cnv:Tcanvas);
begin
x1:=Ingx(x1);
y1:=Ingx(y1);
r:=Ing(r);
if r<0 then r:=-R;
//an1:=an1+pi/2;
//an2:=an2+pi/2;
cnv.Arc(round(x1-r),round(y1-r),round(x1+r),round(y1+r),round(x1+r*sin(an1)),round(y1+r*cos(an1)),round(x1+r*sin(an2)),round(y1+r*cos(an2)));
end;

Var    bufdim:vetdim;

procedure Leggidisegno_canali(canv : TCanvas);
(*
type
      VetDim=record
             Codpezzo,gruppo:integer;
             Entita:string[1];
             Piano:string[30];
             Tlinea,Colore:integer;
             X1,Y1,X2,Y2,Z1,Z2:real;
             R,R2:real;
             end;
Var fDim:file of vetdim;
*)

begin
if fileexists('disegnocanali.dsc') then
  begin
  assignfile(fdim,'disegnocanali.dsc');
  reset(fdim);
    while not eof(Fdim)do
      begin
      read(fdim,bufdim);
      with bufdim do
        case upcase(entita[1]) of
        'L','F','*':linea(x1,y1,x2,y2,canv);
        //'Q':Testo(x1,y1,float_to_str(x2,2));
        'A':Arco(x1,y1,R,x2,y2,canv);
        'C':Arco(x1,y1,R,0,2*pi,canv);
        end;
      end;
  close(Fdim);
  end;
end;
Procedure Redraw2d;
Var rett:Trect;
begin
with form1.Image1.Canvas do
  begin
  rett.top:=0;
  rett.Left:=0;
  rett.Right:=200;
  rett.Bottom:=200;
  Brush.Color:=clwhite;
  pen.Color:=clblack;
  fillrect(rett);
  end;
Leggidisegno_canali(form1.Image1.Canvas);
end;
Procedure InitProgram;
begin
new(DisPezzo);
driveprog:='';
Nomeprog:='pezzo';
definizcan.nomeprog:='Disegno';
init3d;
new(conf);
conf^.altnum:=100;
new(costant);
init_cost;
end ;
{------------------------RICERCA-------------------------}

FUNCTION Cerca_ARCHIVIO(Cod : String) : INTEGER;
    VAR
      I, j : INTEGER;
      Trovato : BOOLEAN;
    BEGIN
      Cod:= UPString(Cod);


      I := 1; Trovato := FALSE;
      WHILE (I <= NPezzi) AND NOT Trovato DO
        BEGIN
           Trovato := (archpezzi[i].Codice = Cod);
           IF NOT Trovato THEN i := i+1;
        END;

      IF NOT Trovato THEN Cerca_ARCHIVIO := 0
      ELSE Cerca_ARCHIVIO := I;

    END;
Var Nuscite:integer;
Function PosTipo(ind:integer):integer;
begin
with archpezzi[ind] do
result:=strtoint(codice[2])+4;
end;


function Mandcod(ci:string):integer;
begin
Result:=0;
ci:=ci[length(ci)];
if ci='>' then result:=1;
if ci='<' then result:=2;
end;

function tipocod(ci:string):string;
begin
Result:='';
if length(ci)>=Nuscite+6 then result:=copy( ci,Nuscite+4,3);
end;
function angcod(ci:string):string;
begin
result:='0';
if tipocod(ci)='ULT' then result:='90' else
  begin
  if length(ci)>=Nuscite+8 then result:=copy( ci,Nuscite+7,2);
  if (result<>'20')and(result<>'30')and(result<>'45')and(result<>'60')and(result<>'75')and(result<>'90')then
  result:='0';
  end;
end;

Procedure initcombopezzi;
Var i:integer;
    tipo,angolo,ss:string;
 const mandrip=1;
begin
with form1 do
  begin
  ss:=cbcodpezzo.text;
  Nuscite:=strtoint(cbNuscite.text);
  angolo:=angcod(ss);
  cbcodpezzo.Items.Clear;
  for i:=1 to maxpezzi do
  if ((cbentrata.text='')or (archpezzi[i].Codice[1]=cbentrata.text[1]))and
     (((cbtipo.text='TUTTO')and (length(archpezzi[i].Codice)>=postipo(i)+2))or (length(archpezzi[i].Codice)>=postipo(i)+3)or(copy(archpezzi[i].Codice,postipo(i),3)=copy(cbtipo.text,1,3)))and
     ((cbNuscite.text='')or (archpezzi[i].Codice[2]=cbNuscite.text[1])) and
     ((cbUscita1.text='')or (archpezzi[i].Codice[3]=cbUscita1.text[1])) and
     ((cbNuscite.text='')or(strtoint(cbNuscite.text)<2)or(cbUscita2.text='')or (archpezzi[i].Codice[4]=cbUscita2.text[1]))and
     (angolo=angcod(archpezzi[i].Codice))and
     ((mandrip=0)or(mandcod(archpezzi[i].Codice)=0)or(mandrip=mandcod(archpezzi[i].Codice)))
  then cbcodpezzo.Items.Add(archpezzi[i].Codice);
  end;
end;

Procedure CambiaNuscite;
begin
initcombopezzi;
end;
 { TODO -oDiego -cNavigazione : Simulazione pezzo }
Procedure Cambiacodice;
Var ind,j,ORLOC:integer;
Type RecPU=record xa,ya,xb,yb:real end;
     Ar_pu=Array[0..3]of recpu;

Var PU:Ar_pu;
    Z_U    :Array[0..3]of real;
    const ingloc=0.4;
Var AA1,BB1:real;
    AA2,BB2:real;
    AA0,BB0:real;
begin
ind:=Cerca_archivio(form1.cbcodpezzo.text);
if ind<>0 then
  begin
  form1.LDescrpezzo.Caption:=archpezzi[ind].Descr;
  form1.Lcod2.Caption:=archpezzi[ind].codpezzo;
  Rewrite(F3d);
  Rewrite(F3dTxt);
  (*
  disegnapezzo(codice,L[0],H[0],L[1],H[1],0,0,0,0,
                     Fi[0],Fi[1],0,0,
                     Orient,Ang,Rag,lung*1000,0,0,Varie,Dis^[i]^.Colorc,
                     PU[0].xa,PU[0].ya,PU[0].xb,PU[0].yb,
                     PU[1].xa,PU[1].ya,PU[1].xb,PU[1].yb,
                     PU[2].xa,PU[2].ya,PU[2].xb,PU[2].yb,
                     PU[3].xa,PU[3].ya,PU[3].xb,PU[3].yb,
                     Z_U[0],Z_U[1],Z_U[2],Z_U[3]);
  *)
  aa0:=0;bb0:=0;
  if Upcase(form1.CBEntrata.Text[1])='R' then
    begin
    aa0:=600;bb0:=300;
    end;
  aa1:=0;bb1:=0;
  if Upcase(form1.CBUscita1.Text[1])='R' then
    begin
    aa1:=200;bb1:=100;
    end;
  aa2:=0;bb2:=0;
  if Upcase(form1.CBUscita2.Text[1])='R' then
    begin
    aa2:=150;bb2:=50;
    end;
  orloc:=1;
  if form1.cborient.text<>'' then orloc:=strtoint(form1.cborient.text);

  disegnapezzo(upstring(archpezzi[ind].codpezzo),1,aa0,bb0,aa1,bb1,aa2,bb2,aa2,bb2,
                  600,200,150,100,
                  //1
                  orloc
                  ,strtoint(angcod(form1.cbcodpezzo.text)),1,200,100,100,1,1,
                  PU[0].xa,PU[0].ya,PU[0].xb,PU[0].yb,
                  PU[1].xa,PU[1].ya,PU[1].xb,PU[1].yb,
                  PU[2].xa,PU[2].ya,PU[2].xb,PU[2].yb,
                  PU[3].xa,PU[3].ya,PU[3].xb,PU[3].yb,
                  Z_U[0],Z_U[1],Z_U[2],Z_U[3]);

  //Inser3d(0,0,0,form1.TBTurn.POsition*2*Pi/100,0,strtoint(form1.cborient.text));
  assignfile(fdim,'disegnocanali.dsc');
  rewrite(fdim);
  for j:=1 to 30 do
  if DisPezzo^[j].Entita[1]<>' ' then
    begin
    bufdim.entita:=DisPezzo^[j].entita;
    bufdim.TLinea:=DisPezzo^[j].TLinea;
    bufdim.Colore:=1;
    bufdim.X1:=DisPezzo^[j].X1;
    bufdim.Y1:=DisPezzo^[j].Y1;
    bufdim.X2:=DisPezzo^[j].X2;
    bufdim.Y2:=DisPezzo^[j].Y2;
    bufdim.R:=DisPezzo^[j].R;
    bufdim.R2:=DisPezzo^[j].R1;
    write (Fdim,bufdim);
    end;
  with bufdim do
  for j:=0 to 3 do
    begin
    entita:='L';
    x1:=pu[j].xa;
    Y1:=pu[j].ya;
    x2:=pu[j].xb;
    y2:=pu[j].yb;
    write (Fdim,bufdim);
    end;
  close(fdim);
  copiaPezzo3d;
  indpezzo3d:=1;
  while  DisPezzo13d^[Indpezzo3d+1].Entita[1]<>' '  do inc(Indpezzo3d);
  Inser3d(0,0,0,form1.TBTurn.POsition*2*Pi/100,0,strtoint(form1.cborient.text));
  scrivi3d;
  close(F3d);
  close(F3dTxt);
  cancellatutto;
  InitVariabili;
  disegnaCanali('disegno.3dm',cparete);
  fissaingr(-ingloc,ingloc,-ingloc,ingloc,-ingloc,ingloc);
  settaingr;
  end;
redraw2d;
form1.DCOggetti.ShowAxes:=true;
end;
Procedure  InitForm;
begin
initprogram;
initcombopezzi;
cambiacodice;
end;
end.
