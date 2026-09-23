object FSecondario: TFSecondario
  Left = 459
  Top = 227
  Width = 804
  Height = 480
  Caption = 
    'Projectbrowser : visualizzatore tridimensionale su schermo secon' +
    'dario'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  OnCreate = FormCreate
  OnMouseWheelDown = FormMouseWheelDown
  OnMouseWheelUp = FormMouseWheelUp
  PixelsPerInch = 96
  TextHeight = 13
  object GLSceneViewer1: TGLSceneViewer
    Left = 0
    Top = 0
    Width = 796
    Height = 446
    Buffer.BackgroundColor = clBlack
    Align = alClient
    OnDblClick = GLSceneViewer1DblClick
    OnMouseDown = GLSceneViewer1MouseDown
    OnMouseMove = GLSceneViewer1MouseMove
  end
  object GBsetting: TGroupBox
    Left = 256
    Top = 136
    Width = 209
    Height = 185
    Caption = 'Configurazione del visualizzatore'
    TabOrder = 1
    Visible = False
    object Button1: TButton
      Left = 6
      Top = 155
      Width = 75
      Height = 25
      Caption = 'Chiudi'
      TabOrder = 0
      OnClick = Button1Click
    end
    object RadioGroup1: TRadioGroup
      Left = 16
      Top = 24
      Width = 185
      Height = 121
      Caption = 'Visualizza come scheletro'
      TabOrder = 1
    end
    object RbNulla: TRadioButton
      Left = 24
      Top = 48
      Width = 113
      Height = 17
      Caption = 'Nulla'
      Checked = True
      TabOrder = 2
      TabStop = True
      OnClick = RbNullaClick
    end
    object RBTutto: TRadioButton
      Left = 24
      Top = 72
      Width = 113
      Height = 17
      Caption = 'Tutto'
      TabOrder = 3
      OnClick = RbNullaClick
    end
    object RBPiano: TRadioButton
      Left = 24
      Top = 96
      Width = 169
      Height = 17
      Caption = 'Tutto tranne il piano selezionato in 2D'
      TabOrder = 4
      OnClick = RbNullaClick
    end
    object RBLoc: TRadioButton
      Left = 24
      Top = 120
      Width = 169
      Height = 17
      Caption = 'Tutto tranne Il locale selezionato'
      TabOrder = 5
      OnClick = RbNullaClick
    end
  end
end
