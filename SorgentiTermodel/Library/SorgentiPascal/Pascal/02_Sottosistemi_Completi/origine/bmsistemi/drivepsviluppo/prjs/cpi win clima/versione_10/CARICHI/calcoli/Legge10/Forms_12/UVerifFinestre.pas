unit UVerifFinestre;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, LbSpeedButton, ExtCtrls, StdCtrls, Grids, VarCarichi;

type
  TFVerifFinestre = class(TForm)
    P_Bottoni: TPanel;
    SB_Chiudi: TLbSpeedButton;
    GB_Finestre: TGroupBox;
    GB_Vetri: TGroupBox;
    StringGrid_VerFin: TStringGrid;
    StringGrid_VerVetri: TStringGrid;
    P_cent: TPanel;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure StringGrid_VerFinDrawCell(Sender: TObject; ACol,
      ARow: Integer; Rect: TRect; State: TGridDrawState);
    procedure StringGrid_VerVetriDrawCell(Sender: TObject; ACol,
      ARow: Integer; Rect: TRect; State: TGridDrawState);
    procedure SB_ChiudiClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FVerifFinestre: TFVerifFinestre;

implementation

{$R *.dfm}

procedure TFVerifFinestre.FormCreate(Sender: TObject);
var
  i: Integer;
begin
  // caricamento delle finestre
  StringGrid_VerFin.ColCount := 5;
  StringGrid_VerFin.Cells[0,0] := 'Codice';
  StringGrid_VerFin.Cells[1,0] := 'Descrizione';
  StringGrid_VerFin.Cells[2,0] := 'Trasmittanza [W/m²K]';
  StringGrid_VerFin.Cells[3,0] := 'Valore limite [W/m²K]';
  StringGrid_VerFin.Cells[4,0] := 'Verifica D.Lgs. 192/05';
  for i := 1 to NFinestre do
  begin
   {$IFDEF VERSIONE_13}
    if (Finestre_D^[i].VerFDlg192 = '*') then
   {$ELSE}
    if (Finestre_D^[i].paretecontinua = '*') then
   {$ENDIF}
    begin
      StringGrid_VerFin.Cells[0,StringGrid_VerFin.RowCount - 1] := Finestre_D^[i].Codice;
      StringGrid_VerFin.Cells[1,StringGrid_VerFin.RowCount - 1] := Finestre_D^[i].Denom;
      StringGrid_VerFin.Cells[2,StringGrid_VerFin.RowCount - 1] := FloatToStr(Finestre_D^[i].Trasmittanza);
      StringGrid_VerFin.Cells[3,StringGrid_VerFin.RowCount - 1] := FloatToStr(Finestre_D^[i].ValLimFT);
      StringGrid_VerFin.Cells[4,StringGrid_VerFin.RowCount - 1] := Finestre_D^[i].VerificaF192;
      StringGrid_VerFin.RowCount := StringGrid_VerFin.RowCount + 1;
    end;
  end;
  if StringGrid_VerFin.RowCount > 2 then StringGrid_VerFin.RowCount := StringGrid_VerFin.RowCount - 1;
  // caricamento dei vetri
  StringGrid_VerVetri.ColCount := 5;
  StringGrid_VerVetri.Cells[0,0] := 'Codice';
  StringGrid_VerVetri.Cells[1,0] := 'Descrizione';
  StringGrid_VerVetri.Cells[2,0] := 'Trasmittanza [W/m²K]';
  StringGrid_VerVetri.Cells[3,0] := 'Valore limite [W/m²K]';
  StringGrid_VerVetri.Cells[4,0] := 'Verifica D.Lgs. 192/05';
  for i := 1 to NStrutture do
  begin
   {$IFDEF VERSIONE_13}
    if (Strutture_D^[i]^.VerDlg192 = '*') and (CompareStr(UpperCase(Strutture_D^[i]^.Categoria), 'TRASPARENTE') = 0) then
   {$ELSE}
    if (Strutture_D^[i]^.st_vet = '*') and (CompareStr(UpperCase(Strutture_D^[i]^.Categoria), 'TRASPARENTE') = 0) then
   {$ENDIF}
    begin
      StringGrid_VerVetri.Cells[0,StringGrid_VerVetri.RowCount - 1] := Strutture_D^[i]^.NFile;
      StringGrid_VerVetri.Cells[1,StringGrid_VerVetri.RowCount - 1] := Strutture_D^[i]^.Descr;
      StringGrid_VerVetri.Cells[2,StringGrid_VerVetri.RowCount - 1] := FloatToStr(Strutture_D^[i]^.Trasmitt);
      StringGrid_VerVetri.Cells[3,StringGrid_VerVetri.RowCount - 1] := FloatToStr(Strutture_D^[i]^.ValLimT);
      StringGrid_VerVetri.Cells[4,StringGrid_VerVetri.RowCount - 1] := Strutture_D^[i]^.Verifica192;
      StringGrid_VerVetri.RowCount := StringGrid_VerVetri.RowCount + 1;
    end;
  end;
  if StringGrid_VerVetri.RowCount > 2 then StringGrid_VerVetri.RowCount := StringGrid_VerVetri.RowCount - 1;
