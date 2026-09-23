object FProgcomp: TFProgcomp
  Left = 205
  Top = 141
  Width = 760
  Height = 500
  Caption = 'Programmazione del componenete'
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
  object Panel1: TPanel
    Left = 0
    Top = 367
    Width = 752
    Height = 106
    Align = alBottom
    TabOrder = 0
    object DBNavigator1: TDBNavigator
      Left = 360
      Top = 0
      Width = 240
      Height = 25
      DataSource = DataSource1
      TabOrder = 0
    end
    object Button1: TButton
      Left = 456
      Top = 32
      Width = 75
      Height = 25
      Caption = 'Prova'
      TabOrder = 1
      OnClick = Button1Click
    end
    object DBImage1: TDBImage
      Left = 0
      Top = 0
      Width = 105
      Height = 105
      DataField = 'Immagine'
      DataSource = DataSource1
      Stretch = True
      TabOrder = 2
    end
    object Button2: TButton
      Left = 360
      Top = 32
      Width = 89
      Height = 25
      Caption = 'Carica Immagine'
      TabOrder = 3
      OnClick = Button2Click
    end
    object DBMemo1: TDBMemo
      Left = 112
      Top = 0
      Width = 185
      Height = 105
      DataField = 'Comento'
      DataSource = DataSource1
      TabOrder = 4
    end
  end
  object DBGrid1: TDBGrid
    Left = 0
    Top = 0
    Width = 752
    Height = 367
    Align = alClient
    DataSource = DataSource1
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
  end
  object Tt1: TTable
    Active = True
    DatabaseName = 'c:\terminali'
    TableName = 'daticomp.db'
    Left = 704
    Top = 24
    object Tt1ID: TAutoIncField
      FieldName = 'ID'
      ReadOnly = True
    end
    object Tt1Gruppo: TStringField
      FieldName = 'Gruppo'
      Size = 10
    end
    object Tt1Padre: TStringField
      FieldName = 'Padre'
      Size = 10
    end
    object Tt1Figlio: TStringField
      FieldName = 'Figlio'
      Size = 10
    end
    object Tt1Descrizione: TStringField
      FieldName = 'Descrizione'
      Size = 50
    end
    object Tt1Filtro: TStringField
      FieldName = 'Filtro'
    end
    object Tt1Tipodatabase: TStringField
      FieldName = 'Tipo database'
    end
    object Tt1L: TIntegerField
      FieldName = 'L'
    end
    object Tt1H: TIntegerField
      FieldName = 'H'
    end
    object Tt1Lmin: TIntegerField
      FieldName = 'Lmin'
    end
    object Tt1Lmax: TIntegerField
      FieldName = 'Lmax'
    end
    object Tt1Lstep: TIntegerField
      FieldName = 'Lstep'
    end
    object Tt1Hmin: TIntegerField
      FieldName = 'Hmin'
    end
    object Tt1Hmax: TIntegerField
      FieldName = 'Hmax'
    end
    object Tt1HSstep: TIntegerField
      FieldName = 'HSstep'
    end
    object Tt1Comento: TMemoField
      FieldName = 'Comento'
      BlobType = ftMemo
      Size = 240
    end
    object Tt1Immagine: TGraphicField
      FieldName = 'Immagine'
      BlobType = ftGraphic
    end
  end
  object DataSource1: TDataSource
    DataSet = Tt1
    OnDataChange = DataSource1DataChange
    Left = 704
    Top = 64
  end
  object Dlg1: TOpenPictureDialog
    Left = 704
    Top = 368
  end
end
