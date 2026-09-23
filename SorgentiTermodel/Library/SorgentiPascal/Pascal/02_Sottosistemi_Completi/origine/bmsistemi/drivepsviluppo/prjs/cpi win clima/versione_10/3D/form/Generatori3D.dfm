object FGeneratori3d: TFGeneratori3d
  Left = 494
  Top = 161
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'Generatori del progetto'
  ClientHeight = 343
  ClientWidth = 673
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox8: TGroupBox
    Left = 0
    Top = 0
    Width = 673
    Height = 82
    Align = alTop
    Caption = #167'GENERATORI:Dati generali:'
    Color = clBtnFace
    ParentColor = False
    TabOrder = 0
    object Label1: TLabel
      Left = 12
      Top = 21
      Width = 86
      Height = 13
      Caption = 'Tipo di generatore'
    end
    object Label4: TLabel
      Left = 348
      Top = 19
      Width = 227
      Height = 13
      Caption = 'Potenza nominale utile del sistema di produzione'
    end
    object Label2: TLabel
      Left = 12
      Top = 50
      Width = 37
      Height = 13
      Caption = 'Modello'
    end
    object Label6: TLabel
      Left = 643
      Top = 19
      Width = 17
      Height = 13
      Caption = '[W]'
    end
    object Label43: TLabel
      Left = 346
      Top = 53
      Width = 80
      Height = 13
      Caption = 'Fonte energetica'
    end
    object DBComboBox1: TDBComboBox
      Tag = 3
      Left = 105
      Top = 17
      Width = 225
      Height = 21
      Style = csDropDownList
      BevelKind = bkFlat
      ItemHeight = 13
      TabOrder = 0
      OnChange = DBComboBox1Change
    end
    object DBEdit2: TDBEdit
      Tag = 8
      Left = 585
      Top = 15
      Width = 55
      Height = 21
      BevelKind = bkFlat
      BorderStyle = bsNone
      TabOrder = 2
    end
    object DBEdit16: TDBEdit
      Tag = 4
      Left = 105
      Top = 46
      Width = 225
      Height = 21
      BevelKind = bkFlat
      BorderStyle = bsNone
      TabOrder = 1
    end
    object DBComboBox2: TDBComboBox
      Tag = 7
      Left = 440
      Top = 45
      Width = 225
      Height = 21
      Style = csDropDownList
      BevelKind = bkFlat
      ItemHeight = 13
      TabOrder = 3
    end
  end
  object GroupBox2: TGroupBox
    Left = 0
    Top = 82
    Width = 673
    Height = 96
    Align = alTop
    Caption = #167'GENERATORI:Fluido vettore: '
    Color = clBtnFace
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentColor = False
    ParentFont = False
    TabOrder = 1
    object Label5: TLabel
      Left = 10
      Top = 27
      Width = 21
      Height = 13
      Caption = 'Tipo'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label7: TLabel
      Left = 218
      Top = 31
      Width = 196
      Height = 13
      Caption = 'Temperatura di esercizio del fluido vettore'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label20: TLabel
      Left = 460
      Top = 31
      Width = 17
      Height = 13
      Caption = '['#176'C]'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label18: TLabel
      Left = 12
      Top = 60
      Width = 254
      Height = 13
      Caption = 'Potenza elettrica assorbita dalle pompe di circolazione'
    end
    object Label8: TLabel
      Left = 331
      Top = 60
      Width = 17
      Height = 13
      Caption = '[W]'
    end
    object DBComboBox3: TDBComboBox
      Tag = 6
      Left = 39
      Top = 23
      Width = 170
      Height = 21
      Style = csDropDownList
      BevelKind = bkFlat
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ItemHeight = 13
      ParentFont = False
      TabOrder = 0
    end
    object DBEdit3: TDBEdit
      Tag = 16
      Left = 416
      Top = 27
      Width = 40
      Height = 21
      BevelKind = bkFlat
      BorderStyle = bsNone
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
    end
    object DBEdit9: TDBEdit
      Tag = 9
      Left = 273
      Top = 56
      Width = 55
      Height = 21
      BevelKind = bkFlat
      BorderStyle = bsNone
      TabOrder = 2
    end
  end
  object GroupBox3: TGroupBox
    Left = 0
    Top = 178
    Width = 673
    Height = 168
    Align = alTop
    Caption = #167'GENERATORI:Generatore a combustione:'
    Color = clBtnFace
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentColor = False
    ParentFont = False
    TabOrder = 2
    object Label27: TLabel
      Left = 362
      Top = 78
      Width = 273
      Height = 13
      Caption = 'Per centrali esistenti si pu'#242' indicare lo stato del generatore'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label28: TLabel
      Left = 10
      Top = 31
      Width = 185
      Height = 13
      Caption = 'Pf : Perdite con generatore funzionante'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label29: TLabel
      Left = 10
      Top = 58
      Width = 173
      Height = 13
      Caption = 'Pfbs : Perdite con generatore spento'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label30: TLabel
      Left = 243
      Top = 31
      Width = 14
      Height = 13
      Caption = '[%]'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label31: TLabel
      Left = 243
      Top = 58
      Width = 14
      Height = 13
      Caption = '[%]'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label32: TLabel
      Left = 10
      Top = 142
      Width = 124
      Height = 13
      Caption = 'Rendimento al 100% di Pn'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label33: TLabel
      Left = 243
      Top = 142
      Width = 14
      Height = 13
      Caption = '[%]'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label39: TLabel
      Left = 10
      Top = 114
      Width = 118
      Height = 13
      Caption = 'Rendimento al 30% di Pn'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label40: TLabel
      Left = 243
      Top = 114
      Width = 14
      Height = 13
      Caption = '[%]'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label41: TLabel
      Left = 10
      Top = 85
      Width = 155
      Height = 13
      Caption = 'Pd : Perdite attraverso l'#39'involucro'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label42: TLabel
      Left = 243
      Top = 85
      Width = 14
      Height = 13
      Caption = '[%]'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object SpeedButton5: TLbSpeedButton
      Left = 265
      Top = 52
      Width = 23
      Height = 23
      Alignment = taCenter
      Color = clBtnFace
      ColorWhenDown = 535020206
      Glyph.Data = {
        36100000424D3610000000000000360000002800000020000000200000000100
        2000000000000010000000000000000000000000000000000000FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00000000000000
        0000000000000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF000000000000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000FFFF
        FF00000000000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF0000000000FFFFFF00000000000000000000000000FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000FFFF
        FF00000000000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF0000000000FFFFFF00000000000000000000000000FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00000000000000
        00000000000000000000000000000000000000000000FFFFFF00000000000000
        00000000000000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00000000000000
        0000FFFFFF00000000000000000000000000000000000000000000000000FFFF
        FF000000000000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00000000000000
        0000FFFFFF00000000000000000000000000C0C0C0000000000000000000FFFF
        FF000000000000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00000000000000
        0000FFFFFF00000000000000000000000000C0C0C0000000000000000000FFFF
        FF000000000000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000
        0000000000000000000000000000000000000000000000000000000000000000
        000000000000000000000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF0000000000FFFFFF00000000000000000000000000FFFFFF0000000000FFFF
        FF00000000000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF000000000000000000000000000000000000000000FFFFFF00000000000000
        0000000000000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00000000000000000000000000FFFFFF00FFFFFF00FFFFFF000000
        00000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF0000000000FFFFFF0000000000FFFFFF00FFFFFF00FFFFFF000000
        0000FFFFFF0000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00000000000000000000000000FFFFFF00FFFFFF00FFFFFF000000
        00000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00}
      HotTrackFont.Charset = DEFAULT_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -11
      HotTrackFont.Name = 'MS Sans Serif'
      HotTrackFont.Style = []
      NumGlyphs = 1
      ParentColor = False
      Style = bsModern
      Visible = False
    end
    object Label44: TLabel
      Left = 364
      Top = 23
      Width = 142
      Height = 13
      Caption = 'Potenza nominale del focolare'
    end
    object Label45: TLabel
      Left = 618
      Top = 23
      Width = 17
      Height = 13
      Caption = '[W]'
    end
    object Label37: TLabel
      Left = 364
      Top = 45
      Width = 188
      Height = 13
      Caption = 'Energia elettrica assorbita dal bruciatore'
    end
    object Label19: TLabel
      Left = 619
      Top = 45
      Width = 17
      Height = 13
      Caption = '[W]'
    end
    object DBComboBox5: TDBComboBox
      Tag = 15
      Left = 362
      Top = 97
      Width = 190
      Height = 21
      Style = csDropDownList
      BevelKind = bkFlat
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ItemHeight = 13
      ParentFont = False
      TabOrder = 5
    end
    object DBEdit12: TDBEdit
      Tag = 11
      Left = 199
      Top = 27
      Width = 40
      Height = 21
      BevelKind = bkFlat
      BorderStyle = bsNone
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
    end
    object DBEdit13: TDBEdit
      Tag = 12
      Left = 199
      Top = 54
      Width = 40
      Height = 21
      BevelKind = bkFlat
      BorderStyle = bsNone
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
    end
    object DBEdit14: TDBEdit
      Tag = 17
      Left = 199
      Top = 138
      Width = 40
      Height = 21
      BevelKind = bkFlat
      BorderStyle = bsNone
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 4
    end
    object DBEdit18: TDBEdit
      Tag = 18
      Left = 199
      Top = 110
      Width = 40
      Height = 21
      BevelKind = bkFlat
      BorderStyle = bsNone
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 3
    end
    object DBEdit19: TDBEdit
      Tag = 13
      Left = 199
      Top = 81
      Width = 40
      Height = 21
      BevelKind = bkFlat
      BorderStyle = bsNone
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
    end
    object DBEdit20: TDBEdit
      Tag = 10
      Left = 559
      Top = 19
      Width = 55
      Height = 21
      BevelKind = bkFlat
      BorderStyle = bsNone
      TabOrder = 6
    end
    object DBEdit17: TDBEdit
      Tag = 14
      Left = 561
      Top = 41
      Width = 55
      Height = 21
      BevelKind = bkFlat
      BorderStyle = bsNone
      TabOrder = 7
    end
    object DBCheckBox1: TDBCheckBox
      Tag = 71
      Left = 368
      Top = 144
      Width = 137
      Height = 17
      Caption = 'A condensazione'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 8
      ValueChecked = 'T'
      ValueUnchecked = 'F'
    end
  end
  object GroupBox11: TGroupBox
    Left = 0
    Top = 346
    Width = 673
    Height = 160
    Align = alTop
    Caption = #167'GENERATORI:Pompa di calore:'
    Color = clBtnFace
    ParentColor = False
    TabOrder = 3
    object Label35: TLabel
      Left = 12
      Top = 25
      Width = 165
      Height = 13
      Caption = 'Potenza frigo della pompa di calore'
    end
    object Label36: TLabel
      Left = 245
      Top = 25
      Width = 17
      Height = 13
      Caption = '[W]'
    end
    object Label17: TLabel
      Left = 304
      Top = 22
      Width = 183
      Height = 13
      Caption = 'Energia elettrica assorbita dagli ausiliari'
    end
    object Label22: TLabel
      Left = 577
      Top = 23
      Width = 17
      Height = 13
      Caption = '[W]'
    end
    object Label13: TLabel
      Left = 304
      Top = 45
      Width = 162
      Height = 13
      Caption = 'Temperatura della sorgente fredda'
    end
    object Label16: TLabel
      Left = 577
      Top = 45
      Width = 17
      Height = 13
      Caption = '['#176'C]'
    end
    object PageControl2: TPageControl
      Left = 2
      Top = 56
      Width = 669
      Height = 102
      ActivePage = TabSheet4
      Align = alBottom
      TabIndex = 1
      TabOrder = 0
      object TabSheet3: TTabSheet
        Caption = 'Elettrica'
        object GBPel: TGroupBox
          Left = 0
          Top = 0
          Width = 661
          Height = 74
          Align = alClient
          Color = clBtnFace
          ParentColor = False
          TabOrder = 0
          object Label10: TLabel
            Left = 8
            Top = 15
            Width = 38
            Height = 13
            Caption = 'COP E'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object Label15: TLabel
            Left = 50
            Top = 15
            Width = 162
            Height = 13
            Caption = 'Coefficiente di effetto utile elettrico'
          end
          object Label26: TLabel
            Left = 8
            Top = 42
            Width = 70
            Height = 13
            Caption = 'COP E Frigo'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object Label34: TLabel
            Left = 84
            Top = 42
            Width = 264
            Height = 13
            Caption = 'Coefficiente di effetto utile elettrico per la climatizzazione'
          end
          object DBEdit5: TDBEdit
            Tag = 21
            Left = 215
            Top = 12
            Width = 81
            Height = 21
            BevelKind = bkFlat
            BorderStyle = bsNone
            TabOrder = 0
          end
          object DBEdit11: TDBEdit
            Tag = 52
            Left = 352
            Top = 40
            Width = 81
            Height = 21
            BevelKind = bkFlat
            BorderStyle = bsNone
            TabOrder = 1
          end
        end
      end
      object TabSheet4: TTabSheet
        Caption = 'A motore'
        ImageIndex = 1
        object GBPmot: TGroupBox
          Left = 0
          Top = 0
          Width = 661
          Height = 74
          Align = alClient
          Color = clBtnFace
          ParentColor = False
          TabOrder = 0
          object Label75: TLabel
            Left = 8
            Top = 19
            Width = 38
            Height = 13
            Caption = 'COP T'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object Label80: TLabel
            Left = 49
            Top = 19
            Width = 159
            Height = 13
            Caption = 'Coefficiente di effetto utile termico'
          end
          object Label85: TLabel
            Left = 8
            Top = 44
            Width = 70
            Height = 13
            Caption = 'COP T Frigo'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object Label86: TLabel
            Left = 81
            Top = 44
            Width = 224
            Height = 13
            Caption = 'Coefficiente di effetto utile per la climatizzazione'
          end
          object DBEdit34: TDBEdit
            Tag = 20
            Left = 213
            Top = 15
            Width = 81
            Height = 21
            BevelKind = bkFlat
            BorderStyle = bsNone
            TabOrder = 0
          end
          object DBEdit38: TDBEdit
            Tag = 51
            Left = 310
            Top = 41
            Width = 81
            Height = 21
            BevelKind = bkFlat
            BorderStyle = bsNone
            TabOrder = 1
          end
        end
      end
    end
    object DBEdit15: TDBEdit
      Tag = 50
      Left = 187
      Top = 21
      Width = 55
      Height = 21
      BevelKind = bkFlat
      BorderStyle = bsNone
      TabOrder = 1
    end
    object DBEdit7: TDBEdit
      Tag = 19
      Left = 494
      Top = 19
      Width = 81
      Height = 21
      BevelKind = bkFlat
      BorderStyle = bsNone
      TabOrder = 2
    end
    object DBEdit6: TDBEdit
      Tag = 22
      Left = 494
      Top = 42
      Width = 81
      Height = 21
      BevelKind = bkFlat
      BorderStyle = bsNone
      TabOrder = 3
    end
  end
  object Panel6: TPanel
    Left = 0
    Top = 315
    Width = 673
    Height = 28
    Align = alBottom
    BevelInner = bvLowered
    TabOrder = 4
    object LbSpeedButton2: TLbSpeedButton
      Left = 5
      Top = 2
      Width = 179
      Height = 23
      Hint = 'Cancella l'#39'elemento selezionato'
      Alignment = taCenter
      Caption = 'Salva nell'#39'archivio personale'
      ColorWhenDown = 535020206
      HotTrackFont.Charset = DEFAULT_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -11
      HotTrackFont.Name = 'MS Sans Serif'
      HotTrackFont.Style = []
      NumGlyphs = 1
      ParentShowHint = False
      ShowHint = True
      Style = bsModern
      OnClick = LbSpeedButton2Click
    end
    object LbSpeedButton6: TLbSpeedButton
      Left = 186
      Top = 2
      Width = 156
      Height = 23
      Hint = 'Cancella l'#39'elemento selezionato'
      Alignment = taCenter
      Caption = 'Inporta dall'#39'archivio personale'
      ColorWhenDown = 535020206
      HotTrackFont.Charset = DEFAULT_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -11
      HotTrackFont.Name = 'MS Sans Serif'
      HotTrackFont.Style = []
      NumGlyphs = 1
      ParentShowHint = False
      ShowHint = True
      Style = bsModern
      OnClick = LbSpeedButton6Click
    end
    object LbSpeedButton7: TLbSpeedButton
      Left = 349
      Top = 2
      Width = 153
      Height = 23
      Hint = 'Cancella l'#39'elemento selezionato'
      Alignment = taCenter
      Caption = 'Inporta dall'#39'archivio generale'
      ColorWhenDown = 535020206
      HotTrackFont.Charset = DEFAULT_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -11
      HotTrackFont.Name = 'MS Sans Serif'
      HotTrackFont.Style = []
      NumGlyphs = 1
      ParentShowHint = False
      ShowHint = True
      Style = bsModern
      OnClick = LbSpeedButton7Click
    end
  end
end
