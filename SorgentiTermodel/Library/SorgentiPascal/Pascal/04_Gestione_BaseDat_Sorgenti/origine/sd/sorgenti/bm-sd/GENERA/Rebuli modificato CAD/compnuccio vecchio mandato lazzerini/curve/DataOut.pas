{*************************************************************}
Procedure Salva_Curve(var Tabella1,Tabella3:TTable);
Var i:integer;
Begin
Crea_Curve(Tabella1);
For i:=1 to NCurve Do
  Begin
  Tabella1.append;
  Tabella1.edit;
  with Curve_D^[i] do
    Begin
    tabella1.fields[0].asstring:=Nome;
    tabella1.fields[1].asfloat:=Parametro;
    tabella1.fields[2].asfloat:=X;
    tabella1.fields[3].asfloat:=Y;
    Tabella1.POst;
    end;
  end;
Tabella1.refresh;
end;
