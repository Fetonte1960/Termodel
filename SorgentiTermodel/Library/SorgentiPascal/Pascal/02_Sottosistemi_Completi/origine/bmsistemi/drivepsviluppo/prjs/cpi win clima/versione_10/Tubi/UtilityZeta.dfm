object Form1: TForm1
  Left = 453
  Top = 180
  Width = 327
  Height = 264
  Caption = 'Calcolo coeff. Z'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 24
    Top = 24
    Width = 102
    Height = 13
    Caption = 'Diametro interno (mm)'
  end
  object Label2: TLabel
    Left = 24
    Top = 56
    Width = 78
    Height = 13
    Caption = 'Prevalenza(kPa)'
  end
  object Label3: TLabel
    Left = 24
    Top = 88
    Width = 66
    Height = 13
    Caption = 'Portata (kg/h)'
  end
  object Label4: TLabel
    Left = 24
    Top = 120
    Width = 53
    Height = 13
    Caption = 'Coeff. Zeta'
  end
  object LZeta: TLabel
    Left = 136
    Top = 120
    Width = 6
    Height = 20
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label5: TLabel
    Left = 24
    Top = 144
    Width = 65
    Height = 13
    Caption = 'Velocit'#224' (m/s)'
  end
  object Lvel: TLabel
    Left = 120
    Top = 144
    Width = 3
    Height = 13
  end
  object Label6: TLabel
    Left = 24
    Top = 168
    Width = 121
    Height = 13
    Caption = 'Potenza (W per dt 10 '#176'C )'
  end
  object LWatt: TLabel
    Left = 163
    Top = 168
    Width = 53
    Height = 13
  end
  object Button1: TButton
    Left = 16
    Top = 192
    Width = 75
    Height = 25
    Caption = 'Calcola'
    TabOrder = 0
    OnClick = Button1Click
  end
  object Ediam: TEdit
    Left = 136
    Top = 16
    Width = 73
    Height = 21
    TabOrder = 1
  end
  object EPrev: TEdit
    Left = 136
    Top = 48
    Width = 73
    Height = 21
    TabOrder = 2
  end
  object EPort: TEdit
    Left = 136
    Top = 80
    Width = 73
    Height = 21
    TabOrder = 3
  end
end
