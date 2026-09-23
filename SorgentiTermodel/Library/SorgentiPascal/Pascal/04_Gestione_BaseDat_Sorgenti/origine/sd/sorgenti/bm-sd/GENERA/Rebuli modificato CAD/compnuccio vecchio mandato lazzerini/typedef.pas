{*************************************************************}
Const MaxRad=100;
Var NRad:integer;
Type 
RecRad=Record
       Grand:string[8];
       Resa:Real;
       End;
Ar_RecRad=array[1..MaxRad]of RecRad;
Var Rad_D:^Ar_RecRad;
{*************************************************************}
Const MaxFan=100;
Var NFan:integer;
Type 
RecFan=Record
       Grand:string[8];
       EPotsens:real;
       EPotTot:real;
       EPortH2o:real;
       EPerdH2o:real;
       IPortH2o:real;
       IPotsens:real;
       IPerdH2o:real;
       End;
Ar_RecFan=array[1..MaxFan]of RecFan;
Var Fan_D:^Ar_RecFan;
{*************************************************************}
Const MaxVuoto=100;
Var NVuoto:integer;
Type 
RecVuoto=Record
       Faitu:string[50];
       End;
Ar_RecVuoto=array[1..MaxVuoto]of RecVuoto;
Var Vuoto_D:^Ar_RecVuoto;
{*************************************************************}
Type 
RecTerm=Record
       Fab:String[20];
       Modello:String[20];
       Grand:String[20];
       ETbs:real;
       ETbu:real;
       ITbs:real;
       EPsens:real;
       IPsens:real;
       EPTot:real;
       EInH2o:real;
       EDt:real;
       EPort:real;
       EDP:real;
       IInH2o:real;
       IDt:real;
       IPort:real;
       IDP:real;
       End;
Var Terminali_D:^RecTerm;
