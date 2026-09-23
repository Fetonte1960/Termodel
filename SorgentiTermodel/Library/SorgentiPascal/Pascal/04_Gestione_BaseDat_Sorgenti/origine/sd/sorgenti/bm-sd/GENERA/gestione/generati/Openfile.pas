{*************************************************************}
Procedure OpenTxt_Campi(var Tabella1:TTable);
Begin
While ReadValoreCampo='#RIGATABASSOCIATA#' Do
  Begin
  Tabella1.append;
  Tabella1.edit;
  Leggi_campo;
  While Buf_Txt<>'#FINECAMPI#' do
    begin;
    tabella1.fields[CampoDB_Campi].asstring:=ValoreCampo;
    Leggi_campo;
    End;
    Tabella1.POst;
  end;
end;
{*************************************************************}
Procedure OpenTXT_Rec(var Tabella1,Tabella3:TTable;DataS1:Tdatasource);
Begin
Tabella3.Close;
Tabella3.Tablename:='Campi.db';
Tabella1.Tablename:='Rec.db';
  Tabella1.open;
Tabella3.close;
Tabella3.tablename:='Campi.DB';
Tabella3.Masterfields:='Numero';
Tabella3.IndexName:='PerNumero';
Tabella3.MasterSource:=DataS1;
Tabella3.open;
While ReadValoreCampo='#RIGATABELLA#' Do
  Begin
  Tabella1.append;
  Tabella1.edit;
  Leggi_campo;
  While Buf_Txt<>'#FINECAMPI#' do
    begin;
    tabella1.fields[CampoDB_Rec].asstring:=ValoreCampo;
    Leggi_campo;
    End;
    Tabella1.POst;
    OpenTxt_Campi(Tabella3);
  end;
tabella3.close;
tabella1.close;
end;
