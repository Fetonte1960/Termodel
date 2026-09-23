{*************************************************************}
Const MaxAmb=500;
Var NAmb:integer;
Type 
Amb=Record
       Par:Ar_;
       :Integer;
       Num:Autoinc;
       Descr:string[20];
       Direz:real;
       Tipo:string[10];
       L:real;
       H:real;
       Alt:real;
       LQ1:real;
       HQ1:real;
       allinea:String[2];
       NLamp:integer;
       TLamp:integer;
       LLamp1:real;
       HLamp1:real;
       SLamp:real;
       POtlamp:real;
       TPOtlamp:real;
       Irragg:real;
       Persone:real;
       AltriC:real;
       ETotSens:real;
       ITotSens:real;
       Slorda:real;
       Snetta:real;
       POrtAp:real;
       TiI:real;
       URI:real;
       ITmaria:real;
       ITmacq:real;
       ITracq:real;
       TiE:real;
       URE:real;
       ETmaria:real;
       ETmacq:real;
       ETracq:real;
       tp:integer;
       DescrP:string[30];
       ts:integer;
       resaI:real;
       resaE:real;
       TotE:real;
       TotI:real;
       End;
Ar_Amb=array[1..MaxAmb]of Amb;
Var Ambienti_D:^Ar_Amb;
{*************************************************************}
Const MaxPar=3000;
Type 
RecPar=Record
       Lato:String[3];
       Tipo:String[9];
       Cod:String[8];
       Num:real;
       Sup:real;
       End;
Ar_RecPar=array[1..MaxPar]of RecPar;
{*************************************************************}
Type 
Recdef=Record
       POrtAp:real;
       Alt:real;
       TiI:real;
       URI:real;
       ITmaria:real;
       ITmacq:real;
       ITracq:real;
       TiE:real;
       URE:real;
       ETmaria:real;
       ETmacq:real;
       ETracq:real;
       End;
Var Default_D:^Recdef;
{*************************************************************}
Type 
Recgen=Record
       Data:string[8];
       Codice:string[20];
       Committente:string[30];
       Commessa:string[30];
       Impianto:string[8];
       Progettista:string[8];
       localita:string[8];
       TestInv:Real;
       TestEst:Real;
       End;
Var Gen_D:^Recgen;
{*************************************************************}
Const MaxMuri=100;
Var NMuri:integer;
Type 
RecMuri=Record
       Cod:string[8];
       Descr:string[20];
       K:real;
       End;
Ar_RecMuri=array[1..MaxMuri]of RecMuri;
Var Muri_D:^Ar_RecMuri;
{*************************************************************}
Const MaxFinestre=100;
Var NFinestre:integer;
Type 
RecFin=Record
       Cod:string[8];
       Descr:string[20];
       SupUn:real;
       K:real;
       AttSol:real;
       End;
Ar_RecFin=array[1..MaxFinestre]of RecFin;
Var Finestre_D:^Ar_RecFin;
{*************************************************************}
Const MaxEspos=100;
Var NEspos:integer;
Type 
RecEsp=Record
       Cod:string[8];
       Descr:string[20];
       Tipo:string[1];
       Incl:real;
       TLcI:real;
       TLcE:real;
       End;
Ar_RecEsp=array[1..MaxEspos]of RecEsp;
Var Espos_D:^Ar_RecEsp;
