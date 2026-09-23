object Form1: TForm1
  Left = 285
  Top = 155
  Width = 696
  Height = 471
  Caption = 'Input tabellare ed esecuzione calcoli'
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
    Top = 410
    Width = 688
    Height = 27
    Align = alBottom
    TabOrder = 0
    object Label1: TLabel
      Left = 152
      Top = 8
      Width = 31
      Height = 13
      Caption = 'Parete'
    end
    object Button1: TButton
      Left = 0
      Top = 2
      Width = 137
      Height = 25
      Caption = 'Esegui Calcoli'
      TabOrder = 0
      OnClick = Button1Click
    end
    object Edit2: TEdit
      Left = 192
      Top = 0
      Width = 113
      Height = 21
      TabOrder = 1
    end
    object Button2: TButton
      Left = 336
      Top = 0
      Width = 75
      Height = 25
      Caption = 'Stampa'
      TabOrder = 2
      OnClick = Button2Click
    end
  end
  object TabbedNotebook1: TTabbedNotebook
    Left = 0
    Top = 0
    Width = 688
    Height = 410
    Align = alClient
    PageIndex = 3
    TabFont.Charset = DEFAULT_CHARSET
    TabFont.Color = clBtnText
    TabFont.Height = -11
    TabFont.Name = 'MS Sans Serif'
    TabFont.Style = []
    TabOrder = 1
    object TTabPage
      Left = 4
      Top = 24
      Caption = 'Input'
      object Panel2: TPanel
        Left = 0
        Top = 354
        Width = 680
        Height = 28
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
        object Edit1: TEdit
          Left = 248
          Top = 0
          Width = 281
          Height = 21
          TabOrder = 1
          Text = 'd:\bmsistemi\progetti\prova3'
        end
        object Button3: TButton
          Left = 552
          Top = 0
          Width = 75
          Height = 25
          Caption = 'Dettaglio'
          TabOrder = 2
          OnClick = Button3Click
        end
      end
      object DBGrid1: TDBGrid
        Left = 0
        Top = 0
        Width = 559
        Height = 354
        Align = alClient
        DataSource = DM1.DataSource1
        TabOrder = 1
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'MS Sans Serif'
        TitleFont.Style = []
        OnDblClick = DBGrid1DblClick
      end
      object ListBox1: TListBox
        Left = 559
        Top = 0
        Width = 121
        Height = 354
        Align = alRight
        ItemHeight = 13
        TabOrder = 2
        OnClick = ListBox1Click
      end
    end
    object TTabPage
      Left = 4
      Top = 24
      Caption = 'Archivi'
      object Panel3: TPanel
        Left = 0
        Top = 353
        Width = 680
        Height = 29
        Align = alBottom
        TabOrder = 0
        object DBNavigator2: TDBNavigator
          Left = 0
          Top = 0
          Width = 240
          Height = 25
          DataSource = DataSource1
          TabOrder = 0
        end
      end
      object DBGrid2: TDBGrid
        Left = 0
        Top = 0
        Width = 680
        Height = 353
        Align = alClient
        DataSource = DataSource1
        TabOrder = 1
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'MS Sans Serif'
        TitleFont.Style = []
        OnDblClick = DBGrid2DblClick
      end
    end
    object TTabPage
      Left = 4
      Top = 24
      Caption = 'Risultati'
      object Panel4: TPanel
        Left = 0
        Top = 345
        Width = 680
        Height = 37
        Align = alBottom
        TabOrder = 0
        object DBNavigator3: TDBNavigator
          Left = 0
          Top = 8
          Width = 240
          Height = 25
          DataSource = DataSource2
          TabOrder = 0
        end
      end
      object DBGrid3: TDBGrid
        Left = 0
        Top = 0
        Width = 680
        Height = 345
        Align = alClient
        DataSource = DataSource2
        TabOrder = 1
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'MS Sans Serif'
        TitleFont.Style = []
        OnDblClick = DBGrid3DblClick
      end
    end
    object TTabPage
      Left = 4
      Top = 24
      Caption = 'Grafici'
      object DBChart1: TDBChart
        Left = 0
        Top = 0
        Width = 680
        Height = 382
        BackWall.Brush.Color = clWhite
        BackWall.Brush.Style = bsClear
        Title.Text.Strings = (
          'TDBChart')
        Align = alClient
        TabOrder = 0
        object Series1: TFastLineSeries
          Marks.ArrowLength = 8
          Marks.Visible = False
          DataSource = Table3
          SeriesColor = clRed
          LinePen.Color = clRed
          XValues.DateTime = False
          XValues.Name = 'X'
          XValues.Multiplier = 1
          XValues.Order = loAscending
          XValues.ValueSource = 'ORA'
          YValues.DateTime = False
          YValues.Name = 'Y'
          YValues.Multiplier = 1
          YValues.Order = loNone
          YValues.ValueSource = 'VALORE'
        end
      end
    end
  end
  object Table1: TTable
    DatabaseName = 'c:\bmsistemi\archivi'
    TableName = 'materiali.db'
    Left = 608
    Top = 40
    object Table1TypeMat: TSmallintField
      FieldName = 'TypeMat'
    end
    object Table1IndiceMat: TIntegerField
      FieldName = 'Indice Mat'
    end
    object Table1NomMat: TStringField
      FieldName = 'NomMat'
      Size = 50
    end
    object Table1LambdaMat: TFloatField
      FieldName = 'LambdaMat'
    end
    object Table1MasseMat: TFloatField
      FieldName = 'MasseMat'
    end
    object Table1MuMat: TFloatField
      FieldName = 'MuMat'
    end
    object Table1Version: TIntegerField
      FieldName = 'Version'
    end
    object Table1CapTerm: TFloatField
      FieldName = 'Cap.Term.'
    end
  end
  object DataSource1: TDataSource
    DataSet = Table1
    Left = 568
    Top = 40
  end
  object DataSource2: TDataSource
    DataSet = Table2
    Left = 568
    Top = 80
  end
  object Table2: TTable
    DatabaseName = 'c:\bmsistemi\progetti\prova3'
    TableName = 'Risultati.DB'
    Left = 608
    Top = 80
    object Table2Nome: TStringField
      FieldName = 'Nome'
    end
    object Table2Indice: TIntegerField
      FieldName = 'Indice'
    end
    object Table2Mese: TStringField
      FieldName = 'Mese'
      Size = 10
    end
    object Table2H0: TFloatField
      FieldName = 'H0'
      DisplayFormat = '0'
      Precision = 2
    end
    object Table2H1: TFloatField
      FieldName = 'H1'
      DisplayFormat = '0'
      Precision = 2
    end
    object Table2H2: TFloatField
      FieldName = 'H2'
      DisplayFormat = '0'
      Precision = 2
    end
    object Table2H3: TFloatField
      FieldName = 'H3'
      DisplayFormat = '0'
      Precision = 2
    end
    object Table2H4: TFloatField
      FieldName = 'H4'
      DisplayFormat = '0'
      Precision = 2
    end
    object Table2H5: TFloatField
      FieldName = 'H5'
      DisplayFormat = '0'
      Precision = 2
    end
    object Table2H6: TFloatField
      FieldName = 'H6'
      DisplayFormat = '0'
      Precision = 2
    end
    object Table2H7: TFloatField
      FieldName = 'H7'
      DisplayFormat = '0'
      Precision = 2
    end
    object Table2H8: TFloatField
      FieldName = 'H8'
      DisplayFormat = '0'
      Precision = 2
    end
    object Table2H9: TFloatField
      FieldName = 'H9'
      DisplayFormat = '0'
      Precision = 2
    end
    object Table2H10: TFloatField
      FieldName = 'H10'
      DisplayFormat = '0'
      Precision = 2
    end
    object Table2H11: TFloatField
      FieldName = 'H11'
      DisplayFormat = '0'
      Precision = 2
    end
    object Table2H12: TFloatField
      FieldName = 'H12'
      DisplayFormat = '0'
      Precision = 2
    end
    object Table2H13: TFloatField
      FieldName = 'H13'
      DisplayFormat = '0'
      Precision = 2
    end
    object Table2H14: TFloatField
      FieldName = 'H14'
      DisplayFormat = '0'
      Precision = 2
    end
    object Table2H15: TFloatField
      FieldName = 'H15'
      DisplayFormat = '0'
      Precision = 2
    end
    object Table2H16: TFloatField
      FieldName = 'H16'
      DisplayFormat = '0'
      Precision = 2
    end
    object Table2H17: TFloatField
      FieldName = 'H17'
      DisplayFormat = '0'
      Precision = 2
    end
    object Table2H18: TFloatField
      FieldName = 'H18'
      DisplayFormat = '0'
      Precision = 2
    end
    object Table2H19: TFloatField
      FieldName = 'H19'
      DisplayFormat = '0'
      Precision = 2
    end
    object Table2H20: TFloatField
      FieldName = 'H20'
      DisplayFormat = '0'
      Precision = 2
    end
    object Table2H21: TFloatField
      FieldName = 'H21'
      DisplayFormat = '0'
      Precision = 2
    end
    object Table2H22: TFloatField
      FieldName = 'H22'
      DisplayFormat = '0'
      Precision = 2
    end
    object Table2H23: TFloatField
      FieldName = 'H23'
      DisplayFormat = '0'
      Precision = 2
    end
  end
  object DataSource3: TDataSource
    DataSet = Table3
    Left = 568
    Top = 120
  end
  object Table3: TTable
    DatabaseName = 'C:\BMSISTEMI\PROGETTI\PROVA3'
    TableName = 'GRAFICI.db'
    Left = 608
    Top = 120
    object Table3ORA: TSmallintField
      FieldName = 'ORA'
    end
    object Table3VALORE: TFloatField
      FieldName = 'VALORE'
    end
  end
end
