object Datigen: TDatigen
  Left = 405
  Top = 172
  Width = 361
  Height = 249
  Caption = 'Dati Generali per il calcolo'
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
    Left = 8
    Top = 168
    Width = 93
    Height = 13
    Caption = 'Portata aria primaria'
  end
  object Label22: TLabel
    Left = 144
    Top = 168
    Width = 26
    Height = 13
    Caption = 'Vol/h'
  end
  object Label23: TLabel
    Left = 184
    Top = 168
    Width = 61
    Height = 13
    Caption = 'Altezza netta'
  end
  object Label24: TLabel
    Left = 312
    Top = 168
    Width = 8
    Height = 13
    Caption = 'm'
  end
  object GroupBox1: TGroupBox
    Left = 16
    Top = 8
    Width = 153
    Height = 145
    Caption = 'Condizioni invernali'
    TabOrder = 0
    object Label2: TLabel
      Left = 8
      Top = 24
      Width = 62
      Height = 13
      Caption = 'Temper. amb'
    end
    object Label3: TLabel
      Left = 8
      Top = 48
      Width = 42
      Height = 13
      Caption = 'U.R amb'
    end
    object Label4: TLabel
      Left = 8
      Top = 72
      Width = 59
      Height = 13
      Caption = 'T mand, aria'
    end
    object Label5: TLabel
      Left = 8
      Top = 96
      Width = 67
      Height = 13
      Caption = 'T. mand. H2O'
    end
    object Label6: TLabel
      Left = 8
      Top = 120
      Width = 49
      Height = 13
      Caption = 'T. rit. H2O'
    end
    object Label7: TLabel
      Left = 128
      Top = 24
      Width = 11
      Height = 13
      Caption = '°C'
    end
    object Label8: TLabel
      Left = 128
      Top = 120
      Width = 11
      Height = 13
      Caption = '°C'
    end
    object Label9: TLabel
      Left = 128
      Top = 72
      Width = 11
      Height = 13
      Caption = '°C'
    end
    object Label10: TLabel
      Left = 128
      Top = 96
      Width = 11
      Height = 13
      Caption = '°C'
    end
    object Label11: TLabel
      Left = 128
      Top = 48
      Width = 8
      Height = 13
      Caption = '%'
    end
    object DBEdit1: TDBEdit
      Left = 88
      Top = 16
      Width = 33
      Height = 21
      DataField = 'I, Temperatura ambiente'
      DataSource = DataSource1
      TabOrder = 0
    end
    object DBEdit2: TDBEdit
      Left = 88
      Top = 40
      Width = 33
      Height = 21
      DataField = 'I, umidita relativa  ambi'
      DataSource = DataSource1
      TabOrder = 1
    end
    object DBEdit3: TDBEdit
      Left = 88
      Top = 64
      Width = 33
      Height = 21
      DataField = 'I, Temperatura di immissi'
      DataSource = DataSource1
      TabOrder = 2
    end
    object DBEdit4: TDBEdit
      Left = 88
      Top = 88
      Width = 33
      Height = 21
      DataField = 'I, Temperatura di mandata'
      DataSource = DataSource1
      TabOrder = 3
    end
    object DBEdit5: TDBEdit
      Left = 88
      Top = 112
      Width = 33
      Height = 21
      DataField = 'I, Temperatura di ritorno'
      DataSource = DataSource1
      TabOrder = 4
    end
  end
  object GroupBox2: TGroupBox
    Left = 176
    Top = 8
    Width = 161
    Height = 145
    Caption = 'Condizioni estive'
    TabOrder = 1
    object Label12: TLabel
      Left = 8
      Top = 24
      Width = 62
      Height = 13
      Caption = 'Temper. amb'
    end
    object Label13: TLabel
      Left = 8
      Top = 48
      Width = 42
      Height = 13
      Caption = 'U.R amb'
    end
    object Label14: TLabel
      Left = 8
      Top = 72
      Width = 59
      Height = 13
      Caption = 'T mand, aria'
    end
    object Label15: TLabel
      Left = 8
      Top = 96
      Width = 67
      Height = 13
      Caption = 'T. mand. H2O'
    end
    object Label16: TLabel
      Left = 8
      Top = 120
      Width = 49
      Height = 13
      Caption = 'T. rit. H2O'
    end
    object Label17: TLabel
      Left = 128
      Top = 24
      Width = 11
      Height = 13
      Caption = '°C'
    end
    object Label18: TLabel
      Left = 128
      Top = 120
      Width = 11
      Height = 13
      Caption = '°C'
    end
    object Label19: TLabel
      Left = 128
      Top = 72
      Width = 11
      Height = 13
      Caption = '°C'
    end
    object Label20: TLabel
      Left = 128
      Top = 96
      Width = 11
      Height = 13
      Caption = '°C'
    end
    object Label21: TLabel
      Left = 128
      Top = 48
      Width = 8
      Height = 13
      Caption = '%'
    end
    object DBEdit6: TDBEdit
      Left = 88
      Top = 16
      Width = 33
      Height = 21
      DataField = 'I, Temperatura ambiente'
      DataSource = DataSource1
      TabOrder = 0
    end
    object DBEdit7: TDBEdit
      Left = 88
      Top = 40
      Width = 33
      Height = 21
      DataField = 'I, umidita relativa  ambi'
      DataSource = DataSource1
      TabOrder = 1
    end
    object DBEdit8: TDBEdit
      Left = 88
      Top = 64
      Width = 33
      Height = 21
      DataField = 'I, Temperatura di immissi'
      DataSource = DataSource1
      TabOrder = 2
    end
    object DBEdit9: TDBEdit
      Left = 88
      Top = 88
      Width = 33
      Height = 21
      DataField = 'I, Temperatura di mandata'
      DataSource = DataSource1
      TabOrder = 3
    end
    object DBEdit10: TDBEdit
      Left = 88
      Top = 112
      Width = 33
      Height = 21
      DataField = 'I, Temperatura di ritorno'
      DataSource = DataSource1
      TabOrder = 4
    end
  end
  object DBEdit11: TDBEdit
    Left = 104
    Top = 160
    Width = 33
    Height = 21
    DataField = 'Portata aria primaria '
    DataSource = DataSource1
    TabOrder = 2
  end
  object Button1: TButton
    Left = 184
    Top = 192
    Width = 75
    Height = 25
    Caption = 'OK'
    TabOrder = 3
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 264
    Top = 192
    Width = 75
    Height = 25
    Caption = 'Cancel'
    TabOrder = 4
  end
  object DBEdit12: TDBEdit
    Left = 256
    Top = 160
    Width = 49
    Height = 21
    DataField = 'Altezza netta'
    DataSource = DataSource1
    TabOrder = 5
  end
  object DataSource1: TDataSource
    DataSet = DisplayTab2
    Left = 304
  end
  object DisplayTab2: TTable
    DatabaseName = 'c:\programmi\ded\sofrad\esempi\esempio3'
    TableName = 'Ambienti.DB'
    Left = 272
  end
end
