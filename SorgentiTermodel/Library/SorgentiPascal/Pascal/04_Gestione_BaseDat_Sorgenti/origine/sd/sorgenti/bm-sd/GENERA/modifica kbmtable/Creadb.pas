Procedure Creadatabase(nome:string);
Begin
If Nome='generalita' then Crea_generalita(Dm1.TT1);
If Nome='perdite' then Crea_perdite(Dm1.TT1);
If Nome='Diametri' then Crea_Diametri(Dm1.TT1);
If Nome='Tubazioni' then Crea_Tubazioni(Dm1.TT1);
If Nome='PerdConc' then Crea_PerdConc(Dm1.TT1);
If Nome='rami' then Crea_rami(Dm1.TT1);
If Nome='Nodi' then Crea_Nodi(Dm1.TT1);
End;
