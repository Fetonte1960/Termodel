object Usacurve: TUsacurve
  Left = 472
  Top = 117
  Width = 449
  Height = 337
  Caption = 'Usacurve'
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
    Top = 280
    Width = 441
    Height = 30
    Align = alBottom
    TabOrder = 0
    object DBNavigator1: TDBNavigator
      Left = 0
      Top = 0
      Width = 240
      Height = 25
      DataSource = DataSource1
      TabOrder = 0
    end
  end
  object DBGrid1: TDBGrid
    Left = 0
    Top = 0
    Width = 441
    Height = 280
    Align = alClient
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
  end
  object Table1: TTable
    MasterSource = DataSource2
    Left = 400
    Top = 80
  end
  object DataSource1: TDataSource
    DataSet = Table1
    Left = 408
    Top = 128
  end
  object TElcurve: TTable
    Left = 400
    Top = 8
  end
  object DataSource2: TDataSource
    DataSet = TElcurve
    Left = 400
    Top = 48
  end
end
