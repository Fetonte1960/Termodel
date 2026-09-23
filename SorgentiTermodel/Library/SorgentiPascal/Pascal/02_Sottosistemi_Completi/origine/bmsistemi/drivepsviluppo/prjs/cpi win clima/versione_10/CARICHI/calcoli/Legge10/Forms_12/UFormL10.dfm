object FCalcL10: TFCalcL10
  Left = 546
  Top = 206
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 
    'Calcolo delle Dispersioni Termiche e del Fabbisogno Convenzional' +
    'e di Energia Primaria'
  ClientHeight = 576
  ClientWidth = 844
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnActivate = FormActivate
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object Panel_Bottoni: TPanel
    Left = 0
    Top = 547
    Width = 844
    Height = 29
    Align = alBottom
    BevelInner = bvLowered
    TabOrder = 0
    object B_Chiudi: TLbSpeedButton
      Left = 752
      Top = 3
      Width = 89
      Height = 25
      Hint = 'Chiude la finestra'
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
      OnClick = B_ChiudiClick
    end
    object LB_Tutor: TLbSpeedButton
      Left = 662
      Top = 3
      Width = 89
      Height = 25
      Hint = 'Tutor operazione'
      Alignment = taCenter
      Caption = 'Tutor operazione'
      ColorWhenDown = 14926510
      HotTrackFont.Charset = DEFAULT_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -11
      HotTrackFont.Name = 'MS Sans Serif'
      HotTrackFont.Style = []
      ParentShowHint = False
      ShowHint = True
      Style = bsModern
      Visible = False
      OnClick = LB_TutorClick
    end
  end
  object P_Base: TPanel
    Left = 0
    Top = 0
    Width = 844
    Height = 547
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 1
    object LB_TipoOpera: TLabel
      Left = 6
      Top = 20
      Width = 62
      Height = 13
      Caption = 'Tipo opera'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 13339492
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object SB_TipoOpera: TLbSpeedButton
      Left = 426
      Top = 16
      Width = 23
      Height = 23
      Alignment = taCenter
      Color = clBtnFace
      ColorWhenDown = 535020206
      Glyph.Data = {
        36030000424D3603000000000000360000002800000010000000100000000100
        18000000000000030000120B0000120B00000000000000000000FFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFF8F8F8D0D0D0BABABABABABAD0D0D0F8F8F8FFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFABA19BA68168C78F69D4
        976ED4976EC78F69A68168ABA19BFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        F0F0F0A2826EF8B585FFD4A7FFD5ABFFD4A8FFD4A8FFD5ABFFD4A7F8B585A282
        6EF0F0F0FFFFFFFFFFFFFFFFFFFAFAFAA8836AFFD3A2FFCEA5FCBC93F6B488F0
        AD81F0AD81F6B488FCBC93FFCEA5FFD3A2A8836AFAFAFAFFFFFFFFFFFFA8968B
        FFC291FFC398F4B185F3AB7BEFB792FAF5F1FAF5F1EFB792F3AB7BF4B185FFC3
        98FFC291A8968BFFFFFFE7E6E6CE8E65FFC598EFA97DF0AD80EEA370EDB793FF
        FFFFFFFFFFEDB793EEA370F0AD80EFA97DFFC598CE8E65E7E6E6B9ADA6F8AD7C
        F2AF83E9A476EBA678EA9C69EBB28DFFFFFFFFFFFFEBB28DEA9C69EBA678E9A4
        76F2AF83F8AD7CB9ADA6A8978BFDB27FE69F71E49D6EE59D6EE3935FE8AD86FF
        FFFFFFFFFFE8AD86E3935FE59D6EE49D6EE69F71FDB27FA8978BA39082FBAE7A
        DD9463DE9565E09869DC8C55E6AE88FFFFFFFFFFFFE6AE88DC8C55E09869DE95
        65DD9463FBAE7AA39082AB9A8FF0A26FD68E5EDA996DDE9E73DD9B6DDE9E74EB
        C5ADEBC5ADDE9E74DD9B6DDE9E73DA996DD68E5EF0A26FAB9A8FC9BFB8E4925D
        D7986EDDAB89DEA985DDA37EE0A985F1D8C8F1D8C8E0A985DDA37EDEA985DDAB
        89D7986EE4925DC9BFB8F8F7F7C78252E3AB88E4C1AAE2BA9FDCA684ECCFBCFF
        FFFFFFFFFFECCFBCDCA684E2BA9FE4C1AAE3AB88C78252F8F7F7FFFFFFC5B4A8
        E6A57BF2DFD2EAD2C2E7C8B4E7C5AEF6E8DFF6E8DFE7C5AEE7C8B4EAD2C2F2DF
        D2E6A57BC5B4A8FFFFFFFFFFFFFFFFFFC39C82FCCCADFFFFFFFAF5F2F2E1D7EB
        CFBDEBCFBDF2E1D7FAF5F2FFFFFFFCCCADC39C82FFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFC5A48FE6B494FFF4ECFFFFFFFFFFFFFFFFFFFFFFFFFFF4EDE6B494C5A4
        8FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFDFD4CDC7A38BD1A68AD6
        B49DD7B49DD0A688C6A289DFD4CDFFFFFFFFFFFFFFFFFFFFFFFF}
      HotTrackFont.Charset = DEFAULT_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -11
      HotTrackFont.Name = 'Arial'
      HotTrackFont.Style = []
      NumGlyphs = 1
      ParentColor = False
      Style = bsModern
      Visible = False
      OnClick = SB_TipoOperaClick
    end
    object LB_Zona: TLabel
      Left = 473
      Top = 20
      Width = 93
      Height = 13
      Caption = 'Zona Climatica: '
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 13339492
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object LB_GradiG: TLabel
      Left = 634
      Top = 20
      Width = 80
      Height = 13
      Caption = 'Gradi Giorno: '
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 13339492
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object ST_Tipoopera: TStaticText
      Left = 72
      Top = 17
      Width = 351
      Height = 21
      AutoSize = False
      BevelInner = bvLowered
      BevelKind = bkFlat
      BevelOuter = bvRaised
      Caption = 
        'Nuova installazione e ristrutturazione integrale di impianti ter' +
        'mici'
      Color = 14811135
      ParentColor = False
      TabOrder = 0
    end
    object PageControl_Ris: TPageControl
      Left = 256
      Top = 51
      Width = 586
      Height = 497
      ActivePage = TabSheet_Risultati
      Style = tsButtons
      TabIndex = 0
      TabOrder = 1
      object TabSheet_Risultati: TTabSheet
        Caption = 'Risultati di Calcolo'
        object Label_Art7: TLabel
          Left = 9
          Top = 322
          Width = 166
          Height = 13
          Caption = 'Articolo 7 - comma 7 DPR 412 / 93'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          Visible = False
        end
        object GB_Dimens: TGroupBox
          Left = 5
          Top = 1
          Width = 250
          Height = 116
          Caption = ' Dimensioni '
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 13339492
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 0
          object LB_VolumeL: TLabel
            Left = 10
            Top = 67
            Width = 104
            Height = 13
            Caption = 'Volume lordo involuco'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            WordWrap = True
          end
          object Lb_m: TLabel
            Left = 210
            Top = 67
            Width = 17
            Height = 13
            Caption = '[m'#179']'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
          end
          object LB_SupL: TLabel
            Left = 10
            Top = 17
            Width = 119
            Height = 13
            Caption = 'Superficie lorda involucro'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            WordWrap = True
          end
          object LB_m2: TLabel
            Left = 210
            Top = 18
            Width = 17
            Height = 13
            Caption = '[m'#178']'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
          end
          object LB_SupP: TLabel
            Left = 10
            Top = 41
            Width = 124
            Height = 13
            Caption = 'Superficie utile pavimento '
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
          end
          object LB_m22: TLabel
            Left = 210
            Top = 42
            Width = 17
            Height = 13
            Caption = '[m'#178']'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
          end
          object Label_SV: TLabel
            Left = 11
            Top = 91
            Width = 69
            Height = 13
            Caption = 'Rapporto S/V '
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
          end
          object LB_m1: TLabel
            Left = 210
            Top = 91
            Width = 25
            Height = 13
            Caption = '[1/m]'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
          end
          object ST_VolLor: TStaticText
            Left = 134
            Top = 64
            Width = 72
            Height = 20
            Alignment = taRightJustify
            AutoSize = False
            BevelInner = bvNone
            BevelKind = bkFlat
            BevelOuter = bvNone
            BorderStyle = sbsSingle
            Color = cl3DLight
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentColor = False
            ParentFont = False
            TabOrder = 0
          end
          object ST_SupL: TStaticText
            Left = 134
            Top = 15
            Width = 72
            Height = 20
            Alignment = taRightJustify
            AutoSize = False
            BevelInner = bvNone
            BevelKind = bkFlat
            BevelOuter = bvNone
            BorderStyle = sbsSingle
            Color = cl3DLight
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentColor = False
            ParentFont = False
            TabOrder = 1
          end
          object ST_SupPav: TStaticText
            Left = 134
            Top = 39
            Width = 72
            Height = 20
            Alignment = taRightJustify
            AutoSize = False
            BevelInner = bvNone
            BevelKind = bkFlat
            BevelOuter = bvNone
            BorderStyle = sbsSingle
            Color = cl3DLight
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentColor = False
            ParentFont = False
            TabOrder = 2
          end
          object st_SV: TStaticText
            Left = 134
            Top = 88
            Width = 72
            Height = 20
            Alignment = taRightJustify
            AutoSize = False
            BevelInner = bvNone
            BevelKind = bkFlat
            BevelOuter = bvNone
            BorderStyle = sbsSingle
            Color = cl3DLight
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentColor = False
            ParentFont = False
            TabOrder = 3
          end
        end
        object GroupBox_Disper: TGroupBox
          Left = 259
          Top = 1
          Width = 316
          Height = 116
          Caption = ' Dispersioni '
          Ctl3D = True
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 13339492
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentCtl3D = False
          ParentFont = False
          TabOrder = 1
          object LB_Disp: TLabel
            Left = 10
            Top = 29
            Width = 172
            Height = 13
            Caption = 'Dispersioni termiche per trasmissione'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
          end
          object LB_W1: TLabel
            Left = 267
            Top = 28
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
          object LB_DispInf: TLabel
            Left = 9
            Top = 53
            Width = 155
            Height = 13
            Caption = 'Dispersioni termiche + Infiltrazioni'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            WordWrap = True
          end
          object LB_W2: TLabel
            Left = 267
            Top = 54
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
          object Label32: TLabel
            Left = 9
            Top = 78
            Width = 134
            Height = 13
            Caption = 'Dispersioni per Volume netto'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
          end
          object LB_wm3: TLabel
            Left = 266
            Top = 79
            Width = 33
            Height = 13
            Caption = '[W/m'#179']'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
          end
          object EN_DispPerCDInf: TStaticText
            Left = 188
            Top = 51
            Width = 76
            Height = 20
            Alignment = taRightJustify
            AutoSize = False
            BevelInner = bvNone
            BevelKind = bkFlat
            BevelOuter = bvNone
            BorderStyle = sbsSingle
            Color = cl3DLight
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentColor = False
            ParentFont = False
            TabOrder = 0
          end
          object EN_DispVol: TStaticText
            Left = 188
            Top = 76
            Width = 76
            Height = 20
            Alignment = taRightJustify
            AutoSize = False
            BevelInner = bvNone
            BevelKind = bkFlat
            BevelOuter = bvNone
            BorderStyle = sbsSingle
            Color = cl3DLight
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentColor = False
            ParentFont = False
            TabOrder = 1
          end
          object EN_DispPerCD: TStaticText
            Left = 188
            Top = 27
            Width = 76
            Height = 20
            Alignment = taRightJustify
            AutoSize = False
            BevelInner = bvNone
            BevelKind = bkFlat
            BevelOuter = bvNone
            BorderStyle = sbsSingle
            Color = cl3DLight
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentColor = False
            ParentFont = False
            TabOrder = 2
          end
        end
        object GB_Veriche192: TGroupBox
          Left = 5
          Top = 118
          Width = 570
          Height = 200
          Caption = ' VERIFICHE '
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 13339492
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 2
          object LB_Info: TLbSpeedButton
            Left = 532
            Top = 32
            Width = 23
            Height = 23
            Alignment = taCenter
            Color = clBtnFace
            ColorWhenDown = 535020206
            Glyph.Data = {
              36030000424D3603000000000000360000002800000010000000100000000100
              18000000000000030000120B0000120B00000000000000000000FFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFF8F8F8D0D0D0BABABABABABAD0D0D0F8F8F8FFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFABA19BA68168C78F69D4
              976ED4976EC78F69A68168ABA19BFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              F0F0F0A2826EF8B585FFD4A7FFD5ABFFD4A8FFD4A8FFD5ABFFD4A7F8B585A282
              6EF0F0F0FFFFFFFFFFFFFFFFFFFAFAFAA8836AFFD3A2FFCEA5FCBC93F6B488F0
              AD81F0AD81F6B488FCBC93FFCEA5FFD3A2A8836AFAFAFAFFFFFFFFFFFFA8968B
              FFC291FFC398F4B185F3AB7BEFB792FAF5F1FAF5F1EFB792F3AB7BF4B185FFC3
              98FFC291A8968BFFFFFFE7E6E6CE8E65FFC598EFA97DF0AD80EEA370EDB793FF
              FFFFFFFFFFEDB793EEA370F0AD80EFA97DFFC598CE8E65E7E6E6B9ADA6F8AD7C
              F2AF83E9A476EBA678EA9C69EBB28DFFFFFFFFFFFFEBB28DEA9C69EBA678E9A4
              76F2AF83F8AD7CB9ADA6A8978BFDB27FE69F71E49D6EE59D6EE3935FE8AD86FF
              FFFFFFFFFFE8AD86E3935FE59D6EE49D6EE69F71FDB27FA8978BA39082FBAE7A
              DD9463DE9565E09869DC8C55E6AE88FFFFFFFFFFFFE6AE88DC8C55E09869DE95
              65DD9463FBAE7AA39082AB9A8FF0A26FD68E5EDA996DDE9E73DD9B6DDE9E74EB
              C5ADEBC5ADDE9E74DD9B6DDE9E73DA996DD68E5EF0A26FAB9A8FC9BFB8E4925D
              D7986EDDAB89DEA985DDA37EE0A985F1D8C8F1D8C8E0A985DDA37EDEA985DDAB
              89D7986EE4925DC9BFB8F8F7F7C78252E3AB88E4C1AAE2BA9FDCA684ECCFBCFF
              FFFFFFFFFFECCFBCDCA684E2BA9FE4C1AAE3AB88C78252F8F7F7FFFFFFC5B4A8
              E6A57BF2DFD2EAD2C2E7C8B4E7C5AEF6E8DFF6E8DFE7C5AEE7C8B4EAD2C2F2DF
              D2E6A57BC5B4A8FFFFFFFFFFFFFFFFFFC39C82FCCCADFFFFFFFAF5F2F2E1D7EB
              CFBDEBCFBDF2E1D7FAF5F2FFFFFFFCCCADC39C82FFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFC5A48FE6B494FFF4ECFFFFFFFFFFFFFFFFFFFFFFFFFFF4EDE6B494C5A4
              8FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFDFD4CDC7A38BD1A68AD6
              B49DD7B49DD0A688C6A289DFD4CDFFFFFFFFFFFFFFFFFFFFFFFF}
            HotTrackFont.Charset = DEFAULT_CHARSET
            HotTrackFont.Color = clWindowText
            HotTrackFont.Height = -11
            HotTrackFont.Name = 'Arial'
            HotTrackFont.Style = []
            NumGlyphs = 1
            ParentColor = False
            Style = bsModern
            Visible = False
            OnClick = LB_InfoClick
          end
          object Label5: TLabel
            Left = 530
            Top = 171
            Width = 20
            Height = 13
            Caption = '[MJ]'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
          end
          object Label_FMJ: TLabel
            Left = 239
            Top = 170
            Width = 204
            Height = 13
            Caption = 'Fabbisogno convenzionale energia primaria'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            WordWrap = True
          end
          object Label_perc: TLabel
            Left = 453
            Top = 62
            Width = 14
            Height = 13
            Caption = '[%]'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
          end
          object Label_perc2: TLabel
            Left = 453
            Top = 88
            Width = 14
            Height = 13
            Caption = '[%]'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
          end
          object Label6: TLabel
            Left = 453
            Top = 37
            Width = 70
            Height = 13
            Caption = '[KWh/m'#178'anno]'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
          end
          object Label19: TLabel
            Left = 453
            Top = 114
            Width = 44
            Height = 13
            Caption = '[W/m'#179#176'C]'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
          end
          object Label_KJ: TLabel
            Left = 453
            Top = 140
            Width = 57
            Height = 13
            Caption = '[KJ/m'#179' g '#176'C]'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
          end
          object SB_VerPareti: TLbSpeedButton
            Left = 8
            Top = 163
            Width = 108
            Height = 25
            Hint = 'Effettua i calcoli '
            Alignment = taCenter
            Caption = 'Verifica Pareti'
            Color = clGreen
            ColorWhenDown = 535020206
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWhite
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            HotTrackFont.Charset = DEFAULT_CHARSET
            HotTrackFont.Color = clWindowText
            HotTrackFont.Height = -11
            HotTrackFont.Name = 'MS Sans Serif'
            HotTrackFont.Style = []
            NumGlyphs = 1
            ParentColor = False
            ParentFont = False
            ParentShowHint = False
            ShowHint = True
            Style = bsModern
            OnClick = SB_VerParetiClick
          end
          object SB_VerFinestre: TLbSpeedButton
            Left = 119
            Top = 163
            Width = 115
            Height = 25
            Hint = 'Effettua i calcoli '
            Alignment = taCenter
            Caption = 'Verifica Finestre'
            Color = clGreen
            ColorWhenDown = 535020206
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWhite
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            HotTrackFont.Charset = DEFAULT_CHARSET
            HotTrackFont.Color = clWindowText
            HotTrackFont.Height = -11
            HotTrackFont.Name = 'MS Sans Serif'
            HotTrackFont.Style = []
            NumGlyphs = 1
            ParentColor = False
            ParentFont = False
            ParentShowHint = False
            ShowHint = True
            Style = bsModern
            OnClick = SB_VerFinestreClick
          end
          object ST_Calcolato: TStaticText
            Left = 265
            Top = 9
            Width = 80
            Height = 21
            Alignment = taCenter
            AutoSize = False
            BevelKind = bkFlat
            BevelOuter = bvRaised
            BorderStyle = sbsSunken
            Caption = 'Calcolato'
            Color = 13339492
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWhite
            Font.Height = -12
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentColor = False
            ParentFont = False
            TabOrder = 0
          end
          object ST_ValoreLimite: TStaticText
            Left = 364
            Top = 9
            Width = 86
            Height = 21
            Alignment = taCenter
            AutoSize = False
            BevelKind = bkFlat
            BevelOuter = bvRaised
            BorderStyle = sbsSunken
            Caption = 'Valore Limite'
            Color = 13339492
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWhite
            Font.Height = -12
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentColor = False
            ParentFont = False
            TabOrder = 1
          end
          object ST_Feap: TStaticText
            Left = 8
            Top = 32
            Width = 250
            Height = 22
            AutoSize = False
            BevelInner = bvLowered
            BevelKind = bkFlat
            BevelOuter = bvRaised
            Caption = 'EP - Indice di prestazione energetica'
            Color = 14811135
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentColor = False
            ParentFont = False
            TabOrder = 2
          end
          object St_EtaG: TStaticText
            Left = 8
            Top = 58
            Width = 250
            Height = 22
            AutoSize = False
            BevelInner = bvLowered
            BevelKind = bkFlat
            BevelOuter = bvRaised
            Caption = 'Rendimento globale medio stagionale EtaG'
            Color = 14811135
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentColor = False
            ParentFont = False
            TabOrder = 3
          end
          object St_EtaP: TStaticText
            Left = 8
            Top = 84
            Width = 250
            Height = 22
            AutoSize = False
            BevelInner = bvLowered
            BevelKind = bkFlat
            BevelOuter = bvRaised
            Caption = 'Rendimento di produzione medio stagionale EtaP'
            Color = 14811135
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentColor = False
            ParentFont = False
            TabOrder = 4
          end
          object ST_ValLim: TStaticText
            Left = 365
            Top = 33
            Width = 84
            Height = 20
            Alignment = taRightJustify
            AutoSize = False
            BevelInner = bvNone
            BevelKind = bkFlat
            BevelOuter = bvNone
            BorderStyle = sbsSingle
            Color = cl3DLight
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentColor = False
            ParentFont = False
            TabOrder = 5
          end
          object ST_FabMJ: TStaticText
            Left = 446
            Top = 168
            Width = 82
            Height = 20
            Alignment = taRightJustify
            AutoSize = False
            BevelInner = bvNone
            BevelKind = bkFlat
            BevelOuter = bvNone
            BorderStyle = sbsSingle
            Color = cl3DLight
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentColor = False
            ParentFont = False
            TabOrder = 6
          end
          object ST_FabKW: TStaticText
            Left = 267
            Top = 33
            Width = 77
            Height = 20
            Alignment = taRightJustify
            AutoSize = False
            BevelInner = bvNone
            BevelKind = bkFlat
            BevelOuter = bvNone
            BorderStyle = sbsSingle
            Color = cl3DLight
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentColor = False
            ParentFont = False
            TabOrder = 7
          end
          object EN_RendCalcolato: TStaticText
            Left = 267
            Top = 59
            Width = 77
            Height = 20
            Alignment = taRightJustify
            AutoSize = False
            BevelInner = bvNone
            BevelKind = bkFlat
            BevelOuter = bvNone
            BorderStyle = sbsSingle
            Color = cl3DLight
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentColor = False
            ParentFont = False
            TabOrder = 8
          end
          object EN_RendMax: TStaticText
            Left = 365
            Top = 59
            Width = 84
            Height = 20
            Alignment = taRightJustify
            AutoSize = False
            BevelInner = bvNone
            BevelKind = bkFlat
            BevelOuter = bvNone
            BorderStyle = sbsSingle
            Color = cl3DLight
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentColor = False
            ParentFont = False
            TabOrder = 9
          end
          object ST_EtaPC: TStaticText
            Left = 267
            Top = 85
            Width = 77
            Height = 20
            Alignment = taRightJustify
            AutoSize = False
            BevelInner = bvNone
            BevelKind = bkFlat
            BevelOuter = bvNone
            BorderStyle = sbsSingle
            Color = cl3DLight
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentColor = False
            ParentFont = False
            TabOrder = 10
          end
          object ST_EtaPV: TStaticText
            Left = 365
            Top = 85
            Width = 84
            Height = 20
            Alignment = taRightJustify
            AutoSize = False
            BevelInner = bvNone
            BevelKind = bkFlat
            BevelOuter = bvNone
            BorderStyle = sbsSingle
            Color = cl3DLight
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentColor = False
            ParentFont = False
            TabOrder = 11
          end
          object St_CD: TStaticText
            Left = 8
            Top = 110
            Width = 250
            Height = 22
            AutoSize = False
            BevelInner = bvLowered
            BevelKind = bkFlat
            BevelOuter = bvRaised
            Caption = 'CD (Coefficiente volumico Dispersione)'
            Color = 14811135
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentColor = False
            ParentFont = False
            TabOrder = 12
          end
          object EN_CdCalcolato: TStaticText
            Left = 267
            Top = 111
            Width = 77
            Height = 20
            Alignment = taRightJustify
            AutoSize = False
            BevelInner = bvNone
            BevelKind = bkFlat
            BevelOuter = bvNone
            BorderStyle = sbsSingle
            Color = cl3DLight
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentColor = False
            ParentFont = False
            TabOrder = 13
          end
          object EN_CDLegge: TStaticText
            Left = 365
            Top = 111
            Width = 84
            Height = 20
            Alignment = taRightJustify
            AutoSize = False
            BevelInner = bvNone
            BevelKind = bkFlat
            BevelOuter = bvNone
            BorderStyle = sbsSingle
            Color = cl3DLight
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentColor = False
            ParentFont = False
            TabOrder = 14
          end
          object ST_Fen: TStaticText
            Left = 8
            Top = 136
            Width = 250
            Height = 22
            AutoSize = False
            BevelInner = bvLowered
            BevelKind = bkFlat
            BevelOuter = bvRaised
            Caption = 'FEN (Fabbisogno Energetico Normalizzato)'
            Color = 14811135
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentColor = False
            ParentFont = False
            TabOrder = 15
          end
          object EN_Fen: TStaticText
            Left = 267
            Top = 137
            Width = 77
            Height = 20
            Alignment = taRightJustify
            AutoSize = False
            BevelInner = bvNone
            BevelKind = bkFlat
            BevelOuter = bvNone
            BorderStyle = sbsSingle
            Color = cl3DLight
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentColor = False
            ParentFont = False
            TabOrder = 16
          end
          object EN_FenLimite: TStaticText
            Left = 365
            Top = 137
            Width = 84
            Height = 20
            Alignment = taRightJustify
            AutoSize = False
            BevelInner = bvNone
            BevelKind = bkFlat
            BevelOuter = bvNone
            BorderStyle = sbsSingle
            Color = cl3DLight
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentColor = False
            ParentFont = False
            TabOrder = 17
          end
          object LB_SM1: TLbStaticText
            Left = 347
            Top = 31
            Width = 18
            Height = 23
            Caption = '<'
            Flat = True
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = -13
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            HotTrackColor = clWhite
            HotTrackFont.Charset = DEFAULT_CHARSET
            HotTrackFont.Color = clWindowText
            HotTrackFont.Height = -11
            HotTrackFont.Name = 'MS Sans Serif'
            HotTrackFont.Style = []
            ParentFont = False
            ShadowColor = 11899524
          end
          object LB_SM2: TLbStaticText
            Left = 347
            Top = 57
            Width = 18
            Height = 23
            Caption = '<'
            Flat = True
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = -13
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            HotTrackColor = clWhite
            HotTrackFont.Charset = DEFAULT_CHARSET
            HotTrackFont.Color = clWindowText
            HotTrackFont.Height = -11
            HotTrackFont.Name = 'MS Sans Serif'
            HotTrackFont.Style = []
            ParentFont = False
            ShadowColor = 11899524
          end
          object LB_SM3: TLbStaticText
            Left = 347
            Top = 83
            Width = 18
            Height = 23
            Caption = '<'
            Flat = True
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = -13
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            HotTrackColor = clWhite
            HotTrackFont.Charset = DEFAULT_CHARSET
            HotTrackFont.Color = clWindowText
            HotTrackFont.Height = -11
            HotTrackFont.Name = 'MS Sans Serif'
            HotTrackFont.Style = []
            ParentFont = False
            ShadowColor = 11899524
          end
          object LB_SM4: TLbStaticText
            Left = 346
            Top = 109
            Width = 18
            Height = 23
            Caption = '<'
            Flat = True
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = -13
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            HotTrackColor = clWhite
            HotTrackFont.Charset = DEFAULT_CHARSET
            HotTrackFont.Color = clWindowText
            HotTrackFont.Height = -11
            HotTrackFont.Name = 'MS Sans Serif'
            HotTrackFont.Style = []
            ParentFont = False
            ShadowColor = 11899524
          end
          object LB_SM5: TLbStaticText
            Left = 347
            Top = 135
            Width = 18
            Height = 23
            Caption = '<'
            Flat = True
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = -13
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            HotTrackColor = clWhite
            HotTrackFont.Charset = DEFAULT_CHARSET
            HotTrackFont.Color = clWindowText
            HotTrackFont.Height = -11
            HotTrackFont.Name = 'MS Sans Serif'
            HotTrackFont.Style = []
            ParentFont = False
            ShadowColor = 11899524
          end
        end
        object EN_Articolo7: TStaticText
          Left = 9
          Top = 336
          Width = 559
          Height = 20
          AutoSize = False
          BevelInner = bvNone
          BevelKind = bkFlat
          BevelOuter = bvNone
          BorderStyle = sbsSingle
          Color = cl3DLight
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentColor = False
          ParentFont = False
          TabOrder = 3
          Visible = False
        end
        object GroupBox_VerCorr: TGroupBox
          Left = 0
          Top = 320
          Width = 579
          Height = 146
          Caption = ' Verifiche e correzioni '
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 13339492
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 4
          object ListBox_VerCor: TListBox
            Left = 2
            Top = 15
            Width = 575
            Height = 129
            Style = lbOwnerDrawVariable
            Align = alClient
            BevelKind = bkFlat
            BorderStyle = bsNone
            Color = clWhite
            ExtendedSelect = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ItemHeight = 13
            ParentFont = False
            TabOrder = 0
            OnDrawItem = ListBox_VerCorDrawItem
          end
        end
      end
      object TabSheet_Grafico: TTabSheet
        Caption = 'Distribuzione delle dispersioni'
        ImageIndex = 1
        object LB_frase: TLabel
          Left = 3
          Top = 453
          Width = 5
          Height = 13
          Alignment = taCenter
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object GraficoDispersioni: TChart
          Left = 0
          Top = 0
          Width = 563
          Height = 453
          AnimatedZoomSteps = 4
          BackWall.Brush.Color = clWhite
          LeftWall.Color = 13339492
          MarginBottom = 2
          MarginLeft = 1
          MarginRight = 2
          MarginTop = 1
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = 13339492
          Title.Font.Height = -16
          Title.Font.Name = 'Arial'
          Title.Font.Style = [fsBold]
          Title.Text.Strings = (
            'DISTRIBUZIONE DELLE DISPERSIONI')
          Chart3DPercent = 10
          LeftAxis.Labels = False
          LeftAxis.LabelsSeparation = 5
          LeftAxis.LabelStyle = talNone
          Legend.Alignment = laBottom
          Legend.Color = 14872561
          Legend.ColorWidth = 8
          Legend.LegendStyle = lsValues
          Legend.ShadowSize = 2
          Legend.TextStyle = ltsPlain
          RightAxis.Title.Font.Charset = DEFAULT_CHARSET
          RightAxis.Title.Font.Color = 13339492
          RightAxis.Title.Font.Height = -11
          RightAxis.Title.Font.Name = 'Arial'
          RightAxis.Title.Font.Style = []
          View3DOptions.Elevation = 326
          View3DOptions.Perspective = 0
          View3DOptions.Rotation = 360
          BevelOuter = bvNone
          TabOrder = 0
          object Series1: TBarSeries
            ColorEachPoint = True
            HorizAxis = aTopAxis
            Marks.Arrow.Color = clBlack
            Marks.ArrowLength = 8
            Marks.BackColor = 14872561
            Marks.Style = smsPercent
            Marks.Visible = True
            SeriesColor = clRed
            BarStyle = bsRectGradient
            BarWidthPercent = 80
            SideMargins = False
            XValues.DateTime = False
            XValues.Name = 'X'
            XValues.Multiplier = 1
            XValues.Order = loAscending
            YValues.DateTime = False
            YValues.Name = 'Bar'
            YValues.Multiplier = 1
            YValues.Order = loAscending
          end
        end
      end
      object TSheet_AttEnergEdif: TTabSheet
        Caption = 'Prestazione Energetica Edificio'
        ImageIndex = 2
        TabVisible = False
        object Label2: TLabel
          Left = 375
          Top = 49
          Width = 191
          Height = 13
          Caption = 'Indicatore Energetico dell'#39'edificio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 3703043
          Font.Height = -12
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label3: TLabel
          Left = 99
          Top = 68
          Width = 89
          Height = 13
          Caption = 'Basso consumo'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 5855577
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label4: TLabel
          Left = 16
          Top = 69
          Width = 33
          Height = 13
          Caption = 'Scala'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 5855577
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label7: TLabel
          Left = 381
          Top = 68
          Width = 82
          Height = 13
          Caption = '[kWh/m'#178'anno]'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 5855577
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label8: TLabel
          Left = 475
          Top = 68
          Width = 93
          Height = 13
          Caption = '[kJ/m'#179'giorno '#176'C]'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 5855577
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label9: TLabel
          Left = 99
          Top = 359
          Width = 77
          Height = 13
          Caption = 'Alto consumo'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 5855577
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object LB_Cat: TLabel
          Left = 98
          Top = 50
          Width = 109
          Height = 13
          Caption = 'Categoria consumo'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 3703043
          Font.Height = -12
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Shape1: TShape
          Left = 375
          Top = 86
          Width = 98
          Height = 42
          Brush.Color = 3703043
        end
        object Image1: TImage
          Left = 89
          Top = 86
          Width = 285
          Height = 267
          Picture.Data = {
            07544269746D6170AE8D0300424DAE8D03000000000036000000280000002201
            00000B0100000100180000000000788D03000000000000000000000000000000
            0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFDFDFDFBFBFBFAFAFAFAFAFAFAFAFAFAFA
            FAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFA
            FAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFA
            FAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFA
            FAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFA
            FAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFA
            FAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFA
            FAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFA
            FAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFA
            FAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFA
            FAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFA
            FAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFA
            FAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFA
            FAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFA
            FAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFA
            FAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFA
            FAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFA
            FAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFA
            FAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFA
            FAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFA
            FAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFA
            FAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFA
            FAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFA
            FAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFA
            FAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFBFBFBFDFDFDFEFE
            FEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFCFCFCF2F2F2E2E2E2D8D8D8
            D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8
            D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8
            D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8
            D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8
            D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8
            D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8
            D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8
            D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8
            D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8
            D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8
            D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8
            D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8
            D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8
            D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8
            D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8
            D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8
            D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8
            D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8
            D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8
            D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8
            D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8
            D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8
            D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8
            D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8
            DFDFDFEBEBEBF7F7F7FDFDFDFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFEFEF6F6F6DB
            DBDBADADAD949494919191919191919191919191919191919191919191909090
            9191919191919191919191919191919191919191919191919191919191919191
            9191919191919191919191919191919191919191919191919191919191919191
            9191919191919191919191919191919191919191919191919191919191919191
            9191919191919191919191919191919191919191919191919191919191919191
            9191919191919191919191919191919191919191919191919191919191919191
            9191919191919191919191919191919191919191919191919191919191919191
            9191919191919191919191919191919191919191919191919191919191919191
            9191919191919191919191919191919191919191919191919191919191919191
            9191919191919191919191919191919191919191919191919191919191919191
            9191919191919191919191919191919191919191919191919191919191919191
            9191919191919191919191919191919191919191919191919191919191919191
            9191919191919191919191919191919191919191919191919191919191919191
            9191919191919191919191919191919191919191919191919191919191919191
            9191919191919191919191919191919191919191919191919191919191919191
            9191919191919191919191919191919191919191919191919191919191919191
            9191919191919191919191919191919191919191919191919191919191919191
            9191919191919191919191919191919191919191919191919191919191919191
            9191919191919191919191919191919191919191919191919191919191919191
            9191919191919191919191919191919191919191919191919191919191919191
            9191919191919191919191919191919191919191919191919191919191919191
            9191919191919191919191919191919191919191919191919191919191919191
            9191919191919191919191919191919191919191919191919191919191919191
            9191919191919191919191919191919191919191919191919191919191919191
            9191919191939393A1A1A1BEBEBEDFDFDFF7F7F7FEFEFEFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFEFEFEF0F0F0C5C5C57878784F4F4F4A4A4A49494949494949494948484847
            4747464646454545454545464646474747484848494949494949494949494949
            4949494949494949494949494949494949494949494949494949494949494949
            4949494949494949494949494949494949494949494949494949494949494949
            4949494949494949494949494949494949494949494949494949494949494949
            4949494949494949494949494949494949494949494949494949494949494949
            4949494949494949494949494949494949494949494949494949494949494949
            4949494949494949494949494949494949494949494949494949494949494949
            4949494949494949494949494949494949494949494949494949494949494949
            4949494949494949494949494949494949494949494949494949494949494949
            4949494949494949494949494949494949494949494949494949494949494949
            4949494949494949494949494949494949494949494949494949494949494949
            4949494949494949494949494949494949494949494949494949494949494949
            4949494949494949494949494949494949494949494949494949494949494949
            4949494949494949494949494949494949494949494949494949494949494949
            4949494949494949494949494949494949494949494949494949494949494949
            4949494949494949494949494949494949494949494949494949494949494949
            4949494949494949494949494949494949494949494949494949494949494949
            4949494949494949494949494949494949494949494949494949494949494949
            4949494949494949494949494949494949494949494949494949494949494949
            4949494949494949494949494949494949494949494949494949494949494949
            4949494949494949494949494949494949494949494949494949494949494949
            4949494949494949494949494949494949494949494949494949494949494949
            4949494949494949494949494949494949494949494949494949494949494949
            494949494949494949494949494C4C4C5C5C5C7F7F7FB1B1B1E4E4E4FAFAFAFE
            FEFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFDFDFD8E9BEE2741E82741E82741E82741E8263FE7253E
            E3233AD51F35C21C30B11A2DA4192B9D192B9D1A2DA41C30B02036C3233AD525
            3EE0263FE62640E82741E82741E82741E82741E82741E82741E82741E82741E8
            2741E82741E82741E82741E82741E82741E82741E82741E82741E82741E82741
            E82741E82741E82741E82741E82741E82741E82741E82741E82741E82741E827
            41E82741E82741E82741E82741E82741E82741E82741E82741E82741E82741E8
            2741E82741E82741E82741E82741E82741E82741E82741E82741E82741E82741
            E82741E82741E82741E82741E82741E82741E82741E82741E82741E82741E827
            41E82741E82741E82741E82741E82741E82741E82741E82741E82741E82741E8
            2741E82741E82741E82741E82741E82741E82741E82741E82741E82741E82741
            E82741E82741E82741E82741E82741E82741E82741E82741E82741E82741E827
            41E82741E82741E82741E82741E82741E82741E82741E82741E82741E82741E8
            2741E82741E82741E82741E82741E82741E82741E82741E82741E82741E82741
            E82741E82741E82741E82741E82741E82741E82741E82741E82741E82741E827
            41E82741E82741E82741E82741E82741E82741E82741E82741E82741E82741E8
            2741E82741E82741E82741E82741E82741E82741E82741E82741E82741E82741
            E82741E82741E82741E82741E82741E82741E82741E82741E82741E82741E827
            41E82741E82741E82741E82741E82741E82741E82741E82741E82741E82741E8
            2741E82741E82741E82741E82741E82741E82741E82741E82741E82741E82741
            E82741E82741E82741E82741E82741E82741E82741E82741E82741E82741E827
            41E82741E82741E82741E82741E82741E82741E82741E82741E82741E82741E8
            2741E82741E82741E82741E82741E82741E82741E82741E82741E82741E82741
            E82741E82741E82741E82741E82741E82741E82741E82741E82741E82741E827
            41E82741E82741E82741E82741E82741E82741E82741E82741E82741E82741E8
            2741E82741E82741E82741E82741E82741E82741E8273FDB2E36654343436D6D
            6DAFAFAFE4E4E4F7F7F7FDFDFDFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFDFDFD8E9BEF2741E92741E92741E9
            2640E7243DDF2138CC1A2DA314217B101B640E18590D16530D16530E18570F1B
            6214217B1A2B9F1F35BF233BD82640E62741E92741E92741E92741E92741E927
            41E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741E9
            2741E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741
            E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741E927
            41E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741E9
            2741E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741
            E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741E927
            41E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741E9
            2741E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741
            E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741E927
            41E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741E9
            2741E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741
            E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741E927
            41E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741E9
            2741E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741
            E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741E927
            41E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741E9
            2741E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741
            E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741E927
            41E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741E9
            2741E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741
            E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741E927
            41E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741E9
            2640E828337B3939396D6D6DB2B2B2DDDDDDF4F4F4FDFDFDFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFDFDFD8D9AEE27
            41E92741E92640E8253EE22138CC1B2DA36069A2BBBDCEE4E5EBF2F3F5E8E9EE
            BABCCB797E9A242B570B1348101B651828912035C2253EE12741E92741E92741
            E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741E927
            41E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741E9
            2741E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741
            E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741E927
            41E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741E9
            2741E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741
            E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741E927
            41E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741E9
            2741E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741
            E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741E927
            41E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741E9
            2741E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741
            E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741E927
            41E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741E9
            2741E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741
            E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741E927
            41E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741E9
            2741E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741
            E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741E927
            41E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741E9
            2741E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741
            E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741E927
            41E92741E92741E92741E92640E829337A4343437C7C7CB2B2B2DDDDDDF7F7F7
            FEFEFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFDFDFD8D9AEE2741E92741E9263FE6233BD53445B8BDC1DDFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFBFBFC84879C0A1241121E6D1C2FAD243DDD
            2741E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741
            E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741E927
            41E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741E9
            2741E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741
            E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741E927
            41E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741E9
            2741E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741
            E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741E927
            41E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741E9
            2741E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741
            E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741E927
            41E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741E9
            2741E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741
            E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741E927
            41E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741E9
            2741E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741
            E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741E927
            41E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741E9
            2741E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741
            E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741E927
            41E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741E9
            2741E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741
            E92741E92741E92741E92741E92741E92741E92741E92640E72C335D4C4C4C7C
            7C7CB2B2B2E4E4E4FAFAFAFEFEFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFDFDFD8D9AEE2741E82640E8243DDE5767D2EBEDF7FFFF
            FFFEFEFECCCFE69DA6E0909CE7A4AEEEDDE1F7FFFFFFFFFFFFFFFFFF8B8FA30F
            195D1A2CA2243CDA2741E82741E82741E82741E82741E82741E82741E82741E8
            2741E82741E82741E82741E82741E82741E82741E82741E82741E82741E82741
            E82741E82741E82741E82741E82741E82741E82741E82741E82741E82741E827
            41E82741E82741E82741E82741E82741E82741E82741E82741E82741E82741E8
            2741E82741E82741E82741E82741E82741E82741E82741E82741E82741E82741
            E82741E82741E82741E82741E82741E82741E82741E82741E82741E82741E827
            41E82741E82741E82741E82741E82741E82741E82741E82741E82741E82741E8
            2741E82741E82741E82741E82741E82741E82741E82741E82741E82741E82741
            E82741E82741E82741E82741E82741E82741E82741E82741E82741E82741E827
            41E82741E82741E82741E82741E82741E82741E82741E82741E82741E82741E8
            2741E82741E82741E82741E82741E82741E82741E82741E82741E82741E82741
            E82741E82741E82741E82741E82741E82741E82741E82741E82741E82741E827
            41E82741E82741E82741E82741E82741E82741E82741E82741E82741E82741E8
            2741E82741E82741E82741E82741E82741E82741E82741E82741E82741E82741
            E82741E82741E82741E82741E82741E82741E82741E82741E82741E82741E827
            41E82741E82741E82741E82741E82741E82741E82741E82741E82741E82741E8
            2741E82741E82741E82741E82741E82741E82741E82741E82741E82741E82741
            E82741E82741E82741E82741E82741E82741E82741E82741E82741E82741E827
            41E82741E82741E82741E82741E82741E82741E82741E82741E82741E82741E8
            2741E82741E82741E82741E82741E82741E82741E82741E82741E82741E82741
            E82741E82741E82741E82741E82741E82741E82741E82741E82741E82741E827
            41E82741E82741E82741E82741E82741E82741E82741E82741E82741E82741E8
            2741E82741E82741E82741E82741E82741E82741E82741E82741E82741E82741
            E8263ED72C335D4444446F6F6FB3B3B3E5E5E5F8F8F8FEFEFEFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFDFDFD8D9AEE2741E92640E72D43D8
            EDEFF9FFFFFFFFFFFF969BBD1A2DA32239CF243DDE2239D11E32B7707BC5FFFF
            FFFFFFFF9C9FAF0F195B1A2CA1243CDA2741E92741E92741E92741E92741E927
            41E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741E9
            2741E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741
            E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741E927
            41E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741E9
            2741E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741
            E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741E927
            41E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741E9
            2741E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741
            E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741E927
            41E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741E9
            2741E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741
            E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741E927
            41E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741E9
            2741E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741
            E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741E927
            41E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741E9
            2741E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741
            E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741E927
            41E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741E9
            2741E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741
            E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741E927
            41E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741E9
            2741E92741E92741E92741E92640E72932733D3D3D717171B6B6B6E0E0E0F6F6
            F6FDFDFDFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFDFDFD8D9AEE27
            41E92640E67887E5FFFFFFFFFFFFFBFBFB2731781E33B7243CDC243EDF1F33BB
            162588354084FFFFFFFFFFFF9C9FB00F195E1A2CA2243CDA2741E92741E92741
            E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741E927
            41E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741E9
            2741E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741
            E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741E927
            41E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741E9
            2741E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741
            E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741E927
            41E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741E9
            2741E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741
            E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741E927
            41E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741E9
            2741E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741
            E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741E927
            41E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741E9
            2741E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741
            E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741E927
            41E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741E9
            2741E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741
            E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741E927
            41E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741E9
            2741E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741
            E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741E927
            41E92741E92741E92741E92741E92741E92741E92741E92640E729326B464646
            7F7F7FB6B6B6E0E0E0F8F8F8FEFEFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFDFDFD8D9AEE2741E9263FE5B6BEF1FFFFFFFFFFFFBCBEC9121E702035C125
            3EE04258E37783CF7078AA8388A8FFFFFFFFFFFF9DA1B8121E6F1B2FAA243CDC
            2741E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741
            E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741E927
            41E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741E9
            2741E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741
            E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741E927
            41E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741E9
            2741E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741
            E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741E927
            41E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741E9
            2741E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741
            E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741E927
            41E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741E9
            2741E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741
            E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741E927
            41E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741E9
            2741E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741
            E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741E927
            41E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741E9
            2741E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741
            E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741E927
            41E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741E9
            2741E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741
            E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741E927
            41E92640E52D33594E4E4E7F7F7FB7B7B7E7E7E7FBFBFBFEFEFEFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFDFDFD8D9AEE2741E9263FE5DDE1F8FFFFFFFFFFFF8B8F
            A3121F722036C3253EE17181ECFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFA1A7CC19
            29961F35BF243DE02741E92741E92741E92741E92741E92741E92741E92741E9
            2741E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741
            E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741E927
            41E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741E9
            2741E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741
            E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741E927
            41E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741E9
            2741E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741
            E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741E927
            41E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741E9
            2741E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741
            E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741E927
            41E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741E9
            2741E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741
            E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741E927
            41E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741E9
            2741E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741
            E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741E927
            41E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741E9
            2741E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741
            E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741E927
            41E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741E9
            2741E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741
            E92741E92741E92741E92741E9263DCA31323B4F4F4F818181C3C3C3EEEEEEFB
            FBFBFEFEFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFDFDFD8D9AEE2741E82640E6E8EBFA
            FFFFFFFFFFFF777A92111C691E33BA243CDC6274ECD3D8F9D3D8F7D3D7F6D2D7
            F4D2D6F18995DB2036C5233BD7253FE52741E82741E82741E82741E82741E827
            41E82741E82741E82741E82741E82741E82741E82741E82741E82741E82741E8
            2741E82741E82741E82741E82741E82741E82741E82741E82741E82741E82741
            E82741E82741E82741E82741E82741E82741E82741E82741E82741E82741E827
            41E82741E82741E82741E82741E82741E82741E82741E82741E82741E82741E8
            2741E82741E82741E82741E82741E82741E82741E82741E82741E82741E82741
            E82741E82741E82741E82741E82741E82741E82741E82741E82741E82741E827
            41E82741E82741E82741E82741E82741E82741E82741E82741E82741E82741E8
            2741E82741E82741E82741E82741E82741E82741E82741E82741E82741E82741
            E82741E82741E82741E82741E82741E82741E82741E82741E82741E82741E827
            41E82741E82741E82741E82741E82741E82741E82741E82741E82741E82741E8
            2741E82741E82741E82741E82741E82741E82741E82741E82741E82741E82741
            E82741E82741E82741E82741E82741E82741E82741E82741E82741E82741E827
            41E82741E82741E82741E82741E82741E82741E82741E82741E82741E82741E8
            2741E82741E82741E82741E82741E82741E82741E82741E82741E82741E82741
            E82741E82741E82741E82741E82741E82741E82741E82741E82741E82741E827
            41E82741E82741E82741E82741E82741E82741E82741E82741E82741E82741E8
            2741E82741E82741E82741E82741E82741E82741E82741E82741E82741E82741
            E82741E82741E82741E82741E82741E82741E82741E82741E82741E82741E827
            41E82741E82741E82741E82741E82741E82741E82741E82741E82741E82741E8
            2741E82741E82741E82741E82741E82741E82741E82741E82741E82741E82741
            E82741E82741E82741E82741E82741E82741E82741E82741E82741E82741E827
            41E82741E82741E82741E82741E82741E82741E82741E82741E82741E82741E8
            2741E82741E82741E82741E82741E82741E82741E82741E8263CC92D33544747
            47828282C3C3C3E7E7E7F9F9F9FEFEFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFDFDFD8D9AEE27
            41E92640E7D7DBF9FFFFFFFFFFFF898CA10E1756192B9E2138CC243DDF253FE3
            253DDF223AD31F34BC1A2CA11B2DA51F34BD233BD72640E62741E92741E92741
            E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741E927
            41E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741E9
            2741E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741
            E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741E927
            41E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741E9
            2741E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741
            E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741E927
            41E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741E9
            2741E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741
            E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741E927
            41E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741E9
            2741E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741
            E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741E927
            41E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741E9
            2741E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741
            E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741E927
            41E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741E9
            2741E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741
            E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741E927
            41E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741E9
            2741E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741
            E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741E927
            41E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741E9
            2741E92640E3293163484848828282B9B9B9E2E2E2F7F7F7FDFDFDFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFDFDFD8D9AEE2741E92640E8AFB9F4FFFFFFFFFFFFBFC1CE0B13461321781B
            2EA72036C42239D02138CB1E32B517278F111C6A1320741A2CA02138CD263FE5
            2741E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741
            E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741E927
            41E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741E9
            2741E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741
            E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741E927
            41E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741E9
            2741E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741
            E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741E927
            41E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741E9
            2741E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741
            E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741E927
            41E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741E9
            2741E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741
            E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741E927
            41E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741E9
            2741E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741
            E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741E927
            41E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741E9
            2741E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741
            E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741E927
            41E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741E9
            2741E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741
            E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741E927
            41E92741E92741E92741E92741E92640E32E3354515151838383BABABAE3E3E3
            F9F9F9FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFDFDFD8D9AEE2741E92741E9697BEDFFFFFFFFFFFFFDFD
            FE2B315C0D1650121E7017268C192A9B1829957F87BCD5D7E49B9EB4353F7D19
            2B9C2138CD263FE52741E92741E92741E92741E92741E92741E92741E92741E9
            2741E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741
            E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741E927
            41E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741E9
            2741E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741
            E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741E927
            41E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741E9
            2741E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741
            E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741E927
            41E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741E9
            2741E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741
            E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741E927
            41E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741E9
            2741E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741
            E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741E927
            41E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741E9
            2741E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741
            E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741E927
            41E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741E9
            2741E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741
            E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741E927
            41E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741E9
            2741E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741
            E92741E92741E92741E92741E92741E92741E92741E92741E9263CC532323652
            5252848484BBBBBBEAEAEAFDFDFDFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFDFDFD8D9AEE2741E82741E82741E8
            B7C0F6FFFFFFFFFFFFCED0DC51577C222A5B141D552A326B878DADF8F8FAFFFF
            FFF2F3F82D3C991E34BC243CDB2640E72741E82741E82741E82741E82741E827
            41E82741E82741E82741E82741E82741E82741E82741E82741E82741E82741E8
            2741E82741E82741E82741E82741E82741E82741E82741E82741E82741E82741
            E82741E82741E82741E82741E82741E82741E82741E82741E82741E82741E827
            41E82741E82741E82741E82741E82741E82741E82741E82741E82741E82741E8
            2741E82741E82741E82741E82741E82741E82741E82741E82741E82741E82741
            E82741E82741E82741E82741E82741E82741E82741E82741E82741E82741E827
            41E82741E82741E82741E82741E82741E82741E82741E82741E82741E82741E8
            2741E82741E82741E82741E82741E82741E82741E82741E82741E82741E82741
            E82741E82741E82741E82741E82741E82741E82741E82741E82741E82741E827
            41E82741E82741E82741E82741E82741E82741E82741E82741E82741E82741E8
            2741E82741E82741E82741E82741E82741E82741E82741E82741E82741E82741
            E82741E82741E82741E82741E82741E82741E82741E82741E82741E82741E827
            41E82741E82741E82741E82741E82741E82741E82741E82741E82741E82741E8
            2741E82741E82741E82741E82741E82741E82741E82741E82741E82741E82741
            E82741E82741E82741E82741E82741E82741E82741E82741E82741E82741E827
            41E82741E82741E82741E82741E82741E82741E82741E82741E82741E82741E8
            2741E82741E82741E82741E82741E82741E82741E82741E82741E82741E82741
            E82741E82741E82741E82741E82741E82741E82741E82741E82741E82741E827
            41E82741E82741E82741E82741E82741E82741E82741E82741E82741E82741E8
            2741E82741E82741E82741E82741E82741E82741E82741E82741E82741E82741
            E82741E82741E82741E82741E82741E82741E82741E82741E82741E82741E827
            41E82741E82741E82741E82741E82741E82741E82741E82741E82741E82741E8
            2741E82741E82741E82741E82741E82741E82741E82741E82741E82741E82741
            E82741E8263BC12E32504A4A4A7C7C7CC5C5C5F4F4F4FEFEFEFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFDFDFD8D9AEE27
            41E92741E92741E92943E8B7BFF6FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFF8E97D32036C3243CDB263FE62741E92741E92741E92741
            E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741E927
            41E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741E9
            2741E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741
            E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741E927
            41E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741E9
            2741E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741
            E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741E927
            41E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741E9
            2741E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741
            E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741E927
            41E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741E9
            2741E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741
            E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741E927
            41E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741E9
            2741E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741
            E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741E927
            41E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741E9
            2741E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741
            E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741E927
            41E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741E9
            2741E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741
            E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741E927
            41E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741E9
            2741E92741E92741E92741E92741E9263FE12F3561565656A9A9A9ECECECFDFD
            FDFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFDFDFD8D9AEE2741E92741E92741E92741E92842E88795F1F6F7FDFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFDFDFEAAB2E8273DCD243DDE263FE62640E82741E9
            2741E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741
            E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741E927
            41E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741E9
            2741E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741
            E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741E927
            41E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741E9
            2741E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741
            E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741E927
            41E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741E9
            2741E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741
            E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741E927
            41E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741E9
            2741E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741
            E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741E927
            41E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741E9
            2741E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741
            E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741E927
            41E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741E9
            2741E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741
            E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741E927
            41E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741E9
            2741E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741
            E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741E927
            41E92741E92741E92741E92741E92741E92741E92741E92741E92740E2575B6F
            B0B0B0EEEEEEFDFDFDFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFDFDFD8D9AEE2741E92741E92741E92741E92741E92640
            E84258EA8D9AF0ACB6F3B2BAF3A7B1F17F8DE93D53DD243CDD253EE32640E827
            41E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741E9
            2741E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741
            E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741E927
            41E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741E9
            2741E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741
            E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741E927
            41E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741E9
            2741E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741
            E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741E927
            41E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741E9
            2741E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741
            E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741E927
            41E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741E9
            2741E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741
            E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741E927
            41E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741E9
            2741E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741
            E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741E927
            41E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741E9
            2741E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741
            E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741E927
            41E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741E9
            2741E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741
            E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741E927
            41E92741E974799BCCCCCCF6F6F6FEFEFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFDFDFD8D9AEE2741E82741E82741E8
            2741E82741E82741E82741E82640E82640E82640E72640E72640E72640E72640
            E82640E82741E82741E82741E82741E82741E82741E82741E82741E82741E827
            41E82741E82741E82741E82741E82741E82741E82741E82741E82741E82741E8
            2741E82741E82741E82741E82741E82741E82741E82741E82741E82741E82741
            E82741E82741E82741E82741E82741E82741E82741E82741E82741E82741E827
            41E82741E82741E82741E82741E82741E82741E82741E82741E82741E82741E8
            2741E82741E82741E82741E82741E82741E82741E82741E82741E82741E82741
            E82741E82741E82741E82741E82741E82741E82741E82741E82741E82741E827
            41E82741E82741E82741E82741E82741E82741E82741E82741E82741E82741E8
            2741E82741E82741E82741E82741E82741E82741E82741E82741E82741E82741
            E82741E82741E82741E82741E82741E82741E82741E82741E82741E82741E827
            41E82741E82741E82741E82741E82741E82741E82741E82741E82741E82741E8
            2741E82741E82741E82741E82741E82741E82741E82741E82741E82741E82741
            E82741E82741E82741E82741E82741E82741E82741E82741E82741E82741E827
            41E82741E82741E82741E82741E82741E82741E82741E82741E82741E82741E8
            2741E82741E82741E82741E82741E82741E82741E82741E82741E82741E82741
            E82741E82741E82741E82741E82741E82741E82741E82741E82741E82741E827
            41E82741E82741E82741E82741E82741E82741E82741E82741E82741E82741E8
            2741E82741E82741E82741E82741E82741E82741E82741E82741E82741E82741
            E82741E82741E82741E82741E82741E82741E82741E82741E82741E82741E827
            41E82741E82741E82741E82741E82741E82741E82741E82741E82741E82741E8
            2741E82741E82741E82741E82741E82741E82741E82741E82741E82741E82741
            E82741E82741E82741E82741E82741E82741E82741E82741E82741E82741E827
            41E82741E82741E82741E82741E82741E82741E82741E82741E82741E82741E8
            2741E82741E82741E82741E82741E82741E82741E82741E82741E82741E82741
            E82741E82741E82741E7616EC6BFBFC3ECECECFCFCFCFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFDFDFD8D9AEE27
            41E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741E9
            2741E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741
            E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741E927
            41E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741E9
            2741E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741
            E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741E927
            41E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741E9
            2741E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741
            E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741E927
            41E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741E9
            2741E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741
            E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741E927
            41E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741E9
            2741E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741
            E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741E927
            41E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741E9
            2741E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741
            E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741E927
            41E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741E9
            2741E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741
            E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741E927
            41E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741E9
            2741E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741
            E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741E927
            41E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741E9
            2741E92741E92741E92741E92741E77780B8CBCBCBECECECFCFCFCFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFDFDFD8D9AEE2741E92741E92741E92741E92741E92741E92741E92741E927
            41E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741E9
            2741E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741
            E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741E927
            41E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741E9
            2741E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741
            E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741E927
            41E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741E9
            2741E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741
            E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741E927
            41E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741E9
            2741E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741
            E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741E927
            41E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741E9
            2741E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741
            E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741E927
            41E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741E9
            2741E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741
            E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741E927
            41E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741E9
            2741E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741
            E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741E927
            41E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741E9
            2741E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741
            E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741E927
            41E92741E92741E92741E92741E92741E92741E8717BBBC9C9C9EBEBEBFAFAFA
            FEFEFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFDFDFD8D9AEE2741E92741E92741E92741E92741E92741
            E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741E927
            41E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741E9
            2741E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741
            E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741E927
            41E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741E9
            2741E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741
            E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741E927
            41E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741E9
            2741E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741
            E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741E927
            41E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741E9
            2741E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741
            E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741E927
            41E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741E9
            2741E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741
            E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741E927
            41E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741E9
            2741E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741
            E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741E927
            41E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741E9
            2741E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741
            E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741E927
            41E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741E9
            2741E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741
            E92741E92741E92741E92741E92741E92741E92741E92741E95464CBC8C8C8EB
            EBEBFAFAFAFEFEFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFDFDFD8D9AEE2741E82741E82741E8
            2741E82741E82741E82741E82741E82741E82741E82741E82741E82741E82741
            E82741E82741E82741E82741E82741E82741E82741E82741E82741E82741E827
            41E82741E82741E82741E82741E82741E82741E82741E82741E82741E82741E8
            2741E82741E82741E82741E82741E82741E82741E82741E82741E82741E82741
            E82741E82741E82741E82741E82741E82741E82741E82741E82741E82741E827
            41E82741E82741E82741E82741E82741E82741E82741E82741E82741E82741E8
            2741E82741E82741E82741E82741E82741E82741E82741E82741E82741E82741
            E82741E82741E82741E82741E82741E82741E82741E82741E82741E82741E827
            41E82741E82741E82741E82741E82741E82741E82741E82741E82741E82741E8
            2741E82741E82741E82741E82741E82741E82741E82741E82741E82741E82741
            E82741E82741E82741E82741E82741E82741E82741E82741E82741E82741E827
            41E82741E82741E82741E82741E82741E82741E82741E82741E82741E82741E8
            2741E82741E82741E82741E82741E82741E82741E82741E82741E82741E82741
            E82741E82741E82741E82741E82741E82741E82741E82741E82741E82741E827
            41E82741E82741E82741E82741E82741E82741E82741E82741E82741E82741E8
            2741E82741E82741E82741E82741E82741E82741E82741E82741E82741E82741
            E82741E82741E82741E82741E82741E82741E82741E82741E82741E82741E827
            41E82741E82741E82741E82741E82741E82741E82741E82741E82741E82741E8
            2741E82741E82741E82741E82741E82741E82741E82741E82741E82741E82741
            E82741E82741E82741E82741E82741E82741E82741E82741E82741E82741E827
            41E82741E82741E82741E82741E82741E82741E82741E82741E82741E82741E8
            2741E82741E82741E82741E82741E82741E82741E82741E82741E82741E82741
            E82741E82741E82741E82741E82741E82741E82741E82741E82741E82741E827
            41E82741E82741E82741E82741E82741E82741E82741E82741E82741E82741E8
            2741E82741E82741E82741E82741E82741E82741E82741E82741E82741E85060
            CDBFC0C7EEEEEEFBFBFBFEFEFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFDFDFD8D9AEE27
            41E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741E9
            2741E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741
            E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741E927
            41E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741E9
            2741E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741
            E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741E927
            41E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741E9
            2741E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741
            E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741E927
            41E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741E9
            2741E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741
            E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741E927
            41E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741E9
            2741E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741
            E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741E927
            41E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741E9
            2741E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741
            E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741E927
            41E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741E9
            2741E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741
            E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741E927
            41E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741E9
            2741E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741
            E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741E927
            41E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741E9
            2741E95E6CC4C2C2C2EDEDEDFDFDFDFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFDFDFD8D9AEE2741E92741E92741E92741E92741E92741E92741E92741E927
            41E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741E9
            2741E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741
            E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741E927
            41E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741E9
            2741E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741
            E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741E927
            41E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741E9
            2741E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741
            E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741E927
            41E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741E9
            2741E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741
            E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741E927
            41E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741E9
            2741E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741
            E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741E927
            41E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741E9
            2741E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741
            E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741E927
            41E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741E9
            2741E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741
            E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741E927
            41E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741E9
            2741E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741
            E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741E927
            41E92741E92741E95867C5C0C0C0E6E6E6FAFAFAFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFDFDFD8D9AEE2741E92741E92741E92741E92741E92741
            E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741E927
            41E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741E9
            2741E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741
            E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741E927
            41E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741E9
            2741E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741
            E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741E927
            41E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741E9
            2741E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741
            E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741E927
            41E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741E9
            2741E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741
            E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741E927
            41E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741E9
            2741E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741
            E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741E927
            41E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741E9
            2741E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741
            E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741E927
            41E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741E9
            2741E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741
            E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741E927
            41E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741E9
            2741E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741
            E92741E92741E92741E92741E94558D3BEBEBFE6E6E6F8F8F8FEFEFEFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFDFDFD8D9AEE2741E82741E82741E8
            2741E82741E82741E82741E82741E82741E82741E82741E82741E82741E82741
            E82741E82741E82741E82741E82741E82741E82741E82741E82741E82741E827
            41E82741E82741E82741E82741E82741E82741E82741E82741E82741E82741E8
            2741E82741E82741E82741E82741E82741E82741E82741E82741E82741E82741
            E82741E82741E82741E82741E82741E82741E82741E82741E82741E82741E827
            41E82741E82741E82741E82741E82741E82741E82741E82741E82741E82741E8
            2741E82741E82741E82741E82741E82741E82741E82741E82741E82741E82741
            E82741E82741E82741E82741E82741E82741E82741E82741E82741E82741E827
            41E82741E82741E82741E82741E82741E82741E82741E82741E82741E82741E8
            2741E82741E82741E82741E82741E82741E82741E82741E82741E82741E82741
            E82741E82741E82741E82741E82741E82741E82741E82741E82741E82741E827
            41E82741E82741E82741E82741E82741E82741E82741E82741E82741E82741E8
            2741E82741E82741E82741E82741E82741E82741E82741E82741E82741E82741
            E82741E82741E82741E82741E82741E82741E82741E82741E82741E82741E827
            41E82741E82741E82741E82741E82741E82741E82741E82741E82741E82741E8
            2741E82741E82741E82741E82741E82741E82741E82741E82741E82741E82741
            E82741E82741E82741E82741E82741E82741E82741E82741E82741E82741E827
            41E82741E82741E82741E82741E82741E82741E82741E82741E82741E82741E8
            2741E82741E82741E82741E82741E82741E82741E82741E82741E82741E82741
            E82741E82741E82741E82741E82741E82741E82741E82741E82741E82741E827
            41E82741E82741E82741E82741E82741E82741E82741E82741E82741E82741E8
            2741E82741E82741E82741E82741E82741E82741E82741E82741E82741E82741
            E82741E82741E82741E82741E82741E82741E82741E82741E82741E82741E827
            41E82741E82741E82741E82741E82741E82741E82741E82741E82741E82741E8
            2741E82741E82741E82741E82741E82741E84054D5B1B3C2EAEAEAF9F9F9FEFE
            FEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFDFDFD8D9AEE27
            41E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741E9
            2741E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741
            E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741E927
            41E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741E9
            2741E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741
            E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741E927
            41E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741E9
            2741E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741
            E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741E927
            41E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741E9
            2741E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741
            E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741E927
            41E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741E9
            2741E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741
            E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741E927
            41E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741E9
            2741E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741
            E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741E927
            41E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741E9
            2741E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741
            E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741E927
            41E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741E9
            2741E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741
            E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741E927
            41E92741E92741E92741E92741E92741E92741E92741E9475ACFB7B8BAE9E9E9
            FCFCFCFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFDFDFD8D9AEE2741E92741E92741E92741E92741E92741E92741E92741E927
            41E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741E9
            2741E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741
            E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741E927
            41E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741E9
            2741E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741
            E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741E927
            41E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741E9
            2741E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741
            E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741E927
            41E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741E9
            2741E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741
            E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741E927
            41E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741E9
            2741E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741
            E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741E927
            41E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741E9
            2741E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741
            E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741E927
            41E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741E9
            2741E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741
            E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741E927
            41E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741E9
            2741E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741
            E92741E92741E92741E92741E92741E92741E92741E92741E92741E94457D1B4
            B5B9E1E1E1F8F8F8FEFEFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFDFDFD8E9BEF2741E92741E92741E92741E92741E92741
            E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741E927
            41E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741E9
            2741E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741
            E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741E927
            41E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741E9
            2741E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741
            E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741E927
            41E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741E9
            2741E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741
            E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741E927
            41E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741E9
            2741E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741
            E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741E927
            41E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741E9
            2741E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741
            E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741E927
            41E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741E9
            2741E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741
            E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741E927
            41E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741E9
            2741E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741
            E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741E927
            41E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741E9
            2741E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741
            E9384EDAB1B2B8E0E0E0F6F6F6FDFDFDFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFDFDFD8E9BEE2741E82741E82741E8
            2741E82741E82741E82741E82741E82741E82741E82741E82741E82741E82741
            E82741E82741E82741E82741E82741E82741E82741E82741E82741E82741E827
            41E82741E82741E82741E82741E82741E82741E82741E82741E82741E82741E8
            2741E82741E82741E82741E82741E82741E82741E82741E82741E82741E82741
            E82741E82741E82741E82741E82741E82741E82741E82741E82741E82741E827
            41E82741E82741E82741E82741E82741E82741E82741E82741E82741E82741E8
            2741E82741E82741E82741E82741E82741E82741E82741E82741E82741E82741
            E82741E82741E82741E82741E82741E82741E82741E82741E82741E82741E827
            41E82741E82741E82741E82741E82741E82741E82741E82741E82741E82741E8
            2741E82741E82741E82741E82741E82741E82741E82741E82741E82741E82741
            E82741E82741E82741E82741E82741E82741E82741E82741E82741E82741E827
            41E82741E82741E82741E82741E82741E82741E82741E82741E82741E82741E8
            2741E82741E82741E82741E82741E82741E82741E82741E82741E82741E82741
            E82741E82741E82741E82741E82741E82741E82741E82741E82741E82741E827
            41E82741E82741E82741E82741E82741E82741E82741E82741E82741E82741E8
            2741E82741E82741E82741E82741E82741E82741E82741E82741E82741E82741
            E82741E82741E82741E82741E82741E82741E82741E82741E82741E82741E827
            41E82741E82741E82741E82741E82741E82741E82741E82741E82741E82741E8
            2741E82741E82741E82741E82741E82741E82741E82741E82741E82741E82741
            E82741E82741E82741E82741E82741E82741E82741E82741E82741E82741E827
            41E82741E82741E82741E82741E82741E82741E82741E82741E82741E82741E8
            2741E82741E82741E82741E82741E82741E82741E82741E82741E82741E82741
            E82741E82741E82741E82741E82741E82741E82741E82741E82741E82741E827
            41E82741E82741E82741E82741E82741E82741E82741E82741E82741E82741E8
            2741E82741E8354BDCA2A6BFE4E4E4F7F7F7FEFEFEFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFEFE8E9BEF27
            41E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741E9
            2741E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741
            E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741E927
            41E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741E9
            2741E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741
            E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741E927
            41E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741E9
            2741E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741
            E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741E927
            41E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741E9
            2741E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741
            E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741E927
            41E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741E9
            2741E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741
            E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741E927
            41E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741E9
            2741E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741
            E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741E927
            41E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741E9
            2741E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741
            E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741E927
            41E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741E9
            2741E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741
            E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741E927
            41E92741E92741E92741E93A4FDAA9ABB7E4E4E4FAFAFAFEFEFEFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFEFEFE909DF12741E92741E92741E92741E92741E92741E92741E92741E927
            41E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741E9
            2741E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741
            E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741E927
            41E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741E9
            2741E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741
            E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741E927
            41E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741E9
            2741E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741
            E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741E927
            41E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741E9
            2741E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741
            E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741E927
            41E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741E9
            2741E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741
            E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741E927
            41E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741E9
            2741E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741
            E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741E927
            41E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741E9
            2741E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741
            E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741E927
            41E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741E9
            2741E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741
            E92741E92741E92741E92741E92741E93D53E1B2B4C3DEDEDEF7F7F7FEFEFEFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFF929FF32741E92741E92741E92741E92741E92741
            E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741E927
            41E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741E9
            2741E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741
            E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741E927
            41E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741E9
            2741E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741
            E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741E927
            41E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741E9
            2741E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741
            E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741E927
            41E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741E9
            2741E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741
            E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741E927
            41E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741E9
            2741E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741
            E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741E927
            41E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741E9
            2741E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741
            E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741E927
            41E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741E9
            2741E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741
            E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741E927
            41E92741E92741E92741E92741E92741E92741E92741E92741E92741E92741E9
            2741E92741E92741E92741E92741E92741E92741E93850E8CCCFE1EAEAEAF6F6
            F6FDFDFDFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFDFDFDF5F5F5E6E6E6DEDEDE
            DDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDD
            DDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDD
            DDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDD
            DDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDD
            DDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDD
            DDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDD
            DDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDD
            DDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDD
            DDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDD
            DDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDD
            DDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDD
            DDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDD
            DDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDD
            DDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDD
            DDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDD
            DDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDD
            DDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDD
            DDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDD
            DDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDD
            DDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDD
            DDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDE0E0E0E9E9E9F5F5F5F9F9F9
            FAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFA
            FAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFA
            FAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFA
            FBFBFBFDFDFDFEFEFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFEFEF6F6F6DB
            DBDBADADAD949494919191919191919191919191919191919191919191919191
            9191919191919191919191919191919191919191919191919191919191919191
            9191919191919191919191919191919191919191919191919191919191919191
            9191919191919191919191919191919191919191919191919191919191919191
            9191919191919191919191919191919191919191919191919191919191919191
            9191919191919191919191919191919191919191919191919191919191919191
            9191919191919191919191919191919191919191919191919191919191919191
            9191919191919191919191919191919191919191919191919191919191919191
            9191919191919191919191919191919191919191919191919191919191919191
            9191919191919191919191919191919191919191919191919191919191919191
            9191919191919191919191919191919191919191919191919191919191919191
            9191919191919191919191919191919191919191919191919191919191919191
            9191919191919191919191919191919191919191919191919191919191919191
            9191919191919191919191919191919191919191919191919191919191919191
            9191919191919191919191919191919191919191919191919191919191919191
            9191919191919191919191919191919191919191919191919191919191919191
            9191919191919191919191919191919191919191919191919191919191919191
            9191919191919191919191919191919191919191919191919191919191919191
            9191919191919191919191919191919191919191919191919191919191919191
            9191919191919191919191919191919191919191919191919191919191919191
            91919191919191919191919191919191919191919191919191919191999999B6
            B6B6DFDFDFF4F4F4FDFDFDFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFEFEFEF0F0F0C5C5C57878784F4F4F49494948484847474747474749494949
            4949494949494949494949494949494949494949494949494949494949494949
            4949494949494949494949494949494949494949494949494949494949494949
            4949494949494949494949494949494949494949494949494949494949494949
            4949494949494949494949494949494949494949494949494949494949494949
            4949494949494949494949494949494949494949494949494949494949494949
            4949494949494949494949494949494949494949494949494949494949494949
            4949494949494949494949494949494949494949494949494949494949494949
            4949494949494949494949494949494949494949494949494949494949494949
            4949494949494949494949494949494949494949494949494949494949494949
            4949494949494949494949494949494949494949494949494949494949494949
            4949494949494949494949494949494949494949494949494949494949494949
            4949494949494949494949494949494949494949494949494949494949494949
            4949494949494949494949494949494949494949494949494949494949494949
            4949494949494949494949494949494949494949494949494949494949494949
            4949494949494949494949494949494949494949494949494949494949494949
            4949494949494949494949494949494949494949494949494949494949494949
            4949494949494949494949494949494949494949494949494949494949494949
            4949494949494949494949494949494949494949494949494949494949494949
            4949494949494949494949494949494949494949494949494949494949494949
            4949494949494949494949494949494949494949494949494949494949494949
            494A4A4A525252757575B1B1B1DDDDDDF4F4F4FDFDFDFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFEFEFE8FB3F12971ED2971ED286FEA266ADF2363D0225E
            C62361CE266BE0286FEB2971ED2971ED2971ED2971ED2971ED2971ED2971ED29
            71ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED
            2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971
            ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED29
            71ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED
            2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971
            ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED29
            71ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED
            2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971
            ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED29
            71ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED
            2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971
            ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED29
            71ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED
            2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971
            ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED29
            71ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED
            2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971
            ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED29
            71ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED
            2971ED2971ED2971ED2971ED2C4B80444444797979B1B1B1DDDDDDF7F7F7FEFE
            FEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFDFDFD8FB3F12971ED286FEB266BE3
            225EC61A499A153C7F1947952260CA276DE52870EC2971ED2971ED2971ED2971
            ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED29
            71ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED
            2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971
            ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED29
            71ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED
            2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971
            ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED29
            71ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED
            2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971
            ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED29
            71ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED
            2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971
            ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED29
            71ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED
            2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971
            ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED29
            71ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED
            2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971
            ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED29
            71ED2971ED2971ED2971ED2971ED2971ED2971ED2770EC2A4B834242426D6D6D
            A3A3A3DBDBDBF7F7F7FDFDFDFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFDFDFD8EB2F029
            71ED2870EC5E91E8B0C3E5ACB9CF8995A912336D1F58BA266BE12870EC2971ED
            2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971
            ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED29
            71ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED
            2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971
            ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED29
            71ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED
            2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971
            ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED29
            71ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED
            2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971
            ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED29
            71ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED
            2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971
            ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED29
            71ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED
            2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971
            ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED29
            71ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED
            2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971
            ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2871ED27
            70EC29487C3A3A3A626262A4A4A4DDDDDDF4F4F4FDFDFDFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFDFDFD8EB2F02971ED2870EC7DA6EEFFFFFFFFFFFFCED1D8102F641F57B626
            6AE02870EC2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED
            2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971
            ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED29
            71ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED
            2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971
            ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED29
            71ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED
            2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971
            ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED29
            71ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED
            2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971
            ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED29
            71ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED
            2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971
            ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED29
            71ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED
            2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971
            ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED29
            71ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED
            2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971
            ED2971ED2871ED2871ED2770EB2945743B3B3B6F6F6FB2B2B2DEDEDEF5F5F5FD
            FDFDFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFDFDFD8EB2F02971ED2870EC7DA6EDFFFFFFFFFFFFCED1
            D8102F631F56B5266ADF286FEB2870EC2971ED2971ED2971ED2971ED2971ED29
            71ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED
            2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971
            ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED29
            71ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED
            2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971
            ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED29
            71ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED
            2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971
            ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED29
            71ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED
            2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971
            ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED29
            71ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED
            2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971
            ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED29
            71ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED
            2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971
            ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED29
            71ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED
            2971ED2971ED2971ED2971ED2871ED2871ED2871ED2770EB2945744444447C7C
            7CB4B4B4DFDFDFF6F6F6FDFDFDFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFDFDFD8EB2F02971ED286FEB7DA6ED
            FFFFFFFFFFFFCDD0D70F2C5E1C51AB2464D22669DD266ADE266AE0266CE4276E
            E82870EC2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED29
            71ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED
            2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971
            ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED29
            71ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED
            2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971
            ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED29
            71ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED
            2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971
            ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED29
            71ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED
            2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971
            ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED29
            71ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED
            2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971
            ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED29
            71ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED
            2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971
            ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED29
            71ED2971ED2971ED2971ED2971ED2971ED2971ED2871ED2871ED2871ED2871ED
            2770EB2A497D454545707070A7A7A7D6D6D6F4F4F4FEFEFEFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFDFDFD8EB2F029
            71ED2870EC7DA6EDFFFFFFFFFFFFCDD1D60C244C163E821B4B9E1C4FA61C50A7
            1D52AE215BC02566D8286FEA2971ED2971ED2971ED2971ED2971ED2971ED2971
            ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED29
            71ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED
            2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971
            ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED29
            71ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED
            2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971
            ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED29
            71ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED
            2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971
            ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED29
            71ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED
            2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971
            ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED29
            71ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED
            2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971
            ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED29
            71ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED
            2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971
            ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2871ED28
            71ED2871ED2871ED2871ED2770EB29426C3D3D3D6464649B9B9BD6D6D6F6F6F6
            FDFDFDFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFDFDFD8EB2F02971ED2870EC7DA6EDFFFFFFFFFFFFCDD0D5091A370D275210
            2D60112F64113066133673194796215DC5276DE52971ED2971ED2971ED2971ED
            2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971
            ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED29
            71ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED
            2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971
            ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED29
            71ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED
            2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971
            ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED29
            71ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED
            2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971
            ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED29
            71ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED
            2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971
            ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED29
            71ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED
            2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971
            ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED29
            71ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED
            2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971
            ED2971ED2871ED2871ED2871ED2871ED2871ED2871ED276FE929426C3D3D3D65
            6565A9A9A9E0E0E0F7F7F7FDFDFDFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFDFDFD8EB2F02971ED2870EC7DA6EDFFFFFFFFFFFFE8EA
            EC8F95A19099A8919BAC919CAE919CAF445C84174189205ABF276CE42971ED29
            71ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED
            2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971
            ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED29
            71ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED
            2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971
            ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED29
            71ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED
            2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971
            ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED29
            71ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED
            2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971
            ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED29
            71ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED
            2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971
            ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED29
            71ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED
            2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971
            ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED29
            71ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED
            2971ED2971ED2971ED2971ED2871ED2871ED2871ED2871ED2871ED2871ED2871
            ED276FE929426C3D3D3D747474B8B8B8E1E1E1F7F7F7FDFDFDFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFDFDFD8EB2F02971ED2870EC7DA6ED
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF748EBB1C50A82361
            CD276EE72971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED29
            71ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED
            2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971
            ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED29
            71ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED
            2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971
            ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED29
            71ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED
            2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971
            ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED29
            71ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED
            2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971
            ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED29
            71ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED
            2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971
            ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED29
            71ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED
            2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971
            ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED29
            71ED2971ED2971ED2971ED2971ED2971ED2971ED2871ED2871ED2871ED2871ED
            2871ED2871ED2871ED2871ED276FE9294067474747818181B8B8B8E1E1E1F8F8
            F8FEFEFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFDFDFD8EB2F029
            71ED286FEB7DA6EDFFFFFFFFFFFFF1F2F4BFC6D3C2D0E7C4D5F1C4D6F4C4D6F5
            6390DD2465D5266BE1286FEA2971ED2971ED2971ED2971ED2971ED2971ED2971
            ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED29
            71ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED
            2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971
            ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED29
            71ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED
            2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971
            ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED29
            71ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED
            2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971
            ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED29
            71ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED
            2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971
            ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED29
            71ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED
            2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971
            ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED29
            71ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED
            2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971
            ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2871ED28
            71ED2871ED2871ED2871ED2871ED2871ED2871ED2871ED276FE92B4672484848
            757575ABABABE0E0E0F9F9F9FEFEFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFDFDFD8EB2F02971ED2870EC7DA6EDFFFFFFFFFFFFCED1D70E2A591B4CA021
            5DC52362CE2363D02363D12464D42568DB276DE62870EC2971ED2971ED2971ED
            2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971
            ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED29
            71ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED
            2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971
            ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED29
            71ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED
            2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971
            ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED29
            71ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED
            2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971
            ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED29
            71ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED
            2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971
            ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED29
            71ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED
            2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971
            ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED29
            71ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED
            2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971
            ED2971ED2871ED2871ED2871ED2871ED2871ED2871ED2871ED2871ED2871ED28
            71ED276FE92A3F643F3F3F686868ADADADE3E3E3F7F7F7FEFEFEFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFDFDFD8EB2F02971ED2870EC7DA6EEFFFFFFFFFFFFCDD1
            D60C2249143A7A1946941A4A9B1B4A9C1B4A9D1B4EA41F57B82467D9286FEB29
            71ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED
            2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971
            ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED29
            71ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED
            2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971
            ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED29
            71ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED
            2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971
            ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED29
            71ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED
            2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971
            ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED29
            71ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED
            2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971
            ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED29
            71ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED
            2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971
            ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED29
            71ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED
            2971ED2971ED2971ED2971ED2871ED2871ED2871ED2871ED2871ED2871ED2871
            ED2871ED2871ED2871ED2871ED276FE72A3F613F3F3F777777BBBBBBE4E4E4F8
            F8F8FEFEFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFDFDFD8EB2F02971ED2870EC7DA6EE
            FFFFFFFFFFFFCDD1D70A1B3B0D26500F2B5B102C5E102D5F102E6112336D1844
            902260CA286FE92971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED29
            71ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED
            2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971
            ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED29
            71ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED
            2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971
            ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED29
            71ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED
            2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971
            ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED29
            71ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED
            2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971
            ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED29
            71ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED
            2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971
            ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED29
            71ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED
            2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971
            ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED29
            71ED2971ED2971ED2971ED2971ED2971ED2971ED2871ED2871ED2871ED2871ED
            2871ED2871ED2871ED2871ED2871ED2871ED2871ED2871ED276DE52A3D5D4A4A
            4A878787C2C2C2EBEBEBFDFDFDFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFDFDFD8EB2F029
            71ED286FEB7DA7EFFFFFFFFFFFFFF5F6F7CED2D9CED3DBCED3DBCED3DBCED3DC
            CED3DC667DA41946932261CC276EE92971ED2971ED2971ED2971ED2971ED2971
            ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED29
            71ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED
            2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971
            ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED29
            71ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED
            2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971
            ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED29
            71ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED
            2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971
            ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED29
            71ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED
            2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971
            ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED29
            71ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED
            2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971
            ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED29
            71ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED
            2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971
            ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2871ED28
            71ED2871ED2871ED2871ED2871ED2871ED2871ED2871ED2871ED2871ED2871ED
            2871ED276EE72F476F5B5B5B9D9D9DDADADAFAFAFAFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFDFDFD8EB2F02971ED2971ED7DA8F2FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFF83A2D7215EC5266ADE2870EB2971ED2971ED2971ED
            2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971
            ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED29
            71ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED
            2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971
            ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED29
            71ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED
            2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971
            ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED29
            71ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED
            2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971
            ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED29
            71ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED
            2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971
            ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED29
            71ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED
            2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971
            ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED29
            71ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED
            2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971
            ED2971ED2871ED2871ED2871ED2871ED2871ED2871ED2871ED2871ED2871ED28
            71ED2871ED2871ED2871ED2871ED286FE857616FA0A0A0DBDBDBFAFAFAFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFDFDFD8EB2F02971ED2971ED4B87EF7DA8F27DA7EF7DA6
            EE7DA6ED7DA6ED7DA6ED7DA6ED7DA6ED7DA6ED4D85E5276CE2276FE92971ED29
            71ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED
            2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971
            ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED29
            71ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED
            2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971
            ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED29
            71ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED
            2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971
            ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED29
            71ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED
            2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971
            ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED29
            71ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED
            2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971
            ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED29
            71ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED
            2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971
            ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED29
            71ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED
            2971ED2971ED2971ED2971ED2871ED2871ED2871ED2871ED2871ED2871ED2871
            ED2871ED2871ED2871ED2871ED2871ED2871ED2871ED2871ED74839CC0C0C0EB
            EBEBFCFCFCFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFDFDFD8EB2F02971ED2971ED2971ED
            2971ED2870EC2870EC2870EB2870EB2870EB2870EB2870EB2870EB2870EC2870
            EC2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED29
            71ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED
            2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971
            ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED29
            71ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED
            2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971
            ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED29
            71ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED
            2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971
            ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED29
            71ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED
            2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971
            ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED29
            71ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED
            2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971
            ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED29
            71ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED
            2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971
            ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED29
            71ED2971ED2971ED2971ED2971ED2971ED2971ED2871ED2871ED2871ED2871ED
            2871ED2871ED2871ED2871ED2871ED2871ED2871ED2871ED2871ED2871ED3A76
            DDB3B5B9E2E2E2F8F8F8FEFEFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFDFDFD8EB2F029
            71ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED
            2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971
            ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED29
            71ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED
            2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971
            ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED29
            71ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED
            2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971
            ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED29
            71ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED
            2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971
            ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED29
            71ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED
            2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971
            ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED29
            71ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED
            2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971
            ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED29
            71ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED
            2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971
            ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2871ED28
            71ED2871ED2871ED2871ED2871ED2871ED2871ED2871ED2871ED2871ED2871ED
            2871ED3776DFA4AFC0E5E5E5F8F8F8FEFEFEFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFDFDFD8EB2F02971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED29
            71ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED
            2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971
            ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED29
            71ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED
            2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971
            ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED29
            71ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED
            2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971
            ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED29
            71ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED
            2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971
            ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED29
            71ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED
            2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971
            ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED29
            71ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED
            2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971
            ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED29
            71ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED
            2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971
            ED2971ED2871ED2871ED2871ED2871ED2871ED2871ED2871ED2871ED2871ED28
            71ED2871ED2871ED3C77DAA9AEB7E4E4E4FAFAFAFEFEFEFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFDFDFD8EB2F02971ED2971ED2971ED2971ED2971ED2971
            ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED29
            71ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED
            2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971
            ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED29
            71ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED
            2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971
            ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED29
            71ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED
            2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971
            ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED29
            71ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED
            2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971
            ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED29
            71ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED
            2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971
            ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED29
            71ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED
            2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971
            ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED29
            71ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED
            2971ED2971ED2971ED2971ED2871ED2871ED2871ED2871ED2871ED2871ED2871
            ED2871ED2871ED2871ED2871ED3876DDA5ABB6DCDCDCF7F7F7FEFEFEFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFDFDFD8EB2F02971ED2971ED2971ED
            2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971
            ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED29
            71ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED
            2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971
            ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED29
            71ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED
            2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971
            ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED29
            71ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED
            2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971
            ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED29
            71ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED
            2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971
            ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED29
            71ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED
            2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971
            ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED29
            71ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED
            2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971
            ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED29
            71ED2971ED2971ED2971ED2971ED2971ED2971ED2871ED2871ED2871ED2871ED
            2871ED2871ED2871ED2871ED2871ED2871ED3173E4A2A9B4DADADAF4F4F4FDFD
            FDFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFDFDFD8EB2F029
            71ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED
            2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971
            ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED29
            71ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED
            2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971
            ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED29
            71ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED
            2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971
            ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED29
            71ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED
            2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971
            ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED29
            71ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED
            2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971
            ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED29
            71ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED
            2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971
            ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED29
            71ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED
            2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971
            ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2871ED28
            71ED2871ED2871ED2871ED2871ED2871ED2871ED2871ED2F73E594A4C0E0E0E0
            F6F6F6FDFDFDFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFDFDFD8EB2F02971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED29
            71ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED
            2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971
            ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED29
            71ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED
            2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971
            ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED29
            71ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED
            2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971
            ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED29
            71ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED
            2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971
            ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED29
            71ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED
            2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971
            ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED29
            71ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED
            2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971
            ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED29
            71ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED
            2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971
            ED2971ED2871ED2871ED2871ED2871ED2871ED2871ED2871ED2871ED3072E397
            A2B4DEDEDEF9F9F9FEFEFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFDFDFD8EB2F02971ED2971ED2971ED2971ED2971ED2971
            ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED29
            71ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED
            2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971
            ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED29
            71ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED
            2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971
            ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED29
            71ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED
            2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971
            ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED29
            71ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED
            2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971
            ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED29
            71ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED
            2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971
            ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED29
            71ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED
            2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971
            ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED29
            71ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED
            2971ED2971ED2971ED2971ED2871ED2871ED2871ED2871ED2871ED2871ED2871
            ED2E72E5939FB4D5D5D5F4F4F4FEFEFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFDFDFD8EB2F02971ED2971ED2971ED
            2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971
            ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED29
            71ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED
            2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971
            ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED29
            71ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED
            2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971
            ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED29
            71ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED
            2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971
            ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED29
            71ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED
            2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971
            ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED29
            71ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED
            2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971
            ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED29
            71ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED
            2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971
            ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED29
            71ED2971ED2971ED2971ED2971ED2971ED2971ED2871ED2871ED2871ED2871ED
            2871ED2871ED2C72E78E9DB5D2D2D2F0F0F0FDFDFDFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFDFDFD8EB2F029
            71ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED
            2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971
            ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED29
            71ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED
            2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971
            ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED29
            71ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED
            2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971
            ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED29
            71ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED
            2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971
            ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED29
            71ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED
            2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971
            ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED29
            71ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED
            2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971
            ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED29
            71ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED
            2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971
            ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2871ED28
            71ED2871ED2871ED2871ED3675E19DA8BBD9D9D9F3F3F3FDFDFDFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFDFDFD8EB2F02971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED29
            71ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED
            2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971
            ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED29
            71ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED
            2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971
            ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED29
            71ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED
            2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971
            ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED29
            71ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED
            2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971
            ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED29
            71ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED
            2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971
            ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED29
            71ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED
            2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971
            ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED29
            71ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED
            2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971
            ED2971ED2871ED2871ED2871ED2871ED2A71EA97A5BCE1E1E1F7F7F7FDFDFDFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFDFDFD8FB3F12971ED2971ED2971ED2971ED2971ED2971
            ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED29
            71ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED
            2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971
            ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED29
            71ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED
            2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971
            ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED29
            71ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED
            2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971
            ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED29
            71ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED
            2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971
            ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED29
            71ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED
            2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971
            ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED29
            71ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED
            2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971
            ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED29
            71ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED
            2971ED2971ED2971ED2971ED2871ED2871ED2871ED2971EB7C93B8D6D6D6F6F6
            F6FDFDFDFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFEFE8FB3F12971ED2971ED2971ED
            2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971
            ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED29
            71ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED
            2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971
            ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED29
            71ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED
            2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971
            ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED29
            71ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED
            2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971
            ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED29
            71ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED
            2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971
            ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED29
            71ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED
            2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971
            ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED29
            71ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED
            2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971
            ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED29
            71ED2971ED2971ED2971ED2971ED2971ED2971ED2871ED2871ED2871EB7790BA
            CBCBCBF0F0F0FDFDFDFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFDFDFD8FB3F129
            71ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED
            2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971
            ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED29
            71ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED
            2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971
            ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED29
            71ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED
            2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971
            ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED29
            71ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED
            2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971
            ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED29
            71ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED
            2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971
            ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED29
            71ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED
            2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971
            ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED29
            71ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED
            2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971
            ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2871ED30
            73E68B9EBDD2D2D2EFEFEFFCFCFCFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFEFEFE91B5F32971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED29
            71ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED
            2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971
            ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED29
            71ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED
            2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971
            ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED29
            71ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED
            2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971
            ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED29
            71ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED
            2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971
            ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED29
            71ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED
            2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971
            ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED29
            71ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED
            2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971
            ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED29
            71ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED
            2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971
            ED2971ED2871ED92A8CBDEDEDEF4F4F4FDFDFDFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFF93B7F52971ED2971ED2971ED2971ED2971ED2971
            ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED29
            71ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED
            2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971
            ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED29
            71ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED
            2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971
            ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED29
            71ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED
            2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971
            ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED29
            71ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED
            2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971
            ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED29
            71ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED
            2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971
            ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED29
            71ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED
            2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971
            ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED29
            71ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED2971ED
            2971ED2971ED2971ED2971ED8AACE7E7E7E7F6F6F6FDFDFDFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFEFEF8F8F8EDEDEDE7E7E7
            E7E7E7E7E7E7E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6
            E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6
            E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6
            E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6
            E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6
            E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6
            E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6
            E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6
            E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6
            E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6
            E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6
            E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6
            E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6
            E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6
            E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6
            E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6
            E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6
            E6E6E7E7E7E7E7E7E8E8E8EDEDEDF3F3F3F7F7F7F8F8F8F8F8F8F8F8F8F8F8F8
            F8F8F8F8F8F8F8F8F8F8F8F8F8F8F8F8F8F8F8F8F8F8F8F8F8F8F8F8F8F8F8F8
            F8F8F8F8F8F8F8F8F8F8F8F8F8F8F8F8F8F8F8F8F8F8F8F8F8F8F8F8F8F8F8F8
            F8F8F8F8F8F8F8F8F8F8F8F8F8F8F8F8F8F8F8F8F8F8F8FBFBFBFEFEFEFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFEFEF7F7F7E1
            E1E1BBBBBBA6A6A6A4A4A4A4A4A4A4A4A4A4A4A4A4A4A4A4A4A4A4A4A4A4A4A4
            A4A4A4A4A4A4A4A4A4A4A4A4A4A4A4A4A4A4A4A4A4A4A4A4A4A4A4A4A4A4A4A4
            A4A4A4A4A4A4A4A4A4A4A4A4A4A4A4A4A4A4A4A4A4A4A4A4A4A4A4A4A4A4A4A4
            A4A4A4A4A4A4A4A4A4A4A4A4A4A4A4A4A4A4A4A4A4A4A4A4A4A4A4A4A4A4A4A4
            A4A4A4A4A4A4A4A4A4A4A4A4A4A4A4A4A4A4A4A4A4A4A4A4A4A4A4A4A4A4A4A4
            A4A4A4A4A4A4A4A4A4A4A4A4A4A4A4A4A4A4A4A4A4A4A4A4A4A4A4A4A4A4A4A4
            A4A4A4A4A4A4A4A4A4A4A4A4A4A4A4A4A4A4A4A4A4A4A4A4A4A4A4A4A4A4A4A4
            A4A4A4A4A4A4A4A4A4A4A4A4A4A4A4A4A4A4A4A4A4A4A4A4A4A4A4A4A4A4A4A4
            A4A4A4A4A4A4A4A4A4A4A4A4A4A4A4A4A4A4A4A4A4A4A4A4A4A4A4A4A4A4A4A4
            A4A4A4A4A4A4A4A4A4A4A4A4A4A4A4A4A4A4A4A4A4A4A4A4A4A4A4A4A4A4A4A4
            A4A4A4A4A4A4A4A4A4A4A4A4A4A4A4A4A4A4A4A4A4A4A4A4A4A4A4A4A4A4A4A4
            A4A4A4A4A4A4A4A4A4A4A4A4A4A4A4A4A4A4A4A4A4A4A4A4A4A4A4A4A4A4A4A4
            A4A4A4A4A4A4A4A4A4A4A4A4A4A4A4A4A4A4A4A4A4A4A4A4A4A4A4A4A4A4A4A4
            A4A4A4A4A4A4A4A4A4A4A4A4A4A4A4A4A4A4A4A4A4A4A4A4A4A4A4A4A4A4A4A4
            A4A4A4A4A4A4A4A4A4A4A4A4A4A4A4A4A4A4A4A4A4A4A4A4A4A4A4A4A4A4A4A4
            A4A4A4A4A4A4A4A4A4A4A4A4A4A4A4A4A4A4A4A4A4A4A4A4A4A4A4A4A4A4A4A4
            A4A4A4A4A4A4A4A4A4A4A4A4A4A4A4A4A4A4A4A4A4A4A4A4A4A4A4A4A4A4A4A4
            A4A4A4A4A4A4A4A4A4A4A4A4A4A4A4A4ABABABBDBDBDD8D8D8F0F0F0FCFCFCFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFEFEFEF0F0F0C5C5C57878784F4F4F49494948484847474747474747474747
            4747474747474747474747474747474747484848494949494949494949494949
            4949494949494949494949494949494949494949494949494949494949494949
            4949494949494949494949494949494949494949494949494949494949494949
            4949494949494949494949494949494949494949494949494949494949494949
            4949494949494949494949494949494949494949494949494949494949494949
            4949494949494949494949494949494949494949494949494949494949494949
            4949494949494949494949494949494949494949494949494949494949494949
            4949494949494949494949494949494949494949494949494949494949494949
            4949494949494949494949494949494949494949494949494949494949494949
            4949494949494949494949494949494949494949494949494949494949494949
            4949494949494949494949494949494949494949494949494949494949494949
            4949494949494949494949494949494949494949494949494949494949494949
            4949494949494949494949494949494949494949494949494949494949494949
            4949494949494949494949494949494949494949494949494949494949494949
            4949494949494949494949494949494949494949494949494949494949494949
            4949494949494949494949494949494949494949494949494949494949494949
            4949494949494949494949494949494949494949494A4A4A5252526A6A6A9898
            98C9C9C9EFEFEFFDFDFDFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFEFEFE8ACBF91FA1FE1FA1FE1E9EFB1C97F01A8CDE1984
            D21881CD1881CD1881CD1881CD1881CD1881CD1882CD1984D21B8FE31D9BF61E
            A0FD1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE
            1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1
            FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1F
            A1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE
            1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1
            FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1F
            A1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE
            1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1
            FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1F
            A1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE
            1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1
            FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1F
            A1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE
            1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1
            FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1F
            A1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE
            285F873C3C3C606060959595D3D3D3F4F4F4FDFDFDFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFEFE8ACBF91FA1FE1EA0FD1D9BF5
            1A8ADB156FB0115B91105586105586105586105586105586105586105588115C
            931677BC1C94EB1E9EFB1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1F
            A1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE
            1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1
            FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1F
            A1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE
            1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1
            FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1F
            A1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE
            1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1
            FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1F
            A1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE
            1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1
            FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1F
            A1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE
            1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1
            FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1F
            A1FE1FA1FE1FA1FE1EA0FD255C84393939606060A3A3A3DDDDDDF4F4F4FDFDFD
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFDFDFD89CAF91E
            A1FD1EA0FD43A9F37BB5DF779EBB748EA0738999738B9C738C9E738C9E738C9E
            748D9F748EA03664841367A31B8FE41E9DF91EA1FD1EA1FD1EA1FD1EA1FD1EA1
            FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1E
            A1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD
            1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1
            FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1E
            A1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD
            1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1
            FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1E
            A1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD
            1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1
            FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1E
            A1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD
            1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1
            FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1E
            A1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD
            1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1
            FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA0FD2272AC343C41626262A4
            A4A4D3D3D3EFEFEFFCFCFCFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFDFDFD89CAF91FA1FE1EA0FD77C2F8FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFF71A2C6177BC21C95ED1E9FFB1FA1FE1FA1FE
            1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1
            FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1F
            A1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE
            1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1
            FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1F
            A1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE
            1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1
            FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1F
            A1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE
            1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1
            FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1F
            A1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE
            1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1
            FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1F
            A1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE
            1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1
            FE2088D3353B3F626262979797CBCBCBF0F0F0FDFDFDFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFDFDFD89CAF91FA1FE1EA0FD77C2F7FFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF75B8E91B93E81D9CF81E
            A0FD1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE
            1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1
            FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1F
            A1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE
            1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1
            FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1F
            A1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE
            1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1
            FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1F
            A1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE
            1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1
            FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1F
            A1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE
            1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1
            FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1F
            A1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE
            1FA1FE1FA1FE1FA1FE1FA1FE236FA53B3B3B626262989898D5D5D5F6F6F6FDFD
            FDFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFDFDFD89CAF91FA1FE1EA0FD77C2F7
            FFFFFFFFFFFFC1C9CF0C42691677BD1B90E51D97F01D99F21D99F21D99F21D9A
            F31E9DF91EA0FD1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1F
            A1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE
            1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1
            FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1F
            A1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE
            1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1
            FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1F
            A1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE
            1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1
            FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1F
            A1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE
            1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1
            FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1F
            A1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE
            1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1
            FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1F
            A1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA0FC25577B3C3C3C636363
            A7A7A7E0E0E0F6F6F6FDFDFDFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFDFDFD89CAF91E
            A1FD1EA0FD77C1F7FFFFFFFFFFFFC0C8CE0B3B5D1367A3177DC51882CE1883CF
            1883D01985D31A8CDE1C98F11EA0FC1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1
            FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1E
            A1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD
            1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1
            FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1E
            A1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD
            1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1
            FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1E
            A1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD
            1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1
            FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1E
            A1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD
            1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1
            FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1E
            A1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD
            1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1
            FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1E
            A0FC246DA1363B3E666666A8A8A8D6D6D6F1F1F1FCFCFCFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFDFDFD89CAF91FA1FE1EA0FD77C2F7FFFFFFFFFFFFC0C7CC0729420B40650E
            4B770F4E7B0F4E7C0F4F7D0F55871368A51A8ADB1E9DFA1FA1FE1FA1FE1FA1FE
            1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1
            FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1F
            A1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE
            1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1
            FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1F
            A1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE
            1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1
            FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1F
            A1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE
            1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1
            FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1F
            A1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE
            1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1
            FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1F
            A1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE
            1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1
            FE1FA1FE1FA1FE1FA1FE1FA1FE2185CC373B3E6565659C9C9CCECECEF2F2F2FD
            FDFDFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFDFDFD89CAF91FA1FE1EA0FD77C2F7FFFFFFFFFFFFD3D7
            DB506371526C7F537086537288537288537289335E7D10578A1984D11D9DF81F
            A1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE
            1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1
            FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1F
            A1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE
            1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1
            FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1F
            A1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE
            1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1
            FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1F
            A1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE
            1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1
            FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1F
            A1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE
            1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1
            FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1F
            A1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE
            1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE246B9E3D3D3D6666
            669D9D9DD8D8D8F7F7F7FDFDFDFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFDFDFD89CAF91FA1FE1EA0FD77C2F7
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF93B2C91367
            A31A8ADA1E9DF91FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1F
            A1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE
            1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1
            FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1F
            A1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE
            1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1
            FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1F
            A1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE
            1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1
            FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1F
            A1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE
            1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1
            FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1F
            A1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE
            1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1
            FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1F
            A1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE
            1F9FFB274F6C3E3E3E676767AAAAAAE1E1E1F7F7F7FDFDFDFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFDFDFD89CAF91E
            A1FD1EA0FD77C1F7FFFFFFFFFFFFF8F9FAE6EBEFE7F0F7E7F2FAE8F3FBE8F3FB
            E8F3FC8AC0E81A8ADA1C97EF1E9FFC1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1
            FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1E
            A1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD
            1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1
            FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1E
            A1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD
            1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1
            FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1E
            A1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD
            1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1
            FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1E
            A1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD
            1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1
            FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1E
            A1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD
            1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1
            FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1E
            A1FD1EA1FD1EA1FD1EA1FD1E9EF9246797373B3D696969ABABABD8D8D8F2F2F2
            FCFCFCFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFDFDFD89CAF91FA1FE1EA0FD77C2F7FFFFFFFFFFFFC0C9CE0B3E62146DAD19
            84D21A8BDC1A8BDD1A8BDD1A8CDE1B90E31C97F01E9FFB1FA1FE1FA1FE1FA1FE
            1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1
            FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1F
            A1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE
            1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1
            FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1F
            A1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE
            1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1
            FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1F
            A1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE
            1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1
            FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1F
            A1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE
            1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1
            FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1F
            A1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE
            1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1
            FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE2180C4383B3E68
            68689F9F9FD1D1D1F3F3F3FEFEFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFDFDFD89CAF91FA1FE1EA0FD77C2F8FFFFFFFFFFFFC0C8
            CD0933500F548513649F1469A6146AA7146AA8146BAA1572B61988D71D9BF61E
            A0FD1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE
            1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1
            FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1F
            A1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE
            1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1
            FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1F
            A1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE
            1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1
            FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1F
            A1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE
            1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1
            FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1F
            A1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE
            1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1
            FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1F
            A1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE
            1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1
            FE1FA1FE2566953F3F3F696969A1A1A1DBDBDBF8F8F8FEFEFEFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFDFDFD89CAF91FA1FE1EA0FD77C2F8
            FFFFFFFFFFFFC0C8CE0728400A37570B3E620B3F650C40650C40660C436A0F50
            7F1675BA1C97EF1EA0FC1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1F
            A1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE
            1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1
            FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1F
            A1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE
            1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1
            FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1F
            A1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE
            1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1
            FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1F
            A1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE
            1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1
            FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1F
            A1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE
            1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1
            FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1F
            A1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE
            1FA1FE1FA1FE1FA1FE1FA1FE1F9DF8274A624040406B6B6BB3B3B3EBEBEBFCFC
            FCFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFDFDFD89CAF91F
            A1FE1EA0FD77C2F9FFFFFFFFFFFFECEFF1B4C0C8B5C1CAB5C2CBB5C2CCB5C2CC
            B5C2CCB5C3CD1F58821573B61C96EE1EA0FC1FA1FE1FA1FE1FA1FE1FA1FE1FA1
            FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1F
            A1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE
            1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1
            FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1F
            A1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE
            1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1
            FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1F
            A1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE
            1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1
            FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1F
            A1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE
            1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1
            FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1F
            A1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE
            1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1
            FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1F
            A1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1F9CF5294A63474747
            909090DCDCDCF9F9F9FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFDFDFD89CAF91EA1FD1EA0FD77C4FBFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFF2C82BF1A89D91D9BF51EA0FD1EA1FD1EA1FD
            1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1
            FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1E
            A1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD
            1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1
            FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1E
            A1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD
            1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1
            FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1E
            A1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD
            1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1
            FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1E
            A1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD
            1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1
            FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1E
            A1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD
            1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1
            FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1E
            A1FD1E9DF834698F8B8B8BD9D9D9F8F8F8FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFDFDFD89CAF91FA1FE1FA1FE42AFFE78C5FC77C3F977C2
            F877C2F777C2F777C2F777C2F777C2F777C2F777C2F7259BF11D9CF71E9FFC1F
            A1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE
            1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1
            FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1F
            A1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE
            1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1
            FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1F
            A1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE
            1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1
            FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1F
            A1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE
            1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1
            FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1F
            A1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE
            1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1
            FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1F
            A1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE
            1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1
            FE1FA1FE1FA1FE1FA1FE1FA1FE3893D4B1B1B1EBEBEBFCFCFCFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFDFDFD89CAF91FA1FE1FA1FE1FA1FE
            1FA1FE1EA0FD1EA0FD1EA0FC1EA0FC1EA0FC1EA0FC1EA0FC1EA0FC1EA0FC1EA0
            FD1EA0FD1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1F
            A1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE
            1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1
            FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1F
            A1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE
            1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1
            FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1F
            A1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE
            1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1
            FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1F
            A1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE
            1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1
            FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1F
            A1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE
            1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1
            FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1F
            A1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE
            1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE21A0FA7CA2BED8D8D8F8F8F8FEFE
            FEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFDFDFD89CAF91F
            A1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE
            1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1
            FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1F
            A1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE
            1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1
            FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1F
            A1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE
            1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1
            FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1F
            A1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE
            1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1
            FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1F
            A1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE
            1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1
            FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1F
            A1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE
            1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1
            FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1F
            A1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE20A0FB76A1BFCCCCCC
            F1F1F1FDFDFDFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFDFDFD89CAF91EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1E
            A1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD
            1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1
            FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1E
            A1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD
            1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1
            FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1E
            A1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD
            1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1
            FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1E
            A1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD
            1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1
            FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1E
            A1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD
            1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1
            FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1E
            A1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD
            1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1
            FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD289FF38B
            AAC0D3D3D3F0F0F0FCFCFCFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFDFDFD89CAF91FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1
            FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1F
            A1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE
            1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1
            FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1F
            A1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE
            1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1
            FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1F
            A1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE
            1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1
            FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1F
            A1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE
            1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1
            FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1F
            A1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE
            1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1
            FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1F
            A1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE
            1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1
            FE1FA0FD84A8C2DCDCDCF4F4F4FDFDFDFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFDFDFD89CAF91FA1FE1FA1FE1FA1FE
            1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1
            FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1F
            A1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE
            1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1
            FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1F
            A1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE
            1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1
            FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1F
            A1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE
            1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1
            FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1F
            A1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE
            1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1
            FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1F
            A1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE
            1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1
            FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1F
            A1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE
            1FA1FE1FA1FE1FA1FE639EC8D0D0D0F4F4F4FDFDFDFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFDFDFD89CAF91F
            A1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE
            1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1
            FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1F
            A1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE
            1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1
            FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1F
            A1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE
            1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1
            FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1F
            A1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE
            1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1
            FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1F
            A1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE
            1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1
            FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1F
            A1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE
            1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1
            FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1F
            A1FE1FA1FE1FA1FE1FA1FE1FA1FE5D9ECCC4C4C4EEEEEEFDFDFDFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFDFDFD89CAF91EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1E
            A1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD
            1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1
            FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1E
            A1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD
            1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1
            FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1E
            A1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD
            1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1
            FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1E
            A1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD
            1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1
            FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1E
            A1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD
            1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1
            FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1E
            A1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD
            1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1
            FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD23A0F875A4C6CBCBCBECECECFCFCFCFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFDFDFD89CAF91FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1
            FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1F
            A1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE
            1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1
            FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1F
            A1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE
            1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1
            FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1F
            A1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE
            1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1
            FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1F
            A1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE
            1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1
            FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1F
            A1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE
            1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1
            FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1F
            A1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE
            1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE70A4C9D5D5D5F1F1
            F1FCFCFCFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFDFDFD89CAF91FA1FE1FA1FE1FA1FE
            1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1
            FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1F
            A1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE
            1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1
            FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1F
            A1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE
            1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1
            FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1F
            A1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE
            1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1
            FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1F
            A1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE
            1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1
            FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1F
            A1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE
            1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1
            FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1F
            A1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE4A9DD8
            C6C7C7F0F0F0FCFCFCFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFDFDFD89CAF91F
            A1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE
            1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1
            FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1F
            A1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE
            1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1
            FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1F
            A1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE
            1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1
            FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1F
            A1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE
            1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1
            FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1F
            A1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE
            1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1
            FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1F
            A1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE
            1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1
            FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1F
            A1FE459DDBB8BABBE9E9E9FCFCFCFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFDFDFD89CAF91EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1E
            A1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD
            1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1
            FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1E
            A1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD
            1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1
            FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1E
            A1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD
            1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1
            FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1E
            A1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD
            1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1
            FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1E
            A1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD
            1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1
            FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1E
            A1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD
            1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1
            FD1EA1FD1FA0FC61A1CFC1C3C4E8E8E8FAFAFAFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFDFDFD8ACBF91FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1
            FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1F
            A1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE
            1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1
            FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1F
            A1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE
            1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1
            FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1F
            A1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE
            1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1
            FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1F
            A1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE
            1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1
            FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1F
            A1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE
            1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1
            FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1F
            A1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE
            1FA1FE1FA1FE1FA1FE1FA1FE5CA0D2CDCDCDEDEDEDFBFBFBFEFEFEFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFEFE8ACBF91FA1FE1FA1FE1FA1FE
            1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1
            FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1F
            A1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE
            1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1
            FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1F
            A1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE
            1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1
            FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1F
            A1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE
            1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1
            FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1F
            A1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE
            1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1
            FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1F
            A1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE
            1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1
            FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1F
            A1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE389DE5BABEC1ECECECFBFBFBFEFEFE
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFEFE8ACBFA1F
            A1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE
            1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1
            FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1F
            A1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE
            1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1
            FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1F
            A1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE
            1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1
            FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1F
            A1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE
            1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1
            FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1F
            A1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE
            1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1
            FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1F
            A1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE
            1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1
            FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE359EE8A8B1B8E4E4E4FA
            FAFAFEFEFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFDFDFD8CCDFB1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1E
            A1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD
            1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1
            FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1E
            A1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD
            1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1
            FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1E
            A1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD
            1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1
            FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1E
            A1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD
            1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1
            FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1E
            A1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD
            1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1
            FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1E
            A1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD
            1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD1EA1FD58A9E3B9C0
            C6E3E3E3F9F9F9FEFEFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFF8ECFFD1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1
            FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1F
            A1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE
            1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1
            FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1F
            A1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE
            1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1
            FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1F
            A1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE
            1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1
            FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1F
            A1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE
            1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1
            FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1F
            A1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE
            1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1
            FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1F
            A1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE1FA1FE
            85C3EFE4E4E4F0F0F0FBFBFBFEFEFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFEFEF8F8F8EDEDEDE7E7E7
            E7E7E7E7E7E7E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6
            E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6
            E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6
            E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6
            E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6
            E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6
            E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6
            E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6
            E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6
            E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6
            E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6
            E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6
            E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6
            E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E7E7E7E7E7E7EA
            EAEAF1F1F1F7F7F7F8F8F8F8F8F8F8F8F8F8F8F8F8F8F8F8F8F8F8F8F8F8F8F8
            F8F8F8F8F8F8F8F8F8F8F8F8F8F8F8F8F8F8F8F8F8F8F8F8F8F8F8F8F8F8F8F8
            F8F8F8F8F8F8F8F8F8F8F8F8F8F8F8F8F8F8F8F8F8F8F8F8F8F8F8F8F8F8F8F8
            F8F8F8F8F8F8F8F8F8F8F8FAFAFAFDFDFDFEFEFEFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFEFEF9F9F9E8
            E8E8CACACABABABAB8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8
            B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8
            B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8
            B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8
            B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8
            B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8
            B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8
            B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8
            B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8
            B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8
            B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8
            B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8
            B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8
            B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8
            B8B8B8B8BABABAC4C4C4DEDEDEF5F5F5FDFDFDFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFDFDFDF1F1F1CACACA8484845F5F5F5A5A5A59595958585858585858585858
            58585858585858585959595A5A5A5A5A5A5A5A5A5A5A5A5A5A5A5A5A5A5A5A5A
            5A5A5A5A5A5A5A5A5A5A5A5A5A5A5A5A5A5A5A5A5A5A5A5A5A5A5A5A5A5A5A5A
            5A5A5A5A5A5A5A5A5A5A5A5A5A5A5A5A5A5A5A5A5A5A5A5A5A5A5A5A5A5A5A5A
            5A5A5A5A5A5A5A5A5A5A5A5A5A5A5A5A5A5A5A5A5A5A5A5A5A5A5A5A5A5A5A5A
            5A5A5A5A5A5A5A5A5A5A5A5A5A5A5A5A5A5A5A5A5A5A5A5A5A5A5A5A5A5A5A5A
            5A5A5A5A5A5A5A5A5A5A5A5A5A5A5A5A5A5A5A5A5A5A5A5A5A5A5A5A5A5A5A5A
            5A5A5A5A5A5A5A5A5A5A5A5A5A5A5A5A5A5A5A5A5A5A5A5A5A5A5A5A5A5A5A5A
            5A5A5A5A5A5A5A5A5A5A5A5A5A5A5A5A5A5A5A5A5A5A5A5A5A5A5A5A5A5A5A5A
            5A5A5A5A5A5A5A5A5A5A5A5A5A5A5A5A5A5A5A5A5A5A5A5A5A5A5A5A5A5A5A5A
            5A5A5A5A5A5A5A5A5A5A5A5A5A5A5A5A5A5A5A5A5A5A5A5A5A5A5A5A5A5A5A5A
            5A5A5A5A5A5A5A5A5A5A5A5A5A5A5A5A5A5A5A5A5A5A5A5A5A5A5A5A5A5A5A5A
            5A5A5A5A5A5A5A5A5A5A5A5A5A5A5A5A5A5A5A5A5A5A5A5A5A5A5A5A5A5A5A5A
            5A5A5A5A5A5A5A5A5A5A5A5A5A5A5A5A5A5A5A5A5A5A5A5A5A5A5A5A5A5A5A5A
            5A5A5A5A5A5A5A5A5A5B5B5B5E5E5E6D6D6D9B9B9BD2D2D2EFEFEFFBFBFBFEFE
            FEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFEFEFE7CDEF803C8FB03C8FB02C5F802BCED02AFDB02A4
            CF02A1CA02A1CA02A1CA02A1CA02A4CE02ABD802B4E302BEEE02C4F703C8FB03
            C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB
            03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8
            FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03
            C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB
            03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8
            FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03
            C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB
            03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8
            FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03
            C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB
            03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8
            FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03
            C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB09AFD92F4145565656959595
            C9C9C9EBEBEBFBFBFBFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFEFE7CDEF803C8FB02C7FA02C1F2
            02ABD8018BAE01728F016984016984016985016985016E8A017A99018AAE02A0
            CA02B8E802C5F803C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03
            C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB
            03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8
            FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03
            C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB
            03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8
            FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03
            C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB
            03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8
            FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03
            C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB
            03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8
            FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB08
            ACD8323E41606060969696CACACAEFEFEFFDFDFDFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFDFDFD7BDEF703
            C8FB02C7FA10C0EE27ABCD268097266171265866265C6A265E6D1C5867014555
            00495B01566C01718E019DC502BDED02C6F903C8FB03C8FB03C8FB03C8FB03C8
            FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03
            C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB
            03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8
            FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03
            C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB
            03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8
            FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03
            C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB
            03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8
            FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03
            C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB
            03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8
            FB03C8FB03C8FB03C8FC118AAB3A3A3A606060979797D3D3D3F4F4F4FDFDFDFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFDFDFD7BDEF703C7FA02C7FA66D8F6FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFE9EFF09BB4BA31616E004254016F8B02A6D002BEEF02C6F903C7FA
            03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7
            FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03
            C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA
            03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7
            FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03
            C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA
            03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7
            FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03
            C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA
            03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7
            FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03
            C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA
            03C7FA03C7FA03C7FA03C7FA03C7FA03C7FC02C7FB1287A6343D3F5757579797
            97D3D3D3EFEFEFFBFBFBFEFEFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFDFDFD7BDEF703C8FB02C7FA67D8F5FFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFBFCFC446C76004B5E0189AC02
            B3E102C4F703C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB
            03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8
            FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03
            C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB
            03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8
            FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03
            C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB
            03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8
            FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03
            C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB
            03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8
            FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03
            C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FC03C8FC03C8FC
            09A7D22D3A3E575757989898CCCCCCEDEDEDFCFCFCFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFDFDFD7BDEF703C8FB02C7FA67D8F5
            FFFFFFFFFFFFD8DFE1004E630293B802B7E51DC7F49EE7F9FFFFFFFFFFFFE1E7
            E905404F01749202A8D302C1F302C7FA03C8FB03C8FB03C8FB03C8FB03C8FB03
            C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB
            03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8
            FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03
            C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB
            03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8
            FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03
            C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB
            03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8
            FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03
            C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB
            03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8
            FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03
            C8FC03C8FC03C8FC03C8FC09A7D2353E406363639A9A9ACDCDCDF1F1F1FDFDFD
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFDFDFD7BDEF703
            C8FB02C7FA67D8F5FFFFFFFFFFFFD8E0E10051650297BD02BBEB02C6F910C8F8
            F5FCFEFFFFFFFFFFFF3A657001667F029EC602BEEF02C7FA03C8FB03C8FB03C8
            FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03
            C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB
            03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8
            FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03
            C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB
            03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8
            FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03
            C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB
            03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8
            FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03
            C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB
            03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8
            FB03C8FB03C8FB03C8FC03C8FC03C8FC03C8FC03C8FC1383A13D3D3D6464649B
            9B9BD6D6D6F6F6F6FDFDFDFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFDFDFD7BDEF703C7FA02C7FA66D8F4FFFFFFFFFFFFD8DFE10051650297BD02
            BCEB02C7FA02C7FA9FE6F9FFFFFFFFFFFF78949C015C740297BE02BCEC02C7FA
            03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7
            FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03
            C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA
            03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7
            FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03
            C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA
            03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7
            FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03
            C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA
            03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7
            FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03
            C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA
            03C7FA03C7FA03C7FA03C7FA03C7FA03C7FC03C7FC03C7FC03C7FC03C7FC03C6
            FA14809C363C3E5A5A5A9B9B9BD7D7D7F1F1F1FCFCFCFEFEFEFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFDFDFD7BDEF703C8FB02C7FA67D8F5FFFFFFFFFFFFD8E0
            E10051650297BD02BCEC02C7FA02C7FA76DCF6FFFFFFFFFFFF96ACB1015A7202
            96BC02BBEC02C7FA03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB
            03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8
            FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03
            C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB
            03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8
            FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03
            C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB
            03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8
            FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03
            C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB
            03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8
            FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03
            C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FC03C8FC03C8FC
            03C8FC03C8FC03C8FC03C8FC0AA2CA2F393B5B5B5B9D9D9DCFCFCFEEEEEEFCFC
            FCFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFDFDFD7BDEF703C8FB02C7FA67D8F5
            FFFFFFFFFFFFD8E0E10051650297BD02BCEC02C7FA02C6F973DAF4FFFFFFFFFF
            FF99AFB5015F780299C102BDED02C7FA03C8FB03C8FB03C8FB03C8FB03C8FB03
            C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB
            03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8
            FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03
            C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB
            03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8
            FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03
            C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB
            03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8
            FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03
            C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB
            03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8
            FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03
            C8FC03C8FC03C8FC03C8FC03C8FC03C8FC03C8FC03C8FC0AA0C8363B3D676767
            9D9D9DCFCFCFF2F2F2FDFDFDFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFDFDFD7BDEF703
            C8FB02C7FA67D8F5FFFFFFFFFFFFD8E0E10050650296BC02BAEB02C6F902C3F5
            74D6EFFFFFFFFFFFFF97B0B601698402A0CA02BFF102C7FA03C8FB03C8FB03C8
            FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03
            C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB
            03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8
            FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03
            C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB
            03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8
            FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03
            C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB
            03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8
            FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03
            C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB
            03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8
            FB03C8FB03C8FB03C8FC03C8FC03C8FC03C8FC03C8FC03C8FC03C8FC03C8FC03
            C8FC157B963E3E3E6767679E9E9ED8D8D8F7F7F7FDFDFDFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFDFDFD7BDEF703C7FA02C7FA66D8F4FFFFFFFFFFFFD8DFE1004B5F018BAF02
            ACD702B4E202ABD798D5E4FFFFFFFFFFFF7EA5B0017E9E02AEDA02C3F503C7FA
            03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7
            FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03
            C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA
            03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7
            FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03
            C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA
            03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7
            FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03
            C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA
            03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7
            FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03
            C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA
            03C7FA03C7FA03C7FA03C7FA03C7FA03C7FC03C7FC03C7FC03C7FC03C7FC03C7
            FC03C7FC03C7FC03C7FC03C5F9157B96373C3D5C5C5C9E9E9ED9D9D9F3F3F3FC
            FCFCFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFDFDFD7BDEF703C8FB02C7FA67D8F6FFFFFFFFFFFFD8DF
            E1003C4C01657F017A99017D9E0F7B96F1F7F8FFFFFFFFFFFF4C95A8029CC302
            BBEC02C6F903C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB
            03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8
            FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03
            C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB
            03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8
            FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03
            C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB
            03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8
            FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03
            C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB
            03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8
            FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03
            C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FC03C8FC03C8FC
            03C8FC03C8FC03C8FC03C8FC03C8FC03C8FC03C8FC03C8FC0C9CC23136375E5E
            5EA1A1A1D2D2D2F1F1F1FDFDFDFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFDFDFD7BDEF703C8FB02C7FA67D8F6
            FFFFFFFFFFFFD8DFE100313E004253014B5E034E618FB0B8FFFFFFFFFFFFF1F6
            F80E8BAC02B2E002C2F502C7FA03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03
            C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB
            03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8
            FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03
            C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB
            03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8
            FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03
            C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB
            03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8
            FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03
            C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB
            03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8
            FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03
            C8FC03C8FC03C8FC03C8FC03C8FC03C8FC03C8FC03C8FC03C8FC03C8FC03C8FC
            03C8FC0D97BB393C3D6B6B6BA5A5A5DADADAF6F6F6FEFEFEFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFDFDFD7BDEF703
            C8FB02C7FA67D9F7FFFFFFFFFFFFF3F6F7B4C5C9BFCED2C4D3D7E8EEEFFFFFFF
            FFFFFFFFFFFF62B5CA02A7D202BFF102C6F903C8FB03C8FB03C8FB03C8FB03C8
            FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03
            C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB
            03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8
            FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03
            C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB
            03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8
            FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03
            C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB
            03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8
            FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03
            C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB
            03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8
            FB03C8FB03C8FB03C8FC03C8FC03C8FC03C8FC03C8FC03C8FC03C8FC03C8FC03
            C8FC03C8FC03C8FC03C8FC03C8FC1776904747477F7F7FC2C2C2EEEEEEFEFEFE
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFDFDFD7BDEF703C8FB02C7FA67DBF9FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFBFDFE73CAE102ABD702BDEE02C6F903C8FB03C8FB03C8FB
            03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8
            FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03
            C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB
            03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8
            FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03
            C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB
            03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8
            FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03
            C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB
            03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8
            FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03
            C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB
            03C8FB03C8FB03C8FB03C8FB03C8FB03C8FC03C8FC03C8FC03C8FC03C8FC03C8
            FC03C8FC03C8FC03C8FC03C8FC03C8FC03C8FC03C8FC03C3F6306370747474BB
            BBBBECECECFEFEFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFDFDFD7BDEF703C7FA03C7FA3ED4FB99E7FC99E6FA99E5
            F999E5F899E4F891E2F78BE0F769D7F41CC2ED02BEEF02C3F502C6F903C7FA03
            C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA
            03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7
            FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03
            C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA
            03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7
            FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03
            C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA
            03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7
            FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03
            C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA
            03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7
            FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03
            C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FC03C7FC03C7FC
            03C7FC03C7FC03C7FC03C7FC03C7FC03C7FC03C7FC03C7FC03C7FC03C7FC03C7
            FC21ABCF989898D2D2D2F4F4F4FDFDFDFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFDFDFD7BDEF703C8FB03C8FB03C8FB
            03C8FB02C7FA02C7FA02C6F902C6F902C6F902C7FA02C7FA02C7FA03C8FB03C8
            FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03
            C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB
            03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8
            FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03
            C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB
            03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8
            FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03
            C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB
            03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8
            FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03
            C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB
            03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8
            FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03
            C8FC03C8FC03C8FC03C8FC03C8FC03C8FC03C8FC03C8FC03C8FC03C8FC03C8FC
            03C8FC03C8FC04C6F974AEBDCFCFCFEFEFEFFCFCFCFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFDFDFD7BDEF703
            C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB
            03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8
            FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03
            C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB
            03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8
            FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03
            C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB
            03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8
            FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03
            C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB
            03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8
            FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03
            C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB
            03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8
            FB03C8FB03C8FB03C8FC03C8FC03C8FC03C8FC03C8FC03C8FC03C8FC03C8FC03
            C8FC03C8FC03C8FC03C8FC03C8FC4AB5D1CCCCCCEDEDEDFBFBFBFEFEFEFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFDFDFD7BDEF703C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03
            C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB
            03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8
            FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03
            C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB
            03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8
            FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03
            C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB
            03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8
            FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03
            C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB
            03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8
            FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03
            C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB
            03C8FB03C8FB03C8FB03C8FB03C8FB03C8FC03C8FC03C8FC03C8FC03C8FC03C8
            FC03C8FC03C8FC03C8FC03C8FC03C8FC03C8FC1FBCE6B8BFC0ECECECFAFAFAFE
            FEFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFDFDFD7BDEF703C7FA03C7FA03C7FA03C7FA03C7FA03C7
            FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03
            C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA
            03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7
            FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03
            C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA
            03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7
            FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03
            C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA
            03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7
            FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03
            C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA
            03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7
            FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03
            C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FC03C7FC03C7FC
            03C7FC03C7FC03C7FC03C7FC03C7FC03C7FC03C7FC03C7FB3EB6D6B4BDBFE9E9
            E9FBFBFBFEFEFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFDFDFD7BDEF703C8FB03C8FB03C8FB
            03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8
            FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03
            C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB
            03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8
            FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03
            C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB
            03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8
            FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03
            C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB
            03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8
            FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03
            C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB
            03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8
            FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03
            C8FC03C8FC03C8FC03C8FC03C8FC03C8FC03C8FC03C8FC03C8FC03C8FC56AFC7
            C6C6C6EAEAEAFBFBFBFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFDFDFD7BDEF703
            C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB
            03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8
            FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03
            C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB
            03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8
            FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03
            C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB
            03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8
            FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03
            C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB
            03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8
            FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03
            C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB
            03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8
            FB03C8FB03C8FB03C8FC03C8FC03C8FC03C8FC03C8FC03C8FC03C8FC03C8FC03
            C8FC35B9DBC4C4C4E9E9E9FAFAFAFEFEFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFDFDFD7BDEF703C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03
            C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB
            03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8
            FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03
            C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB
            03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8
            FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03
            C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB
            03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8
            FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03
            C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB
            03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8
            FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03
            C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB
            03C8FB03C8FB03C8FB03C8FB03C8FB03C8FC03C8FC03C8FC03C8FC03C8FC03C8
            FC03C8FC03C8FC10C1F0A7B9BEE7E7E7F9F9F9FEFEFEFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFDFDFD7BDEF703C7FA03C7FA03C7FA03C7FA03C7FA03C7
            FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03
            C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA
            03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7
            FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03
            C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA
            03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7
            FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03
            C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA
            03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7
            FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03
            C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA
            03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7
            FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03
            C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FC03C7FC03C7FC
            03C7FC03C7FC03C7FC03C7FC2ABBE1A3B8BDE4E4E4FAFAFAFEFEFEFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFDFDFD7BDEF703C8FB03C8FB03C8FB
            03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8
            FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03
            C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB
            03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8
            FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03
            C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB
            03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8
            FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03
            C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB
            03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8
            FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03
            C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB
            03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8
            FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03
            C8FC03C8FC03C8FC03C8FC03C8FC03C8FC38B6D7BBBCBCE5E5E5FAFAFAFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFDFDFD7BDEF703
            C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB
            03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8
            FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03
            C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB
            03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8
            FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03
            C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB
            03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8
            FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03
            C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB
            03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8
            FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03
            C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB
            03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8
            FB03C8FB03C8FB03C8FC03C8FC03C8FC03C8FC03C8FC22BCE5B8BBBBE3E3E3F8
            F8F8FEFEFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFDFDFD7BDEF703C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03
            C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB
            03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8
            FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03
            C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB
            03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8
            FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03
            C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB
            03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8
            FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03
            C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB
            03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8
            FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03
            C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB
            03C8FB03C8FB03C8FB03C8FB03C8FB03C8FC03C8FC03C8FC03C8FC07C5F793B5
            BFE2E2E2F7F7F7FEFEFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFDFDFD7BDEF703C7FA03C7FA03C7FA03C7FA03C7FA03C7
            FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03
            C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA
            03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7
            FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03
            C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA
            03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7
            FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03
            C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA
            03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7
            FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03
            C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA
            03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7
            FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03
            C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FC03C7FC03C7FC
            1ABFEA8DB5BFDEDEDEF9F9F9FEFEFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFEFE7CDEF803C8FB03C8FB03C8FB
            03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8
            FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03
            C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB
            03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8
            FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03
            C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB
            03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8
            FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03
            C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB
            03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8
            FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03
            C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB
            03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8
            FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03
            C8FC03C8FC22BBE3AAB4B7DFDFDFF8F8F8FEFEFEFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFEFE7CDFF803
            C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB
            03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8
            FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03
            C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB
            03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8
            FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03
            C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB
            03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8
            FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03
            C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB
            03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8
            FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03
            C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB
            03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8
            FB03C8FB03C8FB03C8FC15C0EDA6B4B8DDDDDDF4F4F4FDFDFDFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFEFEFE7DE0F903C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03
            C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB
            03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8
            FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03
            C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB
            03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8
            FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03
            C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB
            03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8
            FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03
            C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB
            03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8
            FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03
            C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB03C8FB
            03C8FB03C8FB03C8FB03C8FB03C8FB03C7FB81B9C8DDDDDDF4F4F4FDFDFDFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFEFEFE7FE2FB03C7FA03C7FA03C7FA03C7FA03C7FA03C7
            FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03
            C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA
            03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7
            FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03
            C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA
            03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7
            FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03
            C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA
            03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7
            FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03
            C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA
            03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7
            FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03
            C7FA03C7FA03C7FA03C7FA03C7FA03C7FA03C7FA18CAF898D5E4E4E4E4F7F7F7
            FDFDFDFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFEFEF8F8F8EDEDEDE7E7E7
            E7E7E7E7E7E7E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6
            E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6
            E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6
            E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6
            E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6
            E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6
            E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6
            E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6
            E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6
            E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6
            E6E6E6E6E6E6E6E6E6E6E6E6E6E7E7E7E7E7E7EAEAEAF0F0F0F5F5F5F8F8F8F8
            F8F8F8F8F8F8F8F8F8F8F8F8F8F8F8F8F8F8F8F8F8F8F8F8F8F8F8F8F8F8F8F8
            F8F8F8F8F8F8F8F8F8F8F8F8F8F8F8F8F8F8F8F8F8F8F8F8F8F8F8F8F8F8F8F8
            F8F8F8F8F8F8F8F8F8F8F8F8F8F8F8F8F8F8F8F8F8F8F8F8F8F8F8F8F8F8F8FA
            FAFAFCFCFCFEFEFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFEFEF9F9F9E8
            E8E8CACACABABABAB8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8
            B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8
            B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8
            B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8
            B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8
            B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8
            B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8
            B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8
            B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8
            B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8
            B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B9B9B9C4C4C4D8D8
            D8EEEEEEFBFBFBFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFEFEFEF3F3F3CFCFCF9090906E6E6E69696969696969696969696969696968
            6868686868686868686868696969696969696969696969696969696969696969
            6969696969696969696969696969696969696969696969696969696969696969
            6969696969696969696969696969696969696969696969696969696969696969
            6969696969696969696969696969696969696969696969696969696969696969
            6969696969696969696969696969696969696969696969696969696969696969
            6969696969696969696969696969696969696969696969696969696969696969
            6969696969696969696969696969696969696969696969696969696969696969
            6969696969696969696969696969696969696969696969696969696969696969
            6969696969696969696969696969696969696969696969696969696969696969
            6969696969696969696969696969696969696969696969696969696969696969
            6C6C6C7D7D7D9F9F9FCBCBCBEFEFEFFDFDFDFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFDFDFDB2E2E163C2C047A6A43998963796943695933593
            91338C8A3082802E7A792D76742C75742E7A78308180338A8835929036959336
            9694369694369694369694369694369694369694369694369694369694369694
            3696943696943696943696943696943696943696943696943696943696943696
            9436969436969436969436969436969436969436969436969436969436969436
            9694369694369694369694369694369694369694369694369694369694369694
            3696943696943696943696943696943696943696943696943696943696943696
            9436969436969436969436969436969436969436969436969436969436969436
            9694369694369694369694369694369694369694369694369694369694369694
            3696943696943696943696943696943696943696943696943696943696943696
            9436969436969436969436969436969436969436969436969436969436969436
            9694369694369694368B893C4444575757878787C7C7C7EFEFEFFBFBFBFEFEFE
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFEFE94DCDA34C3C034C3C034C3C0
            33C2BF31BDBA2EB1AE2795931F78761B6765185E5D185D5C1B66651F7775258E
            8C2DACA931BEBB33C2BF34C3C034C3C034C3C034C3C034C3C034C3C034C3C034
            C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C0
            34C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3
            C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034
            C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C0
            34C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3
            C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034
            C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C0
            34C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3
            C034C3C034C3C034C3C034C3C034C3C034C3BF31A9A5303D3C4A4A4A878787CA
            CACAEBEBEBFAFAFAFEFEFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFDFDFD94DBDA34
            C3C034C3C033C2BF32BEBB2EB0AD2693912A73715F8685708E8D6B88873B6261
            103F3E124746195E5D248A882EB1AE32BFBC33C2BF34C3C034C3C034C3C034C3
            C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034
            C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C0
            34C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3
            C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034
            C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C0
            34C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3
            C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034
            C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C0
            34C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3BF35C3BF31A9
            A5303D3C555555979797CACACAEBEBEBFBFBFBFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFDFDFD94DBDA34C3C034C3C032C0BD30B5B22997957EAFAEEFF3F3FFFFFFFF
            FFFFFFFFFFFEFEFEC1CCCC355A590F3D3C1A6462289B9930B7B433C1BE34C3C0
            34C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3
            C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034
            C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C0
            34C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3
            C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034
            C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C0
            34C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3
            C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034
            C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C0
            34C3BF35C3BF35C3BF31A7A4363D3C626262979797CACACAEFEFEFFDFDFDFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFDFDFD94DBD934C3C033C2BF31BBB84BB1B0D2E6E5FFFF
            FFFFFFFFF8FBFBE3F1F1EAF6F6FEFEFEFFFFFFF6F8F8778F8E134B4A2282802D
            ACA931BEBB34C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C0
            34C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3
            C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034
            C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C0
            34C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3
            C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034
            C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C0
            34C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3
            C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034
            C3C034C3C034C3C034C3BF34C3BF34C3BF34C3BF319794363D3C575757898989
            CACACAF1F1F1FBFBFBFEFEFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFDFDFD94DBDA34C3C033C1BE35B5B3
            E1F1F1FFFFFFFFFFFFB6CBCB2C8D8B2DABA931BAB77CD5D2FFFFFFFFFFFFFFFF
            FF417B7A2387852DACA932BEBB34C3C034C3C034C3C034C3C034C3C034C3C034
            C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C0
            34C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3
            C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034
            C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C0
            34C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3
            C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034
            C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C0
            34C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3
            C034C3C034C3C034C3C034C3C034C3C034C3BF35C3BF35C3BF35C3BF35C3BF31
            A4A0313B3A4D4D4D8B8B8BCDCDCDEDEDEDFBFBFBFEFEFEFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFDFDFD94DBDA34
            C3C033C0BD7CCECCFFFFFFFFFFFFFAFAFA2D6A68299A9830B9B633C1BE33C1BE
            C1EBEAFFFFFFFFFFFF8AC3C22BA3A130B7B432C0BD34C3C034C3C034C3C034C3
            C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034
            C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C0
            34C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3
            C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034
            C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C0
            34C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3
            C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034
            C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C0
            34C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3BF35C3BF35C3
            BF35C3BF35C3BF35C3BF32A4A03139385959599B9B9BCDCDCDEDEDEDFCFCFCFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFDFDFD94DBDA34C3C033C0BDBCE6E5FFFFFFFFFFFFB7C2C219605F2BA3A132
            BCB934C3C034C3C06ED3D1E6F7F6A4DFDE51C0BE31BAB732BFBC33C2BF34C3C0
            34C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3
            C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034
            C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C0
            34C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3
            C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034
            C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C0
            34C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3
            C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034
            C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C0
            34C3BF35C3BF35C3BF35C3BF35C3BF35C3BF35C3BF319E9B373C3C6464649B9B
            9BCECECEF1F1F1FDFDFDFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFDFDFD94DBD934C3C033C0BDE9F6F6FFFFFFFFFFFF7D91
            901A63622BA5A331BDBA34C3C034C3C034C3C033C1BE32C0BD32C0BD33C2BF34
            C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C0
            34C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3
            C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034
            C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C0
            34C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3
            C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034
            C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C0
            34C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3
            C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034
            C3C034C3C034C3C034C3BF34C3BF34C3BF34C3BF34C3BF34C3BF34C3BF34C3BF
            319390383D3C5A5A5A8F8F8FCDCDCDF2F2F2FCFCFCFEFEFEFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFDFDFD94DBDA34C3C033C0BDF4FBFA
            FFFFFFFFFFFF6C8383185F5D2AA29F32BCB933C2BF34C3C033C1BE32BDBA31BA
            B731BAB732BEBB33C1BE34C3C034C3C034C3C034C3C034C3C034C3C034C3C034
            C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C0
            34C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3
            C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034
            C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C0
            34C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3
            C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034
            C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C0
            34C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3
            C034C3C034C3C034C3C034C3C034C3C034C3BF35C3BF35C3BF35C3BF35C3BF35
            C3BF35C3BF35C3BF35C3BF319C9A3136365050508F8F8FCFCFCFEEEEEEFBFBFB
            FEFEFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFDFDFD94DBDA34
            C3C033C1BEF0F9F9FFFFFFFFFFFF70868616565428979530B7B432C1BE33C1BE
            31BBB82DADAA299F9C299E9C2DAEAB31BBB833C1BE34C3C034C3C034C3C034C3
            C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034
            C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C0
            34C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3
            C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034
            C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C0
            34C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3
            C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034
            C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C0
            34C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3BF35C3BF35C3
            BF35C3BF35C3BF35C3BF35C3BF35C3BF35C3BF35C3BF3199963136365C5C5C9E
            9E9ED0D0D0EFEFEFFBFBFBFEFEFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFDFDFD94DBDA34C3C033C2BFD6F1F1FFFFFFFFFFFF8C9D9D12474622807E2B
            A6A330B6B330B7B42CA8A5258B891D6F6D1D6F6D2792902EB1AE32BFBC34C3C0
            34C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3
            C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034
            C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C0
            34C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3
            C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034
            C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C0
            34C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3
            C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034
            C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C0
            34C3BF35C3BF35C3BF35C3BF35C3BF35C3BF35C3BF35C3BF35C3BF35C3BF35C3
            BF319996383C3C6767679F9F9FD1D1D1EFEFEFFCFCFCFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFDFDFD94DBD934C3C033C2BF98DEDDFFFFFFFFFFFFD8DF
            DF143E3D1554521E7372248886248B8878B2B1A8C5C4809B9B3D6F6E2385832D
            ADAA31BFBC34C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C0
            34C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3
            C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034
            C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C0
            34C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3
            C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034
            C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C0
            34C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3
            C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034
            C3C034C3C034C3C034C3BF34C3BF34C3BF34C3BF34C3BF34C3BF34C3BF34C3BF
            34C3BF34C3BF34C3BF34C3BF318F8D393B3B5D5D5D929292C6C6C6EEEEEEFDFD
            FDFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFDFDFD94DBDA34C3C034C3C03FC5C2
            EFFAF9FFFFFFFFFFFF869E9E0F3B3A104140134A493A6969F8F9F9FFFFFFFFFF
            FF70A4A3289A9830B6B433C1BE34C3C034C3C034C3C034C3C034C3C034C3C034
            C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C0
            34C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3
            C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034
            C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C0
            34C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3
            C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034
            C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C0
            34C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3
            C034C3C034C3C034C3C034C3C034C3C034C3BF35C3BF35C3BF35C3BF35C3BF35
            C3BF35C3BF35C3BF35C3BF35C3BF35C3BF35C3BF35C3BF309391333636535353
            878787CDCDCDF6F6F6FEFEFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFDFDFD94DBDA34
            C3C034C3C034C3C079D6D4FEFEFEFFFFFFFEFEFEC3D1D096AAAA9CAEAEEAEEEE
            FFFFFFFFFFFFEFF5F53395942EB1AE32BFBC33C2BF34C3C034C3C034C3C034C3
            C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034
            C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C0
            34C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3
            C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034
            C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C0
            34C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3
            C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034
            C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C0
            34C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3BF35C3BF35C3
            BF35C3BF35C3BF35C3BF35C3BF35C3BF35C3BF35C3BF35C3BF35C3BF35C3BF35
            C3BF3094913639395F5F5FB1B1B1EEEEEEFDFDFDFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFDFDFD94DBDA34C3C034C3C034C3C033C2BF84D9D7F9FDFDFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFEDF5F558B0AE2DAEAC31BEBB33C2BF34C3C034C3C0
            34C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3
            C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034
            C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C0
            34C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3
            C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034
            C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C0
            34C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3
            C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034
            C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C0
            34C3BF35C3BF35C3BF35C3BF35C3BF35C3BF35C3BF35C3BF35C3BF35C3BF35C3
            BF35C3BF35C3BF35C3BF35C3BF349793545757A9A9A9ECECECFDFDFDFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFDFDFD94DBDA34C3C034C3C034C3C034C3C034C3C052CA
            C8C2EBEAFDFEFEFFFFFFFFFFFFF3FAFAA8DCDB42B5B330B5B232BEBB33C2BF34
            C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C0
            34C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3
            C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034
            C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C0
            34C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3
            C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034
            C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C0
            34C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3
            C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034
            C3C034C3C034C3C034C3BF35C3BF35C3BF35C3BF35C3BF35C3BF35C3BF35C3BF
            35C3BF35C3BF35C3BF35C3BF35C3BF35C3BF35C3BF35C3BF658180BCBCBCF2F2
            F2FEFEFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFDFDFD94DBD934C3C034C3C034C3C0
            34C3C034C3C034C3C033C2BF39C2BF46C6C346C4C136BEBC32BEBB32C0BD33C1
            BE33C2BF34C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034
            C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C0
            34C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3
            C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034
            C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C0
            34C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3
            C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034
            C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C0
            34C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3
            C034C3C034C3C034C3C034C3C034C3C034C3BF34C3BF34C3BF34C3BF34C3BF34
            C3BF34C3BF34C3BF34C3BF34C3BF34C3BF34C3BF34C3BF34C3BF34C3BF45BAB7
            A2AFAEE1E1E1FAFAFAFEFEFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFDFDFD94DBDA34
            C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C0
            34C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3
            C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034
            C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C0
            34C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3
            C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034
            C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C0
            34C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3
            C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034
            C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C0
            34C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3BF35C3BF35C3
            BF35C3BF35C3BF35C3BF35C3BF35C3BF35C3BF35C3BF35C3BF35C3BF35C3BF35
            C3BF4AB7B4AFB5B5DFDFDFF8F8F8FEFEFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFDFDFD94DBDA34C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034
            C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C0
            34C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3
            C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034
            C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C0
            34C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3
            C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034
            C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C0
            34C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3
            C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034
            C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C0
            34C3BF35C3BF35C3BF35C3BF35C3BF35C3BF35C3BF35C3BF35C3BF35C3BF35C3
            BF35C3BF35C3BF47B8B5ACB3B3DEDEDEF5F5F5FDFDFDFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFDFDFD94DBDA34C3C034C3C034C3C034C3C034C3C034C3
            C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034
            C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C0
            34C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3
            C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034
            C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C0
            34C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3
            C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034
            C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C0
            34C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3
            C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034
            C3C034C3C034C3C034C3BF35C3BF35C3BF35C3BF35C3BF35C3BF35C3BF35C3BF
            35C3BF35C3BF35C3BF35C3BF3FBCB9A9B2B2DDDDDDF4F4F4FDFDFDFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFDFDFD94DBD934C3C034C3C034C3C0
            34C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3
            C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034
            C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C0
            34C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3
            C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034
            C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C0
            34C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3
            C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034
            C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C0
            34C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3
            C034C3C034C3C034C3C034C3C034C3C034C3BF34C3BF34C3BF34C3BF34C3BF34
            C3BF34C3BF34C3BF34C3BF34C3BF34C3BF3DBEBA9CB8B7E2E2E2F7F7F7FDFDFD
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFDFDFD94DBDA34
            C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C0
            34C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3
            C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034
            C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C0
            34C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3
            C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034
            C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C0
            34C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3
            C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034
            C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C0
            34C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3BF35C3BF35C3
            BF35C3BF35C3BF35C3BF35C3BF35C3BF35C3BF35C3BF3FBCB9A0AFAFE0E0E0FA
            FAFAFEFEFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFDFDFD94DBDA34C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034
            C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C0
            34C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3
            C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034
            C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C0
            34C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3
            C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034
            C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C0
            34C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3
            C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034
            C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C0
            34C3BF35C3BF35C3BF35C3BF35C3BF35C3BF35C3BF35C3BF35C3BF3DBDB99BAF
            AED7D7D7F5F5F5FEFEFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFDFDFD94DBDA34C3C034C3C034C3C034C3C034C3C034C3
            C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034
            C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C0
            34C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3
            C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034
            C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C0
            34C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3
            C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034
            C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C0
            34C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3
            C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034
            C3C034C3C034C3C034C3BF35C3BF35C3BF35C3BF35C3BF35C3BF35C3BF35C3BF
            39BFBB97AEADD5D5D5F1F1F1FDFDFDFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFDFDFD94DBD934C3C034C3C034C3C0
            34C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3
            C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034
            C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C0
            34C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3
            C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034
            C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C0
            34C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3
            C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034
            C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C0
            34C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3
            C034C3C034C3C034C3C034C3C034C3C034C3BF34C3BF34C3BF34C3BF34C3BF34
            C3BF34C3BF37C0BC8DB5B3DCDCDCF4F4F4FDFDFDFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFDFDFD94DBDA34
            C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C0
            34C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3
            C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034
            C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C0
            34C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3
            C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034
            C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C0
            34C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3
            C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034
            C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C0
            34C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3BF35C3BF35C3
            BF35C3BF35C3BF35C3BF38C0BC8BACABDADADAF8F8F8FEFEFEFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFDFDFD94DBDA34C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034
            C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C0
            34C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3
            C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034
            C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C0
            34C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3
            C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034
            C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C0
            34C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3
            C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034
            C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C0
            34C3BF35C3BF35C3BF35C3BF35C3BF37C0BC87ACACD0D0D0F2F2F2FEFEFEFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFDFDFD94DBDA34C3C034C3C034C3C034C3C034C3C034C3
            C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034
            C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C0
            34C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3
            C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034
            C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C0
            34C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3
            C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034
            C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C0
            34C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3
            C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034
            C3C034C3C034C3C034C3BF35C3BF35C3BF35C3BF36C1BD82ACABCECECEEEEEEE
            FCFCFCFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFDFDFD94DCD934C3C034C3C034C3C0
            34C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3
            C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034
            C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C0
            34C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3
            C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034
            C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C0
            34C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3
            C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034
            C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C0
            34C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3
            C034C3C034C3C034C3C034C3C034C3C034C3BF34C3BF34C3BF35C2BE7CB3B1D5
            D5D5F1F1F1FCFCFCFEFEFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFEFE95DCDB34
            C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C0
            34C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3
            C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034
            C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C0
            34C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3
            C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034
            C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C0
            34C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3
            C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034
            C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C0
            34C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3BF35C3BF35C2
            BE77ADABD3D3D3F4F4F4FDFDFDFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFEFEFE96DDDC34C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034
            C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C0
            34C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3
            C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034
            C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C0
            34C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3
            C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034
            C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C0
            34C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3
            C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034
            C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C0
            34C3BF34C2BE77B4B2CACACAEFEFEFFDFDFDFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFEFEFE97DFDD34C3C034C3C034C3C034C3C034C3C034C3
            C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034
            C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C0
            34C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3
            C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034
            C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C0
            34C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3
            C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034
            C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C0
            34C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3
            C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034C3C034
            C3C034C3C034C3C034C3BF87C8C6D7D7D7EDEDEDFBFBFBFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFDCF4F4B7E6E5AFDFDEABDBDA
            ABDBDAABDBDAABDAD9ABDAD9ABDAD9ABDAD9ABDAD9ABDAD9ABDAD9ABDAD9ABDA
            D9ABDAD9ABDAD9ABDAD9ABDAD9ABDAD9ABDAD9ABDAD9ABDAD9ABDAD9ABDAD9AB
            DAD9ABDAD9ABDAD9ABDAD9ABDAD9ABDAD9ABDAD9ABDAD9ABDAD9ABDAD9ABDAD9
            ABDAD9ABDAD9ABDAD9ABDAD9ABDAD9ABDAD9ABDAD9ABDAD9ABDAD9ABDAD9ABDA
            D9ABDAD9ABDAD9ABDAD9ABDAD9ABDAD9ABDAD9ABDAD9ABDAD9ABDAD9ABDAD9AB
            DAD9ABDAD9ABDAD9ABDAD9ABDAD9ABDAD9ABDAD9ABDAD9ABDAD9ABDAD9ABDAD9
            ABDAD9ABDAD9ABDAD9ABDAD9ABDAD9ABDAD9ABDAD9ABDAD9ABDAD9ABDAD9ABDA
            D9ABDBDAABDBDAACDCDBB0E0DFB5E4E3B6E6E5B6E6E5B6E6E5B6E6E5B6E6E5B6
            E6E5B6E6E5B6E6E5B6E6E5B6E6E5B6E6E5B6E6E5B6E6E5B6E6E5B6E6E5B6E6E5
            B6E6E5B6E6E5B6E6E5B6E6E5B6E6E5B6E6E5B6E6E5B6E6E5B6E6E5B6E6E5B6E6
            E5B6E6E5B6E6E5B6E6E5B6E6E5B7E6E5C2E8E8F4F4F4F8F8F8FCFCFCFEFEFEFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFEFEF9F9F9E8
            E8E8CACACABABABAB8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8
            B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8
            B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8
            B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8
            B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8
            B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8
            B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8
            B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8BEBEBED2D2D2EEEEEEFAFAFAFEFEFEFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFEFEFEF3F3F3CFCFCF9090906E6E6E69696969696969696969696969696969
            6969696969696969696969696969696969696969696969696969696969696969
            6969696969696969696969696969696969696969696969696969696969696969
            6969696969696969696969696969696969696969696969696969696969696969
            6969696969696969696969696969696969696969696969696969696969696969
            6969696969696969696969696969696969696969696969696969696969696969
            6969696969696969696969696969696969696969696969696969696969696969
            69696969696969696969696969696969696969696A6A6A737373969696CBCBCB
            EBEBEBFAFAFAFEFEFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFEFEFEC1DBCF78AE954F846C396E5534685132634D3060
            4A305F49305F49305F49305F49305F49305F4A31614B33654E356851356A5236
            6B53366B53366B53366B53366B53366B53366B53366B53366B53366B53366B53
            366B53366B53366B53366B53366B53366B53366B53366B53366B53366B53366B
            53366B53366B53366B53366B53366B53366B53366B53366B53366B53366B5336
            6B53366B53366B53366B53366B53366B53366B53366B53366B53366B53366B53
            366B53366B53366B53366B53366B53366B53366B53366B53366B53366B53366B
            53366B53366B53366B53366B53366B53366B53366B53366B53366B53366C533B
            4440595959959595C9C9C9EBEBEBFBFBFBFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFDFDFD92C7AF309B692F9A692E9666
            2A885D23724E1E62431C5D3F1C5D3F1C5D3F1C5D3F1C5D3F1D5F401E6544226F
            4C2781582C92632E9868309B69309B69309B69309B69309B69309B69309B6930
            9B69309B69309B69309B69309B69309B69309B69309B69309B69309B69309B69
            309B69309B69309B69309B69309B69309B69309B69309B69309B69309B69309B
            69309B69309B69309B69309B69309B69309B69309B69309B69309B69309B6930
            9B69309B69309B69309B69309B69309B69309B69309B69309B69309B69309B69
            309B69309B69309B69309B69309B69309B69309B69309B69309B69309B69309B
            69309B69309B692E8E6232473D555555878787BDBDBDE9E9E9FBFBFBFEFEFEFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFDFDFD92C7AF30
            9B6A2F9A6939996D458D6C3B6C56345445314D40324F423351433352442A4A3B
            1134240F3424123D291B5A3D267E562C92632F9968309B6A309B6A309B6A309B
            6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A30
            9B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A
            309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B
            6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A30
            9B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A
            309B6A309B6A309B6A309B6A309B6A309B6A2E8D613039354A4A4A7B7B7BBEBE
            BEEBEBEBFAFAFAFEFEFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFDFDFD92C7AF309B6A2F9A6981BFA2FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFF1F3F29EAAA51E382D123B281F674629885D2E9767309B6A
            309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B
            6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A30
            9B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A
            309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B
            6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A30
            9B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A2E865E
            3037344C4C4C898989CACACAEBEBEBFAFAFAFEFEFEFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFDFDFD92C7AF309B6A2F9A6981BEA2FFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFDBDFDD16342619543926
            7E552D94652F9A69309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A
            309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B
            6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A30
            9B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A
            309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B
            6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A30
            9B6A309B6A309B6A2D835D303734575757979797CBCBCBECECECFBFBFBFEFEFE
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFDFDFD92C7AF309B692F9A6981BEA2
            FFFFFFFFFFFFE6E9E7617D6F6B9E8771B09372B5978BC1A8F0F6F4FFFFFFFFFF
            FF6E8077174C332578512D92632F9A69309B69309B69309B69309B69309B6930
            9B69309B69309B69309B69309B69309B69309B69309B69309B69309B69309B69
            309B69309B69309B69309B69309B69309B69309B69309B69309B69309B69309B
            69309B69309B69309B69309B69309B69309B69309B69309B69309B69309B6930
            9B69309B69309B69309B69309B69309B69309B69309B69309B69309B69309B69
            309B69309B69309B69309B69309B69309B69309B69309B69309B69309B69309B
            69309B69309B69309B69309B69309B69309B692E8B6133453D5858588B8B8BC1
            C1C1E6E6E6FAFAFAFEFEFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFDFDFD92C7AF30
            9B6A2F9A6981BEA2FFFFFFFFFFFFDADDDC1037251E6444267B54278158267E55
            90B8A6FFFFFFFFFFFF9DADA51A563A267E562D94652F9A69309B6A309B6A309B
            6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A30
            9B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A
            309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B
            6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A30
            9B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A
            309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A2E8B
            613137344D4D4D7E7E7EB6B6B6E6E6E6FBFBFBFEFEFEFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFDFDFD92C7AF309B6A2F9A6981BEA2FFFFFFFFFFFFDADDDB0D2A1C15463019
            553A1B583C19543990AA9EFFFFFFFFFFFF99AFA520694829895D2E9767309B6A
            309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B
            6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A30
            9B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A
            309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B
            6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A30
            9B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A
            309B6A309B6A309B6A2D805A3137344E4E4E7F7F7FC1C1C1EDEDEDFBFBFBFEFE
            FEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFDFDFD92C7AF309B6A2F9A6981BEA2FFFFFFFFFFFFD9DD
            DB091F150D2D1E0F3423183C2B4D695CEFF2F1FFFFFFFFFFFF69927F267E562D
            92632F9968309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A
            309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B
            6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A30
            9B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A
            309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B
            6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A30
            9B6A309B6A309B6A309B6A309B6A309B6A309B6A2D805A3137344F4F4F8E8E8E
            CFCFCFEEEEEEFBFBFBFEFEFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFDFDFD92C7AF309B692F9A6981BEA2
            FFFFFFFFFFFFFDFDFDF6F7F6F7F8F7FFFFFFFFFFFFFFFFFFFFFFFFE1E5E38395
            8D1D5B3E28855A2E95662F9A69309B69309B69309B69309B69309B69309B6930
            9B69309B69309B69309B69309B69309B69309B69309B69309B69309B69309B69
            309B69309B69309B69309B69309B69309B69309B69309B69309B69309B69309B
            69309B69309B69309B69309B69309B69309B69309B69309B69309B69309B6930
            9B69309B69309B69309B69309B69309B69309B69309B69309B69309B69309B69
            309B69309B69309B69309B69309B69309B69309B69309B69309B69309B69309B
            69309B69309B69309B69309B69309B69309B69309B69309B69309B69309B692E
            895F2F453B5151518F8F8FC3C3C3E7E7E7FAFAFAFEFEFEFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFDFDFD92C7AF30
            9B6A2F9A6981BEA2FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FCFCFCA0AFA8133224154831257A532D93642F9A69309B6A309B6A309B6A309B
            6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A30
            9B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A
            309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B
            6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A30
            9B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A
            309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B
            6A309B6A309B6A309B6A2F97682F443B505050828282B8B8B8E8E8E8FBFBFBFE
            FEFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFDFDFD92C7AF309B6A2F9A6981BEA2FFFFFFFFFFFFE1E4E34061524C876C53
            9C7A56A280A7CEBCFFFFFFFFFFFF8F9D96123D2A22724D2C8F622F9A69309B6A
            309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B
            6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A30
            9B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A
            309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B
            6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A30
            9B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A
            309B6A309B6A309B6A309B6A309B6A309B6A309B6A2E865D3135345151518282
            82C5C5C5EFEFEFFBFBFBFEFEFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFDFDFD92C7AF309B6A2F9A6981BEA2FFFFFFFFFFFFDADD
            DC0F34231C5D3F23724E257852327C5AFFFFFFFFFFFFF5F6F617412D23724E2C
            90622F9A69309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A
            309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B
            6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A30
            9B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A
            309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B
            6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A30
            9B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A
            2D7C58323634515151929292D1D1D1F0F0F0FCFCFCFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFDFDFD92C7AF309B692F9A6981BFA2
            FFFFFFFFFFFFD9DDDC0B281A11392714442E1546303B6351FFFFFFFFFFFFFFFF
            FF255B42277F572D94642F9A69309B69309B69309B69309B69309B69309B6930
            9B69309B69309B69309B69309B69309B69309B69309B69309B69309B69309B69
            309B69309B69309B69309B69309B69309B69309B69309B69309B69309B69309B
            69309B69309B69309B69309B69309B69309B69309B69309B69309B69309B6930
            9B69309B69309B69309B69309B69309B69309B69309B69309B69309B69309B69
            309B69309B69309B69309B69309B69309B69309B69309B69309B69309B69309B
            69309B69309B69309B69309B69309B69309B69309B69309B69309B69309B6930
            9B69309B69309B69309B692E845C30423A545454959595CBCBCBEFEFEFFDFDFD
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFDFDFD92C7AF30
            9B6A2F9A6981BFA3FFFFFFFFFFFFF4F5F4B6BFBBB7C0BCC0C9C5C3CCC8F3F5F4
            FFFFFFFFFFFFC3D4CC23744F2C90622E9968309B6A309B6A309B6A309B6A309B
            6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A30
            9B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A
            309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B
            6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A30
            9B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A
            309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B
            6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A2F966732443C5F5F5FA1
            A1A1DCDCDCFAFAFAFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFDFDFD92C7AF309B6A2F9A6982C0A4FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFE9F1ED468F6E2A8C5F2E97672F9A69309B6A309B6A
            309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B
            6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A30
            9B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A
            309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B
            6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A30
            9B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A
            309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B
            6A30855E545755989898D8D8D8FAFAFAFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFDFDFD92C7AF309B6A309B6A79BE9EEAF4EFE9F4EFE9F3
            EFE9F3EFE9F3EFE3F0EADEEDE6CFE5DB95C6AF3793692C92632E97672F9A6930
            9B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A
            309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B
            6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A30
            9B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A
            309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B
            6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A30
            9B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A
            309B6A309B6A309B6A309B6A647970AEAEAEE2E2E2FBFBFBFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFDFDFD92C7AF309B69309B69309B69
            2F9A692F99682F98682F98682F98682F98682F98682F98682F98682F99682F9A
            692F9A69309B69309B69309B69309B69309B69309B69309B69309B69309B6930
            9B69309B69309B69309B69309B69309B69309B69309B69309B69309B69309B69
            309B69309B69309B69309B69309B69309B69309B69309B69309B69309B69309B
            69309B69309B69309B69309B69309B69309B69309B69309B69309B69309B6930
            9B69309B69309B69309B69309B69309B69309B69309B69309B69309B69309B69
            309B69309B69309B69309B69309B69309B69309B69309B69309B69309B69309B
            69309B69309B69309B69309B69309B69309B69309B69309B69309B69309B6930
            9B69309B69309B69309B69309B69309B693B996EA2ABA7DADADAF4F4F4FEFEFE
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFDFDFD92C7AF30
            9B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A
            309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B
            6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A30
            9B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A
            309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B
            6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A30
            9B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A
            309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B
            6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309A6A92AA9FDFDFDFF6
            F6F6FDFDFDFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFDFDFD92C7AF309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A30
            9B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A
            309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B
            6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A30
            9B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A
            309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B
            6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A30
            9B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A
            309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309A6A789E
            8DD3D3D3F5F5F5FDFDFDFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFDFDFD92C7AF309B6A309B6A309B6A309B6A309B6A309B
            6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A30
            9B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A
            309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B
            6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A30
            9B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A
            309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B
            6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A30
            9B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A
            309A69729C89C9C9C9EFEFEFFDFDFDFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFDFDFD92C7AF309B6A309B6A309B6A
            309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B
            6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A30
            9B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A
            309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B
            6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A30
            9B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A
            309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B
            6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A30
            9B6A309B6A309B6A6E9C87C7C7C7EAEAEAFBFBFBFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFDFDFD92C7AF30
            9B69309B69309B69309B69309B69309B69309B69309B69309B69309B69309B69
            309B69309B69309B69309B69309B69309B69309B69309B69309B69309B69309B
            69309B69309B69309B69309B69309B69309B69309B69309B69309B69309B6930
            9B69309B69309B69309B69309B69309B69309B69309B69309B69309B69309B69
            309B69309B69309B69309B69309B69309B69309B69309B69309B69309B69309B
            69309B69309B69309B69309B69309B69309B69309B69309B69309B69309B6930
            9B69309B69309B69309B69309B69309B69309B69309B69309B69309B69309B69
            309B69309B69309B69309B69309B69309B69309B69309B69309B69309B69309B
            69309B69309B69309B69309B696BA088CECECEEEEEEEFBFBFBFEFEFEFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFDFDFD92C7AF309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A30
            9B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A
            309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B
            6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A30
            9B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A
            309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B
            6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A30
            9B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A
            309B6A309B6A309B6A309B6A309B6A309B6A619A80CBCBCBF2F2F2FDFDFDFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFDFDFD92C7AF309B6A309B6A309B6A309B6A309B6A309B
            6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A30
            9B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A
            309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B
            6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A30
            9B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A
            309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B
            6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A30
            9B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A5C9A7DBFBFBFEBEBEB
            FCFCFCFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFDFDFD92C7AF309B6A309B6A309B6A
            309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B
            6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A30
            9B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A
            309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B
            6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A30
            9B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A
            309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B
            6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A58997BBC
            BDBCE5E5E5FAFAFAFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFDFDFD92C7AF30
            9B69309B69309B69309B69309B69309B69309B69309B69309B69309B69309B69
            309B69309B69309B69309B69309B69309B69309B69309B69309B69309B69309B
            69309B69309B69309B69309B69309B69309B69309B69309B69309B69309B6930
            9B69309B69309B69309B69309B69309B69309B69309B69309B69309B69309B69
            309B69309B69309B69309B69309B69309B69309B69309B69309B69309B69309B
            69309B69309B69309B69309B69309B69309B69309B69309B69309B69309B6930
            9B69309B69309B69309B69309B69309B69309B69309B69309B69309B69309B69
            309B69309B69309B69309B69309B69309B69309B69309B69309B69309B69319A
            6A6F9F89C5C6C5E9E9E9F9F9F9FEFEFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFDFDFD92C7AF309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A30
            9B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A
            309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B
            6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A30
            9B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A
            309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B
            6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A30
            9B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A
            309B6A309B6A6B9E87D0D0D0EFEFEFFBFBFBFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFDFDFD92C7AF309B6A309B6A309B6A309B6A309B6A309B
            6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A30
            9B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A
            309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B
            6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A30
            9B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A
            309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B
            6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A30
            9B6A309B6A309B6A309B6A499874BFC1C0EEEEEEFBFBFBFEFEFEFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFEFE92C8AF309B6A309B6A309B6A
            309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B
            6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A30
            9B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A
            309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B
            6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A30
            9B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A
            309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B
            6A309B6A309B6A309B6A309B6A309B6A469873AFB3B1E5E5E5FBFBFBFEFEFEFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFDFDFD92C7AF30
            9B69309B69309B69309B69309B69309B69309B69309B69309B69309B69309B69
            309B69309B69309B69309B69309B69309B69309B69309B69309B69309B69309B
            69309B69309B69309B69309B69309B69309B69309B69309B69309B69309B6930
            9B69309B69309B69309B69309B69309B69309B69309B69309B69309B69309B69
            309B69309B69309B69309B69309B69309B69309B69309B69309B69309B69309B
            69309B69309B69309B69309B69309B69309B69309B69309B69309B69309B6930
            9B69309B69309B69309B69309B69309B69309B69309B69309B69309B69309B69
            309B69309B69309B69309B69309B69309B69309A695E9C80B9BDBBE4E4E4F9F9
            F9FEFEFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFEFEFE94C9B1309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A30
            9B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A
            309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B
            6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A30
            9B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A
            309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B
            6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A30
            9B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A5EA082CACACA
            EBEBEBFAFAFAFEFEFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFEFEFE95CBB2309B6A309B6A309B6A309B6A309B6A309B
            6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A30
            9B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A
            309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B
            6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A30
            9B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A
            309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B
            6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A309B6A46
            A278C9D0CDEDEDEDFAFAFAFEFEFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFCBE6D994CAB18FC4AC8DC2AA
            8DC2AA8DC2A98CC1A98CC1A98CC1A98CC1A98CC1A98CC1A98CC1A98CC1A98CC1
            A98CC1A98CC1A98CC1A98CC1A98CC1A98CC1A98CC1A98CC1A98CC1A98CC1A98C
            C1A98CC1A98CC1A98CC1A98CC1A98CC1A98CC1A98CC1A98CC1A98CC1A98CC1A9
            8CC1A98CC1A98CC1A98CC1A98CC1A98CC1A98CC1A98DC2A98DC2A98DC2A98FC4
            AC90C6AD92C7AF92C7AF92C7AF92C7AF92C7AF92C7AF92C7AF92C7AF92C7AF92
            C7AF92C7AF92C7AF92C7AF92C7AF92C7AF92C7AF92C7AF92C7AF92C7AF92C7AF
            92C7AF92C7AF92C7AF92C7AF92C7AF92C7AF92C7AF92C7AF92C7AF92C7AF92C7
            AF92C8AF92C8AFDAE5E0F4F4F4FBFBFBFEFEFEFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFEFEFAFAFAED
            EDEDD5D5D5C7C7C7C6C6C6C6C6C6C6C6C6C6C6C6C6C6C6C6C6C6C6C6C6C6C6C6
            C6C6C6C6C6C6C6C6C6C6C6C6C6C6C6C6C6C6C6C6C6C6C6C6C6C6C6C6C6C6C6C6
            C6C6C6C6C6C6C6C6C6C6C6C6C6C6C6C6C6C6C6C6C6C6C6C6C6C6C6C6C6C6C6C6
            C6C6C6C6C6C6C6C6C6C6C6C6C6C6C6C6C6C6C6C6C6C6C6C6C6C6C6C6C6C6C6C6
            C6C6C6CBCBCBD7D7D7E9E9E9F7F7F7FDFDFDFEFEFEFEFEFEFEFEFEFEFEFEFEFE
            FEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFE
            FEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFE
            FEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFEFEFEF3F3F3CFCFCF9090906E6E6E69696969696969696969696969696969
            6969696969696969696969696969696969696969696969696969696969696969
            6969696969696969696969696969696969696969696969696969696969696969
            6969696969696969696969696969696969696969696969696969696969696969
            69696969696969696A6A6A7373738C8C8CB5B5B5DDDDDDF7F7F7FEFEFEFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFEFEFEC3D5B57CA1625276383B5D2236571E34551D3657
            1E385B1E395E1F3A5E1F3A5E1F3A5E1F395D1F385A1E36571E34551D36581E38
            5C1F395E1F3A5E1F3A5E1F3A5E1F3A5E1F3A5E1F3A5E1F3A5E1F3A5E1F3A5E1F
            3A5E1F3A5E1F3A5E1F3A5E1F3A5E1F3A5E1F3A5E1F3A5E1F3A5E1F3A5E1F3A5E
            1F3A5E1F3A5E1F3A5E1F3A5E1F3A5E1F3A5F203B42374F4F4F7A7A7AB1B1B1E4
            E4E4FAFAFAFEFEFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFEFE96BB7C388103357C02307002
            2A6202285D012B6402327502367F02388103388103378002357C023171022A63
            02285E012E6A02347702367E0238810338810338810338810338810338810338
            8103388103388103388103388103388103388103388103388103388103388103
            3881033881033881033881033881033881033881033881033881033572073137
            2C4A4A4A797979BDBDBDEBEBEBFAFAFAFEFEFEFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFDFDFD96BA7B37
            81034182113F731B355A191F3E081B42012A6301347A02367E02377F02367D02
            39780A3C6B1A32541927480F265801317102367D023781033781033781033781
            0337810337810337810337810337810337810337810337810337810337810337
            8103378103378103378103378103378103378103378103378103378103378103
            3781033781023576053145214242427B7B7BBDBDBDE4E4E4F7F7F7FEFEFEFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFDFDFD96BA7B38810397BC7CFFFFFFFFFFFF889380122B00214D012E6C0232
            7302327402317102A4BD92FFFFFFFFFFFF7E9172265A01327402367E02388103
            3881033881033881033881033881033881033881033881033881033881033881
            0338810338810338810338810338810338810338810338810338810338810338
            81033881033881033881033881023881023780012F4D1A4444447C7C7CB2B2B2
            DEDEDEF7F7F7FEFEFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFDFDFD96BA7B388103669E3EFFFFFFFFFFFFD8DCD50F23
            00173800225001255701265801275704ECF0E9FFFFFFFFFFFF4562312B640234
            7902378002388103388103388103388103388103388103388103388103388103
            3881033881033881033881033881033881033881033881033881033881033881
            0338810338810338810338810338810338810338810238810238810237800230
            43234C4C4C7C7C7CB3B3B3E5E5E5FBFBFBFEFEFEFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFDFDFD96BA7B3881033C8309F5F8F2
            FFFFFFFFFFFF36462B0F2200142F00163301163501445C34FFFFFFFFFFFFE5E7
            E41F47022F6E02367C0237800238810338810338810338810338810338810338
            8103388103388103388103388103388103388103388103388103388103388103
            3881033881033881033881033881033881033881033881033881033881023881
            0238810238810235750630352D4D4D4D7C7C7CC0C0C0EDEDEDFBFBFBFEFEFEFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFDFDFD96BA7B37
            8103378002A1C289FFFFFFFFFFFFD8DBD6BDC1BBBEC3BBBFC5BBBFC5BBD7DAD4
            FFFFFFFFFFFF7A8A6E255601337702367F023781033781033781033781033781
            0337810337810337810337810337810337810337810337810337810337810337
            8103378103378103378103378103378103378103378103378103378103378103
            3781033781023781023781023781023781023575063143244545457E7E7EC1C1
            C1E6E6E6F8F8F8FEFEFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFDFDFD96BA7B388103388103498A18FBFCFBFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFEEEFED2040082B6501367C02378002388103388103
            3881033881033881033881033881033881033881033881033881033881033881
            0338810338810338810338810338810338810338810338810338810338810338
            8103388103388103388103388102388102388102388102388102388102377F02
            2F481C4646467F7F7FB6B6B6E0E0E0F8F8F8FEFEFEFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFDFDFD96BA7B388103388103378002C4D9B5FFFFFFFFFF
            FFB4BBAF96A38C9CB18CAEC39FFFFFFFFFFFFF9BA7931F4801306F02367F0238
            8103388103388103388103388103388103388103388103388103388103388103
            3881033881033881033881033881033881033881033881033881033881033881
            0338810338810338810338810338810338810338810238810238810238810238
            8102388102388102377F023141244F4F4F808080B7B7B7E7E7E7FBFBFBFEFEFE
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFDFDFD96BA7B388103388103388103
            7BAA58FFFFFFFFFFFF828D79143000204C0182A06CFFFFFFFFFFFF455E332556
            0132750237800238810338810338810338810338810338810338810338810338
            8103388103388103388103388103388103388103388103388103388103388103
            3881033881033881033881033881033881033881033881033881033881023881
            0238810238810238810238810238810238810235730731352F505050818181C3
            C3C3EEEEEEFBFBFBFEFEFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFDFDFD96BA7B37
            81033781033781033B8207E2ECDBFFFFFFC7CCC31127001C3C05DEE3D9FFFFFF
            BEC5B91D43012B6502357B023781033781033781033781033781033781033781
            0337810337810337810337810337810337810337810337810337810337810337
            8103378103378103378103378103378103378103378103378103378103378103
            3781033781023781023781023781023781023781023781023781023781023571
            08313F26474747828282C3C3C3E8E8E8F9F9F9FEFEFEFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFDFDFD96BA7B3881033881033881033780028BB46DFFFFFFFDFDFD273A195C
            6B52FFFFFFFFFFFF516841245401317102377E02388103388103388103388103
            3881033881033881033881033881033881033881033881033881033881033881
            0338810338810338810338810338810338810338810338810338810338810338
            8103388103388103388103388102388102388102388102388102388102388102
            388102388102388102377E022E441E484848828282BABABAE3E3E3F9F9F9FEFE
            FEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFDFDFD96BA7B388103388103388103388103478916FAFC
            F9FFFFFF798470B1B7AEFFFFFFE9ECE81B3F0229610233780237800238810338
            8103388103388103388103388103388103388103388103388103388103388103
            3881033881033881033881033881033881033881033881033881033881033881
            0338810338810338810338810338810338810338810238810238810238810238
            8102388102388102388102388102388102388102377E02314027515151838383
            BABABAE9E9E9FCFCFCFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFDFDFD96BA7B388103388103388103
            388103378002C0D6B1FFFFFFD7DBD5F8F9F8FFFFFFAFB9A8204B012E6C02357C
            0237800238810338810338810338810338810338810338810338810338810338
            8103388103388103388103388103388103388103388103388103388103388103
            3881033881033881033881033881033881033881033881033881033881023881
            0238810238810238810238810238810238810238810238810238810238810234
            6F09333431525252858585C8C8C8F3F3F3FDFDFDFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFDFDFD96BA7B37
            8103378103378103378103378103659C3DFEFEFEFFFFFFFFFFFFFFFFFF6A8258
            285F01327502367F023781033781033781033781033781033781033781033781
            0337810337810337810337810337810337810337810337810337810337810337
            8103378103378103378103378103378103378103378103378103378103378103
            3781033781023781023781023781023781023781023781023781023781023781
            02378102378102378102346E09323E294F4F4F989898E0E0E0F9F9F9FFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFDFDFD96BA7B388103388103388103388103388103378002E0EBD8FFFFFFFF
            FFFFF8FAF732650D317202367D02378002388103388103388103388103388103
            3881033881033881033881033881033881033881033881033881033881033881
            0338810338810338810338810338810338810338810338810338810338810338
            8103388103388103388103388102388102388102388102388102388102388102
            388102388102388102388102388102388102388102377D033E5130868686D8D8
            D8F8F8F8FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFDFDFD96BA7B3881033881033881033881033881033881
            03A6C68EEAF1E5EAF1E5AFC89D327402357C02377F0238810338810338810338
            8103388103388103388103388103388103388103388103388103388103388103
            3881033881033881033881033881033881033881033881033881033881033881
            0338810338810338810338810338810338810338810238810238810238810238
            8102388102388102388102388102388102388102388102388102388102388102
            43761D9E9E9EE2E2E2FAFAFAFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFDFDFD96BA7B388103388103388103
            388103388103388103378002367F02367E02367D02367E023780023881033881
            0338810338810338810338810338810338810338810338810338810338810338
            8103388103388103388103388103388103388103388103388103388103388103
            3881033881033881033881033881033881033881033881033881033881023881
            0238810238810238810238810238810238810238810238810238810238810238
            81023881023881025A8639C6C6C6F2F2F2FDFDFDFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFDFDFD96BA7B37
            8103378103378103378103378103378103378103378103378103378103378103
            3781033781033781033781033781033781033781033781033781033781033781
            0337810337810337810337810337810337810337810337810337810337810337
            8103378103378103378103378103378103378103378103378103378103378103
            3781033781023781023781023781023781023781023781023781023781023781
            02378102378102378102388002688F4ABDBFBCEBEBEBFCFCFCFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFDFDFD96BA7B38810338810338810338810338810338810338810338810338
            8103388103388103388103388103388103388103388103388103388103388103
            3881033881033881033881033881033881033881033881033881033881033881
            0338810338810338810338810338810338810338810338810338810338810338
            8103388103388103388103388102388102388102388102388102388102388102
            3881023881023881023881023881023880027B9567CACACAECECECFCFCFCFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFDFDFD96BA7B3881033881033881033881033881033881
            0338810338810338810338810338810338810338810338810338810338810338
            8103388103388103388103388103388103388103388103388103388103388103
            3881033881033881033881033881033881033881033881033881033881033881
            0338810338810338810338810338810338810338810238810238810238810238
            8102388102388102388102388102388102388102388102618C40C9C9C9EBEBEB
            FAFAFAFEFEFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFDFDFD96BA7B388103388103388103
            3881033881033881033881033881033881033881033881033881033881033881
            0338810338810338810338810338810338810338810338810338810338810338
            8103388103388103388103388103388103388103388103388103388103388103
            3881033881033881033881033881033881033881033881033881033881023881
            02388102388102388102388102388102388102388102388102388102458318B4
            B8B1EAEAEAFAFAFAFEFEFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFDFDFD96BA7B38
            8103388103388103388103388103388103388103388103388103388103388103
            3881033881033881033881033881033881033881033881033881033881033881
            0338810338810338810338810338810338810338810338810338810338810338
            8103388103388103388103388103388103388103388103388103388103388103
            3881033881023881023881023881023881023881023881023881023881023881
            02448215A1A99BE1E1E1FAFAFAFEFEFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFDFDFD96BA7B37810337810337810337810337810337810337810337810337
            8103378103378103378103378103378103378103378103378103378103378103
            3781033781033781033781033781033781033781033781033781033781033781
            0337810337810337810337810337810337810337810337810337810337810337
            8103378103378103378103378102378102378102378102378102378102378102
            378102378102558830ADB3A8DFDFDFF8F8F8FEFEFEFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFDFDFD96BA7B3881033881033881033881033881033881
            0338810338810338810338810338810338810338810338810338810338810338
            8103388103388103388103388103388103388103388103388103388103388103
            3881033881033881033881033881033881033881033881033881033881033881
            0338810338810338810338810338810338810338810238810238810238810238
            810238810238810238810253872CBFBFBFE6E6E6F8F8F8FEFEFEFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFDFDFD96BA7B388103388103388103
            3881033881033881033881033881033881033881033881033881033881033881
            0338810338810338810338810338810338810338810338810338810338810338
            8103388103388103388103388103388103388103388103388103388103388103
            3881033881033881033881033881033881033881033881033881033881023881
            023881023881023881023881023881023D810BA5AE9EE5E5E5F8F8F8FEFEFEFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFDFDFD96BA7B38
            8103388103388103388103388103388103388103388103388103388103388103
            3881033881033881033881033881033881033881033881033881033881033881
            0338810338810338810338810338810338810338810338810338810338810338
            8103388103388103388103388103388103388103388103388103388103388103
            3881033881023881023881023881023881023881023B81088E9E82DADADAF8F8
            F8FEFEFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFDFDFD96BA7B37810337810337810337810337810337810337810337810337
            8103378103378103378103378103378103378103378103378103378103378103
            3781033781033781033781033781033781033781033781033781033781033781
            0337810337810337810337810337810337810337810337810337810337810337
            81033781033781033781033781023781023781023781023781024A841F9DA994
            D9D9D9F5F5F5FEFEFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFDFDFD96BA7B3881033881033881033881033881033881
            0338810338810338810338810338810338810338810338810338810338810338
            8103388103388103388103388103388103388103388103388103388103388103
            3881033881033881033881033881033881033881033881033881033881033881
            0338810338810338810338810338810338810338810238810238810238810248
            831AB2B5B0E0E0E0F7F7F7FDFDFDFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFEFE96BB7C388103388103388103
            3881033881033881033881033881033881033881033881033881033881033881
            0338810338810338810338810338810338810338810338810338810338810338
            8103388103388103388103388103388103388103388103388103388103388103
            3881033881033881033881033881033881033881033881033881033881023881
            0238810239800395A588DFDFDFF6F6F6FDFDFDFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFEFE96BB7C38
            8103388103388103388103388103388103388103388103388103388103388103
            3881033881033881033881033881033881033881033881033881033881033881
            0338810338810338810338810338810338810338810338810338810338810338
            8103388103388103388103388103388103388103388103388103388103388103
            3881033881023881023880027B9467D3D3D3F5F5F5FDFDFDFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFDFDFD97BC7C37810337810337810337810337810337810337810337810337
            8103378103378103378103378103378103378103378103378103378103378103
            3781033781033781033781033781033781033781033781033781033781033781
            0337810337810337810337810337810337810337810337810337810337810337
            810337810337810337810337810243841390A481D2D2D2F3F3F3FDFDFDFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFEFEFE99BE7F3881033881033881033881033881033881
            0338810338810338810338810338810338810338810338810338810338810338
            8103388103388103388103388103388103388103388103388103388103388103
            3881033881033881033881033881033881033881033881033881033881033881
            033881033881033881033881033881033881034D8C1EC0C7BBE2E2E2F5F5F5FD
            FDFDFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFCDDFC09ABE7F97BC7D96BB7C
            96BB7C96BA7B96BA7B96BA7B96BA7B96BA7B96BA7B96BA7B96BA7B96BA7B96BA
            7B96BA7B96BA7B96BA7B96BA7B96BA7B96BA7B96BA7B96BA7B96BA7B96BA7B96
            BA7B96BA7B96BA7B96BA7B96BA7B96BA7B96BA7B96BA7B96BA7B96BA7B96BA7B
            96BA7B96BA7B96BA7B96BA7B96BA7B96BA7B96BA7B96BB7C96BB7CDBE3D5F3F3
            F3F9F9F9FDFDFDFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFE
            FEFEFEFEFEFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFD
            FDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFD
            FDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFD
            FDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFD
            FDFDFDFDFDFDFEFEFEFEFEFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000}
        end
        object Shape2: TShape
          Left = 375
          Top = 127
          Width = 98
          Height = 39
          Brush.Color = 3185514
        end
        object Shape3: TShape
          Left = 375
          Top = 199
          Width = 98
          Height = 38
          Brush.Color = 248059
        end
        object Shape4: TShape
          Left = 375
          Top = 236
          Width = 98
          Height = 40
          Brush.Color = 2073085
        end
        object Shape5: TShape
          Left = 375
          Top = 273
          Width = 98
          Height = 39
          Brush.Color = 2716141
        end
        object Shape6: TShape
          Left = 375
          Top = 311
          Width = 98
          Height = 42
          Brush.Color = 2572777
        end
        object Shape8: TShape
          Left = 375
          Top = 163
          Width = 98
          Height = 37
          Brush.Color = 3457984
        end
        object Shape7: TShape
          Left = 0
          Top = 86
          Width = 89
          Height = 42
          Pen.Color = clWhite
        end
        object Shape9: TShape
          Left = 0
          Top = 127
          Width = 89
          Height = 37
          Pen.Color = clWhite
        end
        object Shape10: TShape
          Left = 0
          Top = 163
          Width = 89
          Height = 35
          Pen.Color = clWhite
        end
        object Shape11: TShape
          Left = 0
          Top = 197
          Width = 89
          Height = 40
          Pen.Color = clWhite
        end
        object Shape12: TShape
          Left = 0
          Top = 236
          Width = 89
          Height = 38
          Pen.Color = clWhite
        end
        object Shape13: TShape
          Left = 0
          Top = 273
          Width = 89
          Height = 39
          Pen.Color = clWhite
        end
        object Shape14: TShape
          Left = 0
          Top = 311
          Width = 89
          Height = 42
          Pen.Color = clWhite
        end
        object Label11: TLabel
          Left = 16
          Top = 109
          Width = 75
          Height = 13
          Caption = '<= 30 kWh/m'#178'a'
          Color = clWhite
          ParentColor = False
        end
        object Label12: TLabel
          Left = 17
          Top = 145
          Width = 75
          Height = 13
          Caption = '<= 50 kWh/m'#178'a'
          Color = clWhite
          ParentColor = False
        end
        object Label13: TLabel
          Left = 16
          Top = 181
          Width = 75
          Height = 13
          Caption = '<= 70 kWh/m'#178'a'
          Color = clWhite
          ParentColor = False
        end
        object Label14: TLabel
          Left = 15
          Top = 217
          Width = 75
          Height = 13
          Caption = '<= 90 kWh/m'#178'a'
          Color = clWhite
          ParentColor = False
        end
        object Label15: TLabel
          Left = 9
          Top = 254
          Width = 81
          Height = 13
          Caption = '<= 120 kWh/m'#178'a'
          Color = clWhite
          ParentColor = False
        end
        object Label16: TLabel
          Left = 9
          Top = 291
          Width = 81
          Height = 13
          Caption = '<= 160 kWh/m'#178'a'
          Color = clWhite
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentColor = False
          ParentFont = False
        end
        object Label17: TLabel
          Left = 14
          Top = 327
          Width = 75
          Height = 13
          Caption = '> 160 kWh/m'#178'a'
          Color = clWhite
          ParentColor = False
        end
        object Shape15: TShape
          Left = 472
          Top = 86
          Width = 102
          Height = 42
        end
        object Shape16: TShape
          Left = 472
          Top = 127
          Width = 102
          Height = 37
        end
        object Shape17: TShape
          Left = 472
          Top = 163
          Width = 102
          Height = 37
        end
        object Shape18: TShape
          Left = 472
          Top = 199
          Width = 102
          Height = 38
        end
        object Shape19: TShape
          Left = 472
          Top = 236
          Width = 102
          Height = 38
        end
        object Shape20: TShape
          Left = 472
          Top = 273
          Width = 102
          Height = 39
        end
        object Shape21: TShape
          Left = 472
          Top = 311
          Width = 102
          Height = 42
        end
        object LBVal_A: TLabel
          Left = 403
          Top = 102
          Width = 42
          Height = 16
          Caption = 'Val_A'
          Color = 3703043
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWhite
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentColor = False
          ParentFont = False
        end
        object LBVal_B: TLabel
          Left = 403
          Top = 141
          Width = 42
          Height = 16
          Caption = 'Val_B'
          Color = 3185514
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWhite
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentColor = False
          ParentFont = False
        end
        object LBVal_C: TLabel
          Left = 403
          Top = 174
          Width = 42
          Height = 16
          Caption = 'Val_C'
          Color = 3457984
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWhite
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentColor = False
          ParentFont = False
        end
        object LBVal_D: TLabel
          Left = 402
          Top = 209
          Width = 43
          Height = 16
          Caption = 'Val_D'
          Color = 248059
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWhite
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentColor = False
          ParentFont = False
        end
        object LBVal_E: TLabel
          Left = 403
          Top = 248
          Width = 42
          Height = 16
          Caption = 'Val_E'
          Color = 2073085
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWhite
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentColor = False
          ParentFont = False
        end
        object LBVal_F: TLabel
          Left = 403
          Top = 287
          Width = 41
          Height = 16
          Caption = 'Val_F'
          Color = 2716141
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWhite
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentColor = False
          ParentFont = False
        end
        object LBVal_G: TLabel
          Left = 403
          Top = 326
          Width = 43
          Height = 16
          Caption = 'Val_G'
          Color = 2572777
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWhite
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentColor = False
          ParentFont = False
        end
        object LBVal_AJ: TLabel
          Left = 506
          Top = 102
          Width = 33
          Height = 13
          Caption = 'Val_AJ'
          Color = clWhite
          ParentColor = False
        end
        object LBVal_BJ: TLabel
          Left = 506
          Top = 141
          Width = 33
          Height = 13
          Caption = 'Val_BJ'
          Color = clWhite
          ParentColor = False
        end
        object LbVal_CJ: TLabel
          Left = 506
          Top = 174
          Width = 33
          Height = 13
          Caption = 'Val_CJ'
          Color = clWhite
          ParentColor = False
        end
        object LBVal_DJ: TLabel
          Left = 506
          Top = 211
          Width = 34
          Height = 13
          Caption = 'Val_DJ'
          Color = clWhite
          ParentColor = False
        end
        object LBVal_EJ: TLabel
          Left = 506
          Top = 249
          Width = 33
          Height = 13
          Caption = 'Val_EJ'
          Color = clWhite
          ParentColor = False
        end
        object LbVal_FJ: TLabel
          Left = 506
          Top = 286
          Width = 32
          Height = 13
          Caption = 'Val_FJ'
          Color = clWhite
          ParentColor = False
        end
        object LbVal_GJ: TLabel
          Left = 506
          Top = 326
          Width = 34
          Height = 13
          Caption = 'Val_GJ'
          Color = clWhite
          ParentColor = False
        end
        object Panel1: TPanel
          Left = 0
          Top = 0
          Width = 578
          Height = 49
          Align = alTop
          BevelOuter = bvNone
          TabOrder = 0
          object Label10: TLabel
            Left = 61
            Top = 4
            Width = 383
            Height = 32
            Alignment = taCenter
            Caption = 
              'FABBISOGNO ANNUO DI ENERGIA PRIMARIA PER LA CLIMATIZZAZIONE INVE' +
              'RNALE'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = 232
            Font.Height = -13
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentFont = False
            WordWrap = True
          end
        end
      end
      object TabSheet1: TTabSheet
        Caption = 'Miglioramenti consigliati'
        ImageIndex = 3
        TabVisible = False
        object DBCtrlGrid1: TDBCtrlGrid
          Left = 0
          Top = 41
          Width = 578
          Height = 391
          Align = alClient
          ColCount = 1
          PanelHeight = 130
          PanelWidth = 561
          TabOrder = 0
          RowCount = 3
          object DBMemo1: TDBMemo
            Left = 0
            Top = 0
            Width = 561
            Height = 130
            Align = alClient
            TabOrder = 0
          end
        end
        object Panel2: TPanel
          Left = 0
          Top = 432
          Width = 578
          Height = 34
          Align = alBottom
          TabOrder = 1
        end
        object Panel3: TPanel
          Left = 0
          Top = 0
          Width = 578
          Height = 41
          Align = alTop
          Caption = 'MIGLIORAMENTI CONSIGLIATI'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 13339492
          Font.Height = -17
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 2
        end
      end
    end
    object Panel_L: TPanel
      Left = 0
      Top = 51
      Width = 257
      Height = 496
      BorderStyle = bsSingle
      Caption = 'Panel_L'
      Ctl3D = True
      ParentCtl3D = False
      TabOrder = 2
      object SB_Calcola: TLbSpeedButton
        Left = 1
        Top = 431
        Width = 251
        Height = 30
        Hint = 'Effettua i calcoli '
        Align = alBottom
        Alignment = taCenter
        Caption = 'Calcola'
        Color = 13868412
        ColorWhenDown = clBtnFace
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        HotTrackFont.Charset = DEFAULT_CHARSET
        HotTrackFont.Color = clWindowText
        HotTrackFont.Height = -11
        HotTrackFont.Name = 'MS Sans Serif'
        HotTrackFont.Style = []
        LightColor = 16050657
        NumGlyphs = 1
        ParentColor = False
        ParentFont = False
        ParentShowHint = False
        ShadowColor = clGray
        ShowHint = True
        Style = bsModern
        Visible = False
        OnClick = SB_CalcolaClick
      end
      object LB_Consumi: TLbSpeedButton
        Left = 1
        Top = 461
        Width = 251
        Height = 30
        Hint = 'Effettua i calcoli '
        Align = alBottom
        Alignment = taCenter
        Caption = 'Consumi'
        Color = 2134015
        ColorWhenDown = 535020206
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        HotTrackFont.Charset = DEFAULT_CHARSET
        HotTrackFont.Color = clWindowText
        HotTrackFont.Height = -11
        HotTrackFont.Name = 'MS Sans Serif'
        HotTrackFont.Style = []
        LightColor = 16050657
        NumGlyphs = 1
        ParentColor = False
        ParentFont = False
        ParentShowHint = False
        ShowHint = True
        Style = bsModern
        OnClick = LB_ConsumiClick
      end
      object DBGrid_Gen: TDBGrid
        Left = 1
        Top = 24
        Width = 251
        Height = 334
        Align = alClient
        Color = clWhite
        Ctl3D = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        Options = [dgTitles, dgColLines, dgRowLines, dgRowSelect, dgAlwaysShowSelection]
        ParentCtl3D = False
        ParentFont = False
        TabOrder = 0
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = 13339492
        TitleFont.Height = -11
        TitleFont.Name = 'MS Sans Serif'
        TitleFont.Style = [fsBold]
        OnCellClick = DBGrid_GenCellClick
        OnDrawColumnCell = DBGrid_GenDrawColumnCell
        OnKeyUp = DBGrid_GenKeyUp
        Columns = <
          item
            Expanded = False
            Visible = True
          end>
      end
      object LbStaticText2: TLbStaticText
        Left = 1
        Top = 1
        Width = 251
        Height = 23
        Align = alTop
        Alignment = taCenter
        Caption = 'Elenco generatori'
        Color = 13868412
        Flat = True
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        HotTrackColor = clSilver
        HotTrackFont.Charset = DEFAULT_CHARSET
        HotTrackFont.Color = clWindowText
        HotTrackFont.Height = -11
        HotTrackFont.Name = 'MS Sans Serif'
        HotTrackFont.Style = []
        LightColor = 16050657
        ParentColor = False
        ParentFont = False
        ShadowColor = clGray
        Style = bsModern
      end
      object GB_CalcoloAlloggio: TGroupBox
        Left = 1
        Top = 358
        Width = 251
        Height = 73
        Align = alBottom
        Caption = ' Tipologia di calcolo alloggio '
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 13339492
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 2
        Visible = False
        object Lb_Temp: TLabel
          Left = 99
          Top = 42
          Width = 30
          Height = 13
          Caption = 'Temp.'
          Enabled = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object LB_C: TLabel
          Left = 166
          Top = 42
          Width = 11
          Height = 13
          Caption = #176'C'
          Enabled = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object RB_VicPres: TRadioButton
          Left = 6
          Top = 23
          Width = 91
          Height = 17
          Caption = 'Vicini presenti'
          Checked = True
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 0
          TabStop = True
          OnClick = RB_VicPresClick
        end
        object RB_VicAss: TRadioButton
          Left = 6
          Top = 42
          Width = 87
          Height = 17
          Caption = 'Vicini assenti'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 1
          OnClick = RB_VicAssClick
        end
        object EditN_Temp: TEditN
          Left = 133
          Top = 38
          Width = 31
          Height = 21
          BevelKind = bkFlat
          BorderStyle = bsNone
          Color = clWhite
          Enabled = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 2
          Text = '0'
          OnChange = EditN_TempChange
          ColorOnFocus = clWhite
          ColorOnNotFocus = clWhite
          FontColorOnFocus = clBlack
          FontColorOnNotFocus = clBlack
          FontColorOnOverWrite = clBlack
          EditType = etFloat
          EditKeyByTab = #9
          EditAlign = etAlignNone
          EditLengthAlign = 0
          EditPrecision = 0
          ValueInteger = 0
          ValueDate = 38693
          ValueTime = 0.581837384259259
          TimeSeconds = False
          FirstCharUpper = False
          FirstCharUpList = ' ('
          WidthOnFocus = 0
        end
      end
    end
    object ST_ZonaClim: TStaticText
      Left = 565
      Top = 17
      Width = 57
      Height = 21
      AutoSize = False
      BevelInner = bvLowered
      BevelKind = bkFlat
      BevelOuter = bvRaised
      Color = 14811135
      ParentColor = False
      TabOrder = 3
    end
    object ST_GradiG: TStaticText
      Left = 712
      Top = 17
      Width = 57
      Height = 21
      AutoSize = False
      BevelInner = bvLowered
      BevelKind = bkFlat
      BevelOuter = bvRaised
      Color = 14811135
      ParentColor = False
      TabOrder = 4
    end
  end
  object P_BarraScorrimento: TPanel
    Left = 144
    Top = 432
    Width = 505
    Height = 105
    BevelOuter = bvNone
    BorderWidth = 2
    BorderStyle = bsSingle
    Ctl3D = False
    ParentCtl3D = False
    TabOrder = 2
    object LB_0: TLabel
      Left = 8
      Top = 63
      Width = 25
      Height = 13
      Caption = '[0%]'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object LB_100: TLabel
      Left = 456
      Top = 63
      Width = 39
      Height = 13
      Caption = '[100%]'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object LB_Calc: TLabel
      Left = 119
      Top = 13
      Width = 248
      Height = 16
      Caption = 'CALCOLO DI TUTTI I GENERATORI'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 13339492
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object LB_NomeAll: TLabel
      Left = 70
      Top = 38
      Width = 68
      Height = 13
      Caption = 'Generatore:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object ProgressBar_Calc: TProgressBar
      Left = 38
      Top = 60
      Width = 412
      Height = 21
      Min = 0
      Max = 100
      TabOrder = 0
    end
  end
  object Tab1: TTable
    Left = 80
    Top = 157
  end
  object DataS1: TDataSource
    DataSet = Tab1
    Left = 122
    Top = 158
  end
  object ImageList_Oggetti: TImageList
    Height = 14
    Width = 14
    Left = 272
    Top = 472
    Bitmap = {
      494C01010400090004000E000E00FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000380000002A0000000100200000000000C024
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000FFFFFF00FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00000000000000000000000000892A
      6000374E000056620000465100003B4A000029420000672B3F00000000000000
      00000000000000000000FFFFFF00FFFFFF0000000000680C960000164E000E1D
      6C0003185D0003125100000D3F001E0451000000000000000000000000000000
      0000000000000000000000000000680C960000164E000E1D6C0003185D000312
      5100000D3F00591E840000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000000000000AC426D007978
      0600917B2300927C25008E781F007B611B006B5C19004748000072294B000000
      00000000000000000000FFFFFF00FFFFFF007719B800162D8D00332FA2003631
      A2002E2C9F0028288D0010057200100572001E04510000000000000000000000
      000000000000000000007719B800162D8D00332FA2003631A2002E2C9F002828
      8D001005720010057200000D3F00000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000AF4F6B008F8D0F00B093
      2700B2972900B3972900000000009B802500917B2400735B18004D5000007129
      49000000000000000000FFFFFF00761CBC00213AA0003940BD00F0FFFF003B41
      BF003A42BD003B3DAC00F0FFFF000C056F00100572001E045100000000000000
      000000000000761CBC00213AA0003940BD00F0FFFF00F0FFFF00F0FFFF00F0FF
      FF00F0FFFF002E37C00010057200000D3F000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000949E0500BE9F2F00C7A3
      2E00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF008F79230076601B003649
      00000000000000000000FFFFFF001943A500424BC8004051D100F0FFFF00404F
      CD00404DCB003D47C300F0FFFF003B3DAC000C056F0010057200000000000000
      0000000000001943A500424BC8004051D100F0FFFF00404FCD00404DCB003D47
      C3002E37C0002E37C0002E37C000100572000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF008B4C4500C8AC2B00D5AE3000DFB9
      3400E4C13800DAB13100FFFFFF00C9A32F00BC9D2E00A68C2800927B2400665E
      140043281B000000000050199B003F55D200435CDD00F0FFFF004B61E800F0FF
      FF004359DA00F0FFFF002E37C000F0FFFF003B3DAC000C056F001E0451000000
      000050199B003F55D200435CDD004760E500F0FFFF004560E1004359DA004156
      D1002E37C0002E37C0002E37C0000C056F001E04510000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF009C881F00DDB93300E9C53900EDC4
      3800EDC53800EEC43400FFFFFF00DAAE2F00C4A43100BB9D2E009D8625007B66
      1B00293E000000000000343AAE00465FE4004C65EE00F0FFFF004B69F000F0FF
      FF004C61EB00F0FFFF00434ECE00F0FFFF003B39AD0028248D00001143000000
      0000343AAE00465FE4004C65EE004B6BF100F0FFFF004768F1004C61EB004262
      E100434ECE00444BC6003B39AD0028248D000011430000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00A88C2000E7BC3400F7CD3A00FFD5
      3800FFD33800FFD45700FFFFFF00E7C53800D3AE3000BD9E2E00A88725008568
      1B002B3F000000000000343BB0004669ED00F0FFFF004B77FF004B79FF006A97
      FF00F0FFFF004C61EA00435ADB00404AC800F0FFFF002A2D9700001346000000
      0000343BB0004669ED004D72F9004B77FF00F0FFFF00F0FFFF00F0FFFF00F0FF
      FF00435ADB00404AC800343EB5002A2D97000013460000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00A05A4B00F0D23600F6C93C00FFD3
      3B00FFBD5700FFBD5700FFFFFF00EEC43600DAB23100C4A22E00B59A2A008471
      19004C2E2000000000005727B500496BF200F0FFFF004E79FE006CB0FD004C7B
      FD00F0FFFF00496AF1004460E100414FCE00F0FFFF00292D96002A0C5D000000
      00005727B500496BF2005076F9004E79FE00F0FFFF00567FFF00567FFF00496A
      F1004460E100414FCE003C43C200292D96002A0C5D0000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000DFDB1600FACD3900FFD2
      3F00FFD13E00FFCC3600FFFFFF00EDC53900E4C13800C7A02D00B19528006C76
      00000000000000000000FFFFFF002C72E500F0FFFF00527DFE00527BFE004C7B
      FD00F0FFFF004C6AF0004B62E8004055D000F0FFFF000E2C8100000000000000
      0000000000002C72E5004D77FE00527DFE00F0FFFF004C7BFD004A76FF004C6A
      F0004B62E8004055D0003941BE000E2C81000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000E5787600EFDB2800FFD0
      3E00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00C29E2F009A9213009C4E
      54000000000000000000FFFFFF008940F1003D79F300517EFF005581FE004D78
      FE004B77FF004C6BF100475DE1004251CC00253DAA006524BA00000000000000
      000000000000823DE9003D79F300517EFF00F0FFFF004D78FE004B77FF004C6B
      F100475DE1004251CC00253DAA005F1AAA000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000000000000EE787D00ECD5
      2200FCCE3C00F8CC3A00F8CC3A00E4B93300CFA93000ADA01800AE5D59000000
      00000000000000000000FFFFFF00FFFFFF008940F1003676F0004F79FF004D74
      F9004D72F9004666E800435AD8002B47BB006524BA0000000000000000000000
      000000000000000000008940F1003676F000F0FFFF00F0FFFF00F0FFFF00F0FF
      FF00F0FFFF002B47BB006524BA00000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00000000000000000000000000DE71
      7500CECC1200DDD11B00D8CA1C00C1B619009D9F0800A55E4C00000000000000
      00000000000000000000FFFFFF00FFFFFF00000000008339E3002869D8003068
      E3003169DF002E5BCB001D49AC005928B3000000000000000000000000000000
      00000000000000000000000000008339E3002869D8003068E3003169DF002E5B
      CB001D49AC005928B30000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000FFFFFF00FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00424D3E000000000000003E000000
      28000000380000002A0000000100010000000000500100000000000000000000
      000000000000000000000000FFFFFF0000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000FFFCFFFFFFC00000E03C80FE03C00000
      C01C007C01C00000820C003800C00000800C003800C000000004001000400000
      000400100040000000040010004000000004001000400000800C003800C00000
      800C003800C00000C01C007C01C00000E03C80FE03C00000FFFCFFFFFFC00000
      00000000000000000000000000000000000000000000}
  end
  object Timer: TTimer
    Enabled = False
    Interval = 500
    OnTimer = TimerTimer
    Left = 192
    Top = 440
  end
end
