object Fterminale: TFterminale
  Left = 353
  Top = 112
  Width = 470
  Height = 483
  Caption = 'Selezione del terminale'
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
  object Panel2: TPanel
    Left = 0
    Top = 415
    Width = 462
    Height = 41
    Align = alBottom
    TabOrder = 0
    object Button1: TButton
      Left = 8
      Top = 8
      Width = 97
      Height = 25
      Caption = 'Seleziona tipologia'
      TabOrder = 0
      OnClick = Button1Click
    end
    object Button2: TButton
      Left = 120
      Top = 8
      Width = 89
      Height = 25
      Caption = 'Azzera campi'
      TabOrder = 1
      OnClick = Button2Click
    end
  end
  object GroupBox1: TGroupBox
    Left = 0
    Top = 0
    Width = 462
    Height = 415
    Align = alClient
    Caption = 'Scelta dei fan-coils'
    TabOrder = 1
    object Label14: TLabel
      Left = 8
      Top = 24
      Width = 56
      Height = 13
      Caption = 'Fabbricante'
    end
    object Label15: TLabel
      Left = 208
      Top = 24
      Width = 37
      Height = 13
      Caption = 'Modello'
    end
    object Label16: TLabel
      Left = 344
      Top = 24
      Width = 51
      Height = 13
      Caption = 'Grandezza'
    end
    object DBEdit7: TDBEdit
      Left = 72
      Top = 16
      Width = 121
      Height = 21
      DataField = 'Fabbricante'
      DataSource = DataSource1
      TabOrder = 0
    end
    object DBEdit8: TDBEdit
      Left = 256
      Top = 16
      Width = 81
      Height = 21
      DataField = 'Modello'
      DataSource = DataSource1
      TabOrder = 1
    end
    object DBEdit9: TDBEdit
      Left = 400
      Top = 16
      Width = 49
      Height = 21
      DataSource = DataSource1
      TabOrder = 2
    end
    object GroupBox4: TGroupBox
      Left = 0
      Top = 48
      Width = 321
      Height = 161
      Caption = 'Condizioni in ambiente'
      TabOrder = 3
      object Label2: TLabel
        Left = 64
        Top = 24
        Width = 21
        Height = 13
        Caption = 'Tbs:'
      end
      object Label3: TLabel
        Left = 64
        Top = 48
        Width = 19
        Height = 13
        Caption = 'UR:'
      end
      object Label6: TLabel
        Left = 8
        Top = 96
        Width = 39
        Height = 13
        Caption = 'Potenza'
      end
      object Label9: TLabel
        Left = 56
        Top = 96
        Width = 40
        Height = 13
        Caption = 'sensibile'
      end
      object Label10: TLabel
        Left = 64
        Top = 116
        Width = 26
        Height = 13
        Caption = 'totale'
      end
      object GroupBox2: TGroupBox
        Left = 114
        Top = 16
        Width = 95
        Height = 137
        Caption = 'Estate'
        TabOrder = 0
        object DBEdit1: TDBEdit
          Left = 8
          Top = 16
          Width = 65
          Height = 21
          DataField = 'E Temperatura interna BS'
          DataSource = DataSource1
          TabOrder = 0
        end
        object DBEdit2: TDBEdit
          Left = 8
          Top = 40
          Width = 65
          Height = 21
          DataField = 'E Umidita relativa intern'
          DataSource = DataSource1
          TabOrder = 1
        end
        object DBEdit4: TDBEdit
          Left = 8
          Top = 72
          Width = 65
          Height = 21
          DataSource = DataSource1
          TabOrder = 2
        end
        object DBEdit5: TDBEdit
          Left = 8
          Top = 96
          Width = 65
          Height = 21
          DataSource = DataSource1
          TabOrder = 3
        end
      end
      object GroupBox3: TGroupBox
        Left = 216
        Top = 16
        Width = 97
        Height = 137
        Caption = 'Inverno'
        TabOrder = 1
        object DBEdit3: TDBEdit
          Left = 8
          Top = 16
          Width = 65
          Height = 21
          DataField = 'I Temperatura interna BS'
          DataSource = DataSource1
          TabOrder = 0
        end
        object DBEdit6: TDBEdit
          Left = 8
          Top = 72
          Width = 65
          Height = 21
          DataSource = DataSource1
          TabOrder = 1
        end
      end
    end
    object GroupBox5: TGroupBox
      Left = 0
      Top = 216
      Width = 321
      Height = 193
      Caption = 'Prestazioni del  fan-coil'
      TabOrder = 4
      object Label1: TLabel
        Left = 8
        Top = 40
        Width = 39
        Height = 13
        Caption = 'Potenza'
      end
      object Label4: TLabel
        Left = 56
        Top = 40
        Width = 40
        Height = 13
        Caption = 'sensibile'
      end
      object Label5: TLabel
        Left = 64
        Top = 60
        Width = 26
        Height = 13
        Caption = 'totale'
      end
      object Label7: TLabel
        Left = 8
        Top = 88
        Width = 73
        Height = 13
        Caption = 'Ingresso acqua'
      end
      object Label8: TLabel
        Left = 8
        Top = 120
        Width = 79
        Height = 13
        Caption = 'Salto termico DT'
      end
      object Label11: TLabel
        Left = 8
        Top = 144
        Width = 34
        Height = 13
        Caption = 'Portata'
      end
      object Label12: TLabel
        Left = 8
        Top = 168
        Width = 76
        Height = 13
        Caption = 'Perdite di carico'
      end
      object GroupBox6: TGroupBox
        Left = 114
        Top = 16
        Width = 95
        Height = 169
        Caption = 'Estate'
        TabOrder = 0
        object DBEdit10: TDBEdit
          Left = 8
          Top = 16
          Width = 65
          Height = 21
          DataSource = DataSource1
          TabOrder = 0
        end
        object DBEdit11: TDBEdit
          Left = 8
          Top = 40
          Width = 65
          Height = 21
          DataSource = DataSource1
          TabOrder = 1
        end
        object DBEdit12: TDBEdit
          Left = 8
          Top = 72
          Width = 65
          Height = 21
          DataField = 'E T ingresso acqua'
          DataSource = DataSource1
          TabOrder = 2
        end
        object DBEdit13: TDBEdit
          Left = 8
          Top = 96
          Width = 65
          Height = 21
          DataField = 'E Salto termico acqua'
          DataSource = DataSource1
          TabOrder = 3
        end
        object DBEdit17: TDBEdit
          Left = 8
          Top = 120
          Width = 65
          Height = 21
          DataSource = DataSource1
          TabOrder = 4
        end
        object DBEdit18: TDBEdit
          Left = 8
          Top = 144
          Width = 65
          Height = 21
          DataSource = DataSource1
          TabOrder = 5
        end
      end
      object GroupBox7: TGroupBox
        Left = 216
        Top = 16
        Width = 97
        Height = 169
        Caption = 'Inverno'
        TabOrder = 1
        object DBEdit14: TDBEdit
          Left = 8
          Top = 16
          Width = 65
          Height = 21
          DataField = 'I Potenza sensibile'
          DataSource = DataSource1
          TabOrder = 0
        end
        object DBEdit15: TDBEdit
          Left = 8
          Top = 72
          Width = 65
          Height = 21
          DataField = 'I T ingresso acqua'
          DataSource = DataSource1
          TabOrder = 1
        end
        object DBEdit16: TDBEdit
          Left = 8
          Top = 96
          Width = 65
          Height = 21
          DataField = 'I Salto termico acqua'
          DataSource = DataSource1
          TabOrder = 2
        end
        object DBEdit19: TDBEdit
          Left = 8
          Top = 120
          Width = 65
          Height = 21
          DataSource = DataSource1
          TabOrder = 3
        end
        object DBEdit20: TDBEdit
          Left = 8
          Top = 144
          Width = 65
          Height = 21
          DataSource = DataSource1
          TabOrder = 4
        end
      end
    end
    object GroupBox8: TGroupBox
      Left = 328
      Top = 48
      Width = 129
      Height = 81
      Caption = 'Tipo di impianto'
      TabOrder = 5
      object RadioButton1: TRadioButton
        Left = 8
        Top = 24
        Width = 113
        Height = 17
        Caption = '2 tubi'
        Checked = True
        TabOrder = 0
        TabStop = True
      end
      object RadioButton2: TRadioButton
        Left = 8
        Top = 48
        Width = 65
        Height = 17
        Caption = '4 tubi'
        TabOrder = 1
      end
    end
    object DBGrid1: TDBGrid
      Left = 328
      Top = 136
      Width = 129
      Height = 273
      DataSource = DataSource2
      TabOrder = 6
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'MS Sans Serif'
      TitleFont.Style = []
    end
  end
  object DataSource1: TDataSource
    DataSet = Table1
    Left = 416
    Top = 96
  end
  object Table1: TTable
    DatabaseName = 'c:\terminali'
    TableName = 'Terminale.DB'
    Left = 416
    Top = 136
  end
  object Table2: TTable
    Left = 416
    Top = 216
  end
  object DataSource2: TDataSource
    DataSet = Table2
    Left = 416
    Top = 176
  end
end
