object Fmessaggidb: TFmessaggidb
  Left = 287
  Top = 172
  Width = 528
  Height = 325
  Caption = 'Errori rilevati  '
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  object Button1: TButton
    Left = 8
    Top = 256
    Width = 75
    Height = 25
    Caption = 'Chiudi'
    TabOrder = 0
    OnClick = Button1Click
  end
  object Memo1: TMemo
    Left = 0
    Top = 0
    Width = 505
    Height = 249
    Lines.Strings = (
      '')
    TabOrder = 1
  end
end
