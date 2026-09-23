{*************************************************************}
Function O_RecCurve.Nome:STRING;
Begin
result:=Dm1.tt1.fields[0].asstring;
End;
Procedure O_RecCurve.Set_Nome(Par:STRING);
Begin
Dm1.tt1.fields[0].asstring:=Par;
End;
Function O_RecCurve.Parametro:REAL;
Begin
result:=Dm1.tt1.fields[1].asfloat;
End;
Procedure O_RecCurve.Set_Parametro(Par:REAL);
Begin
Dm1.tt1.fields[1].asfloat:=Par;
End;
Function O_RecCurve.X:REAL;
Begin
result:=Dm1.tt1.fields[2].asfloat;
End;
Procedure O_RecCurve.Set_X(Par:REAL);
Begin
Dm1.tt1.fields[2].asfloat:=Par;
End;
Function O_RecCurve.Y:REAL;
Begin
result:=Dm1.tt1.fields[3].asfloat;
End;
Procedure O_RecCurve.Set_Y(Par:REAL);
Begin
Dm1.tt1.fields[3].asfloat:=Par;
End;
