unit UFormL10;

interface

uses
 Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Math,
 DB, DBTables, Grids, DBGrids, Dialogs, StdCtrls, ExtCtrls, TeEngine, Series,
 TeeProcs, Chart, ComCtrls, Mask, DBCtrls, UtilityGestioneTutor,udbt,
 GestioneGrafico,  LbSpeedButton, ImgList, EditNew, LbStaticText, URicercaDati,
  dbcgrids,miglioramenti;
type
  TFCalcL10 = class(TForm)
    Panel_Bottoni: TPanel;
    B_Chiudi: TLbSpeedButton;
    LB_Tutor: TLbSpeedButton;
    P_Base: TPanel;
    GB_CalcoloAlloggio: TGroupBox;
    Lb_Temp: TLabel;
    LB_C: TLabel;
    RB_VicPres: TRadioButton;
    RB_VicAss: TRadioButton;
    EditN_Temp: TEditN;
    LB_TipoOpera: TLabel;
    ST_Tipoopera: TStaticText;
    PageControl_Ris: TPageControl;
    TabSheet_Risultati: TTabSheet;
    TabSheet_Grafico: TTabSheet;
    GraficoDispersioni: TChart;
    Series1: TBarSeries;
    TSheet_AttEnergEdif: TTabSheet;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    LB_Cat: TLabel;
    Shape1: TShape;
    Image1: TImage;
    Shape2: TShape;
    Shape3: TShape;
    Shape4: TShape;
    Shape5: TShape;
    Shape6: TShape;
    Shape8: TShape;
    Shape7: TShape;
    Shape9: TShape;
    Shape10: TShape;
    Shape11: TShape;
    Shape12: TShape;
    Shape13: TShape;
    Shape14: TShape;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Shape15: TShape;
    Shape16: TShape;
    Shape17: TShape;
    Shape18: TShape;
    Shape19: TShape;
    Shape20: TShape;
    Shape21: TShape;
    LBVal_A: TLabel;
    LBVal_B: TLabel;
    LBVal_C: TLabel;
    LBVal_D: TLabel;
    LBVal_E: TLabel;
    LBVal_F: TLabel;
    LBVal_G: TLabel;
    LBVal_AJ: TLabel;
    LBVal_BJ: TLabel;
    LbVal_CJ: TLabel;
    LBVal_DJ: TLabel;
    LBVal_EJ: TLabel;
    LbVal_FJ: TLabel;
    LbVal_GJ: TLabel;
    Panel1: TPanel;
    Label10: TLabel;
    SB_Calcola: TLbSpeedButton;
    SB_TipoOpera: TLbSpeedButton;
    LB_frase: TLabel;
    Panel_L: TPanel;
    Tab1: TTable;
    DataS1: TDataSource;
    DBGrid_Gen: TDBGrid;
    GB_Dimens: TGroupBox;
    LB_VolumeL: TLabel;
    Lb_m: TLabel;
    LB_SupL: TLabel;
    LB_m2: TLabel;
    LB_SupP: TLabel;
    LB_m22: TLabel;
    Label_SV: TLabel;
    LB_m1: TLabel;
    ST_VolLor: TStaticText;
    ST_SupL: TStaticText;
    ST_SupPav: TStaticText;
    st_SV: TStaticText;
    GroupBox_Disper: TGroupBox;
    LB_Disp: TLabel;
    LB_W1: TLabel;
    LB_DispInf: TLabel;
    LB_W2: TLabel;
    Label32: TLabel;
    LB_wm3: TLabel;
    EN_DispPerCDInf: TStaticText;
    EN_DispVol: TStaticText;
    EN_DispPerCD: TStaticText;
    GB_Veriche192: TGroupBox;
    LB_Info: TLbSpeedButton;
    Label5: TLabel;
    Label_FMJ: TLabel;
    Label_perc: TLabel;
    Label_perc2: TLabel;
    Label6: TLabel;
    Label19: TLabel;
    Label_KJ: TLabel;
    SB_VerPareti: TLbSpeedButton;
    SB_VerFinestre: TLbSpeedButton;
    ST_Calcolato: TStaticText;
    ST_ValoreLimite: TStaticText;
    ST_Feap: TStaticText;
    St_EtaG: TStaticText;
    St_EtaP: TStaticText;
    ST_ValLim: TStaticText;
    ST_FabMJ: TStaticText;
    ST_FabKW: TStaticText;
    EN_RendCalcolato: TStaticText;
    EN_RendMax: TStaticText;
    ST_EtaPC: TStaticText;
    ST_EtaPV: TStaticText;
    St_CD: TStaticText;
    EN_CdCalcolato: TStaticText;
    EN_CDLegge: TStaticText;
    ST_Fen: TStaticText;
    EN_Fen: TStaticText;
    EN_FenLimite: TStaticText;
    Label_Art7: TLabel;
    EN_Articolo7: TStaticText;
    GroupBox_VerCorr: TGroupBox;
    ListBox_VerCor: TListBox;
    LbStaticText2: TLbStaticText;
    ImageList_Oggetti: TImageList;
    LB_SM1: TLbStaticText;
    LB_SM2: TLbStaticText;
    LB_SM3: TLbStaticText;
    LB_SM4: TLbStaticText;
    LB_SM5: TLbStaticText;
    LB_Zona: TLabel;
    ST_ZonaClim: TStaticText;
    LB_Consumi: TLbSpeedButton;
    LB_GradiG: TLabel;
    ST_GradiG: TStaticText;
    P_BarraScorrimento: TPanel;
    ProgressBar_Calc: TProgressBar;
    LB_0: TLabel;
    LB_100: TLabel;
    LB_Calc: TLabel;
    LB_NomeAll: TLabel;
    Timer: TTimer;
    TabSheet1: TTabSheet;
    DBCtrlGrid1: TDBCtrlGrid;
    Panel2: TPanel;
    Panel3: TPanel;
    DBMemo1: TDBMemo;
    procedure SB_CalcolaClick(Sender: TObject);
    procedure LB_TutorClick(Sender: TObject);
    procedure B_ChiudiClick(Sender: TObject);
    procedure LB_InfoClick(Sender: TObject);
    procedure SB_TipoOperaClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure LB_ConsumiClick(Sender: TObject);
    procedure ListBox_VerCorDrawItem(Control: TWinControl; Index: Integer; Rect: TRect; State: TOwnerDrawState);
    procedure RB_VicPresClick(Sender: TObject);
    procedure RB_VicAssClick(Sender: TObject);
    procedure SB_VerParetiClick(Sender: TObject);
    procedure SB_VerFinestreClick(Sender: TObject);
    procedure DBGrid_GenCellClick(Column: TColumn);
    procedure FormActivate(Sender: TObject);
    procedure DBGrid_GenKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormDestroy(Sender: TObject);
    procedure DBGrid_GenDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure TimerTimer(Sender: TObject);
    procedure EditN_TempChange(Sender: TObject);
  private
    { Private declarations }
    Procedure StampaValorePrestazioneEnergEdif;
    Procedure PulisciLabelCertificazione;
    procedure ClearDati192;
    procedure CaricaDatiGeneratore;
  public
    { Public declarations }
    BitInfo, BitWarning, BitError, BitWhite: TBitMap; { Stampa un'immagine nei messaggi }
    Calcolo192: Boolean;
    Procedure CaricaDatiCalcolo;
    procedure ClearDatiMaschera;
    Function  NumeroRiga(Codice: String): Integer;
  end;

var
  FCalcL10: TFCalcL10;

Procedure CalcoloL10(PathFiles, PathRisorse:string);
Procedure CalcoloDisp(PathFiles, PathRisorse, Generatore:Pchar; Riga: Integer);
Procedure CalcoloLegge10(PathFiles, PathRisorse, Generatore:Pchar; Riga: Integer);

implementation

uses Uvariabili, Varcarichi, LibreriaGenerale, Ucompilaform, UFileLog,
     UmainL10, udb, Utireport, UInizializza, {TutorF,} FMessValLim, Risparmio,
     UVerifPareti, UVerifFinestre, FMessValLim3;

{$R *.dfm}

Procedure CalcoloL10(PathFiles, PathRisorse:string);
begin
 dmtutti.T_generatori.filtered:=false;
 Drivecombo := PathRisorse + '\Risorse';
 PercorsoDrive := PathFiles;
 dp := Percorso_progetti;
 da := Percorso_archivi;
 FCalcL10 := TFCalcL10.Create(nil);
 FCalcL10.ShowModal;
end;

Procedure CalcoloDisp(PathFiles, PathRisorse, Generatore:Pchar; Riga: Integer);
begin
 Drivecombo := strpas(PathRisorse) + '\Risorse';
 PercorsoDrive := strpas(PathFiles);
 dp := Percorso_progetti;
 da := Percorso_archivi;
 InitUdb(Dp);
 Inizializza;
 gencor := Riga;
 NomeGeneratore := Generatore;
 TempVicinoAll := 0;
 VicAss := False;
 CalcoloDispers;
 CloseStatistica;
 DisposeUdb;
end;

Procedure CalcoloLegge10(PathFiles, PathRisorse, Generatore:Pchar; Riga: Integer);
begin
 Drivecombo := strpas(PathRisorse) + '\Risorse';
 PercorsoDrive := strpas(PathFiles);
 dp := Percorso_progetti;
 da := Percorso_archivi;
 InitUdb(Dp);
 Inizializza;
 gencor := Riga;
 NomeGeneratore := Generatore;
 TempVicinoAll := 0;
 VicAss := False;
 InitFileLog(PercorsoDrive + '\ErroriL10.Log');
 AzzeraVoci;
 ScriviLog('IN:'+ NomeGeneratore);
 CalcL10;
 if not ErroreGen then
     ScriviLog(CALCOLI_B_F);
 ScriviLog('FN:'+ NomeGeneratore);
 CloseFileLog;
 DisposeUdb;
end;

procedure TFCalcL10.FormCreate(Sender: TObject);
var
  Table, TableST: TTable;
  Campo, Campo1, Campo2, Campo3: TField;
  Opera: String;
begin
 Application.UpdateFormatSettings := False;
{$IFDEF VERSIONE_13}
  LB_Consumi.Visible := False;
  if FileExists(IncludeTrailingPathDelimiter(PercorsoDrive) + 'ErroriL10.log') then
     DeleteFile(IncludeTrailingPathDelimiter(PercorsoDrive) + 'ErroriL10.log');
{$ELSE}
  LB_Consumi.Visible := False;
{$ENDIF}
{ Serve per i messaggi }
 BitInfo     := TBitMap.Create;
 BitWarning  := TBitMap.Create;
{ Serve per i messaggi }
 BitError    := TBitMap.Create;
 BitWhite    := TBitMap.Create;
 ImageList_Oggetti.GetBitMap(0, BitInfo);
 ImageList_Oggetti.GetBitMap(1, BitWarning);
 ImageList_Oggetti.GetBitMap(2, BitError);
 ImageList_Oggetti.GetBitMap(3, BitWhite);
 InitUdb(Dp);
 Inizializza;
 Tab1.Databasename := Percorso_progetti;
 Tab1.TableName := 'Generatori';
 Tab1.Open;
 dbgrid_Gen.datasource:= Datas1;
 dbgrid_Gen.Columns.Clear;
 dbgrid_Gen.Columns.Add;
 dbgrid_Gen.Columns.Add;
 dbgrid_Gen.Columns[0].FieldName := 'Descrizione';
 dbgrid_Gen.Columns[0].Title.Alignment := taCenter;
 dbgrid_Gen.Columns[0].Width := 180;
 dbgrid_Gen.Columns[1].FieldName := 'Verifica';
 dbgrid_Gen.Columns[1].Title.Alignment := taCenter;
 dbgrid_Gen.Columns[1].Alignment := taCenter;
 dbgrid_Gen.Columns[1].Width := 50;
 dbgrid_Gen.Columns[1].Color := $00E1FFFF;

 Table := TTable.Create(Nil);
 Table.DatabaseName := Percorso_progetti;
 Table.TableName := 'fabbricato.db';
 Table.Close;
 Table.Open;
 Campo := Table.Fields.DataSet.FindField('Calc192');
 if Campo <> nil then
    Calcolo192 := CompareStr(UpperCase(Campo.asString), 'SI') = 0
 else Calcolo192 := True;
 Campo2 := Table.Fields.DataSet.FindField('Zona Climatica');
 if Campo2 <> nil then
    ST_ZonaClim.Caption := Campo2.AsString;
 Campo3 := Table.Fields.DataSet.FindField('Gradi Giorno');
 if Campo3 <> nil then
    ST_GradiG.Caption := Campo3.AsString;
 Campo := Table.Fields.DataSet.FindField('Opera');
 Opera := Campo.AsString;
 if Campo <> nil then
 begin
  if (Opera = '') or (UpperCase(Opera) = 'NO') or (UpperCase(Opera) = 'SI') then
  begin
    TableST := TTable.Create(Nil);
    TableST.DatabaseName := Percorso_progetti;
    TableST.TableName := 'DescStampe.db';
    TableST.Close;
    TableST.Open;
    Campo1 := TableST.Fields.DataSet.FindField('TIPORELAZIONE');
    if Campo1 <> nil then
    begin
       if CompareStr(UpperCase(Campo1.AsString),'EDIFICI DI NUOVA COSTRUZIONE') = 0 then
         Opera := 'Edificio di nuova costruzione'
       else
       if CompareStr(UpperCase(Campo1.AsString),'RISTRUTTURAZIONE INTEGRALE DI EDIFICI ESISTENTI') = 0 then
          Opera := 'Ristrutturazione integrale edificio (sup. utile > 100 m²)'
       else
       if CompareStr(UpperCase(Campo1.AsString),'RISTRUTTURAZIONE O MANUTENZIONE DI EDIFICI ESISTENTI') = 0 then
          Opera := 'Ristrutturazione o manutenzione straordinaria edificio'
       else
       if (CompareStr(UpperCase(Campo1.AsString),'NUOVA INSTALLAZIONE DI IMPIANTI') = 0) or
          (CompareStr(UpperCase(Campo1.AsString),'RISTRUTTURAZIONE INTEGRALE DI IMPIANTI TERMICI') = 0)
       then
          Opera := 'Nuova installazione e ristrutturazione integrale di impianti termici'
       else
       if (CompareStr(UpperCase(Campo1.AsString),'SOSTITUZIONE DI GENERATORI DI CALORE') = 0)
       then
          Opera := 'Sostituzione generatore - Verifica analitica'
       else
       begin
         Opera := Campo1.AsString;
       end;
       Table.Edit;
       Table.FieldByName('Opera').AsString := Opera;
       Table.Post;
    end;
    TableST.Close;
    FreeAndNil(TableST);
  end
  else Opera := Campo.asString;
 end;

 if Opera = '' then
 begin
   if Calcolo192 then
      ST_TipoOpera.Caption := 'Edificio di nuova costruzione'
   else ST_TipoOpera.Caption := 'Edificio di nuova costruzione o ristrutturazione edificio';
 end
 else ST_TipoOpera.Caption := Opera;
 if Calcolo192 then
 begin
     Caso := 0;
     ClearDati192;
     if (CompareStr(Opera, 'Edificio di nuova costruzione') = 0) or
        (CompareStr(Opera, 'Ristrutturazione integrale edificio (sup. utile > 100 m²)') = 0) or
        (CompareStr(Opera, 'Demolizione e ricostruzione edificio (sup. utile > 100 m²)') = 0) or
        (CompareStr(Opera, 'Ampliamento edificio (volume ampliato > 20% del totale)')= 0)
     then
     begin
       Caso := 1;
       {
       SB_VerPareti.Visible := True;
       SB_VerFinestre.Visible := True;
       SB_VerPareti.Enabled := False;
       SB_VerFinestre.Enabled := False;
       }
     end
     else
     if (CompareStr(Opera, 'Ristrutturazione o manutenzione straordinaria edificio') = 0)
     then
     begin
       Caso := 2;
       {
       SB_VerPareti.Visible := True;
       SB_VerFinestre.Visible := True;
       SB_VerPareti.Enabled := False;
       SB_VerFinestre.Enabled := False;
       }
     end
     else
     if (CompareStr(Opera, 'Nuova installazione e ristrutturazione integrale di impianti termici') = 0)
     then Caso := 3
     else
     if (CompareStr(Opera, 'Sostituzione generatore - Verifica analitica') = 0)
     then Caso := 4
     else Caso := 5;
 end;
 Table.Close;
 FreeAndNil(Table);

 InitStatistica;  // Procedura per il calcolo delle statistiche dispersioni
 DeleteFile(percorsodrive+'\potinv.int');
 ListBox_VerCor.Clear;
 Tab1.First;
 if Calcolo192 then
 begin
   Caption := 'Calcolo delle Dispersioni Termiche e del Fabbisogno Convenzionale di Energia Primaria';
   EN_CdLegge.Visible   := False;
   EN_FenLimite.Visible := False;
   ST_ValLim.Visible    := True;
   //LB_Info.Visible      := True;
   Label6.Visible       := True;
   Label_Art7.Visible   := False;
   EN_Articolo7.Visible := False;
   //SB_TipoOpera.Visible := True;
   LB_Zona.Visible      := True;
   St_ZonaClim.Visible  := True;
   LB_GradiG.Visible    := True;
   St_GradiG.Visible    := True;
   LB_SM1.Visible := True;
   LB_SM2.Visible := True;
   LB_SM3.Visible := True;
   LB_SM4.Visible := False;
   LB_SM5.Visible := False;
   //SB_VerPareti.Visible := True;
   //SB_VerFinestre.Visible := True;
   // Parte TabSheet Certificazione Energetica
   PulisciLabelCertificazione;
   //PageControl_Ris.Pages[2].TabVisible := True;
 end  
 else
 begin
   Caption := 'Calcolo delle Dispersioni Termiche e del FEN';
   EN_CdLegge.Visible   := True;
   EN_FenLimite.Visible := True;
   ST_ValLim.Visible    := False;
   LB_Info.Visible      := False;
   //Label_Art7.Visible   := True;
   //EN_Articolo7.Visible := True;
   SB_TipoOpera.Visible := False;
   LB_Zona.Visible      := False;
   St_ZonaClim.Visible  := False;
   LB_GradiG.Visible    := False;
   St_GradiG.Visible    := False;
   LB_SM1.Visible := False;
   LB_SM2.Visible := True;
   LB_SM3.Visible := True;
   LB_SM4.Visible := True;
   LB_SM5.Visible := True;
   SB_VerPareti.Visible := False;
   SB_VerFinestre.Visible := False;
   //PageControl_Ris.Pages[2].TabVisible := False;
 end;
 CreaListaIntPot;
 PageControl_Ris.ActivePageIndex := 0;
 Init_miglioramenti;
end;

procedure TFCalcL10.ClearDatiMaschera;
begin
 EN_CDCalcolato.Caption   := '0';
 EN_CDLegge.Caption       := '0';
 EN_FEN.Caption           := '0';
 EN_FENLimite.Caption     := '0';
 EN_DispPerCD.Caption     := '0';
 EN_DispPerCDInf.Caption  := '0';
 EN_DispVol.Caption       := '0';
 EN_RendCalcolato.Caption := '0';
 EN_RendMax.Caption       := '0';
 EN_Articolo7.Caption     := ' ';
 ST_VolLor.Caption        := '0';
 ST_SV.Caption            := '0';
 ST_ValLim.Caption        := '0';
 ST_FabMJ.Caption         := '0';
 ST_FabKW.Caption         := '0';
 ST_SupL.Caption          := '0';
 ST_SupPav.Caption        := '0';
 ST_SupPav.Caption        := '0';
end;

procedure TFCalcL10.ClearDati192;
var
 i: Integer;
begin
{$IFDEF VERSIONE_12}
 DatiV192.VerifPareti    := True;
 DatiV192.VerifiFinestre := True;
 DatiV192.VerificaVetri  := True;
 DatiV192.ValMaxFAEP     := 0
{$ELSE}
 SetLength(DatiV192, Tab1.RecordCount);
 for i:=0 to tab1.RecordCount - 1 do
 begin
  DatiV192[i].VerifPareti    := True;
  DatiV192[i].VerifiFinestre := True;
  DatiV192[i].VerificaVetri  := True;
  DatiV192[i].ValMaxFAEP     := 0
 end;
{$ENDIF}
end;

Procedure Setta_verificheK(Verpos,Positiva:boolean;testover:string;var bottone:TLBSpeedbutton);
Var messaggio:string;
begin
with Fcalcl10 do
if positiva then
  begin
  if verpos then
    begin
    Messaggio := 'I:'+Testover+'  positiva';
    listBox_VerCor.Items.Add(Messaggio);
    end;
  end
else
  begin
  if not verpos then
    begin
    Messaggio := 'W:'+Testover+' negativa ';
    listBox_VerCor.Items.Add(Messaggio);
    end;
  bottone.Color:=clred;
  bottone.Font.Color:=clwhite;
  end;
end;
Procedure Setta_verifiche(Positiva:boolean;testover:string;maggioredi:boolean;Var valore,limite:Tstatictext;Var Maggiore:Tlbstatictext);
Var messaggio,magmin,minmax:string;
begin
valore.Font.Color:=clwhite;
if maggioredi then
  begin
  Maggiore.Caption:='>';
  magmin:=' maggiore ';
  minmax:=' minimo ';
  end
else
  begin
  Maggiore.Caption:='<';
  magmin:=' minore ';
  minmax:=' limite ';
  end;
with Fcalcl10 do
if ((maggioredi) and (str_tofloat(Valore.caption)>=str_tofloat(Limite.caption)))or
   ((not maggioredi) and (str_tofloat(Valore.caption)<=str_tofloat(Limite.caption)))then
  begin
  if positiva then
   begin
   Messaggio := 'I:'+Testover+' è'+magmin+'del valore'+minmax+'ammesso';
   ListBox_VerCor.Items.Add(Messaggio);
   end;
   valore.Color:=clgreen;
   valore.Font.Color:=clwhite;
  end
else
  begin
  if not positiva then
   begin
   Messaggio := 'W:'+Testover+' non è '+magmin+'del valore'+minmax+'ammesso';
   ListBox_VerCor.Items.Add(Messaggio);
   end;
   valore.Color:=clred;
  end
end;
Procedure TFCalcL10.CaricaDatiCalcolo;
Var
  rend1, rend2: Double;
  VerificheL10, VerificaCD, VerificaFen: String[2];
  Messaggio: String;
  Verifiche: Boolean;
begin
{$IFDEF VERSIONE_TRIAL}
 EN_CdCalcolato.Caption   := '0.457';
 EN_CdLegge.Caption       := '0.876';
 EN_Fen.Caption           := '31.42';
 EN_FenLimite.Caption     := '103.18';
 ST_SupL.Caption          := '1161.67';
 ST_SupPav.Caption        := '329';
 ST_VolLor.Caption        := '1418.42';
 EN_DispPerCD.Caption     := '12973';
 EN_DispPerCDInf.Caption  := '14650';
 EN_DispVol.Caption       := '14.47';
 EN_RendCalcolato.Caption := '78.87';
 if Calcolo192 then
    EN_RendMax.Caption    := '79.14'
 else EN_RendMax.Caption  := '69.14';
 ST_SV.Caption            := '0.82';
 ST_ValLim.Caption        := '78.53';
 ST_FabMJ.Caption         := '71755.39';
 ST_FabKW.Caption         := '60.63';
 ST_EtaPc.Caption         := '91.04';
 ST_EtaPv.Caption         := '81.14';
 VerificheL10             := 'Si';
 VerificaCD               := 'Si';
 VerificaFEN              := 'Si';
 EN_Articolo7.Caption:= 'E'' richiesta installazione di un dispositivo di regolazione';
{$ELSE}
 Verifiche := True;
{$IFDEF VERSIONE_12}
 Tab1.Open;
 Tab1.First;
 Messaggio := '';
 while (not Tab1.Eof) and (CompareStr(Tab1.FieldByName('Codice').asString, NomeGeneratore) <> 0) do Tab1.Next;
{$ENDIF} 
 ST_SupL.Caption          := FloatToStr(Tab1.Fields[26].AsFloat);
 ST_SupPav.Caption        := FloatToStr(Tab1.Fields[57].AsFloat);
 ST_VolLor.Caption        := FloatToStr(Tab1.Fields[25].AsFloat);
 EN_DispPerCD.Caption     := FloatToStr(Tab1.Fields[24].AsFloat);
 EN_DispPerCDInf.Caption  := FloatToStr(Tab1.Fields[43].AsFloat);
 EN_DispVol.Caption       := FloatToStr(Tab1.Fields[44].AsFloat);
 EN_CdCalcolato.Caption   := FloatToStr(Tab1.Fields[31].AsFloat);
 EN_CdLegge.Caption       := FloatToStr(Tab1.Fields[30].AsFloat);
 EN_Fen.Caption           := FloatToStr(Tab1.Fields[34].AsFloat);
 EN_FenLimite.Caption     := FloatToStr(Tab1.Fields[41].AsFloat);
 Rend1                    := Tab1.Fields[40].AsFloat;
 EN_RendCalcolato.Caption := FloatToStr(Rend1);
 Rend2                    := Tab1.Fields[45].AsFloat;
 EN_RendMax.Caption       := FloatToStr(Rend2);
 EN_Articolo7.Caption     := Tab1.Fields[46].AsString;
 VerificheL10             := Tab1.Fields[42].AsString;
 VerificaCD               := Tab1.Fields[47].AsString;
 VerificaFEN              := Tab1.Fields[48].AsString;
 ST_SV.Caption            := FloatToStr(Tab1.Fields[27].AsFloat);
 ST_ValLim.Caption        := FloatToStr(Tab1.Fields[58].AsFloat);
 ST_FabMJ.Caption         := FloatToStr(Tab1.Fields[55].AsFloat);
 ST_FabKW.Caption         := FloatToStr(Tab1.Fields[59].AsFloat);
 ST_EtaPc.Caption         := FloatToStr(Tab1.Fields[61].AsFloat);
 ST_EtaPv.Caption         := FloatToStr(Tab1.Fields[62].AsFloat);
 //inserimento delle informazioni sulle verifiche
 if Tab1.Fields[43].AsFloat > Tab1.Fields[7].AsFloat then
 begin
   Messaggio := 'W:LA POTENZA NOMINALE DEL GENERATORE E'' INFERIORE ALLE DISPERSIONI CALCOLATE';
   ListBox_VerCor.Items.Add(Messaggio);
 end;
{$ENDIF}
 //Verifica CD
 if Not Calcolo192 then
 begin
   if VerificaCD = 'Si' then
   begin
     Verifiche := True;
     EN_CdCalcolato.Font.Color := clTeal;
     EN_CdLegge.Font.Color     := clTeal;
     Messaggio := 'I:CD VERIFICATO';
     ListBox_VerCor.Items.Add(Messaggio);
     LB_SM4.Font.Color := clTeal;
     LB_SM4.Caption := '<';
   end
   else
   begin
     EN_CdCalcolato.Font.Color := clRed;
     EN_CdLegge.Font.Color     := clRed;
     Messaggio := 'W:CD NON VERIFICATO';
     ListBox_VerCor.Items.Add(Messaggio);
     Messaggio := 'P:     Il valore del Cd non è verificato, modificare i valori delle trasmittanze k';
     ListBox_VerCor.Items.Add(Messaggio);
     Messaggio := 'P:     delle strutture.';
     ListBox_VerCor.Items.Add(Messaggio);
     LB_SM4.Font.Color := clRed;
     LB_SM4.Caption := '>';
   end;              
   //Verifica FEN
   if VerificaFEN = 'Si' then
   begin
     Verifiche := True;
     EN_Fen.Font.Color       := clTeal;
     EN_FenLimite.Font.Color := clTeal;
     Messaggio := 'I:FEN VERIFICATO';
     ListBox_VerCor.Items.Add(Messaggio);
     LB_SM5.Font.Color := clTeal;
     LB_SM5.Caption := '<';
   end
   else
   begin
     EN_Fen.Font.Color       := clRed;
     EN_FenLimite.Font.Color := clRed;
     Messaggio := 'W:FEN NON VERIFICATO';
     ListBox_VerCor.Items.Add(Messaggio);
     Messaggio := 'P:     Il valore del FEN non è Verificato. Controllare';
     ListBox_VerCor.Items.Add(Messaggio);
     Messaggio := 'P:     - il numero di ricambi dovuti sia alla ventilazione naturale (Infiltrazioni) che all''aria trattata (Ventilazione meccanica),';
     ListBox_VerCor.Items.Add(Messaggio);
     Messaggio := 'P:       nella maschera Zone Termiche. Se le quantità assumono valori troppo alti diminuire questi valori;';
     ListBox_VerCor.Items.Add(Messaggio);
     Messaggio := 'P:     - il numero di ricambi d''aria per persona (Trattata) o il numero di ricambi imposto (calcolo con DPR 412 art. 8 comma ';
     ListBox_VerCor.Items.Add(Messaggio);
     Messaggio := 'P:       9) nella maschera Zone Termiche (se attivato). Questo dato incrementa il valore del Fen limite;';
     ListBox_VerCor.Items.Add(Messaggio);
     Messaggio := 'P:     - il fattore di Shading dello schermo dei serramenti vetrati effettuare la selezione in modo da avere un';
     ListBox_VerCor.Items.Add(Messaggio);
     Messaggio := 'P:       valore abbastanza vicino all''unità.';
     ListBox_VerCor.Items.Add(Messaggio);
     LB_SM5.Font.Color := clRed;
     LB_SM5.Caption := '>';
   end;
   //Verifica RENDIMENTI
   if (CompareValue(Rend1, Rend2, 0) > 0) or SameValue(Rend1, Rend2) then
   begin
      Verifiche := True;
      EN_RendCalcolato.Font.Color := clTeal;
      EN_RendMax.Font.Color := clTeal;
      Messaggio := 'I:RENDIMENTI GLOBALI VERIFICATI';
      ListBox_VerCor.Items.Add(Messaggio);
      LB_SM2.Font.Color := clTeal;
      LB_SM2.Caption := '>';
   end
   else
   begin
      Verifiche := False;
      EN_RendCalcolato.Font.Color := clRed;
      EN_RendMax.Font.Color       := clRed;
      Messaggio := 'W:RENDIMENTI GLOBALI NON VERIFICATI';
      ListBox_VerCor.Items.Add(Messaggio);
      Messaggio := 'P:     I valore dei rendimenti non sono verificati. Controllare:';
      ListBox_VerCor.Items.Add(Messaggio);
      Messaggio := 'P:     - nel sistema di regolazione di aver inserito la combinazione che';
      Messaggio := Messaggio + ' dia un valore di rendimento alto (vedi norma';
      ListBox_VerCor.Items.Add(Messaggio);
      Messaggio := 'P:       UNI 10348 Prospetto II);';
      ListBox_VerCor.Items.Add(Messaggio);
      Messaggio := 'P:     - modificare in Dati Impianto - box Dati per la verifica di Legge 10 i ';
      Messaggio := Messaggio + ' seguenti campi: Sistema di regolazione e';
      ListBox_VerCor.Items.Add(Messaggio);
      Messaggio := 'P:       Tipologia di prodotto;';
      ListBox_VerCor.Items.Add(Messaggio);
      Messaggio := 'P:     - che il numero di ore inserite nei due campi relativi al periodo di attenuazione';
      Messaggio := Messaggio + 'o spegnimento dell''impianto di';
      ListBox_VerCor.Items.Add(Messaggio);
      Messaggio := 'P:       riscaldamento (espresso in ore) corrisponda al periodo di spegnimento giornaliero e che i giorni settimanali di';
      ListBox_VerCor.Items.Add(Messaggio);
      Messaggio := 'P:       attenuazione o spegnimento inseriti corrispondano al numero di giorni in cui l’impianto di riscaldamento è spento;';
      ListBox_VerCor.Items.Add(Messaggio);
      Messaggio := 'P:     - la potenza del generatore (Potenza nominale utile del sistema di produzione) sia';
      Messaggio := Messaggio + ' superiore o comunque vicino al';
      ListBox_VerCor.Items.Add(Messaggio);
      Messaggio := 'P:       valore delle dispersioni termiche calcolate da programma;';
      ListBox_VerCor.Items.Add(Messaggio);
      Messaggio := 'P:     - che il valore delle perdite di distribuzione non sia troppo grande.';
      ListBox_VerCor.Items.Add(Messaggio);
      LB_SM2.Font.Color := clRed;
      LB_SM2.Caption := '<';
   end;
   if StrToFloat(ST_EtaPC.Caption) < StrToFloat(ST_EtaPV.Caption) then
       LB_SM3.Caption := '<'
   else LB_SM3.Caption := '>';
 end;
 if Calcolo192 then
 begin
       case Caso of
         1:begin
             // Verifica Fabbisogno di energia primaria
             //Rifatto da diego
             if CompareStr(UpperCase(VerificheL10), 'SI') = 0 then
               begin
               verifiche:=true;
               Messaggio := 'I:LE VERIFICHE PREVISTE PER IL TIPO DI OPERA SONO SODDISFATTE IN BASE A QUANTO';
               ListBox_VerCor.Items.Add(Messaggio);
               end
             else
               begin
               verifiche:=false;
               Messaggio := 'W:LE VERIFICHE PREVISTE PER IL TIPO DI OPERA NON SONO SODDISFATTE IN BASE A QUANTO';
               ListBox_VerCor.Items.Add(Messaggio);
               end;
             //Ep
             Setta_verifiche(verifiche,st_feap.caption,False,ST_FABKW,ST_Vallim,LB_sm1);
             //ETag
             Setta_verifiche(verifiche,St_EtaG.caption,true,EN_RendCalcolato,EN_RendMax,LB_sm2);
             //ETaP
             Setta_verifiche(verifiche,St_EtaP.caption,true,ST_EtaPC,ST_EtaPV,LB_sm3);
             sb_verpareti.Color:=clgreen;
             sb_verfinestre.Color:=clgreen;
             //pareti,finestre vetri
             Setta_verificheK(verifiche,DatiV192[Gencor-1].VerifPareti,'Verifica isolamento pareti',sb_verpareti);
             Setta_verificheK(verifiche,DatiV192[Gencor-1].VerifiFinestre,'Verifica isolamento vetri',sb_verfinestre);
             Setta_verificheK(verifiche,DatiV192[Gencor-1].Verificavetri,'Verifica isolamento finestre',sb_verfinestre);
             (*
             if CompareStr(UpperCase(VerificheL10), 'SI') = 0 then
             begin
                Verifiche := True;
                SB_VerPareti.Enabled := False;
                SB_VerFinestre.Enabled := False;
                SB_VerPareti.Font.Color := clTeal;
                SB_VerFinestre.Font.Color := clTeal;
               {$IFDEF VERSIONE_12}
                if SameValue(StrToFloat(St_FabKW.Caption), Descgen1^[gencor].ValLim, 0.005) then
               {$ELSE}
                if SameValue(StrToFloat(St_FabKW.Caption), Descgen1^[gencor].ValLim, 0.005) then
               {$ENDIF}
                begin
                  //ST_FabKW.Visible := False;
                  LB_SM1.Visible := False;
                  ST_ValLim.Font.Color := clBlack;
                  EN_RendCalcolato.Font.Color := clTeal;
                  EN_RendMax.Font.Color := clTeal;
                  if (CompareValue(Rend1, Rend2, 0) > 0) or SameValue(Rend1, Rend2) then
                     LB_SM2.Caption := '>'
                  else LB_SM2.Caption := '<';
                  LB_SM2.Font.Color := clTeal;
                  Messaggio := 'I:LE VERIFICHE PREVISTE PER IL TIPO DI OPERA SONO SODDISFATTE IN BASE A QUANTO';
                  ListBox_VerCor.Items.Add(Messaggio);
                  Messaggio := 'G:   PREVISTO DAL D.LGS. 192/int.311';
                  ListBox_VerCor.Items.Add(Messaggio);
                  Messaggio := 'G:   - Il Rendimento Globale Medio Stagionale risulta essere maggiore o uguale di';
                  ListBox_VerCor.Items.Add(Messaggio);
                  Messaggio := 'G:     quello limite [etag >= (75+3 log Pn) %] (Punto 5, allegato C)';
                  ListBox_VerCor.Items.Add(Messaggio);
                  Messaggio := 'G:   - Tutte le pareti e le finestre comprensive dei vetri soddisfano i limiti sulle trasmittanze ';
                  ListBox_VerCor.Items.Add(Messaggio);
                  Messaggio := 'G:     secondo le tabelle 2, 3, 4a e 4b dell''allegato C del D.lgs. 192/05/int.311';
                  ListBox_VerCor.Items.Add(Messaggio);
                  Messaggio := 'G:   - Il valore del EP di progetto rientra nei limiti imposti dalla tabella 1 dell''allegato C del ';
                  ListBox_VerCor.Items.Add(Messaggio);
                  Messaggio := 'G:     D.lgs. 192/05/int.311 (viene assegnato il valore limite massimo per quella categoria).';
                  ListBox_VerCor.Items.Add(Messaggio);
                end
                else
                begin
                  LB_SM1.Visible := True;
                  LB_SM1.Caption := '<';
                  LB_SM1.Font.Color := clTeal;
                  ST_FabKW.Font.Color := clTeal;
                  ST_ValLim.Font.Color := clTeal;
                  EN_RendCalcolato.Font.Color := clBlack;
                  EN_RendMax.Font.Color := clBlack;
                  if (CompareValue(Rend1, Rend2, 0) > 0) or SameValue(Rend1, Rend2) then
                     LB_SM2.Caption := '>'
                  else LB_SM2.Caption := '<';
                  LB_SM2.Font.Color := clBlack;
                  Messaggio := 'I:LE VERIFICHE PREVISTE PER IL TIPO DI OPERA SONO SODDISFATTE IN BASE A QUANTO';
                  ListBox_VerCor.Items.Add(Messaggio);
                  Messaggio := 'G:   PREVISTO DAL D.LGS. 192/int.311:';
                  ListBox_VerCor.Items.Add(Messaggio);
                  Messaggio := 'G:   - Il valore del EP rientra nei limiti imposti dalla tabella 1 dell''allegato C del D.lgs. 192/05/int.311';
                  ListBox_VerCor.Items.Add(Messaggio);
                end;
             end
             else
             begin
                Verifiche := False;
                if StrToFloat(ST_FabKW.Caption) <= StrToFloat(ST_ValLim.Caption) then
                begin
                  ST_FabKW.Font.Color := clTeal;
                  ST_ValLim.Font.Color := clTeal;
                  LB_SM1.Visible := True;
                  EN_RendCalcolato.Font.Color := clBlack;
                  EN_RendMax.Font.Color := clBlack;
                  if (CompareValue(Rend1, Rend2, 0) > 0) or SameValue(Rend1, Rend2) then
                      LB_SM2.Caption := '>'
                  else LB_SM2.Caption := '<';
                  LB_SM2.Font.Color := clBlack;
                  SB_VerPareti.Enabled := True;
                  SB_VerFinestre.Enabled := True;
                  LB_SM1.Font.Color := clTeal;
                  LB_SM1.Caption := '<';
                 {$IFDEF VERSIONE_12}
                  if DatiV192.VerifPareti then
                 {$ELSE}
                  if DatiV192[Gencor-1].VerifPareti then
                 {$ENDIF}
                     SB_VerPareti.Font.Color := clTeal
                  else SB_VerPareti.Font.Color := clRed;
                 {$IFDEF VERSIONE_12}
                  if DatiV192.VerifiFinestre and DatiV192.VerificaVetri then
                 {$ELSE}
                  if DatiV192[Gencor-1].VerifiFinestre and DatiV192[Gencor-1].VerificaVetri then
                 {$ENDIF}
                     SB_VerFinestre.Font.Color := clTeal
                  else SB_VerFinestre.Font.Color := clRed;
                  Messaggio := 'W:LE VERIFICHE PREVISTE PER IL TIPO DI OPERA NON SONO SODDISFATTE IN BASE A QUANTO';
                  ListBox_VerCor.Items.Add(Messaggio);
                  Messaggio := 'P:   PREVISTO DAL D.LGS. 192/int.311';
                  ListBox_VerCor.Items.Add(Messaggio);
                  Messaggio := 'P:   Controllare che le pareti, le finestre e i vetri rientrino nei valori limite previsti dal D.LGS. 192/int.311';
                  ListBox_VerCor.Items.Add(Messaggio);
                end
                else
                begin
                  ST_FabKW.Font.Color := clRed;
                  ST_ValLim.Font.Color := clRed;
                  LB_SM1.Font.Color := clRed;
                  LB_SM1.Visible := True;
                  LB_SM1.Caption := '>';
                  SB_VerPareti.Enabled := True;
                  SB_VerFinestre.Enabled := True;
                 {$IFDEF VERSIONE_12}
                  if DatiV192.VerifPareti then
                 {$ELSE}
                  if DatiV192[Gencor-1].VerifPareti then
                 {$ENDIF}
                     SB_VerPareti.Font.Color := clTeal
                  else SB_VerPareti.Font.Color := clRed;
                 {$IFDEF VERSIONE_12}
                  if DatiV192.VerifiFinestre or DatiV192.VerificaVetri then
                 {$ELSE}
                  if DatiV192[Gencor-1].VerifiFinestre or DatiV192[Gencor-1].VerificaVetri then
                 {$ENDIF}
                     SB_VerFinestre.Font.Color := clTeal
                  else SB_VerFinestre.Font.Color := clRed;
                  Messaggio := 'W:LE VERIFICHE PREVISTE PER IL TIPO DI OPERA NON SONO SODDISFATTE IN BASE A QUANTO';
                  ListBox_VerCor.Items.Add(Messaggio);
                  Messaggio := 'P:   PREVISTO DAL D.LGS. 192/int.311';
                  ListBox_VerCor.Items.Add(Messaggio);
                  Messaggio := 'P:   Controllare che le pareti, le finestre e i vetri rientrino nei valori limite previsti ';
                  Messaggio := Messaggio + 'dal D.LGS. 192/int.311';
                  ListBox_VerCor.Items.Add(Messaggio);
                  if (CompareValue(Rend1, Rend2, 0) > 0) or SameValue(Rend1, Rend2) then
                  begin
                    LB_SM2.Caption := '>';
                    LB_SM2.Font.Color := clTeal;
                    EN_RendCalcolato.Font.Color := clTeal;
                    EN_RendMax.Font.Color := clTeal;
                  end
                  else
                  begin
                    LB_SM2.Caption := '<';
                    LB_SM2.Font.Color := clRed;
                    EN_RendCalcolato.Font.Color := clRed;
                    EN_RendMax.Font.Color := clRed;
                    Messaggio := 'P:   Per i valore dei rendimenti non verificati. Controllare:';
                    ListBox_VerCor.Items.Add(Messaggio);
                    Messaggio := 'P:   - nel sistema di regolazione di aver inserito la combinazione che';
                    Messaggio := Messaggio + ' dia un valore di rendimento alto (vedi norma';
                    ListBox_VerCor.Items.Add(Messaggio);
                    Messaggio := 'P:     UNI 10348 Prospetto II);';
                    ListBox_VerCor.Items.Add(Messaggio);
                    Messaggio := 'P:   - modificare in Dati Impianto - box Dati per la verifica di Legge 10 i ';
                    Messaggio := Messaggio + ' seguenti campi: Sistema di regolazione e';
                    ListBox_VerCor.Items.Add(Messaggio);
                    Messaggio := 'P:     Tipologia di prodotto;';
                    ListBox_VerCor.Items.Add(Messaggio);
                    Messaggio := 'P:   - che il numero di ore inserite nei due campi relativi al periodo di attenuazione';
                    ListBox_VerCor.Items.Add(Messaggio);
                    Messaggio := 'P:     o spegnimento dell''impianto di riscaldamento (espresso in ore) corrisponda';
                    ListBox_VerCor.Items.Add(Messaggio);
                    Messaggio := 'P:     al periodo di spegnimento giornaliero e che i giorni settimanali di attenuazione o';
                    ListBox_VerCor.Items.Add(Messaggio);
                    Messaggio := 'P:     spegnimento inseriti corrispondano al numero di giorni in cui l’impianto di riscaldamento';
                    ListBox_VerCor.Items.Add(Messaggio);
                    Messaggio := 'P:     è spento;';
                    ListBox_VerCor.Items.Add(Messaggio);
                    Messaggio := 'P:   - la potenza del generatore (Potenza nominale utile del sistema di produzione) sia';
                    ListBox_VerCor.Items.Add(Messaggio);
                    Messaggio := 'P:     superiore o comunque vicino al valore delle dispersioni termiche calcolate da programma;';
                    ListBox_VerCor.Items.Add(Messaggio);
                    Messaggio := 'P:   - che il valore delle perdite di distribuzione non sia troppo grande.';
                    ListBox_VerCor.Items.Add(Messaggio);
                  end;
                end;
             end;
             if StrToFloat(ST_EtaPC.Caption) < StrToFloat(ST_EtaPV.Caption) then
                 LB_SM3.Caption := '<'
             else LB_SM3.Caption := '>';  *)
           end;
         2:begin
             ST_FabKW.Font.Color := clBlack;
             ST_ValLim.Font.Color := clBlack;
             EN_RendCalcolato.Font.Color := clBlack;
             EN_RendMax.Font.Color := clBlack;
             if StrToFloat(ST_FabKW.Caption) <= StrToFloat(ST_ValLim.Caption) then
                   LB_SM1.Caption := '<'
                else LB_SM1.Caption := '>';
             if (CompareValue(Rend1, Rend2, 0) > 0) or SameValue(Rend1, Rend2) then
                    LB_SM2.Caption := '>'
                else
                    LB_SM2.Caption := '<';
             if StrToFloat(ST_EtaPC.Caption) < StrToFloat(ST_EtaPV.Caption) then
                 LB_SM3.Caption := '<'
             else LB_SM3.Caption := '>';
             SB_VerPareti.Enabled := True;
             SB_VerFinestre.Enabled := True;
             if CompareStr(UpperCase(VerificheL10), 'SI') = 0 then
             begin
                Verifiche := True;
                SB_VerPareti.Font.Color := clTeal;
                SB_VerFinestre.Font.Color := clTeal;
                Messaggio := 'I:LE VERIFICHE PREVISTE PER IL TIPO DI OPERA SONO SODDISFATTE IN BASE A QUANTO';
                ListBox_VerCor.Items.Add(Messaggio);
                Messaggio := 'G:   PREVISTO DAL D.LGS. 192/int.311';
                ListBox_VerCor.Items.Add(Messaggio);
                Messaggio := 'G:   Tutte le pareti e le finestre comprensive dei vetri soddisfano i limiti ';
                ListBox_VerCor.Items.Add(Messaggio);
                Messaggio := 'G:   sulle trasmittanze secondo le tabelle 2, 3, 4a e 4b dell''allegato C del D.lgs. 192/05./int.311';
                ListBox_VerCor.Items.Add(Messaggio);
             end
             else
             begin
                Verifiche := False;
               {$IFDEF VERSIONE_12}
                if DatiV192.VerifPareti then
               {$ELSE}
                if DatiV192[Gencor-1].VerifPareti then
               {$ENDIF}
                   SB_VerPareti.Font.Color := clTeal
                else SB_VerPareti.Font.Color := clRed;
               {$IFDEF VERSIONE_12}
                if DatiV192.VerifiFinestre or DatiV192.VerificaVetri then
               {$ELSE}
                if DatiV192[Gencor-1].VerifiFinestre or DatiV192[Gencor-1].VerificaVetri then
               {$ENDIF}
                   SB_VerFinestre.Font.Color := clTeal
                else SB_VerFinestre.Font.Color := clRed;
                Messaggio := 'W:LE VERIFICHE PREVISTE PER IL TIPO DI OPERA NON SONO SODDISFATTE IN BASE A QUANTO';
                ListBox_VerCor.Items.Add(Messaggio);
                Messaggio := 'P:   PREVISTO DAL D.LGS. 192/int.311';
                ListBox_VerCor.Items.Add(Messaggio);
                Messaggio := 'P:   Controllare che le pareti, le finestre e i vetri rientrino nei valori limite previsti dal D.LGS. 192/int.311';
                ListBox_VerCor.Items.Add(Messaggio);
             end;
           end;
         3:begin
             EN_RendCalcolato.Font.Color := clBlack;
             EN_RendMax.Font.Color := clBlack;
             if (CompareValue(Rend1, Rend2, 0) > 0) or SameValue(Rend1, Rend2) then
                LB_SM2.Caption := '>'
             else
                LB_SM2.Caption := '<';
             if StrToFloat(ST_EtaPC.Caption) < StrToFloat(ST_EtaPV.Caption) then
                 LB_SM3.Caption := '<'
             else LB_SM3.Caption := '>';
             SB_VerPareti.Enabled := False;
             SB_VerFinestre.Enabled := False;
             if CompareStr(UpperCase(VerificheL10), 'SI') = 0 then
             begin
                Verifiche := True;
                ST_FabKW.Font.Color := clTeal;
                ST_ValLim.Font.Color := clTeal;
                LB_SM1.Visible := True;
                LB_SM1.Caption := '<';
                Messaggio := 'I:LE VERIFICHE PREVISTE PER IL TIPO DI OPERA SONO SODDISFATTE IN BASE A QUANTO';
                ListBox_VerCor.Items.Add(Messaggio);
                Messaggio := 'G:   PREVISTO DAL D.LGS. 192/int.311';
                ListBox_VerCor.Items.Add(Messaggio);
                Messaggio := 'G:   Il valore del EP di progetto rientra nei limiti imposti dalla tabella 1 dell''allegato C del';
                ListBox_VerCor.Items.Add(Messaggio);
                Messaggio := 'G:   D.lgs. 192/05/int.311 aumentato del 50%';
                ListBox_VerCor.Items.Add(Messaggio);
             end
             else
             begin
                Verifiche := False;
                if StrToFloat(ST_FabKW.Caption) <= StrToFloat(ST_ValLim.Caption) then
                begin
                  ST_FabKW.Font.Color := clTeal;
                  ST_ValLim.Font.Color := clTeal;
                  LB_SM1.Font.Color   := ClTeal;
                  LB_SM1.Caption := '<';
                end
                else
                begin
                  ST_FabKW.Font.Color := clRed;
                  ST_ValLim.Font.Color := clRed;
                  LB_SM1.Font.Color   := ClRed;
                  LB_SM1.Caption := '>';
                end;
                Messaggio := 'W:LE VERIFICHE PREVISTE PER IL TIPO DI OPERA NON SONO SODDISFATTE IN BASE A QUANTO';
                ListBox_VerCor.Items.Add(Messaggio);
                Messaggio := 'P:   PREVISTO DAL D.LGS. 192/int.311';
                ListBox_VerCor.Items.Add(Messaggio);
                Messaggio := 'P:   Controllare il valore del EP';
                ListBox_VerCor.Items.Add(Messaggio);
             end;
           end;
         4:begin
             EN_RendCalcolato.Font.Color := clBlack;
             EN_RendMax.Font.Color := clBlack;
             if (CompareValue(Rend1, Rend2, 0) > 0) or SameValue(Rend1, Rend2) then
                LB_SM2.Caption := '>'
             else
                LB_SM2.Caption := '<';
             SB_VerPareti.Enabled := False;
             SB_VerFinestre.Enabled := False;
             if CompareStr(UpperCase(VerificheL10), 'SI') = 0 then
             begin
               Verifiche := True;
               ST_FabKW.Font.Color := clTeal;
               ST_ValLim.Font.Color := clTeal;
               LB_SM1.Font.Color   := ClTeal;
               LB_SM1.Caption := '<';
               ST_EtaPC.Font.Color := clTeal;
               ST_EtaPV.Font.Color := clTeal;
               LB_SM3.Font.Color   := clTeal;
               LB_SM3.Caption := '>';
               Messaggio := 'I:LE VERIFICHE PREVISTE PER IL TIPO DI OPERA SONO SODDISFATTE IN BASE A QUANTO';
               ListBox_VerCor.Items.Add(Messaggio);
               Messaggio := 'G:   PREVISTO DAL D.LGS. 192/int.311';
               ListBox_VerCor.Items.Add(Messaggio);
               Messaggio := 'G:   - l valore del EP rientra nei limiti imposti dalla tabella 1 dell''allegato C del D.lgs. 192/05/int.311';
               ListBox_VerCor.Items.Add(Messaggio);
               Messaggio := 'G:   - Il Rendimento di Produzione Medio Stagionale risulta essere maggiore o uguale di quello';
               ListBox_VerCor.Items.Add(Messaggio);
               Messaggio := 'G:     limite [etap >= (77+3 log Pn) %] (DPR 412/93, art. 5, comma3).';
               ListBox_VerCor.Items.Add(Messaggio);
             end
             else
             begin
                Verifiche := False;
                Messaggio := 'W:LE VERIFICHE PREVISTE PER IL TIPO DI OPERA NON SONO SODDISFATTE IN BASE A QUANTO';
                ListBox_VerCor.Items.Add(Messaggio);
                Messaggio := 'P:   PREVISTO DAL D.LGS. 192/int.311';
                ListBox_VerCor.Items.Add(Messaggio);
                if StrToFloat(ST_FabKW.Caption) <= StrToFloat(ST_ValLim.Caption) then
                begin
                  ST_FabKW.Font.Color  := clTeal;
                  ST_ValLim.Font.Color := clTeal;
                  LB_SM1.Font.Color    := ClTeal;
                  LB_SM1.Caption := '<';
                end
                else
                begin
                  ST_FabKW.Font.Color  := clRed;
                  ST_ValLim.Font.Color := clRed;
                  LB_SM1.Font.Color    := ClRed;
                  LB_SM1.Caption := '>';
                  Messaggio := 'P:   Controllare il valore del EP';
                  ListBox_VerCor.Items.Add(Messaggio);
                end;
                 if StrToFloat(ST_EtaPC.Caption) < StrToFloat(ST_EtaPV.Caption) then
                 begin
                   ST_EtaPC.Font.Color := clRed;
                   ST_EtaPV.Font.Color := clRed;
                   LB_SM3.Font.Color   := clRed;
                   LB_SM3.Caption := '<';
                   Messaggio := 'P:   Controllare che il rendimento di produzione medio stagionale sia maggiore del valore limite';
                   ListBox_VerCor.Items.Add(Messaggio);
                 end
                 else
                 begin
                   ST_EtaPC.Font.Color := clTeal;
                   ST_EtaPV.Font.Color := clTeal;
                   LB_SM3.Font.Color   := clTeal;
                   LB_SM3.Caption := '>';
                 end;
             end;
           end;
         5:begin
             //da fare
           end;
       end;
 end;
 {
 If Verifiche then
 begin
   Messaggio := 'I:LE VERIFICHE DI LEGGE SONO SODDISFATTE';
   ListBox_VerCor.Items.Add(Messaggio);
 end
 else
 begin
   Messaggio := 'W:VERIFICHE DI LEGGE NON SODDISFATTE';
   ListBox_VerCor.Items.Add(Messaggio);
 end;
}
 if Calcolo192 then
    StampaValorePrestazioneEnergEdif;
end;

function TFCalcL10.NumeroRiga(Codice: String): Integer;
var
  i: Integer;
begin
  Result := 0;
  i := 0;
  Tab1.First;
  While not Tab1.Eof do
  begin
    inc(i);
    if Tab1.FieldByName('Codice').AsString = Codice then
    begin
      Result := i;
      exit;
    end;
    Tab1.Next;
  end;
end;


procedure TFCalcL10.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  CreaFileIntPot(percorsodrive+'\potinv.int');
  Tab1.Edit;
  Tab1.Post;
  Tab1.Close;
  Tab1.Active := False;
  CloseStatistica;
 {$IFDEF VERSIONE_13}
  DeleteFile(PercorsoDrive + '\ErroriL10.log');
 {$ENDIF}
  Disponi;
  DisposeUdb;
  Action := caFree;
end;

procedure TFCalcL10.SB_CalcolaClick(Sender: TObject);
var
  Mess: String;
begin
  gencor := NumeroRiga(Tab1.FieldByName('Codice').asString);
  NomeGeneratore := Tab1.FieldByName('Codice').asString;
  // -------------------------------
  // Avvia il calcolo della Legge 10
  // -------------------------------
  ListBox_VerCor.Clear;
  ClearDatiMaschera;
  PulisciLabelCertificazione;
 {$IFDEF VERSIONE_13}
  TempVicinoAll := Tab1.FieldByName('TempVA').AsFloat;
  VicAss := UpperCase(Tab1.FieldByName('VicAssenti').AsString) = 'SI';
  CaricaContenutoFile(PercorsoDrive + '\ErroriL10.Log', NomeGeneratore);
  ScriviLog('IN:'+ NomeGeneratore);
 {$ELSE}
  AzzeraVoci;
  TempVicinoAll := EditN_Temp.ValueFloat;
  VicAss := RB_VicAss.Checked;
 {$ENDIF}
  CalcL10;
 {$IFDEF VERSIONE_13}
  if not ErroreGen then
     ScriviLog(CALCOLI_B_F);
  ScriviLog('FN:'+ NomeGeneratore);
  CloseFileLog;
  Mess := '';
  Mess := ErroreG(PercorsoDrive + '\ErroriL10.Log', NomeGeneratore);
  if Mess = '' then
  begin
   CaricaDatiCalcolo;
   if FcalcL10 <> nil then
      DisplayStatistica(FcalcL10.series1, FcalcL10.GraficoDispersioni);
  end
  else
  begin
    if FcalcL10 <> nil then
    begin
      Tab1.Edit;
      Tab1.Fields[42].AsString := '--';
      FCalcL10.ListBox_VerCor.Clear;
      FCalcL10.ListBox_VerCor.Items.Add('P:' + Mess);
    end;
  end;
 {$ELSE}
  if not ErroreGen then
     CaricaDatiCalcolo;
 {$ENDIF}
end;

procedure TFCalcL10.LB_TutorClick(Sender: TObject);
var
  PathFileTutor: String;
  FTag: TextFile;
begin
  PathFileTutor := Percorso_RisorseGenerale + '\Risorse\Tutor\TagSezione.txt';
  AssignFile(FTag, PathFileTutor);
  Rewrite(FTag);
  Writeln(FTag, 'SEZIONE4B');
  CloseFile(FTag);
  // caricamento della finestra del tutor
  {
  FormTutor := TFormTutor.Create(Application);
  FormTutor.LeggiSezione;
  FormTutor.ShowModal;
  FormTutor.Close;
  FreeAndNil(FormTutor);
  }
end;

procedure TFCalcL10.B_ChiudiClick(Sender: TObject);
begin
  Close;
end;

procedure TFCalcL10.LB_InfoClick(Sender: TObject);
begin
 if Caso = 3 then
 begin
  FormMessValLim3 := TFormMessValLim3.Create(nil);
  FormMessValLim3.ShowModal;
  FormMessValLim3.Close;
  FreeAndNil(FormMessValLim3);
 end
 else
 begin
  FormMessValLim := TFormMessValLim.Create(nil);
  FormMessValLim.ShowModal;
  FormMessValLim.Close;
  FreeAndNil(FormMessValLim);
 end;
end;

procedure TFCalcL10.SB_TipoOperaClick(Sender: TObject);
var
  PathFileTutor: String;
begin
  PathFileTutor := Percorso_RisorseGenerale + '\Risorse\Tutor\Estratto_CASI_1922.rtf';
  // caricamento della finestra del tutor
  {
  FormTutor := TFormTutor.Create(Application);
  FormTutor.Area_RTF.Lines.LoadFromFile(PathFileTutor);
  FormTutor.ShowModal;
  FormTutor.Close;
  FreeAndNil(FormTutor);
  }
end;

procedure TFCalcL10.PulisciLabelCertificazione;
begin
 LBVal_A.Caption := '';
 LBVal_B.Caption := '';
 LBVal_C.Caption := '';
 LBVal_D.Caption := '';
 LBVal_E.Caption := '';
 LBVal_F.Caption := '';
 LBVal_G.Caption := '';
 LBVal_AJ.Caption := '';
 LBVal_BJ.Caption := '';
 LBVal_CJ.Caption := '';
 LBVal_DJ.Caption := '';
 LBVal_EJ.Caption := '';
 LBVal_FJ.Caption := '';
 LBVal_GJ.Caption := '';
end;

procedure TFCalcL10.StampaValorePrestazioneEnergEdif;
begin
 {$IFDEF VERSIONE_TRIAL}
   LBVal_C.Caption := Format('%1.2f', [60.63]);
   LBVal_CJ.Caption := Format('%1.2f', [31.42]);
 {$ELSE}
 {$IF Defined(VERSIONE_12)}
   if DatiAtt.QKW <= 30 then
    begin
       LBVal_A.Caption := Format('%1.2f', [DatiAtt.QKW]);
       LBVal_AJ.Caption := Format('%1.2f', [DatiAtt.FEN]);
    end
    else
    if (DatiAtt.QKW > 30) and (DatiAtt.QKW <= 50) then
    begin
       LBVal_B.Caption := Format('%1.2f', [DatiAtt.QKW]);
       LBVal_BJ.Caption := Format('%1.2f', [DatiAtt.FEN]);
    end
    else
    if (DatiAtt.QKW > 50) and (DatiAtt.QKW <= 70) then
    begin
       LBVal_C.Caption := Format('%1.2f', [DatiAtt.QKW]);
       LBVal_CJ.Caption := Format('%1.2f', [DatiAtt.FEN]);
    end
    else
    if (DatiAtt.QKW > 70) and (DatiAtt.QKW <= 90) then
    begin
       LBVal_D.Caption := Format('%1.2f', [DatiAtt.QKW]);
       LBVal_DJ.Caption := Format('%1.2f', [DatiAtt.FEN]);
    end
    else
    if (DatiAtt.QKW > 90) and (DatiAtt.QKW <= 120) then
    begin
       LBVal_E.Caption := Format('%1.2f', [DatiAtt.QKW]);
       LBVal_EJ.Caption := Format('%1.2f', [DatiAtt.FEN]);
    end
    else
    if (DatiAtt.QKW > 120) and (DatiAtt.QKW <= 160) then
    begin
       LBVal_F.Caption := Format('%1.2f', [DatiAtt.QKW]);
       LBVal_FJ.Caption := Format('%1.2f', [DatiAtt.FEN]);
    end
    else
    if (DatiAtt.QKW > 160) then
    begin
       LBVal_G.Caption := Format('%1.2f', [DatiAtt.QKW]);
       LBVal_GJ.Caption := Format('%1.2f', [DatiAtt.FEN]);
    end;
   {$ELSEIF Defined(VERSIONE_13)}
    if DatiAtt[Gencor-1].QKW <= 30 then
    begin
       LBVal_A.Caption := Format('%1.2f', [DatiAtt[Gencor-1].QKW]);
       LBVal_AJ.Caption := Format('%1.2f', [DatiAtt[Gencor-1].FEN]);
    end
    else
    if (DatiAtt[Gencor-1].QKW > 30) and (DatiAtt[Gencor-1].QKW <= 50) then
    begin
       LBVal_B.Caption := Format('%1.2f', [DatiAtt[Gencor-1].QKW]);
       LBVal_BJ.Caption := Format('%1.2f', [DatiAtt[Gencor-1].FEN]);
    end
    else
    if (DatiAtt[Gencor-1].QKW > 50) and (DatiAtt[Gencor-1].QKW <= 70) then
    begin
       LBVal_C.Caption := Format('%1.2f', [DatiAtt[Gencor-1].QKW]);
       LBVal_CJ.Caption := Format('%1.2f', [DatiAtt[Gencor-1].FEN]);
    end
    else
    if (DatiAtt[Gencor-1].QKW > 70) and (DatiAtt[Gencor-1].QKW <= 90) then
    begin
       LBVal_D.Caption := Format('%1.2f', [DatiAtt[Gencor-1].QKW]);
       LBVal_DJ.Caption := Format('%1.2f', [DatiAtt[Gencor-1].FEN]);
    end
    else
    if (DatiAtt[Gencor-1].QKW > 90) and (DatiAtt[Gencor-1].QKW <= 120) then
    begin
       LBVal_E.Caption := Format('%1.2f', [DatiAtt[Gencor-1].QKW]);
       LBVal_EJ.Caption := Format('%1.2f', [DatiAtt[Gencor-1].FEN]);
    end
    else
    if (DatiAtt[Gencor-1].QKW > 120) and (DatiAtt[Gencor-1].QKW <= 160) then
    begin
       LBVal_F.Caption := Format('%1.2f', [DatiAtt[Gencor-1].QKW]);
       LBVal_FJ.Caption := Format('%1.2f', [DatiAtt[Gencor-1].FEN]);
    end
    else
    if (DatiAtt[Gencor-1].QKW > 160) then
    begin
       LBVal_G.Caption := Format('%1.2f', [DatiAtt[Gencor-1].QKW]);
       LBVal_GJ.Caption := Format('%1.2f', [DatiAtt[Gencor-1].FEN]);
    end;
   {$IFEND}
  {$ENDIF}
end;

procedure TFCalcL10.LB_ConsumiClick(Sender: TObject);
begin
  Frisparmio:=TFrisparmio.create(nil);
  Frisparmio.ShowModal;
  FRisparmio.Close;
  FreeandNil(FRisparmio);
end;

procedure TFCalcL10.ListBox_VerCorDrawItem(Control: TWinControl; Index: Integer; Rect: TRect; State: TOwnerDrawState);
var
    Offset: Integer;      { text offset width }
    Stringa: String;
    Bitmap: TBitmap;
begin
    with (Control as TListBox).Canvas do  { draw on control canvas, not on the form }
    begin
        { A seconda l'intestazione scelgo la bitmap appropriata }
        Stringa := (Control as TListBox).Items[Index];
        Case Stringa[1] of
            'I': begin  { Information }
                   BitMap := BitInfo;
                   Font.Color := clGreen;
                 end;
            'W': begin  { Warning }
                   BitMap := BitWarning;
                   Font.Color := RGB(255,81,81);
                 end;
            'E': begin  { Errore }
                   BitMap := BitError;
                   Font.Color := clRed;
                 end;
            'P': begin
                   BitMap := BitWhite;
                   Font.Color := RGB(255,81,81);
                 end;
            'G': begin
                   BitMap := BitWhite;
                   Font.Color := clGreen;
                 end;
            else begin
                  BitMap := BitInfo;
                  Font.Color := clBlack;
                 end;
        end; { case }

        Brush.Style := bsSolid;

        Brush.Color := clWhite;

        Rectangle(Rect);
        FillRect(Rect);       { clear the rectangle }

        Offset := 2;          { provide default offset }

        if Bitmap <> nil then
        begin
	    BrushCopy(Bounds(Rect.Left + 2, Rect.Top, Bitmap.Width, Bitmap.Height), Bitmap, Bounds(0, 0, Bitmap.Width, Bitmap.Height), clWhite);
            {render bitmap}
            Offset := Bitmap.width + 6;    { add four pixels between bitmap and text}
        end;

        { Pulisco la stringa dei primi tre caratteri }
        Stringa := Copy(Stringa, 3, Length(Stringa));
        TextOut(Rect.Left + Offset, Rect.Top + 1, Stringa)  { display the text }
    end;
end;

procedure TFCalcL10.RB_VicPresClick(Sender: TObject);
begin
  LB_Temp.Enabled    := False;
  EditN_Temp.Enabled := False;
  LB_C.Enabled       := False;
  EditN_Temp.SetFloat(0);
  EditN_Temp.Text := '0';
 {$IFDEF VERSIONE_13}
  Tab1.Edit;
  Tab1.FieldByName('VicAssenti').AsString := 'NO';
 {$ENDIF} 
end;

procedure TFCalcL10.RB_VicAssClick(Sender: TObject);
begin
  LB_Temp.Enabled    := True;
  EditN_Temp.Enabled := True;
  LB_C.Enabled       := True;
 {$IFDEF VERSIONE_13}
  Tab1.Edit;
  Tab1.FieldByName('VicAssenti').AsString := 'SI';
 {$ENDIF} 
end;

procedure TFCalcL10.SB_VerParetiClick(Sender: TObject);
begin
  FVerifPareti := TFVerifPareti.create(nil);
  FVerifPareti.ShowModal;
  FVerifPareti.Close;
  FreeAndNil(FVerifPareti);
end;

procedure TFCalcL10.SB_VerFinestreClick(Sender: TObject);
begin
  FVerifFinestre := TFVerifFinestre.create(nil);
  FVerifFinestre.ShowModal;
  FVerifFinestre.Close;
  FreeAndNil(FVerifFinestre);
end;

procedure TFCalcL10.DBGrid_GenCellClick(Column: TColumn);
begin
 CaricaDatiGeneratore;
end;

procedure TFCalcL10.FormActivate(Sender: TObject);
var
 Mess, Descrizione: String;
 Passo: Integer;
begin
{$IFDEF VERSIONE_13}
 Passo := 100 div Tab1.RecordCount;
 SetLength(DatiAtt,  Tab1.RecordCount);
 InitFileLog(PercorsoDrive + '\ErroriL10.Log');
 AzzeraVoci;
 Application.ProcessMessages;
 P_BarraScorrimento.Visible := True;
 P_BarraScorrimento.Repaint;
 ProgressBar_Calc.Position := 1;
 while not Tab1.Eof do
 begin
  ResetStatistica;
  gencor := NumeroRiga(Tab1.FieldByName('Codice').asString);
  NomeGeneratore := Tab1.FieldByName('Codice').asString;
  Descrizione := Tab1.FieldByName('Descrizione').asString;
  LB_NomeAll.Caption := 'Generatore: ' + Descrizione;
  Application.ProcessMessages;
  P_BarraScorrimento.Repaint;
  // -------------------------------
  // Avvia il calcolo della Legge 10
  // -------------------------------
  ScriviLog('IN:'+ NomeGeneratore);
  TempVicinoAll := Tab1.FieldByName('TempVA').AsFloat;
  VicAss := UpperCase(Tab1.FieldByName('VicAssenti').AsString) = 'SI';
  ProgressBar_Calc.Position := ProgressBar_Calc.Position + Passo;
  CalcL10;
  if not ErroreGen then
     ScriviLog(CALCOLI_B_F);
  ScriviLog('FN:'+ NomeGeneratore);
  Tab1.Next;
 end;
 ProgressBar_Calc.Position := 100;
 P_BarraScorrimento.Visible := False;
 CloseFileLog;
 Tab1.First;
 RB_VicPres.Checked := Tab1.FieldByName('VicAssenti').AsString <> 'SI';
 RB_VicAss.Checked  := Tab1.FieldByName('VicAssenti').AsString = 'SI';
 EditN_Temp.Text := FloatToStr(Tab1.FieldByName('TempVA').AsFloat);
 gencor := NumeroRiga(Tab1.FieldByName('Codice').asString);
 NomeGeneratore := Tab1.FieldByName('Codice').asString;
 Mess := '';
 Mess := ErroreG(PercorsoDrive + '\ErroriL10.Log', NomeGeneratore);
 if Mess = '' then
 begin
   CaricaDatiCalcolo;
   if FcalcL10 <> nil then
      DisplayStatistica(FcalcL10.series1, FcalcL10.GraficoDispersioni);
 end
 else
 begin
   if FcalcL10 <> nil then
   begin
      Tab1.Edit;
      Tab1.Fields[42].AsString := '--';
      FCalcL10.ListBox_VerCor.Clear;
      FCalcL10.ListBox_VerCor.Items.Add('P:' + Mess);
   end;
 end;
{$ELSE}
 P_BarraScorrimento.Visible := False;
{$ENDIF}
//dmtutti.T_Generatori.Filtered:=true;
end;

procedure TFCalcL10.DBGrid_GenKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  CaricaDatiGeneratore;
end;

procedure TFCalcL10.CaricaDatiGeneratore;
var
 Mess: String;
begin
{$IFDEF VERSIONE_13}
  RB_VicPres.Checked := Tab1.FieldByName('VicAssenti').AsString <> 'SI';
  RB_VicAss.Checked  := Tab1.FieldByName('VicAssenti').AsString = 'SI';
  EditN_Temp.Text := FloatToStr(Tab1.FieldByName('TempVA').AsFloat);
  ListBox_VerCor.Clear;
  ClearDatiMaschera;
  PulisciLabelCertificazione;
  gencor := NumeroRiga(Tab1.FieldByName('Codice').asString);
  NomeGeneratore := Tab1.FieldByName('Codice').asString;
  RB_VicPres.Checked := Tab1.FieldByName('VicAssenti').AsString <> 'SI';
  RB_VicAss.Checked  := Tab1.FieldByName('VicAssenti').AsString = 'SI';
  EditN_Temp.Text := FloatToStr(Tab1.FieldByName('TempVA').AsFloat);
  Mess := '';
  Mess := ErroreG(PercorsoDrive + '\ErroriL10.Log', NomeGeneratore);
  if Mess = '' then
  begin
     CaricaDatiCalcolo;
     if FcalcL10 <> nil then
        DisplayStatistica(FcalcL10.series1, FcalcL10.GraficoDispersioni);
  end
  else
  begin
     if FcalcL10 <> nil then
     begin
        FCalcL10.ListBox_VerCor.Clear;
        FCalcL10.ListBox_VerCor.Items.Add('P:' + Mess);
     end;
  end;
{$ENDIF}
end;

procedure TFCalcL10.FormDestroy(Sender: TObject);
begin
  FCalcL10 := nil;
end;

procedure TFCalcL10.DBGrid_GenDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn;
                                             State: TGridDrawState);
var
   NRect : TRect;
   TempStr : String;
   TempGrg : TDBGrid;
   NCol : Integer;
   Colore : TColor;
begin
{$IFDEF VERSIONE_13}
   NRect := Rect;
   NRect.Left := NRect.Left + 1;
   NRect.Right := NRect.Right - 1;
   TempGrg := (Sender As TDBGrid);
   TempStr := Column.Field.AsString;
   if Calcolo192 then
   begin
     If (DataCol = 1) Then
     Begin
       If CompareStr('SI', UpperCase(TempStr)) = 0 Then
       Begin
         TempGrg.Canvas.Font.Style := [fsBold];
         TempGrg.Canvas.Font.Color := clWhite;
         TempGrg.Canvas.Brush.Color := $0000B700;
         TempStr := 'SI';
       End
       Else
          If CompareStr('NO', UpperCase(TempStr)) = 0 Then
          Begin
            TempGrg.Canvas.Font.Style := [fsBold];
            TempGrg.Canvas.Font.Color := clWhite;
            TempGrg.Canvas.Brush.Color := $000000DF;
            TempStr := 'NO';
          end
          else
          begin
            TempGrg.Canvas.Font.Color := clBlack;
            TempGrg.Canvas.Brush.Color := clWhite;
            TempStr := '--';
          end;
       TempGrg.Canvas.FillRect(Rect);
       DrawText(TempGrg.Canvas.Handle, PChar(TempStr), Length(TempStr), NRect, DT_VCENTER);
     end;
   end;
{$ENDIF}   
end;

procedure TFCalcL10.TimerTimer(Sender: TObject);
begin
  Timer.Enabled := False;
 {$IFDEF VERSIONE_13}
  if EditN_Temp.Text <> '' then
  begin
    Tab1.Edit;
    Tab1.FieldByName('TempVA').AsFloat := StrToFloat(EditN_Temp.Text);
  end;
 {$ENDIF} 
end;

procedure TFCalcL10.EditN_TempChange(Sender: TObject);
begin
  Timer.Enabled := True;
end;

end.
