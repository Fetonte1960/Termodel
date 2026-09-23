object FGestDb: TFGestDb
  Left = 538
  Top = 164
  Width = 712
  Height = 575
  Caption = 'Definizione del Database'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox1: TGroupBox
    Left = 0
    Top = 0
    Width = 704
    Height = 89
    Align = alTop
    Caption = #167'Rec::'
    TabOrder = 0
    object Label1: TLabel
      Left = 8
      Top = 24
      Width = 122
      Height = 13
      Caption = 'Numero massimo elementi'
    end
    object Label4: TLabel
      Left = 240
      Top = 24
      Width = 61
      Height = 13
      Caption = 'Tipo archivio'
    end
    object Label5: TLabel
      Left = 8
      Top = 64
      Width = 83
      Height = 13
      Caption = 'Tabella associata'
    end
    object Label7: TLabel
      Left = 480
      Top = 24
      Width = 27
      Height = 13
      Caption = 'Menu'
    end
    object DBEdit1: TDBEdit
      Tag = 3
      Left = 144
      Top = 19
      Width = 81
      Height = 21
      TabOrder = 0
    end
    object DBComboBox2: TDBComboBox
      Tag = 4
      Left = 316
      Top = 18
      Width = 145
      Height = 21
      ItemHeight = 13
      TabOrder = 1
    end
    object DBComboBox3: TDBComboBox
      Tag = 5
      Left = 104
      Top = 56
      Width = 241
      Height = 21
      ItemHeight = 13
      TabOrder = 2
    end
    object DBEdit4: TDBEdit
      Tag = 6
      Left = 522
      Top = 18
      Width = 121
      Height = 21
      TabOrder = 3
    end
    object DBCheckBox1: TDBCheckBox
      Tag = 7
      Left = 368
      Top = 56
      Width = 177
      Height = 17
      Caption = 'Aggiorna automaticamente'
      TabOrder = 4
      ValueChecked = 'SI'
      ValueUnchecked = 'NO'
    end
  end
  object GroupBox2: TGroupBox
    Left = 0
    Top = 89
    Width = 241
    Height = 452
    Align = alLeft
    Caption = #167'Campi:Elenco dei campi:'
    TabOrder = 1
    object DBGrid1: TDBGrid
      Left = 2
      Top = 15
      Width = 237
      Height = 410
      Align = alClient
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'MS Sans Serif'
      TitleFont.Style = []
    end
    object DBNavigator1: TDBNavigator
      Left = 2
      Top = 425
      Width = 237
      Height = 25
      Align = alBottom
      TabOrder = 1
    end
  end
  object GroupBox3: TGroupBox
    Left = 241
    Top = 89
    Width = 463
    Height = 452
    Align = alClient
    Caption = #167'Campi:Dettaglio del campo selezionato:'
    TabOrder = 2
    object Label2: TLabel
      Left = 16
      Top = 24
      Width = 55
      Height = 13
      Caption = 'Descrizione'
    end
    object Label3: TLabel
      Left = 16
      Top = 64
      Width = 56
      Height = 13
      Caption = 'Tipo di dato'
    end
    object Label6: TLabel
      Left = 250
      Top = 59
      Width = 78
      Height = 13
      Caption = 'Numero caratteri'
    end
    object Label8: TLabel
      Left = 16
      Top = 104
      Width = 56
      Height = 13
      Caption = 'Tipo campo'
    end
    object Label9: TLabel
      Left = 18
      Top = 131
      Width = 85
      Height = 13
      Caption = 'Dimensione griglia'
    end
    object Label10: TLabel
      Left = 152
      Top = 132
      Width = 87
      Height = 13
      Caption = '[ -1 non visualizza]'
    end
    object Label11: TLabel
      Left = 16
      Top = 165
      Width = 123
      Height = 13
      Caption = 'Aggancio ad altro archivio'
    end
    object Label12: TLabel
      Left = 296
      Top = 165
      Width = 33
      Height = 13
      Caption = 'Campo'
    end
    object Label13: TLabel
      Left = 176
      Top = 192
      Width = 50
      Height = 13
      Caption = 'Combobox'
    end
    object DBEdit2: TDBEdit
      Tag = 2
      Left = 80
      Top = 20
      Width = 353
      Height = 21
      TabOrder = 0
    end
    object DBComboBox1: TDBComboBox
      Tag = 3
      Left = 80
      Top = 56
      Width = 161
      Height = 21
      ItemHeight = 13
      TabOrder = 1
    end
    object DBEdit3: TDBEdit
      Tag = 4
      Left = 336
      Top = 56
      Width = 41
      Height = 21
      TabOrder = 2
    end
    object DBComboBox4: TDBComboBox
      Tag = 6
      Left = 80
      Top = 96
      Width = 161
      Height = 21
      ItemHeight = 13
      TabOrder = 3
    end
    object DBEdit5: TDBEdit
      Tag = 7
      Left = 106
      Top = 128
      Width = 42
      Height = 21
      TabOrder = 4
    end
    object DBComboBox5: TDBComboBox
      Tag = 8
      Left = 152
      Top = 160
      Width = 137
      Height = 21
      ItemHeight = 13
      TabOrder = 5
    end
    object DBEdit6: TDBEdit
      Tag = 9
      Left = 344
      Top = 160
      Width = 105
      Height = 21
      TabOrder = 6
    end
    object DBEdit7: TDBEdit
      Tag = 10
      Left = 8
      Top = 208
      Width = 449
      Height = 21
      TabOrder = 7
    end
    object DBEdit8: TDBEdit
      Tag = 11
      Left = 8
      Top = 229
      Width = 449
      Height = 21
      TabOrder = 8
    end
    object DBEdit9: TDBEdit
      Tag = 12
      Left = 9
      Top = 250
      Width = 449
      Height = 21
      TabOrder = 9
    end
    object DBEdit10: TDBEdit
      Tag = 13
      Left = 9
      Top = 271
      Width = 449
      Height = 21
      TabOrder = 10
    end
    object DBEdit11: TDBEdit
      Tag = 14
      Left = 8
      Top = 292
      Width = 449
      Height = 21
      TabOrder = 11
    end
    object DBEdit12: TDBEdit
      Tag = 15
      Left = 8
      Top = 313
      Width = 449
      Height = 21
      TabOrder = 12
    end
    object DBEdit13: TDBEdit
      Tag = 16
      Left = 9
      Top = 334
      Width = 449
      Height = 21
      TabOrder = 13
    end
    object DBEdit14: TDBEdit
      Tag = 17
      Left = 9
      Top = 355
      Width = 449
      Height = 21
      TabOrder = 14
    end
    object DBEdit15: TDBEdit
      Tag = 18
      Left = 8
      Top = 376
      Width = 449
      Height = 21
      TabOrder = 15
    end
    object DBEdit16: TDBEdit
      Tag = 19
      Left = 8
      Top = 397
      Width = 449
      Height = 21
      TabOrder = 16
    end
  end
end
