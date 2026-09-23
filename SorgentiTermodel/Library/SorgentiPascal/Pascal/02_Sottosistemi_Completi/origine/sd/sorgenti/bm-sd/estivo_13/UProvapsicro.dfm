object FProvaPsicro: TFProvaPsicro
  Left = 437
  Top = 167
  Width = 361
  Height = 186
  Caption = 'Prova psicro'
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
    Left = 64
    Top = 48
    Width = 19
    Height = 13
    Caption = 'TBs'
  end
  object Label2: TLabel
    Left = 64
    Top = 72
    Width = 11
    Height = 13
    Caption = 'Ur'
  end
  object Edit1: TEdit
    Left = 96
    Top = 40
    Width = 49
    Height = 21
    TabOrder = 0
    Text = '26'
  end
  object Edit2: TEdit
    Left = 96
    Top = 64
    Width = 49
    Height = 21
    TabOrder = 1
    Text = '50'
  end
  object Button1: TButton
    Left = 8
    Top = 112
    Width = 153
    Height = 25
    Caption = 'Visualizza psicrometrico'
    TabOrder = 2
    OnClick = Button1Click
  end
end
