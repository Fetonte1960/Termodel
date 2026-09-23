unit Calcolo_analitico_pannelli;

interface
Uses math,varcarichi,uleggiscrividati;
implementation
const max_col=10;
      max_righe=10;
var ar_col,ar_righe:integer;
Type Tar_interp=array[1..max_col,1..max_righe]of real;
Var ar_interp:Tar_interp;
    val_righe:array[1..max_righe] of real;
    val_colonne:array[1..max_col] of real;

{--------------------------------------------------------------------------------------}

Function Interpola(ValColonna,Valriga:real;bidim:boolean):real;
Var supcolonna,infcolonna,supriga,infriga,i,j:integer;
    Vrinf,Vrsup:real;
begin
for i:=1 to ar_col do
  begin
  infcolonna:=1;
  supcolonna:=1;
  if val_Colonne[i]<=Valcolonna then infcolonna:=i;
  if val_Colonne[i]>=Valcolonna then
    begin
    Supcolonna:=i;
    break;
    end;
  end;
if bidim then
for i:=1 to ar_righe do
  begin
  infriga:=1;
  Supriga:=1;
  if val_righe[i]<=Valriga then infriga:=i;
  if val_righe[i]>=Valriga then
    begin
    Supriga:=i;
    break;
    end;
  end;
if bidim then
  begin
  Vrinf:=ar_interp[infcolonna,infriga]+(Valcolonna-val_colonne[infcolonna])*(ar_interp[supcolonna,infriga]-ar_interp[infcolonna,infriga])/(val_colonne[supcolonna]-val_colonne[infcolonna]);
  Vrsup:=ar_interp[infcolonna,supriga]+(Valcolonna-val_colonne[infcolonna])*(ar_interp[supcolonna,supriga]-ar_interp[infcolonna,supriga])/(val_colonne[supcolonna]-val_colonne[infcolonna]);
  Result:=VrInf+(Valriga-val_righe[infriga])-(vrsup-vrinf)/(val_righe[supriga]-val_righe[infriga]);
  end
else
  begin
  infriga:=1;
  //copiato da vrinf
  result:=ar_interp[infcolonna,infriga]+(Valcolonna-val_colonne[infcolonna])*(ar_interp[supcolonna,infriga]-ar_interp[infcolonna,infriga])/(val_colonne[supcolonna]-val_colonne[infcolonna]);
  end;
end;

{--------------------------------------------------------------------------------------}
Function Tabella1(Val_Colonna,Val_riga:real):real;
Var I,J:integer;
const TAB:array[1..6,1..4]of real=((1.196,0.833,0.640,0.519),(1.122,0.797,0.618,0.505),
                                    (1.058,0.764,0.598,0.491),(1.000,0.734,0.579,0.478),
                                    (0.924,0.692,0.553,0.460),(0.821,0.632,0.514,0.433));
const ColT:array[1..4]of real=(0.00,0.05,0.10,0.15);
const RigT:array[1..6]of real=(2,1.5,1.2,1,0.8,0.6);

begin
ar_col:=4;
ar_righe:=6;
for i:=1 to ar_col do val_colonne[i]:=colT[i];
for i:=1 to ar_righe do val_righe[i]:=rigT[i];
for i:=1 to ar_col do
for J:=1 to ar_righe do
ar_interp[i,j]:=Tab[J,I];
result:=interpola(Val_Colonna,Val_riga,true);
end;
{--------------------------------------------------------------------------------------}
Function Tabella3(Val_Colonna,Val_riga:real):real;
Var I,J:integer;
const TAB:array[1..8,1..4]of real=((1.0690,1.056,1.0430,1.0370),(1.0660,1.053,1.0410,1.0350),
                                    (1.0630,1.050,1.0390,1.0335),(1.0570,1.046,1.0350,1.0305),
                                    (1.0510,1.041,1.0315,1.0275),(1.0480,1.038,1.0295,1.0260),
                                    (1.0395,1.031,1.0240,1.0210),(1.0300,1.024,1.0180,1.0160));
const ColT:array[1..4]of real=(0.00,0.05,0.10,0.15);
const RigT:array[1..8]of real=(0.05,0.075,0.1,0.15,0.2,0.225,0.3,0.375);

