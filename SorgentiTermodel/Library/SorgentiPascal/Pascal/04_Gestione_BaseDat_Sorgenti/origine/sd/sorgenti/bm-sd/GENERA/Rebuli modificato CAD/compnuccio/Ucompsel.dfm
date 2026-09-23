object FProgcomp: TFProgcomp
  Left = 244
  Top = 211
  Width = 759
  Height = 411
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
  object TabbedNotebook1: TTabbedNotebook
    Left = 0
    Top = 0
    Width = 751
    Height = 384
    Align = alClient
    TabFont.Charset = DEFAULT_CHARSET
    TabFont.Color = clBtnText
    TabFont.Height = -11
    TabFont.Name = 'MS Sans Serif'
    TabFont.Style = []
    TabOrder = 0
    object TTabPage
      Left = 4
      Top = 24
      Caption = 'Struttura'
      object DBGrid2: TDBGrid
        Left = 0
        Top = 0
        Width = 743
        Height = 234
        Align = alClient
        DataSource = DataSource1
        TabOrder = 0
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'MS Sans Serif'
        TitleFont.Style = []
      end
      object Panel2: TPanel
        Left = 0
        Top = 234
        Width = 743
        Height = 122
        Align = alBottom
        TabOrder = 1
        object DBNavigator2: TDBNavigator
          Left = 360
          Top = 0
          Width = 240
          Height = 25
          DataSource = DataSource1
          TabOrder = 0
        end
        object Button3: TButton
          Left = 456
          Top = 32
          Width = 75
          Height = 25
          Caption = 'Prova'
          TabOrder = 1
          OnClick = Button1Click
        end
        object DBImage2: TDBImage
          Left = 0
          Top = 0
          Width = 105
          Height = 105
          DataField = 'Immagine'
          DataSource = DataSource1
          TabOrder = 2
        end
        object Button4: TButton
          Left = 360
          Top = 32
          Width = 89
          Height = 25
          Caption = 'Carica Immagine'
          TabOrder = 3
          OnClick = Button2Click
        end
        object DBMemo2: TDBMemo
          Left = 112
          Top = 0
          Width = 185
          Height = 105
          DataField = 'Comento'
          DataSource = DataSource1
          TabOrder = 4
        end
      end
    end
    object TTabPage
      Left = 4
      Top = 24
      Caption = 'Parametri'
      object Panel1: TPanel
        Left = 0
        Top = 322
        Width = 743
        Height = 34
        Align = alBottom
        TabOrder = 0
        object DBNavigator1: TDBNavigator
          Left = 8
          Top = 8
          Width = 240
          Height = 25
          DataSource = DataSource2
          TabOrder = 0
        end
      end
      object DBGrid1: TDBGrid
        Left = 0
        Top = 0
        Width = 743
        Height = 322
        Align = alClient
        DataSource = DataSource2
        TabOrder = 1
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'MS Sans Serif'
        TitleFont.Style = []
      end
    end
  end
  object Tt1: TTable
    Active = True
    DatabaseName = 'c:\programmi\ded\sofrad'
    TableName = 'daticomp.db'
    Left = 688
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
    object Tt1TP: TIntegerField
      FieldName = 'TP'
    end
    object Tt1C1: TStringField
      FieldName = 'C1'
    end
    object Tt1C2: TStringField
      FieldName = 'C2'
    end
    object Tt1C3: TStringField
      FieldName = 'C3'
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
    Left = 688
    Top = 64
  end
  object Dlg1: TOpenPictureDialog
    Left = 704
    Top = 368
  end
  object Table1: TTable
    Active = True
    DatabaseName = 'c:\programmi\ded\sofrad'
    TableName = 'parcomp.db'
    Left = 692
    Top = 104
    object Table1Codice: TStringField
      FieldName = 'Codice'
      Size = 10
    end
    object Table1Ind: TAutoIncField
      FieldName = 'Ind'
      ReadOnly = True
    end
    object Table1Tipo: TStringField
      FieldName = 'Tipo'
      Size = 1
    end
    object Table1Campo: TStringField
      FieldName = 'Campo'
      Size = 30
    end
  end
  object DataSource2: TDataSource
    DataSet = Table1
    Left = 692
    Top = 144
  end
end
