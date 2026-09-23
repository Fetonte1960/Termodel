object FReti3d: TFReti3d
  Left = 579
  Top = 158
  Width = 380
  Height = 398
  Caption = 'Elenco delle reti'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox1: TGroupBox
    Left = 0
    Top = 0
    Width = 364
    Height = 360
    Align = alClient
    Caption = #167'RETI::'
    TabOrder = 0
    object Label1: TLabel
      Left = 16
      Top = 200
      Width = 63
      Height = 13
      Caption = 'Portata totale'
    end
    object Label2: TLabel
      Left = 16
      Top = 224
      Width = 113
      Height = 13
      Caption = 'Prevalenza della pompa'
    end
    object Label3: TLabel
      Left = 200
      Top = 200
      Width = 24
      Height = 13
      Caption = '[ l/s ]'
    end
    object Label4: TLabel
      Left = 200
      Top = 217
      Width = 31
      Height = 13
      Caption = '[ kPa ]'
    end
    object Label6: TLabel
      Left = 16
      Top = 256
      Width = 94
      Height = 13
      Caption = 'Contatore debug 3d'
    end
    object Label7: TLabel
      Left = 8
      Top = 123
      Width = 42
      Height = 13
      Caption = 'Tipo rete'
    end
    object DBMemo1: TDBMemo
      Tag = 12
      Left = 2
      Top = 15
      Width = 360
      Height = 98
      Align = alTop
      ReadOnly = True
      TabOrder = 0
    end
    object Panel1: TPanel
      Left = 2
      Top = 290
      Width = 360
      Height = 68
      Align = alBottom
      TabOrder = 1
      object LbSpeedButton1: TLbSpeedButton
        Left = 2
        Top = 7
        Width = 95
        Height = 23
        Hint = 'Cancella l'#39'elemento selezionato'
        Alignment = taCenter
        Caption = 'Calcola'
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
        Left = 2
        Top = 38
        Width = 95
        Height = 23
        Hint = 'Cancella l'#39'elemento selezionato'
        Alignment = taCenter
        Caption = 'Controlla piano'
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
      object Label5: TLabel
        Left = 104
        Top = 44
        Width = 27
        Height = 13
        Caption = 'Piano'
      end
      object LbSpeedButton3: TLbSpeedButton
        Left = 100
        Top = 7
        Width = 125
        Height = 23
        Hint = 'Cancella l'#39'elemento selezionato'
        Alignment = taCenter
        Caption = 'Aggiorna & Calcola'
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
      object LbSpeedButton4: TLbSpeedButton
        Left = 229
        Top = 7
        Width = 52
        Height = 23
        Hint = 'Cancella l'#39'elemento selezionato'
        Alignment = taCenter
        Caption = '3D'
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
        OnClick = LbSpeedButton4Click
      end
      object LbSpeedButton5: TLbSpeedButton
        Left = 285
        Top = 7
        Width = 52
        Height = 23
        Hint = 'Cancella l'#39'elemento selezionato'
        Alignment = taCenter
        Caption = 'Tipi rete'
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
        OnClick = LbSpeedButton5Click
      end
      object Edit1: TEdit
        Left = 144
        Top = 38
        Width = 121
        Height = 21
        TabOrder = 0
        Text = 'Terra'
      end
    end
    object DBEdit1: TDBEdit
      Tag = 14
      Left = 136
      Top = 192
      Width = 57
      Height = 21
      Color = clBtnFace
      ReadOnly = True
      TabOrder = 2
    end
    object DBEdit2: TDBEdit
      Tag = 15
      Left = 136
      Top = 216
      Width = 58
      Height = 21
      Color = clBtnFace
      ReadOnly = True
      TabOrder = 3
    end
    object Edit2: TEdit
      Left = 136
      Top = 248
      Width = 65
      Height = 21
      TabOrder = 4
      Text = '0'
    end
    object SpinButton1: TSpinButton
      Left = 208
      Top = 240
      Width = 20
      Height = 25
      DownGlyph.Data = {
        0E010000424D0E01000000000000360000002800000009000000060000000100
        200000000000D800000000000000000000000000000000000000008080000080
        8000008080000080800000808000008080000080800000808000008080000080
        8000008080000080800000808000000000000080800000808000008080000080
        8000008080000080800000808000000000000000000000000000008080000080
        8000008080000080800000808000000000000000000000000000000000000000
        0000008080000080800000808000000000000000000000000000000000000000
        0000000000000000000000808000008080000080800000808000008080000080
        800000808000008080000080800000808000}
      FocusControl = Edit2
      TabOrder = 5
      UpGlyph.Data = {
        0E010000424D0E01000000000000360000002800000009000000060000000100
        200000000000D800000000000000000000000000000000000000008080000080
        8000008080000080800000808000008080000080800000808000008080000080
        8000000000000000000000000000000000000000000000000000000000000080
        8000008080000080800000000000000000000000000000000000000000000080
        8000008080000080800000808000008080000000000000000000000000000080
        8000008080000080800000808000008080000080800000808000000000000080
        8000008080000080800000808000008080000080800000808000008080000080
        800000808000008080000080800000808000}
      OnDownClick = SpinButton1DownClick
      OnUpClick = SpinButton1UpClick
    end
    object Button1: TButton
      Left = 248
      Top = 192
      Width = 75
      Height = 25
      Caption = 'Apri progetto'
      TabOrder = 6
      OnClick = Button1Click
    end
    object DBComboBox1: TDBComboBox
      Tag = 6
      Left = 69
      Top = 120
      Width = 164
      Height = 21
      ItemHeight = 13
      TabOrder = 7
    end
  end
  object OpenDialog1: TOpenDialog
    DefaultExt = '*.cct'
    Filter = 'projectbrowser|*.cct'
    InitialDir = 'c:\documenti\progetti clima'
    Left = 248
    Top = 128
  end
end
