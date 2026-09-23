object FCarburanti: TFCarburanti
  Left = 303
  Top = 213
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'Elenco fonti energetiche'
  ClientHeight = 366
  ClientWidth = 684
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 337
    Width = 684
    Height = 29
    Align = alBottom
    BevelInner = bvLowered
    TabOrder = 0
    object LbSpeedButton1: TLbSpeedButton
      Left = 592
      Top = 4
      Width = 89
      Height = 23
      Hint = 'Effettua i calcoli '
      Alignment = taCenter
      Caption = 'Chiudi'
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
      OnClick = LbSpeedButton1Click
    end
    object LbSpeedButton2: TLbSpeedButton
      Left = 409
      Top = 4
      Width = 89
      Height = 23
      Hint = 'Effettua i calcoli '
      Alignment = taCenter
      Caption = 'Conferma'
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
    object LbSpeedButton3: TLbSpeedButton
      Left = 500
      Top = 4
      Width = 89
      Height = 23
      Hint = 'Effettua i calcoli '
      Alignment = taCenter
      Caption = 'Nuovo'
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
      OnClick = LbSpeedButton3Click
    end
  end
  object DBGrid1: TDBGrid
    Left = 0
    Top = 0
    Width = 320
    Height = 337
    Align = alLeft
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    Options = [dgEditing, dgTitles, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit]
    ParentFont = False
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = 13339492
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = [fsBold]
  end
  object GroupBox1: TGroupBox
    Left = 320
    Top = 0
    Width = 364
    Height = 337
    Align = alClient
    Caption = 'Dettaglio'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = 13339492
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 2
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
      Width = 170
      Height = 13
      Caption = 'TEP/mc Tonn. Equivalenti Petrolio :'
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
      Top = 164
      Width = 360
      Height = 171
      Align = alBottom
      Caption = 'Utility di calcolo'
      TabOrder = 4
      object Label5: TLabel
        Left = 5
        Top = 24
        Width = 190
        Height = 13
        Caption = 'Prezzo del KW/h (energia elettrica)Euro:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object LbKWH: TLbSpeedButton
        Left = 265
        Top = 19
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
        OnClick = LbKWHClick
      end
      object EKWH: TEdit
        Left = 198
        Top = 20
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
    end
  end
end
