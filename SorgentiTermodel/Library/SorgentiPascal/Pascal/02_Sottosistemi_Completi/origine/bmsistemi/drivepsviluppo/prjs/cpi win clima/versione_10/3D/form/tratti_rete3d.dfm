object FTrattirete3d: TFTrattirete3d
  Left = 484
  Top = 167
  BorderStyle = bsDialog
  Caption = 'Dettaglio del tratto di rete selezionato'
  ClientHeight = 297
  ClientWidth = 659
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  object PageControl6: TPageControl
    Left = 0
    Top = 153
    Width = 659
    Height = 117
    ActivePage = TabSheet21
    Align = alTop
    TabIndex = 0
    TabOrder = 0
    object TabSheet21: TTabSheet
      Caption = 'Arco-rete'
      object lfisso: TLabel
        Left = 263
        Top = 65
        Width = 9
        Height = 16
        Caption = '  '
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object LB_Lunghezza: TLabel
        Left = 7
        Top = 63
        Width = 55
        Height = 13
        Caption = 'Lunghezza '
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object Label67: TLabel
        Left = 609
        Top = 66
        Width = 25
        Height = 13
        Caption = '[kPa]'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object Label66: TLabel
        Left = 279
        Top = 64
        Width = 80
        Height = 13
        Caption = 'Perdita distribuita'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object Label55: TLabel
        Left = 417
        Top = 65
        Width = 25
        Height = 13
        Caption = '[kPa]'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object Label54: TLabel
        Left = 471
        Top = 66
        Width = 85
        Height = 13
        Caption = 'Perdita localizzata'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object Label53: TLabel
        Left = 609
        Top = 39
        Width = 24
        Height = 13
        Caption = '[m/s]'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object Label48: TLabel
        Left = 472
        Top = 40
        Width = 38
        Height = 13
        Caption = 'Velocit'#224
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object Label47: TLabel
        Left = 417
        Top = 39
        Width = 18
        Height = 13
        Caption = '[l/s]'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object Label46: TLabel
        Left = 117
        Top = 63
        Width = 14
        Height = 13
        Caption = '[m]'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object Label45: TLabel
        Left = 279
        Top = 39
        Width = 80
        Height = 13
        Caption = 'Portata calcolata'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object Label44: TLabel
        Left = 143
        Top = 63
        Width = 66
        Height = 13
        Caption = 'Sigla diametro'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object Label43: TLabel
        Left = 7
        Top = 37
        Width = 45
        Height = 13
        Caption = 'Tipo tubo'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object Label42: TLabel
        Left = 49
        Top = 16
        Width = 3
        Height = 13
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object Label41: TLabel
        Left = 7
        Top = 17
        Width = 33
        Height = 13
        Caption = 'Codice'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object Label10: TLabel
        Left = 56
        Top = 16
        Width = 38
        Height = 13
        Caption = 'Label10'
      end
      object Ed_PCar: TEdit
        Left = 366
        Top = 61
        Width = 48
        Height = 21
        AutoSelect = False
        BevelKind = bkFlat
        BorderStyle = bsNone
        Color = cl3DLight
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        ReadOnly = True
        TabOrder = 0
      end
      object Edit8: TEdit
        Left = 558
        Top = 62
        Width = 48
        Height = 21
        AutoSelect = False
        BevelKind = bkFlat
        BorderStyle = bsNone
        Color = cl3DLight
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        ReadOnly = True
        TabOrder = 1
      end
      object Edit5: TEdit
        Left = 366
        Top = 35
        Width = 48
        Height = 22
        AutoSelect = False
        BevelKind = bkFlat
        BorderStyle = bsNone
        Color = cl3DLight
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        ReadOnly = True
        TabOrder = 2
      end
      object Edit4: TEdit
        Left = 213
        Top = 60
        Width = 61
        Height = 21
        AutoSelect = False
        BevelKind = bkFlat
        BorderStyle = bsNone
        Color = cl3DLight
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        ReadOnly = True
        TabOrder = 3
      end
      object Edit1: TEdit
        Left = 64
        Top = 59
        Width = 48
        Height = 21
        AutoSelect = False
        BevelKind = bkFlat
        BorderStyle = bsNone
        Color = cl3DLight
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        ReadOnly = True
        TabOrder = 4
      end
      object ED_Velocita: TEdit
        Left = 558
        Top = 36
        Width = 48
        Height = 21
        AutoSelect = False
        BevelKind = bkFlat
        BorderStyle = bsNone
        Color = cl3DLight
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        ReadOnly = True
        TabOrder = 5
      end
      object ED_TipoTubo: TEdit
        Left = 64
        Top = 33
        Width = 210
        Height = 21
        AutoSelect = False
        BevelKind = bkFlat
        BorderStyle = bsNone
        Color = cl3DLight
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        ReadOnly = True
        TabOrder = 6
      end
    end
    object TabSheet22: TTabSheet
      Caption = 'Terminale'
      ImageIndex = 1
      object Label75: TLabel
        Left = 301
        Top = 40
        Width = 25
        Height = 13
        Caption = '[kPa]'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object Label74: TLabel
        Left = 178
        Top = 40
        Width = 43
        Height = 13
        Caption = 'Sbilancio'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object Label73: TLabel
        Left = 301
        Top = 14
        Width = 17
        Height = 13
        Caption = '[W]'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object Label72: TLabel
        Left = 125
        Top = 38
        Width = 25
        Height = 13
        Caption = '[kPa]'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object Label71: TLabel
        Left = 125
        Top = 15
        Width = 18
        Height = 13
        Caption = '[l/s]'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object Label70: TLabel
        Left = 179
        Top = 14
        Width = 39
        Height = 13
        Caption = 'Potenza'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object Label69: TLabel
        Left = 3
        Top = 38
        Width = 33
        Height = 13
        Caption = 'Perdita'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object Label68: TLabel
        Left = 3
        Top = 15
        Width = 34
        Height = 13
        Caption = 'Portata'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object Edit2: TEdit
        Left = 47
        Top = 11
        Width = 74
        Height = 21
        AutoSelect = False
        BevelKind = bkFlat
        BorderStyle = bsNone
        Color = cl3DLight
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        ReadOnly = True
        TabOrder = 0
      end
      object Edit7: TEdit
        Left = 223
        Top = 32
        Width = 74
        Height = 21
        AutoSelect = False
        BevelKind = bkFlat
        BorderStyle = bsNone
        Color = cl3DLight
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        ReadOnly = True
        TabOrder = 1
      end
      object Edit6: TEdit
        Left = 223
        Top = 10
        Width = 74
        Height = 21
        AutoSelect = False
        BevelKind = bkFlat
        BorderStyle = bsNone
        Color = cl3DLight
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        ReadOnly = True
        TabOrder = 2
      end
      object Edit3: TEdit
        Left = 47
        Top = 34
        Width = 74
        Height = 21
        AutoSelect = False
        BevelKind = bkFlat
        BorderStyle = bsNone
        Color = cl3DLight
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        ReadOnly = True
        TabOrder = 3
      end
    end
    object TabSheet23: TTabSheet
      Caption = 'Perdite'
      ImageIndex = 2
      object MPerdite: TMemo
        Left = 0
        Top = 0
        Width = 262
        Height = 89
        Align = alLeft
        BevelKind = bkFlat
        BorderStyle = bsNone
        Color = cl3DLight
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        HideSelection = False
        ParentFont = False
        ReadOnly = True
        TabOrder = 0
        WantReturns = False
      end
    end
  end
  object GroupBox1: TGroupBox
    Left = 0
    Top = 0
    Width = 659
    Height = 153
    Align = alTop
    TabOrder = 1
    object Label1: TLabel
      Left = 16
      Top = 24
      Width = 23
      Height = 13
      Caption = 'Rete'
    end
    object Label2: TLabel
      Left = 16
      Top = 48
      Width = 43
      Height = 13
      Caption = 'Tipologia'
    end
    object Label3: TLabel
      Left = 8
      Top = 80
      Width = 109
      Height = 13
      Caption = 'Informazioni sul calcolo'
    end
    object DBEdit1: TDBEdit
      Tag = 5
      Left = 64
      Top = 16
      Width = 121
      Height = 21
      TabOrder = 0
    end
    object DBEdit2: TDBEdit
      Tag = 11
      Left = 192
      Top = 16
      Width = 457
      Height = 21
      TabOrder = 1
    end
    object DBMemo1: TDBMemo
      Tag = 12
      Left = 2
      Top = 72
      Width = 655
      Height = 79
      Align = alBottom
      TabOrder = 2
    end
    object DBEdit3: TDBEdit
      Tag = 6
      Left = 64
      Top = 40
      Width = 121
      Height = 21
      TabOrder = 3
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 268
    Width = 659
    Height = 29
    Align = alBottom
    TabOrder = 2
    object Button1: TButton
      Left = 2
      Top = 3
      Width = 75
      Height = 25
      Caption = 'Chiudi'
      TabOrder = 0
      OnClick = Button1Click
    end
  end
end
