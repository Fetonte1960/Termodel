unit VarCarichi;

interface
uses variabiligenerali;
{$I Typedef}
var
PATM:REAL;  { Pressione atmosferica }



{  Definizione ArCalc }
Const  MaxPointAmb=5000;
//Const  MaxPOnti=50;
Type

CarichiMax=RECORD
                CTMAX:REAL;
                CTTOTMAX:REAL;
                Ht,Mt:INTEGER;
              END;
PotenzeMax=RECORD
                PTMAX:REAL;
                PTTOTMAX:REAL;
                Ht,Mt:INTEGER;
              END;
RecPtm     = RECORD
                     PTMAX:REAL;
                     Ht:INTEGER;
                  END;
RecVarCalc = record
                    Ctm       : CarichiMax;
                    Ptm       : Potenzemax;
                    PtMinv    : RecPtm;
                    Pvent     : real;
                    InsTotInv : real;
                    QcTotInv  : real;
                    w1        : real;
              end;

PunCalc=array[1..MaxPointAmb] of ^RecVarcalc;
PuntCalc=^PunCalc;
var ArCalc:PuntCalc;
{   Definizione tabella interpolazioni }
 CONST
  DIM_X=16;
  DIM_Y=16;
TYPE
  TabInterp=ARRAY[0..DIM_X,0..DIM_Y] OF REAL48;

VAR
  TabC0:^TabInterp;

CF                         :integer         ;

{  Variabili di salvataggio su disco }
{$I costcart}
Const
NCanHM=21;
NCanH =8;

Type

TyHM=ARRAY[0..23,1..12] OF REAL;
  TyH =ARRAY[0..23] OF REAL;
  FHM =FILE OF TyHM;
  FH  =FILE OF TyH;
  tDAT  =ARRAY[1..NCanHM] OF TyHM;
  tdATB =ARRAY[1..NCanH]  OF TyH;

  RecHM=RECORD
          F:FHM;
          A:INTEGER;         { Codice Ambiente/record attualmente in buffer }
        END;
  RecH =RECORD
          F:FH;
          A:INTEGER;         { Codice Ambiente/record attualmente in buffer }
        END;


Var
CanHM:ARRAY[1..NCanHM] OF RecHM;
CanH :ARRAY[1..NCanH]  OF RecH;

DAT  :^tdat;
DATB :^tdatb;

Type
tab=array[0..23,1..12] of real;
ore=array[0..23] of real;
mesi=array[1..12] of real;

Var
R1,R2,R3,TE,IDN,SETOT,SEVENT :^tyhm;

TMAXBS,TMAXBU,WMAX,HMIN:mesi;

A0,T0:REAL;
USImm,USImmInv:ARRAY[1..MaxZone] OF REAL;
US,UR:tab;
UScost,URcost:REAL;

type
DescrOrizz=ARRAY[0..23] OF REAL; { (array index)*15=zona di orizzonte }
PunOrizz=^DescrOrizz;

Var
Orizzonte_D   :PunOrizz;

Const MaxProfili=10;

Type
RigaProf=ARRAY[0..23] OF INTEGER;

TabProf=ARRAY[1..MaxProfili] OF RigaProf;

PunProf=^TabProf;
Var
Profili_D:Punprof;
Nprofili:integer;
type
 dati_Ponti=object
              function K(Cod:integer): real;
            end;
var  Kappa_PT: ^Dati_Ponti;
 const
  QCTOT  :INTEGER=1;
  QIRRTOT:INTEGER=2;
  QIRCTOT:INTEGER=3;
  ILLTOT :INTEGER=4;
  QACON  :INTEGER=5;
  QAIRR  :INTEGER=6;
  QAILL  :INTEGER=7;
  INSTOT :INTEGER=8;
  INLTOT :INTEGER=9;
  EREST  :INTEGER=10;
  TIE    :INTEGER=11;
  UIE    :INTEGER=12;
  LATEFF :INTEGER=13;
  SZTOT  :INTEGER=14;
  LZTOT  :INTEGER=15;
  SZVENT :INTEGER=16;
  LZVENT :INTEGER=17;
  SAPR   :INTEGER=18;
  LAPR   :INTEGER=19;

  OCSTOT:INTEGER=1;
  OCLTOT:INTEGER=2;
  APSTOT:INTEGER=3;
  APLTOT:INTEGER=4;
  QAPS  :INTEGER=5;
  QOCS  :INTEGER=6;
  ERInv :INTEGER=7;
  TIEInv:INTEGER=8;
  
