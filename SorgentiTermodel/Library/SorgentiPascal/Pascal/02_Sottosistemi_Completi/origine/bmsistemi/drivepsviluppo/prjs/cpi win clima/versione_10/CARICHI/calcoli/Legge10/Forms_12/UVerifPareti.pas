unit UVerifPareti;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, LbSpeedButton, ExtCtrls, Grids, DBGrids, DB, DBTables, ComCtrls, VarCarichi,
  StdCtrls;

type
  TFVerifPareti = class(TForm)
    P_Bottoni: TPanel;
    SB_Chiudi: TLbSpeedButton;
    GB_Generale: TGroupBox;
    StringGrid_Verif: TStringGrid;
    procedure StringGrid_VerifDrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect; State: TGridDrawState);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure SB_ChiudiClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FVerifPareti: TFVerifPareti;

implementation

{$R *.dfm}

procedure TFVerifPareti.FormCreate(Sender: TObject);
var
  i: Integer;
begin
  StringGrid_Verif.ColCount := 5;
  StringGrid_Verif.Cells[0,0] := 'Codice';
  StringGrid_Verif.Cells[1,0] := 'Descrizione';
  StringGrid_Verif.Cells[2,0] := 'Trasmittanza [W/m²K]';
  StringGrid_Verif.Cells[3,0] := 'Valore limite [W/m²K]';
  StringGrid_Verif.Cells[4,0] := 'Verifica D.Lgs. 192/05';
  for i := 1 to NStrutture do
  begin
   {$IFDEF VERSIONE_13}
    if (Strutture_D^[i]^.VerDlg192 = '*') and (CompareStr(UpperCase(Strutture_D^[i]^.Categoria), 'OPACO') = 0) then
   {$ELSE}
    if (Strutture_D^[i]^.st_vet = '*') and (CompareStr(UpperCase(Strutture_D^[i]^.Categoria), 'OPACO') = 0) then
   {$ENDIF}
    begin
      StringGrid_Verif.Cells[0,StringGrid_Verif.RowCount - 1] := Strutture_D^[i]^.NFile;
      StringGrid_Verif.Cells[1,StringGrid_Verif.RowCount - 1] := Strutture_D^[i]^.Descr;
      StringGrid_Verif.Cells[2,StringGrid_Verif.RowCount - 1] := FloatToStr(Strutture_D^[i]^.Trasmitt);
      StringGrid_Verif.Cells[4,StringGrid_Verif.RowCount - 1] := Strutture_D^[i]^.Verifica192;
      if CompareStr('PS', UpperCase(Strutture_D^[i]^.Verifica192)) = 0  then
      StringGrid_Verif.Cells[3,StringGrid_Verif.RowCount - 1] := FloatToStr(Strutture_D^[i]^.ValLimT*1.3)
      else StringGrid_Verif.Cells[3,StringGrid_Verif.RowCount - 1] := FloatToStr(Strutture_D^[i]^.ValLimT);
      StringGrid_Verif.RowCount := StringGrid_Verif.RowCount + 1;
    end;
  end;
  if StringGrid_Verif.RowCount > 2 then StringGrid_Verif.RowCount := StringGrid_Verif.RowCount - 1;
end;

procedure TFVerifPareti.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TFVerifPareti.StringGrid_VerifDrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect; State: TGridDrawState);
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
     If (CompareStr('SI', UpperCase(TempVal)) = 0)or(CompareStr('PS', UpperCase(TempVal)) = 0) Then
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


procedure TFVerifPareti.SB_ChiudiClick(Sender: TObject);
begin
  Close;
end;

end.
