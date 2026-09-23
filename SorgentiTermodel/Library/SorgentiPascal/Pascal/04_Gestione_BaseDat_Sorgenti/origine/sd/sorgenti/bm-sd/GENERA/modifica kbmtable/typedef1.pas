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
