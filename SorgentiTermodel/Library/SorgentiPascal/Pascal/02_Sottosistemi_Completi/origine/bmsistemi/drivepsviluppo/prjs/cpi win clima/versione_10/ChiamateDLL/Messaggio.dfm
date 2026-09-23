object FMessaggio: TFMessaggio
  Left = 518
  Top = 281
  Width = 431
  Height = 180
  Caption = 'Messaggio'
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
    Top = 105
    Width = 423
    Height = 41
    Align = alBottom
    TabOrder = 0
    object Button1: TButton
      Left = 192
      Top = 8
      Width = 75
      Height = 25
      Caption = 'Ok'
      TabOrder = 0
      OnClick = Button1Click
    end
  end
  object MemoMessaggio: TMemo
    Left = 0
    Top = 0
    Width = 423
    Height = 105
    Align = alClient
    Lines.Strings = (
      'Memo1')
    TabOrder = 1
  end
end
