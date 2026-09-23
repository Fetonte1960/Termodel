object FRunComp: TFRunComp
  Left = 194
  Top = 188
  Width = 744
  Height = 535
  Caption = 'Scelta del tipo di componenete'
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
  object DBCtrlGrid1: TDBCtrlGrid
    Left = 0
    Top = 0
    Width = 177
    Height = 472
    Align = alLeft
    ColCount = 1
    DataSource = DataSource1
    PanelHeight = 157
    PanelWidth = 161
    TabOrder = 0
    RowCount = 3
    OnDblClick = DBCtrlGrid1DblClick
    object DBImage1: TDBImage
      Left = 0
      Top = 0
      Width = 161
      Height = 132
      Align = alClient
      DataField = 'Immagine'
      DataSource = DataSource1
      ReadOnly = True
      Stretch = True
      TabOrder = 0
      OnClick = DBImage1Click
    end
    object Panel2: TPanel
      Left = 0
      Top = 132
      Width = 161
      Height = 25
      Align = alBottom
      Caption = 'Panel2'
      TabOrder = 1
      object DBText1: TDBText
        Left = 0
        Top = 8
        Width = 153
        Height = 17
        DataField = 'Descrizione'
        DataSource = DataSource1
      end
    end
  end
  object pp1: TPanel
    Left = 576
    Top = 152
    Width = 129
    Height = 73
    TabOrder = 1
    object Ppl: TPanel
      Left = 8
      Top = 8
      Width = 113
      Height = 25
      TabOrder = 0
      object Label1: TLabel
        Left = 8
        Top = 8
        Width = 6
        Height = 13
        Caption = 'L'
      end
      object Spl: TSpinEdit
        Left = 32
        Top = 0
        Width = 73
        Height = 22
        MaxValue = 0
        MinValue = 0
        TabOrder = 0
        Value = 0
      end
    end
    object Pph: TPanel
      Left = 8
      Top = 40
      Width = 113
      Height = 25
      TabOrder = 1
      object Label2: TLabel
        Left = 8
        Top = 8
        Width = 8
        Height = 13
        Caption = 'H'
      end
      object Sph: TSpinEdit
        Left = 32
        Top = 0
        Width = 73
        Height = 22
        MaxValue = 0
        MinValue = 0
        TabOrder = 0
        Value = 0
      end
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 472
    Width = 736
    Height = 36
    Align = alBottom
    TabOrder = 2
    object Button3: TButton
      Left = 6
      Top = 8
      Width = 75
      Height = 25
      Caption = 'Indietro'
      TabOrder = 0
      OnClick = Button3Click
    end
    object Button1: TButton
      Left = 86
      Top = 8
      Width = 75
      Height = 25
      Caption = 'Scegli'
      TabOrder = 1
      OnClick = Button1Click
    end
    object Button2: TButton
      Left = 174
      Top = 8
      Width = 75
      Height = 25
      Caption = 'Annulla'
      TabOrder = 2
    end
  end
  object TabbedNotebook1: TTabbedNotebook
    Left = 177
    Top = 0
    Width = 559
    Height = 472
    Align = alClient
    TabFont.Charset = DEFAULT_CHARSET
    TabFont.Color = clBtnText
    TabFont.Height = -11
    TabFont.Name = 'MS Sans Serif'
    TabFont.Style = []
    TabOrder = 3
    object TTabPage
      Left = 4
      Top = 24
      Caption = 'Modelli'
      object DBGrid1: TDBGrid
        Left = 0
        Top = 0
        Width = 551
        Height = 416
        Align = alClient
        DataSource = DataSource2
        TabOrder = 0
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'MS Sans Serif'
        TitleFont.Style = []
      end
      object Panel3: TPanel
        Left = 0
        Top = 416
        Width = 551
        Height = 28
        Align = alBottom
        TabOrder = 1
        object DBText2: TDBText
          Left = 8
          Top = 8
          Width = 257
          Height = 17
          DataField = 'Descrizione'
          DataSource = DataSource1
        end
        object DBNavigator1: TDBNavigator
          Left = 304
          Top = 0
          Width = 240
          Height = 25
          DataSource = DataSource2
          TabOrder = 0
        end
      end
    end
    object TTabPage
      Left = 4
      Top = 24
      Caption = 'Grandezze disponibili'
      object Panel4: TPanel
        Left = 0
        Top = 416
        Width = 551
        Height = 28
        Align = alBottom
        TabOrder = 0
        object DBText3: TDBText
          Left = 128
          Top = 8
          Width = 169
          Height = 17
          DataField = 'Descrizione'
          DataSource = DataSource2
        end
        object Label3: TLabel
          Left = 8
          Top = 8
          Width = 116
          Height = 13
          Caption = 'Grandezze disponibili di :'
        end
        object DBNavigator2: TDBNavigator
          Left = 304
          Top = 0
          Width = 240
          Height = 25
          DataSource = DataSource3
          TabOrder = 0
        end
      end
      object DBGrid2: TDBGrid
        Left = 0
        Top = 0
        Width = 551
        Height = 416
        Align = alClient
        DataSource = DataSource3
        TabOrder = 1
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'MS Sans Serif'
        TitleFont.Style = []
      end
    end
    object TTabPage
      Left = 4
      Top = 24
      Caption = 'Scelta e verifica'
    end
  end
  object Tt1: TTable
    Active = True
    DatabaseName = 'c:\terminali'
    TableName = 'daticomp.DB'
    Left = 672
    Top = 56
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
    object Tt1Filtro: TStringField
      FieldName = 'Filtro'
    end
    object Tt1Tipodatabase: TStringField
      FieldName = 'Tipo database'
    end
  end
  object DataSource1: TDataSource
    DataSet = Tt1
    OnDataChange = DataSource1DataChange
    Left = 672
    Top = 24
  end
  object DataSource2: TDataSource
    DataSet = Tt2
    OnDataChange = DataSource2DataChange
    Left = 669
    Top = 88
  end
  object Tt2: TTable
    DatabaseName = 'c:\terminali'
    IndexName = 'Pergruppo'
    MasterFields = 'Tipo database'
    MasterSource = DataSource1
    TableName = 'modelli.DB'
    Left = 669
    Top = 120
    object Tt2ID: TAutoIncField
      FieldName = 'ID'
      ReadOnly = True
      Visible = False
    end
    object Tt2Gruppo: TStringField
      FieldName = 'Gruppo'
      Visible = False
    end
    object Tt2Produttore: TStringField
      FieldName = 'Produttore'
    end
    object Tt2Codice: TStringField
      FieldName = 'Codice'
    end
    object Tt2Descrizione: TStringField
      DisplayWidth = 30
      FieldName = 'Descrizione'
      Size = 50
    end
    object Tt2File: TStringField
      FieldName = 'File'
    end
    object Tt2Etc: TFloatField
      FieldName = 'Etc.'
    end
  end
  object DataSource3: TDataSource
    DataSet = Tt3
    Left = 669
    Top = 152
  end
  object Tt3: TTable
    Left = 669
    Top = 184
  end
end
