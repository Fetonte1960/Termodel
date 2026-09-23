object Form1: TForm1
  Tag = 1
  Left = 450
  Top = 152
  Width = 826
  Height = 643
  Caption = 'Pezzi speciali dei canali'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Tag = 3
    Left = 0
    Top = 508
    Width = 818
    Height = 101
    Align = alBottom
    TabOrder = 0
    object Label1: TLabel
      Left = 200
      Top = 8
      Width = 41
      Height = 13
      Caption = 'Distanza'
    end
    object Label2: TLabel
      Left = 352
      Top = 64
      Width = 91
      Height = 13
      Caption = 'Con il mouse muovi'
      Visible = False
    end
    object Label3: TLabel
      Left = 352
      Top = 8
      Width = 32
      Height = 13
      Caption = 'Focale'
    end
    object Label4: TLabel
      Left = 8
      Top = 40
      Width = 7
      Height = 13
      Caption = 'X'
    end
    object Label6: TLabel
      Left = 168
      Top = 48
      Width = 7
      Height = 13
      Caption = 'Y'
    end
    object Label7: TLabel
      Left = 328
      Top = 40
      Width = 7
      Height = 13
      Caption = 'Z'
    end
    object LPezzo: TLabel
      Left = 600
      Top = 56
      Width = 3
      Height = 13
    end
    object Label12: TLabel
      Left = 560
      Top = 72
      Width = 38
      Height = 13
      Caption = 'Label12'
    end
    object Label13: TLabel
      Left = 488
      Top = 8
      Width = 22
      Height = 13
      Caption = 'Turn'
    end
    object TrackBar1: TTrackBar
      Left = 256
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
      Left = 352
      Top = 80
      Width = 113
      Height = 17
      Caption = 'Il punto di vista'
      TabOrder = 1
      Visible = False
      OnClick = RBVistaClick
    end
    object RBLuci: TRadioButton
      Left = 448
      Top = 80
      Width = 113
      Height = 17
      Caption = 'L'#39' illuminavione'
      TabOrder = 2
      Visible = False
    end
    object TrackBar3: TTrackBar
      Left = 392
      Top = 0
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
      Left = 24
      Top = 32
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
      Left = 184
      Top = 32
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
      Left = 344
      Top = 32
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
      OnChange = TrackBar4Change
    end
    object CheckBox1: TCheckBox
      Left = 8
      Top = 8
      Width = 97
      Height = 17
      Caption = 'In primo piano'
      TabOrder = 7
      OnClick = CheckBox1Click
    end
    object CBdentro: TCheckBox
      Left = 8
      Top = 72
      Width = 65
      Height = 17
      Caption = 'Dentro'
      TabOrder = 8
      OnClick = CBdentroClick
    end
    object CbAssi: TCheckBox
      Left = 96
      Top = 72
      Width = 161
      Height = 17
      Caption = 'Visualizza punto di mira'
      TabOrder = 9
      OnClick = CbAssiClick
    end
    object Test1: TTrackBar
      Left = 632
      Top = 0
      Width = 150
      Height = 33
      Max = 100
      Orientation = trHorizontal
      Frequency = 1
      Position = 0
      SelEnd = 0
      SelStart = 0
      TabOrder = 10
      TickMarks = tmBottomRight
      TickStyle = tsAuto
      OnChange = Test1Change
    end
    object Test2: TTrackBar
      Left = 632
      Top = 32
      Width = 150
      Height = 33
      Max = 100
      Orientation = trHorizontal
      Frequency = 1
      Position = 0
      SelEnd = 0
      SelStart = 0
      TabOrder = 11
      TickMarks = tmBottomRight
      TickStyle = tsAuto
      OnChange = Test1Change
    end
    object Test3: TTrackBar
      Left = 640
      Top = 64
      Width = 150
      Height = 33
      Max = 100
      Orientation = trHorizontal
      Frequency = 1
      Position = 0
      SelEnd = 0
      SelStart = 0
      TabOrder = 12
      TickMarks = tmBottomRight
      TickStyle = tsAuto
      OnChange = Test1Change
    end
    object CBHmedia: TCheckBox
      Left = 120
      Top = 8
      Width = 73
      Height = 17
      Caption = 'H. Media'
      TabOrder = 13
    end
    object rbscheletro: TCheckBox
      Left = 264
      Top = 72
      Width = 97
      Height = 17
      Caption = 'rbscheletro'
      TabOrder = 14
    end
    object Epezzo: TEdit
      Left = 584
      Top = 40
      Width = 57
      Height = 21
      TabOrder = 15
    end
    object SBPezzo: TSpinEdit
      Left = 592
      Top = 70
      Width = 49
      Height = 22
      MaxValue = 0
      MinValue = 0
      TabOrder = 16
      Value = 0
    end
    object TBTurn: TTrackBar
      Left = 528
      Top = 0
      Width = 89
      Height = 33
      Max = 100
      Orientation = trHorizontal
      Frequency = 1
      Position = 0
      SelEnd = 0
      SelStart = 0
      TabOrder = 17
      TickMarks = tmBottomRight
      TickStyle = tsAuto
      OnChange = TBTurnChange
    end
  end
  object GLSceneViewer1: TGLSceneViewer
    Left = 0
    Top = 0
    Width = 633
    Height = 508
    Camera = GLCamera1
    Buffer.BackgroundColor = clBlack
    Align = alClient
    OnDblClick = GLSceneViewer1DblClick
    OnMouseDown = GLSceneViewer1MouseDown
    OnMouseMove = GLSceneViewer1MouseMove
  end
  object Panel2: TPanel
    Left = 633
    Top = 0
    Width = 185
    Height = 508
    Align = alRight
    TabOrder = 2
    object Label5: TLabel
      Left = 8
      Top = 160
      Width = 65
      Height = 13
      Caption = 'Codice Pezzo'
    end
    object Label8: TLabel
      Left = 8
      Top = 64
      Width = 34
      Height = 13
      Caption = 'Entrata'
    end
    object Label9: TLabel
      Left = 8
      Top = 16
      Width = 45
      Height = 13
      Caption = 'N'#176' Uscite'
    end
    object Label10: TLabel
      Left = 8
      Top = 40
      Width = 21
      Height = 13
      Caption = 'Tipo'
    end
    object Label14: TLabel
      Left = 8
      Top = 88
      Width = 39
      Height = 13
      Caption = 'Uscita 1'
    end
    object Label15: TLabel
      Left = 8
      Top = 112
      Width = 48
      Height = 13
      Caption = 'Uscita 2,3'
    end
    object Label16: TLabel
      Left = 8
      Top = 136
      Width = 30
      Height = 13
      Caption = 'Flusso'
    end
    object cbcodpezzo: TComboBox
      Left = 8
      Top = 176
      Width = 145
      Height = 21
      ItemHeight = 13
      TabOrder = 0
      Text = 'R1C_ULT'
      OnChange = cbcodpezzoChange
    end
    object CBEntrata: TComboBox
      Left = 64
      Top = 56
      Width = 89
      Height = 21
      ItemHeight = 13
      TabOrder = 1
      Text = 'Rettangolare'
      OnChange = CBEntrataChange
      Items.Strings = (
        'Rettangolare'
        'Circolare')
    end
    object CBNUSCITE: TComboBox
      Left = 64
      Top = 8
      Width = 89
      Height = 21
      ItemHeight = 13
      TabOrder = 2
      Text = '2'
      OnChange = CBNUSCITEChange
      Items.Strings = (
        '0'
        '1'
        '2'
        '3')
    end
    object CBTipo: TComboBox
      Left = 64
      Top = 32
      Width = 89
      Height = 21
      ItemHeight = 13
      TabOrder = 3
      Text = 'TUTTO'
      OnChange = CBNUSCITEChange
      Items.Strings = (
        'CURVA'
        'RIDUZIONE'
        'ULTIMA DERIVAZIONE'
        'TUTTO')
    end
    object Panel3: TPanel
      Left = 1
      Top = 339
      Width = 183
      Height = 168
      Align = alBottom
      TabOrder = 4
      object Image1: TImage
        Left = 0
        Top = 0
        Width = 185
        Height = 169
      end
    end
    object CBUscita1: TComboBox
      Left = 64
      Top = 80
      Width = 89
      Height = 21
      ItemHeight = 13
      TabOrder = 5
      Text = 'Rettangolare'
      OnChange = CBUscita1Change
      Items.Strings = (
        'Rettangolare'
        'Circolare')
    end
    object CBUscita2: TComboBox
      Left = 64
      Top = 104
      Width = 89
      Height = 21
      ItemHeight = 13
      TabOrder = 6
      Text = 'Circolare'
      OnChange = CBUscita1Change
      Items.Strings = (
        'Rettangolare'
        'Circolare')
    end
    object GBVarie: TGroupBox
      Left = 0
      Top = 200
      Width = 185
      Height = 57
      Caption = 'Varie'
      TabOrder = 7
      object LDescrpezzo: TLabel
        Left = 3
        Top = 44
        Width = 55
        Height = 13
        Caption = 'Descrizione'
      end
      object Label11: TLabel
        Left = 8
        Top = 20
        Width = 63
        Height = 13
        Caption = 'Orientamento'
      end
      object LCod2: TLabel
        Left = 8
        Top = 60
        Width = 39
        Height = 13
        Caption = 'Codice2'
      end
      object Cborient: TComboBox
        Left = 80
        Top = 12
        Width = 33
        Height = 21
        ItemHeight = 13
        TabOrder = 0
        Text = '1'
        OnChange = CborientChange
        Items.Strings = (
          '1'
          '2'
          '3'
          '4'
          '5'
          '6')
      end
    end
    object CBFlusso: TComboBox
      Left = 64
      Top = 128
      Width = 89
      Height = 21
      ItemHeight = 13
      TabOrder = 8
      Text = 'Qualsiasi'
      OnChange = CBUscita1Change
      Items.Strings = (
        'Mandata'
        'Ripresa'
        'Qualsiasi')
    end
  end
  object GLScene1: TGLScene
    Left = 24
    Top = 8
    object DCGlobale: TDummyCube
      Direction.Coordinates = {00000000000000800000803F00000000}
      CubeSize = 1
      object DCGenerale: TDummyCube
        Direction.Coordinates = {824A899D0000803F080251B400000000}
        Up.Coordinates = {2EBDBB33080251340000803F00000000}
        CubeSize = 1
        BehavioursData = {0201060B54474C4D6F76656D656E74020008}
        object DCVista: TDummyCube
          CubeSize = 1
          object Cube1: TCube
            Direction.Coordinates = {F304353FFFFFFF3E0000003F00000000}
            Up.Coordinates = {000000BF7A825A3F19F615BE00000000}
            Visible = False
            Material.FrontProperties.Emission.Color = {E7E6E63EE5E4643E000000000000803F}
          end
        end
        object DCOggetti: TDummyCube
          CubeSize = 1
          object DCLuci: TDummyCube
            Direction.Coordinates = {000000002EBDBBB3000080BF00000000}
            Up.Coordinates = {00000000000080BF2EBDBB3300000000}
            CubeSize = 1
            object Sphere1: TSphere
              Position.Coordinates = {000000000000803F0000803F0000803F}
              Scale.Coordinates = {CDCCCC3DCDCCCC3DCDCCCC3D00000000}
              Visible = False
              Material.FrontProperties.Ambient.Color = {0000000000000000000000000000803F}
              Material.FrontProperties.Diffuse.Color = {0000000000000000000000000000803F}
              Material.FrontProperties.Emission.Color = {0000803F0000803F0000803F0000803F}
              Radius = 0.5
              object Disk1: TDisk
                OuterRadius = 0.5
                SweepAngle = 360
              end
              object Cylinder1: TCylinder
                BottomRadius = 0.5
                Height = 1
                TopRadius = 0.5
              end
            end
          end
          object DcParticles: TDummyCube
            CubeSize = 1
          end
          object Cube2: TCube
            Direction.Coordinates = {F304353FFFFFFF3E0000003F00000000}
            Up.Coordinates = {000000BF7A825A3F19F615BE00000000}
            Visible = False
            Material.FrontProperties.Ambient.Color = {BFBEBE3E9F9E1E3F9392923E0000803F}
            Material.FrontProperties.Diffuse.Color = {DFDEDE3EEBEAEA3EF7F6F63ECDCC2C3F}
            Material.FrontProperties.Emission.Color = {CFCECE3EE3E2E23EEBEAEA3E0000803F}
            Material.FrontProperties.Specular.Color = {00000000000000000000000046B6733F}
            Material.BlendingMode = bmTransparency
          end
        end
      end
    end
    object GLCamera1: TGLCamera
      DepthOfView = 100
      FocalLength = 100
      TargetObject = DCVista
      Position.Coordinates = {00000000000040400000A0C00000803F}
      Up.Coordinates = {000000800000803F0000000000000000}
      object GLLightSource1: TGLLightSource
        ConstAttenuation = 1
        SpotCutOff = 180
      end
    end
  end
end
