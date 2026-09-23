object FZone3d: TFZone3d
  Left = 499
  Top = 199
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'Zone del progetto'
  ClientHeight = 340
  ClientWidth = 611
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
  object GBEdifZone: TGroupBox
    Left = 0
    Top = 0
    Width = 611
    Height = 129
    Align = alTop
    Caption = #167'ZONE:Caratteristiche generali:'
    TabOrder = 0
    object Label38: TLabel
      Left = 16
      Top = 28
      Width = 142
      Height = 13
      Caption = 'Altezza soffitto ricorrente netta'
    end
    object Label42: TLabel
      Left = 207
      Top = 28
      Width = 14
      Height = 13
      Caption = '[m]'
    end
    object Label83: TLabel
      Left = 245
      Top = 28
      Width = 60
      Height = 13
      Caption = 'Temperatura'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label103: TLabel
      Left = 421
      Top = 28
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
    object Label84: TLabel
      Left = 446
      Top = 28
      Width = 72
      Height = 13
      Caption = 'Umidit'#224' relativa'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label102: TLabel
      Left = 585
      Top = 28
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
    object Label115: TLabel
      Left = 17
      Top = 79
      Width = 135
      Height = 13
      Caption = 'Ricambi Naturali (Infiltrazioni)'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      WordWrap = True
    end
    object Label117: TLabel
      Left = 196
      Top = 80
      Width = 32
      Height = 13
      Caption = '[Vol/h]'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object LbSpeedButton3: TLbSpeedButton
      Left = 656
      Top = 74
      Width = 121
      Height = 23
      Hint = 'Cancella l'#39'elemento selezionato'
      Alignment = taCenter
      Caption = 'Suddivisione in zone'
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
      Visible = False
    end
    object Label10: TLabel
      Left = 244
      Top = 73
      Width = 231
      Height = 26
      Caption = 
        'Incremento delle dispersioni per tenere conto del funzionamento ' +
        'intermittente dell'#39'impianto'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      WordWrap = True
    end
    object Label11: TLabel
      Left = 540
      Top = 80
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
    object Label1: TLabel
      Left = 243
      Top = 52
      Width = 110
      Height = 13
      Caption = 'Temperatura se assenti'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label2: TLabel
      Left = 422
      Top = 52
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
    object DBEdit53: TDBEdit
      Tag = 7
      Left = 164
      Top = 24
      Width = 40
      Height = 21
      BevelKind = bkFlat
      BorderStyle = bsNone
      TabOrder = 0
    end
    object DBEdit51: TDBEdit
      Tag = 20
      Left = 362
      Top = 24
      Width = 50
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
    object DBEdit52: TDBEdit
      Tag = 21
      Left = 523
      Top = 24
      Width = 50
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
    object DBEdit46: TDBEdit
      Tag = 2
      Left = 154
      Top = 76
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
    object DBEdit6: TDBEdit
      Tag = 60
      Left = 498
      Top = 76
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
    object DBEdit1: TDBEdit
      Tag = 77
      Left = 363
      Top = 48
      Width = 50
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