NOMHM:ARRAY[1..19]OF STRING[12]=

('QCTOT.DAT'  ,{1}
 'QIRRTOT.DAT',{2}
 'QIRCTOT.DAT',{3}
 'ILLTOT.DAT' ,{4}
 'QACON.DAT'  ,{5}
 'QAIRR.DAT'  ,{6}
 'QAILL.DAT'  ,{7}
 'INSTOTes.DAT' ,{8}
 'INLTOTes.DAT' ,{9}
 'EREST.DAT'  ,{10}
 'TIE.DAT'    ,{11}
 'UIE.DAT'    ,{12}
 'LATEFF.DAT' ,{13}
 'SZTOT.DAT'  ,{14}
 'LZTOT.DAT'  ,{15}
 'SZVENT.DAT' ,{16}
 'LZVENT.DAT' ,{17}
 'SAPR.DAT'   ,{18}
 'LAPR.DAT'   ){19};

NOMH:array[1..8] of string[12]=

('OCSTOT.DAT',{1}
 'OCLTOT.DAT',{2}
 'APSTOT.DAT',{3}
 'APLTOT.DAT',{4}
 'QAPS.DAT'  ,{5}
 'QOCS.DAT'  ,{6}
 'ERInv.DAT' ,{7}
 'TIEInv.DAT');{8}

CONST
  HE:ARRAY[ -10..47 ] of integer = (14,15,16,17,18,19,20,21,22,23,
                                    0,1,2,3,4,5,6,7,8,9,10,11,
                                    12,13,14,15,16,17,18,19,20,21,22,23,
                                    0,1,2,3,4,5,6,7,8,9,10,11,
                                    12,13,14,15,16,17,18,19,20,21,22,23);

var st_8:string[8];                                    
var
DRIVEARCC:ST126;
DRIVEMatrice:ST126;
Meseinizio,mesefine:integer;
DA,DP:string;
ErroreGen:boolean;

Const TPar='Parete';
      TFin='Finestra';
      TPOnte='PonteT';



Procedure Init_Puntatori;
Procedure Dispose_Puntatori;
Function NomeMese(Num:integer):string;

implementation

Function NomeMese(Num:integer):string;
begin
case num of
   1:result:=CH12;
   2:result:=CH13;
   3:result:=CH14;
   4:result:=CH15;
   5:result:=CH16;
   6:result:=CH17;
   7:result:=CH18;
   8:result:=CH19;
   9:result:=CH20;
  10:result:=CH21;
  11:result:=CH22;
  12:result:=CH23;
end;

end;

Function dati_Ponti.K(Cod:integer): real;
begin
   K := 0;
   k:=FrontiereLin_D^[Cod]^.Kappa;
end;

{$I NewPun}
{$I DispPun}
Procedure Init_Puntatori;
Var i:integer;
begin
InitPuntatori;
New(arcalc);
for i:=1 to MaxpointAmb do new(arcalc^[i]);
new(dat);
new(datb);
new(tabc0);
New(R1);
New(R2);
New(R3);
New(TE);
New(IDN);
New(SETOT);
New(SEVENT);
new(orizzonte_D);
for i:=0 to 23 do Orizzonte_D^[i]:=0;
New(Profili_D);
for i:=0 to 23 do Profili_d^[1][i]:=0;
for i:=8 to 18 do Profili_d^[1][i]:=100;
end;
Procedure Dispose_Puntatori;
Var i:integer;
begin
DisposePuntatori;
for i:=1 to MaxpointAmb do dispose(arcalc^[i]);
Dispose(arcalc);
dispose(dat);
dispose(datb);
dispose(tabc0);
Dispose(R1);
Dispose(R2);
Dispose(R3);
Dispose(TE);
Dispose(IDN);
Dispose(SETOT);
Dispose(SEVENT);
Dispose(orizzonte_D);
Dispose(Profili_D);
end;

end.
