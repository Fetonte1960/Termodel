Unit Nuove_f;

Interface

Uses Definiz,genproc;

Function D_E(Lung:real):real;

{-------------------------------------------------------------------------}
Implementation
Function D_E(Lung:real):real;
Var D_e1:real;
begin
if sezione then D_e1:=Ze(Lung)-Ze(0)
else D_e1:=XE(Lung)-Xe(0);
D_e:=D_e1*conf^.AltNum/40000;
end;
end.