object FCarburanti3D: TFCarburanti3D
  Left = 496
  Top = 218
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'Elenco fonti energetiche'
  ClientHeight = 292
  ClientWidth = 336
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox1: TGroupBox
    Left = 0
    Top = 0
    Width = 336
    Height = 292
    Align = alClient
    Caption = #167'Carburanti::'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = 13339492
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    object Label1: TLabel
      Left = 16
      Top = 24
      Width = 111
      Height = 13
      Caption = 'Potere calorifico Kj/kg :'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label2: TLabel
      Left = 16
      Top = 56
      Width = 169
      Height = 13
      Caption = 'kgep/kg   (kg. equivalenti Petrolio) :'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label3: TLabel
      Left = 16
      Top = 88
      Width = 74
      Height = 13
      Caption = 'Densit'#224'  Kg/mc'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label4: TLabel
      Left = 16
      Top = 120
      Width = 76
      Height = 13
      Caption = 'Prezzo Euro/MJ'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label8: TLabel
      Left = 16
      Top = 147
      Width = 58
      Height = 13
      Caption = 'Aggiornato il'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object DBEdit1: TDBEdit
      Tag = 3
      Left = 191
      Top = 20
      Width = 81
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
    object DBEdit2: TDBEdit
      Tag = 4
      Left = 191
      Top = 52
      Width = 81
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
    object DBEdit3: TDBEdit
      Tag = 5
      Left = 191
      Top = 84
      Width = 81
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
    object DBEdit4: TDBEdit
      Tag = 6
      Left = 191
      Top = 116
      Width = 81
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
    object GroupBox2: TGroupBox
      Left = 2
      Top = 177
      Width = 332
      Height = 113
      Align = alBottom
      Caption = 'Utility di calcolo'
      TabOrder = 4
      object Label6: TLabel
        Left = 13
        Top = 88
        Width = 35
        Height = 13
        Caption = 'Prezzo '
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object LbSpeedButton1: TLbSpeedButton
        Left = 201
        Top = 83
        Width = 89
        Height = 23
        Hint = 'Effettua i calcoli '
        Alignment = taCenter
        Caption = 'Conferma'
        ColorWhenDown = 535020206
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        HotTrackFont.Charset = DEFAULT_CHARSET
        HotTrackFont.Color = clWindowText
        HotTrackFont.Height = -11
        HotTrackFont.Name = 'MS Sans Serif'
        HotTrackFont.Style = []
        NumGlyphs = 1
        ParentFont = False
        ParentShowHint = False
        ShowHint = True
        Style = bsModern
        OnClick = LbSpeedButton1Click
      end
      object Label5: TLabel
        Left = 8
        Top = 32
        Width = 169
        Height = 13
        Caption = 'Fonte energetica  ( Dlgs 115/2008 )'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object Label7: TLabel
        Left = 56
        Top = 88
        Width = 53
        Height = 13
        Caption = '( Euro/mc )'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object EDMetano: TEdit
        Left = 134
        Top = 84
        Width = 65
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
      object ComboBox1: TComboBox
        Left = 8
        Top = 56
        Width = 313
        Height = 22
        Style = csOwnerDrawFixed
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ItemHeight = 16
        ItemIndex = 1
        ParentFont = False
        TabOrder = 1
        Text = 'Gas naturale  ( 93% metano )'
        OnChange = ComboBox1Change
        Items.Strings = (
          'Energia elettrica'
          'Gas naturale  ( 93% metano )'
          'GPL'
          'Carbone'
          'Carbon fossile'
          'Mattonelle di lignite'
          'Lignite nera'
          'Lignite'
          'Scisti bituminosi'
          'Torba'
          'Mattonelle di torba'
          'Olio pesante residuo'
          'Olio combustibile'
          'Carburante ( benzina )'
          'Paraffina'
          'GNL'
          'Legname ( umidit'#224' 25 % )'
          'Pellet/mattoni di legno'
          'Rifiuti'
          'Calore derivato')
      end
    end
    object DBEdit5: TDBEdit
      Tag = 2
      Left = 191
      Top = 144
      Width = 81
      Height = 21
      BevelKind = bkFlat
      BorderStyle = bsNone
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 5
    end
  end
end
