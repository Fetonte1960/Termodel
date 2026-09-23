object Form1: TForm1
  Left = 780
  Top = 53
  Width = 545
  Height = 154
  Caption = 'Generazione del database versione multitabella ( V.3.03 )'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnActivate = FormActivate
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 16
    Width = 108
    Height = 13
    Caption = 'Percorso del Database'
  end
  object Label2: TLabel
    Left = 16
    Top = 104
    Width = 195
    Height = 13
    Caption = 'Nessuna cartella indicata nel parametro 2'
  end
  object Label3: TLabel
    Left = 16
    Top = 88
    Width = 266
    Height = 13
    Caption = 'Verranno cancellati i file della  ( Database ) (parametro 2)'
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
  object CheckBox1: TCheckBox
    Left = 296
    Top = 88
    Width = 65
    Height = 17
    TabOrder = 3
  end
end
