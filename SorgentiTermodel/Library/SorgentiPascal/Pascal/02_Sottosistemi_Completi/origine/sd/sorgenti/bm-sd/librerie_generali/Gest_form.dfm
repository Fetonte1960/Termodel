object FGestForm: TFGestForm
  Left = 466
  Top = 137
  BorderStyle = bsDialog
  Caption = 'FGestForm'
  ClientHeight = 593
  ClientWidth = 884
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
  object Label3: TLabel
    Left = 328
    Top = 104
    Width = 330
    Height = 13
    Caption = 'Per inserire una riga digitare il codice nel campo in basso,'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label5: TLabel
    Left = 328
    Top = 88
    Width = 107
    Height = 13
    Caption = 'L'#39'archivio '#232' vuoto:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label6: TLabel
    Left = 328
    Top = 120
    Width = 144
    Height = 13
    Caption = 'premere il tasto aggiungi.'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Panel6: TPanel
    Left = 0
    Top = 559
    Width = 884
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
      Width = 109
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
      Left = 1137
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
    object LbSpeedButton4: TLbSpeedButton
      Left = 918
      Top = 6
      Width = 99
      Height = 23
      Hint = 'Cancella l'#39'elemento selezionato'
      Alignment = taCenter
      Caption = 'Percorso archivi'
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
      OnClick = LbSpeedButton4Click
    end
    object Edit1: TEdit
      Left = 328
      Top = 6
      Width = 121
      Height = 21
      TabOrder = 0
    end
    object RadioButton1: TRadioButton
      Left = 744
      Top = 8
      Width = 113
      Height = 17
      Caption = 'Progetto'
      Checked = True
      TabOrder = 1
      TabStop = True
      Visible = False
      OnClick = RadioButton1Click
    end
    object RadioButton2: TRadioButton
      Left = 808
      Top = 8
      Width = 81
      Height = 17
      Caption = 'Archivio'
      TabOrder = 2
      Visible = False
      OnClick = RadioButton1Click
    end
  end
  object Panel1: TPanel
    Left = 233
    Top = 0
    Width = 651
    Height = 559
    Align = alClient
    Caption = 'Panel1'
    TabOrder = 1
    object Panel2: TPanel
      Left = 1
      Top = 1
      Width = 649
      Height = 26
      Align = alTop
      Caption = 'Panel2'
      TabOrder = 1
    end
    object PageControl1: TPageControl
      Left = 1
      Top = 27
      Width = 649
      Height = 531
      Align = alClient
      TabOrder = 2
    end
    object GroupBox2: TGroupBox
      Left = 1
      Top = 1
      Width = 928
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
  object Panel3: TPanel
    Left = 0
    Top = 0
    Width = 233
    Height = 559
    Align = alLeft
    TabOrder = 2
    object DBGrid1: TDBGrid
      Left = 1
      Top = 1
      Width = 231
      Height = 391
      Align = alClient
      ReadOnly = True
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'MS Sans Serif'
      TitleFont.Style = []
      OnCellClick = DBGrid1CellClick
      OnDrawColumnCell = DBGrid1DrawColumnCell
    end
    object Panel5: TPanel
      Left = 1
      Top = 392
      Width = 231
      Height = 166
      Align = alBottom
      TabOrder = 1
      Visible = False
      object Panel4: TPanel
        Left = 1
        Top = 1
        Width = 229
        Height = 56
        Align = alTop
        TabOrder = 0
        object Label7: TLabel
          Left = 8
          Top = 14
          Width = 76
          Height = 13
          Caption = 'Percorso archivi'
        end
        object LbSpeedButton5: TLbSpeedButton
          Left = 130
          Top = 7
          Width = 80
          Height = 23
          Hint = 'Cancella l'#39'elemento selezionato'
          Alignment = taCenter
          Caption = 'Imposta'
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
        end
        object Label8: TLabel
          Left = 8
          Top = 32
          Width = 32
          Height = 13
          Caption = 'Label8'
        end
      end
      object DirectoryListBox1: TDirectoryListBox
        Left = 1
        Top = 57
        Width = 229
        Height = 108
        Align = alClient
        ItemHeight = 16
        TabOrder = 1
      end
    end
  end
end
