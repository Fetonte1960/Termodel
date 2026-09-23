object Fpezzi: TFpezzi
  Left = 259
  Top = 107
  Width = 856
  Height = 542
  Caption = 'Pezzi speciali dei canali'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCanResize = FormCanResize
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnPaint = FormPaint
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 390
    Width = 848
    Height = 125
    Align = alBottom
    TabOrder = 0
    OnClick = Panel1Click
    object Label1: TLabel
      Left = 344
      Top = 8
      Width = 41
      Height = 13
      Caption = 'Distanza'
    end
    object Label2: TLabel
      Left = 704
      Top = 8
      Width = 91
      Height = 13
      Caption = 'Con il mouse muovi'
      Visible = False
    end
    object Label3: TLabel
      Left = 344
      Top = 48
      Width = 32
      Height = 13
      Caption = 'Focale'
    end
    object Label4: TLabel
      Left = 488
      Top = 8
      Width = 7
      Height = 13
      Caption = 'X'
    end
    object Label6: TLabel
      Left = 488
      Top = 40
      Width = 7
      Height = 13
      Caption = 'Y'
    end
    object Label7: TLabel
      Left = 488
      Top = 64
      Width = 7
      Height = 13
      Caption = 'Z'
    end
    object Label5: TLabel
      Left = 8
      Top = 96
      Width = 78
      Height = 13
      Caption = 'Scheletro tranne'
    end
    object Label8: TLabel
      Left = 128
      Top = 72
      Width = 32
      Height = 13
      Caption = 'Locale'
    end
    object Label9: TLabel
      Left = 280
      Top = 72
      Width = 50
      Height = 13
      Caption = 'Solo piano'
    end
    object TrackBar1: TTrackBar
      Left = 384
      Top = 0
      Width = 94
      Height = 41
      Ctl3D = True
      Max = 100
      Orientation = trHorizontal
      ParentCtl3D = False
      Frequency = 1
      Position = 8
      SelEnd = 0
      SelStart = 0
      TabOrder = 0
      TickMarks = tmBottomRight
      TickStyle = tsAuto
      OnChange = TrackBar1Change
    end
    object RBVista: TRadioButton
      Left = 704
      Top = 24
      Width = 113
      Height = 17
      Caption = 'Il punto di vista'
      TabOrder = 1
      Visible = False
    end
    object RBLuci: TRadioButton
      Left = 704
      Top = 40
      Width = 113
      Height = 17
      Caption = 'L'#39' illuminavione'
      TabOrder = 2
      Visible = False
    end
    object TrackBar3: TTrackBar
      Left = 392
      Top = 40
      Width = 86
      Height = 33
      Orientation = trHorizontal
      Frequency = 1
      Position = 5
      SelEnd = 0
      SelStart = 0
      TabOrder = 3
      TickMarks = tmBottomRight
      TickStyle = tsAuto
      OnChange = TrackBar3Change
    end
    object TrackBar2: TTrackBar
      Left = 504
      Top = 0
      Width = 145
      Height = 41
      Max = 100
      Orientation = trHorizontal
      Frequency = 1
      Position = 50
      SelEnd = 0
      SelStart = 0
      TabOrder = 4
      TickMarks = tmBottomRight
      TickStyle = tsAuto
      OnChange = TrackBar2Change
    end
    object TrackBar4: TTrackBar
      Left = 504
      Top = 24
      Width = 145
      Height = 33
      Max = 100
      Orientation = trHorizontal
      Frequency = 1
      Position = 50
      SelEnd = 0
      SelStart = 0
      TabOrder = 5
      TickMarks = tmBottomRight
      TickStyle = tsAuto
      OnChange = TrackBar4Change
    end
    object TrackBar5: TTrackBar
      Left = 504
      Top = 56
      Width = 145
      Height = 25
      Max = 100
      Orientation = trHorizontal
      Frequency = 1
      Position = 50
      SelEnd = 0
      SelStart = 0
      TabOrder = 6
      TickMarks = tmBottomRight
      TickStyle = tsAuto
      OnChange = TrackBar5Change
    end
    object RBscheletro: TCheckBox
      Left = 8
      Top = 48
      Width = 97
      Height = 17
      Caption = 'Scheletro'
      TabOrder = 7
      OnClick = RBscheletroClick
    end
    object CheckBox1: TCheckBox
      Left = 8
      Top = 8
      Width = 97
      Height = 17
      Caption = 'In primo piano'
      TabOrder = 8
    end
    object CBLocale: TComboBox
      Left = 96
      Top = 88
      Width = 97
      Height = 21
      BevelKind = bkFlat
      Style = csDropDownList
      Ctl3D = True
      ItemHeight = 13
      ParentCtl3D = False
      TabOrder = 9
      OnChange = CBLocaleChange
    end
    object CB_Reti: TCheckBox
      Left = 8
      Top = 28
      Width = 97
      Height = 17
      Caption = 'Reti'
      Checked = True
      State = cbChecked
      TabOrder = 10
      OnClick = CB_RetiClick
    end
    object CBdentro: TCheckBox
      Left = 392
      Top = 88
      Width = 65
      Height = 17
      Caption = 'Dentro'
      TabOrder = 11
      OnClick = CBdentroClick
    end
    object CbAssi: TCheckBox
      Left = 480
      Top = 88
      Width = 161
      Height = 17
      Caption = 'Visualizza punto di mira'
      TabOrder = 12
      OnClick = CbAssiClick
    end
    object CBVetri: TCheckBox
      Left = 8
      Top = 64
      Width = 97
      Height = 17
      Caption = 'Vetri'
      TabOrder = 13
    end
    object CBPIano: TComboBox
      Left = 256
      Top = 87
      Width = 97
      Height = 21
      BevelKind = bkFlat
      Style = csDropDownList
      Ctl3D = True
      ItemHeight = 13
      ParentCtl3D = False
      TabOrder = 14
      OnChange = CBPIanoChange
    end
    object CBHmedia: TCheckBox
      Left = 120
      Top = 8
      Width = 97
      Height = 17
      Caption = 'H. Media'
      TabOrder = 15
    end
    object Test1: TTrackBar
      Left = 664
      Top = 32
      Width = 150
      Height = 33
      Max = 100
      Orientation = trHorizontal
      Frequency = 1
      Position = 0
      SelEnd = 0
      SelStart = 0
      TabOrder = 16
      TickMarks = tmBottomRight
      TickStyle = tsAuto
    end
    object BSalva: TButton
      Left = 96
      Top = 40
      Width = 57
      Height = 25
      Caption = 'Memo'
      TabOrder = 17
    end
    object BRichiama: TButton
      Left = 160
      Top = 40
      Width = 57
      Height = 25
      Caption = 'Richiama'
      TabOrder = 18
    end
    object Test2: TTrackBar
      Left = 664
      Top = 56
      Width = 150
      Height = 33
      Max = 100
      Orientation = trHorizontal
      Frequency = 1
      Position = 0
      SelEnd = 0
      SelStart = 0
      TabOrder = 19
      TickMarks = tmBottomRight
      TickStyle = tsAuto
    end
    object Test3: TTrackBar
      Left = 664
      Top = 80
      Width = 150
      Height = 33
      Max = 100
      Orientation = trHorizontal
      Frequency = 1
      Position = 0
      SelEnd = 0
      SelStart = 0
      TabOrder = 20
      TickMarks = tmBottomRight
      TickStyle = tsAuto
    end
  end
  object HostPanel: TPanel
    Left = 0
    Top = 0
    Width = 848
    Height = 390
    Align = alClient
    TabOrder = 1
    OnResize = HostPanelResize
  end
end
