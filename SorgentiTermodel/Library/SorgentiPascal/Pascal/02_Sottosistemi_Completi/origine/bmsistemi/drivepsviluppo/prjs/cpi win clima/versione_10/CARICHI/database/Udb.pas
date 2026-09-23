unit UDB;

interface

uses
  SysUtils, Classes, DB, DBTables;

type
  TDM1 = class(TDataModule)
            DataSource1: TDataSource;
            TT1: TTable;
            DataSource2: TDataSource;
            DataSource3: TDataSource;
            TT2: TTable;
            TT3: TTable;
            TT0: TTable;
            DataSource0: TDataSource;
            TCerca: TTable;
            procedure TT2AfterPost(DataSet: TDataSet);
            procedure TT1AfterPost(DataSet: TDataSet);
            procedure TT0NewRecord(DataSet: TDataSet);
            procedure TT1NewRecord(DataSet: TDataSet);
            procedure TT1BeforePost(DataSet: TDataSet);
  private
    { Private declarations }
  public
    { Public declarations }
  end;


var
  DM1: TDM1;
  Tab0:boolean;
  TxtOut:textfile;
  DSZone:Tdatasource;
  TTZone:TTable;

  //Procedure Creadatabase(nome:string);
 {$IFDEF TUBI}

 {$ELSE}
  Procedure Crea_setti(Var Tabella1:ttable);
  Procedure Crea_finestre(Var Tabella1:ttable);
  Procedure Crea_strati(Var Tabella1:ttable);
  Procedure Crea_strutture(Var Tabella1:ttable);
 {$ENDIF} 
  Procedure InitUdb(perc:string);
  Procedure DisposeUdb;
  Procedure SalvaTxt;
  Procedure InitAssociata;
  Procedure NuovoDb;

implementation

uses
  udatalink,libreriagenerale,
  {$Ifdef REBULI}
  UClientform,
  {$Endif}
  dialogs;
  {$R *.dfm}
  {$I MappaDb}
  {$I CreaDb}
  {$I Init}
  {$I Nuovo}

  Procedure InitAssociata;
  begin
    dm1.TT3.close;
    dm1.TT3.MasterSource:=dm1.datasource1;
    dm1.TT3.MasterFields:='Numero';
    dm1.TT3.IndexName:='PerNumero';
    dm1.TT3.Open;
  end;

  Procedure Writecampo(valore:string);
  begin
    writeln(TxtOut,Valore);
  end;

  {$I Savefile}

  Procedure SalvaTxt;
  var datacor:string;
  begin
  {$I Data}
  {$IFDEF TUBI}

  {$ELSE}
    writeCampo('Versione database ' + datacor);
    SaveTxt_strutture(dm1.tt1,dm1.tt3);
    SaveTxt_Finestre(dm1.tt1,dm1.tt3);
    SaveTxt_Confine(dm1.tt1,dm1.tt3);
    SaveTxt_Orari(dm1.tt1,dm1.tt3);
    SaveTxt_Generatori(dm1.tt1,dm1.tt3);
    SaveTxt_Piani(dm1.tt1,dm1.tt3);
    SaveTxt_DescStampe(dm1.tt1,dm1.tt3);
    SaveTxt_Fabbricato(dm1.tt1,dm1.tt3);
    SaveTxt_Zone(dm1.tt1,dm1.tt3);
    SaveTxt_Impianti(dm1.tt1,dm1.tt3);
    // Emanuela 30/01/2003
    SaveTxt_ponti(dm1.tt1,dm1.tt3);
    SaveTxt_Locali(dm1.tt1,dm1.tt3);
    // Emanuela 8/06/2004 mancava il salvataggio di diametriB e tipirete
    {$IF Defined(VERSIONE_12) or Defined(VERSIONE_13)}
    SaveTxt_CarichiInterni(dm1.tt1,dm1.tt3);
    SaveTxt_Perdite_Conc(dm1.tt1,dm1.tt3);
    {$IFEND}
    {$IFDEF CANALI}
      SaveTxt_UPdate(dm1.tt1,dm1.tt3);
    {$ENDIF}
    SaveTxt_TipiRete(dm1.tt1,dm1.tt3);
    SaveTxt_perdite(dm1.tt1,dm1.tt3);
    writeCampo('#ENDFILE#');
  {$ENDIF}
  end;


  Function Valorecampo:string;
  begin
    readln(txtout,result);
  end;

  Procedure InitUdb(perc:string);
  begin
    TTZone:=TTable.Create(Nil);
    TTzone.TableName:='Zone';
    DSZone:=Tdatasource.Create(Nil);
    DsZone.DataSet:=TTzone;

    // Emanuela 2/12/2004 c'era uno \ in più
    if Perc[Length(Perc)] = '\' then Perc := Copy(Perc,1,Length(Perc) -1);

    if not Assigned(DM1) then
       dm1:=TDm1.Create(nil);


    tab0:=false;
    dm1.TT0.close;
    dm1.TT0.DatabaseName:=Perc;
    dm1.TT1.close;
    dm1.TT1.DatabaseName:=Perc;
    dm1.TT2.close;
    dm1.TT2.DatabaseName:=Perc;
    dm1.TT3.close;
    dm1.TT3.DatabaseName:=Perc;
  end;

  Procedure DisposeUdb;
  begin
    if Dm1.TT3 <> nil then
    begin
      Dm1.TT3.MasterFields := '';
      dm1.TT3.IndexName:='';
      dm1.TT3.MasterSource := Nil;
      dm1.TT3.Close;
    end;

    dm1.TT1.Close;
    dm1.TT2.Close;
    {$IFDEF TUBI}
    Dm1.free;
    {$ENDIF}
    dszone.Free;
    ttzone.Free;
    {$IFDEF TUBI}
    Dm1:=nil;
    {$ENDIF}
    dszone:=nil;
    ttzone:=nil;
  end;

  procedure TDM1.TT2AfterPost(DataSet: TDataSet);
  begin
  {$Ifdef REBULI}
  //POsttt2;
  {$Endif}
  end;

  procedure TDM1.TT1AfterPost(DataSet: TDataSet);
  begin
    //
  end;

  procedure TDM1.TT0NewRecord(DataSet: TDataSet);
  begin
    tt0.edit;
    InitDb(copy(tt0.tablename,1,length(tt0.tablename)-3));
  end;

  procedure TDM1.TT1NewRecord(DataSet: TDataSet);
  begin
    tt1.edit;
    if tt1.tablename[length(tt1.tablename)-2]='.' then
       InitDb(copy(tt1.tablename,1,length(tt1.tablename)-3))
    else InitDb(tt1.tablename)
  end;



  procedure TDM1.TT1BeforePost(DataSet: TDataSet);

      Function Table_name:string;
      begin
      result:=Upstring(tt1.Tablename);
      if result<>'' then
      if result[length(result)-2]='.' then result:=copy(result,1,length(result)-3);
      end;

      Function CampoCorrelato(Nometabella:string;NumCampo1,NumCampo2:integer;P_a:char;Cerca:string):real;
      begin
      with Tcerca do
        begin
        Tablename:=Nometabella;
        if P_a='A' then Databasename:=Percorso_archivi
        else Databasename:=Percorso_progetti;
        open;
        first;
        while (not eof) and(cerca<>fields[numcampo1].AsString) do next;
        if cerca=fields[numcampo1].AsString then result:=fields[numcampo2].Value
        else result:=0;
        end;
      end;

  begin
  //{$I conferma}
  //showmessage('beforepost');
  end;
end.