begin
ar_col:=4;
ar_righe:=8;
for i:=1 to ar_col do val_colonne[i]:=colT[i];
for i:=1 to ar_righe do val_righe[i]:=rigT[i];
for i:=1 to ar_col do
for J:=1 to ar_righe do
ar_interp[i,j]:=Tab[J,I];
result:=interpola(Val_Colonna,Val_riga,true);
end;
{--------------------------------------------------------------------------------------}
Function Tabella4(Val_Colonna,Val_riga:real):real;
Var I,J:integer;
const TAB:array[1..8,1..4]of real=((1.013,1.013,1.012,1.011),(1.021,1.019,1.016,1.014),
                                    (1.029,1.025,1.022,1.018),(1.040,1.034,1.029,1.024),
                                    (1.046,1.040,1.035,1.030),(1.049,1.043,1.038,1.033),
                                    (1.053,1.049,1.044,1.039),(1.056,1.051,1.046,1.042));
const ColT:array[1..4]of real=(0.00,0.05,0.10,0.15);
const RigT:array[1..8]of real=(0.05,0.075,0.1,0.15,0.2,0.225,0.3,0.375);

begin
ar_col:=4;
ar_righe:=8;
for i:=1 to ar_col do val_colonne[i]:=colT[i];
for i:=1 to ar_righe do val_righe[i]:=rigT[i];
for i:=1 to ar_col do
for J:=1 to ar_righe do
ar_interp[i,j]:=Tab[J,I];
result:=interpola(Val_Colonna,Val_riga,true);
end;
{--------------------------------------------------------------------------------------}
Function Tabella2(Val_Colonna:real):real;
Var I:integer;
const TAB:array[1..4]of real=(1.230,1.188,1.156,1.134);
const ColT:array[1..4]of real=(0.00,0.05,0.10,0.15);

begin
ar_col:=4;
for i:=1 to ar_col do val_colonne[i]:=colT[i];
for i:=1 to ar_col do
ar_interp[i,1]:=Tab[i];
result:=interpola(Val_Colonna,0,false);
end;
{--------------------------------------------------------------------------------------}
//definizione archivi
//Spestubo =spessore del tubo mm
//lambdaTubo = conducibilità termica del tubo, W/mK
//DiamEsterno=diametro esterno del tubo mm
//Spessmassetto = spessore massetto m
//LambdaMassetto = conducibilita termica del massetto, W/mK
Function Coeff_resa(Lambdam,RP,I,sm,DE,lambdaT,St:real):real;
//st =spessore del tubo m
//lambdaT = conducibilità termica del tubo, W/mK
//De=diametro esterno del tubo m
//sm = spessore massetto m
// I=interasse dei tubi m
//Lamdam = conducibilita termica del massetto, W/mK
//Rp = resistenza termica del pavimento, m2K/W
Const B0=6.7;
      St0=0.002;
      LambdaT0=0.350;
      Alfa=10.8;
      sm0=0.045;
      Lambdam0 = 1.0;
Var B,FP,X,AI,FI,Y,Am,Fm,Ad,Z,Fd,coefresa:real;
begin
FP:=(1/alfa+sm0/lambdam0)/(1/alfa+sm0/lambdam+RP);
X:=1-I/0.075;
AI:=Tabella2(RP);
FI:=Power(AI,X);
Y:=100*(0.045-sm);
Am:=tabella3(RP,I);
Fm:=Power(Am,Y);
AD:=tabella4(RP,I);
Z:=250*(De-0.02);
FD:=Power(AD,Z);
B:=1/(1/B0+1.1/PI*Fp*FI*Fm*FD*I*(1/(2*lambdaT)*ln(de/(de-2*st))-1/(2*lambdaT0)*ln(de/(de-2*st0))));
Coefresa:=B*Fp*FI*Fm*FD;
end;
{--------------------------------------------------------------------------------------}
Function Tsup(ta,q:real):real;
//Ta = temperatura ambiente C
// q = densità di potenza   W/mq
begin
result:=ta+power(q/8.92,1/1.1);
end;
Function Potmax(Tamb,Tsup:real):real;
Var dtm,dtm1,dt,dtsup,dtinf,densp:real;
    ciclo:integer;
begin
{
dtsup:=Tsup(Tamb,200);
dtinf:=Tsup(Tamb,10);
dt:=(dtsup-dtinf)/2;
ciclo:=0;
  repeat
  inc(ciclo);
  dtm1:=dtmedialog(tmand,tmand-dt,tint);
  if dtm1>dtm then
    begin
    dtinf:=dt;
    dt:=(dtsup+dt)/2;
    end
  else
    begin
    dtsup:=dt;
    dt:=(dtinf+dt)/2;
    end;
  until  (abs(dtm1-dtm)<0.01)or(ciclo>30);
result:=dt;
}
end;


function Resa_pannello(Indice_amb,indice_term,indice_serie,indice_modello:integer):real;
begin
Leggi_mem_locali;
Leggi_mem_Terminali;
end;
end.
