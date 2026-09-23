object Form1: TForm1
  Left = 260
  Top = 115
  Width = 760
  Height = 495
  Caption = 'Programmazione del componente'
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
    Top = 368
    Width = 752
    Height = 100
    Align = alBottom
    TabOrder = 0
    object DBNavigator1: TDBNavigator
      Left = 112
      Top = 8
      Width = 240
      Height = 25
      DataSource = DataSource1
      TabOrder = 0
    end
    object Button1: TButton
      Left = 216
      Top = 40
      Width = 75
      Height = 25
      Caption = 'Prova'
      TabOrder = 1
    end
    object DBImage1: TDBImage
      Left = 0
      Top = 0
      Width = 105
      Height = 105
      DataField = 'Immagine'
      DataSource = DataSource1
      TabOrder = 2
    end
    object Button2: TButton
      Left = 112
      Top = 40
      Width = 89
      Height = 25
      Caption = 'Carica immagine'
      TabOrder = 3
      OnClick = Button2Click
    end
  end
  object DBGrid1: TDBGrid
    Left = 0
    Top = 0
    Width = 752
    Height = 368
    Align = alClient
    DataSource = DataSource1
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
  end
  object Table1: TTable
    Active = True
    DatabaseName = 'c:\compnuccio'
    TableName = 'daticomp.db'
    Left = 704
    Top = 24
  end
  object DataSource1: TDataSource
    DataSet = Table1
    Left = 704
    Top = 64
  end
  object Dial1: TOpenPictureDialog
    Left = 712
    Top = 376
  end
end
