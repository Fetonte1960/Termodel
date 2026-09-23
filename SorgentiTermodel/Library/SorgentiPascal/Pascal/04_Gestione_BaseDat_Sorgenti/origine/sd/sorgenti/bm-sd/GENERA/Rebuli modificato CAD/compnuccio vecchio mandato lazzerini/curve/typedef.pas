{*************************************************************}
Const MaxCurve=100;
Var NCurve:integer;
Type 
RecCurve=Record
       Nome:string[20];
       Parametro:Real;
       X:Real;
       Y:Real;
       End;
Ar_RecCurve=array[1..MaxCurve]of RecCurve;
Var Curve_D:^Ar_RecCurve;
