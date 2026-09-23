object FMain_suntrace: TFMain_suntrace
  Left = 411
  Top = 155
  Width = 999
  Height = 590
  Caption = 'Sun trace V. 2.51'
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
  object Panel1: TPanel
    Left = 0
    Top = 525
    Width = 991
    Height = 31
    Align = alBottom
    TabOrder = 0
    object SpeedButton4: TLbSpeedButton
      Left = 6
      Top = 2
      Width = 80
      Height = 23
      Hint = 'Crea un nuovo elemento di confine'
      Alignment = taCenter
      Caption = 'Nuovi dati'
      ColorWhenDown = 535020206
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
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
      OnClick = SpeedButton4Click
    end
    object LbSpeedButton1: TLbSpeedButton
      Left = 94
      Top = 2
      Width = 80
      Height = 23
      Hint = 'Crea un nuovo elemento di confine'
      Alignment = taCenter
      Caption = 'Calcola'
      ColorWhenDown = 535020206
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
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
  end
  object PageControl1: TPageControl
    Left = 0
    Top = 0
    Width = 991
    Height = 525
    ActivePage = TabSheet2
    Align = alClient
    TabIndex = 1
    TabOrder = 1
    object TabSheet1: TTabSheet
      Caption = 'Rilevazioni'
      object Panel2: TPanel
        Left = 0
        Top = 469
        Width = 983
        Height = 28
        Align = alBottom
        TabOrder = 0
        object DBNavigator1: TDBNavigator
          Left = 0
          Top = 0
          Width = 240
          Height = 25
          DataSource = DSRilievi
          TabOrder = 0
        end
      end
      object DBGrid1: TDBGrid
        Left = 0
        Top = 0
        Width = 983
        Height = 469
        Align = alClient
        TabOrder = 1
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'MS Sans Serif'
        TitleFont.Style = []
      end
    end
    object TabSheet2: TTabSheet
      Caption = 'Dati generali'
      ImageIndex = 1
      object GroupBox1: TGroupBox
        Left = 0
        Top = 160
        Width = 983
        Height = 337
        Align = alBottom
        Caption = 'Dati localit'#224
        TabOrder = 0
        object Label39: TLabel
          Left = 373
          Top = 56
          Width = 74
          Height = 13
          AutoSize = False
          Caption = 'Mese iniziale'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object Label40: TLabel
          Left = 374
          Top = 93
          Width = 66
          Height = 13
          AutoSize = False
          Caption = 'Mese finale'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object Label3: TLabel
          Left = 373
          Top = 24
          Width = 74
          Height = 13
          AutoSize = False
          Caption = 'Ora legale'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label41: TLabel
          Left = 13
          Top = 26
          Width = 46
          Height = 13
          Alignment = taCenter
          AutoSize = False
          Caption = 'Localit'#224
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label4: TLabel
          Left = 13
          Top = 57
          Width = 62
          Height = 13
          Alignment = taCenter
          AutoSize = False
          Caption = 'Latitudine'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label15: TLabel
          Left = 146
          Top = 57
          Width = 28
          Height = 13
          AutoSize = False
          Caption = '[Deg]'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object Label6: TLabel
          Left = 13
          Top = 88
          Width = 69
          Height = 14
          AutoSize = False
          Caption = 'Longitudine'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label12: TLabel
          Left = 146
          Top = 89
          Width = 28
          Height = 13
          AutoSize = False
          Caption = '[Deg]'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object Label9: TLabel
          Left = 13
          Top = 120
          Width = 205
          Height = 13
          AutoSize = False
          Caption = 'Longitudine meridiano di riferimento'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label38: TLabel
          Left = 283
          Top = 120
          Width = 28
          Height = 13
          AutoSize = False
          Caption = '[Deg]'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object LbSpeedButton2: TLbSpeedButton
          Left = 6
          Top = 306
          Width = 80
          Height = 23
          Hint = 'Crea un nuovo elemento di confine'
          Alignment = taCenter
          Caption = 'Conferma'
          ColorWhenDown = 535020206
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
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
          OnClick = LbSpeedButton2Click
        end
        object Label18: TLabel
          Left = 16
          Top = 160
          Width = 73
          Height = 13
          Caption = 'Label18'
        end
        object Label19: TLabel
          Left = 16
          Top = 192
          Width = 38
          Height = 13
          Caption = 'Label18'
        end
        object Label20: TLabel
          Left = 16
          Top = 176
          Width = 57
          Height = 13
          Caption = 'Label18'
        end
        object Label21: TLabel
          Left = 16
          Top = 208
          Width = 38
          Height = 13
          Caption = 'Label18'
        end
        object DBEdit30: TDBEdit
          Tag = 7
          Left = 453
          Top = 52
          Width = 56
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
        object DBEdit31: TDBEdit
          Tag = 8
          Left = 453
          Top = 89
          Width = 56
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
        object DBEdit36: TDBEdit
          Tag = 1
          Left = 85
          Top = 22
          Width = 239
          Height = 21
          BevelKind = bkFlat
          BorderStyle = bsNone
          Color = clMenu
          TabOrder = 2
        end
        object DBEdit12: TDBEdit
          Tag = 4
          Left = 85
          Top = 53
          Width = 50
          Height = 21
          BevelKind = bkFlat
          BorderStyle = bsNone
          Color = clMenu
          TabOrder = 3
        end
        object DBEdit15: TDBEdit
          Tag = 5
          Left = 85
          Top = 85
          Width = 50
          Height = 21
          BevelKind = bkFlat
          BorderStyle = bsNone
          Color = clMenu
          TabOrder = 4
        end
        object DBEdit32: TDBEdit
          Tag = 6
          Left = 221
          Top = 116
          Width = 50
          Height = 21
          BevelKind = bkFlat
          BorderStyle = bsNone
          Color = clMenu
          TabOrder = 5
        end
        object GroupBox3: TGroupBox
          Left = 2
          Top = -2
          Width = 979
          Height = 337
          Align = alBottom
          Caption = 'Dati localit'#224
          TabOrder = 6
          object Label22: TLabel
            Left = 373
            Top = 56
            Width = 74
            Height = 13
            AutoSize = False
            Caption = 'Mese iniziale'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
          end
          object Label23: TLabel
            Left = 374
            Top = 93
            Width = 66
            Height = 13
            AutoSize = False
            Caption = 'Mese finale'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
          end
          object Label24: TLabel
            Left = 373
            Top = 24
            Width = 74
            Height = 13
            AutoSize = False
            Caption = 'Ora legale'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object Label25: TLabel
            Left = 13
            Top = 26
            Width = 46
            Height = 13
            Alignment = taCenter
            AutoSize = False
            Caption = 'Localit'#224
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object Label26: TLabel
            Left = 13
            Top = 57
            Width = 62
            Height = 13
            Alignment = taCenter
            AutoSize = False
            Caption = 'Latitudine'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object Label27: TLabel
            Left = 146
            Top = 57
            Width = 28
            Height = 13
            AutoSize = False
            Caption = '[Deg]'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
          end
          object Label28: TLabel
            Left = 13
            Top = 88
            Width = 69
            Height = 14
            AutoSize = False
            Caption = 'Longitudine'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object Label29: TLabel
            Left = 146
            Top = 89
            Width = 28
            Height = 13
            AutoSize = False
            Caption = '[Deg]'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
          end
          object Label30: TLabel
            Left = 13
            Top = 120
            Width = 205
            Height = 13
            AutoSize = False
            Caption = 'Longitudine meridiano di riferimento'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object Label31: TLabel
            Left = 283
            Top = 120
            Width = 28
            Height = 13
            AutoSize = False
            Caption = '[Deg]'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
          end
          object LbSpeedButton3: TLbSpeedButton
            Left = 6
            Top = 306
            Width = 80
            Height = 23
            Hint = 'Crea un nuovo elemento di confine'
            Alignment = taCenter
            Caption = 'Conferma'
            ColorWhenDown = 535020206
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
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
            OnClick = LbSpeedButton2Click
          end
          object Labelnorm: TLabel
            Left = 16
            Top = 160
            Width = 41
            Height = 13
            Caption = 'Label18'
          end
          object LabelX2: TLabel
            Left = 16
            Top = 192
            Width = 38
            Height = 13
            Caption = 'Label18'
          end
          object Labelins: TLabel
            Left = 16
            Top = 176
            Width = 38
            Height = 13
            Caption = 'Label18'
          end
          object Labelx4: TLabel
            Left = 16
            Top = 208
            Width = 38
            Height = 13
            Caption = 'Label18'
          end
          object Labelx6: TLabel
            Left = 16
            Top = 224
            Width = 38
            Height = 13
            Caption = 'Label18'
          end
          object DBEdit6: TDBEdit
            Tag = 7
            Left = 453
            Top = 52
            Width = 56
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
          object DBEdit7: TDBEdit
            Tag = 8
            Left = 453
            Top = 89
            Width = 56
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
          object DBEdit8: TDBEdit
            Tag = 1
            Left = 85
            Top = 22
            Width = 239
            Height = 21
            BevelKind = bkFlat
            BorderStyle = bsNone
            Color = clMenu
            TabOrder = 2
          end
          object DBEdit9: TDBEdit
            Tag = 4
            Left = 85
            Top = 53
            Width = 50
            Height = 21
            BevelKind = bkFlat
            BorderStyle = bsNone
            Color = clMenu
            TabOrder = 3
          end
          object DBEdit10: TDBEdit
            Tag = 5
            Left = 85
            Top = 85
            Width = 50
            Height = 21
            BevelKind = bkFlat
            BorderStyle = bsNone
            Color = clMenu
            TabOrder = 4
          end
          object DBEdit11: TDBEdit
            Tag = 6
            Left = 221
            Top = 116
            Width = 50
            Height = 21
            BevelKind = bkFlat
            BorderStyle = bsNone
            Color = clMenu
            TabOrder = 5
          end
        end
      end
      object GroupBox2: TGroupBox
        Left = 0
        Top = 0
        Width = 983
        Height = 160
        Align = alClient
        Caption = 'Dati impianto'
        TabOrder = 1
        object Label1: TLabel
          Left = 13
          Top = 24
          Width = 124
          Height = 13
          AutoSize = False
          Caption = 'Posizione pannelli'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label2: TLabel
          Left = 13
          Top = 56
          Width = 74
          Height = 13
          AutoSize = False
          Caption = 'Orientamento'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object Label5: TLabel
          Left = 14
          Top = 93
          Width = 66
          Height = 13
          AutoSize = False
          Caption = 'Inclinazione'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object Label7: TLabel
          Left = 157
          Top = 56
          Width = 124
          Height = 13
          AutoSize = False
          Caption = '( 0:Nord  90:est  180:sud )'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object Label8: TLabel
          Left = 157
          Top = 96
          Width = 148
          Height = 13
          AutoSize = False
          Caption = '( 0:orizzontale  90:verticale )'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object Label10: TLabel
          Left = 320
          Top = 25
          Width = 105
          Height = 13
          AutoSize = False
          Caption = 'Potenza di picco'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label11: TLabel
          Left = 514
          Top = 25
          Width = 28
          Height = 13
          AutoSize = False
          Caption = '[kW]'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object Label13: TLabel
          Left = 320
          Top = 49
          Width = 124
          Height = 13
          AutoSize = False
          Caption = 'Rendimento inverter'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label14: TLabel
          Left = 514
          Top = 49
          Width = 28
          Height = 13
          AutoSize = False
          Caption = '[%]'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object Label16: TLabel
          Left = 320
          Top = 73
          Width = 124
          Height = 13
          AutoSize = False
          Caption = 'Costo energia'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label17: TLabel
          Left = 514
          Top = 73
          Width = 63
          Height = 13
          AutoSize = False
          Caption = '[ Euro/kWh ]'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object DBEdit1: TDBEdit
          Tag = 1
          Left = 93
          Top = 52
          Width = 56
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
          Tag = 2
          Left = 93
          Top = 89
          Width = 56
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
          Tag = 3
          Left = 453
          Top = 21
          Width = 50
          Height = 21
          BevelKind = bkFlat
          BorderStyle = bsNone
          Color = clMenu
          TabOrder = 2
        end
        object DBEdit4: TDBEdit
          Tag = 4
          Left = 453
          Top = 45
          Width = 50
          Height = 21
          BevelKind = bkFlat
          BorderStyle = bsNone
          Color = clMenu
          TabOrder = 3
        end
        object DBEdit5: TDBEdit
          Tag = 5
          Left = 453
          Top = 69
          Width = 50
          Height = 21
          BevelKind = bkFlat
          BorderStyle = bsNone
          Color = clMenu
          TabOrder = 4
        end
      end
    end
    object TabSheet3: TTabSheet
      Caption = 'Ostacoli'
      ImageIndex = 2
    end
    object TabSheet4: TTabSheet
      Caption = 'Risultati'
      ImageIndex = 3
    end
  end
  object TRilievi: TTable
    Left = 816
    Top = 48
  end
  object DSRilievi: TDataSource
    DataSet = TRilievi
    Left = 776
    Top = 48
  end
  object dslocalita: TDataSource
    DataSet = Tlocalita
    Left = 808
    Top = 488
  end
  object Tlocalita: TTable
    Left = 848
    Top = 488
  end
  object DSProgetto: TDataSource
    DataSet = TProgetto
    Left = 808
    Top = 448
  end
  object TProgetto: TTable
    Left = 848
    Top = 448
  end
end
