object Fcontrolla3d: TFcontrolla3d
  Left = 554
  Top = 176
  BorderStyle = bsDialog
  Caption = 'Controllo degli elaborati ed esecuzione dei calcoli'
  ClientHeight = 409
  ClientWidth = 748
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  object PageControl1: TPageControl
    Left = 0
    Top = 0
    Width = 748
    Height = 381
    ActivePage = TabSheet1
    Align = alClient
    TabIndex = 0
    TabOrder = 0
    object TabSheet1: TTabSheet
      Caption = 'Edificio'
      object Panel2: TPanel
        Left = 0
        Top = 323
        Width = 740
        Height = 30
        Align = alBottom
        TabOrder = 0
        object LbSpeedButton2: TLbSpeedButton
          Left = 2
          Top = 3
          Width = 287
          Height = 23
          Hint = 'Cancella l'#39'elemento selezionato'
          Alignment = taCenter
          Caption = 'Calcolo dispersioni invernali , consumi e verifiche di legge'
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
      end
      object Memo1: TMemo
        Left = 0
        Top = 0
        Width = 740
        Height = 323
        Align = alClient
        Lines.Strings = (
          '')
        ReadOnly = True
        TabOrder = 1
      end
    end
    object TabSheet2: TTabSheet
      Caption = 'Reti'
      ImageIndex = 1
      object Panel3: TPanel
        Left = 0
        Top = 312
        Width = 740
        Height = 41
        Align = alBottom
        TabOrder = 0
      end
      object Memo2: TMemo
        Left = 0
        Top = 0
        Width = 740
        Height = 312
        Align = alClient
        Lines.Strings = (
          'Memo2')
        TabOrder = 1
      end
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 381
    Width = 748
    Height = 28
    Align = alBottom
    TabOrder = 1
    object LbSpeedButton1: TLbSpeedButton
      Left = 2
      Top = 3
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
    object LbSpeedButton3: TLbSpeedButton
      Left = 87
      Top = 3
      Width = 90
      Height = 23
      Hint = 'Cancella l'#39'elemento selezionato'
      Alignment = taCenter
      Caption = 'Crea relazioni'
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
end
