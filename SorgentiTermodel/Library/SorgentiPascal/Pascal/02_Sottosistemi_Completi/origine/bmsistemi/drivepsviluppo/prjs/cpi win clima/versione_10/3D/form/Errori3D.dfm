object FErrori3d: TFErrori3d
  Left = 452
  Top = 227
  Width = 485
  Height = 362
  Caption = 'Segnalazione irregolarit'#224
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 301
    Width = 477
    Height = 27
    Align = alBottom
    TabOrder = 0
    object Button4: TLbSpeedButton
      Left = 2
      Top = 2
      Width = 80
      Height = 23
      Hint = 'Crea un nuovo elemento '
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
      OnClick = Button4Click
    end
  end
  object Memo1: TMemo
    Left = 0
    Top = 0
    Width = 477
    Height = 301
    Align = alClient
    Color = cl3DLight
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clRed
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    Lines.Strings = (
      'Memo1')
    ParentFont = False
    TabOrder = 1
  end
end
