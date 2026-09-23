object Form1: TForm1
  Left = 595
  Top = 244
  Width = 545
  Height = 115
  Caption = 'Generazione del database ( V.3.02 )'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnActivate = FormActivate
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 16
    Width = 108
    Height = 13
    Caption = 'Percorso del Database'
  end
  object Button3: TButton
    Left = 8
    Top = 48
    Width = 75
    Height = 25
    Caption = 'Genera'
    TabOrder = 0
    OnClick = Button1Click
  end
  object Edit1: TEdit
    Left = 152
    Top = 8
    Width = 377
    Height = 21
    TabOrder = 1
    Text = 'Edit1'
  end
  object CBNobde: TCheckBox
    Left = 128
    Top = 56
    Width = 97
    Height = 17
    Caption = 'escludi bde'
    TabOrder = 2
  end
end
