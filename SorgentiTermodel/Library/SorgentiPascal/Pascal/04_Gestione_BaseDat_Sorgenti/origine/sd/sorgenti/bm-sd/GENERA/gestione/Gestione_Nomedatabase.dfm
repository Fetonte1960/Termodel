object FNomeDatabase: TFNomeDatabase
  Left = 568
  Top = 136
  Width = 633
  Height = 530
  Caption = 'Descrizione_Database'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox1: TGroupBox
    Left = 0
    Top = 0
    Width = 625
    Height = 216
    Align = alClient
    Caption = #167'NOMEDATABASE::'
    TabOrder = 0
    object DBComboBox1: TDBComboBox
      Left = 272
      Top = 24
      Width = 145
      Height = 21
      ItemHeight = 13
      TabOrder = 0
    end
  end
  object GroupBox2: TGroupBox
    Left = 0
    Top = 216
    Width = 625
    Height = 249
    Align = alBottom
    Caption = #167'NOMEDATABASE::'
    TabOrder = 1
    object Panel2: TPanel
      Left = 2
      Top = 15
      Width = 247
      Height = 232
      Align = alLeft
      Caption = 'Panel2'
      TabOrder = 0
      object Panel3: TPanel
        Left = 1
        Top = 208
        Width = 245
        Height = 23
        Align = alBottom
        TabOrder = 0
        object DBNavigator1: TDBNavigator
          Left = 1
          Top = 1
          Width = 240
          Height = 21
          Align = alLeft
          TabOrder = 0
        end
      end
      object DBGrid1: TDBGrid
        Left = 1
        Top = 1
        Width = 245
        Height = 207
        Align = alClient
        TabOrder = 1
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'MS Sans Serif'
        TitleFont.Style = []
      end
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 465
    Width = 625
    Height = 31
    Align = alBottom
    TabOrder = 2
  end
end
