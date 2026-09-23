{*************************************************************}
Type 
RecGen=Record
       Progetto:STRING[50];
       Committ:STRING[50];
       Progettista:STRING[50];
       Revisione:integer;
       Data:STRING[20];
       Luogo:STRING[32];
       ritorno:String[1];
       dps:real;
       maxvels:real;
       dpe:real;
       maxvele:real;
       valvtipo:string[8];
       perdmin:real;
       Tolleranza:real;
       Iterazioni:integer;
       End;
Var GENERALITA_D:^RecGen;
{*************************************************************}
Const MaxPerd=500;
Var Nperd:integer;
Type 
RecPerd=Record
       Cod:string[8];
       Descr:string[20];
       Leq:real;
       Zeta:real;
       Rit:String[1];
       End;
Ar_RecPerd=array[1..MaxPerd]of RecPerd;
Var Perd_D:^Ar_RecPerd;
{*************************************************************}
Const MaxSez=50;
Type 
Recsez=Record
       Dnom:string[8];
       Dint:Real;
       spes:Real;
       form:integer;
       End;
Ar_Recsez=array[1..MaxSez]of Recsez;
{*************************************************************}
Const MaxTubax=100;
Var Ntubaz:integer;
Type 
RecTubaz=Record
       Sez:Ar_Recsez;
       NSez:Integer;
       Cod:string[8];
       Descr:string[55];
       Dens:Real;
       Rug:Real;
       End;
Ar_RecTubaz=array[1..MaxTubax]of RecTubaz;
Var Tubaz_D:^Ar_RecTubaz;
{*************************************************************}
Const MaxPconc=10;
Var Npconc:integer;
Type 
RecPconc=Record
       N:integer;
       Cod:string[8];
       End;
Ar_RecPconc=array[1..MaxPconc]of RecPconc;
Var Pconc_D:^Ar_RecPconc;
{*************************************************************}
Const MaxPros=10;
Type 
RecPros=Record
       Ramo:Integer;
       End;
Ar_RecPros=array[1..MaxPros]of RecPros;
{*************************************************************}
Const Lungdati=16000;
Var Ntronchi:integer;
Type 
calcrec=Record
       Pros:Ar_RecPros;
       Npros:Integer;
       Num:integer;
       x:real;
       y:real;
       Tipo:string[8];
       Dh:real;
       lungh:real;
       Coddiam:string[8];
       diam:real;
       SWDiam:string[1];
       port:real;
       PortEff:real;
       Ti:integer;
       Term:integer;
       pd:Real;
       pl:Real;
       pp:Real;
       pr:Real;
       End;
Ar_calcrec=array[1..Lungdati]of calcrec;
Var Dati:^Ar_calcrec;
