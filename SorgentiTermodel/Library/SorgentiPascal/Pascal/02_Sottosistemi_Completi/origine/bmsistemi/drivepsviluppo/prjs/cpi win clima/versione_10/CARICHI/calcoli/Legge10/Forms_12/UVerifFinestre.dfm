object FVerifFinestre: TFVerifFinestre
  Left = 349
  Top = 218
  BorderIcons = [biSystemMenu]
  BorderStyle = bsToolWindow
  Caption = 'Verifica della trasmittanza delle Finestre e dei vetri'
  ClientHeight = 413
  ClientWidth = 620
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object P_Bottoni: TPanel
    Left = 0
    Top = 384
    Width = 620
    Height = 29
    Align = alBottom
    BevelInner = bvLowered
    TabOrder = 0
    object SB_Chiudi: TLbSpeedButton
      Left = 538
      Top = 2
      Width = 80
      Height = 25
      Hint = 'Chiude la finestra'
      Align = alRight
      Alignment = taCenter
      Caption = 'Chiudi'
      ColorWhenDown = 535020206
      HotTrackFont.Charset = DEFAULT_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -11
      HotTrackFont.Name = 'MS Sans Serif'
      HotTrackFont.Style = []
      NumGlyphs = 1
      ParentShowHint = False
      ShowHint = True
      Style = bsModern
      OnClick = SB_ChiudiClick
    end
  end
  object GB_Finestre: TGroupBox
    Left = 0
    Top = 0
    Width = 620
    Height = 185
    Align = alTop
    Caption = ' Verifica trasmittanza delle finestre '
    Font.Charset = DEFAULT_CHARSET
    Font.Color = 13339492
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 1
    object StringGrid_VerFin: TStringGrid
      Left = 2
      Top = 15
      Width = 616
      Height = 168
      Align = alClient
      Ctl3D = False
      DefaultColWidth = 120
      DefaultRowHeight = 25
      FixedCols = 0
      RowCount = 2
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine]
      ParentCtl3D = False
      ParentFont = False
      ScrollBars = ssVertical
      TabOrder = 0
      OnDrawCell = StringGrid_VerFinDrawCell
      ColWidths = (
        97
        161
        120
        120
        96)
    end
  end
  object GB_Vetri: TGroupBox
    Left = 0
    Top = 195
    Width = 620
    Height = 189
    Align = alBottom
    Caption = ' Verifica trasmittanza vetri '
    Font.Charset = DEFAULT_CHARSET
    Font.Color = 13339492
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 2
    object StringGrid_VerVetri: TStringGrid
      Left = 2
      Top = 15
      Width = 616
      Height = 172
      Align = alClient
      Ctl3D = False
      DefaultColWidth = 120
      DefaultRowHeight = 25
      FixedCols = 0
      RowCount = 2
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine]
      ParentCtl3D = False
      ParentFont = False
      ScrollBars = ssVertical
      TabOrder = 0
      OnDrawCell = StringGrid_VerVetriDrawCell
      ColWidths = (
        102
        163
        110
        120
        102)
    end
  end
  object P_cent: TPanel
    Left = 0
    Top = 185
    Width = 620
    Height = 10
    Align = alClient
    BevelInner = bvLowered
    BevelOuter = bvLowered
    Color = 13339492
    TabOrder = 3
  end
end
