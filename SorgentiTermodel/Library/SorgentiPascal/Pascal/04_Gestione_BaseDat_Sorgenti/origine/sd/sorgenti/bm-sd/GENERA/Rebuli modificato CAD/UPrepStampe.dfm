object PrepStampa: TPrepStampa
  Left = 384
  Top = 286
  Width = 390
  Height = 260
  Caption = 'Stampa della relazione'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Button1: TButton
    Left = 8
    Top = 200
    Width = 73
    Height = 25
    Caption = 'Anteprima'
    TabOrder = 0
    OnClick = Button1Click
  end
  object ReportPrinc: TQRCompositeReport
    OnAddReports = ReportPrincAddReports
    Options = []
    PrinterSettings.Copies = 1
    PrinterSettings.Duplex = False
    PrinterSettings.FirstPage = 0
    PrinterSettings.LastPage = 0
    PrinterSettings.OutputBin = Auto
    PrinterSettings.Orientation = poPortrait
    PrinterSettings.PaperSize = Letter
    Left = 9
    Top = 8
  end
end