end;

procedure TFVerifFinestre.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TFVerifFinestre.StringGrid_VerFinDrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect; State: TGridDrawState);
var
   NRect : TRect;
   TempStr, TempVal : String;
   TempGrg : TStringGrid;
   NCol : Integer;
   Colore : TColor;
   Stile : TFontStyle;
begin
   NRect := Rect;
   NRect.Left := NRect.Left + 1;
   NRect.Right := NRect.Right - 1;
   TempGrg := (Sender As TStringGrid);
   TempStr := TempGrg.Cells[ACol, ARow];
   If (ARow > 0) and (ACol = 4) Then
   Begin
     TempVal := TempGrg.Cells[TempGrg.ColCount - 1, ARow];
     If CompareStr('SI', UpperCase(TempVal)) = 0 Then
     Begin
       TempGrg.Canvas.Font.Style := [fsBold];
       TempGrg.Canvas.Font.Color := clWhite;
       TempGrg.Canvas.Brush.Color := $0000B700;
       TempStr := 'Positiva';
     End
     Else
        If CompareStr('NO', UpperCase(TempVal)) = 0 Then
        Begin
          TempGrg.Canvas.Font.Style := [fsBold];
          TempGrg.Canvas.Font.Color := clWhite;
          TempGrg.Canvas.Brush.Color := $000000DF;
          TempStr := 'Negativa';
        end;
   End
   else
   If (ARow = 0) Then
   begin
     Stile  := fsBold;
     Colore := $00CB8B64;
     TempGrg.Canvas.Font.Style := [Stile];
     TempGrg.Canvas.Font.Color := Colore;
   end;
   TempGrg.Canvas.FillRect(Rect);
   If (ARow = 0) Then
      DrawText(TempGrg.Canvas.Handle, PChar(TempStr), Length(TempStr), NRect, DT_WORDBREAK or DT_CENTER)
   Else
      DrawText(TempGrg.Canvas.Handle, PChar(TempStr), Length(TempStr), NRect, DT_SINGLELINE or DT_VCENTER or DT_Left);
end;

procedure TFVerifFinestre.StringGrid_VerVetriDrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect; State: TGridDrawState);
var
   NRect : TRect;
   TempStr, TempVal : String;
   TempGrg : TStringGrid;
   NCol : Integer;
   Colore : TColor;
   Stile : TFontStyle;
begin
   NRect := Rect;
   NRect.Left := NRect.Left + 1;
   NRect.Right := NRect.Right - 1;
   TempGrg := (Sender As TStringGrid);
   TempStr := TempGrg.Cells[ACol, ARow];
   If (ARow > 0) and (ACol = 4) Then
   Begin
     TempVal := TempGrg.Cells[TempGrg.ColCount - 1, ARow];
     If CompareStr('SI', UpperCase(TempVal)) = 0 Then
     Begin
       TempGrg.Canvas.Font.Style := [fsBold];
       TempGrg.Canvas.Font.Color := clWhite;
       TempGrg.Canvas.Brush.Color := $0000B700;
       TempStr := 'Positiva';
     End
     Else
        If CompareStr('NO', UpperCase(TempVal)) = 0 Then
        Begin
          TempGrg.Canvas.Font.Style := [fsBold];
          TempGrg.Canvas.Font.Color := clWhite;
          TempGrg.Canvas.Brush.Color := $000000DF;
          TempStr := 'Negativa';
        end;
   End
   else
   If (ARow = 0) Then
   begin
     Stile  := fsBold;
     Colore := $00CB8B64;
     TempGrg.Canvas.Font.Style := [Stile];
     TempGrg.Canvas.Font.Color := Colore;
   end;
   TempGrg.Canvas.FillRect(Rect);
   If (ARow = 0) Then
      DrawText(TempGrg.Canvas.Handle, PChar(TempStr), Length(TempStr), NRect, DT_WORDBREAK or DT_CENTER)
   Else
      DrawText(TempGrg.Canvas.Handle, PChar(TempStr), Length(TempStr), NRect, DT_SINGLELINE or DT_VCENTER or DT_LEFT);
end;

procedure TFVerifFinestre.SB_ChiudiClick(Sender: TObject);
begin
  Close
end;

end.
