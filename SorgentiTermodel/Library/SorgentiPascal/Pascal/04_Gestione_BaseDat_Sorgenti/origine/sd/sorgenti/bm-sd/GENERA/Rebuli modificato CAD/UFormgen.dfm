object FGenerale: TFGenerale
  Left = 364
  Top = 175
  Width = 540
  Height = 369
  Caption = 'Form generale'
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
    Top = 312
    Width = 532
    Height = 30
    Align = alBottom
    TabOrder = 0
    object DBNavigator1: TDBNavigator
      Left = 1
      Top = 1
      Width = 240
      Height = 28
      DataSource = DataSource1
      Align = alLeft
      TabOrder = 0
    end
    object BOk: TButton
      Left = 248
      Top = 0
      Width = 75
      Height = 28
      Caption = 'Ok'
      TabOrder = 1
      OnClick = BOkClick
    end
  end
  object GroupBox1: TGroupBox
    Left = 0
    Top = 0
    Width = 532
    Height = 312
    Align = alClient
    Caption = 'Unità di misura : m , mq , °C , W '
    TabOrder = 1
    object DBGrid1: TDBGrid
      Left = 2
      Top = 15
      Width = 528
      Height = 295
      Align = alClient
      DataSource = DataSource1
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'MS Sans Serif'
      TitleFont.Style = []
      OnDblClick = DBGrid1DblClick
    end
  end
  object DataSource1: TDataSource
    DataSet = DM1.TT4
    Left = 400
    Top = 16
  end
end
