object FGestForm: TFGestForm
  Left = 466
  Top = 113
  BorderStyle = bsDialog
  Caption = 'FGestForm'
  ClientHeight = 593
  ClientWidth = 956
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Panel6: TPanel
    Left = 0
    Top = 559
    Width = 956
    Height = 34
    Align = alBottom
    BevelInner = bvLowered
    TabOrder = 0
    object Button2: TLbSpeedButton
      Left = 464
      Top = 6
      Width = 80
      Height = 23
      Hint = 'Modifica l'#39'elemento selezionato'
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
      OnClick = Button2Click
    end
    object Button3: TLbSpeedButton
      Left = 545
      Top = 6
      Width = 80
      Height = 23
      Hint = 'Cancella l'#39'elemento selezionato'
      Alignment = taCenter
      Caption = 'Cancella'
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
      OnClick = Button3Click
    end
    object LbSpeedButton1: TLbSpeedButton
      Left = 2
      Top = 7
      Width = 80
      Height = 23
      Hint = 'Cancella l'#39'elemento selezionato'
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
    object Button4: TLbSpeedButton
      Left = 193
      Top = 8
      Width = 80
      Height = 23
      Hint = 'Crea un nuovo elemento '
      Alignment = taCenter
      Caption = 'Aggiungi'
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
      OnClick = Button4Click
    end
    object Binserisci: TLbSpeedButton
      Left = 111
      Top = 8
      Width = 80
      Height = 23
      Hint = 'Crea un nuovo elemento '
      Alignment = taCenter
      Caption = 'Inserisci'
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
      OnClick = BinserisciClick
    end
    object Label4: TLabel
      Left = 280
      Top = 12
      Width = 33
      Height = 13
      Caption = 'Codice'
    end
    object LbSpeedButton2: TLbSpeedButton
      Left = 628
      Top = 7
      Width = 90
      Height = 23
      Hint = 'Cancella l'#39'elemento selezionato'
      Alignment = taCenter
      Caption = 'Salva in archivio'
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
      OnClick = LbSpeedButton2Click
    end
    object LbSpeedButton3: TLbSpeedButton
      Left = 721
      Top = 7
      Width = 105
      Height = 23
      Hint = 'Cancella l'#39'elemento selezionato'
      Alignment = taCenter
      Caption = 'Inporta dall'#39'archivio'
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
      OnClick = LbSpeedButton3Click
    end
    object Edit1: TEdit
      Left = 328
      Top = 6
      Width = 121
      Height = 21
      TabOrder = 0
    end
  end
  object DBGrid1: TDBGrid
    Left = 0
    Top = 0
    Width = 217
    Height = 559
    Align = alLeft
    ReadOnly = True
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    OnCellClick = DBGrid1CellClick
    OnDrawColumnCell = DBGrid1DrawColumnCell
  end
  object Panel1: TPanel
    Left = 217
    Top = 0
    Width = 739
    Height = 559
    Align = alClient
    Caption = 'Panel1'
    TabOrder = 2
    object Panel2: TPanel
      Left = 1
      Top = 1
      Width = 737
      Height = 26
      Align = alTop
      Caption = 'Panel2'
      TabOrder = 1
    end
    object PageControl1: TPageControl
      Left = 1
      Top = 27
      Width = 737
      Height = 531
      Align = alClient
      TabOrder = 2
    end
    object GroupBox2: TGroupBox
      Left = 0
      Top = 0
      Width = 553
      Height = 48
      Caption = 'Dettaglio dell'#39'elemento selezionato'
      TabOrder = 0
      object Label2: TLabel
        Left = 192
        Top = 23
        Width = 55
        Height = 13
        Caption = 'Descrizione'
      end
      object Label1: TLabel
        Left = 8
        Top = 23
        Width = 33
        Height = 13
        Caption = 'Codice'
      end
      object DBEdit1: TDBEdit
        Left = 256
        Top = 19
        Width = 353
        Height = 21
        TabOrder = 0
      end
      object DBEdit2: TDBEdit
        Left = 48
        Top = 19
        Width = 137
        Height = 21
        TabOrder = 1
      end
    end
  end
end
