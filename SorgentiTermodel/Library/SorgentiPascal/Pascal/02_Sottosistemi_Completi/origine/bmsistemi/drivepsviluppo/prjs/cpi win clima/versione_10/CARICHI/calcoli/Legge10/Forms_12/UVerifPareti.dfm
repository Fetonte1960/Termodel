object FVerifPareti: TFVerifPareti
  Left = 575
  Top = 325
  BorderIcons = [biSystemMenu]
  BorderStyle = bsToolWindow
  Caption = 'Verifica della trasmittanza delle pareti'
  ClientHeight = 260
  ClientWidth = 630
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object P_Bottoni: TPanel
    Left = 0
    Top = 231
    Width = 630
    Height = 29
    Align = alBottom
    BevelInner = bvLowered
    TabOrder = 0
    object SB_Chiudi: TLbSpeedButton
      Left = 548
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
  object GB_Generale: TGroupBox
    Left = 0
    Top = 0
    Width = 630
    Height = 231
    Align = alClient
    Caption = ' Elenco delle pareti '
    Font.Charset = DEFAULT_CHARSET
    Font.Color = 13339492
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 1
    object StringGrid_Verif: TStringGrid
      Left = 2
      Top = 15
      Width = 626
      Height = 214
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
      OnDrawCell = StringGrid_VerifDrawCell
      ColWidths = (
        71
        202
        120
        120
        97)
    end
  end
end
