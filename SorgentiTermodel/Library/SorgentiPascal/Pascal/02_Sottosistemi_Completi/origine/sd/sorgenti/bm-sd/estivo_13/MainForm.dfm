object FMainEstivo: TFMainEstivo
  Left = 397
  Top = 141
  Width = 800
  Height = 600
  Caption = '?'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnActivate = FormActivate
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 528
    Width = 792
    Height = 38
    Align = alBottom
    TabOrder = 0
    object Label1: TLabel
      Left = 248
      Top = 16
      Width = 55
      Height = 13
      Caption = 'Dal mese di'
    end
    object Label2: TLabel
      Left = 400
      Top = 16
      Width = 47
      Height = 13
      Caption = 'al mese di'
    end
    object Button1: TButton
      Left = 96
      Top = 8
      Width = 137
      Height = 25
      Caption = 'Calcolo dei carichi estivi'
      TabOrder = 0
      Visible = False
      OnClick = Button1Click
    end
    object ComboBox1: TComboBox
      Left = 312
      Top = 8
      Width = 73
      Height = 21
      ItemHeight = 13
      TabOrder = 1
      Text = 'Luglio'
      Items.Strings = (
        'Gennaio'
        'Febbraio'
        'Marzo'
        'Aprile'
        'Maggio'
        'Giugno'
        'Luglio'
        'Agosto'
        'Settembre'
        'Ottobre'
        'Novembre'
        'Dicembre')
    end
    object ComboBox2: TComboBox
      Left = 456
      Top = 10
      Width = 73
      Height = 21
      ItemHeight = 13
      TabOrder = 2
      Text = 'Luglio'
      Items.Strings = (
        'Gennaio'
        'Febbraio'
        'Marzo'
        'Aprile'
        'Maggio'
        'Giugno'
        'Luglio'
        'Agosto'
        'Settembre'
        'Ottobre'
        'Novembre'
        'Dicembre')
    end
    object CBContinuo: TCheckBox
      Left = 552
      Top = 11
      Width = 97
      Height = 17
      Caption = '24 ore'
      Checked = True
      State = cbChecked
      TabOrder = 3
    end
    object Button2: TButton
      Left = 8
      Top = 8
      Width = 75
      Height = 25
      Caption = 'Chiudi'
      TabOrder = 4
      OnClick = Button2Click
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 0
    Width = 225
    Height = 464
    Align = alLeft
    TabOrder = 1
    object Label3: TLabel
      Left = 8
      Top = 192
      Width = 26
      Height = 13
      Caption = 'Mese'
    end
    object ListBox1: TListBox
      Left = 1
      Top = 1
      Width = 223
      Height = 176
      Align = alTop
      ItemHeight = 13
      Items.Strings = (
        'Potenza totale del fabbricato '
        'Temperatura esterna'
        'Radiazione solare diretta'
        'Potenza totale per zona'
        'Potenza sensibile  per zona'
        'Potenza Latente per zona'
        'Potenza totale per locale'
        'Potenza sensibile  per locale'
        'Potenza Latente per locale'
        'Carichi da trasmissione per locale'
        'Carichi da irraggiamento per locale'
        'Carichi  da persone per locale'
        'Carichi  da apparechhiature per locale'
        ''
        ''
        ''
        ''
        '')
      TabOrder = 0
      OnClick = ListBox1Click
    end
    object ComboBox3: TComboBox
      Left = 48
      Top = 184
      Width = 73
      Height = 21
      ItemHeight = 13
      TabOrder = 1
      Text = 'Luglio'
      Items.Strings = (
        'Gennaio'
        'Febbraio'
        'Marzo'
        'Aprile'
        'Maggio'
        'Giugno'
        'Luglio'
        'Agosto'
        'Settembre'
        'Ottobre'
        'Novembre'
        'Dicembre')
    end
    object DBGrid1: TDBGrid
      Left = 1
      Top = 216
      Width = 223
      Height = 247
      Align = alBottom
      TabOrder = 2
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'MS Sans Serif'
      TitleFont.Style = []
      OnCellClick = DBGrid1CellClick
    end
  end
  object Panel3: TPanel
    Left = 0
    Top = 464
    Width = 792
    Height = 64
    Align = alBottom
    TabOrder = 2
    object Memo1: TMemo
      Left = 1
      Top = 1
      Width = 790
      Height = 62
      Align = alClient
      Lines.Strings = (
        '')
      TabOrder = 0
    end
  end
  object Panel4: TPanel
    Left = 225
    Top = 0
    Width = 567
    Height = 464
    Align = alClient
    TabOrder = 3
    object DBChart1: TDBChart
      Left = 1
      Top = 1
      Width = 565
      Height = 383
      BackWall.Brush.Color = clWhite
      BackWall.Brush.Style = bsClear
      Title.Font.Charset = DEFAULT_CHARSET
      Title.Font.Color = clBlue
      Title.Font.Height = -16
      Title.Font.Name = 'Arial'
      Title.Font.Style = [fsBold, fsItalic]
      Title.Text.Strings = (
        '')
      Legend.Visible = False
      View3D = False
      Align = alClient
      TabOrder = 0
      object Series1: TLineSeries
        Marks.ArrowLength = 8
        Marks.Visible = False
        DataSource = Table3
        SeriesColor = clRed
        Pointer.InflateMargins = True
        Pointer.Style = psRectangle
        Pointer.Visible = False
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
    object Panel5: TPanel
      Left = 1
      Top = 384
      Width = 565
      Height = 79
      Align = alBottom
      TabOrder = 1
      object Label4: TLabel
        Left = 8
        Top = 8
        Width = 71
        Height = 20
        Caption = 'Massimo'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
    end
  end
  object Table1: TTable
    TableName = 'Risultati.DB'
    Left = 720
    Top = 24
    object Table1Nome: TStringField
      FieldName = 'Nome'
    end
    object Table1Indice: TIntegerField
      FieldName = 'Indice'
    end
    object Table1Mese: TStringField
      FieldName = 'Mese'
      Size = 10
    end
    object Table1H0: TFloatField
      FieldName = 'H0'
    end
    object Table1H1: TFloatField
      FieldName = 'H1'
    end
    object Table1H2: TFloatField
      FieldName = 'H2'
    end
    object Table1H3: TFloatField
      FieldName = 'H3'
    end
    object Table1H4: TFloatField
      FieldName = 'H4'
    end
    object Table1H5: TFloatField
      FieldName = 'H5'
    end
    object Table1H6: TFloatField
      FieldName = 'H6'
    end
    object Table1H7: TFloatField
      FieldName = 'H7'
    end
    object Table1H8: TFloatField
      FieldName = 'H8'
    end
    object Table1H9: TFloatField
      FieldName = 'H9'
    end
    object Table1H10: TFloatField
      FieldName = 'H10'
    end
    object Table1H11: TFloatField
      FieldName = 'H11'
    end
    object Table1H12: TFloatField
      FieldName = 'H12'
    end
    object Table1H13: TFloatField
      FieldName = 'H13'
    end
    object Table1H14: TFloatField
      FieldName = 'H14'
    end
    object Table1H15: TFloatField
      FieldName = 'H15'
    end
    object Table1H16: TFloatField
      FieldName = 'H16'
    end
    object Table1H17: TFloatField
      FieldName = 'H17'
    end
    object Table1H18: TFloatField
      FieldName = 'H18'
    end
    object Table1H19: TFloatField
      FieldName = 'H19'
    end
    object Table1H20: TFloatField
      FieldName = 'H20'
    end
    object Table1H21: TFloatField
      FieldName = 'H21'
    end
    object Table1H22: TFloatField
      FieldName = 'H22'
    end
    object Table1H23: TFloatField
      FieldName = 'H23'
    end
  end
  object Table3: TTable
    TableName = 'GRAFICI.db'
    Left = 720
    Top = 80
    object Table3ORA: TSmallintField
      FieldName = 'ORA'
    end
    object Table3VALORE: TFloatField
      FieldName = 'VALORE'
    end
  end
end
