{*************************************************************}
Procedure Iter_Percorri_CalcolaPortata(Nodo:integer);
Var i:Integer;
Begin
With Dati^[nodo] Do
  Begin
  port:=0;
  For i:=1 to Npros do
  Iter_Percorri_CalcolaPortata(Pros[i].ramo);
  End;
End;
Procedure Percorri_CalcolaPortata;
Begin
Iter_Percorri_CalcolaPortata(Primonodo);
End;
