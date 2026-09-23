{*************************************************************}
Procedure Leggi_Curve(var Tabella1:TTable;var Tabella3:TTable);
Var i:integer;
Begin
i:=0;
Tabella1.close;
Tabella1.tablename:='Curve.DB';
Tabella1.open;
Tabella1.first;
While not Tabella1.eof do
  Begin
  inc(i);
  with Curve_D^[i] do
    Begin
    Nome:=tabella1.fields[0].asstring;
    Parametro:=tabella1.fields[1].asfloat;
    X:=tabella1.fields[2].asfloat;
    Y:=tabella1.fields[3].asfloat;
    end;
  Tabella1.Next;
  end;
NCurve:=i;
end;
