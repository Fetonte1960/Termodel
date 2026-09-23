object WizardFSoloMuri: TWizardFSoloMuri
  Left = 462
  Top = 164
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'Pareti'
  ClientHeight = 635
  ClientWidth = 959
  Color = clBtnFace
  Constraints.MaxHeight = 700
  Constraints.MaxWidth = 1000
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Arial'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnActivate = FormActivate
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 14
  object Shape4: TShape
    Left = 352
    Top = 22
    Width = 25
    Height = 1
    Brush.Color = clRed
    Pen.Color = clRed
    Pen.Width = 5
  end
  object Label16: TLabel
    Left = 384
    Top = 16
    Width = 26
    Height = 14
    Caption = 'temp.'
    Color = clNone
    ParentColor = False
  end
  object Panel2: TPanel
    Left = 0
    Top = 0
    Width = 959
    Height = 69
    Align = alTop
    Color = clWhite
    TabOrder = 0
    object Label83: TLabel
      Left = 4
      Top = 0
      Width = 974
      Height = 19
      AutoSize = False
      Caption = 'Benvenuto nel Wizard per la definizione '
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -16
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label84: TLabel
      Left = 16
      Top = 26
      Width = 952
      Height = 16
      AutoSize = False
      Caption = 'Procedura automatica per la definizione del tipo '
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 69
    Width = 178
    Height = 547
    Align = alLeft
    Color = 10485760
    TabOrder = 1
    object Label85: TLabel
      Left = 1
      Top = 1
      Width = 176
      Height = 14
      Align = alTop
      Alignment = taCenter
      AutoSize = False
      Caption = 'Sequenza Operazioni'
      Color = clSilver
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentColor = False
      ParentFont = False
    end
    object TreeView1: TTreeView
      Left = 1
      Top = 15
      Width = 176
      Height = 178
      Align = alTop
      Color = 10485760
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      HideSelection = False
      Indent = 19
      ParentFont = False
      ReadOnly = True
      RowSelect = True
      TabOrder = 0
      OnClick = TreeView1Click
    end
  end
  object Panel7: TPanel
    Left = 178
    Top = 69
    Width = 781
    Height = 547
    Align = alClient
    Caption = 'Panel7'
    TabOrder = 2
    object Tabfinestre: TPageControl
      Left = 1
      Top = 1
      Width = 779
      Height = 503
      ActivePage = TabSheetDefinizione
      Align = alClient
      Style = tsButtons
      TabIndex = 0
      TabOrder = 0
      OnChange = TabfinestreChange
      object TabSheetDefinizione: TTabSheet
        Caption = 'Definizione'
        object GroupBox17: TGroupBox
          Left = 7
          Top = 317
          Width = 329
          Height = 154
          Caption = ' Generali '
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clHotLight
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 3
          Visible = False
          object Label72: TLabel
            Left = 9
            Top = 16
            Width = 78
            Height = 14
            Caption = 'Superficie totale'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
          end
          object Label73: TLabel
            Left = 192
            Top = 16
            Width = 18
            Height = 14
            Caption = '[m'#178']'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
          end
          object Label75: TLabel
            Left = 9
            Top = 39
            Width = 91
            Height = 14
            Caption = 'Trasmittanza totale'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
          end
          object Label155: TLabel
            Left = 192
            Top = 39
            Width = 42
            Height = 14
            Caption = '[W/m'#178#176'C]'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
          end
          object Label156: TLabel
            Left = 9
            Top = 96
            Width = 116
            Height = 14
            AutoSize = False
            Caption = 'Posizione dello schermo'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
          end
          object Label157: TLabel
            Left = 9
            Top = 68
            Width = 147
            Height = 14
            AutoSize = False
            Caption = 'Attenuazione solare (Shading)'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
          end
          object Label158: TLabel
            Left = 212
            Top = 68
            Width = 24
            Height = 14
            AutoSize = False
            Caption = '[0..1]'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
          end
          object Label159: TLabel
            Left = 9
            Top = 127
            Width = 116
            Height = 14
            AutoSize = False
            Caption = 'Incremento di Sicurezza'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
          end
          object Label160: TLabel
            Left = 231
            Top = 127
            Width = 21
            Height = 14
            AutoSize = False
            Caption = '>= 1'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
          end
          object DBEdit33: TDBEdit
            Tag = 14
            Left = 125
            Top = 16
            Width = 64
            Height = 22
            BevelKind = bkFlat
            BorderStyle = bsNone
            Color = clWhite
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            TabOrder = 0
          end
          object DBEdit66: TDBEdit
            Tag = 13
            Left = 125
            Top = 39
            Width = 64
            Height = 22
            BevelKind = bkFlat
            BorderStyle = bsNone
            Color = clWhite
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            TabOrder = 1
          end
          object DBComboBox10: TDBComboBox
            Tag = 16
            Left = 161
            Top = 92
            Width = 132
            Height = 22
            Style = csDropDownList
            BevelKind = bkFlat
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ItemHeight = 14
            ParentFont = False
            TabOrder = 2
          end
          object DBEdit67: TDBEdit
            Tag = 17
            Left = 163
            Top = 64
            Width = 41
            Height = 22
            BevelKind = bkFlat
            BorderStyle = bsNone
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            TabOrder = 3
          end
          object DBEdit68: TDBEdit
            Tag = 42
            Left = 160
            Top = 119
            Width = 49
            Height = 22
            BevelKind = bkFlat
            BorderStyle = bsNone
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            TabOrder = 4
          end
          object SpinButton2: TSpinButton
            Left = 210
            Top = 119
            Width = 20
            Height = 22
            DownGlyph.Data = {
              56000000424D56000000000000003E0000002800000006000000060000000100
              010000000000180000000000000000000000020000000200000000000000FFFF
              FF00CC0000008400000000000000CC000000CC000000CC000000}
            FocusControl = DBEdit68
            TabOrder = 5
            UpGlyph.Data = {
              56000000424D56000000000000003E0000002800000006000000060000000100
              010000000000180000000000000000000000020000000200000000000000FFFF
              FF00CC000000CC000000CC0000000000000084000000CC000000}
            OnDownClick = RxSpinButton1DownClick
            OnUpClick = RxSpinButton1UpClick
          end
        end
        object GroupBox5: TGroupBox
          Left = 3
          Top = 114
          Width = 734
          Height = 356
          Caption = ' Calcolo delle adduttanze e Verifica della condenza '
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clHotLight
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 1
          object Label9: TLabel
            Left = 422
            Top = 35
            Width = 92
            Height = 14
            Caption = 'Adduttanza interna'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
          end
          object Label10: TLabel
            Left = 422
            Top = 108
            Width = 144
            Height = 14
            Caption = 'Adduttanza esterna Legge 10'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
          end
          object Label11: TLabel
            Left = 16
            Top = 159
            Width = 97
            Height = 14
            Caption = 'Temperature interna'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
          end
          object Label12: TLabel
            Left = 16
            Top = 182
            Width = 92
            Height = 14
            Caption = 'Um. relativa Interna'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
          end
          object Label13: TLabel
            Left = 16
            Top = 206
            Width = 101
            Height = 14
            Caption = 'Temperatura esterna'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
          end
          object Label14: TLabel
            Left = 16
            Top = 230
            Width = 96
            Height = 14
            Caption = 'Um. relativa esterna'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
          end
          object Label132: TLabel
            Left = 9
            Top = 35
            Width = 86
            Height = 14
            Caption = 'Velocit'#224' del vento'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
          end
          object Label133: TLabel
            Left = 9
            Top = 83
            Width = 132
            Height = 14
            Caption = 'Classificazione della parete'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
          end
          object Label134: TLabel
            Left = 9
            Top = 255
            Width = 177
            Height = 14
            Caption = 'Classe di umidit'#224' interna (ISO 13788)'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
          end
          object Label135: TLabel
            Left = 9
            Top = 302
            Width = 90
            Height = 14
            Caption = 'Colore della parete'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
          end
          object Label136: TLabel
            Left = 422
            Top = 59
            Width = 143
            Height = 14
            Caption = 'Adduttanza interna  Legge 10'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
          end
          object Label137: TLabel
            Left = 422
            Top = 83
            Width = 96
            Height = 14
            Caption = 'Adduttanza esterna'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
          end
          object Label138: TLabel
            Left = 9
            Top = 108
            Width = 34
            Height = 14
            Caption = 'Epsilon'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            Visible = False
          end
          object Label139: TLabel
            Left = 9
            Top = 330
            Width = 95
            Height = 14
            Caption = 'Stampa della parete'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
          end
          object Label140: TLabel
            Left = 17
            Top = 15
            Width = 134
            Height = 14
            Caption = 'Calcolo delle adduttanze'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object Label141: TLabel
            Left = 9
            Top = 126
            Width = 128
            Height = 14
            Caption = 'Verifica della condensa'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object Label142: TLabel
            Left = 250
            Top = 159
            Width = 97
            Height = 14
            Caption = 'Temperature interna'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
          end
          object Label143: TLabel
            Left = 250
            Top = 182
            Width = 92
            Height = 14
            Caption = 'Um. relativa Interna'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
          end
          object Label144: TLabel
            Left = 250
            Top = 206
            Width = 101
            Height = 14
            Caption = 'Temperatura esterna'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
          end
          object Label145: TLabel
            Left = 250
            Top = 230
            Width = 96
            Height = 14
            Caption = 'Um. relativa esterna'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
          end
          object Label146: TLabel
            Left = 253
            Top = 143
            Width = 34
            Height = 14
            Caption = 'Estate'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object Label147: TLabel
            Left = 16
            Top = 143
            Width = 42
            Height = 14
            Caption = 'Inverno'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object Label92: TLabel
            Left = 166
            Top = 159
            Width = 17
            Height = 14
            Caption = '['#176'C]'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
          end
          object Label93: TLabel
            Left = 166
            Top = 182
            Width = 16
            Height = 14
            Caption = '[%]'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
          end
          object Label94: TLabel
            Left = 166
            Top = 206
            Width = 17
            Height = 14
            Caption = '['#176'C]'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
          end
          object Label95: TLabel
            Left = 166
            Top = 230
            Width = 16
            Height = 14
            Caption = '[%]'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
          end
          object Label97: TLabel
            Left = 398
            Top = 159
            Width = 17
            Height = 14
            Caption = '['#176'C]'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
          end
          object Label99: TLabel
            Left = 398
            Top = 182
            Width = 16
            Height = 14
            Caption = '[%]'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
          end
          object Label100: TLabel
            Left = 398
            Top = 206
            Width = 17
            Height = 14
            Caption = '['#176'C]'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
          end
          object Label148: TLabel
            Left = 398
            Top = 230
            Width = 16
            Height = 14
            Caption = '[%]'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
          end
          object Label149: TLabel
            Left = 624
            Top = 35
            Width = 42
            Height = 14
            Caption = '[W/m'#178#176'C]'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
          end
          object Label150: TLabel
            Left = 624
            Top = 59
            Width = 42
            Height = 14
            Caption = '[W/m'#178#176'C]'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
          end
          object Label151: TLabel
            Left = 624
            Top = 83
            Width = 42
            Height = 14
            Caption = '[W/m'#178#176'C]'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
          end
          object Label152: TLabel
            Left = 624
            Top = 108
            Width = 42
            Height = 14
            Caption = '[W/m'#178#176'C]'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
          end
          object Label168: TLabel
            Left = 9
            Top = 59
            Width = 42
            Height = 14
            Caption = 'Tipologia'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
          end
          object Label1: TLabel
            Left = 225
            Top = 35
            Width = 23
            Height = 14
            Caption = '[m/s]'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
          end
          object LB_TipoDiv: TLabel
            Left = 376
            Top = 274
            Width = 63
            Height = 14
            Caption = 'Tipo divisorio'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
          end
          object DBEdit7: TDBEdit
            Tag = 1
            Left = 570
            Top = 31
            Width = 50
            Height = 22
            BevelKind = bkFlat
            BorderStyle = bsNone
            Color = cl3DLight
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            ReadOnly = True
            TabOrder = 5
            OnKeyPress = DBEdit7KeyPress
          end
          object DBEdit8: TDBEdit
            Tag = 18
            Left = 570
            Top = 104
            Width = 50
            Height = 22
            BevelKind = bkFlat
            BorderStyle = bsNone
            Color = cl3DLight
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            ReadOnly = True
            TabOrder = 8
            OnKeyPress = DBEdit7KeyPress
          end
          object DBEdit9: TDBEdit
            Tag = 3
            Left = 122
            Top = 155
            Width = 41
            Height = 22
            BevelKind = bkFlat
            BorderStyle = bsNone
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            TabOrder = 9
            OnKeyPress = DBEdit7KeyPress
          end
          object DBEdit10: TDBEdit
            Tag = 4
            Left = 122
            Top = 178
            Width = 41
            Height = 22
            BevelKind = bkFlat
            BorderStyle = bsNone
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            TabOrder = 10
            OnKeyPress = DBEdit7KeyPress
          end
          object DBEdit11: TDBEdit
            Tag = 5
            Left = 122
            Top = 202
            Width = 41
            Height = 22
            BevelKind = bkFlat
            BorderStyle = bsNone
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            TabOrder = 11
            OnKeyPress = DBEdit7KeyPress
          end
          object DBEdit12: TDBEdit
            Tag = 6
            Left = 122
            Top = 226
            Width = 41
            Height = 22
            BevelKind = bkFlat
            BorderStyle = bsNone
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            TabOrder = 12
            OnKeyPress = DBEdit7KeyPress
          end
          object DBEdit58: TDBEdit
            Tag = 15
            Left = 154
            Top = 31
            Width = 40
            Height = 22
            BevelKind = bkFlat
            BorderStyle = bsNone
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            TabOrder = 0
            OnChange = DBComboBox13Change
            OnKeyPress = DBEdit7KeyPress
          end
          object DBComboBox3: TDBComboBox
            Tag = 32
            Left = 154
            Top = 55
            Width = 220
            Height = 22
            Style = csDropDownList
            BevelKind = bkFlat
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ItemHeight = 14
            ParentFont = False
            TabOrder = 2
            OnChange = DBComboBox3Change
            OnKeyPress = DBComboBox3KeyPress
          end
          object DBComboBox13: TDBComboBox
            Tag = 33
            Left = 154
            Top = 79
            Width = 220
            Height = 22
            Style = csDropDownList
            BevelKind = bkFlat
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ItemHeight = 14
            ParentFont = False
            TabOrder = 3
            OnChange = DBComboBox13Change
            OnKeyPress = DBComboBox3KeyPress
          end
          object DBComboBox14: TDBComboBox
            Tag = 22
            Left = 9
            Top = 271
            Width = 343
            Height = 22
            Style = csDropDownList
            BevelKind = bkFlat
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ItemHeight = 14
            ParentFont = False
            TabOrder = 17
            OnChange = DBComboBox14Change
            OnKeyPress = DBComboBox3KeyPress
          end
          object DBComboBox15: TDBComboBox
            Tag = 14
            Left = 112
            Top = 298
            Width = 240
            Height = 22
            Style = csDropDownList
            BevelKind = bkFlat
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ItemHeight = 14
            ParentFont = False
            TabOrder = 18
            OnChange = DBComboBox15Change
            OnKeyPress = DBComboBox3KeyPress
          end
          object DBEdit59: TDBEdit
            Tag = 17
            Left = 570
            Top = 55
            Width = 50
            Height = 22
            BevelKind = bkFlat
            BorderStyle = bsNone
            Color = cl3DLight
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            ReadOnly = True
            TabOrder = 6
            OnKeyPress = DBEdit7KeyPress
          end
          object DBEdit60: TDBEdit
            Tag = 2
            Left = 570
            Top = 79
            Width = 50
            Height = 22
            BevelKind = bkFlat
            BorderStyle = bsNone
            Color = cl3DLight
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            ReadOnly = True
            TabOrder = 7
            OnKeyPress = DBEdit7KeyPress
          end
          object DBEdit61: TDBEdit
            Tag = 16
            Left = 155
            Top = 104
            Width = 40
            Height = 22
            BevelKind = bkFlat
            BorderStyle = bsNone
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            TabOrder = 4
            Visible = False
            OnChange = DBComboBox13Change
            OnKeyPress = DBEdit7KeyPress
          end
          object DBComboBox16: TDBComboBox
            Tag = 20
            Left = 112
            Top = 326
            Width = 240
            Height = 22
            Style = csDropDownList
            BevelKind = bkFlat
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ItemHeight = 14
            ParentFont = False
            TabOrder = 19
            OnChange = DBComboBox16Change
            OnKeyPress = DBComboBox3KeyPress
          end
          object DBEdit62: TDBEdit
            Tag = 30
            Left = 355
            Top = 155
            Width = 41
            Height = 22
            BevelKind = bkFlat
            BorderStyle = bsNone
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            TabOrder = 13
            OnKeyPress = DBEdit7KeyPress
          end
          object DBEdit63: TDBEdit
            Tag = 34
            Left = 355
            Top = 178
            Width = 41
            Height = 22
            BevelKind = bkFlat
            BorderStyle = bsNone
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            TabOrder = 14
            OnKeyPress = DBEdit7KeyPress
          end
          object DBEdit64: TDBEdit
            Tag = 31
            Left = 355
            Top = 202
            Width = 41
            Height = 22
            BevelKind = bkFlat
            BorderStyle = bsNone
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            TabOrder = 15
            OnKeyPress = DBEdit7KeyPress
          end
          object DBEdit65: TDBEdit
            Tag = 35
            Left = 355
            Top = 226
            Width = 41
            Height = 22
            BevelKind = bkFlat
            BorderStyle = bsNone
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            TabOrder = 16
            OnKeyPress = DBEdit7KeyPress
          end
          object SpinButton1: TSpinButton
            Left = 195
            Top = 31
            Width = 20
            Height = 22
            DownGlyph.Data = {
              56000000424D56000000000000003E0000002800000006000000060000000100
              010000000000180000000000000000000000020000000200000000000000FFFF
              FF00CC0000008400000000000000CC000000CC000000CC000000}
            FocusControl = DBEdit58
            TabOrder = 1
            UpGlyph.Data = {
              56000000424D56000000000000003E0000002800000006000000060000000100
              010000000000180000000000000000000000020000000200000000000000FFFF
              FF00CC000000CC000000CC0000000000000084000000CC000000}
            OnDownClick = RxSpinButton1DownClick
            OnUpClick = RxSpinButton1UpClick
          end
          object DBCombo_TipoDiv: TDBComboBox
            Tag = 36
            Left = 445
            Top = 271
            Width = 220
            Height = 22
            Style = csDropDownList
            BevelKind = bkFlat
            Ctl3D = True
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ItemHeight = 14
            ParentCtl3D = False
            ParentFont = False
            TabOrder = 20
          end
        end
        object RadioGroup1: TRadioGroup
          Left = 3
          Top = 114
          Width = 384
          Height = 90
          ItemIndex = 0
          Items.Strings = (
            'Calcolo della trasmittanza secondo UNI 10345'
            'Inserimento manuale dei dati')
          TabOrder = 2
          OnClick = RadioGroup1Click
        end
        object GroupBox8: TGroupBox
          Left = 2
          Top = 6
          Width = 384
          Height = 105
          TabOrder = 0
          object Label87: TLabel
            Left = 19
            Top = 21
            Width = 33
            Height = 14
            Caption = 'Codice'
          end
          object Label88: TLabel
            Left = 19
            Top = 47
            Width = 57
            Height = 14
            Caption = 'Descrizione'
          end
          object Label91: TLabel
            Left = 19
            Top = 73
            Width = 42
            Height = 14
            Caption = 'Tipologia'
          end
          object DBEdit36: TDBEdit
            Tag = 12
            Left = 81
            Top = 17
            Width = 55
            Height = 22
            BevelKind = bkFlat
            BorderStyle = bsNone
            MaxLength = 8
            TabOrder = 0
            OnKeyPress = DBEdit36KeyPress
          end
          object DBEdit37: TDBEdit
            Tag = 27
            Left = 81
            Top = 43
            Width = 240
            Height = 22
            BevelKind = bkFlat
            BorderStyle = bsNone
            TabOrder = 1
            OnKeyPress = DBEdit37KeyPress
          end
          object DBComboBox11: TDBComboBox
            Tag = 36
            Left = 81
            Top = 69
            Width = 240
            Height = 22
            Style = csDropDownList
            BevelKind = bkFlat
            ItemHeight = 14
            TabOrder = 2
            OnChange = DBComboBox11Change
            OnKeyPress = DBComboBox3KeyPress
          end
        end
      end
      object TabSheet3: TTabSheet
        Caption = 'Dettaglio parete'
        ImageIndex = 1
        object Image2: TImage
          Left = 8
          Top = 22
          Width = 269
          Height = 260
          Transparent = True
        end
        object Image1: TImage
          Left = 593
          Top = 39
          Width = 152
          Height = 152
        end
        object Shape1: TShape
          Left = 303
          Top = 8
          Width = 110
          Height = 57
          Brush.Color = clBlack
        end
        object Shape2: TShape
          Left = 297
          Top = 2
          Width = 113
          Height = 60
        end
        object Shape3: TShape
          Left = 304
          Top = 15
          Width = 25
          Height = 3
          Brush.Color = clRed
          Pen.Color = clRed
          Pen.Width = 5
        end
        object Label15: TLabel
          Left = 336
          Top = 9
          Width = 61
          Height = 14
          Caption = 'Temperatura'
          Color = clWhite
          ParentColor = False
        end
        object Label17: TLabel
          Left = 336
          Top = 25
          Width = 73
          Height = 14
          Caption = 'Pr. saturazione'
          Color = clWhite
          ParentColor = False
        end
        object Shape5: TShape
          Left = 304
          Top = 31
          Width = 25
          Height = 3
          Brush.Color = clBlue
          Pen.Color = clBlue
          Pen.Width = 5
        end
        object Label18: TLabel
          Left = 336
          Top = 41
          Width = 50
          Height = 14
          Caption = 'Pr. vapore'
          Color = clWhite
          ParentColor = False
        end
        object Shape6: TShape
          Left = 304
          Top = 46
          Width = 25
          Height = 3
          Brush.Color = clYellow
          Pen.Color = clLime
          Pen.Width = 5
        end
        object Label23: TLabel
          Left = 50
          Top = -2
          Width = 169
          Height = 20
          Caption = 'Diagramma di Glaser'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clHotLight
          Font.Height = -16
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label76: TLabel
          Left = 418
          Top = 3
          Width = 95
          Height = 14
          Caption = 'Ricerca materiale'
          Color = clBtnFace
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clHotLight
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentColor = False
          ParentFont = False
        end
        object Button13: TSpeedButton
          Left = 416
          Top = 446
          Width = 90
          Height = 26
          Caption = 'Cancella'
          Glyph.Data = {
            36100000424D3610000000000000360000002800000020000000200000000100
            2000000000000010000000000000000000000000000000000000E3DFE000E3DF
            E000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DF
            E000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DF
            E000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DF
            E000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DF
            E000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DF
            E000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DF
            E000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DF
            E000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DF
            E000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DF
            E000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DF
            E000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DF
            E000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DF
            E000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DF
            E000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DF
            E000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DF
            E000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DF
            E000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DF
            E000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DF
            E000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DF
            E000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DF
            E000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DF
            E000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DF
            E000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DF
            E000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DF
            E000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DF
            E000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DF
            E000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DF
            E000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DF
            E000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DF
            E000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DF
            E000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DF
            E000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE0006E6E
            6E001A1A1A002626260026262600262626002626260026262600262626002626
            2600262626002626260026262600262626002626260026262600262626002626
            2600262626002626260026262600262626001A1A1A007A7A7A00E3DFE000E3DF
            E000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE0003232
            3200F2F2F200F2F2F200F2F2F200F2F2F200F2F2F200F2F2F200DADADA00DADA
            DA00F2F2F200F2F2F200F2F2F200F2F2F200F2F2F200E6E6E600CECECE00F2F2
            F200F2F2F200F2F2F200F2F2F200F2F2F200E6E6E6003E3E3E00E3DFE000E3DF
            E000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE0003E3E
            3E00F0FBFF00F2F2F200F2F2F200F2F2F200F2F2F200FFFFFF00E6E6E600E6E6
            E600FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00F2F2F200DADADA00FFFF
            FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00E6E6E6003E3E3E00E3DFE000E3DF
            E000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE0003232
            3200F2F2F200F2F2F200F2F2F200F2F2F200F2F2F200FFFFFF00E6E6E600E6E6
            E600FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00F2F2F200DADADA00FFFF
            FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00F2F2F2003E3E3E00E3DFE000E3DF
            E000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE0003232
            3200F2F2F200F2F2F200E6E6E600F2F2F200F2F2F200F2F2F200DADADA00DADA
            DA00F2F2F200F2F2F200F2F2F200F2F2F200F2F2F200E6E6E600DADADA00F0FB
            FF00F2F2F200F2F2F200F2F2F200F0FBFF00E6E6E6003E3E3E00E3DFE000E3DF
            E000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE0003232
            3200E6E6E600CECECE00CECECE00CECECE00DADADA00DADADA00C2C2C200CECE
            CE00DADADA00DADADA00DADADA00DADADA00DADADA00DADADA00C2C2C200E6E6
            E600DADADA00DADADA00DADADA00E6E6E600CECECE003E3E3E00E3DFE000E3DF
            E000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE0003232
            3200F0FBFF00F2F2F200F2F2F200F0FBFF00F0FBFF00FFFFFF00E6E6E600E6E6
            E600FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00F2F2F200DADADA00FFFF
            FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00F2F2F2003E3E3E00E3DFE000E3DF
            E000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE0003232
            3200F2F2F200F2F2F200F2F2F200F2F2F200F2F2F200F2F2F200E6E6E600E6E6
            E600F0FBFF00F2F2F200F2F2F200F2F2F200FFFFFF00F2F2F200DADADA00FFFF
            FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00E6E6E6003E3E3E00E3DFE000E3DF
            E000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE0003232
            3200F0FBFF00F2F2F200F2F2F200F2F2F200F2F2F200F2F2F200E6E6E600E6E6
            E600F0FBFF00F2F2F200F0FBFF00F0FBFF00FFFFFF00F2F2F200DADADA00FFFF
            FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00F2F2F2003E3E3E00E3DFE000E3DF
            E000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE0003232
            3200F2F2F200CECECE00CECECE00CECECE00CECECE00DADADA00C2C2C200C2C2
            C200DADADA00DADADA00DADADA00DADADA00DADADA00CECECE00C2C2C200DADA
            DA00DADADA00DADADA00DADADA00E6E6E600CECECE003E3E3E00E3DFE000E3DF
            E000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE0003232
            3200F2F2F200E6E6E600E6E6E600F2F2F200F2F2F200F2F2F200DADADA00DADA
            DA00F2F2F200F2F2F200F2F2F200F2F2F200F2F2F200E6E6E600DADADA00F2F2
            F200F2F2F200F2F2F200F2F2F200F0FBFF00E6E6E6003E3E3E00E3DFE000E3DF
            E000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE0003232
            3200F0FBFF00F2F2F200F2F2F200F2F2F200F2F2F200F2F2F200DADADA00E6E6
            E600F0FBFF00F2F2F200F2F2F200F2F2F200FFFFFF00F2F2F200DADADA00FFFF
            FF00F0FBFF00FFFFFF00FFFFFF00FFFFFF00F2F2F2003E3E3E00E3DFE000E3DF
            E000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE0003E3E
            3E00FFFFFF00F2F2F200F2F2F200F2F2F200F2F2F200F2F2F200E6E6E600E6E6
            E600F0FBFF00F2F2F200F2F2F200F0FBFF00FFFFFF00F2F2F200DADADA00FFFF
            FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00F2F2F2003E3E3E00E3DFE000E3DF
            E000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE0003232
            3200F2F2F200DADADA00DADADA00DADADA00DADADA00DADADA00CECECE00CECE
            CE00E6E6E600E6E6E600E6E6E600E6E6E600E6E6E600DADADA00CECECE00E6E6
            E600E6E6E600E6E6E600E6E6E600E6E6E600DADADA003E3E3E00E3DFE000E3DF
            E000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE0003232
            3200F2F2F200DADADA00DADADA00DADADA00DADADA00DADADA00CECECE00CECE
            CE00E6E6E600DADADA00E6E6E600E6E6E600E6E6E600DADADA00C2C2C200E6E6
            E600E6E6E600E6E6E600E6E6E600E6E6E600DADADA003E3E3E00E3DFE000E3DF
            E000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE0003E3E
            3E00FFFFFF00F2F2F200F2F2F200F2F2F200F2F2F200F2F2F200DADADA00E6E6
            E600F0FBFF00F2F2F200F2F2F200F2F2F200FFFFFF00F2F2F200DADADA00FFFF
            FF00F0FBFF00FFFFFF00FFFFFF00FFFFFF00F2F2F2003E3E3E00E3DFE000E3DF
            E000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE0003232
            3200F2F2F200E6E6E600E6E6E600E6E6E600E6E6E600F2F2F200DADADA00DADA
            DA00F2F2F200F2F2F200F2F2F200F2F2F200F2F2F200E6E6E600CECECE00F2F2
            F200F2F2F200F2F2F200F2F2F200F0FBFF00F2F2F2003E3E3E00E3DFE000E3DF
            E000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE0003E3E
            3E00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00F2F2F200F2F2
            F200FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00F0FBFF00E6E6E600FFFF
            FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF003E3E3E00E3DFE000E3DF
            E000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE0003232
            32009E9E9E00A4A0A000A4A0A000A4A0A000A4A0A000A4A0A0009E9E9E009E9E
            9E009E9E9E009E9E9E009E9E9E009E9E9E009E9E9E0092929200929292009E9E
            9E009E9E9E009E9E9E00929292009E9E9E00929292004A4A4A00E3DFE000E3DF
            E000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000C0C0
            C000DC000000DC000000DC000000DC000000DC000000DC000000DC000000DC00
            0000DC000000DC000000DC000000DC000000DC000000DC000000DC000000DC00
            0000DC000000DC000000DC000000DC000000DC000000C2C2C200E3DFE000E3DF
            E000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DF
            E000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DF
            E000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DF
            E000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DF
            E000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DF
            E000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DF
            E000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DF
            E000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DF
            E000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DF
            E000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DF
            E000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DF
            E000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DF
            E000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DF
            E000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DF
            E000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DF
            E000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DF
            E000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000}
          OnClick = Button13Click
        end
        object Button14: TSpeedButton
          Left = 506
          Top = 446
          Width = 90
          Height = 26
          Caption = 'Conferma'
          Glyph.Data = {
            36100000424D3610000000000000360000002800000020000000200000000100
            2000000000000010000000000000000000000000000000000000E3DFE000E3DF
            E000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DF
            E000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DF
            E000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DF
            E000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DF
            E000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DF
            E000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DF
            E000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DF
            E000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DF
            E000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DF
            E000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DF
            E000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DF
            E000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DF
            E000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DF
            E000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DF
            E000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DF
            E000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DF
            E000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DF
            E000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DF
            E000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DF
            E000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DF
            E000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DF
            E000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DF
            E000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DF
            E000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DF
            E000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DF
            E000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DF
            E000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DF
            E000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DF
            E000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DF
            E000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DF
            E000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DF
            E000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE0006E6E
            6E001A1A1A002626260026262600262626002626260026262600262626002626
            2600262626002626260026262600262626002626260026262600262626002626
            2600262626002626260026262600262626001A1A1A007A7A7A00E3DFE000E3DF
            E000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE0003232
            3200F2F2F200F2F2F200F2F2F200F2F2F200F2F2F200F2F2F200DADADA00DADA
            DA00F2F2F200F2F2F200F2F2F200F2F2F200F2F2F200E6E6E600CECECE00F2F2
            F200F2F2F200F2F2F200F2F2F200F2F2F200E6E6E6003E3E3E00E3DFE000E3DF
            E000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE0003E3E
            3E00F0FBFF00F2F2F200F2F2F200F2F2F200F2F2F200FFFFFF00E6E6E600E6E6
            E600FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00F2F2F200DADADA00FFFF
            FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00E6E6E6003E3E3E00E3DFE000E3DF
            E000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE0003232
            3200F2F2F200F2F2F200F2F2F200F2F2F200F2F2F200FFFFFF00E6E6E600E6E6
            E600A4A0A0000000000000000000F2F2F200F2F2F200F2F2F200DADADA00FFFF
            FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00F2F2F2003E3E3E00E3DFE000E3DF
            E000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE0003232
            3200F2F2F200F2F2F200E6E6E600F2F2F200F2F2F200F2F2F200E6E6E600E6E6
            E60000000000963100005656560000000000F2F2F200E6E6E600DADADA00FFFF
            FF00FFFFFF00FFFFFF00F2F2F200F0FBFF00E6E6E6003E3E3E00E3DFE000E3DF
            E000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE0003232
            3200E6E6E600CECECE00CECECE00CECECE00DADADA00DADADA00A4A0A000CECE
            CE0000000000FF8F6B00963100000000000086868600DADADA00CECECE00F0FB
            FF00DADADA00DADADA00DADADA00E6E6E600CECECE003E3E3E00E3DFE000E3DF
            E000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE0003232
            3200F0FBFF00F2F2F200F2F2F200F0FBFF00F0FBFF00FFFFFF00E6E6E6000000
            0000FF8F6B00FF8F6B00FF8F6B005656560000000000E6E6E600DADADA00FFFF
            FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00F2F2F2003E3E3E00E3DFE000E3DF
            E000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE0003232
            3200F2F2F200F2F2F200F2F2F200F2F2F200F2F2F200F2F2F200A4A0A0000000
            0000FFAA0000FF8F6B00FF8F6B00963100000000000086868600DADADA00FFFF
            FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00E6E6E6003E3E3E00E3DFE000E3DF
            E000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE0003232
            3200F0FBFF00F2F2F200F2F2F200F2F2F200F2F2F200F2F2F20000000000FFAA
            0000FFAA0000FFAA0000FF8F6B00FF8F6B005656560000000000DADADA00FFFF
            FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00F2F2F2003E3E3E00E3DFE000E3DF
            E000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE0003232
            3200F2F2F200CECECE00CECECE00CECECE00E6E6E600A4A0A00000000000FFAA
            0000FF8F6B0000000000FFAA0000FF8F6B00963100000000000086868600DADA
            DA00DADADA00DADADA00DADADA00E6E6E600CECECE003E3E3E00E3DFE000E3DF
            E000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE0003232
            3200F2F2F200E6E6E600E6E6E600F2F2F200E6E6E60000000000FFAA0000FF8F
            6B0000000000F2F2F20000000000FFAA0000FF8F6B005656560000000000F2F2
            F200F2F2F200F2F2F200F2F2F200F0FBFF00E6E6E6003E3E3E00E3DFE000E3DF
            E000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE0003232
            3200F0FBFF00F2F2F200F2F2F200F2F2F2008686860026262600FF8F6B000000
            0000F0FBFF00F2F2F200F2F2F20026262600FFAA0000FF8F6B00000000008686
            8600F0FBFF00FFFFFF00FFFFFF00FFFFFF00F2F2F2003E3E3E00E3DFE000E3DF
            E000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE0003E3E
            3E00FFFFFF00F2F2F200F2F2F200F2F2F20000000000FF8F6B0000000000F2F2
            F200F2F2F200F2F2F200F2F2F200F2F2F20000000000FFAA0000FF8F6B000000
            0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00F2F2F2003E3E3E00E3DFE000E3DF
            E000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE0003232
            3200F2F2F200DADADA00DADADA00DADADA000000000000000000C2C2C200C2C2
            C200F2F2F200C2C2C200F2F2F200F2F2F200F2F2F20000000000FFAA00002626
            260086868600E6E6E600E6E6E600E6E6E600DADADA003E3E3E00E3DFE000E3DF
            E000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE0003232
            3200F2F2F200DADADA00DADADA00DADADA00DADADA00DADADA00C2C2C200C2C2
            C200F2F2F200F2F2F200F2F2F200F2F2F200F2F2F200DADADA0000000000FFAA
            000000000000E6E6E600E6E6E600E6E6E600DADADA003E3E3E00E3DFE000E3DF
            E000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE0003E3E
            3E00FFFFFF00F2F2F200F2F2F200F2F2F200E6E6E600E6E6E600DADADA00F0FB
            FF00F2F2F200F2F2F200F2F2F200F2F2F200DADADA00F2F2F200DADADA000000
            00000000000000000000FFFFFF00FFFFFF00F2F2F2003E3E3E00E3DFE000E3DF
            E000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE0003232
            3200F2F2F200E6E6E600E6E6E600E6E6E600E6E6E600F2F2F200DADADA00DADA
            DA00F2F2F200F2F2F200F2F2F200F2F2F200F2F2F200DADADA00C2C2C200F2F2
            F20000000000F2F2F200F2F2F200F0FBFF00F2F2F2003E3E3E00E3DFE000E3DF
            E000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE0003E3E
            3E00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00F2F2F200F2F2
            F200FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00F0FBFF00E6E6E600FFFF
            FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF003E3E3E00E3DFE000E3DF
            E000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE0003232
            32009E9E9E00A4A0A000A4A0A000A4A0A000A4A0A000A4A0A0009E9E9E009E9E
            9E009E9E9E009E9E9E009E9E9E009E9E9E009E9E9E0092929200929292009E9E
            9E009E9E9E009E9E9E00929292009E9E9E00929292004A4A4A00E3DFE000E3DF
            E000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000C0C0
            C000DC000000DC000000DC000000DC000000DC000000DC000000DC000000DC00
            0000DC000000DC000000DC000000DC000000DC000000DC000000DC000000DC00
            0000DC000000DC000000DC000000DC000000DC000000C2C2C200E3DFE000E3DF
            E000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DF
            E000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DF
            E000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DF
            E000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DF
            E000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DF
            E000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DF
            E000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DF
            E000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DF
            E000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DF
            E000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DF
            E000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DF
            E000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DF
            E000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DF
            E000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DF
            E000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DF
            E000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DF
            E000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000}
          OnClick = Button14Click
        end
        object Button2: TSpeedButton
          Left = 597
          Top = 446
          Width = 129
          Height = 26
          Caption = 'Archivio materiali'
          Glyph.Data = {
            36100000424D3610000000000000360000002800000020000000200000000100
            2000000000000010000000000000000000000000000000000000E3DFE000E3DF
            E000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DF
            E000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DF
            E000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DF
            E000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DF
            E000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DF
            E000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DF
            E000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DF
            E000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DF
            E000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DF
            E000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DF
            E000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DF
            E000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DF
            E000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DF
            E000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DF
            E000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DF
            E000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DF
            E000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DF
            E000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DF
            E000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DF
            E000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DF
            E000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DF
            E000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DF
            E000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DF
            E000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DF
            E000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DF
            E000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DF
            E000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DF
            E000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DF
            E000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DF
            E000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DF
            E000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DF
            E000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE0006E6E
            6E001A1A1A002626260026262600262626002626260026262600262626002626
            2600262626002626260026262600262626002626260026262600262626002626
            2600262626002626260026262600262626001A1A1A007A7A7A00E3DFE000E3DF
            E000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE0003232
            3200F2F2F200F2F2F200F2F2F200F2F2F200F2F2F200F2F2F200DADADA00DADA
            DA00F2F2F200F2F2F200F2F2F200F2F2F200F2F2F200E6E6E600CECECE00F2F2
            F200F2F2F200F2F2F200F2F2F200F2F2F200E6E6E6003E3E3E00E3DFE000E3DF
            E000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE0003E3E
            3E00F0FBFF00F2F2F200F2F2F200F2F2F200F2F2F200FFFFFF00E6E6E600E6E6
            E600FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00F2F2F200DADADA00FFFF
            FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00E6E6E6003E3E3E00E3DFE000E3DF
            E000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE0003232
            3200F2F2F200F2F2F200F2F2F200F2F2F200F2F2F200FFFFFF00E6E6E600E6E6
            E600FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00F2F2F200DADADA00FFFF
            FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00F2F2F2003E3E3E00E3DFE000E3DF
            E000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE0003232
            3200F2F2F200F2F2F200E6E6E600F2F2F200F2F2F200DC000000DC000000DADA
            DA00F2F2F200F2F2F200F2F2F200F2F2F200F2F2F200DC000000DC000000F0FB
            FF00F2F2F200F2F2F200F2F2F200F0FBFF00E6E6E6003E3E3E00E3DFE000E3DF
            E000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE0003232
            3200E6E6E600CECECE00CECECE00CECECE00DADADA00DC000000DC000000CECE
            CE00DADADA00DADADA00DADADA00DADADA00DADADA00DC000000DC000000E6E6
            E600DADADA00DADADA00DADADA00E6E6E600CECECE003E3E3E00E3DFE000E3DF
            E000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE0003232
            3200F0FBFF00F2F2F200F2F2F200F0FBFF00F0FBFF00DC000000DC000000E6E6
            E600FFFFFF00DC000000DC000000FFFFFF00FFFFFF00DC000000DC000000FFFF
            FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00F2F2F2003E3E3E00E3DFE000E3DF
            E000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE0003232
            3200F2F2F200F2F2F200F2F2F200F2F2F200F2F2F200DC000000DC000000E6E6
            E600F0FBFF00DC000000DC000000F2F2F200FFFFFF00DC000000DC000000FFFF
            FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00E6E6E6003E3E3E00E3DFE000E3DF
            E000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE0003232
            3200F0FBFF00F2F2F200F2F2F200F2F2F200F2F2F200DC000000DC000000E6E6
            E600DC000000DC000000DC000000DC000000FFFFFF00DC000000DC000000FFFF
            FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00F2F2F2003E3E3E00E3DFE000E3DF
            E000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE0003232
            3200F2F2F200CECECE00CECECE00CECECE00CECECE00DC000000DC000000C2C2
            C200DC000000DC000000DC000000DC000000DADADA00DC000000DC000000DADA
            DA00DADADA00DADADA00DADADA00E6E6E600CECECE003E3E3E00E3DFE000E3DF
            E000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE0003232
            3200F2F2F200E6E6E600E6E6E600F2F2F200F2F2F200DC000000DC000000DC00
            0000DC000000F2F2F200F2F2F200DC000000DC000000DC000000DC000000F2F2
            F200F2F2F200F2F2F200F2F2F200F0FBFF00E6E6E6003E3E3E00E3DFE000E3DF
            E000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE0003232
            3200F0FBFF00F2F2F200F2F2F200F2F2F200F2F2F200DC000000DC000000DC00
            0000DC000000F2F2F200F2F2F200DC000000DC000000DC000000DC000000FFFF
            FF00F0FBFF00FFFFFF00FFFFFF00FFFFFF00F2F2F2003E3E3E00E3DFE000E3DF
            E000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE0003E3E
            3E00FFFFFF00F2F2F200F2F2F200F2F2F200F2F2F200DC000000DC000000DC00
            0000F0FBFF00F2F2F200F2F2F200F0FBFF00DC000000DC000000DC000000FFFF
            FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00F2F2F2003E3E3E00E3DFE000E3DF
            E000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE0003232
            3200F2F2F200DADADA00DADADA00DADADA00DADADA00DC000000DC000000DC00
            0000E6E6E600E6E6E600E6E6E600E6E6E600DC000000DC000000DC000000E6E6
            E600E6E6E600E6E6E600E6E6E600E6E6E600DADADA003E3E3E00E3DFE000E3DF
            E000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE0003232
            3200F2F2F200DADADA00DADADA00DADADA00DADADA00DC000000DC000000CECE
            CE00E6E6E600DADADA00E6E6E600E6E6E600E6E6E600DC000000DC000000E6E6
            E600E6E6E600E6E6E600E6E6E600E6E6E600DADADA003E3E3E00E3DFE000E3DF
            E000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE0003E3E
            3E00FFFFFF00F2F2F200F2F2F200F2F2F200F2F2F200DC000000DC000000E6E6
            E600F0FBFF00F2F2F200F2F2F200F2F2F200FFFFFF00DC000000DC000000FFFF
            FF00F0FBFF00FFFFFF00FFFFFF00FFFFFF00F2F2F2003E3E3E00E3DFE000E3DF
            E000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE0003232
            3200F2F2F200E6E6E600E6E6E600E6E6E600E6E6E600F2F2F200DADADA00DADA
            DA00F2F2F200F2F2F200F2F2F200F2F2F200F2F2F200E6E6E600CECECE00F2F2
            F200F2F2F200F2F2F200F2F2F200F0FBFF00F2F2F2003E3E3E00E3DFE000E3DF
            E000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE0003E3E
            3E00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00F2F2F200F2F2
            F200FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00F0FBFF00E6E6E600FFFF
            FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF003E3E3E00E3DFE000E3DF
            E000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE0003232
            32009E9E9E00A4A0A000A4A0A000A4A0A000A4A0A000A4A0A0009E9E9E009E9E
            9E009E9E9E009E9E9E009E9E9E009E9E9E009E9E9E0092929200929292009E9E
            9E009E9E9E009E9E9E00929292009E9E9E00929292004A4A4A00E3DFE000E3DF
            E000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000C0C0
            C000DC000000DC000000DC000000DC000000DC000000DC000000DC000000DC00
            0000DC000000DC000000DC000000DC000000DC000000DC000000DC000000DC00
            0000DC000000DC000000DC000000DC000000DC000000C2C2C200E3DFE000E3DF
            E000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DF
            E000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DF
            E000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DF
            E000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DF
            E000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DF
            E000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DF
            E000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DF
            E000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DF
            E000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DF
            E000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DF
            E000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DF
            E000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DF
            E000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DF
            E000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DF
            E000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DF
            E000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DF
            E000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000}
          OnClick = Button2Click
        end
        object Label3: TLabel
          Left = 418
          Top = 24
          Width = 104
          Height = 14
          Caption = 'Categoria materiali'
          Color = clBtnFace
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clHotLight
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentColor = False
          ParentFont = False
        end
        object Panel4: TPanel
          Left = 298
          Top = 67
          Width = 115
          Height = 101
          BevelOuter = bvNone
          TabOrder = 3
          object Shape7: TShape
            Left = 5
            Top = 7
            Width = 110
            Height = 94
            Brush.Color = clBlack
          end
          object Shape8: TShape
            Left = 0
            Top = 0
            Width = 113
            Height = 97
          end
          object Label22: TLabel
            Left = 30
            Top = 64
            Width = 74
            Height = 16
            Caption = 'di condensa'
            Color = clWhite
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentColor = False
            ParentFont = False
          end
          object Label21: TLabel
            Left = 34
            Top = 40
            Width = 66
            Height = 16
            Caption = 'formazione'
            Color = clWhite
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentColor = False
            ParentFont = False
          end
          object Label20: TLabel
            Left = 39
            Top = 16
            Width = 56
            Height = 16
            Caption = 'Possibile'
            Color = clWhite
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentColor = False
            ParentFont = False
          end
          object Label19: TLabel
            Left = 11
            Top = 18
            Width = 14
            Height = 64
            Caption = '!'
            Color = clWhite
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clRed
            Font.Height = -53
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentColor = False
            ParentFont = False
          end
        end
        object ListBox1: TListBox
          Left = 418
          Top = 38
          Width = 169
          Height = 154
          BevelKind = bkFlat
          BorderStyle = bsNone
          ItemHeight = 14
          TabOrder = 0
          OnClick = ListBox1Click
        end
        object GroupBox3: TGroupBox
          Left = 416
          Top = 316
          Width = 354
          Height = 126
          Caption = 'Statigrafia dall'#39'interno all'#39'esterno (misure in cm) '
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clHotLight
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 1
          object SpeedButton1: TSpeedButton
            Left = 333
            Top = 2
            Width = 16
            Height = 15
            Caption = '?'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clHotLight
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            OnClick = SpeedButton1Click
          end
          object DBGrid2: TDBGrid
            Tag = 2
            Left = 2
            Top = 16
            Width = 350
            Height = 108
            Align = alClient
            DataSource = DataSource3
            FixedColor = clInfoBk
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            Options = [dgEditing, dgTitles, dgColumnResize, dgColLines, dgTabs, dgConfirmDelete, dgCancelOnExit]
            ParentFont = False
            PopupMenu = PopupMenu1
            TabOrder = 0
            TitleFont.Charset = DEFAULT_CHARSET
            TitleFont.Color = clWindowText
            TitleFont.Height = -11
            TitleFont.Name = 'Arial'
            TitleFont.Style = [fsBold]
            OnDblClick = DBGrid2DblClick
            OnDragDrop = DBGrid2DragDrop
            OnDragOver = DBGrid2DragOver
            OnKeyPress = DBGrid2KeyPress
          end
        end
        object GroupBox4: TGroupBox
          Left = 417
          Top = 196
          Width = 354
          Height = 120
          Caption = 'Archivio dei materiali (Drag && Drop per selezionare) '
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clHotLight
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 2
          object DBGrid1: TDBGrid
            Tag = 1
            Left = 2
            Top = 16
            Width = 350
            Height = 102
            Align = alClient
            DataSource = DataSource2
            FixedColor = clInfoBk
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            Options = [dgEditing, dgTitles, dgColumnResize, dgColLines, dgTabs, dgConfirmDelete, dgCancelOnExit]
            ParentFont = False
            TabOrder = 0
            TitleFont.Charset = DEFAULT_CHARSET
            TitleFont.Color = clWindowText
            TitleFont.Height = -11
            TitleFont.Name = 'Arial'
            TitleFont.Style = [fsBold]
            OnCellClick = DBGrid1CellClick
            OnDblClick = DBGrid1DblClick
          end
        end
        object Edit21: TEdit
          Left = 519
          Top = 1
          Width = 121
          Height = 20
          BevelKind = bkFlat
          BorderStyle = bsNone
          TabOrder = 4
          OnKeyUp = Edit21KeyUp
        end
        object GroupBox21: TGroupBox
          Left = 0
          Top = 283
          Width = 409
          Height = 187
          TabOrder = 5
          object Label77: TLabel
            Left = 9
            Top = 43
            Width = 62
            Height = 14
            Caption = 'Trasmittanza'
          end
          object Label78: TLabel
            Left = 187
            Top = 43
            Width = 42
            Height = 14
            Caption = '[W/m'#178#176'C]'
          end
          object Label53: TLabel
            Left = 187
            Top = 70
            Width = 42
            Height = 14
            Caption = '[W/m'#178#176'C]'
          end
          object Label129: TLabel
            Left = 9
            Top = 70
            Width = 83
            Height = 14
            Caption = 'Trasmittanza L10'
          end
          object Label128: TLabel
            Left = 9
            Top = 95
            Width = 116
            Height = 14
            AutoSize = False
            Caption = 'Incremento di Sicurezza'
          end
          object Label130: TLabel
            Left = 9
            Top = 163
            Width = 58
            Height = 14
            Caption = 'Mese critico'
          end
          object Label131: TLabel
            Left = 9
            Top = 138
            Width = 26
            Height = 14
            Caption = 'Mese'
          end
          object Label166: TLabel
            Left = 9
            Top = 17
            Width = 81
            Height = 14
            Caption = 'Spessore parete'
          end
          object Label167: TLabel
            Left = 187
            Top = 17
            Width = 20
            Height = 14
            Caption = '[cm]'
          end
          object Label2: TLabel
            Left = 201
            Top = 95
            Width = 16
            Height = 14
            Caption = '[%]'
          end
          object Label4: TLabel
            Left = 8
            Top = 116
            Width = 201
            Height = 14
            Caption = 'Verifica Termo-Igrometrica mensile '
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object Label5: TLabel
            Left = 236
            Top = 25
            Width = 140
            Height = 14
            Caption = 'Verifica decr. 27 Luglio 05'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object Shape_Ver: TShape
            Left = 240
            Top = 42
            Width = 17
            Height = 17
            Brush.Color = 59904
            Shape = stCircle
          end
          object LB_InfoVer: TLbSpeedButton
            Left = 265
            Top = 39
            Width = 23
            Height = 23
            Alignment = taCenter
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
            OnClick = LB_InfoVerClick
          end
          object DBEdit34: TDBEdit
            Tag = 10
            Left = 133
            Top = 39
            Width = 50
            Height = 22
            BevelKind = bkFlat
            BorderStyle = bsNone
            Color = cl3DLight
            ReadOnly = True
            TabOrder = 0
          end
          object DBEdit56: TDBEdit
            Tag = 21
            Left = 133
            Top = 66
            Width = 50
            Height = 22
            BevelKind = bkFlat
            BorderStyle = bsNone
            Color = cl3DLight
            ReadOnly = True
            TabOrder = 1
          end
          object DBEdit55: TDBEdit
            Tag = 13
            Left = 133
            Top = 91
            Width = 40
            Height = 22
            BevelKind = bkFlat
            BorderStyle = bsNone
            TabOrder = 2
            OnChange = DBEdit55Change
            OnKeyPress = DBEdit7KeyPress
          end
          object RxSpinButton15: TSpinButton
            Left = 176
            Top = 91
            Width = 20
            Height = 22
            DownGlyph.Data = {
              56000000424D56000000000000003E0000002800000006000000060000000100
              010000000000180000000000000000000000020000000200000000000000FFFF
              FF00CC0000008400000000000000CC000000CC000000CC000000}
            FocusControl = DBEdit55
            TabOrder = 3
            UpGlyph.Data = {
              56000000424D56000000000000003E0000002800000006000000060000000100
              010000000000180000000000000000000000020000000200000000000000FFFF
              FF00CC000000CC000000CC0000000000000084000000CC000000}
            OnDownClick = RxSpinButton1DownClick
            OnUpClick = RxSpinButton1UpClick
          end
          object DBEdit57: TDBEdit
            Tag = 23
            Left = 75
            Top = 159
            Width = 90
            Height = 22
            BevelKind = bkFlat
            BorderStyle = bsNone
            Color = cl3DLight
            ReadOnly = True
            TabOrder = 5
          end
          object ComboMese: TComboBox
            Left = 75
            Top = 134
            Width = 90
            Height = 22
            BevelKind = bkFlat
            Style = csDropDownList
            ItemHeight = 14
            ItemIndex = 0
            TabOrder = 4
            Text = 'Gennaio'
            OnChange = ComboMeseChange
            Items.Strings = (
              'Gennaio'
              'Febbraio'
              'Marzo'
              'Aprile'
              'Maggio'
              'Giugno'
              'Luglio'
              'Agosto'
              'Settembre'
              'Ottobre'
              'Novembre'
              'Dicembre')
          end
          object DBEdit35: TDBEdit
            Tag = 11
            Left = 133
            Top = 13
            Width = 35
            Height = 22
            BevelKind = bkFlat
            BorderStyle = bsNone
            Color = cl3DLight
            ReadOnly = True
            TabOrder = 6
          end
        end
      end
      object TabSheet4: TTabSheet
        Caption = 'Geometriche'
        object Image3: TImage
          Left = 0
          Top = 0
          Width = 440
          Height = 440
        end
        object Label89: TLabel
          Left = 301
          Top = 530
          Width = 219
          Height = 14
          AutoSize = False
          Caption = 'Calcolo della trasmittanza secondo UNI 10345'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object Panel3: TPanel
          Left = 440
          Top = 0
          Width = 331
          Height = 471
          Align = alRight
          BevelOuter = bvNone
          TabOrder = 0
          object Button16: TSpeedButton
            Left = 1
            Top = 372
            Width = 90
            Height = 26
            Caption = 'Conferma'
            Glyph.Data = {
              36100000424D3610000000000000360000002800000020000000200000000100
              2000000000000010000000000000000000000000000000000000E3DFE000E3DF
              E000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DF
              E000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DF
              E000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DF
              E000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DF
              E000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DF
              E000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DF
              E000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DF
              E000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DF
              E000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DF
              E000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DF
              E000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DF
              E000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DF
              E000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DF
              E000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DF
              E000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DF
              E000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DF
              E000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DF
              E000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DF
              E000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DF
              E000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DF
              E000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DF
              E000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DF
              E000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DF
              E000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DF
              E000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DF
              E000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DF
              E000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DF
              E000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DF
              E000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DF
              E000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DF
              E000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DF
              E000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE0006E6E
              6E001A1A1A002626260026262600262626002626260026262600262626002626
              2600262626002626260026262600262626002626260026262600262626002626
              2600262626002626260026262600262626001A1A1A007A7A7A00E3DFE000E3DF
              E000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE0003232
              3200F2F2F200F2F2F200F2F2F200F2F2F200F2F2F200F2F2F200DADADA00DADA
              DA00F2F2F200F2F2F200F2F2F200F2F2F200F2F2F200E6E6E600CECECE00F2F2
              F200F2F2F200F2F2F200F2F2F200F2F2F200E6E6E6003E3E3E00E3DFE000E3DF
              E000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE0003E3E
              3E00F0FBFF00F2F2F200F2F2F200F2F2F200F2F2F200FFFFFF00E6E6E600E6E6
              E600FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00F2F2F200DADADA00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00E6E6E6003E3E3E00E3DFE000E3DF
              E000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE0003232
              3200F2F2F200F2F2F200F2F2F200F2F2F200F2F2F200FFFFFF00E6E6E600E6E6
              E600A4A0A0000000000000000000F2F2F200F2F2F200F2F2F200DADADA00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00F2F2F2003E3E3E00E3DFE000E3DF
              E000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE0003232
              3200F2F2F200F2F2F200E6E6E600F2F2F200F2F2F200F2F2F200E6E6E600E6E6
              E60000000000963100005656560000000000F2F2F200E6E6E600DADADA00FFFF
              FF00FFFFFF00FFFFFF00F2F2F200F0FBFF00E6E6E6003E3E3E00E3DFE000E3DF
              E000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE0003232
              3200E6E6E600CECECE00CECECE00CECECE00DADADA00DADADA00A4A0A000CECE
              CE0000000000FF8F6B00963100000000000086868600DADADA00CECECE00F0FB
              FF00DADADA00DADADA00DADADA00E6E6E600CECECE003E3E3E00E3DFE000E3DF
              E000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE0003232
              3200F0FBFF00F2F2F200F2F2F200F0FBFF00F0FBFF00FFFFFF00E6E6E6000000
              0000FF8F6B00FF8F6B00FF8F6B005656560000000000E6E6E600DADADA00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00F2F2F2003E3E3E00E3DFE000E3DF
              E000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE0003232
              3200F2F2F200F2F2F200F2F2F200F2F2F200F2F2F200F2F2F200A4A0A0000000
              0000FFAA0000FF8F6B00FF8F6B00963100000000000086868600DADADA00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00E6E6E6003E3E3E00E3DFE000E3DF
              E000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE0003232
              3200F0FBFF00F2F2F200F2F2F200F2F2F200F2F2F200F2F2F20000000000FFAA
              0000FFAA0000FFAA0000FF8F6B00FF8F6B005656560000000000DADADA00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00F2F2F2003E3E3E00E3DFE000E3DF
              E000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE0003232
              3200F2F2F200CECECE00CECECE00CECECE00E6E6E600A4A0A00000000000FFAA
              0000FF8F6B0000000000FFAA0000FF8F6B00963100000000000086868600DADA
              DA00DADADA00DADADA00DADADA00E6E6E600CECECE003E3E3E00E3DFE000E3DF
              E000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE0003232
              3200F2F2F200E6E6E600E6E6E600F2F2F200E6E6E60000000000FFAA0000FF8F
              6B0000000000F2F2F20000000000FFAA0000FF8F6B005656560000000000F2F2
              F200F2F2F200F2F2F200F2F2F200F0FBFF00E6E6E6003E3E3E00E3DFE000E3DF
              E000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE0003232
              3200F0FBFF00F2F2F200F2F2F200F2F2F2008686860026262600FF8F6B000000
              0000F0FBFF00F2F2F200F2F2F20026262600FFAA0000FF8F6B00000000008686
              8600F0FBFF00FFFFFF00FFFFFF00FFFFFF00F2F2F2003E3E3E00E3DFE000E3DF
              E000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE0003E3E
              3E00FFFFFF00F2F2F200F2F2F200F2F2F20000000000FF8F6B0000000000F2F2
              F200F2F2F200F2F2F200F2F2F200F2F2F20000000000FFAA0000FF8F6B000000
              0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00F2F2F2003E3E3E00E3DFE000E3DF
              E000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE0003232
              3200F2F2F200DADADA00DADADA00DADADA000000000000000000C2C2C200C2C2
              C200F2F2F200C2C2C200F2F2F200F2F2F200F2F2F20000000000FFAA00002626
              260086868600E6E6E600E6E6E600E6E6E600DADADA003E3E3E00E3DFE000E3DF
              E000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE0003232
              3200F2F2F200DADADA00DADADA00DADADA00DADADA00DADADA00C2C2C200C2C2
              C200F2F2F200F2F2F200F2F2F200F2F2F200F2F2F200DADADA0000000000FFAA
              000000000000E6E6E600E6E6E600E6E6E600DADADA003E3E3E00E3DFE000E3DF
              E000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE0003E3E
              3E00FFFFFF00F2F2F200F2F2F200F2F2F200E6E6E600E6E6E600DADADA00F0FB
              FF00F2F2F200F2F2F200F2F2F200F2F2F200DADADA00F2F2F200DADADA000000
              00000000000000000000FFFFFF00FFFFFF00F2F2F2003E3E3E00E3DFE000E3DF
              E000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE0003232
              3200F2F2F200E6E6E600E6E6E600E6E6E600E6E6E600F2F2F200DADADA00DADA
              DA00F2F2F200F2F2F200F2F2F200F2F2F200F2F2F200DADADA00C2C2C200F2F2
              F20000000000F2F2F200F2F2F200F0FBFF00F2F2F2003E3E3E00E3DFE000E3DF
              E000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE0003E3E
              3E00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00F2F2F200F2F2
              F200FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00F0FBFF00E6E6E600FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF003E3E3E00E3DFE000E3DF
              E000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE0003232
              32009E9E9E00A4A0A000A4A0A000A4A0A000A4A0A000A4A0A0009E9E9E009E9E
              9E009E9E9E009E9E9E009E9E9E009E9E9E009E9E9E0092929200929292009E9E
              9E009E9E9E009E9E9E00929292009E9E9E00929292004A4A4A00E3DFE000E3DF
              E000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000C0C0
              C000DC000000DC000000DC000000DC000000DC000000DC000000DC000000DC00
              0000DC000000DC000000DC000000DC000000DC000000DC000000DC000000DC00
              0000DC000000DC000000DC000000DC000000DC000000C2C2C200E3DFE000E3DF
              E000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DF
              E000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DF
              E000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DF
              E000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DF
              E000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DF
              E000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DF
              E000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DF
              E000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DF
              E000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DF
              E000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DF
              E000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DF
              E000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DF
              E000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DF
              E000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DF
              E000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DF
              E000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DF
              E000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000}
            OnClick = Button16Click
          end
          object GroupBox12: TGroupBox
            Left = 0
            Top = 0
            Width = 331
            Height = 57
            Align = alTop
            Caption = 'Cassonetto'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clHotLight
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            TabOrder = 0
            object Label34: TLabel
              Left = 14
              Top = 26
              Width = 40
              Height = 14
              AutoSize = False
              Caption = 'Altezza'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
            end
            object Label36: TLabel
              Left = 135
              Top = 26
              Width = 20
              Height = 14
              Caption = 'Tipo'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
            end
            object Label169: TLabel
              Left = 99
              Top = 26
              Width = 16
              Height = 14
              AutoSize = False
              Caption = '[m]'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
            end
            object DBEdit19: TDBEdit
              Tag = 7
              Left = 59
              Top = 22
              Width = 35
              Height = 22
              BevelKind = bkFlat
              BorderStyle = bsNone
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
              TabOrder = 0
              OnKeyPress = DBEdit15KeyPress
            end
            object DBComboBox4: TDBComboBox
              Tag = 8
              Left = 160
              Top = 22
              Width = 152
              Height = 22
              Style = csDropDownList
              BevelKind = bkFlat
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ItemHeight = 14
              ParentFont = False
              TabOrder = 1
              OnChange = DBComboBox4Change
              OnKeyPress = DBComboBox3KeyPress
            end
          end
          object GroupBox10: TGroupBox
            Left = 0
            Top = 57
            Width = 331
            Height = 58
            Align = alTop
            Caption = 'Sopra Luce'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clHotLight
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            TabOrder = 1
            object Label170: TLabel
              Left = 100
              Top = 27
              Width = 16
              Height = 14
              AutoSize = False
              Caption = '[m]'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
            end
            object Label25: TLabel
              Left = 14
              Top = 27
              Width = 40
              Height = 14
              AutoSize = False
              Caption = 'Altezza'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
            end
            object DBEdit15: TDBEdit
              Tag = 5
              Left = 60
              Top = 23
              Width = 35
              Height = 22
              BevelKind = bkFlat
              BorderStyle = bsNone
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
              TabOrder = 0
              OnKeyPress = DBEdit15KeyPress
            end
          end
          object GroupBox9: TGroupBox
            Left = 0
            Top = 115
            Width = 331
            Height = 71
            Align = alTop
            Caption = 'Finestra'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clHotLight
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            TabOrder = 2
            object Label26: TLabel
              Left = 10
              Top = 17
              Width = 55
              Height = 14
              AutoSize = False
              Caption = 'Larghezza'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
            end
            object Label27: TLabel
              Left = 152
              Top = 17
              Width = 7
              Height = 14
              AutoSize = False
              Caption = 'X'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
            end
            object Label28: TLabel
              Left = 173
              Top = 17
              Width = 41
              Height = 14
              AutoSize = False
              Caption = 'Altezza'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
            end
            object Label31: TLabel
              Left = 10
              Top = 45
              Width = 61
              Height = 14
              AutoSize = False
              Caption = 'Numero ante'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
            end
            object Label32: TLabel
              Left = 131
              Top = 45
              Width = 83
              Height = 14
              AutoSize = False
              Caption = 'Larghezza telaio'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
            end
            object Label171: TLabel
              Left = 115
              Top = 17
              Width = 16
              Height = 14
              AutoSize = False
              Caption = '[m]'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
            end
            object Label172: TLabel
              Left = 255
              Top = 17
              Width = 16
              Height = 14
              AutoSize = False
              Caption = '[m]'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
            end
            object Label173: TLabel
              Left = 256
              Top = 45
              Width = 16
              Height = 14
              AutoSize = False
              Caption = '[m]'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
            end
            object DBEdit13: TDBEdit
              Tag = 2
              Left = 76
              Top = 13
              Width = 35
              Height = 22
              BevelKind = bkFlat
              BorderStyle = bsNone
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
              TabOrder = 0
              OnKeyPress = DBEdit15KeyPress
            end
            object DBEdit14: TDBEdit
              Tag = 1
              Left = 216
              Top = 13
              Width = 35
              Height = 22
              BevelKind = bkFlat
              BorderStyle = bsNone
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
              TabOrder = 1
              OnKeyPress = DBEdit15KeyPress
            end
            object DBEdit16: TDBEdit
              Tag = 4
              Left = 76
              Top = 41
              Width = 40
              Height = 22
              BevelKind = bkFlat
              BorderStyle = bsNone
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
              TabOrder = 2
              OnKeyPress = DBEdit15KeyPress
            end
            object DBEdit18: TDBEdit
              Tag = 3
              Left = 216
              Top = 41
              Width = 35
              Height = 22
              BevelKind = bkFlat
              BorderStyle = bsNone
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
              TabOrder = 3
              OnKeyPress = DBEdit15KeyPress
            end
          end
          object GroupBox13: TGroupBox
            Left = 0
            Top = 186
            Width = 331
            Height = 127
            Align = alTop
            Caption = 'Sotto finestra'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clHotLight
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            TabOrder = 3
            object Label38: TLabel
              Left = 10
              Top = 48
              Width = 20
              Height = 14
              AutoSize = False
              Caption = 'Tipo'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
            end
            object Label51: TLabel
              Left = 10
              Top = 74
              Width = 65
              Height = 14
              AutoSize = False
              Caption = 'Trasmittanza '
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
            end
            object Label52: TLabel
              Left = 10
              Top = 100
              Width = 83
              Height = 14
              AutoSize = False
              Caption = 'Trasmittanza L10'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
            end
            object Label79: TLabel
              Left = 10
              Top = 23
              Width = 56
              Height = 14
              AutoSize = False
              Caption = 'Larghezza'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
            end
            object Label80: TLabel
              Left = 155
              Top = 23
              Width = 7
              Height = 14
              AutoSize = False
              Caption = 'X'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
            end
            object Label174: TLabel
              Left = 118
              Top = 23
              Width = 16
              Height = 14
              AutoSize = False
              Caption = '[m]'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
            end
            object Label37: TLabel
              Left = 173
              Top = 23
              Width = 41
              Height = 14
              AutoSize = False
              Caption = 'Altezza'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
            end
            object Label175: TLabel
              Left = 256
              Top = 23
              Width = 16
              Height = 14
              AutoSize = False
              Caption = '[m]'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
            end
            object Label176: TLabel
              Left = 154
              Top = 74
              Width = 42
              Height = 14
              Caption = '[W/m'#178#176'C]'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
            end
            object Label177: TLabel
              Left = 154
              Top = 100
              Width = 42
              Height = 14
              Caption = '[W/m'#178#176'C]'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
            end
            object DBEdit20: TDBEdit
              Tag = 9
              Left = 215
              Top = 19
              Width = 35
              Height = 22
              BevelKind = bkFlat
              BorderStyle = bsNone
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
              TabOrder = 1
              OnKeyPress = DBEdit15KeyPress
            end
            object DBComboBox6: TDBComboBox
              Tag = 10
              Left = 80
              Top = 44
              Width = 205
              Height = 22
              Style = csDropDownList
              BevelKind = bkFlat
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ItemHeight = 14
              ParentFont = False
              TabOrder = 2
              OnChange = DBComboBox6Change
              OnKeyPress = DBComboBox3KeyPress
            end
            object DBEdit39: TDBEdit
              Tag = 61
              Left = 100
              Top = 70
              Width = 50
              Height = 22
              BevelKind = bkFlat
              BorderStyle = bsNone
              Color = cl3DLight
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
              ReadOnly = True
              TabOrder = 3
              OnKeyPress = DBEdit15KeyPress
            end
            object DBEdit40: TDBEdit
              Tag = 62
              Left = 100
              Top = 96
              Width = 50
              Height = 22
              BevelKind = bkFlat
              BorderStyle = bsNone
              Color = cl3DLight
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
              ReadOnly = True
              TabOrder = 4
              OnKeyPress = DBEdit15KeyPress
            end
            object DBEdit23: TDBEdit
              Tag = 2
              Left = 79
              Top = 19
              Width = 35
              Height = 22
              BevelKind = bkFlat
              BorderStyle = bsNone
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
              TabOrder = 0
              OnKeyPress = DBEdit23KeyPress
            end
          end
          object GroupBox14: TGroupBox
            Left = 0
            Top = 313
            Width = 331
            Height = 58
            Align = alTop
            Caption = 'Ponte termico di bordo'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clHotLight
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            TabOrder = 4
            Visible = False
            object Label39: TLabel
              Left = 11
              Top = 28
              Width = 20
              Height = 14
              AutoSize = False
              Caption = 'Tipo'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
              Visible = False
            end
            object DBComboBox7: TDBComboBox
              Tag = 11
              Left = 36
              Top = 24
              Width = 129
              Height = 22
              Style = csDropDownList
              BevelKind = bkFlat
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ItemHeight = 14
              ParentFont = False
              TabOrder = 0
              OnChange = DBComboBox7Change
              OnKeyPress = DBComboBox3KeyPress
            end
          end
        end
      end
      object TabSheetTermiche: TTabSheet
        Caption = 'Termiche'
        ImageIndex = 1
        object Label90: TLabel
          Left = 301
          Top = 530
          Width = 219
          Height = 14
          AutoSize = False
          Caption = 'Calcolo della trasmittanza secondo UNI 10345'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object GroupBox16: TGroupBox
          Left = 504
          Top = 254
          Width = 266
          Height = 211
          Caption = ' Riepilogo '
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clHotLight
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 4
          object Label49: TLabel
            Left = 9
            Top = 20
            Width = 134
            Height = 32
            AutoSize = False
            Caption = 'Superficie dei setti opachi (sottofinestra etc.)'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            WordWrap = True
          end
          object Label50: TLabel
            Left = 196
            Top = 29
            Width = 18
            Height = 14
            AutoSize = False
            Caption = '[m'#178']'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
          end
          object Label66: TLabel
            Left = 9
            Top = 56
            Width = 78
            Height = 14
            Caption = 'Superficie totale'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
          end
          object Label67: TLabel
            Left = 196
            Top = 56
            Width = 18
            Height = 14
            Caption = '[m'#178']'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
          end
          object Label68: TLabel
            Left = 9
            Top = 157
            Width = 106
            Height = 14
            Caption = 'Trasmittanza totale'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object Label69: TLabel
            Left = 205
            Top = 157
            Width = 42
            Height = 14
            Caption = '[W/m'#178#176'C]'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
          end
          object Label162: TLabel
            Left = 9
            Top = 183
            Width = 128
            Height = 14
            Caption = 'Trasmittanza totale L10'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object Label163: TLabel
            Left = 205
            Top = 183
            Width = 42
            Height = 14
            Caption = '[W/m'#178#176'C]'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
          end
          object Label6: TLabel
            Left = 10
            Top = 119
            Width = 140
            Height = 14
            Caption = 'Verifica decr. 27 Luglio 05'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object Shape_VerF: TShape
            Left = 154
            Top = 118
            Width = 17
            Height = 17
            Brush.Color = 59904
            Shape = stCircle
          end
          object LB_InfoVerF: TLbSpeedButton
            Left = 177
            Top = 115
            Width = 23
            Height = 23
            Alignment = taCenter
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
            OnClick = LB_InfoVerFClick
          end
          object Label7: TLabel
            Left = 9
            Top = 85
            Width = 147
            Height = 14
            Caption = 'Trasmittanza della finestra'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object Label8: TLabel
            Left = 214
            Top = 85
            Width = 42
            Height = 14
            Caption = '[W/m'#178#176'C]'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
          end
          object DBEdit22: TDBEdit
            Tag = 34
            Left = 149
            Top = 25
            Width = 40
            Height = 22
            BevelKind = bkFlat
            BorderStyle = bsNone
            Color = cl3DLight
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            ReadOnly = True
            TabOrder = 0
          end
          object DBEdit30: TDBEdit
            Tag = 14
            Left = 149
            Top = 52
            Width = 40
            Height = 22
            BevelKind = bkFlat
            BorderStyle = bsNone
            Color = cl3DLight
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            ReadOnly = True
            TabOrder = 1
          end
          object DBEdit31: TDBEdit
            Tag = 13
            Left = 149
            Top = 153
            Width = 50
            Height = 22
            BevelKind = bkFlat
            BorderStyle = bsNone
            Color = cl3DLight
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            ReadOnly = True
            TabOrder = 2
          end
          object DBEdit69: TDBEdit
            Tag = 55
            Left = 149
            Top = 179
            Width = 50
            Height = 22
            BevelKind = bkFlat
            BorderStyle = bsNone
            Color = cl3DLight
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            ReadOnly = True
            TabOrder = 3
          end
          object Ed_TrasmFin: TEdit
            Left = 159
            Top = 82
            Width = 50
            Height = 22
            BevelKind = bkFlat
            BorderStyle = bsNone
            Color = cl3DLight
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            ReadOnly = True
            TabOrder = 4
          end
        end
        object PageControl4: TPageControl
          Left = 0
          Top = 190
          Width = 503
          Height = 233
          ActivePage = TabSheet10
          Style = tsButtons
          TabIndex = 0
          TabOrder = 0
          object TabSheet10: TTabSheet
            Caption = 'Telaio tipo a'
            object Image4: TImage
              Left = -2
              Top = 3
              Width = 500
              Height = 198
              Picture.Data = {
                0A544A504547496D616765759C0000FFD8FFE000104A46494600010201004800
                480000FFC000110800C601F403012200021101031101FFDB0084000101010101
                0101010101010101010101010101010101010101010101010101010101010202
                0201020202010102030202020203030301020303030203020203020101010101
                0101010101010201010101020202020202020202020202020202020202020202
                02020202020202020202020202020202020202020202020202020202FFC401A2
                0000010501010101010100000000000000000102030405060708090A0B100002
                010303020403050504040000017D010203000411051221314106135161072271
                14328191A1082342B1C11552D1F02433627282090A161718191A25262728292A
                3435363738393A434445464748494A535455565758595A636465666768696A73
                7475767778797A838485868788898A92939495969798999AA2A3A4A5A6A7A8A9
                AAB2B3B4B5B6B7B8B9BAC2C3C4C5C6C7C8C9CAD2D3D4D5D6D7D8D9DAE1E2E3E4
                E5E6E7E8E9EAF1F2F3F4F5F6F7F8F9FA01000301010101010101010100000000
                00000102030405060708090A0B11000201020404030407050404000102770001
                02031104052131061241510761711322328108144291A1B1C109233352F01562
                72D10A162434E125F11718191A262728292A35363738393A434445464748494A
                535455565758595A636465666768696A737475767778797A8283848586878889
                8A92939495969798999AA2A3A4A5A6A7A8A9AAB2B3B4B5B6B7B8B9BAC2C3C4C5
                C6C7C8C9CAD2D3D4D5D6D7D8D9DAE2E3E4E5E6E7E8E9EAF2F3F4F5F6F7F8F9FA
                FFDA000C03010002110311003F00FEFE28A28A0028A28A0028A28A0028A2BE08
                FF00828AFED5DE20FD92FE08783F59F03CBE05D2FE24FC6DF8E7F09FF66AF867
                E2DF8AAF7F17C24F875E30F8BFAD4DA645F127E28B6992DB4D3E8DA05869FAE6
                A6F6497BA71BE9F4EB4D3C5E69A7505B8B700FBC92681E49218E589A58047E74
                28E8648448A4C5E646A731860A48C8190A719C54B5FCE57FC1387F6AED43E15F
                C33F1BFED4FF00B5DFC436F8EFE36FF8280FFC14E53F645F81DF193E05FC38B9
                D3FE187C42F08FC3BD52DFF653F81BE35B0F0D5ADFDFD8FC2AF0CEA37FF0BBE2
                1EB6D7577AD5EF9EFE270D6B2EA72DFE9F04BFD1AD0014514500145145001455
                1BFB99ECEDE396D74EBAD4E46BCD36D4DAD9496314B15BDE5FDAD9DD6A0CDA84
                D047E4D9C534B77222BB4AD1D948B04771334314B7A800A28A2800A28A2800A2
                8A2800A28A2800A28A2800A28A2800A28AFCCAFF0082AE7C76F885F013F66EF0
                8EA7E08F1778CFE12F87BE20FC78F85DF0B7E33FED0DF0FF00C0D79F117C57FB
                387C0FF11CBACEA5E3FF008A5A0784EC349D75EE750B88F40B0F0A585D9D1B51
                5B1D43E2669D7AD0482C8E003F40F44F887E02F1278B3C6DE02F0F78CBC31ADF
                8DBE1ABF8762F885E12D275BD3AFFC45E0793C5DA4FF006EF8563F1568F6B234
                FA036A3623ED76CB751C5E7438923DE9CD7655FCC77FC13F3E3378BBF62CFD92
                BC19FB48F8ABC0BF1BBF686D47FE0A4FFF000560F0F7C34B5F89BF1CBC5163E1
                7F8D9E1AFD9E3E2AFC51D2BF64EFD94FE2AFC5DB8F13E9169ACF8A8D9F83FE1B
                7C35BB8B448F48B7BA95FC6A1E4FEC78A6BC9ADBFA71A0028A28A0028A28A002
                8A28A0028A28A0028A28A0028A28A0028A28A0028A28A0028A28A0028A28A002
                8A4E00EC00FA003B0F61E940C606318C0C63A63B631DA80168A2BF37BFE0ABF3
                FC7887F629F1D5B7C00D3FE345FEADAAF8D3E11687F14D7F669D23FB77F693B4
                FD9D358F89FE14D3BF683BCFD9F348496192EBC5C9E139FC4EB60D6C5EE62696
                49AD11AEA0B5C007D7DE17F8F7F0ABC67F1A7E2BFECF7E19F129D57E2B7C0FF0
                BFC30F177C50F0EC1A3EB696BE14D1FE310F1849F0F12E7C412DB269B73757D0
                F813C41706C6DEEE5B88618EDA59A3863BCB5697D8EBF978FD92BC25F1B3FE09
                C7FB057ED2DFB527C18FD985BE10EBDF1CBF6F8F0EF8BE0F831FB5E78C3C77A9
                FC4DF86FFB1D49E3DF86DFB3C781B4FD66E22D57C47AAEB1E244D1F4EBCD66D7
                45D47C476F6B6537C40BB74B89EDAC2D2CB53FEA18741C01C0E0741C741ED400
                B45149C0C741D00E83E807F80A005A28A2800A28A2800A28A2800A28A2803E74
                FDB03E2BF893E02FEC93FB51FC72F065B69177E2FF0082FF00B3A7C6DF8AFE13
                B4D7AD6E6F341B9F127C3AF867E26F17E856DAD59D94D6D35D59BDD68D689345
                0DC5BBB46CEA92444AB2FE237ED69FF05E4FDA57F6754B14F04FFC10DFFE0A5D
                F1205C456B24DADF897C19A4786BC1A8B77609710087C4FF0005A3F89B6E9234
                ADE5FD9EE4DA3811B1C164D87F5CFF00E0A41692DF7FC13BFF006F4B1B709E75
                DFEC5DFB51DA401DD628FCDB8F81DE398620EED858D72CA0B1C003D315F5D680
                E65D074490C7E519348D35CC65DE53196B280F96649155A4DBD3732A938C9033
                401F0BF85FF6DCF88FE21F087857C4D2FF00C13CBF6E4D32EBC45E1FD135AB9D
                026D17F66E86FF00449756D2AD750974DBD4D57E24D948925B35C340CB2430C8
                1A06DD1444155E6FE227C721F1BFC23AC7C34F8BFF00F04ABFDAA3E2A7C3AD78
                E991EB5E0AF8A3E08FD89FC65E07D7E5B6BFFED0D3E1D53C2DE2EF8A771697A2
                D67D32CAE965BAB5F2A2716CCAEB227EEFF48E8A00FC5EF8E9A56B1F107E1DFC
                0EF829E0BFF82607ED9DF0CBE1DFC02F8EBFB3DFED11E03D23E0F9FF00826B78
                5BC17A5EA7FB397C55D03E2CE87F0F74FF000B4DF1CF4B8745B4D526F0FBD8C8
                2CECA38E34D55DD1D580AFA7AC7F6BAFDA8AF209A76FF8259FED75A708A5B88E
                2B5D47E307FC13ED2FA78A0D39AFA19523B1F8CB710279CEA966AAD3AE27906F
                31C0AD3AFE81D1401FCFDFED9FFF000584FDB73F667B2F84BFF0AF7FE0879FB7
                47C54D7FC73E30D6BC3BE20D027F117C15D7ADACEC749D24DFC573E17D57F655
                D6FE2DDD4F249FEB0BEB9A46836C23B498473CEEAEB1747F0D7FE0A91FB5A7C5
                6F8F3FB007C39F1B7FC13B7F688FD8B3C29FB477C72F891E08F883AE7ED087E1
                4EABA6EB1A1F85BF647FDA27E31E8BE12F0847E1EF10A789FC3BABC9AB7C3BF0
                C5EB4BAA784ACE036BA26A36E668A5748E5FDE1AFCBEFDBBAF12D3F6B4FF0082
                3BA24724F3C9FB74FC580B6B6D179F73F6697FE09D3FB6E69D717BF675656105
                B9BFB769651958D5831CFCAAC01FA83451450014514500145145001451450014
                51450014514500145145007C9DFB7AFC4DF1C7C13FD863F6CEF8CBF0C3554D03
                E257C24FD93FF689F89BF0F35C7D1ECBC411E8BE38F017C20F1878A7C25AABE8
                1A8C3716DADADB5FE93A7CC6CE7B79A39843E5BC722BB2B7E3B7ED59FB42FF00
                C1CCDA469B37FC3307EC09FF0004FED612796616F7DA6FED25ADFC4FD562B117
                112DADD592FC4E93E125AEE922DCE1A7B390EC7F9A081D4257EAB7FC14EBECFF
                00F0EDBFF8280C371B7CABAFD8A7F6A3D3D50A193CE9B50F821E37B0B5B54850
                6667964B886258D412CD2AA804915F6C69C8D1E9F611BA9468ECED51908DA519
                208D4A91C6082318C76A00FCE8F0A78EBFE0AD97BE09F09DC7897F665FF827FE
                95E35B9F0DF872E3C536CFFB657C7D8ACECFC43269313F88ED21D2B4CF825A84
                564AB76EEA9143ACEA71C4B0322DD6A20A4E7A2B4F14FF00C15364005FFC09FD
                802CC6F2B9B4FDAB7F688D482C5E4485650937C19B40EC245813CACA82B2336F
                531AA49FA0345007E4EFC67F853FF050BF8F5A6782B45F88BF04FF00E09FBAD6
                93F0F7E2B7C29F8DFE12B77FDA17F6A3B19B4AF89DF05FC65A478FFC01E21173
                A1F812C8DDC767AAE896331B29D658254468A749D1D81F588F54FF0082AD4851
                64F027FC13DEC503C6CF247F157F68ED50B4492C5E6C0901F06D908D9E3F3944
                A64608C1098E61951FA1545007E137EDA1E31FF8385BC2369F0BB53FD8EBE11F
                FC13E3E265F49E31BEB5F883E1ABEF10F8FD2CEDFC30FA50934ED4357BDF883A
                B784DD6DA3B88648DBFB12EA6BC2D770E203124ACB3780FE2E7FC162348F8C7F
                B03689FB6D783FF623F867E0EF8A5FB50F8BBC11E358FF00653F897F193C41E2
                5F10D8D87EC6BFB6378FF4AF0AF8A7C1FF0012BC3EDA6DA696FA9F80BC1FAAFD
                A74FF155DCF1DCF85EC97C978EEAE16C7F74EBE05FDB26E557E39FFC130EC219
                76EA175FB75F8927B6B68E212C93D9D87EC07FB723EACE1482B1C715BCAECCE7
                1B411B7E629401F7D51451400514514005145140051451400514514005145140
                0514514005145140051451401E41FB4135DA7C04F8DADA73C915FA7C22F890D6
                3240D3C72C776BE0DD60DB3C2D68D1CA8CAE2320C4E8C0A8DA548047F367AAFE
                C75FF07077C71FD99BF67DD63F675FF82BB7C12F87FE15F127C05F82FACD8F87
                27FD98ACFE1F789AD62BFF0086FA1DD7D9F5AF8A537FC27DAE6B7780DC4227D4
                619AC7ED522BCFF67B3DC21AFE917F68DD6B4EF0CFECF5F1DBC45ABCAD6FA4E8
                1F06BE276B3A9CE90C93B41A7695E08D6EF6F65482056798A45048C111493B40
                00922BCF7F616B89EEFF00625FD8EEEAEAD4D95D5CFECB3FB3EDC5CD936E2D67
                3CDF09BC2524D6A4B2A9CC6CCC9CAA9F93A2F4A00F953E16FC02FF0082B57867
                E1A7C2ED17C5FF00F0501FD96B5AF1B689E00F02689F106EF5CFD863C65E394D
                47C59A6F84ECAC3C67AB59F8BB4AF8B9E1093C4725C6A70CF710DFCBA168EB22
                3B3CBA7DBB4A22B7ED9BE097FC150F367B3F6FFF00D98702E81D402FFC13CFC4
                9121B2FB14C1A2D3E36F8DF21864FB47D9D834AF281107521DC2B9FD1DA2803F
                2FBC7FFB297EDF5F14FC297FE06F883FB6BFECC3E2AF096A973A2DDEA5A06ADF
                F04F8D66E34EBD9BC3DAE699E24D1CDCC1FF000B9C090417BA3E9D3853C6EB55
                EA2BB21F017FE0A332E1EE3FE0A15F0A6DDF1B4C3A37EC2DA35A59055C08CA45
                AB7C44D42656DA3E626E181272AB10016BF43E8A00FC26FDB63F626FF82CEFC6
                0F87DE0EF0FF00ECD7FF00055AF00FC30F14699F1034ED67C47AC45FB33E9FF0
                C26BBF0A41A36B567736716B7E1FD47C512EAA56E2F34E97FB2E6B1B5867302B
                BDD41F6648E7F14D23F677FF0082A47ECE9F133FE09F379FB637FC15117F6B8F
                0D6B1FB6C7853C2973E00F0C7ECB1F0DFE069B7179FB3C7ED0D240FAD7C4BF03
                5DC37DE34B143A526EB2BFD322F3A5BB5966967686DD63FE912BF3E3F6F76D4A
                0D6FF608BAD1F4F3A9DF5B7FC1417E0D20B313456D1AE9BA87C39F8CFA36BF7F
                2492B2822CB4DD4756BE58D725DF4D8E3504B80403F41E8A28A0028A28A0028A
                28A0028A28A00F903FE0A1076FEC0DFB701076EDFD903F695208E36E3E0BF8D3
                046318C63DBA57D7AA542AF200DA31D00C631C7B718AFCECFF0082BC9D413FE0
                955FF051F934AB996CEF20FD877F6A3B84B8B7B87B496282D7E0B78CA7BC11CD
                195652D045709B411BB7EDFE2AFE75BE16FF00C13F7F62DF1C7C22F849E363F1
                C7F6ADD3FF00667FD977C35E05F10FED5FFB7CF8C3F6D3FDA992D7E357C48D06
                C74AB0F10FECDBFB34783BC2FE314D1D609F5FBB8B4BD775ED134495ED2E343B
                1F0AF8646A5E20BDD56FFC2A01FD9EE57D47E94657D47E95FC8EDD7FC1343F66
                4D3F5787C7DABFC0AFDA6DBE247ED096727857F622FF008276EA9FB7E7EDB9E1
                CF143F86343974FBAD6FF699FDABFC7177E3DBFD73E14C7676FA869D71AC5ADA
                DCBE9DE1ED35B4AD1C5978A7C5FADE99652F209FF049FF00D8F752D1F5CF82BE
                1FF89FF1DAFF0046FD9EE59753FDBFBFE0A43E29FDAFFF00697F0D7C29F84BAA
                F84751B4F1C78EBE06FC00F0CEB1E3B9740BDF125AC366749BCBED4E3D72DBC2
                1A4DC3AEB57DE21F12136D401FD88E57D47E94657D47E95FC8AEA7FF0004E9FD
                85EF75EF0D7C78D7FF0066BF8ECDE1EF8A569AD7C27FD837F61E6FDA67F6BFD3
                3E367ED3BAC89EDAFEE3F682F8CF7BE25F194FA8FC1CD020B0B08F518ADEEA3B
                1B7F0E683AACFAAF893ED1AC6B5A5685A0E0DAFF00C1223F64997C3DE3CFD97F
                4D865D7BE30E83FDB3F107F6E8FDB3BFE1A07F688D2BE02FEC25E16F125945E2
                597E0CFC0FB7F1678B6687C4BE23D3B42529A55A7896E2F9F49B0DBE28F16CCA
                2FF40D0B5E00FEC232BEA3F4AFCEDFDB034AD3A5FDAD3FE0941AEBDA5C49AB69
                FF00B5C7C70D16CAF52E74E5B3B6D335AFF82777ED9D7DA9DBCB652B8B996596
                5F0EE8CD1CD046D1C6B693A4AD1B5C5B093F02354FF8264FFC1343557D0BF695
                D47E03FED27F0EFF0064FD2574EF879FB387C29D07F696FDAE25FDA03FE0A4DF
                13BC53A0DB5A781756F05F8026F1EADCF817C37756D65F6DD2A2B78BC37A96A2
                7FB4BC47E20B8F0BF86F45B87D5FC77C1BFB15FECE3FB077FC14F3FE094F6FA0
                DE78C743FDAEFE21FED4BF12BC43F143E12F873E2EFC7CF8DDF083F664F82DF1
                33F655F8DDA27C39F81A9E35F899AB6AB0DDEAD76DE1F1792DFEA9A87F68EAF3
                59F892FECAD2C740874BB0B200FEDB28A28A00680413C8DB850AA1718C75E7A6
                31B78C0C63BE461D45140051451400514514005145140051457E487FC1577FE0
                AA3E19FF008275781BC09E0BF007C3ED63F689FDB5FF0068DD46EBC1BFB287EC
                BBE0FB5D4351D7FC7DE290D6D652789BC490E8F1C971A5F87F4C9AFEC9A668C2
                4D76E45B5B1882DF5D698019FF00F053BFF82ABE93FB10DEFC2CFD9EFE027C36
                9BF6AAFF008280FED19E20D33C3BF00BF655F0B6A4B0DF4B6371791C7AB7C49F
                8ADAA59891BE1E785EC2DE3BE93FB42E922133594CC1A0B1D3B5CBED23F59BC3
                B73ADDEF87F42BCF12E9165A0788EEF47D32E75FD0B4CD5DFC41A768BAD4F650
                49AA693A7EBD25AD8B6B705B4ED3C31DDB595999961590C16FBFCB4FC4EFF824
                57FC12C7C6DFB2B6A1F127F6D4FDB77C696BF1F3FE0A6DFB5588359F8E5F14EE
                C586A9A67C2AD024589B4DF821F096EE28238F46D2AC2DEDF48B5BA3A725BDA4
                87C3F6169691A69FA469BBBF72A803E06FF82A8EA16DA3FF00C135FF006EED5A
                EE582DED749FD947E396A53C97051615874FF87BAE5D3AB6F2AA4B0876852CA0
                965195CF1B8DFF00052FFF008270C29BA5FF0082807EC4B122229667FDAABE04
                A2AA9518249D780031B79E3B7B57997FC164E28A5FF824DFFC147D248E39117F
                62AFDA36455745651243F0B3C4B2C2E148C06478E365200C14523040AFC03F84
                7FB10FFC1327C67F037F65DFDA17C49FF04FBF84BF0F3F64BF0469BF0A740FD9
                CFE1A5F7C03F0D6AFF00B667FC14B3F693D53C3290F87FFB4F56F105B5A78835
                7F063DE9D625B7D335A4B41E221A2DF78935D7D17C19A3C2DAC007F47F3FFC14
                FF00FE09A76B6A6F2E7FE0A1BFB0D5B592C5E69BA9FF006B2F8090DAAC21A38F
                CC33BEBE102069225DD9032EA3B8CE2FFC3D8FFE0962303FE1E57FB00F4E31FB
                62FECEF800638C8F11617B71C7E95F8E3A57FC136BF659D23E22F8D3C15A67EC
                2DFB056B5FB7A7C7FF000968FE31F1FE807F66BF843E2EFD8FBFE09B1FB3FD9D
                CDED87852EEF3C32746B1D3BC59E24B8126AED6F23C306ADE31D6ACF519CBE89
                E0EF0D245E1CE034CFD823FE09617DF06BC32749FD97FE0C59FF00C13BBE06F8
                934D7D43E3D5E7C1BF873E2EFDA5FF00E0A65FB44DAF8B628BC2FE05F82BAFE8
                1A5FF6F6B7E14BEF112DFDAF95E1B8F4DFF84A6FAFAC742F0CDB69DE12B2BD5D
                7803F6C2E7FE0B0BFF0004A2B390C32FFC148FF61E664DA336BFB4F7C1CBD8B9
                8A2906D9ACB579236016441956382ACBC323854B4FF82C2FFC128EF2786D6DFF
                00E0A3FF00B1199A6748A2593F698F8436E8CEECA889E64FAB22264951CB0FC3
                15F9511FEC59F0153E2D2DCDCFEC07FB166ADFB7F7C74F01B5B7C30FD9887C09
                F847AE7ECE7FF04F8FD9EE5BCBE783E2CFED2773E0AD1D2D3C6DAF5EDD59AACF
                78CFF69D7352D313C35E137D2B47D33C55AED79843FB0BFF00C13764F843E3BF
                06689F09FE07695FB10FC1AF17789B52FDB5BF6F4F127C13F8713FC58FDAE7E2
                E5DEBB247E34F80DFB2AEB3E17D17ED1A06972F881ECF40D46F7C09676D0C12B
                45E0BF03C0BAA2EA777E1D00FDA2D3BFE0B17FF049FD4EFCE9B6DFF0521FD88E
                2B8585E6F3350FDA5BE11E8FA7F971BF9655755D575582D4BE471189B71182AA
                4106BC1BE2D7EDB9FB147ED0BFB5CFFC1303C1FF0000FF006C8FD973E3678D74
                8FDB07E2A6A97FE05F841F1EBE127C4BF145B688FF00F04F3FDB8B45935FBCD1
                BC1BAB5EDED85AC17D7FA358195A1488CFAFDB444F98F02B7C41E29FD93FF665
                F107C41F877E3EF88BFF0004EAF801E34FDA0BE22F84B55D23F61AFF00826D1F
                81DF0CB4EF077C12F855722C2C359FDA3BF6E3BED2748BBD3748B9758B4837F7
                DACC77B67A0AAD97867C3167AF78A2EAFEEB5EF8E6CBF669FD903F656FF82947
                FC12DBC37FB3F7C25F06F883E34C3FB727C54B1FDAEFF6B8F843F097E1EFC28F
                8249F197C49FB29FC69B13FB2BFC2CD07C32915B7876C7C3F0E9C923F853408E
                EE2D120D2F4F6F10DFEA7E26D6EEAEEEC03FB41A28A2800A28A2800A28A2800A
                28A2800A28A2800A28A2800A2B275ED7743F0AE85ACF89BC4DAC697E1DF0DF87
                349D435DF106BFADDFDA693A2685A1E91672DFEABABEAFAA5F3C706996B6B6F6
                F3CD2DC4CF1C71C703BBB22A311F819FB137FC14F7F69FFF00829A7EDEFE27D5
                3F641F87DE0FD27FE091FF00006C7C5DE01F1E7ED0FF00123C3BAF43E32FDA6B
                E30FD89E3D35FE013ACF6CBA4E9FA55E2E99216B9B4B843A7FDB25BD36F79ABE
                8B69A6007D4BF147FE0B9FFF000498F829F10FC7DF09BE297EDB3F0BBC1BF11B
                E1778AF5EF02F8F3C23A9699E3C9354F0E78AFC2FA84DA4EBDA25CAD8E8F2C73
                CB6D716D3C2C6DDE542613B59C015F7AFECE7FB487C10FDAD7E0FF00857E3DFE
                CE7F10B47F8A7F083C6AFAEC3E16F1C6836FA9DAE99ABC9E18F10EA9E13D7638
                2DB59B7B5B984DAEA3A1EA96AC25823F9ACD8AEE528CDFCCBFC17FD9D7F67AF8
                A1FF000747FF00C14CBC3FF157E0A7C22F89FA5C9FB13FC07F88161A0FC45F86
                7E0FF1B691A7F8AA6B2F811A3EABE27D36C7C4965756FA7DFCD1CA165BA8D126
                97EDF312CDBA5DDFD517C3DF86DF0EBE12784F4DF017C29F00F82BE19781B466
                BC7D1FC17F0F7C2BA1782FC27A53EA3793EA3A83E9BE1CF0DDBDB59D899EE2EA
                EAE2431429BE4B891DB733B12011FC4DF893E07F835F0DFC7FF177E267882D3C
                23F0E3E16F82BC51F113C7DE29BE86EE7B2F0DF82FC15A1DF788FC4FAEDD5BE9
                F14D713C76763A6DECED1DBC32C8C2DCAC69231456FC7983FE0E42FF008225CF
                7B63A747FB7AF80167BF9E1B5B779BE1F7C6EB6B18E49AE6DAD236BDD4AE3C2E
                96DA6461AE622D2DCCB0C6889248CC91C32B47FB57AD689A2F89745D5BC37E23
                D234BD7FC3DAFE977FA26BBA0EB5A7DA6ABA2EB5A2EAB692D86A7A46ADA5DF24
                906A36B7304F3412DBCD1BC724733A3AB2B107F96BFF0082D0FECB3FB33FC3BF
                DAAFFE08617BE04FD9E7E0C78262F117FC14F7E1BF83FC4D6DE0CF83FE02F0DE
                9BE26D0F57B5B4B83A4F89E5D1F478E2D4E15974EB7912CEEA60AE166648A530
                992D403FA07FDB6E4897F62EFDAE2579238E05FD983E3D48D33B05863897E157
                8A98C8CDD15554673E83DABF17BF636FF82FDFFC1223E1BFEC6BFB297833C7FF
                00B6D782B46F16F81BF66CF817E0EF1AD8DC782BE30EA0FA378BBC37F0BBC35A
                3F88746BED474FF0ECF6F2DCDBDE69D7B0B849A4CB22ED2E2588BFEE2FED5904
                771FB2E7ED236D22A98A7F809F17E0752A0A98E5F87BE218D94AF008C1C638FC
                2BF99DFD94BC4FA6B7EC2FFF0004F7F157C44FD9F6F34AF84FA47C2FF815A37F
                C139BFE0999E1EB0F0BE89E34FDB3FF69FD3FE1E683E27D63F6AEF8E1A55A3CD
                63A7786B4FD76E35FF0016E9B26A6D258E9965A7BF8F35BFB66B37DE17B1D0C0
                3F4B74DFF838BFFE08B9A95DB580FDBA3C0DA4DC25A6B37A17C4FF000F7E35F8
                42092DB41B816979F67BAF147862CE1B8791B06DA18DDA4BB505AD52E15588B5
                A97FC1C4BFF045DD26DE5B99FF006F3F8697504059666D13C25F16BC4461F2ED
                E2B82D247E1FF0EDCB22149061CA85631488A4B432AA79269D61F18B4BF8CFE3
                DF0DFC3ABDF007C70FF829678FFC37E1ED3BF6C0FDB3F59D134FBFFD97FF00E0
                9B3F07E648FC4BE1DF825F0E3C2FAE5EC1777F3DAD8EA9A96A9A3782E0717BAD
                DE48BE28F1ADD695657DA54727CE83C3DFB38EADF002DED4FF00C25DA57FC12A
                BC21F13776A122D8FF00C253FB49FF00C171FF006ADF156BD05CC0EE2CADEC75
                1F8A7E18F11F89A0954C8B85F1D4F6EE48D33C11A4ACBAD007D78FFF00072AFF
                00C113A3165BBF6D8B3FF8982EEB154F801FB52BB5D288A39BF711C7E0725C04
                746C01D33FDD38CD93FE0E66FF008227A4B75043FB62EA17B258A96BB4D3BF66
                8FDAD2F4DAC696B717924938B7F021F21238AD5DD9982855284E030AE684BF17
                5FF688F0E5FDD783BC09E39FF8299F8C7E1DCD67F04FE0B426DFC4BFB387FC12
                0BF652F16BAE8D71E3AF1DEA7A52C316B5E25D663D0A186F26B06B0BDF16DFF8
                797C3DA0FF0064786343D6B568BC66DFC3BF04F52F839F12FC31FF000B2FC4DF
                F0EF4D13E25EA3AF7EDDBFB616B51CF79F1ABFE0AD7FB4E6A3AD69FE1ED5FE06
                7C2393C1F14777E25F085FEB30D87856F5FC31008F541A4DA780FC276FFD9506
                A972003E82B7FF00839B7FE08B3756DA7DDDAFED5BE2DB8B4D5AF63D334AB9B7
                FD947F6C196DB52D46488CD169FA7CD17804A5E4EC8A5C4311662AA48040AF06
                F8BFFF0005BAFF00826DFED7BF1DBF608F80DFB3DFC77F13F8A7E29CDFB797C0
                CD49FC3DABFC07FDA1BE1AADB69F7DE1AF893A159A5DEB1F127C29A3D9C0D793
                EB36B045019F7CAAF310BE5C333C7DF4B75F18AC3E2E7C2DF17EBBF07BC21E27
                FDBC3C73E0ED4B46FF00827D7EC2E16C60F813FF0004C0FD9AA5B27F0D5EFED1
                1FB465E785965B3D17596B2834ED3F56D4B4A8E59EE2E163F02F82CBD98F11EA
                D73F9D9FB4FC1A2E91F1D3FE09A9A27C20B4B8FDA03C2BA47FC16CFF0064A93F
                6C1FF828978E753B7B5F177ED1DFB68C7A1FC5EF0A37C3DF869A469D6E961A97
                863C13A58F13584F069335BE85E1E6BBD1BC3DA1C77F7765E2C36001FD9DD145
                14005145140051451400515CBF88FC6FE0BF06A44DE2DF17785FC2A935BDD5CC
                0DE22D7B49D0D65B5B1117DB6E223A94B10923844D06F75C84F35376DDCB9E1C
                7ED07F00CDAB5EAFC6EF8426CE3D460D1DEE97E24F830DB47AB5C5E8D32DB4B6
                985EEC4B892E76DBAC048769088C296C0A00F993FE0AB63FE3571FF052500C4B
                FF001809FB6200660BE42FFC63BFC4400CA1815D838C8208C03C1AFCBCF85DAF
                F8A2DFE16FEC55F15FE287C1E373E2E1F0F7C03A1FFC12D3FE096BE1AFECAF0F
                2E81AB691F0F347D3ADFF699FDA56EF4E8AEF4FF00095EE87A4DCFDB24BD7B69
                34AF01699AC9B6B64D7FC57AD5846FFA77FF00052DF15FC3BD4BFE09DBFB7C78
                7F54F1D782B4F8759FD917F69CF02CEDA8789740B6862D6F5EF823E39D32DB44
                9BED8F246B75234FB56D5E291D8F02293EE9FCB6FD9622F12C1E03D0BC39E07F
                8BD0EBFF00B4CEBBF00BE0A6B1FF000505FF008285F892C74AD27E1FFEC75F03
                A2F875E1FF001AE8FF00B33FC038F5E924D23C23AE43A2EA097963A3299EDB4B
                FEDB9FC6BE2B17F7BA8E8FA7EBC01EBD2DB78AEC3C47F1CFC35A67C7DB2D3BE2
                4AE9716B1FF053FF00F829ADC59D97843C19FB3CF807C39A5EA3AED8FEC9BFB2
                75CF88E4B9D37C117FA3586A57F2C50C977A92784AD7C433F88F5F6D67C4FE26
                B5FB7F3773A9F83ED3E1F7C06F126BDF0975FF000DFECD7E1CD7B4AD1FFE099B
                FF0004C7D07459341F8AFF00B57FC44F0D5B43AD7827E39FED0BA5F89DA5BBD3
                2D2CEEFCCF165B69BAFC505BF8760893C63E329EEB5D36163E15D09B56F85FA9
                7C31F85BE261F07FC769FB18FC31F1A699A7FEC09FB21E92FAC4BF173FE0A27F
                1E6CA58FC6BE15F8EFF10B43F16C91DFDF68316AF6BAD78934C93C6374C97525
                A5FF00C43F164D0C56DA1C967DAD8DA7C62B1F8B7E32D1742D7FC1BE35FF0082
                8AFC48F0C69E3F694FDA66DF4D8B5CFD9F7FE098BFB3C6B1676FAF699F09FE1B
                1F142C69ADEA621B38F50D2FC3B7115ADD788F5153E2DF14C1A46890E8FA7500
                10D9FC4A87E287C41D034DF8A5E17D47F6CFF16F8320BBFDB83F6C38EDAC64F8
                3FFF0004E8FD9C923FF84C74BFD9F7E059F122476165AE4D6D7325D6996BAA19
                6495ECA7F1DF8C6092D20F0A681ABF9B6AEFF07350F847E05BCD73C33E24D13F
                E09BBE1DF1559693FB377ECC3A7683AAF897E3DFFC1567F688D7357D53C5763E
                39F1AE8BAE39D5FC73E19D6B5BFB5788AD6D35B30B7892E2D754F1A78BAEADBC
                316F04977045A97C1AD67E0F7852FD2D7C7ABFF04E2F0AF8E218BE1F7840DBDE
                F8B7F685FF0082C6FED3FAE5EDE6AFA7EB37F6F7CD05FF00C4CF09EBDAC69F79
                AAA36A06DE2F1ADC5A4DAAEA2FA7780F49493C4BE9AAFF001AEEFE37EA171041
                E0BF1E7FC14FBE207C3F821D13C3B3CD77E32FD9BBFE0945FB35F8D65BA874EB
                BD6A7B04821F10EBBAAC9A25CCD32C2DA7EADE3DD5BC366CED64D0BC1FE1A7BA
                F0D806B6A5FF000BC25F8D9A7C973A8F817E26FF00C1493C61E09B77D0742161
                71AFFECC7FF04B2FD9EFC61205F127887527865B693C5BAEEA6BA7DD59477F71
                3586B3E37D43418E0B3B7F0B784746D71B41FCF8F887A858EA1FB56FFC12561F
                80BE1FFF00848FF656D27FE0A53AF0D77F6B6F1F6ACFACFC56FDB6BF69ED4FF6
                5BFDA36D7C79F18742BFB18A0B5D73C33A7C7E1BD634A6D74C16B637D70D6565
                E16B4B0F0DF8674FFB5FD536FA57C15BCF82BE3BF06E81E3CF177877F605F0E7
                8AAEF54FDB6FF6C6F120D763F8DBFF000535F8E126A5A6F853C43F0DBE1B7897
                C311D9EA5F1034AF11EA7A75A787756D6BC396A6DF55892C7C0DE0AB53A69B86
                D23E68FDA6EF75D9BF6EBFF822B78C7E34F88AD3E08F8BFC4DFB628D33F66BFF
                00827E689ABE91A4C5F02BF661D1BF678F8F1A0AF8D7E23F82FC35753E9FAC78
                C6FEFB52F869A7DEDC5A6ED33C3F1476FE1FD19EECC5AFEA3AE007F55F451450
                01451450014514500145145001451450015FC887FC1627C39FB63EA5FF0005DA
                FF008264DE7EC1527C01B4FDA60FEC95FB492F82B51FDA5ECF59B9F855A5E99A
                5CDAE7FC25B79747C296F73AA437A74BD635382DDADE06C35D01F2A3DC11FD77
                D7E5F7C66FD93BC0DE37FF0082AB7EC5FF00B5D6A7FB447833C27E3CF827F00F
                F687F00F863F66DD474FD224F1BFC59D27C73069B6BAD78D3C337D3EB76D7905
                9E8035184DD7D9F42D4907DAAD9649AD3CF52A01F9C11785BFE0ECC91C2BFC48
                FF0082335B27EF1B7FF67FED22EAB88C98E30ABA0B1C12AAA0E38DFC9C0E2FDE
                7C32FF0083AEEE7220FDA27FE08DBA68DA369B2F0B7ED20FB729B30A2FFC233F
                4203720F27B818AFD56FDAA3FE0A93FF0004FBFD88FC79A2FC2EFDAABF6A6F86
                9F05BE20EBFE14B7F1BE93E10F13CBAD4FAD5C784AEF51D5747B2D75ED343B2B
                BFB1DBCF75A0EB1044D3188C8FA64C230FE5B63E579BFE0E21FF00822DDB8937
                FEDFBF08D843179ADE468BF126E729B656DB12DB684C66602071E5A066E506DC
                C918600FC86FF8287F837FE0E57D03FE09E5FB6A5BFED17F15FF00E093BE3BF8
                1DFF000CD9F18EEFE30DDFC3FD13F687D3BE2D27C2F4F00EB67C6FA67C3A5B9D
                0B4BD17FB47FB3AD6F7ECCFA8C057CEBF1BA5448D4C5F697ECBB73F1A6D3C11F
                B2EDC59CDF0FFE377FC1487E267EC9DF0A5FE146831C7AA5E7ECBFFF0004D6FD
                94758F05786F4687E246BF6D73F65BDBCD575D8AD6CE5BB50F6FADF8CF58B37D
                234D6D0FC27E1AD42F3C3DCD7FC143FF00E0B9DFF0491F8F9FF04DDFDBDFE1D7
                C2EFDB77E1578A7C71F103F642FDA4FE1D781BC1DF65F1C7873C49E28F1CF8B7
                E0D78B343F09687A3691E24D2F4F9EF5AEEFF53D32DD645530E6565762A9281E
                7FFB1DDC7C08BAFF0082797862DBC37E35F167C3BFD8761F823F0BBC57FB7CFE
                DB7AB6BFADDD7C63FDB03E310F06F84BC0DAC7ECA5F067C43A5C4BADEB9A7D8A
                D8D8F81AE355F0DAB1821B0D27C0DE0B82E2FE5D56EBC3201F435CD9FC20D43E
                0EF8D34D9BC61E3183FE09EDE14F195CDF7ED49FB464371A9DF7C7EFF82B37ED
                39A86B36BE12D5BE177826DBC150A6A5E35F09EAFAD416FE1FBE5D1A2862F113
                C163E0EF0D5ADBF85B4FBDFB67A6EA03E2EC9F12BE1AF8AB5BF84BE07D4BF6D4
                D53C2B269FFB0B7EC532EA767A87C15FF8274FC159B4A1E11F11FED11FB42DFF
                008224FECC7D685ADD7F665E5F68ED23BA5BC7E0BF044B24373E2FD6B55A8DAE
                78C6C7C77F04355D4FE10E810FED3FA9783F57D37FE09B1FF04F18E46D17E1AF
                EC6BF0834AD12EFC1F71FB4E7ED490F85649EC3C33A8DA691A8596937DA8DA40
                E9A35BEA70F827C2297BAA6B5E22BFF11632C7A0E95A7FED13A1E8DFB405F47E
                06D175B8BC4BFF00055EFF00829C6A77D178435AF13DFF0080F407B5BDFD943F
                668BDF0AAECF06B6916A62D1E64D06EA54F0759EBD7D63632EA5E38D7B52D434
                C00A97D67E066F871F183C2EDF17FC471FECB5A178AA5BFF00F82907FC141EE3
                579743F8ABFB657C57D3E6B4D075AFD9AFE045D781627BE8B4BFB65C691E0BBB
                97C2AD047A55AB0F03F840B6B51EAD73E1CEAAE6EFC47A3F897E09F8C3C53F02
                ACECBE251B43E1FF00F825DFFC130F4B9B48D0BC39F047C3FE1ED12C745BFF00
                DA83F69A5F0DDBCFA67812FF0046B2D5916EEF634D42CFC1FA66A969A16849AD
                F8AFC44F1EAD8B75AA4560DFB3C6BFA87C00FECD7D1F538B4AFF0082527FC12E
                ACD6DBC11756AFE0EB38B4C4FDAF3F6A3B78E2BAB7F00C7A0586A91EAD1ADFD9
                5CC5E0CB1D4AD8F95AE78EFC47A4E99A66AE8565AFC3E29F8F7E13F09FED0167
                A8FC61BCB68EE3FE0A6BFF00052BBABAD23C39E09FD99BC27E12D3EE75CB5FD9
                5FF661835C6B8D2FC197FA2D86B3AD1B6B196E6E20F095B6B97DE26F12CFAD78
                9758B6B7D6C032F43D27C4FA7B7C7CF01F83FE3C5B69DAFD99BDD7BFE0AB7FF0
                558D623B2F07C5E15B8F0F595CEA7AAFECD1FB294DA9DCDC5A7816E3C2BA35EE
                A76304826BDD33C05A7DC0B8BB97C41E31D5355957E45F8A7A6F8BB52FDA4FFE
                0875E20F027C36D2FF00662FD8A7C23FB6D6ADE02FD97FF67AD73C3F3695F19B
                E2068D7FFB2FFC78D6EE3F68DF89365AA49F6DF01437CBA7491D9787AFE39757
                75F16DC6ABE229A1D4B588F4ED1BE9D9355F83D75F0D7E0C789FE217C2EF11F8
                43F636D13C4FA0F877FE09C5FF0004FAD32DF5087E2F7EDC3F172D3523E2CF08
                FC6DF8C3E08D5EE12EB5E86F2FA08BC51A6691E2F945BE9D1CD79E39F1ECD6B7
                C96C3C27F2C7ED53F67B6FF8297FFC128354F8F7E3B1F137F6DCD43F6D7F0EEA
                3E2EF07FC3DB0D6AF3E097EC6DF04FC65FB387ED13FF00087FC02F0E6B873696
                7AAEBF79696FAD5EEA5AABC3ABF8A9BE1DCFA9259E8FA2E8FE1ED374D00FEAFA
                8A28A0028A28A0028A28A0028A28A0028A28A002AADEDED96996575A8EA3756B
                A7E9FA7DACF797D7D793C56B6765676B134D737575733158EDA28A38DDD9DD95
                5550924006AD57F291FF00051CF1BFED57FF000569FF0082857C48FF008224FE
                CF7E29D4FF0066CFD96BE00F84BE1CF8F3FE0A29F1F34DD5AC13E207C47F05FC
                52F08786BC6BE16F837F0C74B8B7490D8EA167E25B1B5B9698AC7732FDB45EA8
                B0D356CFC4A01E4BF183E337C68FF83933F686F16FEC7BFB2CEB9E20F85FFF00
                046EF819E31D2F4FFDABFF006A7D091F4CD77F6B7F15E87369DAF5AFC1CF8552
                6A9145247A589ED2297CC8619E34862B7D5350212F3C3BA76A5FD607C14F82BF
                0AFF00673F851E02F81DF04BC11A1FC39F853F0CBC3961E15F047833C3B6ED06
                99A268DA7A1091AB4ACF2DF4F348D35C5C5E5CC935C5CCF773DC5C4B3CF3CD23
                E0FECE3FB397C17FD92BE0AF803F67BFD9F7C07A2FC37F84DF0D3448743F0B78
                5F43B758A28E30CF3DFEABA9DD1065D6751BFB99AEAF6F351BA796E2EAE6FA7B
                89DE5966919BDBE803F979FD9A16E21FF83B0BFE0A288CCEB6F75FF04DAF83F7
                31C603A45208359FD9A6DA390A9C2CA5185D286038DECA3077E7FA86AFE14FC6
                3F033FE0A69E2BFF00839DFF006ECF0EFEC81FB69FC32F82FF0013F59FD903C3
                1F1124F885E3EF827E13F19E9361FB3CDC6B9F04B4AF0DFC1783C17A859DFA5D
                DFE9BA8DC787D8EBA8D0C93C5A14B24D242D7DF656FD6393F62FFF0083955C30
                4FF82CB7ECC70EE915D4C5FB107C313E5A04DBE4A0974261B09C365833640C10
                38A00FE926BF9FFF00F82E3C16C7E2E7FC10FEE19B17717FC165BF66682040D8
                06DA7F0BFC467B96D98E76B5B598CF18DD8EF5E42BFB0D7FC1CB8F23993FE0B7
                7F00ADA362A516D7F614F81B388C6F5063459FC2EA76842C41676398D4701891
                F911FF00055DFD93FF00E0B73E01F1C7FC130DFF00687FF82ABFC38F8D177E34
                FF0082997ECEFF000D3F67ED57C3BFB297C2CF8747E0D7C79F180F135A782BE3
                26B1A6786F46B787C6D6BA5416FAB2BE8F7D24F0CDF6F28636196001FDAFFED4
                4A5BF666FDA21114B337C0BF8B4A88AB9249F00EBE155540C92780001E95FCCC
                FF00C136743F1FD9FECD1FB26F83FE0A7C5497E2C7FC140BE337FC13FF00F657
                B9F8A3FB5378E7C2DA45E7C2DFF8262FEC2FAEFC2BD1750F86BE07F047872DDA
                DF4B8FC457B69A7594961E1C37AD79E24D674DBAF16F887FE247A169F615FD3A
                FC63D3EE9FF679F8A7A5EBD756FABDEB7C19F1BD86B37B1597D82D754BAFF842
                353B7D46EA3D39649059473BF9AE2012BEC1285DCDB727F93BFF00827C7FC2AC
                D5BFE0941FB30DA78A7E1FF8BFF67DFF008275685F073E09AFC74D16CBC3BE23
                93F685FF0082AEFED71E28F02E85A3F89FE08FC3EF0FACDFF090EBDE06B8F10D
                A2684B05BAB49E2B8F4AB7D174EFECBF0668D7CDAC807D912695F06BC6FF00B3
                96A50DD78B3C69F07BFE08F1F0DB5EB9B6D72F62FED4F137ED1DFF000586F8C3
                E24F1633F89351BAF10DBF9BE25F1A7857C6FE23CDA2C7A5C326B3F126EBC4D7
                296CF61E1D7B15D7FD3EF25FDA05FE2E7C36F883E26F0378675CFF008295FC55
                F03EBDA77EC7DFB25DC6A91EB9FB397FC12DBF668D55A1F0E7897E377C62BBF0
                C470C5ACEBAD69F62B4D6355B79629B5ED460B7F067850D869569ACEA6D2EB7A
                AF8EA1F8CBF09FC45E35F82FE1FF008BBFF0527F107833EDFF00B20FEC7762D3
                6A1FB32FFC130BE0C6B5E6F86C7C55F8DDE32F0F5BC9A7F86F553669736BAB78
                A2DE337FAD4DE1897C2FE07B58ECAD352BABBE1E1B7F08DE7827F684F0B69BF1
                F7C49A3FECFBA1EA3A86B7FF000552FF0082ACEA3AADA785FC6BFB47FC45D023
                8F40F117ECB3FB2FEBFA30F33C35A6E96254F0B4973E150D6BE19808F0AF86DA
                F3C5B75AE5F68801058E85F0E93E1BFC7DF07E95F1CF5FF0A7EC31E07F1478B3
                C45FF0535FF8282F88E773F18BF6FDF8FB6DFD8FE18F1CFC0DF835E23D01CCDA
                6E836DF608BC1DAA5E7866CA778858D9780FC1D1C3796BAADD69DD1EA9AD78EC
                F8C3F679F89BAD7C1DD3ACBF686D6B48D7B41FF82467FC1332EA3B5F08F833F6
                5FF01D878413C23AD7ED63FB55E9FE1D411F86AFB48F0F6B56F1DFC69BE0F0CD
                8F886DFC29A125E7893C417135D5289A2B49FF0066DF1878A7F66AD52DB50D2B
                46B7B1FF008248FF00C124B4EB6D3BC3D078034DF075AE8767A7FED7DFB59E99
                6E97565F0E750D020D67C3D2497FAA9BBB6F035A788ADED2DA0D53C69AE2452C
                D15B6BB6DAEFED17E11D37F69116DF1261D3E3D73FE0AD5FF054B5B6D27C2DE1
                9FD9EBC15E15F0F7F6C41FB197EC797DAA48F6FF000EEEF48D3F53D526B6453A
                BC7E12B6D6B50D735A9754F18789A0794028C5A3E9BA7E9BFB517807C3FF00B4
                DF887C3DF0ABC1371AA78DFF00E0AF9FF0550B99A0F0B7C40F1FF8F7C2DE1FDB
                ADFECAFF00B396B9A5DABDAF80E0F0D6901F4EB997419AF7FE10BB0D42D743D2
                8DC78A751D52F349F86FF6D1BBD4B50F187FC1147C4FAEDDBFEC91F0A26FF82A
                CFEC59E15FD80BFE09F3A558E9DE0FD7C7ECE5A0DF4BA6F897E3BFC72F03EEFB
                75AF882ED35AF0AD9DB68E63B64F0AE9FE3286CB5059F59F12EAC2D3ED8B9BFF
                00065AF853F66ED6B53FD9E7C576FF000574DD62C749FF008250FF00C129B45D
                397C3BE3FF008F5E3CF0A5B49AED9FED57FB57D8F8A7CD6F0D5A694D341E2889
                FC4F23C1E18B7BA3E23F110D5BC5FAAE8FA7E87F1C7EDB1A4E9BA5FED23FB0FC
                1E2F7BFF00DA8BF6CD9BFE0AD1FF0004DFD47F6C1FDA57C36B616BF01FF64DD2
                1FE29EB9A87C2BFD8BFE0F26AD762FB45B781BC5975A92787AD60BFD4668B50B
                8F11789E7B19F5AF0DDBB807F627451450014514500145145007F293FF000588
                F83FFB2EFC66FF00829C7C36F08FEDBDF066F3E27FECB3AA7FC1333E2BE9DE37
                F897A1470C1AE7EC71757DFB4AFC3AD26CBF6A8935032BDCE9FA7E9577AB7877
                4DBBD4EC6C674D22D359BED47584BAD060D73EC5E55AFF00FC1253F643BFD7FE
                1EFC19D73F63CFD8EFC37FB667C34D3B5EF1D7ECC9F10ECFE14786FC3FFB1BFF
                00C153BE0F45E1E67F137833C51A0688458F80FC7234A68EF2EECF4E956FF41B
                ED3AD7C51A049AC785E4D734B8BEFEFDB3E0F8DEBFF0595F819AB7ECF3AF7826
                FBE22787BFE09A1F1C35797E027C43BED1348F0AFED51E0A83F694F83B0F8E3E
                07B6BFAAC33BF84751B8D3E5B8D574ED6208258ADAFF00C3164BA8ABE9171AC2
                B718B6BF0820F815ACBE9FA778E35BFF00826A6AFE2EB6B6F12F80CC3A9E87FB
                51FF00C1183F699F09EA0CD77ACE87A7DA1B8D5FC1FE12F0C6B371657925ADA4
                F70FE0DFB47DBB4DFED7F87FA93A786C03F2B3E3CFFC133BFE09B9E04FD9ABF6
                C3FDA1BE117EC0F6BE3DF837AF7803E2B681F17FE0BCDE1AD6B51FDB1FFE0999
                FB58695F0D2E6C2D6F748B0B4D46E351F11782C6A69E1ABFBCD3EDAEB554D353
                56B7F136833EB7E11D5671A6FE837ECED07C3AFF008616FD912E3C49F03F5DF8
                65FB0B58E85F09349FD99FF613D13C371DA7C79FF82917ED3DABE89A7F8AECFC
                5BF15F41F125CC43FE114B9D76CBC43E23B7D1B5DBB116A70F87E6F18F8BEFAC
                F41B34B31B1FB52699F1AE2F09FC70D1B56F1BF82BE13FFC14A3C1FF00B24FC5
                18EE3E21AE9F2699FB337FC15A7F652F06FC39F115B6ADAAEA5E1ED20C634AF1
                7F872D75D7BE7B3B646D4BC21AAEAF8B09B5AF06F882737F37EC9707C5BBFF00
                097C02D37C2DE35F05FC62FF008299FC4CFD91BE106A1AA7C5F5D0EFF54FD9B7
                FE0973FB22F8E7C0FE18FF00847DBC2BE12D6679ADAEFC47AE5BE8D65776FA44
                B3A6ABE32D634D96FF0052934DF087872DE1D2003E98FB3FC67D43E3C789F4CD
                33C4FE07D7FF00E0A1FE28F87DA6FF00C2EFF8D09127897F679FF8254FECBDE2
                993FB76CBE1CFC35B3D7A1B687C65E2BD6FF00B18DDDBC37F059DDF88EF3494F
                10F881346F0C685E18D11783B783E0D5D7C0EB29AEE3F17787FF00E09A76DE2F
                B487C39E1F58B51F197ED31FF0586FDA07C69AA2DEC3E21D5EECCB16A9F103C2
                BE30D56DE39E2B794C7378E944B757AFA4F80AD122F14648B6FD9FEFFE07C62D
                DFC683FE09BBA3FC43B97D72F2679BC5BF1FBFE0B35FB5478D35AB5B3B6B7B56
                2F6FA9FC57F0B6BBADDA4D1B063147E389AD60B7823D37E1FE85FF001567AA05
                F8C0BF1AB40D535BF0EF83FC6DFF00052BF88DE0EBC7F831F0863BB9FC55FB3D
                7FC129FF00661F1246DE1E9BC6DE2CBAD304561AC6B77234F9A0BCD42D7EC1A9
                F8D354B197C3FA13E99E16D0756D434800DC4B2F8D527C65D1239AD3E1FEBFFF
                00050EF177C32BE9FE19F81E4B4B6F10FECDBFF04B0FD987C45AA9D1A6F116A5
                69A5C967378CFC49ABA69D6FA74B35ACB6975E2FD4FC1874DD39BC33E13F0FEB
                37DA6F8DD8DAFC20BEF831F166CF4BF1E78BFC21FF0004FAF0D78FEEEEFF006A
                6FDA96492E2FFE3FFF00C155FE3EEBBABC3E1AF16F823E1DF8A3C0ED6DAA5FF8
                7351D77FB03C1F25E787ED125F1149127833C236BA578774D865D4F5ED63F859
                7DF0BFE2AE843C6DE258FF00622F87FE29D45FF6DFFDB02EB55D417E327FC14B
                7F6888993C13AEFC18F855A9781D86A7E24D1E5D7BFB2BC2B7ABE1D9615BABAB
                1D3BE1BF842D16C6CB5582C3A7D46FBC4BA1FC4AF83DE2FF00197C25B0F117ED
                3BADE89F64FF00826D7FC138F48B9B6D27E1A7EC67F0AF40F0D47E0ED5BE3FFC
                7C9BC2B0CBA4784B52B4B2D69ACF55F128B7B8B7D0ED755B0F04F839753D4B50
                D4EF3C5C0136AD75F14EDBC6FF00047C65F15FE11F8575BFDA5F554D7FFE1DB9
                FF0004E1D0754D3B47F87FFB2AF81F41D0AD7C3BABFED09FB4B6BBE1D9EF74A9
                755F0EE91AC689A7EA5E20D3AD6F74EF0E1F165BF857C1EBAC6A7E237BEF117E
                757C7BD1F49D03F6CDFF008269699E1CB2D73F686F1BDBFF00C1573E1FDA7ED9
                BFF0504D6E3D3FC3FA278EFF00697D33F67FFDA3ED3C37FB377C28F0DC725CA9
                D03C1DA51F1BDB3691A3CE74CF0B9D1B4FD327B8D6FC41AAF8AA7B5FBC2D60B0
                824F8EBF0FBC0BFB406A1713E84D75AA7FC158BFE0AA7E2BD462F08A785349F0
                8417FACF897F65EFD9C35F965FB1FC3EBAD36D350F1059C569A15DC9A7FC3AD3
                351B9B99EE351F18EAA67B8F8EBF6896B983E2AFFC112756D1F4AB3FD937F659
                D33FE0A4BF0A7C0DFB1C7EC6979A7E95E12F19F8BFE1C1F811F1F4EA9FB4B7C5
                8F0BEAC1B56F0F6A5757BAB78374DD2FC3D2082F74BB7F89D753788CCBAE78B1
                2C3C3401FD61D14514005145140051451400514514005145140057F397FB655A
                6CFF0083903FE08DB7BB5C79FF00B33FEDD3699DA045FE85F0DB5A9708472587
                DBB91D814C7535FD1A57F3BBFB6B958FFE0E24FF0082287EF563337C05FF0082
                83C3E5B9C89827C2169562810B05461B4B92AA49580823001400F25FDB474A7D
                53FE0AEBFB4DDAFC48FD9BF44FDA5FF641BEFF00825F7ECA5A2FED61E18D2B4D
                D5758F8DDE06F096A1FB48FED653F853E2BFC19D13408CEA5E2293C3973A6EA9
                A96A163A1CD6DAC2416106A1A31BBD4F46B1B1D43D6DBC07E1D5D5FF00672D2A
                FF00E28F8625F104D670EA3FF04B7FF82AEE89A1785BC51A37C451E32D363487
                F656FDAE7FE11F6B1D3BC7D75E24D361D36D77C93E996BE34B7B6175A64DE1AF
                19E8B693B7947ED18BE77FC1C2FAB597C34FDA1346F813FB5B4BFF0004C4F817
                A8FECD7E1EF1C6A13A7C28FDA162D13F688FDA42FF00E2A7C08F897E1B4C3789
                B4FD4F4F8B45BC57D259359D2E4F0EAEB3A68B98F46D52D2FBD8DE7F0D3F85BE
                3C6B3E1FF803AE7887E056BDE20BDD07FE0A8FFF0004C5B8B3FF008493E237EC
                E9F117C51049AEEADFB4B7ECBDA4785D626F15C1AACAD1789AEA1F0BC8917892
                0B61E29F0BFD83C6161AF69BE2600F8BFF006F1F046B32FEC73FF053DF899E01
                FD99FE17F837E2F45FB2F7C7FD2BFE0A0FFB1EF8B74AF08C50689E30D73E08F8
                C2D3C35FF050EFD907E235FD916D634D9469AFABC9218EC93C4167E03BC4687C
                3BE37F0BEAD65A9FB4FECABAA78FFF00E19E7FE09DFE32F89DF0FBC27E36F8F9
                A97ECE3F04D3FE09AFFF0004F7F0B78816EBE1BFC31B1F0F7C2AF0CF87F59FDB
                8BF692F1168B6AD6D6F25ADAF8A12FEE35B1A7BDB7866C3C4963A168706B7E2D
                D7849A9F997FC1463C3FE17BBFD883E2E68DF13FF68CD7F569E4FD8C7F695BBF
                F827CFFC1473C3EFE19D526FDA23E06F89BE0278C358F1EFEC45FB4AF8A7CA6D
                0BC73AD6B3A0E8D3F93737F6BA78D7E1B3D3B5ED21ADFC59E17D5E45E83F607D
                3B4C4FD8DBE1EE83F0BBE3CEABA089FF00646FD9C75BFF008292FF00C14BBC59
                AA687A3DD7C10F86FE19F80BE15D53C29FB1E7ECE1AD3C49A3784B5AF0FF0087
                F5795649AC924B5F08C3ACDE6B7A90D4BC5BE2889A400FA9FECA2CA2FDA0FC25
                6FFB40DFE91E19D0A3B4D7BFE0AA9FF0545BFF002BC157DAF6AFE1C86FEDAF3F
                644FD94AFEC9E487E1F2E856B2EA3A6CCDA4DD5D8F05DA78992CECE6D67C71AF
                EAFA968CCD42F2C6C34AF811AFDDFECF573E1EF0A787B5EB3D1FFE094FFF0004
                B4B3D32D7C07ACF8CFC55E133653E9FF00B56FED3BA1986E53E1FDB7874DE47E
                23823D5AD8C7E0CB2F2F55D462D4BC71AD68BA568715ECBE1CB0D23F678D7EEB
                E09EA363F09FC25AE58E8FFF0004A1FF008269D840FE17F1B7C6BF1FF85B4E7B
                BD27F6ACFDA3ED3C4CB2DDF84AD34682FDBC43045E21888F0A59DD49E23F11A6
                A1E30D4F44D2FC33DBD8687E3FB5F891F197C29A37C6CD2351FDAD7C45E1AD26
                FBF6FDFDBD6CB43B4D37E13FEC4DF05B49D3D3C57A3FECD7FB3769BE2C92F34D
                F09EB11697AB5CEA7A7E9DAB4FA83D947ACCBE37F170D4E5BCF0DE95AD006259
                E8FADD8EBDF1DF45B1FDA034D93E340D224D43FE0A73FF00052E8A2D33C29E13
                FD977E1E78474FB6F180FD937F6619F5F5B9B0F02CDA7E95AAEA92C168F7B77F
                F08B5A6AB79E29F10CDA8F8935BD2E3D56ADAEA1F0BF47F84BF0AB5ED63E0DEA
                DE14FD8C744D7F41D03FE09F1FB04785744921F8C1FB717C56924FF84CBC29F1
                83E2EF84FC4524571710DCDE59DE78A6C748F13496E9631DBEA7E39F1EDC4575
                05B47E12C4D3EE3E18DBFC24F843E2F7F00F8DEC3F60EF87DE26D1B42FD85BF6
                36D2B46BEBEF8CFF00F051AF8F32DFC5E33F02FC78F8A1A7F8A5E2BED534DBDD
                66C75AF1669569E2492DE39DADE7F885E30BAB386D2C9348F43B483E3C27C6D9
                ADAE35EF08F8D7FE0A55F133E1C40DE3FF001EC7612F887F665FF8255FECC1E2
                3BDB7D56FBC33E1282FBC983C59E20D466D3035AC7762DB53F1B6ABE18B5D4B5
                64D07C23E1AD3ECF440096DED3E313FC68F1AE93E13F13F82BC6FF00F0519F1D
                783ACADBE3DFED033D9FFC24DFB39FFC12EFF678D6DED35BD37E127C33B2D5E2
                821F127886E628E2D52CB43BD4B4BFF145F5847E28F148D17C3961E15D222FCE
                EF8CD71A76A1F1F3FE090F37ECE1E0F6FF008632B0FF0082AAF86EE6E3F690F8
                913EBD7DF19FF6D7FDA4FC55F01BE3F5E78ABE3F691AA5FC10FF00C253E135B4
                D0F5AB24F155EAC116B73DE5A8F0DDADB785F42D1AE755FA7EE34FFD9D35AFD9
                DB5A0DE31F17786FFE096DE12F891AA4BE3BD7E417FE26FDA03FE0AFDFB49F88
                7C510C7AAD95BEB71469AAFC4EF0AF89FC4A23D2445A44105DF8E6F74E4D374E
                FB07826C6DE3F14F807EDAF3EB9A87EDADFF000466F187ED11F102C7C15FB417
                8AFF00E0A05F0CF50F815FB10F84EFCC3E1FFD9A7F656BBF841F1AB4FD7AF3E2
                0DA787657B2F18F8D354D62D7E19D9DF6B57332D85AB68175A4785E19ECF4DF1
                4EA1AF007F57945149C0C741D00E83E807F80A005A28A2800A28A2800A28A280
                0A28A2800AFE6D3F6241145FF0727FFC16AD0422292E3F677FD8527DC2543F68
                10FC1EF02DBB4C61DC1976810C5C2103C9192BE62EEFE92EBF99FF00D8CA5913
                FE0E70FF0082C4DB862B0CDFB297EC71398F62ED76B7F873F09E289C3E323689
                E65C2F0779CFDD5A00FE9828AFE3C7E2378EBFE0A0BF143F6F4FDB4F57F89DFF
                00051CF8FF00FB277EC23E05FDAF97F642F85DE37F809E13F83F7FE16F813F13
                34FF00841F05FE23F85ADBF684B1F19F872E66F0EF85FC4AFF0018BC2FA65A78
                B4EB17111D66D2E6C3548F47B6D5F49B88AC45FB36FF00C15B759B2F889F0335
                9FF82B5FED5B65FB7BFC23B75F1A7FC29B86C7F67FF047C29FDADBF66CB2F195
                ACD77E3BFD963E204DE12B6FEC1D5EEECA7B5D325935A4BD6F0F6BB756FA56AF
                FF00127D434DD5AFC03E4FF891FF00056DFD8E7F61DFF839EFF6E0F8E1FB41F8
                87C7DE1BF875A3FEC53A0FECA5757BA4FC3EF106BB7F2FC5FD2BC5BF00BC652D
                A5B6856086E26D38D8786F5B78B532890BF909E5F991DCC0EFFA8771FF000774
                7FC11A200FE57C43F8E779B368516DF01BC589E60F2A47F93ED6D081831A4786
                2BCCC98CA8764F8A75CF81BFB4EDF5C7803F6808BFE0B09FB465F7EC3FF11A6F
                F856FE36F8CBF157F654FD97FC67F1EBF64AFDA4EC3C451783751F873FB5D699
                E32F0C5BDEF80B42B7D4567D0A7D50B429A06AB15ADB6A1043A75E5BEAEB99A4
                FEC43FF0559D23C43F153E03C7FF00054DF1CF84BF6DFF000169DABFC46F831E
                053FB377ECD5E0CF83FF00B62FC0BF0C6B5A5E3C5BF023E29AE868BE1DD7ADAD
                755D1B4DD574ED461BC9F41D62FAC5EF7ED1A3EAFA66AF3807DB773FF0779FFC
                11C2DE3B568BC61FB405E34F0AC92C36BF02B5A47B272A87ECF726EEEA146719
                2B981A54FDD9C311B777E42FFC154FFE0E34FF00826EFED73E27FF008265EA9F
                07F56F8D57369FB2C7FC14DFF66BFDAAFE2B9F107C2A9743369F09BE15BF88BF
                E12A9F43492F9CEB3A801AC5A186C6355F30452E5E32A824FA86CFF67EFDAC20
                F0AF81FF00696D0BFE0ADFFB515EFECA1A59F11FC3BFDAFECF4EFD93BF66DF0A
                7ED25FB157C59F0DEAD0437D79F18BE14C1E1FBA167E1DD027FEDC83C46D6D03
                5DE9B1BD96BD6C75DD0AF2F6FB4FEA6EFF00629FF82954BE31F1FF00ECF73FFC
                162BE2CF85FE3478FBC3BE21F1CFEC09F12F50F85BF00AEBF66BFDACFE1FD959
                49E24B7D153C6BE13D04EA5E0AF1669761A842BA96936ED7D20B2783C41A2FF6
                F69F0DF5AE8801FD65FC50D6B4EF127ECF5F113C45A44924DA4EBFF067C5BAD6
                972CB6D3D9CB2E9DAA7822FEFACA492D2E92396D59A29E226295119492ACAA54
                81FCB0FF00C13357E2E69BFB2B7FC1397517B8F879FB43FF00C1403C49FB167C
                38B6FD84BE075F7F6E5AFECE7FB0A7ECB63C29A5F82759FDAEFE365BDBCAB737
                BAEEB76D15B5BDF6AD0A26ABA8CF749E10F0C0D3F4F1E2ED4E4E5FC61F0BBFE0
                A31E32F82FE20F8B7E0DFF0082A6FEDEBE38B2F839A778F3E1BFEDF5FB20DC7C
                33FD98AD7F6A3F80F732FC38BB8A4D4FC31E16D33C3A34EF8A7690FD96CF5386
                3B1B786E75FD0B5B3ACF86AFAEB50F2ACF51C4FF00825958FC2ABDFF00825EFC
                2FB2F875E35D77E00FEC9B65F00BE14F8AFF00E0A79FB78F88BC41E25FF85ABF
                187C5765E0AD2F489FF625FD9CFC60631AAD8E9BE1FB7BDB5F0A4FA968128FEC
                34BBB7F0CF8620BCF116A5AD5D68601FA11A25BE8371F0C3E3FF00873E1A7C7C
                D47E1E7EC93E09D6BC59AE7FC14F7FE0AAFE2AB95D17E377ED5DF14FC1B25D68
                BF183E1AFECFDE27D1DAD93C1F6BA4C7A29F0C5CF8AB47B796C340B59E2F0BF8
                1A04D4F499EF3C3EDB2D51F4EB5FD9CBC69E22FD9B66F0EF8752EC7863FE08F1
                FF000499D2847E08BFB8BEF07E8F15FDB7ED61FB5969D0F9B61E0A9747B29AD3
                58D9AAD9DFC1E05B1D6229E65D63C69ADD85AD9CFACB68BA7CDF01F54F8C7F03
                F556D4ECBEC96BFF000499FF00823378151BC291E89A3FC344D2ECFC23F1EFF6
                ABD0F4769341D06F74944D13566B9F1424BA0FC3EB516E96E355F16CE80EE691
                A5F8E22F1EFC75F0F689F1B7C3F7BFB526A7E1D179FF00053CFF008294F99FD8
                BF08BF61CF843A669173E283FB2C7EC8B75E336974EF096A1A469FE75E5BD8CF
                2CB1E8A93CBE33F199BED5B52D1B4FD5001DA245E2BD53C5DFB44F843E1DFC72
                F0C7FC2EC8B44793FE0AB7FF0005462E965E0CFD9A741F08E9D75ADDC7EC7FFB
                238D42636FE14D4FC35A76A9E219ADE1B8BA7B5F06DBDCCDE20F11B6BDE2AD6C
                5BDEF9B1B9F86D6DF0FF00F66EF14597C18F10F87FF640D03C51A4687FF04B3F
                F8272692CFA5FC4DFDBEBE3EEC3E3CF0A7ED41FB42D9F88A433695A1D95C5BDF
                78C6D17C6134DF604B49FC75E2C953567D1B4FD32DA5F7C1CD6BE107C26F14EB
                9F09BC59A27EC05A3F8A6D744FF827FF00EC0BA658EB5FF0BC3FE0A75F1E351D
                4A1F1A787BE3C7C6DD03C597105FEBFA1DF6A706A7E24B4D2FC64BE4CC89A8F8
                FF00C7177F651A747A57A6DE41F1CE1F8CFE28D0349F147823C51FF053CF8ABF
                0F62D53E387C729117C4DFB39FFC123BF64CD7E782EEC3C17E01B4D75E186FB5
                BD420D21E7B2D3E76B4BDF17EB5A2DC789B5B8AC3C2FA0699A658004FA4C3F1B
                B4BF8ABF16BC0DA17C4EF076AFFB7D78DFC17A3789FF006EBFDB864D2F4FD47F
                67DFF82707ECFD341ABF8ABC13FB3E7C0DD1FC5CF6F15D6A10D8FDBEEB4BD1F5
                0F25AE0DC5CF8E7C62CE93689A66AFF9ADFB4DD9EA2DF0FF00FE097FE2AF81D3
                4DF03FF60CF0F7FC160FF60DB1F80DA1F8D88D43E3DFFC1417E2078AFE35A5FF
                008EFF006C8F8B7E22F103A6B4B67AAC8BAFEABA641768756D74DD6A1E23D5E3
                B4B593C3D05AFD9B73AA7ECD7A9FC09B8D5F52D33C6B6DFF0004C0F0BFC4055F
                0378474FB8D73C5BFB457FC16A3F6A7F105C32CDE24D60DC4D6FAB7C74F09EB7
                A9D9F9D6F6D3BCB1F8D66D2CEA77D2D9782742862D6FE42FF828CAC5A97C6BFF
                00827BEB7FB4BE9CFE2EFDBA355FF828EFFC13A3C5169F097E1A4FFF000987C1
                6FF826A7ECDBADFED23E13B3F0BFC30D47C4D018B4EB6F1278CAEAC2D61BEF10
                ADBC37BE24BBF0C5DAE9D05AF86FC2D671C401FD8FD145140051451400514514
                01FCBA7FC148F49F83FE29FF0082D6FC05F0CFC6DF1878BFE0D093FE09D57CBF
                B3B7ED41E09B358EFF00F65DFDA4B5AFDAFF00C2365E0DF885AC7896E14D8F84
                AC75B974FD13C18CDABAC961AA7FC2C093C3B726DE0F145CADDFD2D36B9F131B
                E3978B35FD33C05E05F0A7FC147FE1EFC37117ED51FB2EC30DFF0087FE057FC1
                50FF00665B1862D0F4CF899F06F5ED7E296D753D7B4EB7B3367A4DE6A06FEF74
                0BBB897C1FE2774D1355D1B585F33FDB6AEBE25DA7FC168FC3D3F81FE0DF857F
                68FF0002DB7FC1217E235B7ED1BFB3AEAFA669FAB78B3E30FC00D7FF006ADF0C
                E85E31F0FF00C2CD3B549A3D3F55F10DA3DC586A30E8FABA0B4D62DB4CBFD212
                4B4BBD4AD2E6CAF5CDAF8027F867F0CF46D73E32F883C57FB18F89F5ED235AFF
                0082727FC14674ED5354BEF8E7FB077C70D6EEC784343F817F1DBC4FAF5BA6A7
                A5E94DA8DDCBE15B4D4FC4CB10B8B7BBBCF0178E62374F633EBE01F287ED8B6B
                F073C29FF04DAF8D7A1A4DE2AF8A9FF04E4D6BE1AFC63F1B7EC83F1B34D8BC55
                A7FC79FF00825FFED41A17863C730F85FE017C4413093C4FF0F7C3767ADEA137
                8274BB81636979E168B56BFF0005789204D1A7B5B88FD13F666D33E0259FEC23
                F0CECFC33A678D3E187FC12D93C23F0FEC7C4CD0E91E39BAFDAD3FE0AC9FB43F
                8BFC33E1DF0A8F05E9569A8A43E28D77C23AB5E5AD8E851C1047697FE275F0AD
                AE9B62DA478074B65F11FA67C71F0EFC75F899E18FDAD341F85DF0FB46F871FB
                79EBFF0000FC6FE01FDB87F62BB3BF45F843FB6B7C32F1A7C3ED73E17F86BF6B
                BFD962EF5F960B5D5B5CB651689A76A7733DA5C4D1694FE09F199B3B9B6F0AEA
                DA3FE70E85E1DFF82A2783EFBF64FF00DAEEE3F6FAFD913C51FB2EE81F0D34EF
                D9D3C05F1CB52FD9075E6F02FEC11E35D1ADE3F8597B1FC53F811AA7897431F0
                5354D66E62B9F0AF887C697C97973A05EE929A1DE5BF85F44BED403807ED25D4
                BF17F56F8ADF0DA0BFF06F8275BFDBD355F0DDE6A9F033E05982CFC49FB3A7FC
                1297F677F16410784E7F8A5F1357C3135ADB78DBC5F7161A2DDE9B14B6D77697
                3AF5F43AA7877C2B2787FC2F69E33D6ABCAED97E19DBFC34F8BFA8E8DF15BC51
                E0AFD81B4CF116ADA9FED8DFB6F6A1E21D46E7F695FF008297FC70296BE03D5B
                E1B7C0DF10781E2B5BAB1F0F5D5F5B41E17FED2F04DBDA4DA8DD9B6F0AFC3DB2
                D26DE16BEAFCB4BBFD94FF00E0B4AFE14FDAB3F61ED43F6E2FD9AB4CF8F7F14B
                58F16FC77D046B7F012FFC39AF7FC14DBE1CBBE95ADEB52699FB4BC1AFAC7A5D
                BFD9DADFC13ABF836C74BB19BC3BA35868F6511B3F0CEABA5DEDCAF8D7E1E7FC
                153FC49A77ECDBFB6BD9FEDCFF0001E7F827FB27DC5E7C32F893F05346FF0082
                7D5CE9737FC13A7C5765A5E95A26ADF10BC4FF00B1F4BE22B8935DD6BC216B27
                F63DE6AD6D7F25C685E1CD72EB57F0D41A9691AADDDE4A01FAE0DFF09568FADF
                C01BFD53E09F8664FDA7757D31A6FF00826E7FC137FED16BE1BF847FB10FC2CD
                034697C2737ED1FF00B4CC5E0C1716B65A9E8FA66BF043AB6AF0437906932EAD
                65E0EF06A5DEAB7FA8EADE23A1610E8BA7CDFB4BC7E10F8F927863C21E1FD634
                DBCFF82A7FFC154756D5A1F0F78AFC63E2EF871A4FD9B51FD973F65B6B2692C3
                E1DC7E1CB59E0D1AE2EB4969AD7C2916BB79A5E9F16B5E38D535FD5341FCC29B
                F65BFF0082B643F117F686F84B75FF00055DF815E11F1B7FC140FC223C45FB3B
                7ED87A17ECB1A2B5AFED71A51F87377AAE91F04FC03FB41F87BC4D3CBFB3CDCF
                87AC57557D27C39A2586A41744D6353F13F875F58D457C51FD9DF2DF8BB43FF8
                28AE91E23FF825F7C149FF006F5F82FE05F107C39FDB67E1C7ECA9E21FD886F3
                F60FF03782B41FD963E2BEA9F0D7C61E2DF00FC57F13FC38B4F145FE9BFB46E8
                F690783352D6BC2DE265BCB1B3BAB8D42D758D36E6DF52B6BE5D2C03F76B5C82
                DAC3C0DF0067F13FECFF0079E18F84F6DE20D0F4DFF82697FC1283C2D716BE1B
                F18FC60F1DF87669FC49E16F8F7FB5FF00DA2DE56F0BD9684BF64F15DC6937ED
                7FA6F8523964D6FC4C7C49E2C9342B1F0EFC61FB4F68DA74BFF050DFF8259786
                FE21EAFA97ED2BFB4941FF00050FF096BBFB4FFED11E1AB2B6B4F829F033C6BA
                1FECF5F1DFC5BF0ABF635F83B657135D5EF82EC34D86FF0057F124DA1DB3CF77
                241A6586ADE2CB996F35DF0F983EAEF0E7FC12BFFE0AD7E1EF887F19BE253FFC
                1603E187893E25FC61F008F004DF1DBC53FF0004FF00D02FFE2CF807C36D67A5
                C51783FE1169FA778FECF41F84DA359DE43AAEAF15AE936412EB50BC4BCD4E2D
                52E61B39AC687C0EFF00822D7ED95E0AF15FEC31A7FC66FF008289FC3FF8ABF0
                33F627F8F6DFB45E91F0EBC25FB1DE9FF0ABC6FE3FF88B1F8335BF0EB6BFE36F
                8BB65E36D4F53F16EA5AA5DF8CFC6F7FAAEADABC57B75A95C7886F2E6FDF5296
                F1459007F48145145001451450014514500145145001451450015FC7B7FC163F
                F6BBF871FB1AFF00C17F7FE094DF1AFE2FF84FE21FC45F02FC3AFD983F68CB9B
                7F097C28F0ADC78FFE20E8DE20F885A57C45F055AF89FC33E08B3B8B69354790
                C3676F3B6F6DB6B67752AA3BD9AEDFEC26BF993FDBA5A083FE0E66FF00822049
                23F9666F805FB6FDB2E5DF6173F03FE2DAC2891E76A312E46428270A0E422E00
                3F37ECBF6D9FD983FE0A19FF00053FFDA9BE2FF8EBF676FDA0FC3BFB2CE9DFB1
                27ECBDF0B3C65F1D7E24F854FC22F8E3FB11F8ABC3DF1E7E2478DFC0BFB46F85
                BC377535FDD787B41D2BC4D7FA1DD5DF8BED9645D166F0DFDBEFE26D0EDF5E92
                BF6E758D37E27DC7C7FF0086117883C69E02F087FC142BC0BE08D7EC7F65BFDA
                41EC13C33FB3C7FC14EBF67A7B0B6F16F8AFE0C7C4FD37C391DD8F0EEB5A7A5A
                2EA971A46973DF5E68975627C61E198350D06FFC51A0C7F287C5EB8F8CFA4FFC
                1C41F196FF00E04F8DBC2B2F8EED7FE0989F0235E9FF00664F1DEA3A058F85FF
                006B6F879A7FC72F8A7A7F8FBC05617BA9959BC31E20D32D277D4348D662DF6F
                6F7509B6D5233A46AFA9496FEA8D37C069FE097883ECBA6F896FFF00E099DA97
                8DEF23F1E783D6C353F03FED2DFF00046FFDA7BC1FAA5AEA3FDA7A4E89A7472E
                A7F0D7C2FE1DD6E5B7D44A59C73378366D562D56CA4D57E1F6A8EFE1800F973F
                E0A21AA47A57FC1367FE0A2FAC7C22FD9EB5CD5FE0A7C40F841F1CAC3F6C1FD8
                B7C410E9FF00F0B4BF60FF00DACAF7C25E20F1758FED0FE0BF0F788EEDF48D4F
                C1B7DAEB681E21D41BC350476B2C725B78F3C3936A51DDEB4937A4FECDC74FB7
                FD903F62BD5BC7FF00B37DF787BE19C3F0C3E12E8DFF0004EDFF00825BF85D34
                0D175EFDA43E3169FE18F0C78E750FDA6BF694D33416D434AD034DB6D6BFE2A4
                825D725BAD37C356724BE27F10B5FF0088F58D234FD07D33F691F819F11BF685
                D27C69FB3FF89FE2878174AFDB43C7BFB33FC42F841F0F3E2D247A4E89F077FE
                0AA5FB1678BFC2DAC5B7883C1FE23B186DEE34CF08F8EBC3F1F88AE354173A2A
                5FBF87753D461F10E9B6B79E15F13EB9A19FCD1D03F614F8B9F0C6D740FDA7FE
                177FC14E3FE0A4C3C33F067E16D97EC89FB607C3E7D07E0B5EFED6FF00B0DFC3
                CF0DC5A1EA5E1D1FF082CBA36A315FF84F41B6B7BDD47514F094125EEA9637DA
                378AB42BFF00135A69E8B7801FAEC2CBC690F8FF00E32786A0F8EB697FFB47FF
                00C229717DFF00050CFF008288BBE8BA17C2BFD817E0E368D6BE2E97F661FD93
                7FE1318A6D33C23A925A42DA95B5B5F0BE6D2A09478C3C692EA57D75E18D3759
                C35BCF85F73F0D3C29E26BEF847E2BF0D7EC2BA8F8CAF34BFD913F631D3F4BD4
                E6F8E5FF00053CF8FDE31FB7F8DE1F8BFF001BF44F1848755D7744D526D375FF
                0010DAE9BE33BA437B05A6A7E34F1D4B0595958C5A77E47C1FF0497F8BB36817
                BFB226AFFF00056BFDAD3FE104F8CFAB5C7C72FF0082757C603E25F867E32FD8
                BBF6A9F115CEA517C75F0E7873E303697A7DE5C78A3C6CBAC3DC7886E1351D56
                F61F145847FDB7A326A9FD8DAD69BA47A8788BF613FDA27E24F8BBC39FB410FD
                B83FE0A87ABFED29FB2A587FC2BBFDAC3F658F11F8EFF67BF117ED15F0BFE137
                8E9BC37E22D7BE2AFEC61E208BC0117873E24D8DD6ADF0F348D7F4ED4B49D0A3
                BAF135AF82DB4AB6BCD0FC47E1C9747001FAC969A57C68F117C62F106956FE2B
                F0EEB9FB73EA7A0CD71F1CFE3C2E3C4DFB3E7FC12C7F67FF001AD9699AA43F07
                3E0669BAFA4361AF78EB55D2F48D1AE124BCB58EE757B988F8A3C4A963E1BB2F
                07F866E3C9A5D4FE066BBF08751D7F4E87C7BE13FF00826AC7E27B35985BCDE2
                2F117ED37FF0596FDA1FC4567A6786749D305F6B132F88FE2C784BC48DA3695A
                6F997B72B73E3F783CB9DECBC0BA748FE2EFCD2B0FF826869167E00F177C28D5
                3FE0AD7FB7E789FF00610FF82824BAC6A1F007F6A4D17E33F8075DF8557DF1CB
                E2FEDB2F117C2BFDB27C3DA9786E3D435ABBF157886DB51486F9B5FF000FD96B
                971ADDD783F54B6D175A8F4C6F12F8B7C50FD9F7E2C683FB687FC12F3F668F8C
                1FF0501FF82967C3FF00DB3E5F8E5F107E107C449F5CF8DFF0FF005CF0E49F09
                FC45F043C63AD49FB417EC4BACFF00C20D69A59D0B5CB9F04E97A34CF79A7DDE
                A5A3AEAD3E89AB5BC73A59DC5E007EE75F27C5B8BE2DF85B4A5F047823E237FC
                145BC4BE04B7D73E037C139E2B2D63F649FF0082497C069ECAE3C1BA778E3C59
                2E90D6D0EA3AFDDC575A9594D7DA4A2EB5E2ABBD3E7D0B42FEC4F09687AAEA1A
                67C41F142CBC1D71FB5E7FC130343F83FE1FF10FC6DF863A7FFC1516DA3FDA43
                F6F5F8ABAA47A9F89BF6A0FDAF3C0BFB357ED516FA2E89E039F6795E2DD07C07
                F61F895A7B4BA641A7F877C39776FA7F87BC2F138D2FC450E91F5A68FF00F06F
                1F817C3F3FC52D4F43FF0082A6FF00C16374CF107C6E9CDDFC5DD7ADBF6B9F05
                2DEFC47BB7F0DC9E0A7BCF18C7FF00082F95AFCC9A27D8F4A826B9491EDA0D2E
                D05B180DB4253E84F849FF000463F017C2FF001DFECB1E2BD67F6D8FDBCBE307
                84FF00636F11699E2AF811F04FE28FC42F81D27C18F0D6B3A27C3AD7FE166877
                13784BC03F0F3409EE05868DE27D6ED6D825F44D02DFCA91B2C735C24C01FB29
                49B54EDF947CBCAF03E538DB95E38E3238C52D14005145140051451400514514
                005145140057F14BA77EC23E2EFDB5BFE0E29FF82CE45E13FDB5BF6B2FD8BEF3
                E17F803F6270FAA7ECA9F10D3C0DE23F1C5878DFF671F85F7074DF136A7731CC
                2E34EB39BC369751DA25B90B2EAD9124423027FED6ABF889D6FF00E0A1DE22FD
                80FF00E0E29FF82CA5E787FF00633FDABBF6C66F8A5F0EFF0061FB79BC3BFB28
                FC3BBDF88DE21F06FF00C21BFB30FC237B7D63C57A5D9231D3EC2E8F8965B74B
                9278960D815B79DA01D07FC132BE1E78CBF672BDFF0082AC7C2FD23E3678F3FE
                0A17A5FC3EFDB8BF684F017EDC9FB18FC5BD7F4CF1EFC79F8D5FB35EB1E0EF87
                DE19D13F6A0F87DA76A7E5DFF893C6E2D1FC47A6EAB62676B3F15DB7851B4DB4
                5D3F58D3B408E4FD199FC3BF0ED7E1EFECEBA1CFF1DBC41E20FD9765F12E8BAC
                FF00C12CFF00E0A5BA0DE49AF7C47FD8FBE2AEB515DF81B41FD9CFF68ED7F5B7
                497C43A26A66E65F04DADDF896085357B6B897C1DE2B6B5F11C5A16A7AF7E657
                FC1383E3A1FDA77C7BFB55F8BB59F855F157FE09E3FB52FC42FF008295FED33E
                2AFD87BF68DF8AFA387D274CF8D1E2DF007C13BDF895FB06FED2DE1445B592C3
                FB634FF0BF822E6E7C23E238ED575A1AAB4FE1A9EDBC45E0FB1B983F4EF45D7C
                DAC9FB485E2FECED797DA86A96B7117FC157FF00E0938E969E37B6D6ECBC6D67
                7BA76B3FB67FEC61A76A4F6D69F10F4FF115BD9DF5FDC5AE9B0DBC7E2CB7B0B8
                8E4B7D0FC75A2EA163AA8077B6FE21F8A76BF133E35788B4DF86FA0CBFB5B681
                E1AD29FF00E0A15FF04ECD3B57B2D6BE177EDC7F03E5D1ADFC01A27ED61FB295
                AF8D1D229357BAD1349B6D2EDCDE8852F8F864F823C55F66BBD3BC39ACD8F8DD
                BA7C1DD37E0FFC1BF0D4FF00167C5B7BFF0004F8BDF15693A87EC0FF00B7168B
                7F2D87C69FF825C7ED05A6CB73F0EFC2FF00003E356ABE215375A6F86ECEE353
                D43C23617BE2DB69A3B78F50BCF03F8D23BAB5BAD36E6F3A2D460D0EDB44F807
                E14BDF8FFAADE782B59F10D8EB9FF0487FF82AE7F6B47F10EFBC11E28F1BDA43
                A7695FB1F7ED49AECC6D26F165B6AF2412F87618FC47726DFC63A70B1D2F50B8
                B3F1C683A75EDFDFB3D5FC6771E33FDA13C41E1FF8116779F1F0E9BA5D9FFC15
                3FFE095B7177A07883C0FF00B54FC3AD63C383C1EDFB627EC716DE2A92DAC7C5
                17FAC69B6F05A4775746CADFC4B6DE1197C2DE218B4AF12E89A7DCDA8077BA3E
                A9F19A1FDA27C4FA9E8F65E0DF86BFF0541F037827497F8D9F018EAB7FE1BFD9
                9BFE0A9FFB3478293FB2F43F89DF0C2EB5C69E3F096BD6035936365AD486F352
                F0A6A3249E1EF112EB7E1AD4744D4EE7C8E77F80A9FB3B4D04CFE3F9BFE0995A
                878FD5A499A6D47C2DFB4EFF00C1177F6A7F87FE278E6852E91CDD6A1E01F08F
                847C401244706F13C16F2215FED9F879AA44FE178E5BAF86567F0B7E0FC3ADFC
                62F12F8A3F619D47C59A76A7FF0004FBFF00828FE93A87DA7E3BFF00C139FE34
                CB79FF00082E8DF02FF681D47C710B6A7FD883519750F0847AA7896D64436F73
                77E09F1EDB2E6DEFF55F43B1BBF8C52FC62F1CC91FC3EF00781BFE0A2DE1DF06
                DDFF00C351FECC131D2F4DFD9CBFE0AE9FB34F86EDBFE10FD3BE2BFC209FC4D7
                13DB68DAEC361269F6B697BA9996EFC3979AC9F0978AA4D4FC3F79A1EB2C01C3
                7ED29FF0B51ACFE20F87BC5DF14BC3BF07FF00E0A29E16FD967E2869FF00053F
                68CB5D1A487F66CFF829EFECC9E15F0AF8A7C4FAA7847C5DE0DD0EEA1B7B1F12
                E8D06A7ABEA773A269B769AA785AFF00C472F883C38FAAF86B57D6F4DB9F92FF
                00609D4BE29691FB1A7FC130F5FF00881E00F037C6FF00DA735CFD963E10699F
                F04D6FD84FC27AADCC3F047E18F867C2FE08F075A788BFE0A19FB54EAD676252
                CB510756D1353B9D61EC26FEC1FF00848ACB43F0FA5DF88BC43AADF5C7D0DADA
                7ECC7AE7ECA1AAF84B5CD2BC7BF15FFE0915E23D46EBC3BA85ECD7FAD685FB4E
                7FC11BBE33F82EE2E747D5FC3BE22B0BE5FF0084A7E1E785FC1977771449379D
                757DE05482E609E3D4BC13776E743FCF9D0FFE08ABFB3AF815FC31FB33E97E28
                F891E05FDB1741F0BF8675EFD923E3B5AFED59FB4A7873F66AFF00829B7ECE3E
                047B9F13C1F066FF0055F0EF896E0FC1ED66DB4F92EFFB53C3BE10BAB33A5CBA
                9D8F8A7408358D0E7D434CB200FD4BF0D68FAE5CEB9FB40784BE097C62D06CF5
                1D1DBC4D17FC1583FE0B1BE2F9AC741F1578635BF0C580D43C65FB37FEC8E351
                5BBD3FC1D2F8474F478511EF24F0EF802D1217922F1378A2E75668B8737DF0C2
                F3E0D7C20F145EFC0AF14E9FFB197FC24D068BFF0004E3FF00826DE996474AF8
                C3FF000514F8DB3CBAA78A2C3F681FDA6747F159135DE85793C173E3182D3C59
                2BC36F6AB79E36F1A1B9BD6D26C748FCEE4FF825AFFC13B2FF0043D7FE23787F
                E19FED747F651F03DC37C33FF82827EC25AB7ED25FB469F8E3FB0D78EAD3517F
                18DDFC5CD3BC11A1F89E58FE2F7846E6EEE65D775A017C48BA8584365E28F095
                D5E4767A9D86A1A1ACFF00C1247E0A681A9F86FC2DAA7ED6FF00B4C691F107E3
                1C3AB9FF0082547FC14FAC7F6BFF008F5E22F865E3DD2BE204D2FC44F0FF00EC
                97F19DB4BF100B6F00EAFAA5BC125A4737862EB46B5F1869761F6ED225D33C43
                6B77A6900FD65D1BC3FF001BA1F8E1E2EF07E89E38F871F10BFE0A5BE31F01D9
                DF7ED3DFB51BE993EB3FB3FF00FC12F3F66EF16DE2EA3E1EF835FB3FF8775E89
                239758BCB3B4B8BDD2F45BD36773E21BAF0CC5E2BF188834A8340D3A5F1D9AEF
                E038F82D16B16DE1EF1B5BFF00C13534AF8876565E12F0DDAC3AB78C3F6A1FF8
                2DD7ED6DE22B98A3D0756D52E494D53E2DF8335ED474D59A17BD9163F180D11A
                F6ECE97F0FB4145D7FE03D33FE0965F053C5F0F89756F87FE08FDB0E2F8C3F0F
                A7BA8FFE0AABFF0004C6D77F6E5FDA013C77F1734AF889616B15EFC7CF81DE3F
                B6F134117C7396E8786EEEEB45B8D62FE6D2FC57A6DBCFA45E9F0C7886C5A3D3
                BE45FDAFBFE09DFF00047E1D7893FE09FF00E3DF835E25FDA17E3FFEC6FF00B4
                27FC146BF647F007C16FDA05BF6B7F8FD67E39FD947C07F107C67A7FC2BF8D7F
                B1FF008EBC01E25D7AD66F0306B2B6D4ACF49F11E9961A2F887469744D4BC3FE
                21305DE9F6573AA807F419258FC7693E3D68BA5E8FE1DF867E23FF00829CF8FF
                00E1EDBDF68D1CF6B2F8E7F657FF008237FEC9BADDBB68567696D6D6F3592F8A
                FC5BAEC5A7EB165149A7C7A4DDF8CB55D26E81FEC0F06F868C767F04FC69B280
                5E7EC0D6FF00B3DE9F6177FB19F85BFE0AFDFB1369BF13BF6A6F89966FE2DF8E
                BFF0525FDAD27F8A377E19F127C63D37C592CB0ADE785F41D4F4E9F3E2631DC5
                BEA97968961E1DB7D2BC3BE1AB73AA7EA3DB7FC1BBFF00F04BAB3D57C67ADDB7
                C3BFDA0E0D53E2424707C48BE87F6DCFDB320BDF8876315B7D8A1D37C737F0F8
                ED67F14C09034B02A5ECB3111CCC8080463D03E16FFC1073FE0967F073C69F07
                7C7FE06FD9DFC5D17893E0078C3C2DE3FF00838BE27FDA87F6B7F1F7863C03E3
                1F044892F8475DD13C03E3CF1DEA5A02CBA6B4719B74974C9238FCB50A8028A0
                0FD7EA28A2800A28A2800A28A2803F962FF8283C1E0C8FFE0BF3FB39C9A9FC7E
                F117ECBFF13F54FF008260F89744FD9DFE33E9D6D2DD783743F8EB37ED79E1D8
                7C15E1BF8B1A7DC3FF0064F88FC33E22B6BFF137866EB46D756CEDEFA5F1AD8D
                A69F7BA76BF75E1BB9B3FA1ECAEFC4779E3CFDA01BC3DF0774ED1BF68CBAF0A4
                9AC7FC1463FE095DADCD6DAF7C28FDB23E19EB36FF00F084DFFED55FB21EA1E2
                54B6D3B58D4758B0D3E5B38F5286182D75B974C8BC31E32B7D0B5CB7B0D534BF
                19FF0082886A97BA6FFC16A7C076DAA7ECE169FB557C13F107FC11F3E31F863F
                6A5F83F059BEB7E33BCFD9CF5BFDAF7E14D9F8C3C51F0CBC151C6E7E22EB3A26
                A2DE10D4DF4185A1BBB9D374CD60E9667D5A2D26DEE3D52EC68D3F863E08787B
                5FF8E7AD6B9F037C4173A4EBBFF04A9FF82B278675E1E2DF16FC22F1878CD20D
                33C27FB367ED3FE22BD632F8AACB56952D7428EFBC499D37C5D676D6BA178865
                B3F185BE9177AD003353BDF0A7FC21BF04DFC5DFB4178AF5CF80DA8F8E26BAFF
                0082767FC1503489AEB50F8ADFB237C45F126A71681A57ECBDFB5F5DF8B64FB7
                6BDA6DF5CC4BE0F92F3C5D0A5BEB69A6AF873C66BA5F8A2D344D575DED60BDF8
                9D17C60F88F07863C09E0CF07FEDC90F865B52FDAEBF617D5AEECEC7F665FF00
                8298FC13B2B2B7F086A1FB417ECEFA978B435969DE219ACAEB4DD3D355BC769E
                D64B7B5F0978EA2B8B15F0B6BB63CDE9726BF3EB5F1BBC53E19FD9CF496F8C2F
                25B5B7FC158BFE097170DA7789FC1BFB45784FC4FA44BA3DE7ED6FFB2669BE23
                8E3D37C7FA86AF6D6324D697860B083C5F69A25DF877C409A378B34384E998F7
                CFF0C74EF861F09AC7C45F15FC61E2FF00D857C45E36D3751FD81FFE0A17A06A
                77937C73FF008275FC69BDD4EFBC13E1FF0083BF1B3C43E3089F5383C3F16A4D
                73E0FB4D6BC4F6F7085350B8F03F8F6D668A682EF5500C7BA6F83F69F047C349
                7179E3AD67FE09B3A478A25BAF07FC525D4356F07FED7FFF000453F8F9E0C4B7
                B3B3D07C552EBCD73ABF853C1FE17BA9A6B1125E5BDCB7852D6EDF4FD662F10F
                806FCCBA27ACEA09F16ACBE367832FAE7C69E0AF863FF052087C237169F09BE2
                6D90BCF0A7EC65FF00056DF825E16B45D56CFC23E3FB3D1CEA76FA1F8A74ED36
                FAEA78ACE19E6D7BC31757775AC686BE23F08DE6B1A6DDC96971F1C74FF8D3AA
                6ADA27857C07E04FF8297F83BC196727C72F8271EA2BE14FD9B7FE0ABFFB37F8
                54DB68A3E237C35D5F56492DFC3FE28D3A3BCB4B7B3D46F926D4BC277FA9A787
                7C40DAA785758D0B55BBF158353F817A77C04D6E4B7D03C63E2EFF0082566B7A
                FC2BE3CF0534DAA785BF69FF00F82317ED13E11D62C6EAF2EED348595F5FF00F
                867C2FAC5DD96AAB1E99235DF8124B1FED2D2FFB4FC197D6FF00F08F006BDA45
                F0B22F841F13AD34BF831E36D47F6398BC511C9FB6AFEC1535BEA67F68FF00F8
                263FC7396EE1F1A1F8EFFB36E9BE112DAA278760BE9478A92D7C2123AC6A96FE
                2EF024EF11D434CBBF957F6D1BCD762FDA7FFE08B17BF17B45F0F7C7FD66CFFE
                0A23FB3BDBFECA9FF0529F01E91E18BDD3BE3B7ECCBE39F017C52BBBBF873F17
                B57F0B6CB5D0FC5D0EA0DE09BF074B4FEC4D7A26935DD261D15CEBDA4E93F785
                E5AFC61B3F889F0EF4BD5FE22F8474AFF8284786FC237D07EC6DFB5DF976FA6F
                ECF5FF00053BFD9DF457BEF19C1F00FE3B4DE15B61A75978964D2DAF350D434A
                D3605934DBBB87F1A78316EF4B6F1368B61F9EDFB4CD9DB5E7C67FF8273F887E
                07EBB77F05BE185B7FC168BF65BB2FDA8FFE09F3F11AC2DE1F19FECBBFB59EAB
                A3FC57D5E6F10FC22B9D2AE45A68BE17F1A586BFE27D6AEADB4E4BED0F5C37DA
                6F88F4092CFF00B4BC4C2F803FB03A28A2800A28A2800A28A2800A28A2800A28
                A2800A28A2800AFE3FFF00E0B79FB3169FFB56FF00C1733FE08B5F053C4DE3DF
                8BBF097C2DF13BE1AFED69A4BFC49F80DE3493E1CFC58D0AEFC03E03D6FC7CE9
                E10F1A7D96F1343791ED747B699D2DA466B5D5EEA2FDDF9B1BA7F6015FCDB7FC
                1486EF4EFF008880FF00E0DF3B35834F8B52834DFF00828ACF77788197519ECA
                F7F677B1B7D2AD2E9CA04682396CF5330AABB10F7B73954DC9BC03F2FE1FD8A7
                F66AFD83BFE0B0FF0015BE147C42F895FB617C40F873AAFEC0DF033E2BDAFEDE
                BF15BE2BE91F137E37FEC3DF17754FDA0FE237817C05F1307C48BAD3ADAEFC1D
                E1663A0DBE9571793695AAE8F6E9E24BAB7F13432F86F56D61AD7F68AF8FC61D
                2BE3F45124DF0D3E1FFF00C145D3C1B29D32E44573E19FD92FFE0B05FB387833
                4E89E5D32FF8BD4F0478DB42B3D418A4665D5358F08CF7324D07FC25DE08D5AE
                E3BEF99BF692D4FE3EE87FF0706FC42D67E02D97813E254DA3FF00C11FFE186A
                7F11FF0065AF1941A0C17FFB507C338FF6A3F8C1A778A3C01F0FFC4FAE4F15BF
                84BC476706A326A160F7F0CFA65ECB6CBA66A674CB4D55F52D2BD3352D3BE08E
                85F022C6D2DEF3C65AA7FC12EFC4FE2BBBBAF09F8C6CEDF5DF017ED1DFF0469F
                DA0FC297B75158C915BEB36E9AD7C2CF07F86358FB5D9AC1776D1CFE0396F1B4
                EBDB7BFF0001EA1347E1500CF82EBF67E8BE0F6BB1B783BE2468DFB0B786FE21
                DA3FC46F86F109FC35FB4BFF00C113FF006A8F0DF9BAA49E2DF09E9FA519B52F
                87DE04B09356B0BE8AE7C3736A7A7E816DAC9D574AFED8F875E21BB6F0F7B15E
                5AFC6AB4F8C5E108B5BF1CFC3DF067EDD767E0F4D2FF0065EFDAC52D4691FB31
                7FC1517E07E931DFF8AE2F821F1CB40F0A192D3C3DE2AB2B39A5D45AD2C55EF3
                4C9B54D4FC4DE084D43429BC6DA0C0D375FB40D9FC64D3ADD75DF87771FB7EF8
                37E1A0934591EE6DBC1FFB377FC15EFF0063EF0F4B7370B04967035EDA7C36F1
                CF87DFC452CAD2DB477EDE1BD47C52D2C6BA9F837C61246BE7D3CFF046DFE0C7
                8DC695E05F1AEAFF00F04ECD4FC4B7165FB40FECF6FA36B5E1BFDA5FFE091BFB
                40E8A6D3C413FC41F875E18D27CDD4BC09E15D06F5EDF5F6B6F0D3C8DE1999EC
                FC4FE109757F0BEA4EBA480092F81AE7C13F166D343F83DE23D6FF00652B0F14
                449FB7D7FC13D7503ACB7ED03FF04FAF8BD3CF078BE0F8F9FB265B7C3C637977
                A11BC59FC546D7C1776F1DCFF66278A3C01711EA70EB3A56B3D4F882EBC4BAA6
                ABF0274AF127C77B5BCF12EB905ADFFF00C12D3FE0AADE1DB6D2BC4DE1BF88EB
                E2ED1ACE7B3FD98BF6C9B7F0C8B1D1FC51278A121D3231146BA6699E30822B5B
                9D21FC35E32D074F95AFCADF1517E28FC26D3B5CF89FE05D3FF6DAD3BC2F77FF
                000C4DFB6AC16905B7ECF7FF00052AFD9FD2C24F185D7C01F8FABE04536361AF
                9B156D567B3B08585ACB3FFC261E084BAB47F17E83A762E9573E01B7F0CFC7AD
                4FC2BFB3EEA8FF0003F56B8FB0FF00C14DBFE097B7DE1E835CF891FB3EF8EFC5
                88FAC6ADFB487ECF1E12F0986B5F1ADB6A8A6E75FBD8FC2265B7F1443A03F88B
                C2ACFE2DB2D5F4DF128032D6CF58BDD5FF0068CB8F07FECF3A7CDE38D52466FF
                00829CFF00C12A3C472597893C23F1D740F1A69CFA5DDFED63FB1E5EF880D9E9
                3AFDD7882D6C669BED305AD9E9DE2B7D0753D275B83C3FE35D36EEE2D7E20F8D
                73789F4DFDA9BFE085927C3EF8A7A47ED23FB195EFEDC9AC2FECE5F1B3C55AD4
                971F1F3E13453FC0CF897E1AF107ECB7F1757C416E9A9F8C1F4C3672416BABEA
                62D75EB393C1F75A3F89E1B8D5B4DB6D4754FB8EFF004DFB0E99F02FC37E20FD
                A01350630D849FF04B0FF82ACC76F078EAE2EAEFC53685AC3F669FDAE7C41686
                1B0F138D760B3D3B4663A84FA758F8D2D6DAD8453689E37D3B4A99FF0039FF00
                6CAD67C167FE0A09FF0004AFF15EB50EA1FB24FED813FF00C14CFE07693FB56F
                ECAB637B16B3F09FE31EB5E29F86FF0013BC35E16FDADBE13C7259C56FE3EB3D
                56D6CB58F0A0F1A69EB637AB1F89AD2C3C496B6DAAF8774D86C803FB1EA28A28
                00A28A2800A28A2800A28A2800A28A2800A28A2800AFE6A3F618B6FB2FFC1CA7
                FF0005C1738FF8987C07FD832F23DB1800243F02BE1C69E433A0C6736BC0620E
                380084E3FA57AFE697F62E9208FF00E0E67FF82CA5B9329B8B8FD977F62DB889
                77CA62586DBE187C308275118611AF335A91952465F695DCFB803E76F829A3F8
                BA5F8B1FF05A5B7F16D85B7ED71FB1F5EFFC1497E2A68DFB5A7EC6169A2699A9
                FC6BF867E0AD53E0A7C02F14783FF6B1F8051784FEC7AEEB17DA7DF5AEA9693E
                8506751B887E13DA6A5E16B8FF00849340BAB5F12FD8FAD59FFC24B73FB3CDAF
                893E3EE9573E37BC8AD2EBFE0933FF00056BD362B0F11DB7C4587C63A5C77F6F
                FB2A7ED69269B2DAD9F8B6FBC4369A45BDA5D59CF25869DE35B7B58AF34E5F0E
                78CB43B5117C6DF01AD74493F6F8FF008295C7F08EF61FD9F3F6CE5FF82907C4
                B3FB2D7ED3BE35D15EF3F67CFDA57533FB327ECC5AEFC52FF827DFC67BFD05A1
                B8D4ED9A3F0FDA6BF1E9B398751B47F10CDAE785CEA177E1BF135B5C7D4B15F7
                84754F0B7ED1F77A7FC07D7B59F813AF6A973A2FFC1543FE0963A9453789BE2C
                7ECD1F12FC65349E27D73F6AAFD982DFC2D71BBC49A7EA8679BC512C3E118922
                F11FF650F1378565B0F16E9DAF69DAF004F6CFAFDD43FB46DBEB9FB3B787B5FD
                3751D49B4DFF0082A7FF00C129608F44F1F47AEC3E24B548EE3F6E8FD882DED9
                6DAF3C6361E28822B0D61F4F9ACAC8F881BC33A8A451685E3CD0F578356A975A
                0F8627D23F6725D6BF687D53C45F0BE7D4B4ED5BFE094DFF000572D3753B3F18
                78DFE14F8AFC631E9DA0D87EC95FB5AEA9722D478EF4CF115C432E8626D725B2
                B4F14DB08BC3FABB685E34D2341D535DD9D926B3E26FD9FF0043D63E3DC775F1
                65A192EFFE0947FF00055B31681E29F057ED15E0BF10D85A788CFEC7BFB566A7
                E13BCB4B7F1DEA5AA5BE97716D77A6CF1E8D178A6CF45835AD026D2FC5BA3DE7
                D85B64163B9FDA22E34FFD9B5F57F0E78AAEAEED3FE0AB9FF04A0D42D2D7C737
                626F18589B39BF6CDFD8CF4E78AD2DFE26E9BE23B7D327BEB9B6D22D218BC58B
                A2DDB5BDBE89E3FF000FEBFA66AA01A9603C7F73E3CF8CB2E85F08FC15A2FED5
                A7459AE3FE0A33FF0004CDBFBAD2B5AF813FB7DFC25D6F4FB4F086A7FB517ECA
                C7C6E6DACA7D5F54D32D1AD61D42EE386DEFE58A6F0878E22B7BE8345D774BF2
                DD6743F838FF00063E1D5B7883E25FC45D53F6121F1162BFFD8DBF6D7B5BABFD
                23F69DFF008242FED09A6DECFE0B5F829F1CAFFC611B6ADE1DF0AE95AA25E785
                FEDBE28864FECA5BBBBF07F8DADE7D29F4FBFAEE758B1F0F3F84BF67CB3F13FC
                78D67C41F062E75DB4F107FC12CBFE0ACBE1F9F4DF13F8B7F676F1378CB4EB7D
                0BC3FF00B397ED4DA96A3E5AF8934DD685A8F0AFF6A7883CBB1F14C0F69A0788
                4E93E30B3D0F52D6BA3B6FF85803E2C7C66BED07E0E783F49FDAF0784926FF00
                8284FF00C13DCC9A71F81FFF000518F82375A51F005AFED3FF00B326A9E388E2
                B1BED65ECA3834E5BABE2BE6858BC17E3636D345E17D6B4E00A96967F1C2CBF6
                84D7AE6DA2F097C2AFF82A0683E03B57F899F095E76F0D7EC79FF058AF809E01
                B4B6D221F1CF85E2D51A74F09F8B34DB0BE974D8EF1E5BBD57C1D75ACC1A7EB7
                0F8AFC2971A05E5CF95887E08DA7C0BF15DCDBF813E276ADFF0004DFB4F17CD0
                FC69FD9FEF34EB9D1BF6B7FF00822BFED31E179E3D6A5F897F0BADF439EE755F
                03F84BC3ADA9DAEB26D7C353DF49E198E5B6F10785E5D6BC27AB5C5BE9DD5A0F
                857A17C13F03DB6BFE30F1FF008DBFE09C075E1ACFECCDFB5B58EA5AC691FB53
                FF00C123FE35E872DE7866DFE1B7C629B5D81B5BF0EF86FC3179737DA045A9EB
                D6B3CFE1B4B6BDF0AF8F2CB54D06596F22EF2FEEFF0068AB2F8F1670CB3F803C
                01FF000539F09FC3F43A234739F097EC87FF000589FD99FC0FF6ABFBAD0A182E
                25BF7F87DE31D062D5F506C137BA9F83AF7C40972A7C4FE0ED7658AE002A5C0F
                8CD07C51F835A66B9F13FC01A7FEDCD6FE0ED523FD86BF6E6D32D63FF8674FF8
                2977ECFBA55849E3397F66FF00DA520F0828B4D23C4773A73B6BB359E9B1C91D
                BCC9278BFC10F716D178BBC3F63CB69367E0983C17F1BCE83FB3F7883C57FB2A
                EA7ACDCE87FF000526FF008254F8974DB5D73C7FFB1B7C4BD5E53E33D5BF685F
                D973C3BA28CF89343D42757F15B695E109C41ACAB45E2CF0535B788ADB56D2B5
                DE2A2BCF81FA7FC11F1F4DA5F857E20EA9FF0004D9B8F187D87F68EFD9A64B0B
                CD03F6A3FF008230FED27A16AB67E245F89DF0DF44D13CDD5BC07E11D0B52BCB
                2F134D069124EBE1845B4F15F85E4D4BC297D751587A6EADA6FC6283E2EFC1DD
                13C5FF0015BC07E0CFDBDFC3FE149B4DFD867F6F74B7B387F67CFF00829BFC0B
                B7893C63AA7ECDFF00B44F87BC1EC90D86B12595C0D426D16CE79DA2B98E4F1A
                F828CF0C3E23D174F00CDF1358DBE97A97C028BC51FB48EA56569E20D2AD2DFF
                00E096BFF0578D1A6B3F184D75A778FAE748D4B48FD8F3F6CFD6659134EF8976
                FE20365E1A86CAE35D7B7B2F18C7A3DB96B9D1FC71A5D95E6ADF9D3FF0527FB0
                EB1F107F652F10EAD26A7FB28FED6BA7FF00C1553FE09DEFFB677EC81A26B1A7
                6B1F057F681BF9BE2CC7A4FC36FDB43E0BBDFC50DC6AF6D7CBA3A590F15E9296
                57B2C36E742F15DA8D53C3961F63FD11F0E5FE872F85FF00681BEF09FECC3A9F
                89FE0AEB736A969FF0546FF824278CECB4BF127C40F811E35F18A5DEB7AFFED0
                1FB2EF864C434CF893A5789459EAFADBE93A11B3D3FC5A81F5FF000EC961E29B
                6D6F4AD7BF36FF00E0A3F6074DF0A7FC12721D52E17F6C1F804FFF00052CFD8A
                F5BFD80BFE0A09A75DE9BE27F883E0FF0087BADFC54D33FE12DFD9A3F695F115
                F4B05F6A176B61A75A9D37C4F6EB7326B23E1F0B6F1059E97AD680F7DAF007F6
                BD45145001451450014514500145145007F331FF000514D0EE13FE0B93FB0DEA
                7E11FDA2ED7F664F8D5E2BFD84BE3D7853E0078BFC4266BEF877E3DF8B9A07C7
                9F849ABE89F05BE27F84D2EAD62F1AE85E26D2F5BF1A5849A63DC58CE6E65D3A
                E34CB85D62C34511FA459DB9D4EFBF694D5BC25F031B54D6AE6C6FECFF00E0A8
                1FF047CD7753B1F17E93E37B5F15C7AACFABFED4DFB1DDBEB42C34FF00115EF8
                AA11737B0DCDAD9E97A5F8D86973DB5F2785BC69A66AA5343FE0A9FF00F04E2D
                23FE0A19FB737ECD3F0DB51FDA03E2DFC03D3B5BFD87BF6C7B4F16EA5F0AACFC
                1D7B7BE27F0AF85BE3BFEC44F0785AE97C65A7DFC1A7C725EF8E2D7531776F1C
                7730DDF83B499EDE481ED8B351D47FE0847F16B57F1E7C3BF8A5A9FF00C1643F
                E0A3D7FF00127E14689AFF00867C03E3DBAD4BE084DE2ED0FC39E2AB1B4B0F12
                F87E4F103F85BED5ACD8DFAE9DA6CD3DA5FCB7514971A65ADD329B9B68258C03
                12D353F0BBF84FF6759B5DFDA2D752F005F6AF6C3FE0971FF055DB092C75EF10
                F81F53F15DDE9FA4D9FEC81FB62497E96F6DACB6AF2D9C3E146FED592DADFC53
                1E97169F7EBE1CF1B68BA4DF6A7D969D77E3E97E22FC7293C17F05FC29E1CFDA
                C9B4CB8D67F6FF00FF0082676B5AF6977DF02FF6EEF857A969167E0EB8FDA7FF
                00658D77C6B6969A7EA7AAEA9609A4E969AEDD5B69D6B7F3D8B784BC750E9B7D
                69A36B1A479B45FF0006F97C469FC19F1C7E1E6B5FF0570FDB6F52F027ED19E2
                0F1078B3E31781E1F08FECF76BE08F1E789FC59A55BE91E2AD6B5EF08DD786EE
                AC4CDAAC567672DEB59C367F6CB880DDDC79D74C66AE8B58FF008206FC49F10D
                E7C1CD4F5CFF0082C4FF00C147F53D6BF67FBE5D43E0E7892E359F82E7C59E02
                B86F0CDCF836F5746F168F0C7F693457BA55EDCD8DE4171753C57B14816ED2EB
                626D00C1BABCF83BA57C15F87326A1E3CF1C5DFF00C13DC7896EAEBF662FDB02
                49751B0FDA6BFE090FFB40E8375A878797E16FC69BEF1E4171AB785BC2BA45E9
                D4BC2ABA87896298E8B1CB71E10F195BDEE81790DE27ADBEA1F1623F8E16F649
                79F0E7E0F7FC14D34FF093CBA65A3DDEA1E1FF00D8F7FE0AF7F033C1FA45A9BC
                BF16C229934DF10D858DE6E616E753F107816EAFE00F278C3C1D7CA35EE1F4EF
                F820678EB4FF0011FC54F13C7FF057BFF828EDB6A3F1DC6971FC6D7D1F58F817
                A3C5F1423D1B425F0BE9F3F8A6C60F08BD9EA37434B58F4C92F26B59659ACED2
                DAD6632C16B6F1C645FF0006EFF86FFE1547C31F84371FF0552FF82B0CDE12F8
                29ABF82FC41F087468FE3A7C188744F86DAE7C3BB8B6B8F036A5E0FB493E1EC9
                7BA1BE8E2D638AC85BEA518B6880863DB0EE8D8039FD2BFE148FFC288F1CC3A4
                FC34F89B27EC1D07C43B96FDA23F66816DAA68DFB557FC11E7F693D2EF93C5F7
                DF153E14596813CDABF86FC27A3EA57D0789D22F0ACB7ADA126AF6FE25F08C9A
                AF84AFE5B4D2BE58FDB763BA1FB46FFC1222E3F681D060F8A7F17EC7FE0A31FB
                2259FECD3FF050BF869A7C51FC33FDAC7F667D66FBC53AC58F87BE2B4FE062BA
                0F87BC6FA6C9AA69B7AB6134234DD41752BCD6BC29259C1AB789347D1FEEB4FF
                008208DC43E3BD5BE2E5A7FC15CFFE0AEDA7FC60D7FC2FA2F81F5FF881A67C7F
                F83DA65FF883C19E1CD5AFB5AD03C39E21834EF87D13EBD0585C6A9AA3DB0BBB
                89441FDAD78B1848EEEE124F8DBF681FF823FF00857F6145FF00827A78B3C09F
                B747FC1423E29783FC0BFF000552FD8B2F746F81BF1CFE33780BC5BF016C359F
                89FF001FAC6C3C4DAE69BE00F087837426D1AEA59BC4FADBC060BC4B781FC497
                A4427ED529A00FEB368A28A0028A28A0028A28A0028A28A0028A28A0028A28A0
                02BF9CDFF82A5F9D67FF0005B4FF008373F5355536EBE3AFF828CE92C54244C9
                26ABF007E165B2069792E0AF9A42051FEAD865778C7F4655E1BF10BF66AF817F
                15FE2BFC10F8E3F113E1BE85E2AF8AFF00B375EF8CF51F81DE35D45B501A9FC3
                ABDF887A2D9F877C6773A2456D3C76F235FD969F656EE6E619F68B6431F96CA1
                A803F9C5FDBD743F8251FF00C17C3C23AAFC61BBF889F0C24D4FFE0983F0AEDB
                E18FED5FF0B34C99B56FD92FE315AFED91F12B44F03FC48F19F8A45BCD6BE0CD
                035C93C4E9E11B87D5E0BED1B508FC4F2E95AF40BA56A575247F651D47E39F87
                3E3F6BD1C7A17853C3BFB7DC1E0786E3E277C1F323F87FF656FF0082B47ECEFE
                0682D744B8F1DFC27B9F10CF35AFC31F88DA158EA16168D1DFCD7377A1C9770E
                8BAD9F12F84EFF00C33E20B3D5FDB37FE09FBFB29FEDC7FF000536F869E1EFDA
                83E1D7897C7FE1E7FF00827B7C5CB18F4BD1FE2D7C5DF861A56A165A57C7FF00
                8616573A5EB23E136BBA14FAE40F0F8FB5347B4BA9A5B6956F879D0CED05A35B
                75D17FC1BE9FF049EF33C2F3DFFECEDE39D7AEBC191C89E18BAF127ED5DFB5FE
                BF3686D2D9369D2CFA47F6AF8F654D2246819A12D6890653098D888AA01F2D16
                F80BA5FC230FA7CBF1534BFF008278E9FF0011AF5B47F1240F7DE12FDA43FE08
                A9FB57F81EEEFF004BD4AC8697ABDB4FAA7C38F0269F3EA777685449AB69DE19
                875996CCDBEA7F0DBC441BC3DEBF7373F1AF4CF8FBA069FAC6A7E02F02FF00C1
                46F4EF02DE2FC22F8A7A6DB5FF00843F648FF82B2FECF9E0C85F597F017C40B6
                D346A8BE05F1668906AD73742CC9D4753F0B5CEBD77AC7879FC4FE16D53C4FA6
                4FD35FFF00C1BB9FF04B3367E21B2F0AFC2DF8D9F0DA3F198963F1DBFC3CFDAF
                BF6AFD04F8FED1EDB51B382C3C7314DE32B887C510DBC1A9CF6F0A5DC5218A05
                5B742B0178DF3F5DFF0083743FE0981AED9F83B4B6F067ED1DA768DF0FDB4297
                C15A1D9FEDA9FB5A5CE91E14B9F0DD8DF69DA2DE786AC75BF18DE2F8765B686F
                E48E27B0FB3792A8121F21249D6600F1BB5B2F86117C2AF88F6FA7FC29F1F6AF
                FB0CAF8EA4B3FDAABF63A74B9B6FDA4BFE0943FB44E8B7567E2DB8F8C1FB3FC7
                E07B8B9BEB4F0B69B797363E265B4F03DFDC7F64FF00A278A7C092EA5A65FDED
                9C1EAD7F67F10E4F1C7C13B5F127C6DF0B45FB494FA24A3FE09F9FF0514D134C
                D2A6F849FB657C3CD434BB8F15B7ECBBFB58681E0DF234BD5B51D4B4FB07D4E4
                B4D3059D9EA28A3C4FE0A7D1357D3B57D2B49A9E1DFF008378FF00E094BA81D7
                7C4BE18D13E3EEA9AA6B4F2785F5BF1A689FB707ED4B75AB5CDEF813C41AB68D
                77A36A1AC697E31D9773E937906BFA5C96972B2FD9244BD87CBB7B85988AF61F
                F06CFF00FC1232CFC3961E119FE0D7C66D4FC31A4DED9EA7A36817BFB5D7ED53
                1689A36A5A74F2DD69FA8697A2E99E2FB6B4B29EDE599E48E548032312CA54B3
                16008EDF4F9353B4F8D8BA17C049F52F0A6B2441FF00052FFF008255EBD7B63E
                27D4FC25A878D4497B27ED39FB1D146B7D3BC4106B6D65AA7885A1D11AC6CFC5
                4FA66A177691683F10B4DF10D86A3F9C3FB7E5A78A4F8F3FE084BAD69FE298BF
                6B1FD9E53FE0AB7FB255D7ECB1FB69CF2F87B54F88FE1DF87BE2BBED574EF11F
                ECF5F1E35BB968753F12EAB27F60F87EE2CFC49696D0CBA90F86F756BE29B6B6
                D7741B7BFF00137E9AC9FF0006D8FF00C12265D525D75FE057C5A3AE4F651E9B
                3EB47F6C2FDAFDB569F4C8EEA4BD1A64DA83F8E4CB25B99669E4F24B150D3BB0
                0ACDBABC87C73FF0439FF82687EC93F127F61CF897F01FE05F8A3C1FE29F067E
                DBDF06753D01B52F8F3FB4278FF41B5D562B6F1CEBB0EA5FF0877C41F136B1A4
                A5CFF68DBD8DE9BB8EC239965B35612C6925C89403FA3BA28A2800A28A2800A2
                8A2800A28A2800A28A2800A28A2800AFE683F643B4BAB4FF00839EBFE0AD2E96
                882C753FD8D3F64CBF9EEA5BC5F385CC1E14F84DA6D94767631424185D2CEFC3
                B4B32323D8A6D4952E01B7FE97EB82D33E15FC30D17E207893E2CE8FF0E3C07A
                4FC53F1968FA4F87BC5FF12F4CF08787EC7C7FE2AD03410A342D0FC49E31B5B7
                4D475CB3B20AA20B5BAB99638768F2D63C0A00FE53EC7C5DA4783FE3DFFC165E
                3FDA0AF7C09F14BF615D6BFE0A05696FF1FBE0EC178744FDA0FF00672D4F4FFD
                9A3F65DD5FC3DFB6D7C1CD4340BCFEDEF10DB69535BE9CBA85A695696BAAE943
                E18596B7E1DB9BAB9D2B56B0B9FA56EFC7F6D0FC4CF83FE18D63F6B1F8356DFB
                54E85A029FF827CFFC14857C47E1BD63E19FED9FF07ACADBFE124D4FF650FDB5
                6D7C17736BA76A1ACDED8DADC5C4C2D8DB477FBE4F15783C691AB596B7A5DAFD
                2BE12FF825A7FC13C3F699FDA8FF00E0A2DF13BF681FD907E0CFC5FF001F49FB
                5C783F48FF0084A7E20F857FB7F538F4B6FD87FF00636F12BD8593DF9096B6ED
                A878975FBB290AED32EAB70D925D82FB3AFF00C10C3FE09008303FE09DBFB2E6
                32C79F86DA6B637316C0C9E00CE0018000006001401F9DB378F3E146BFF0D3F6
                98F16D97C25D03C7FF00B26A78EEFED7FE0A9BFF0004F6B1BCB1F127C43FD917
                E2D4963A578975BFDAEBF650D73C09F679FC5DA46A308D03C6F247E1D6B69F52
                F224F14F859F4EF1741E22D2356E92FF00C67E1CBFF19FECE3E10F883FB56782
                53E2C5E695AAEB7FF04A7FF82AA697E22F0BEABA4FC71F0EEB1A5C1E20D43F65
                4FDAB341D22E2CB4FF0018DD5FE9769671DDD95CCD6B69E2CB3D3A0D5F45B8F0
                EF8C74ACD8FD7BAF7FC1BEFF00F0466F11DEAEA17FFF0004FBF81B6D3ADBC76C
                22D021F16F856C7CB88BB2B1D33C31AA59DB1909918194C25D8050588440AB6F
                FF0006FC7FC119ED8B347FF04FBF8184BB16227B7F155D2827B225CEA6EB1A8C
                E02A85030300605007C6FE1BF1FD95B6A3FB405E785FE17781A6F15DF992D7FE
                0A89FF00048ED5BC41E1DF15F85BE2369BE2AB5D4AC758FDACFF00620B9D71ED
                34EF14378A6C17FB4A6B18618B4FF14C5A7DC595FDBF867C7365AAFF006867CD
                E3BFD9CD7C23FB3E68175FB57F87B54FD9BB59D4EC755FF8267FFC14434AF1A6
                85A97C77FD8ABE24788ECA3D33C35FB3CFC7B7F1AB3DD788BC3FA85BABF86EDE
                FBC59084D460D3D7C29E338975B8B45D5759FB8FFE1C09FF00046DFF00A47C7C
                02FF00C14EBBFF00C9F45AFF00C1017FE08DB677F1EA50FF00C13E3E00B5C451
                A44B15CE91AE5EE9FB11D9D4BE93797F25A4AD9720BB405880AA4908A0007C81
                A67C6B58BE337C54F10784FC57FB377807F6F5D17C2FA09FDAFF00F62FBCF893
                E10D3BF65EFF008294FC215B1D6FC3BE14F8E3F04BC45E2A958F867C477D61A1
                EB1A55A6AB792DE4FA6BE8A9E17F1A43A8E9D6DE1BD6ADBC2AD7E337EC163E00
                F8260B3F8DDE1CF117FC134BC73E3FD0753F845AD5B7C4FF000DF843F6AAFF00
                823D7ED1567AFD9F85FC371786A7B9D4A4D57C2FE0BD035DBA920824B64B993C
                202F6E209BFE120F01EA83FE11AFD584FF008217FF00C1202350ABFF0004EDFD
                97480140DDF0DF4D73855551CB124F0A39CFA9E49357AD3FE0881FF0488B3B84
                BA87FE09D3FB27B491BBBAA5D7C23F0D5EDB6648DA2656B2BD8A485D40724234
                6554852A14AA9001F9BFA7FC75B1D73F688834CD2FF68AFD9534BFF82A1FC30F
                05DD699E0AF8A7A0F8E7C27A6FECC3FF000550FD99343B886F5FE197C58D37C3
                1A95E7FC2BEF1A69715EDACB2D9BC7757DE17D43551ACE8516BBE15D6F57D324
                F2AB8F8E5FB137867E0B78CE78757F0B6A5FF04E4F10F8EF58D17F6AFF00D8B7
                C55F11FC35A27ED1DFF04B2FDA1342F14C97577F15BF679B0D17563A8D8786F4
                CF12C13EB53E99E17BE9DB4933DB78A7C0D71369314FA6BFE9BF857FE0931FF0
                446F8F5E1EF139F037EC27FB1DF89346F07FC44F1B7C2FF13DFF00843E10681E
                19BCD17E227C2BF135FF00843C75E14B8D5B44B6B0BB59F4CD4F4BBFB29D2395
                A267B4619954026E7FC3813FE08DBFF48F8F805FF829D77FF93E803E00BBF8EB
                F0A27F8BDF0C7C0BE38FDBE3E00E89FB5C7C38F00F8857F618FF008296E83F13
                BE156A3E07FDA77E125AA687AC7887F66DFDB77C0DE1ED621D3B52BE959B44BC
                BCD39A4D2E0D64D85C7897C1D3F85B55B2D5EC74BFCDAFDB0FE3CFECFDF1BBE2
                4FEC1BAC7C08F8EBE0AF845F135BFE0B5FFB03BFED9DFB03F823C79E09F897E1
                3BBF8ED278EAEAEA1FDA9FF67DF10786E7B891B47D76D756696EF5AF0DD98B3D
                74EA9A5CFAB5A68FE23D3B5982FBFA35B1FF00820CFF00C11DB4F8E48ADFFE09
                E7FB383AC92412B1BDF084DA93AB5BB878D629351B895A142400D1A15571F2B0
                60715F3CFED55FF049EFF826DFECE7E14F81DF19BE057EC57F00FE177C54F057
                EDDBFF0004DE93C29E39F067822CB47F10E84FAE7EDFBFB35F863566B0BEB7C9
                884FA7EB5AA5B302A414BB6FBA769500FDF6A28A2800A28A2800A28A2800A28A
                2803E16F19EEBBFF008297FECD822C471F87FF00616FDB6BEDA19997ED0DE2EF
                8FDFF04FD1A5F911A7CAC201E07D5F797DA57EDF084DC1E5D9F74D7E3A7EDADF
                B4ECBFB28FEDDDF023C7517ECEDFB4D7ED2536AFFB10FED6567A7F817F657F86
                107C55F1E993C3FF001AFF00644D42F2E2EB409751D356CAD8FDBF4EB75B8798
                299AFE18C64B8AF967F664FF008381B57FDA23F68DF1BFC06BFF00F8254FFC14
                7FE16DBF837C0FA978B66D53C4FF00062FA7F1CC177A7EB7E18D163D1BC4BF0C
                FC9B61E17494EB7A830B93AC5D10DA5451F92DF6976B500FE8C6BF21BFE0A55F
                F050DF1EFECB9AE69FF05FE0443F04345F8B72FECFDF177F6ABF19FC54FDA775
                2F10D87C08F84DF027E08DFF0086F49F105E6A1A0F832EAC35BF893E21D7350F
                1258693A5E87A55F58EC617177733AC76D6F6DA87D3F63FB74F81AFA032A7C04
                FDB62DCC7117960BDFD8C3F688B29626440CF0A89F4055B9651800C0D2AB1184
                2F8AF97BF692D63F630FDAC2E3C3507ED35FF04D1F8F5FB465BF80DF514F03DF
                FC4FFD85F5FF001ADBE87178B6C6D6DBC473F87E2F1659FDA748565B2B259D1E
                0B773269B6F2C292982DE4500F0DFF00826B7EDBB61F0AFC0DFB2AFECA1FB54C
                9F19750FDAC3F69DBDF167C62F137C417F83FF00142DBF67DD2FE35FED591FC4
                BFDB92D3F66FD0FE2878B51E28B52F0FF84BC4979690E9B14D7905B43E0D368D
                7314F08813F7B6BF9C5F1D6A3FB4C788FF00E0A67F0CFF006B55F057C7FF0010
                7C00F829E10B9F87DF0AFF00670D7FFE09E7E39BAD4FE1DE9FE30F094B69F13F
                C6DF0E7E29C5F1134CD1ACBC57AE4FA6E9DA58D7F50D01D6CB46BBFECAB7B68D
                26D6E5D63F4CF4AFDBDB5BD52D05D2FEC13FF0504D3C2DDC36B2DBEA9F063E1F
                D8DD410BCC6DE6BFFB3B78C499E1858465960F36465903C51CC89218C03F41EB
                F31BFE0A8665BBF07FEC59E1BB74413F897FE0A6DFB05AA5C4B27950DA43E09F
                8DFA47C55BD675547694CB6DF0FAEED6345D9FBCBF89999511C1F94FF6E3FF00
                82D2FC57FD91FE19F87FC79E12FF00824EFEDEBF14AF75CF8A9E15F8730E95E2
                1D13C05E07D3AEADBC41A3F883599B52D0A5F87BA978F35CD52F238BC3F2A436
                12F86ECE091DD926BED3DC5BADCFCC1F16BFE0A23F183F6BAB5FF827DA78F3FE
                09ADFB727EC77E5FFC14BBF639BDBBF12FED17E0BF047867C1110BBF10EB9A4C
                9A545F6CD6AD3C51F6990EB56E9109BC276F196DE19E230BA800FEA128A28A00
                28A28A0028A28A0028A28A0028A28A0028A28A0028A28A00F83EF2D9351FF829
                BF86EED55206F077EC21E33B69180DEFA9A7C47FDA03C05242B91B45A2D81F85
                7371FBCF37FE122FF961F65FDFFDE15F8E3FB597C44FDAFF00E13FEDCFFF0009
                5FEC95FB1F69DFB597882FFF00626874CBCD1BC43F1DF40FD9EBC3FA4DE69DF1
                C751BBB3B54F17F89B46D5ED757BAB88EF67616482D9945A2179218E6F322F16
                FD91FF006CEFF82EAFC5EF8F3F10BC2DFB437FC1283E087ECF1F08F4AF01C5AD
                783352F177ED5B14770FE2A5D6ECED4E893FC48F86FA5F8E6D7C5CF71693DCC8
                96B6FE16D1D60FECD779AF0F9B042C01FBEF5F823FF05ADFF82876BDFB1BC5E0
                1F87B65FB4669DFB1E689E32F80FFB4B7C7493E3A27837C2BF103E21F8EFC57F
                01E3F867A47823F65AF81BE16F885A76A3E1CFF84A3C617FF152D6F4EA1A9DA6
                A26DEC3C097D1C368AD786FB4CFD06D57E2E7FC140F4AFB2887F628F80FE2117
                36E92B7FC237FB6DEABFF12F7F943DA6A23C51F09F49C4801E0DAFDA90F96C0B
                A7C9BB92BEF89FFB7C7882E6CA1D63FE09E5F00AF2DECA65B9B0BBF107EDAB65
                791E9F72F0081E78618BE16DDC96B2049E78CBC2AC4AAB8048650C01F0BFFC13
                F7E39FC5FF00D8EEEFF625FF00827CFC71F80DE29D5F56F8F5A3F8FBC4BACFED
                633FC40F0520F8A3FB5278E7E1A788BF6E5FDA4F5BD33E0B5AC31EB7FF0008AD
                9EAFE38F1568B3F8B185A5B45ACDC59D87D8A05BB8241FBFB5F825E19FD947F6
                DEB8FF008283EA1FF0512D7BE1F78AB45F19DE7C3A97E11C5F0564FDBBBE18F8
                97E0B59FC39D274DD5EDEC7C13A678625FD9F5358D0B4AD475B934FF0015C93D
                8F8BA0BC37C914D746EA28974C83F43F58F8D1FB6FE9FA8BD9E99FB0EF8335DB
                24B789E3D56D3F6B7F0CD8DBC931B612496E2D752F09433A159034418C601F95
                BE405B6007DBD5F04FEDC97F343E23FD84343876C49E29FDBCBE1769F7175B82
                B5A41E1EF855F1BBE207EE94B22B9B86F05C56454BAE135272A256548A5F8F7F
                6D3FDAF3FE0B2BF0BBC0BF0FF57FD94FFE097BF0CBE2AF8BB59F897A5E81E2BF
                0FEA3FB4E689E2C92CBC1D7BE1BF12CED771DB5B5AF84EDFC3A5751B5D0124D6
                2EB54BBB7B74DF0B59CDF6E4BAD37CD2D3E327FC1513E3BFC47FD862D7F6B0FF
                00826B7847F662F09F87FF006B3F04F8BB5FF1A7823F6BCF0EFC7CD574E9ADFE
                0C7C73B268F56F875E0BF0C4516836092DF59C72DF4FE23B88A07BDB651E7B36
                E8803FA03A28A2800A28A2800A28A2800A28A2800A28A2800A28A2800A28A280
                3E39FD9618DD7C49FDBBF557F965D53F6C58D248441245140BE1BFD933F652F0
                4DB085E4E2E4490785ED67674F944975220C79581F6357E0DFC43B6FF82D0F80
                BE217EDB92FEC35F07BF61ED57C2BAFF00ED450F8B3C13ABFED61E38F8F7A578
                A3C57A3EA5FB387ECEB65A8DE783BC2BE09D1ECF45BED3A1D474ED6ACA3BD6F1
                4C49F6AD27518248524B2904FE85FB07789BFE0BA7E23F84BE2DBDFDB93E1AFE
                C49E03F8AC3E22EB10784F49D2BC43E2B36BFF00080FFC239E18974ABB920F86
                D77E22B278C6A33788E2513EA91DDB2DA112C5120B696700FDA2A2BE1BFEDBFF
                008293E9F0C300F861FB0EF8B27967B7926D47FE17A7C79F8790E9F6AD26CB9B
                187441F0EFC4EDAB49126244BA37F622423CB36F6E0F9A2C3F893FE0A3A5EDD2
                1F831FB12C7133B0BA9DFF00696F8E923DB44B0B346D6F68BF09905E33482342
                8D35B85572E0B9411B007DB9457C489AE7FC146DC297F85BFB135A6FB69B3127
                C78F8E97E2D6EFCBB74B65598FC38B6FB6C4185D3B1F2ED8E3CB40010CE522D4
                BFE0A3ACF2F9BE0BFD896DA11836EB17C4AF8EB78FC9FF0057296F09DBA8DABC
                6E55E71F7533C007DB95F855FF00059FF8C3F1ABC04DF047C11E18B0FDB463F8
                21E2EF87FF00B47F8B3C633FEC11F0F7E2FF00883E3FFC4AF8F7F0F346F877FF
                000CD9FB37DBFC4CF8310DCEABF03B45F14CBE28F88FACDE6B50C76524FF00F0
                A92DEC86A1A7DB5C6A2B77F7FDC49FF051696D6D459D8FEC556378235FB69B9D
                4FE39EA96AD2794032DAA436766D1AABE482E5B2A00C213915EDA2FF008290B6
                05D5E7EC436EBE6C0BBADB4BF8F175B606622E2511C97700674508563DCA1CE4
                1784004807E3B7EC5BE3DFDB13FE09EBE27FF826CFEC11ACF81BE197C49F05FC
                70F0BDAEB7F18E5D4B5DF895E2DFDB5F55F8A1F127C0DE35F8FDFB54FED67F10
                6EE467D2FC2FE0CD03E227896D7C2D71378AA15D4F50B9F12DB2DBDC3CA822AF
                E99EBF0ABE22FF00C1377F6A7F14FED5969FB73E91E3AF833A6FED2D65A57807
                C2F7379E14F8BDFB6F7C28F01F8ABC0BE00D5A1D5B4BF875E2BF05F87BC65A9E
                83A9787649E4D5AEAE34597C3F7105D4FAB5CCAFE55C5CCF72DF6709FF00E0AA
                BE5427FB2BFE09F4263248B34635CFDA33CA8E0548BC87865FECF06566265050
                C718511A10CFBC88C03F41EBE18FF8281E89A87883E11FC1ED2EDA08A4D247ED
                C5FF0004F9D5FC49379E2DAEACF4CF0BFEDABF02BC53A54DA7932C42477D6344
                F0BDBC91FEF09B7BDBADA8CC136FC71FB5A0FF0082FBB7C229E4FD95DBFE09CF
                07C524D7FC3CC96AE9F17A7B897C3E269C6B9158DDFC4231E921FF00E3CB22E2
                146F2967F28ACBE4D7CF3AC783BFE0BFBE33F873F06348FDAC745FF82707893C
                35A7FED87FB0978BFE2069DFB30E9BFB42EA3F18E0F87BE02FDB2FF676F1BF89
                75AB187C6E0786A07D2AD3C3DAEEA7A94E91BC70E9DA3DE4B6A5278A068C03FA
                34A28A2800A28A2800A28A2800A28A28032A4D0B449B5AB1F124DA3E972F88B4
                CD2B54D0B4DD7A4D3ED1F59D3B44D72EF46BFD6B47B1D5190CF696B793F877C3
                F34F6F1BAC72BE8564F22BB5AC063D4000E800E31C0038F4FA7038A5A2800A28
                A2800A28A28013038E0718C7038C74C7A63DAA95FE97A6EA914106A7A7D8EA30
                DADED8EA56D0DF5A417515BEA3A65CC57BA6DFC11CEACB0CF6F3C104D14AA034
                6F0A321564522F5140051451400514514005145140051451400514C54542E46E
                F9D83105D9954AC691811AB12225C22FCAA146727196625F4005145140051451
                400981E83A63A0E9E9F4F6A5A28A0028A28A0028A28A002930318C0C0C60638E
                3A7E54B450014514500145145001451450014514500145145001451450014514
                5001451450014514500145145001451450014514500145145001451450014514
                5001451450014514500145145001451450014514500145145001451450014514
                5001451450014514500145145001451450014514500145145001451450014514
                5001451450014514500145145001451450014514500145145001451450014514
                5001451450014514500145145001451450014514500145145001451450014514
                5001451450014514500145145001451450014514500145145001451450014514
                500145145001451450014514500145145001451450015F88507FC15C357F8DDF
                B4A7EC93F05BF652FD9FBE28F897E167ED09F1D7E25E85A7FED4DE30D17C1317
                C0CF89FF00037F677F09F8A25FDA13C6BF09E4B2F14C3E25860B0D6AEFE1A586
                93E21D47C38BA5EB0DA9DEA5835E04B57B8FDBDAFCCAFD957FE0935FB2B7EC7D
                F15F47F8B7F0B6F7E33EAF7FE05F0B7C4DF007C12F047C45F8B5E22F1AFC2FFD
                9CFE1C7C5CF15E81E34F19FC3FF813E03BE0967E08D3A6BFF0ED9EC9185D5DAC
                0ED68D7525AC3690DA807B77ED79FB7F7EC8BFB06E95E0FD6BF6B0F8BD6FF093
                49F1E1F128F0B5F5CF833E21F8B60BF4F075BE8F73E259A73E00D23553A44569
                1EBDA4334B7A2D908BB1B0BEC9367B97C11F8D7F0D3F68BF857E0EF8D3F07B5F
                B8F14FC34F1ED85CEA5E12F10DCF877C4FE149356D3ECF53BED1E5BB5D07C636
                5A76A563199F4DBA086E6CE1F3111258FCC8A585DFC8BF69BFD84FF63BFDB3E4
                F06CBFB557ECE7F0B3E3C4BF0F62D761F04CBF117C356DAE4BE1A87C4C7496D7
                E1D2E490AB40974742D20BA64826C23C01CE7DABE10FC1FF0085FF0000BE1BF8
                4FE0FF00C17F02F873E1A7C2FF0002D84BA5F83FC0BE11D3A2D27C39E1DD3A6B
                DBAD4A6B3D2B4F83E4B68DEE2F6EE62ABD5AE1CF7A00FC2AD4BFE0BA52F833F6
                7FD47E36EA1FB377C41F8C57DAEFC26F8BFF00B68E93E09F83D1F82341FF0085
                21FF0004FDD07C69AF782FE047C63F8E1E28F897E29B1B2D7358F1C5B78666D7
                ECF46F0E97BB9A0D42F2D6DAC66FEC27BBD4FF005CBF63BF8CFE21F8B5F027E1
                08F8BBAD78262FDA86D7E047C0CF1A7ED2BF0DBC2823D26FBE187C45F89BE03B
                5D7F51D0F59F04DC5F6A17FE0C8CDF59F8960B7B6BF9DE465D12520B88DB1F9B
                1E01FF0082197C0BBDF873F0EBC07F1DFC69F143C427E0F787B56F809E1A9FE1
                47C5EF88BF0CB43F8B1FB1FF00827E37F89FE2DFECBFF05BF682F0C69171141E
                365F02C1AED869B104758E4FEC991B7982F1ED61FBBBF67AFD8F74CF801FB597
                EDAFF1EFC2BA5FC3BF0DF83BF6B0FF008511E216F0D7823C3D0F86F553F11FC0
                3A7FC4C83E26F8D3C696FA75B5BD9EAF7FAFDCF8CB4ABE7D4C3CF77732C774D7
                6C59216900383FDB73FE0AB5FB147FC13F3C65F08FE1DFED1BF18BC25E10F1CF
                C5BF15782B4AB0F09DDEBDA4D8EB7E19F02F8C754F12689FF0B93C4D637F2C46
                C3C2FA75D78535782E75004ED7B631C6B2C9B51BEC9F177C6FF859E08F81DE27
                FDA435BF18696DF04FC21F0A75AF8DDABF8FB4732EBBA31F85BA07846E7C777F
                E2FD2CE8A93C9ACDA9D22D25BD88DA24CD347B3CA590BA06A7F15FE02FC2FF00
                8D9AAFC1BD6BE2378746B9A8FC04F8BBA57C72F85F30BDBCB21A07C49D17C1DE
                36F01E9DAE49159BC69A92C7A5FC43F165BFD9AE5658B3A82C9B3CC82168FB6F
                1E7813C21F13FC09E33F865E3EF0FE9FE28F00FC43F09788BC09E35F0B6A71B3
                E97E22F0878B347BBF0FF88F40D42289919ADEF2CAFEF2D9D5590ECB8600AF18
                00FE7FBC2BFF0005AED587ED63E13B0FDAB3C15A4FFC13FBF64FD13F658B0F8D
                BADEB9F18FE207C3CF19EB1F10F5FF00DA63C75A368FFB1F787F5F9FC2492BFC
                26D664D03E14FED31E22BEF0F4571A9182D3435B8BEBAB7874EB8317E8FF00EC
                8DFB5DEA9F1ABF695FDBD7F676D7357F0778B2DBF65EF1C7C0CF137803E20F82
                A5B71A4EBFF063F69EF831A57C5CF879A5EB02DE69E0B9D4B4A787C4B0FF0068
                DACBE45EE9D73A25D2AA4D35D67E1AFDA5FF00E08BB61A0FC02BDF879FF04E6D
                4B47F83FF123C79F12BE1BEA7F1BBE23FC73F8B9F1BFE227C45F1EFC1AF875F0
                D7E297C31B1F85BE09F8E9E3793C6FE22F8213B687F11EEFC2B16B1E1CB482E2
                DFC3FA96A7A642522BBDA7EC4FD933FE09E3E1AF839F0FBF6A2D2BE297F63EA5
                E27FDB0A7D2BC3FF0013F47F869ADF8BB44F0C7833E0D7C3FF0082BE1BFD9ABE
                0DFC1AF87BE31DFA7F88FC8D07C13E0FD2A26D7659AD3509B53D6F55BE47B569
                A011006B5D7ED37F19FC5FFB2AFED5BFB4FF00C3697E0C785FC2763E1FF19788
                3F636F117C64BDD53C1FE01D73C03E12F045A8D37E3A7C65F144F751258F8675
                FD6A0F10EB3A735A2D9ABF86ADF44BD7B88E6D5E64D3FCE7FE093FFB44FED2FF
                00B45FC3FF008CDAFF00C6DF1668DF1B3E16683F11B42D3FF666FDAB348F809E
                2EFD9820FDA47C01AAF80BC3BAFF008BBC4361F05FC6D75757961A5E87E23D47
                C41A069DAFC461B6D62D34586EA159F6497377F71FED01FB30FC13FDA7BE0078
                C7F65FF8C7E0F6D6FE0878EF41D1FC33E21F06683AF788BC0A1F43F0FEA9A46B
                3A2E9DA66B5E06BBD3B50D0E2B6B8D074A655B2BA8014B41130689E48DA87ECC
                5FB2BFC26FD90FE1F5EFC31F836FF12DBC297FE25BEF15CD1FC51F8D1F177E38
                EB506ABA869FA5E9B73169DE26F8CBADEBBA8E9165E5E9166CBA75A5CC16A92B
                CF32C2B35D5D3CC01F4651451400514514005145140051451400514514005145
                1400514514005145140051451400514514005145140051451400514514005145
                1400514514005145140051451400514514005145140051451400514514005145
                1400514514005145140051451400514514005145140051451400514514005145
                1400514514005145140051451400514514005145140051451400514514005145
                1400514514005145140051451400514514005145140051451400514514005145
                1401FFD9}
              Stretch = True
            end
          end
          object TabSheet11: TTabSheet
            Caption = 'Telaio tipo b'
            ImageIndex = 1
            object Image5: TImage
              Left = -2
              Top = 3
              Width = 500
              Height = 198
              Picture.Data = {
                0A544A504547496D61676593CA0000FFD8FFE000104A46494600010201004800
                480000FFC000110800C601F403012200021101031101FFDB0084000101010101
                0101010101010101010101010101010101010101010101010101010101010202
                0201020202010102030202020203030301020303030203020203020101010101
                0101010101010201010101020202020202020202020202020202020202020202
                02020202020202020202020202020202020202020202020202020202FFC401A2
                0000010501010101010100000000000000000102030405060708090A0B100002
                010303020403050504040000017D010203000411051221314106135161072271
                14328191A1082342B1C11552D1F02433627282090A161718191A25262728292A
                3435363738393A434445464748494A535455565758595A636465666768696A73
                7475767778797A838485868788898A92939495969798999AA2A3A4A5A6A7A8A9
                AAB2B3B4B5B6B7B8B9BAC2C3C4C5C6C7C8C9CAD2D3D4D5D6D7D8D9DAE1E2E3E4
                E5E6E7E8E9EAF1F2F3F4F5F6F7F8F9FA01000301010101010101010100000000
                00000102030405060708090A0B11000201020404030407050404000102770001
                02031104052131061241510761711322328108144291A1B1C109233352F01562
                72D10A162434E125F11718191A262728292A35363738393A434445464748494A
                535455565758595A636465666768696A737475767778797A8283848586878889
                8A92939495969798999AA2A3A4A5A6A7A8A9AAB2B3B4B5B6B7B8B9BAC2C3C4C5
                C6C7C8C9CAD2D3D4D5D6D7D8D9DAE2E3E4E5E6E7E8E9EAF2F3F4F5F6F7F8F9FA
                FFDA000C03010002110311003F00FEFE28A28A0028A2BF9FBFF82CA7FC146FF6
                AAFD982C3E30FC37FD91B4DF80DA16BFF097F653D03E3EFC4DF88FF1D6EFC557
                57B732FC74F893E38F811F00FE137C07F0C784EFF4BF3FC63ABEB3E00F1F6A31
                EA9AB5C5CE9D689E11B78E7B49C5F6FB700FE8128AF86FFE09F1F103E146B1FB
                3F58FC01F863F13757F8B7AB7EC1F7DE1DFD847E3478CB5BD27C55A75FDE7C72
                FD9E7E157C35D37C791CF7FE2EB3B39FC53215D6F479E5D5ADD26B6B89AF6731
                4D3EC76AFB92800A28AFCB4FF8297FED9FE33FD9B24FD9C3E09FC23F885F02FE
                0D7C5CFDAAFC65F12F45D37E38FED2F6F7973F057E087C31F837F0A3C43F133E
                2A7C4AD674DB4D53445F12EAF6E96BE16D374AD1EE754B1B69AEBC4DF68BA91E
                D74DB982E403F52E8AFE6F7FE094BFB7CF863E1CFC0EFD947C25FB4E7863E309
                FDA37FE0A29F1135DF8FDE37F8E3A47C24F1745FB3FEA3F173F6BBF117C53F89
                FF00B3E780A4F166A97539D1AE2FBE1DF807C1F61A669BA441A8D9E9DA7785B4
                A5D42E74F332CB3FF48540051451400514514005145140051451400514514005
                1451400514514005145140051451400514514005145140051451400514514005
                14514005145719E01F887E04F8A5E1B4F187C37F16681E37F0A3EB9E2DF0CC5E
                22F0C6A36DAB68D36BBE02F16EB9E02F18E996FA859B3453C9A76B3E19D7B4D9
                846CC166D2664C9D9401D9D14514005145140051451400514514005145140051
                45140051451400514514005145140051451400514514005145140057CC5FB6CF
                C5FF00157ECF5FB19FED6FF1F3C090E8F3F8DFE07FECC5F1EBE2FF00836DFC41
                673EA1A04DE2AF869F0ABC57E33F0EC3ADE9F6935B4B7B66D77A259ACD0C5716
                ECF197559222CACBF4ED7C55FF000526B386FF00FE09D5FB7CD84E0FD9EF7F62
                AFDA9ACE609856F26E3E0678EA09021208076B903E53DB83401F92FF00B53FFC
                1723F6CAF8112AA7C39FF820AFFC1463E2A5B18E69FF00B4B538FC35068E2D12
                45682E4EB3FB3959FC59B38D1EDE5B597734EAA099514C820773F41FC54B4F85
                1FB4EF8D3E087C7BFDA2FF00E0861FB497C49F8D3F0DB45F0A6A9E06F17789F4
                0FD82FC59AE7C3E79A6D2FC7567A343AE6A3F18ECEE354B6D23559669A1B5BFB
                256B6B97BE78ED2CE4BCBD597F64BC137B0EA5E0DF08EA16EBB21BFF000C6817
                B0A02842C575A4DA4F1AE506D202BA8C818E06315D45007F3C1A9FED69F187FE
                09EFF0F7FE0A01FB48E9FF00F04CBFF82807C4E7F8DBF1FEEBF6A8B6F095FE99
                FB27E85A5F85F51BDF813FB3CFC0A7F04EA9AC7C2FF8B5F10BC45A95A79BF065
                F579359D3BC1D74615F1335BAE9CF169C6E6E38AB8FF0082F4FED11A8FECEBE3
                4F8A8BFF00046BFF00828CFC29F15683A4F87B57D22FFE26FC2AF09A7C206B6D
                4FC45A469970353F1078BFC4BE09D6AE4CD05FF956C9A7E8F70ED3DD425E358A
                37DDFD29055DBB428DBD30028000E00C74E0003F0AF82FFE0A6EEF6DFB0C7C7E
                B982362F61A2F84750548EDFED01469BF117C1D7859E08C13E5225B16760AC15
                2366C304C100FCA3FDA97FE0BD7FB52FC07BA03C0BFF000421FF00829878EB47
                8EFEC74CB8D67C71E17D2FC216315D4F78DA7CC915EFC15B3F89F632A194451D
                BC86F634B937116D6884B0F99F607C5FF8D7A37ED4BA1E9DE13FDA1FFE0839FB
                5FFC79F0BF867559B5FD17C3DF1E7E1BFF00C12D7E22F87B46D7A0D22580EB1A
                1693F11FE3ADDDB5B5E35AEA1716AB7369187617534018E2745FD910AA000140
                0318000006060606303038E052D007F2B7F1AB50FF0082917887F6FF00FD95FF
                0069DF83BFF04FFF00DA67C37FB347ECB9E00B5F01780BF65EF177C24FD83CC5
                E0983C41E67877E2AF89FE1AEBBE14FDA96DB4DF0D788F55F098FF0084434ED6
                9F4692DF46D2F50BAB4B7D2EE56EB547D5FE99FDA8FF00E0B4BFB57FECCCDF0B
                A6BDFF0082217EDF7E27D37E22788B56F0ECA347F117C0FF001BEBF633E9B636
                77D0AE91E18FD9D358F88B717B2CB1CD7276EAEDE1E848B33E44F78CB70B6DFD
                05D26D5F97E51F2F0BC0F94631C7A0C00303DA803F267F67AFF82977C4DF8F3F
                143E027C37F14FFC13E3F6C1FD93A3F8B1ACFC41B6D53C4DFB50F867E1B78674
                116BE09F879E32F16DAE89E0E83C29E29D4B5AB8D52E64D13479986AFA0E9702
                5B457EB1B5CBAC1257EB3D7C2BFB42BE9D17ED81FF0004F48E5B858F5193C6BF
                B4745616C62B40B3DAA7ECE7E2C92FBCB9DD84C8D198EC8F951214657767D861
                873F75500145145001457CBBFB62FED05A97ECBBF0327F8C3A4782759F889756
                1F167F66DF00C9E0BF0CE9926B5E28D774DF8D3FB487C26F829ACDBF84B468AE
                2D0EABABC767F106FA7B1B56B88D25BBB5B547DE8EEADF8C9E31FF0083933E09
                F84FE35FC3CF80371FF04F6FF82A1E97E3FF001A7C4FF077C39D4AD7C69FB30E
                9FE158BC3CBE2AD69B446D42CB4EB1D7F53D4FC5D73037973C7A7E9BA749F6A8
                926F2673244B14801E9DFF00055CFF0082907ED1DF0774CFDA53E097EC59F0DF
                E1F7883C7DF053E0A7C2ED67E2E7C58F897E3DF15782DBC11E34FDADFC55E20F
                833FB36FC31F81DE18F0E685A8C9F113C75A8EAB1C7AEC4D737BA7E9D6D0E936
                96B23DCDD6ACA34DFD36FD8BBE3BFC0CF8D3F09AFBC31F033E39DE7ED156FF00
                B3178A8FECA7F14BE27EA4BE2ABAD535AF8C5F087C1FE0E4F184DAB789FC530A
                9F1DDDDCC3AEE85A8CDAE69F77AAD9DDCBADC8D15F5E3A5C14F813E33FC3EFD8
                07E37FED19F0D3F6B8F89BFF0004F4FDAC3C71FB467C29D4FC0D7BE04F89B65F
                B377ED0DE1BD574BD43E197896DFC69F0F758D5B4CD2EE34AD2FC512E91A93BB
                5ACFABD9DF490AA4F00D969298E6D8F831F192D7F65C8BF6DCF8A569F007F6E0
                F894BF1E7E3E78DBF6B33A037ECB3AB7836EBC2622F809F09BE19A7C37B192F3
                549E5F14166F814B711EA31D9DBB96F17C311B565B53717201FB39457F38FF00
                B2D7FC1C3B6DFB4869B33CDFF04AAFF82A3F842FADF456D527D7B49FD9D2EBC7
                3F08EC245B0BFBC8A2D5BE275BCFA71D22DE5FB0848EEA7D2515879ADB1040DB
                BF6A3F637F8CDAEFED1BFB21FECADFB42F8A34FD1B49F137C77FD9BFE06FC66F
                11695E1D86EEDBC3FA66BBF143E18F85FC6FAB69FA15BEA17179710594171AE4
                F14093DDDD48B14518796760CEC01F4851457F3FFE3EFF0082E56BFF0005BE0E
                E97E38F19FFC135BFE0A2FF1775BBC6F195BC7E2AFD9DFF671B1F15FC0DD4A5F
                07F8BBC47E1DBCBEFF0084DA0F146A379E10B058345B59C4FABD84324E2F0B5B
                433ADBDF8B000FD7BFDABBF683D1BF652FD9CFE2EFED09AE787B51F17DAFC2FF
                00085D6B961E0ED1EEECB4DD4FC63E23B89ED746F08F83AC754D4B16BA3C9AAE
                ABA968DA70BCB9C436FF00DA3E74BFBB85EBF09FE0C7FC148BE347C28FDA47F6
                C6F8CBFF000503F156957DE06F839A6FC38FD98BC1FF000A3F613F06FED1DF1C
                FE127877C79E14F871E2DFDAEBF68EF16F8D7CF82EAC7FB7FC0FE15F1A78074B
                D73C450DB69F0AC1A1A43B2D6664B3AFABBE1E7FC147FC35FB6C7ECB1A36A9F1
                1FFE0971FB74788BE1A7C7CF056AFA478B7E1AEBBF057E1CF8D3C27AB6837E75
                6D2B56D0F538FC43E24D2E5D52D268F4E9C096EB4AB20C648822867B7327C3BF
                B587C25F88B79FB21F86BF656FF82747FC13DBE367ECA1F013C49F126CBE247E
                D07F09EFFF00662F84FAAF87BE3A783EDED344BCD47E16F8AB42F0AFC70F05EB
                5A6697E25FF847B48B1F10C36BA8DAEA5A95869E9A53CD6F6979AB437801FD39
                7853C51A078DFC2DE1AF1A7853518758F0BF8BF40D1BC51E1BD5EDE39A28354D
                035FD3ADB55D1F51822B948E58927B6BBB6955648D1809406542081BF5F8B1F1
                5BFE0A87F173F671FD9EF5EF145CFF00C12CBF6F8F1AF8B3E167C2DB1D5AF34A
                F0AFC25F82FE05F86DAC5F68560961A87F645A782FE2378FF51F01692B269F7B
                3A585B5BF89EE6C2CD600DFDA0A229A7F06F02FF00C174FE2E78E3E14EADE3CD
                7BFE0915FF000523F819F648343BE4F1AFC50F83BE1A83E0EE83A15EEB9A3697
                AC789FC53AF78A3C43E14D616C2CA1D49AE7769FA35DC8F15BC9322325BCEAA0
                1FD10514514005145140051457CA3FB70FC79F16FECC1FB29FC64F8F5E04F0B5
                A78DBC59F0D3C3FA66B7A2F83EF2DE4B98FC4B34DE25D0F499B44B7862BDD341
                B9B887509E2B767BEB68D67781A57112C80807D5D5FC9B7C72FF0082887C46FD
                A2BF6A3F80DA978DFC59F0E3C33FB037C19F8DDFB657ED5FE26F851F067C2FF1
                1BC5DFB62DFF00C2BFF8251F8835DF05F87FE2AFC58FB3DCCD1E97A2789FE2BE
                89A0DEDA783E2F07E9B7434CD1C8BAD4E76B4D4DB4FF00A6FE3D7FC170BF6BAF
                83BE32D2BC35A2FF00C1083FE0A43E2BD2352F13691A1AF882EEC7C1AF6B158E
                AF7D6B696F77F6FF0083C3C77A1C573B2776FB35C6BD6D02B46AB2DDDBA97922
                F73D73C3BE0DD4ECBF698BBF87BFF0449FDA6FE117C51FDACBE1FF00C44F047C
                63F8E1E03F0A7FC12BBC2DF143C509F147449F4AF10DF788FC5D1FC75B5BEF13
                4A6E7ECFA9CB05D5C4B04F7B0FDAA5F3679A695803F607E17FC43F0EFC5DF867
                F0EFE2BF840DEB784BE277817C23F10FC2EDA95A8B1D44F877C69E1FD3FC49A2
                1BFB20CE2CE736BA95AEF883BEC6DCB96DB93DD57F3276FF00F057BF8AFF00B1
                378B3E10FEC0BE1EFF00823A7FC14E7E2B693F04BE03FC1CF03D978D7C37E08F
                0478DBC49A8E9DE19F025A7862C350BCB7F857A9789BC297311FF8471126BFB7
                F1C4F10952F03796D6BB64FD7EFD8F7F6C1F16FED4FE2EF8CDA7788BF677F8C7
                FB35E9DF0EB48F8497DA1F813F683F0D7857C29F1826FF0084FEC7C69777FA96
                BFA47827C49E26D32DEC987872C56D512EE19D4ADDADC468CA8B1807DDD4515F
                09FED91FB5A7C42FD983C4BF0334FF00017ECE9F143F69AFF859D73F14AD758F
                87BF052C3C1375F12E18FC11E085F12E97AAE912FC44F13F85F48B5B25B9F26D
                EE8C971797056FE116D6F2BA95600FCE7FF82D7FED27E39F84DADFC2BF87B75E
                35FDB17E127C17D5BE077ED15F1625F13FEC45E09F88BAD7C65F8D1FB41FC377
                F87765F05FF673B4F88DF0FF00C37E204F82FA65CC1E24F1AF882FB50D4D6C6D
                AF63F0CDBC125CDBDBDADEC77BB9FB077C45FDA17F636F11FEC0BFF04DEF88DF
                08FC23A9E87E35FD9F755D675DF894DF187C41E28F8F77FF0013740F84BA1FC7
                2FDA27E3D78EBE192787059F82BC1377F11BE226BDE04B57D5BC4116A736AF79
                14A2036B25BFDA38FF0082FF00F05A9FDAFF00E2A7ED61A2FECEBAD7FC10DBF6
                FDF875E11D5749F13EA8DF13FC5179E0BF0EC9691E85A4DF6A1A7617E22C5E1B
                F02CF1DDC963F67247C484915E555B68B5290A44DF227ED25FB50FC6DFD9F3FE
                0AC76FF1CFE137FC10D7FE0A79F17BE2BFC42F84DE06D3BC5BF15745FDAA3C5F
                6DF0A6E3C2F068BE30F0568BE03D7BE12FC1EBAF1EFC1D1A6694D6D79AA416DA
                D78AF4B921D5B5EBBD5CD8D8DEDC4179A9807F5A7457F3EFE3CFF82BA7ED31E0
                9D43E2BDF78A3F61EF8A1F08AF7C0D75FF000498D1F42F809F12CFC28F147C5C
                F164FF00B707ED9DF1E7E05FC59D47C0BAB7C2BF1DDF685AF4B37873E1C68363
                E1EB1D6F50F0BCF69E20B4BC7D5A07D3A4B6171C67C6FF00F82ED7ED39F0B7E2
                C7867E1E786BFE085BFF000532F12F87F5CF18F847C3975E35F13F84344F0FE9
                F65A5EB5AEE9BA0EB9AB59EA7F0DE2F1B7862E27B492EE56B6B6BCF15E9D6F72
                05B1B8BDD1E2B932C001DD7FC15EBFE0A57FB47FECB1AAFC5BF865FB307887F6
                70F87DE2FF00837FB287827F68ED5358F8F1A1F88BE20F8C3E3078B3E35FC5BF
                1F7C19F813F00FF67AF867E19D73416B9D6751D5BE1378C0DFEB57EDACDBDA2E
                B3A24634E93ED7717365F50FEC4BFB4DF843E1AFC50F879FF0484BFF00027C78
                BCF8DFFB21FEC4FF0002758F18FC5DF165BFC33BDF867E2FF077863C1BE03F86
                BA7F8A6D3C51A4F8A6EF5BD46FB56D496F62115D787ED1DE6D13539184714292
                4D378FF5FF0002FC66F157867E2FFC51FF00822CFC71F8A9F137E1AC3690F803
                C6DF123E1A7FC137BC4DF127C20965A94FE20B1B6F0378A3C71F16DEFBC3AB05
                FDA2DD27D8EEED912E258A652ACC241F10785FC35FB5BE9BFB7E5B7EDB1F153F
                64BFDB9BE2CD87843C35F1BFC2FF00067C0BE19F81BFF04ABF85BE3CF08F84FE
                356B3E0DBF1E03F8BBF1CB40FDA345DFC6DD1BC3167E13B7B2D0EC9F42D22684
                48971A95DEB37F04B34E01FD1CD15F84FF00B69FFC15A3F6CDFD99EF7E12D9FC
                27FF008221FEDD5F1E97E206A1ACDAF88664F167C15C784EDB4BD37C3BA9C2F6
                917ECCDA9FC6169A668F54D56374F108F09C064D10A5A5CEA61AE4D8FB5FECE7
                FF000506FDA67E397C53FD9CFC0FF123FE09F1F1AFF63CD1FE2AC7F16EEBC597
                FF001FFC51F05AFDE483C0BE08B4F1078774CF87965E0CF17BF8964BF96E2FAD
                DAEE2D67C17650C76F04E2398C904BE5007EB6D14514005145140057E63FFC14
                57F6D4F1D7ECCBABFECD1F06FE0F6A1F04BC21F173F69FF177C52834CF8B1FB4
                DAF893FE19E3E0EFC32F807F09F5EF8C5F177C75E3DB7F08EA7A2DF6BD782C34
                9D2F4FD3B498F59D162965D6E7BA9EFADA1D2658AEFF003735CFF82D5FFC148E
                C7F672F83BFB417C3FFF0082137C7FF8DDE14F88FF00053E19FC5B97C4DE0DFD
                A2FE1447A66AFA7F8E7C03A4F8D5F55F057813E19D97C40F14B584916A51CB6D
                6BA9699697EB1CC915D5BDB5C2346DF4A5DFC7E6FDBB7E027C22D57F6B3FF820
                6FED4DF12ACF54D2BC31F12ADFE19FC5EF0AFF00C13C7E23E81E06F165E69B15
                C3B68FA67C7FF8A7E18D774F9628E79AD59F57F08F86AF6482E2582F34FB459A
                E2DA80307FE0881FB4FB78E7E0FF0085BE16FC70D6BC47A87EDA9FB427C30D4B
                FE0A81F14A21E14F11E99F0C66F85BFB5E7C59F165EFC1D9FE176B9A9C6D6874
                DB6F0DDA7806D3FB22D6F7516D3A4867B2B8B992FEC35586CBF796BF17BC31A9
                FC45F0CFED3FA4FED39E12FF0082607EDD5E15B5F0E7ECA1A2FECA1E1FF855A1
                6A3FF04BDF0EF85746F04E89E3E8FE2268371A5A59FED0F09B24D3D3CBD2EDB4
                BB7B78A0B58CCCAA10B6C8FE697FF82D27FC142DFF00686F88DF072C3FE0DFAF
                DBA67F06F823C5973A0E93F122EFC75E10D323F12E9304F22C3ACDBEA1368C7C
                037CCF14123EDF0FFC47F11D986F2D16FE412C6EC01FD1BD15F1EFEC6BFB437C
                4AFDA33C2BF1635FF8A9F06B56F803E23F02FC6AD6BE1BDB7C2AF13EA7E0ED6F
                C69E19D234CF01FC3BF135AA78D75AF875AF788F40D4F509E5F16DECE24D2353
                7856DAE2CA3923B7B98AED47D85400515F90DFB537EDE1FB6EFC1CF8D3F1AFE1
                B7ECCDFF0004E5D6BF6DDD1BE17781BE12F8A96F3C1DF1FBE157C0FD434ABFF1
                F58F8DEE750D135B83E21DC5EEA1E2470BE14B79603A26853155BA3111732B28
                4F3BFD897FE0A95FB6CFED27FF000B66C7E377FC1143F6CEFD9D35AF869AEE83
                A2E9F6B6DF113E06EAFA378B63D52D75496F2F748D77F68BD47E0F2EB715B3E9
                D120B9F0DC1E25B322E97CDBBB3730C73807E5C787FF006F9F8E7FB697ED89FB
                247C60F146ADE11F89BFB3BFC13F0FFED7FF00F05068FF0060EFD963E1F7883E
                23FED6BE01D1FE064F73FB22FECDBA37C4DB8D17C472A78EFC5DE2AD53E3F3F8
                A23F0E3E8FE1D8B4A9BC13790CED710585DDC2FF004ADFB1CFED7DF0F7F6D4F8
                55AE7C4EF00F84FE25FC3BBBF057C56F8A1F037E24FC31F8C1E1ED1FC39F11FE
                1AFC56F83FE2ABCF0978D7C1BE28B6F0BEA5AD68B7934135ADBCEB71A36B5AAD
                B18F51891A68AEA1BDB6B4FCE1F8BFADFED0BAAFC3DF8E567FB24FFC128BF686
                FD91FF0068DF8FFA4F8E343D6FF6A0F0ED9FFC12D6DBC6FA06AFACEA93CFFF00
                0B0B5797C3FF001B12E7E20EA7725AE6F95B50BD4F2EF2EE2B8135DB441DB82F
                F82796A7FB7DFEC31FB33F82BF658F12FF00C13BBF680F8D7A3FC2FD424D0BC0
                DE3AF0D789BFE09E3F04ED93C1B7105849753F88B408FE3CF88AE7C59AADDEB0
                DE2DD7EFBC437335B5E6A1378BDDEE2D16E23B892700FE8268AFE6CBE0BFFC16
                63FE0A83F12BE22F893C09AE7FC1BE5FB5BF8734FD07C65E23D022F15DDFC61F
                08F82EC2F34AB0D7F54B1D22F6D6EBE31681E18F0F6AE3ECD65087BCD2FC537F
                6370CAB716970F6F79699FD82FD817F682F1BFED43FB33689F197E237850F80B
                C65AC7C59FDA77C1FAC780A4BBD0B53BBF018F849FB4FF00C63F843A6F81F52D
                63C2F3DD69BAFDE68F69E04B0D36E752B09E482F27D326B98884B840003ECBA2
                8A2800AF8EFF00E0A1D6B35E7EC01FB72D9DAC465B8BAFD8EFF699B5B78576A9
                9269FE0AF8D628625DC4282CCCABC90391D2BEC4AF96BF6E4FF9327FDB07FECD
                6BF681FF00D54BE2DA00F52F84DAAE943E0F7C31D4FEDF651E98FF000E3C1972
                97AF3C3159FD9C786B4B22613B1544400AF248038E9C57A3D8DDD95FDB4577A7
                5CDB5E594A0F917367343716B22A318DBCA960251C2B4657E5270508E315FC26
                FECDDFF04A3FD8187C08FD9A7F694F8E7FF04EFF000E6B9F16FE3E7C08F869F0
                EBF62CFD823C3FE3AF195B7C46FDA0BC65A9780FC2DAC78EBF69DFDA4B5BB6D6
                EE2CFC116B34A6E75A9A70F0695E13F0E5F2CDA9AEABE21D634CD334CF4BBCFF
                008217FF00C13BAFE3F14FECB3E1CF0F784B55F8BBE17BBD5FE2DFEDF3FB5EF8
                5BE2DFC5FF0087FF00B38FEC11E0AD5059EBBACFC1CF839E09B5F13AF86FFE12
                86D2F4C96DB47D3FC6ABADDCE95A559CDE27F174BA923689A56BC01FDB9D7C23
                FF00053354FF00860DFDA74BB3A245F0D2EA6CC4BCA8B7D574A9B605404B03E5
                AA940390481B722BF978B6FF008262FF00C12907D87F6C8D6BF64BF1C7853F64
                8B4377F083F631FD9E3C2FF127F68BD67F69DFF829A7C4FD72396C3C3FF10A7F
                0D7887C4F1EA7A6E897525B6A977E17D2AC64D2A4B8B19751F15F88AEB4DD0E3
                B6B7B5FCF8FDB5BF632F871FB08EB1FB497837C21E21F0DF857E3D7C73FF0082
                547EDC9F123F68AFD993E1AFC4BF177C40F03FECDBE1097C5DFB2D5CFC12F85D
                A65C78B751D4F56D4A482CAD7C717379E22D52E22FED8BA5D4EF2D6D349D35F4
                DB4B600FF47B5002A803000000C018000006070303030296BF85DF84DFF04F4F
                F825978A3E187C22FDAA3C53FB3AF8D740FD8E7E12687E0BF86FF072C74CF18F
                C6DD63F68DFF0082ACFED45AD7866C34694F83BC19FDAD6F73A9F8493564D5ED
                F48B4D0ED74D6D7EF74ED47589A5D1FC23A1C6759F5E7FF822DFEC797D7737C0
                F83F638F84127EDD5FB48E9561F13BC65E13B8F16FC48F1C7ECE5FF04B8FD9E6
                6173A7E83A8F8A1EDF5CB74F88FE2268B4FBF82CED2EA753E27F1343AB5D41FD
                8BE17D16E7EC201FDA2540B3402536AB244268E28E53007412A40CCD1C529847
                2A85A3750D80331903EE9C7F14B63FF04A2FF822FB7857C31F19F4FF00D9A2C2
                E3F61EFD9A758B4F077827E23D96A9E3EF19FED07FF054CFDA3349B0BCF0ED9F
                83FE15E8D677B10F1EF8567D4E0D5E1821F0ED85A378B35CD3D9B4CFEC9F0AE8
                32C9E28E9F4CFF0082447EC6DE1BF13DC785EDBF612F84BA9FFC1403F6A4F0D6
                81ADF803F654D0B59F1E47F017FE09C9FB3EB4B7D6761E3CFDA57C71F0CB56B6
                FF0084B6FA2946A771A85CDCEAA27F15EB7A20F0FF008512DB4CD16FB54B700F
                E8BFF69CB58D3F6D6FF8264EA09F6B5963F891FB4E68F886E9E1B4FB25FF00EC
                ABF10F50956EECE24DB76449A059142F22AA156F9246646B7FD0BAFE18BF676F
                D9E3F64BFD983FE0B63FF0461F85FF00B1A780BC7DACF827C2D71FF0516F86FF
                00157F6CDF13F89EFEF740FDAD7E33F817F64BF13CDE3FD17C21A3CB74D657B6
                1E05BDD5E0B37D4F42B0B4D196F3C5177A3D93DE4FE15D44DBFF0073B4005145
                1401F1E7EDC833F057C14005E3F6C0FF008279F0D1F98005FDBEFF006673C2A9
                1B480386E8A403821707EC20AA3185036FDDC0031F4E38E9DB15F1E7EDCCE22F
                825E0E7CAA84FDAF3FE09EE72C06D007EDF1FB34F0412A318E31915F62500145
                14500733E2FB01A8F847C4FA6AC4CFF6EF0E6B7622289E385DFED3A65CDBAC51
                4920D9113B800CC303827815F147FC1283FE516BFF0004D5FF00B302FD8E3FF5
                9DBE1CD7DDFA9FFC83350FFAF1BAFF00D2792BE0FF00F824F803FE0969FF0004
                D5000007EC03FB1C000000003F675F873800000000718007E1401F7F57C63FB0
                05AA587ECB1E07B18F718EC3C5FF001BF4F8DA46DD2BC765F1DFE265AA3C8724
                17710AB36C21724ED08A1147D9D5F1CFEC16C8FF00B33F860A0C05F883FB4046
                17000022FDA13E2947F28007CB952303DBA5007D88154000285000C280005C74
                000E063DA9AAA549E72A4AED5C2058D4222845D8A0E3299E73D4F4014070DAAA
                3A2818C6028000E028EC303038C7E140DA005C28C0C0500018181800741C0181
                ED400EAF90FF006F5BBB6D3BF631FDA6750B9B0B0D42DB4CF837E33D4A4B1D4A
                F6DB4BD3A74D3B4A92F3CBBCD46EC793A6C43ECEA5AE24C2C61379C6CE3EBBCA
                FA8FD2BE38FF008282846FD883F6AC8C0E1BE047C448C04FB28C67C3976AA17E
                D70DC42A7B012DBCE9D37472AE55803EC8A28A2800A28A2800AF86BFE0A56F73
                07EC29FB4A5C594F25A5DDA7C3FF00B65B5CC0EF0CD6D3596B9A35CC535BCB11
                56824430AB2BA152ACAA4152A08FB96BE0EFF829EDCA58FF00C13FFF006ACBD7
                648D2CBE136AF74CED2C16E8896D756131266B806384011FDE70546064103040
                3EF1A2A2468F1B54A9D98421767CBF2A90A54636FCA50E303823D454995F51FA
                5002D7C51F08E675FDB9BF6C8B1FDD7931FC1FFD8E6FE3D8E0BA49792FED1F65
                2452469232C202E9303053144F897277A184D7DAB945000DA1400140C01C7002
                81E9803007A57C7FF0E71FF0DC7FB5285C051FB3A7EC6A005C6063C6BFB62600
                000C0036F1401F6157C79F1D3117ED3BFB114CB05A334BE2DF8EDA6F9F245235
                DC114FF033C4B7ED1DAC8AEA90A3B69306F0C8E4F93185D986CFD875F1E7C7A9
                ECE1FDA57F6188E694457375F123E355BD8C4CD1225C327ECE9F11AEA78A30C4
                34922C76AD204407E482527012803EC3A2A2DF1A6D5DE8A73B153728C951F750
                71D14670076F6AAA352D35405FED0B0017E5DA2EADC63180060361718C607A50
                07F3E3FF00051557FF0086B6F152A98D40F897FF0006D1AC43CB24230FF82C0F
                ED600160AC03A83B06D52980BD7918FE876BF9D5FF00828EDCD85CFED0FF0018
                F5BB1D423B8FF845BC49FF0006DA6AB0AE9F6EDA9DB4B776DFF058CFDA76CCD9
                5EDC5A168B49458F50693CD9F6AEE8618400F730E7FA29CAFA8FD280168A602A
                A3F8555476C00A00FC00000FD3B629A1A355E1902A944182A14138544C0C004E
                5401FEEFB5002A646E5D8AAAA5447B4FDE4D8BC95DAA1082186D04F0A0F19C0F
                837F6919E3B6FDB17FE09C1192E9F6BF889FB48D94491A90ACE3F661F1F5E88E
                5DAA5550269EE704A7CC91E33D2BEEF696089373490A22EE018BC6883CA07775
                200DA14E4718D87A62BE12FDA526D3E5FDAABFE09B661B8B57B91F1D7E3A2449
                14D0B486D0FEC6FF00B407DA0A468D968C490DA0242900AA0F9723201F7A5145
                140051457F3A9FF0530FF828FF00C74F8ABF1AEEFF00E092DFF049F96C7C4FFB
                6BF8C3479A3FDA0FF6858EF6687E1C7EC1FF000D2ED6CA2D5FC51E27F1159C13
                C51F8A64B4BE912DAD6DDA4B8B096E6D8C70DC6A53D85B2807DF1FF0481F8C3F
                0AFE2A7FC13A3F631D1FE1BFC4AF027C40D63E14FEC95FB2B7C3BF89DA77837C
                51A2788AF3C01E3DB0FD9DBE196A3A8783BC5F6FA34F3B787B53821D42CDE4B1
                BA11CB1F9BB595591C2FE99D7E267FC1083F671FD96BF645FF00826D7EC9BA47
                C1C1E11D1FC5FF001F7E08FC1AF8E9F17B5BB9D7F46BBF19F8FF00E2BFC52F87
                7E1CF11EB2FAADC0749A6874F9F567D274FD3D2255B5B6D3A2882BCEF772DC7E
                D9657D47E9400B455692EACED8289AE2DE0046104B2C5170BC610310303A600A
                846A5A6A80BFDA16002FCBB45D5B8C63000C06C2E318C0F4A00F987F673D76C3
                53F8A7FB7268B61A5A69BFF0867ED57E1BD02F1E28F4B862D52F754FD8C7F643
                F1D4BA9247A7471C80B2F8CA1859AF0C9333D948DBBC96B658FEADAF8DBF65D9
                6D27F8C3FF0005079ECA786E209BF6BFF04BACB6F2C7340C3FE180FF0061C54F
                29E22576EC58C8DA71CF1D457D93401F197C2FD360D3FF006E2FDAF278AF0DCB
                EB3F05BF63ED56E2DC0B111E9D2A6A5FB4CE88B69FE8B3CF2EE68B43827FF498
                AD1F178A162688433DCFD9B5F1459FC4EF86DE15FDB6BE3E695E26F881E07F0E
                6A4BFB307EC93FF12FD7BC55A0E8F7831F137F6D2B923ECBA84F13F114F6F290
                14E1278D8E15D377D75A5F88FC39AC69963ABE8BAF689AA68DA846D269DAA699
                A9E9F7DA6DEC313796EF657B6923C3708AC85098D9802B8E31401BB45654FACE
                8D6681AE754D32D63530461A7BEB48101B8648ED9373BA8064668D5547524019
                C8AB315E5948F0C30DD5A3C92C32CD0451CD0B34B05B34314F2C28872E91B4D6
                CACCA08532A03B772E402E57E6E7FC1281658FF644D5E29832C90FEDABFF0005
                3E8191B868BC8FF829A7ED770AC38FE1082354DBD8201C62BF47CB451AE59A34
                4185C92A8A07000CF000E8303DABE0DFF826DE84FE1BFD9C3C61A53EA163AAED
                FDB6FF00E0A6FA8457DA7CE9736F2DBEB5FF000528FDACF5AB54792355559A28
                AFE18A68D57092C32A02C101201F7B5145140057CE3FB625ADADEFEC8DFB5359
                5EB886CAEFF671F8DD6B7726E890456B3FC32F13433BEE995A340A8CC72EACA3
                6F2080457D1D5F1AFF00C145F53D7344FF00827BFEDDBAC786378F12691FB1AF
                ED3DA9F877CA172641AE587C11F1BDD691E58B29229B70B886DF0219627E9B19
                1B69001F86FF00B1A691E2A5F831E1AD03E197C7FD2B53FDA163FD9ABE0E4BFF
                000502FF008297F8BB41F0BDA7827F639F82D61F0B740F12E8FF00B2A7ECC9A7
                DDA45E1AD03C45A6E97F64BB6B4300D3B4758A7F15F8B62BFD56FF00C3FA46A5
                E8D25BFC25BDF843E07BAF137C24F13FC3BFF826F691E2BB3B0FD97BF6388B47
                D4F56FDA53FE0ACDF1EF58BF3E26D0BE23FC61F06F89C45ACF88742D6350D3DF
                C470E8FE2AB996EB5F2351F16F8FA5D2F46D3BC96FC87F833FF055BFF8250E89
                FB26780350F16F8CBC1DE11FD96FF65DF0F785B4DFD96BFE0953E0EBDB7B7F1C
                FC78F8BFE1CBCB18E2F8E1FB5F6A50C5369FA935D788C5FEB165A36B3AADCE99
                6D1F99E27F1126B7ACCBA45B787FEA0B6FF82AD7ECB1AF7C49F8677D69FF0005
                15FD96BC57FB717C63F0CF8827F889FB5978B3C47A6691FB297FC137FE09CD7F
                A2FF00C263F0E7F64AF047C51B7B1B2F1978AF56F3F4CD22C5AF21BDD475C97C
                38FADF8A258346D274DD10807E8C4D75F1DF55F8E7AEAE89A8FC36F17FFC14BB
                5AF015BFFC263E2DD5A0BEF16FECA1FF000475FD9B3C67A5D8EA6BE14D3E0F3E
                D6D7C6FE34D6E2D22DEE0C5E7699A9F8B6EEC62D4AF97C3FE0CD0B4AB1B6FC0F
                FF0082845DFC369B40F1441F003C15E28D5BF67A9FFE099BFF00057FD4F40FDB
                2FE25F883FB77E237EDF3F1A6F74FF00D8F97E3AFC71B99AF2182E7C49A2C32E
                91E07B2D2FC4EB15BD86A31C17D6FA05A59787F43D0249FE9AB9FF008290FF00
                C126E0F87BF1D7C2775FB54F83F43FD80BE0E788FC6DAE78C3E0AF867E236ADE
                26FDB4BFE0AC1F1E2EE6B693C59E3BF8C1AAC4F67ADDFF0083755D4ADA0D320B
                3B9D46DBFE1258ECCC9ADCBA2F83ED34FB1D4BF37FF6F6FDA8F49FDA82D3E32F
                C56D2BF6AAF851F15BC45A7FFC1257F6C09ECFF673FD9DBC47A46B9F01BF61AF
                0678BBE30FEC7DF0E3C2FF0003FC353E836F0C1E2FD72F3C397BAD43AE788664
                10DEDED8DB8D36DF4BD3742D044401FD04FC13BDF8E1AD6A9F03750D1BFE15E7
                8EBFE0A4FE38FD99BC1137C2BF074D797FE2BFD93FFE091BFB1F78A7C31A4699
                69F117C57636ADA7C5E2DF1B78A2CB4CB64924852C752F135FDAC9A569C745F0
                7787358BD17A11F04A7F831F10A2FF0084C7C713FF00C13E2D3C6B770FED27FB
                46AB2EB5FB49FF00C168FF006A4D77548BC2F37C25F85F3F8412DB51F1878475
                2D56D47861A3F0FC76D178844165E11F0CC3A6784747D41B51F32F84BE1FFD9D
                E1FD99647D0AE7E217873FE0999A4DCD8F85BE22F8AF46F1178AB5DFDA77FE0B
                37FB51EA1A368DE00B0F01F84FC45A7C969E22F15782A3BFD1A6F0E595A687A9
                59DAF890E8F1695609A4781B41BA5D67E994D2FE33BFC48F84BA75D780BE1F37
                FC1407C47E11D4352FD9E7E01DA4B6BADFECBBFF000472FD946FF4EB5F039F88
                FE2CD1FC3CB6BA678B7C632699A7FF006647751C293EB9ABC97FE1EF0E4BA278
                4749F13EA5401A32597C5DBAF8A9F0E2F8FC33F006A3FB7CEA1E0B71FB277ECA
                D7CF6BA97ECCFF00F0495FD9AB53B4BEF080F8C1F1760F87AF169DAC78A2FEC3
                4EFECC925D3E78EE757BCD365F0A7842E349F0F69BE2ED6DB83B7B7F03CBF0B3
                E37C1A0FC65F13F82FF628B2F13EA779FB767FC1412EA49D7F68BFF828D7C6BB
                990787B5CF841FB30EB5E12517365E1DB7BB1A77829352F0DD9CED209A0F0778
                0A0B6934EB9D4EDF3EE2CBE0A4BF0A7E316A1078D3E21CDFB01786FC657B6BFB
                54FED15A66B1A9EBDFB4FF00FC15F7F69AB9FB3F822E7E11FC3BD73C14D67A8E
                A9E10975796DFC33F66F0B1D36DF5ABB861F0AF862DB45F0AE977CDAAF557D0F
                C40B3F885F05ED35BF83BE19F147EDD7E20F0F0D5BF613FD8774DDD17ECBDFF0
                4B3F80F6961A8784BC3FF1CFF688D2BC0B38D0E5D634EB38DED2EB5B8A39E6BB
                D4749FF844BC05F60822D6B54BD00F8DF5A83E2627FC16E3FE081F378EF4BF05
                FC01F083F85BFE0A176BF003F605F0BE97E0DD2F5EFD957E02E93FB1D6B1A3F8
                135AF89D1F85279E387C4BE2D5B0BD8EEF4FD3DBFB1F4A5F87B6FA469D2EA971
                A46B77F7FF00D7C57F191E198BE134DFF07057FC12D34CF87D7FE3BF8DFE23F0
                A2FF00C14513E38FEDBFE33B3D323B5FDA53F691D2BF6628FC19F117C23E09D4
                34D48EDFFB0FE1CD95B685A245A26851C5E1FD1A7F135D699A7AB6A1A7F88E59
                BFB37A0028A28A00FC0EFF0083936292EFFE0987AC69573F11358F853E13D6FF
                0069DFD8F745F881E3CD0BC43FF08B5F785FC137FF00B44F8061D47C451EB2CC
                91D89D2A7FECBD552698F970CBA1433B63ECE31F9DFA67EC9DF00121D07F692D
                13E2E7FC1513E1DFEC4D6F656FF0D7F659F821A27EDCBFB5E45F1F7FE0A39F18
                7C5F15BB784759F85DE03D67C5F6779F0EFC29770E99A9DEE9285F45B8D55359
                D47C43A94BE11F0C6870BEABFA25FF000715EA1AA597EC51F02AD74AF00C3F16
                8EAFFF00050EFD8674DBBF83977AA69BA1E99F18608BE33E99AADAFC2DD5756D
                615ACF4DB6D6EEF4BD32C9AE2ED1A18BED092480A44C0D7D42C7E344FF001CA0
                F075BFC45F007C47FF0082936A5E03BED73E2AFC68FEC75D4FF66EFF00824E7E
                CCDE33961BAD4343F84DE14D5E16B0BFF14EB30DB5ADA6969AEA5B6B1E2E3E19
                935AD79AC3C31E1DB0D26D403F396EBFE09B9AC5ABEA1F00E4F8B9FB59F88FF6
                DBF8E622F89D77E01D3FFE0A11FB676B5FB377FC12EFE02EAB63269507897E2B
                78FAC7C6706A3F18B5961A7F8826B2B7D467B43E2AD76DEEE2D3EDBC31E1BD33
                55BEB2BF67FB15FEC8BAAD8E8DF176D3E377EDD31FEC39F01F50B4F0B6AFF1F6
                FBF6E6FDAF7C45F137FE0A57F1A2F2C1BC15A2FC2CFD9B7C0DE19F19C76375E1
                6B9D6EEE38D75BF0E699697DE21D72DA2D3BC3C6CB47D3EF750D53E9E59BE036
                B3F097C65ABE9D73E3CD17FE099B2F8CE1D3BC79E2FB73E28F167ED41FF05B1F
                DA67C68345F0CE9DA5786F5F76B7D77E24F8335BBBB5B0D1A19B4DB8860F1860
                E9D61FD8FE04D15FFB6FD92D97E347FC2C0F86BA24FE11F871AB7FC1407C45E1
                DB6D47E05FC01B5116B3FB35FF00C120BF661D7748D53C1D69F11FC5BA2F86FE
                CBA778B7C4F1E9BA66A9A4A5F410D85E6BFA95C5CF86741B9D13C2B61AEEA510
                07E6AFC5AFF8275F83BC2FE1AF891A1C3E0AFDA0FC7FFB6C7C73F006B7F103E0
                47EC649FF050CFDB6B52F869FB117C26D134BBDB63F17FF6A7F8C1A6F8FAFF00
                51D6EFAE65F9AEE385EE2CB55D66C6DFC39E18B3BEB7D2F5DF10CFFD167FC127
                F1FF000EB4FF00826AE0003FE1807F638C0000007FC33AFC39C00070001D857E
                3B7C6BBBF8629FB277ED8BAC7817E39789BE1CFEC73E0FF0078F750FDACFFE0A
                05E24F15DE695F187FE0A21FB48699E11D47C0DA67C33F867F13ADC43756FE0E
                B0D621D2746BBD43C226CED6E6E7C8F0678361B0D3EDB5C63FB13FF049F007FC
                12D3FE09AA00C01FB00FEC7000C01803F676F873818000181C6001F85007DFD5
                FC127EC7BFB19FECCBFB4BFECBB77F15BE22E93F16FF0066DF87DF087F683FDA
                7BC4DFB72FEDDBABFED15FB457C35B7F1BDB68BFB5C7C58BED23F677F809F0D7
                41F135A68FE36BBD5B489FC01A66A1E25FEC1B9B3B46F16DFE9BA2C5ACF8B6FE
                FDF42FEF6EBF8EFF00F8275B6ADE1EFD92BF64EBCF88379A3FED4DFB43F8C7C6
                FF0018FC47FB017EC23E1EBDD4742F85FE0CD62C7F693F8BBAC7883F6CEFDA79
                6596F1F56B8D1F58F126B1AD5F78CB53B56B2D192CF4BB2F0C69971E29BB865D
                5003959FFE0977FB2EDAF8923F89BE25FD9D7F6803AF7ED07A34FE06FD82BFE0
                9B92FEDABFB5FE8DF15BC57A46882DAF752FDA5BF6B6F883AD78F6F6FBE0E585
                A58A69F7377A6D9B4563E1AD2B50B2D3EFA1F11F8B757D374AB4C76FF824A7EC
                649E14F117C23BEF1DF8FBFB17F679F126ABE36FF828D7FC143B54FDA4BF68FF
                000F7C29F8389A7DCC9E2BD7FF00643FD977C35ADF8D6EB4FD6759B3B7BDD334
                59F52D76D3C46FE1FD1D586AB75AD78A756B4B7B5FD38834C834FD73E2FF0085
                B4AFDA2EF62D43C1B645FF00E0AA5FF0560D4EEF4CF00DEE8B0785AEDB5C5FD8
                E7F664D52492E34FF84D3DBC7AD4F69730787AE047E0CD39D0B5C6A1E36D692F
                ACB346A3E1FD3B44F805A8DC7C01BBB5D02F35C8742FF82507FC130B50B5B8F0
                C6AFAFEBBA0C6BE225FDB5BF6B9B1BC9EF2E3C3ED62EDA9F89A5B8F13C374FE1
                5B2BDB5BCBB82FFE21788ACF4FB200FCE5FF00875CFEC136FE24F0EFC7FF0011
                7EC8BF1274FF000CFC61B5BDF875FF0004FCFF00827759FC7CFDA834EF8DFF00
                B4AEA57705BEA1FF000BEBF69DD47C6FE32B9B9F841A3DBD958C7A9FF673AE9B
                6DE1AD06FE59FC4A357D7B53D37C3FA47C17FF000533FF008261FECCBFB37FEC
                13FB59E87F077E0C687F19FF006B3F83DA1E93F177F6B3FDA3EC7E2C7C79B7F8
                1BFB20C9E32F1778225D2BF66EF815A1F8A35ED59FC7BADC9A7DCA5BDB697AE3
                5FDEDA68FE66B7E22BBD365D5FC27A6EA1FD1A5AD8EA7A6F897E2BE93A07C6FB
                0D47E395AF87F5BFF8794FFC1546FECEC7C3DE06FD98BE1D787EEAEBC53AA7EC
                B3FB2C5EF8A5EF744F01EA7A6437E96D6DA1DA4B7707866CF4D7F1278B65D5FC
                537BA6AEBDF95DFF000594B4F015D7FC12A3E32EAFAC5CEB7FB33FECC5A8EA1E
                0FF0F7EC13FB2E47A9788342F887FB54F8AB51F8AFE05F14FC40FDAD3F68BB19
                A49BC4FE309755B4BCF12EAD63A478967324515FCFE24F169BDD7BC41A45AF85
                803FB4AD363BB8B4EB08AFE4F36FE3B2B58EF65F3619FCCBB48235B893CFB7B6
                B38E6DCE1CEF8ED2D54E72B0C00844BB4514005145140057E29FFC1C58C13FE0
                8AFF00B7C1F3E4B51FF0AC7C24824844DB9B7FC5CF87482DC8B6646D92E442D9
                2576CCDBD5D37AB7ED657E217FC1C75A8C7A4FFC118BF6CCBD9D2F25B1487F67
                FB7D52D34F4792EB51D12F7F6A5F82163ADE911DBC52426ED6F2CEE2F6D5ADCC
                B1ACA976D1B15576A00FC6DD2FFE095DFF0004BDD53E119D22DB46D35FF64BFD
                99B58FED5FDB1BFE0A1BE2EF10FC4A9BC63FB487C57D0B5144D77E04FECA9A56
                8FAACF693A1BF36BE1ABED7F42B3D5A5813ECDE12F0C7F6BF8865D4B52F0E763
                A97FC12E7F626D3FC7563E30BBFF00827C784A6FDA07F688F0AEA7A0FEC57FF0
                4F1BED7FC7DA75B7C33F875697D6DFDBDFB547EDD1E29D3B5ABB93C22F009B47
                6BDB78EEE4B6D221FB2F87F47835EF13EA575237E84431F892CB54F833ACEA5F
                B3D68F75FB435FE870C5FF0004C9FF0082683DB58E91F087F627F847E16874BD
                07C39FB4E7ED47A3783FED5A2F81758D2227B496FF005C83ED2FA1C7A85BF837
                C1A2FB59BCD5AEB5E67F64E87058FC5FD22C7F680BFD27E18785EE6E2FFF00E0
                AB5FF053AD52FD7C1FE30F8B5AEF84DB52B39BF644FD9A7C5FA3B07F00D8E8F7
                9AA6A1A4DD1F0BC91A7846D2FBFB0B4296E3C65AD6B1A8F87C03F34EF3FE092F
                FB13EA5E0BF147C19F07F8E2F20F037C04D7F51F893FB7B7FC1486F3E2B7C53F
                01FC2CF82D7B6BBBC4DAFF00ECDDFB1AFC3CF0F788EDFC19A66A3656AD269F3C
                93DB6B969E0FD2B518A2BF9BC43E26BA860B1FA2FF00E0887E17F877F0D3FE0A
                91FF00051FF06FC06F82DF117F678FD9DBC55FB31FEC5DE3FF0083DF0FFE2678
                A3C77ADF8BBC67E0E82EFE2A685A37C64F11E8BE3ED5B56D53C132EBF24BADDE
                DA68FAC4B69A85BE9FAA5935DD96937775A85ADBFBFF0089F54D0E2F0FFC1FF1
                27C45FD99AFB4DF8711496DE10FF008255FF00C120F45D134ED075AF89BE23F0
                F2E8DAE68DFB46FED43E06B48A5D2BC0CBA2CD05A6AF1DBEBF15D69BE06D3634
                D5B51173E2FD4ECEC74ACBFF008240E85F112CFF00E0AB3FF05A39FE3B7C63F0
                BFC7AF8EFA4F813FE09A765E3EF12F84F4DB5B6F077C29F10F89FE19FC7CF10F
                8BFE02FC2AFDDC771A7786340BB834CB4B78EE23B7BCB95D26DAEB57497566BF
                95C03FA4FAFE683FE0E0AF0CF80FC61F19BFE0917E16F8A9F033C69FB4E7C3BD
                7FF6A4F8D9A3EA1FB3C7816F2E74FD5FE2C78BAF3F671F16A7C35F0DADFADE69
                F6BA4C7FDB69A4BCD7FA85F58D9DA5A25F5C5EDCDA58C37F227F4BF5FCF0FF00
                C1632CFE28EA9FB7C7FC116747F84DF17BC3BF0235DBDF887FB77BEAFF00163C
                4FA7D86A9A77C3DF03DA7EC957D27C4CF19E9567AD3AE991EB761E153E393A4D
                CEAD15CD85B6A17565717B05D59C17704E01F9F3A17FC11B3F63DB1D5BC73F03
                BC3FFB3AFECEBE20FDB0FC571D97C53FDA67E256A77DE3DF13FEC9FF00F04C2F
                85DAEF877C9F0F7817C05A76B57B6B67F137C5506976D7575A769DAEBC175A9D
                C4B3F8A3C429A1F87E4D0349B9E56CBFE096FF00F048E9BC29F0DFE2AAFEC89A
                369FFB11FC13D76CBC01F07B536D275CF117ED69FF000562F8F96D049A2F8597
                C0F6CB35B5FEADE09BDBF8B57BEB37D3DB4DFF00849A5D265D518687E04D1CCD
                E22FD1637DF00F57F831A0DFEADE08F1E587FC138F41F1A59E91FB3C7ECFFA25
                96B3E2FF008FFF00F057DF8F3A9A0BC87C7DE3AD0B562358F8A9E11D62FE09EF
                2D6D3C437890F8A0E9D77E29F15CFA7F8474BB26D43A7B6B7F8D43E2CDA69F35
                A782B54FF829978DBC036D7D6D05B476FE2CFD983FE08E5FB26788DAFB488AE7
                46FB6456FA2EB3E2CB9D374DBEB606DA15D47C5FAC5B2A4ABA6F81B412DA6007
                F2A5FB72FEC4B6DF02BE31FEDBDF05747F0BFC01FD9EEE3E397EC51FB027C44F
                147ECF1F072D2E6F3E1DFECD1AC78EFF00E0AABF02FE1CF853C07E26D734CBE8
                A6F893AD69FA31D2754D535D274DFB4C9E2BBD5D312CF4D6D29DFF005B34AFF8
                24F7FC12964F859A74FA57856DA1FD8D7F65ED5B4DB5FDA0FF006F5BEF19FC46
                BAF8B7FB6A7C62F0D78871A87C01FD97746F0C5FB47FD8D73E231A569975AD78
                5619E6BCBD8A0F09F84E1BFBD9355D574CFCE1FDB163FD941BF690FDB19BE19F
                837C71F167E09D9FC0CFF825C68FE39F8AFE31F096ADE39F1EFEDA3145FF0005
                44F05A7C6CF8B7A46BCD17F687C6BB5F175DE992E8E97D69682D35893C07651E
                871B68B65E1DDFFD3817F1CD878C7E17F89B5FF819E1B9FF006B5F10F8752C3F
                E09C5FF04E79753D2E0F83BFB0A7C18F0EDB587858FED1BF1FECBC0F0BE8DE14
                D52CA3BE84EABAED8437CFA6C37165E08F05C9797975ACDE6BE01F0D5CFF00C1
                2F3F64AD235FB2D6B5EFD81FC13E21FDA23E3D787EE343FD91FF00E09E17FF00
                10BC743C19F03BE1558DFDE8D6BF68DFDB47C5BA56B3AA410DF21D72DA4D6B52
                85B50B5D3D9748F0AF86935DD6A79F51D67CB2EFFE08E7FF0004DCD63C23E3EF
                83C3C05F0C2DBC03F05FC5BAA78F7FE0A27FF0518BED7FC55E0BF0CF807C55A5
                6A13789FC45FB31FEC8BA5DC6A777A4F856EB4C6FECAD1EF0ACB796BE16D26DA
                2B4B91AE78A6FD1F4CFD2BB7B6F0E2787FE33681A0FC78D76C7E11780AEEF758
                FF0082A4FF00C14C24D4B51F0F7C44F8DDE2FF000BD96ACBAD7ECBBFB35F88FC
                3CB737DE14B3D12EAF86993C3E13BA483C276BA845E1AF0D1BDF15EA5AF5DF87
                AACDADE9168FFB3BF8B35EFD9AE4B0B29B5436DFF04ADFF825569DA6E95E09D5
                ADF59F0D3DCEB13FED91FB50F87D6092CFE1BCFA6437FA66ABE7EB1677F0F816
                1D52C6775BCF1CF896DAC2C403F3A756FF00824CFF00C13A6EBC63E1BF8C1AB7
                FC13E2D2CD3E29786F5CF873FB04FF00C13E22F18FC63F0B7C51F8F063B5D346
                B3FB4A7ED5F2EBDAB4977F06F48B2B36D1AEA68AFADE13E1DD375C7B8D7C6B3E
                2AF10E95A0E99C3FECE5FB107EC89FB0EFFC1603FE0961F0E7E09781743D6BF6
                8B93E337EDABA87ED61F193E13E99E2BD2FF0067AF87BE2CD7BF610F8CFAE785
                FF00649F86B6BAFEABA9269ADE1ED3E6B5D4CE99713DDEAD1DBDFD96A3AB4D1C
                BE23B5B7B7FD5F4D3B5C86F7E31F83E2F8D9A22FC53B3D1DAF7FE0AA1FF0539F
                3A1F07F863E00F8234CD357C4BABFEC91FB2A6B3AADCBAFC3CBDB0D39C4505A5
                B5D341E10B1D41FC49AD3EA3E2CD72CC6A5F3D7876DF56B9FF008290FF00C115
                F52F873F0AFC3DFB387EC5D6DAAFEDDFA67ECC5F042FBC117DE1FF008B1E3286
                3FD957C617DAE7ED29F11E2D7561BFF073F8963D52292CF46D4EDE4D6E48B55B
                AD575EB84D435FB8D3F4800FEA2E8A28A002BFCF87FE0969F187FE0AB9E02F82
                5FF051CB3FD88FFE0981F0EBF6B6F067C51FDB6FF6B5B6F89BFB45F8A3E3CFC3
                3F86BF11758F142DADAD9DEF82356F04F88F58D3BC43E321A441ADFDBED96067
                479FC67A8416C45C4972C7FD07ABF95AFF008377AED2E3FE08BBFB50DDD8BBAE
                B4FF001F3F6EC9F55D42DF316A579AEC96BE745A85D5E868E4BAB9FB3BE96A27
                794305B78977A08936007E447FC12F3FE09EBFB21EBFFB1A7EC5FF001EFF0069
                1FD8D3E0FF00C7FF008EFF001A7E16F8DBC1BFB1CFEC7BF09B4CFECBF1F7C7BD
                42D359BAD37E22FED45FB52FC5ED6A6B28F45B5D2E116462B8B96B4D23C2DA7C
                714F6A7C4FE25F10E856763F704BFF00045BFD89A697E237ECEBA67C2CF825A9
                FC7096DDFE25FEDCBFB5858EB9E32D27F665FF0082757C3BB8D2CDFD9FC20F81
                5A26BFAD2C7ABF8BBFB0ACA47B35F125D3CB69079FE34F13FD8ADEFBC33E1ED6
                737FE08D36DE12D53FE09CDF087C29FB317C4DD5BE10DADCFC09D035DFF82907
                FC14BFC69AF697777DF003C1DA459DDEAB17EC87FB3878D7C6318D2BC2DADE9D
                A7DD4D3C82D231A57822DB59B8D66F21D47C4FE22B7693F447CCF82EBF0DBE14
                6A6BF063C45E1FFD872DBC6773A57EC4DFB0FE9FA5DF4BF1B3FE0A7FF1F35B8A
                E756B3F8E5F1C3C3DE367FED2D6BC34EF06B1E28823F1A4B235DC76D73E3CF1A
                4F6B6F61A5436A01F046A1FF0004C0FF00825778961F855F1FE7FD87E1B4FD97
                FC3D787C0DFB16FC02D2A3F186A1FB50FF00C14D7E2CEA7A34F6DA178FFC423C
                55AAC7A868DE05365A7DEEAFA65A5FCFA647756697DE2FF135CE91E1FB0B2827
                24FF00823AFEC7567E25F889F03F40FD8FBF656F127EDB1F16349F0FF8DFE397
                88AC3C33ADEABFB177FC12ABE0A5CE917B1787D6D65D5A6B35F895E319AC63BF
                BDB1D335092CAFFC49A8799ADDFDBF84FC2B63696B17E95B58FC68BCF8ADE3BF
                07F873C65E06D6FF00E0A0FE36F04C777FB48FED389145ADFECFFF00F049BFD9
                AB5F8ED6FEC3E0CFC13875C8E2B6D4BC4F369F66B7965A6DCA6993F882FB4A3E
                2FF14A69BA258F86F463E537373FB3F789BE0C687791685E39F0AFFC12D7C29F
                10AC2C3C1FE11B08B55F187ED07FF05AAFDA475F9869FA5AEABA6EB2575FF8C3
                E11D6751D2A69C9D5E79A4F1E3D89D475096C3C15A1BC9E2200E3FFE0DA2F09F
                ECDBF0DAF3FE0A95F0BBF63BD7EF3C53FB30F80BF6C4F05E8BF08FC4D79AB5E6
                BBFF000956976BF017C0BA5EB1E2EB7D6AFA289B5B8755D4349D46FA2BFB644B
                2B986EE0974F8E2B27B4DDFD47D7E0FF00FC10A6D7E233D97FC15335EF8CBF0A
                BC3FF067E2BEBBFF000554F8B175E23F86FA06A5A678860F0168373FB327EC99
                ADF813C03FF0956936D6B6DE224D1F4AD7AC60FB45A44968F34F772DA2886E10
                B7EF05007F1D1FB747ECA3FB2DFED07FF057DFDB57E227EDA1A37C3BF107ECF3
                FB3EFC0AFF00827AF89757F0649E019FC5FF00B407C68F889E24BAFDA0EDFE13
                FECF1F03F50B69D6EB4DB7F166ABE1E51AA693A25B3EABAE49E1BD074A8A6B4D
                3AEB5DF321F15FFC1277F64A93E26D8788BE20FF00C13B7F664D77F6CCFDA13C
                3BA527ECBDFF0004E4F87FE26F11786BF67EFD92FE14E9B74F71E29FDA1BF6B2
                D43E1ECD6FA65ECD04F75696FAEEA7A568E9A7DF5E681A5F863C371EB77F753E
                AB7BED77B74FA7FF00C177BFE0A416BF06FE065AFC52FDB73C47F0DFF621D1FE
                02FC4BF883E1FD6353F81FFB2FFC2ED4BE08F892C7E2D7C76F1E6A70B470593E
                9F25B699656BA5D8CB6FAB6B571AFC5A3D85CE9963A978A6F74EF5FD024F80F2
                7C2DF8E3A77C31F8CDAF787FF652F0DEB73DDFFC14B7FE0A8BE25D635BB5F8BD
                FB617C47F0D5EC5A5789BE01FC04F1AE9822BEBCB5BDB9B89B49B8D5FC1C4693
                A3DBEBD0F857C05693EA7A9DD5CF85403F32EFFF00E08A7FF049B87C0DAA785A
                FF00C05E1BB6FD9E3F64DF1526B9FB73FF00C1457C41AD78CF4BBBF8C5F12343
                F13E9D7FE23FD953F657F0EF85B596D36C218B535B4F09EA777A4D95F4BA3C68
                3C29A41D57C557BAC5FE87E871FF00C1287F60FD0BC61E1CF8C5E20FF8273787
                34BF885F1AFC35AA781BF600FF00826159F8D7C75E19F1FEA3E1D9A5D12F3C4F
                FB48FEDA7E281AD6A0FE045B18BFB3AEAFE3532E9BE14D3B56B3D3A68BC4BE2E
                D574BB58BF4AA4D4F5283C49F027C49AE7ECF5E1FB3F8917364D6BFF0004AFFF
                00825A476D6BE0DD0FE05F86B4958ECF50FDB1BF6BBD2F47B5B9B1F86D7FA45A
                DEDAC92DD269D791F842D3538F44D1975DF17789658EE3374AB5B3B4B9FDA13C
                25E14F8E765178A6C8DEDE7FC1593FE0ACBA8349E0FB2F0241A2DAC575AD7EC9
                BFB266BD7EF7769E0EBDD1ECA49349834FD2F5492D3C036B29BDBB6D63C69A9C
                AD3007E656A5FF000463FF00827ADCF843C75F0266F09FC2D874BF849AC6B3F1
                23FE0A49FF0005169B58F12F873E167ECF735B4BFF00091EBBFB297EC9FA2EA7
                AF5C69DA46BBA7DB5A58584B2EAA7561E15D2668AEF58975BF126B1676A3F5DB
                FE0DD5B6F869A6FEC3FF0018F40F827A16BDE15F827E1AFF008280FEDC7A0FC1
                8F0A789ECFC53A67887C2BF0A2CBE37EB4FE00F0E6B7A478DD9B58D1EF2CB4C9
                F4E827B5D531771CD0CA2EB371E796F2DBFD43C1DA6683FB3CEBF2FECF33587C
                1ED1AE4E8FFF0004A7FF008258787EC61F0F78DBE3FF008E34E8A1BAD3BF6B6F
                DA5B44D6B31783B4ED22DB548FC4291F89AD2E97C256BA8CBE26F10C977E2FD4
                F49D2BC3BF51FF00C107A1F18C7FB096BD2FC47B4F0A59FC4BBBFDB4BFE0A057
                1F1263F030BA6F081F1EAFED99F1A6DBC53FF08CCF7F1417375A747776F3C36B
                25D431CA6DADADC3AC6576A807ECD5145140057CE1FB62EAFE2BF0F7EC8BFB53
                EBDE03D462D1FC71A1FECE1F1C357F066AD36976BAD41A578AF4CF863E27BCF0
                E6A32E8B78560D5920BC82CE536B29549444636215CD7D1F5F3C7ED756D1DDFE
                C9FF00B4F59C86448AEBF678F8D36D21827B8B499639BE1B78962630DCD93C53
                5B300C71243246EA4028C8554800FE24BE177ECE3F1CFE207C05F833FB57F86B
                FE0A27FB62789BE0DF86F41F0D58FF00C1403E0FF83BF672F825E13FDAABF640
                F18F88FC0DA0EBDA6FC4CB6F830FE18BA9FC6FE10B4B6BF4BDBA1656D3EA1368
                3756BAEE8F2F89ADE2BBB78BB893FE09C1FB4FEB5F117C55F0BB48FF0082A168
                1E21F127C69F0FB7C46FF82697C72F89FF00B277EC9BF14BE037ED77E0993C1D
                A46BB71F0E75CF8C171A0EAF7BE1AF1768CD6BAAACBA6C51CE973A6DD5AEBFA2
                DAEA413C4561A47E8B7ECCE3E35BF823F61C3E21F15FC2EF823FF05123FB2FFC
                2893F656FDA3F42865FF008652FF0082957C03D2BE1CF873C597BFB2C7C72834
                A48E7B1D7B45B4BFB82B6C125BED2E477F167845F52B2BAF176876BD44D0FC33
                B7F85BF1CEEB56F82DE3DF0F7EC5175F1317FE1B9FF638D3FF00B4746F8F5FF0
                4AAFDA77486F0F78AFFE1A93F660BCF0518EEAEFC1573733681E3E6B9F051896
                DD2EFF00E132F0E4570DA878A74B8C03F23ECFFE09FF00FB46EADE0ED23E2D78
                2FF6B9F8AB25B7C14F1C6A3E02FF008283FECE5FF0C1BFB18CDFB5D7EC9725C6
                9825B0F1DF85BE1CF85F40B9B6F8D3E1E48B66AEB3680D2CBAC681769A8F87D3
                5AB882E74C8BE74FF828A7ECDDF1C7F67AFD927F68FF001578FBFE0A55E29F89
                DFB36FC7BF81B67E22FD90BE357C34FD9C7F67FD1BE05FED3DA05C9D17C41E25
                FD98FE31F887C03A45BEA5F08BC573AE9316A3A4CCDAA0D3B5A8B45912DFCAD5
                74FB9D247F49B7165F13D3E2E7C21D2357F8DFE17F09FEDA165E0ABCB7FD833F
                6FBB3B2D16FBF677FF008296FC0F1A7DBF8907ECEDFB50685E1478ECEF7C4115
                B3ADEC963A74F6CFBE6FF84BFC15360F89F43D33F367FE0A643C59FF000EDEFF
                0082936AFF0003BE1B691F0DF4DBCF0D6A365FF0508FF826DFC52D4F4D32FECD
                5F1AB57D6F41D72C3F6BDFD95B5EB6B57D3F54D1B5CBA834CF11BAD85ADB691E
                248257D76C1FC39E26B0F1159EA601F7AFC30BDF8BF7BE36FD9FB5293C17F0DF
                C67FB7DF88FE08F85BFE1957F665D30C5AF7ECC1FF000494FD94F5ED074FF0D4
                FF001CBE2C5DE86D6506B9E2CD5B4D83EC525C69DFD9B7BAD4D149E14F0C1D33
                C3DA7789B596A73699F08A2F829F1534FBEF899E33D63F6233E3E49BF6C8FDAF
                5D351D5BF691FF0082B47ED2973E2097C2F7BFB397C028BC1460BDD43C233EA7
                6DA678490F86098AEA0B38BC19E1586D34AB0D5F50AF18F83D71F07F54FD932E
                20D3BE2DF8E7C1BFF04FCD121F085C7EDC3FB684F71ADEB5FB47FF00C152BF68
                AB8D27C3FE129FF671F80DE25F0DC6353D63C216FA82D8F8266BDF0C25CC9789
                E1E87C0FE1482CEC2D354BFAFAA5EE3E299F899F06E69BE0E7826DBF6B8F1378
                1AE6CBFE09EBFB0B7F63E9F37C0EFF0082667C06B1B28FC3BA87ED49FB4CA785
                9D74FD37C4E960F6BA5BBE8F1C4F13CADE07F08CB3C575E30D735000D58E7F8A
                737C47F842AFF093E1D0FDB5A5F064D27EC53FB13C5244FF00B3F7FC12F3F67E
                BCD32E7C1EDF1FBF6908BC09709A7DE788DF4D5FEC86934A48DA69E393C1FE0C
                920B04F187882F3CD2C97C309F0DBF688B7D07E3AEA9E19FD94348F10EABA8FF
                00C14A7FE0A75E2259748F8D3FB707C4DD35EE740F177ECF9FB255C7849A29BC
                31A1696E4782ADF54F0E1B84D2D6F61F0B781E1BFD6E3D5357D3DF33FC345F86
                5F1D34D9FE3978921FD8FF00C2DE2E9A5FF828EFFC140F50B8BF83E357FC1427
                E3CDB5E41E14D4FF0065CFD9C9BC1686EF4CF0E43A84D69E11921F07B32DB79B
                67E03F065B497526B77DA6F49AFDC5E68BE31FD9FF00C45E3FF80DA2EADFB404
                BA7DA47FF04A5FF824EE80F07867C01FB30F857C2B6A749B3FDA6FF6A1B7F0B4
                575A1F83B56D1ECAFEC1EF75B96C6F2CBC230592683E124D67C437D7B71AC807
                C5D059FC5FB7FF0082DBFF00C107EF3C5FF0FBC0DFB337C1697E1AFF00C143BC
                39FB2E7EC5DE18F0F699A3F8BBE047C11F0C7ECC3716FA0F887E305C6973F936
                5E25F172B58CF3786ACE06B0D0EDFC0B6366B2DF6A87C41715FD83D7F1722CFC
                0DA57FC1C55FF0497D2E2F1DF8A7F684FDA2F4DBCFF8287E91FB5BFED4D2F85E
                E749F857E2AF8AA9FB206B97D69FB37FC1CBE135C58687A5FC2EB378606F0869
                97377FD89FF0B26DDB52BABFD7B59F124D27F68D40051451401F813FF071924E
                3F628F80D736DE3D1F0A65D3FF00E0A23FB0F5DC7F143CBD09D7E1BBAFC5FB4B
                78BC7A57C4E8FA6634679E2D47FE2631C96BFF0012C0275688C82BC86CADFE00
                43F016D74FD3FC29E3CF05FF00C132A0F17D8DBDB68B73A16A5E23FDA8BFE0B4
                1FB4578BA5B7FB1799A35FAC5ABFC52F08F8B1B4AFB44F25FC315C78DD37C92F
                F61F823439DBC4BF57FF00C17CFC01F0DFC6FF00F04F4D6751F8A1F1C3E0BFC0
                0F0EFC30F8EDFB3A7C59B4F18FED05E0EF12F8FF00E126B1AE7823E2BF876E74
                BF01F8C7C1DE0A8AE358D7ACF593732DA4B6DA6DA5D48F13CCB2AC16A6EEE2D7
                F9BA8FFE0ADDF12AF7E32F8DFF00694BBFF8295FFC10F7C73F142D3C017FF0DF
                F6689FC6FA07FC1427C11E0FFD9B740D56DE1B6F182F80FE0E4DE0FBB1A2EA5A
                DDCE9FA5C97BE20D52EB5ABEB9B7F0FD95942F6BA5BBD9B007EF04A7E345D7C7
                0F86536BBE0BF87DE28FF828BF883E1F16F809FB3E6952FF00C24BFB31FF00C1
                23BF66FF001445178735BF8A7F11350D292D2DFC61E2BBAB5B1BDD27FB42CEDF
                4BBAF125D68AFE19F0EFF62786EC3C49AC279BC3FF000ABDFE19FC67D0F4EF8A
                3F127C3DFB0AE93E39BAD63F6DDFDBC350937FC78FF829FF00ED05AD6B1A7F83
                AF3E007C00D47C0D6906A1ABF8727BB4D1BC132EA3E0CB2885CAD8D8F80FC0F1
                411DA6A17965FCF41FF82877C4DD1FF67CD6FE02D87FC14ABFE08A9630FC5BF8
                83A0F8E3F6ABF8B76BF12BFE0A5BA8FC72FDABA6BD8F4EB2F883A1FC4AF887A3
                7C36B6BEF09E9FADDAD95A68ED0F858688965A359C3A5695FF0008DE9D0986BD
                222FF82BE78B24F8ABF0E7E254DFB7C7FC1086D341F80DE0883C13FB33FC14B4
                F863FF0005355F82BFB3E4F6DA6C9E187F889E0BF06699E06D39751F124FA1DD
                CFA1437B7B2B47A569F04967A547649ABEB4D7801FB45FB54DD7899FE1E5D6B9
                F157E03E99AE7C7A1FB39FC5CBCFF827DFFC134FC1775A5695F0F7F62FF827A2
                7C39BFF0AEABFB54FED2FAAD8C4FA0F86FC45A4699751E991DF416F25AE8D26A
                51784FC229AB6A37DACEAB7BFB03FF00049F007FC12D3FE09AA00000FD807F63
                8000E800FD9DBE1C800703803D87E15FC505EFFC142758F107ECFDFB497C361F
                F0596FF82607843E2E7ED5166F17ED03FB52783FF677FF0082867897E3BF8CF4
                DBD5BDD121F0747E37F11684DA2FC38D074FD23539F44D32C742F0B69F6FA659
                DC5D369D6DA6DDCB757B27EFFF00EC7BFF0005E1FF008234FECBDFB25FECA1FB
                31F893F6F1D0BC49E26F80BFB36FC10F825A96BDA17ECF3FB57C7A3F8A354F84
                BF0B7C2DE07D575DF0FC137818C86D2E64D065B88D5B2C91CE81F6906803FA5E
                AFE2FF00FE0941A9786B4FFD8275B9FE15CBAAFECB3F0A20D7BE2FEAFF00F051
                FF00F828F78F6FB52F0E78BB4FD03C21F1A3E27269DFB34FECADAB788924BB96
                EA2D2EEB4E8BFB734929A3F86DBC79A849A443AA78BB56BE4D33F5BE2FF83947
                FE08AF35B6A1776DFB645E5D59E906E86AB7567FB337ED79756BA60B1B75B8BA
                6BF9EDBC00C964B1A3479690A2E644504B3A29FC9FFF008263F889AFBF61FF00
                D8FF00C7FF001475AD3FF6823ABF8FFE3A6B7FF04C8FF82737C3B36DA5587C5E
                F19E8BFB457C60D72C3F69AFDA12EF5EB29EF921F0D5DEB735E8BFD4E14D03C2
                165E15B1D64DBEABE27BBD1E1D3803F42B57B3D2346D17F671B9D43E046ADA7F
                C2FB0D4E3B5FF82617FC12AF41D3DBC2DE21F8B5E36D020835FB0FDA9BF6C896
                EE2BC5F0659E8926A31789E44F11C1341E156D5EDF58D723D6FC75A8685A6695
                B0B63E22B3F11FC71587E3AE8B67F1B6DF428E1FF829E7FC14A6DADA3F0FF833
                F65BF86BE1BD1A7F1845FB20FEC7D26BA6E6CFC29AAE996BADD9CA919379FD89
                06A53788BC40DA9F89B54D1EDA4B1A4E91E36B2F88BF167C3FE1FF008D5E1FD5
                7F6961E1907FE0A51FF052ED46C2D746F86FFB207C2BD06DA2F1CD8FECA3FB2E
                E99E27965D2BC2B7D6F61AA4D710D8B5CBC3A1C17171E30F163EA9ADDFE8F61A
                BF23A74FF0F749F867F07FC4173F06FC61A3FEC9DE0EF155B787FF00E09BFF00
                F04F7B2B1B9D23E317EDE5F1A74AB69FC47A5FED15F1FB48F13B1BDD46CA5D42
                2D63C5D691F8AD4C3671413FC40F17B3EA49A347A08068DECFE0C1F0DBE0FEAB
                E36F833E29F0EFEC95A478C346D1FF00E09E5FF04E6D2B4D7B5F8D5FB71FC56D
                2D93C61E16F8F3FB47E91AE4EB35B594DA90BFF18268DE2F68E3D385B0F19F8F
                268B594B7D3BC3BF9B7FF05AA9FC7161FB10FEDED71ACE8FE1FF00DA47F6C8BA
                F855F0CE7FDAEFE2C683AC6A567F023F608F82BFF0B73E1B78D7C13FB297C0EB
                9BAB36B8D5F58D4EEE0D26FE7B28EDF4FD4F5586D8F8A7C51268B691F80F4993
                F56ADB4FF8A63E2EF8EB45D1FE22F84BC4BFB7B7897C23689FB60FED6E2CE3D5
                3E02FF00C1307F67AD4B4EB5F19C3F03BE035A78C1174F4D72EAD61D36EEC74C
                BE486E3559AD2DFC6DE338134DB1F0C68B77F91DFF00058483C1B75FF047BFDA
                32E7C0DE32D5FF00675FD86347B3D16C7F667D3351D6EFA4F8CBFF00052EF8FD
                E23F1F683E22D77E3F7C4ED7B576935CF16785EFDADBC4BAF582DD3497BE2596
                CEE7C5BA9CB068B61A025F007F6BF4514500145145007C21FF000517FF008286
                7C13FF0082637ECE53FED39F1F3C3BF133C51E0283C6DE16F87EBA3FC25D13C2
                FAF78BA6D77C5C350FEC968AC7C5FACE836096EBFD993892593518F6E530AF93
                B7F980FF0082EEFF00C1603C4DF143FE09D5F17BF667F1BFFC13DFF6C8FD997C
                53FB4469FF0009B5CF843F12FE3347F0520F855AA68FF0FF00E387C1CF1B788F
                538FC4BE0EF15EA736A9750C91F86E1834CD26D7519E6835FF00B738B4B5B3B8
                61FB09FF00070B6A9ABE85FB2DFEC8FAD787BC0B27C50D7B47FF0082A1FEC15A
                9E89F0CE0D4348D225F889AB69FF0015DAEB4CF0243AAEBEC961A5B6AF343069
                E2E2F996DE33A80798AC68F8FCEFFDB67F67DF017C7AFF008277FC54F835F0BF
                C57FD87FF04E7F899AFE830EA173F15FE1FDD78B7E2DFF00C119BE3FFC3FF891
                E16F1478C743F137806499758F0BFC3E82D935DD0754D356EE3B9F0343E23B8B
                BB6BABDF03EA6DFF0008B807DA7A0E9902687F1C74DD0BF687BCD07E1BF87751
                BDD6BFE0AB3FF054C96EE3F0AF8D3E2DFC40F0269EB61AD7ECC9FB2A6B1A448E
                7E1FE99E1A8DAE34196E74247B6F0ADBCE744D09F52F195F789350D0ECBB5ACB
                65FB386B3A87ECE973A378774B4B8D37FE0959FF0004AAB7B7B1F078BEB8F045
                9585CE95FB5B7ED7BA64D6F35A7C3A1E1F8A4D3B56820D523BE8FC1D06B7613C
                916ADE3DD774CD334CFC58F1AF87BFE0AFBE14FF008283FF00C137FF00E09CDE
                26F1D7EC53A17C22D46CFE2BF8AFF632BCF05FECD3E249FF00630BED27E03FC1
                A83E2CF81FE2B49E0FD1FC4703F8BFC4FA13F87754D32DB46D4AEE68F429F57B
                0D7ADE3D51F56D235187F5AD7FE0995FF05A5B3D43F686F1DE95FF00052BFD94
                B4FF008D5FB4468F71E17D77E32DB7EC83E2A8BE25782BC0D696A6C3C29F0F7E
                1378A66F17CF07C30D134959B51BDB5B3B0D2A4316A1ADDE6A32BDF6A131BCA0
                0EE349D2BC59078EFE39F87FC27F1FEC3C41FB4B43A03D9FFC149BFE0A85ADE9
                1A4E8FF0CBF632F861E1ED1E1F185FFECA7FB2645AE01A3783354D36C75337F0
                69B24D7D0680B7EFE2BF18BEBBAD5D69B61AAF99FF00C1114FC2587FE0A1BFF0
                566FF8517F067C61F07BE0FEB9F097FE09A1AFFC33B9F1DD8EA51F8DBE33785E
                6F08FED445BF688F1EDD6B125C6AEDAA78DEEAEAEF5B175E2DB84D7F5386EA3D
                4B518A2B9BABC8AD78FD4BFE0969FF0005953E02F815F0034DF8FF00FF0004BB
                97F669F829A8D87896EBE14BFECFFF00B41687E15F8BFE33B0D4AE35FD37C4FF
                001E7C2BA77882793E2EDC586ACD6FAEF977DAE5BDA6A9AAC516A7ACD9EA97D6
                96D703EF0FF826B7EC19FB6DFC09FDAC7F6D0FDB23F6EAF8E5F017E2BFC4FF00
                DA97C25FB3FF0082347D0BF67DF08F8BBC2DE0DF07681F05348F13E9F1DAC56D
                E30549ED236FEDD8163855EEDA468EE2E25962699218803F6BABF95BFF00838C
                7E24FECC7F06FF0068EFF823F7C54FDB1FC3B71E2DFD9C3C09F15FF6BDD77C7B
                E1086D26BEB7F19EA16BFB3F69ADF0FF00C0FA9E9DE6DBD96AD65ACF88D7C29A
                75CD86B3710691736D7D730EB2E9A4C9A9D7F54945007F1DCFFF00057AFD8FB4
                DF1AF877E24DFF00EDBDFB2678BFF6FEF8EBA16B9E1DF0FF00C43D5FC4BAAF8B
                BF642FF8266FC0D916C0EB5E13F8770451D847F11BC4139874A4B84B07B4D4FC
                5FAB411BDF5CE83E16D134CB7D338C9FFE0A81FF0004A39741F895F061FF006C
                2B64FD8C7E1CDEDFF8DFF6A4F114D0F8D75CFDAC7FE0AB7F1E353D334DBFD774
                4BE8F4FD26DAF67F025DB43A469BA95C24DA545AC26956FE18B58341F0369337
                F6CFF68945007F9C77C44FDA6F51FDB83E397EDA1F1D7E0FF8ABE03DFEB70FEC
                EFFF000493D2BE00F81FC1DA0F8A61F859FB355EE97FF056AF803A67C2DF825F
                10755B3874A7F8917DA359788F49BED7AEB44820B18A7F195EE97A4B496FA2E9
                F7327F4B36363A4E9165F1F20D17E3CDFE97F0EB47D41357FF0082A4FF00C152
                B50F27C39E2FF8BBE23F05D9BE9D75FB277ECA52684D752F82AC3463A8DCE85B
                FC3D35DA784A2D4AE343D09F56F1BEAFAD6A9A0FBE7FC1C0977E11D3FF00E095
                1F1CEFBC7F73ABD8F80AC7E307EC3775E36BCF0F4DE21B6D7ACFC216DFB7B7EC
                C52F892E743B8F0815D5ADEF23B24BD785F4B65BB5912336C5661163C8EC8595
                A4BF0035CBFF0080B1F87EC2C20D3743FF008252FF00C13296D3FE10D8F403E1
                4D2A0947ED63FB577876DEDEEA3F8787438EF748BC335F58DF0F04D95CDB88E0
                D5FC71E25B2D3A1008DE5B8F0F49F01AEAEFE00D8699AF47653E87FF0004B3FF
                0082585ABDB783B49F05D87816D2673FB58FED590A5AC96BE05BCD2B4FBAD26F
                9C5FDADDC1E0D8AF6CAC2C575CF1D7896DADDAA5BE87E2C4D7FE34E87E1BF8E9
                A1A7C4FBAB5D463FF82A2FFC150A4B9B7F0A7863F674F06F86EC2EF5D3FB22FE
                C7C75BB8B8B2F016A1A1DA6AB2431466EEE61F095ACB2F883C452EBBE2DD66D5
                6F6CDADA6AF697BF1A7C37A77ED09A058FC46D374DB33FF0550FF82A2F9763E0
                ED1FE13F877C3B6DAAEB337EC9BFB295E6AB737367F0E6FF0045B7D4E6B686D1
                6F2E20F0659788E7D6B52935BF196B5BAF31D6E3C0D0781FE0E6B173F03FC53A
                27ECBFE1AF117F617FC13A3FE09DF69653E97F15BF6D8F8BF67A96A1E22B1FDA
                4BF680F0DF8C23FB7697A4477137FC2616D0F8C093A4A4D79E3AF1995D69B46B
                3F0E004115BF81AD7C11F03AF13E076AB6DFB36E93AADA5A7FC1363FE09BF650
                5DE85F133F6B7F8A36064F13C1FB4DFED3DA7F8D04971A4E976775749E2A8878
                BA19C6882593C65E2C7BCF135EE83A6F877C064D3F4CD3FF00E0B4BFF04D087E
                2AF8F8FC72FDB64EBDFB5D5F7ED11E37F06DA788DFE04FECF7A16B5FB217C42D
                5FE1BFEC95F0926D40A59F876DF4DB4BB9F5892C678DB5ED416E20F106B82C97
                C41A1DBAFD556D65F11DFC7FF15740B1F8ADE0E9FF006CBD5BC176773FB78FED
                DD69FD9E9F05FF00E09D7F035638BC6163FB377ECEF1F8DD1ACEC3561A4ADE5E
                DAD9DEB44D13B7FC279E34422E7C27A26B1F2FF83F529A7FF8281FFC1191FE06
                7C33B0F85BFB09FF00C2CBFDB4B4AF8137DE304F135C7C74FDA47C4BAAFEC53F
                183C55E32FDA97C637FE35946AE349D765B645B0BAD796E75DD7DF52BFF105FC
                90DA5EE8E2600FEA468A28A002BF951FF836ED6DDBFE08E3FB545BEAB24767A7
                C5FB4B7EDB96F76D76FE55B5858FF61E8E6EFCCF39945BC51ABCCCC0B2018624
                8C935FD5757E1BFF00C1307E07FEC7FF00047FE09E9FB52F807F670FDACEF7E3
                17C0ED47E307ED6FACF8FF00E36DBF879FC3BA8FC2FF0014EAFA62DA7C4AD12D
                B4EB68226B87F0CC766B730DCC30059D4C32421E37859803F233FE09A9A8EA57
                1FF04D8FF82724FF00B457C26B4F1DF81ADBC0BA0E8DFB087FC137FE136A7E14
                D73C4FFB67FC6CF0EDEDF6BFAD7ED41FB41FDB7EC9A2E95E1FD0AEEE1B5B8ACF
                5B77D27C3ABA7BF8975D9F54D76EFC2DA7E89FA777117C6F93E2F78EB4BD33C7
                7F0FBC41FF00050FF1278176FED21FB4CC769FDABFB337FC127FF667D66DA0F1
                4D9FC2FF0085B6FE2C10DBEBDE25D4AD2C2C6FEDECAFD6D6F35FBCB1FF0084AF
                C4B1693E1DD23C37A28FE3AFF617FDA77E3D7ECEFA178B341FD977FE0A13E2DF
                13CDA3FC12F0E781B48F8AFAEFFC12C3F685F8C7E24F83FF00B3E41FDA89E07D
                27C03AFC716AD2FC2FF0A7DA4788FC411C7069CB677975A25DDD5C0D4AE2CEDE
                31EB52FEDADE236FD9DFC05F0621FF008290FECADAA7ECDC9E34B2F889E32B6F
                0BFF00C1383FE0A49E27D2FF006B7F89DA85FCF6BA858FED1DE3FF0015E956F7
                BF1D350D7B5F78AF753B3BFD6A3B6D4B51D1AC6CEF05C595B7D86200FE9348F8
                1577F04FC37711E85F10ECFF00E09A169E316FF8563F0A6D6C2F7C4DFB4BFF00
                C16CFF006A5F186A906AF61E3AF12C37E916B9F12BC23AE5F69577ABA35E9B58
                FC5C85B5CD565D3BC0DA2DBA6ADEA7773FC7DBDFDA074712597C37F1D7FC150B
                C61E0411F80FE1EC32DE78E7F649FF00823DFECC7E2A47B0BAF18789A4D3534E
                3E30F166BD0E8ED6ED721B4BD47C5FA868E34ED297C39E12D0F57BA83F0074BF
                F82877C75BEFDA3B51F8AF7FFF000550FD9C67FDA174BF848BE01F87DE14D43F
                E08FFF00F0518D66E7F67EF8677DA841A56A9A9FC1EF871FF08C1B4F07BF88EF
                7FE1173A8EAD71A7DF49792E9DA3E9D24CF656967663E7E1FB5C788F43FD95BC
                69F09E3FF82CB7C1FF000EFC27F89DF112F35AFDA0FE378FF825FF00FC14820F
                88DF1F3C6165A8DAC7E38F0F7C6DF8ED77E1E7BCF10BEA906956BA26A3656D77
                A7C89A56949A34474DD390DA3007F52BFF00040DBDF8716969FF000547F06FC2
                BF8D3E23FDA47C25E1DFF829978DAFCFC7FF001778A6CFC5FE23F8A9E29D5BF6
                65FD9834CF883E20BFD674BB2B2B2BD4FF00848BC31E2A4865D3A25B2F27CA8A
                C87D92DAD5E6FE812BF8E1FF008248FF00C14ABF620FD8CD7F681F057C66FDA7
                7C41F173E3BFED2BF18ADFE27E87E03FD9EBFE0999FB64FC27F0DE9DE17F871F
                04FC0BF0A74CF0EFC3CF855A678226922B6B1B1F86BA2C2EB6F696D140352B16
                9701AFE5B5FD4D87FE0E2FFF0082624FA5F8CF5B83C55FB4A4BA2FC38BAD5F4F
                F885ABC5FB157ED612697E03BEF0F416171AF58F8CAFD3C2061F0B4D6316A7A5
                C97115F3DBB42BA8DB99046268B7007C01F1AA5923FF0082BAFF00C15AED3E2A
                FC663F057F6303FB3AFF00C13CB5BFDA8DFC2D1EBE7E337C66813C39F147C23F
                0BFF0066DF85579E1871A8E971F8DF50F136BBA75FC7A15B5DEBBA97D82C343D
                23ECD2788679ED7E93D4BC41F13ECFC45F01FC4FF153E03F85E2F8BC9A659C7F
                F04AEFF8244780EE34AD27C35F0234BF0D690748D33F6A4FDAFEEF458CE97E12
                9BC25A6EA3A5D8CD7505BCDA2F83D4C5A6E809AEF8A758D3D9BF2D7E067ED9DF
                B3D7EDA9FF0005A2FDACBF68EFD94BE10F8D7F694F8D7AD7C09FD91B4FFD8BFC
                13F147C13F10BE1AFC31F0AF8DAC7C31E3DD23C71FB52FC66D3B5CB354F0BE85
                E09D3758B08ADBC513D9BEA0F17C459F4BF0EA5C5EF892D99FF4BBC27A07849F
                4DFDA1FC17F0CFF69EF12EAFAE58AEA4DFF055EFF82C0F886EE7F0FEA7E13B6F
                08DEDEEADE2BFD96FF0064BD63566BAD3BC012DA19F5EB4B7D27C377573A3F80
                2C35A6995B59F145F42080685B695F604FDA4B49B3FDA7A0D23C43A2CB6D73FF
                00056FFF0082B2CD6765E088FC27A7F8574F6BE97F62CFD8EB5099E6B4F87971
                A1D86A42C87D82EB508FC196FAEB5CDC7F6F78DFC473CD6A5C369B6FA3FC0ED5
                B5EF80507857E06E917C9A2FFC12A3FE0933A3697A7785BC71FB4078FF00C2F6
                70F89745FDA7FF006A7D0F5012C7E13B3D0CDBB78A22B3D62D6E22F0A5B4B1F8
                875EFB7F8BEE747D3748AB6975E0FB5D23F66CD766F80D77E1BF82DE1ED6D3C3
                FF00F049AFF825A148FC25E37FDA17E20691245AEDAFED8FFB4D681E218AE2E3
                C1D65A28B997C550BF892D2E64F0B5BDDCBE25D745DF8BF58D174CD2BA5D1349
                F17DA7C4CF8F5E1ED0BE35F84BC49FB656BBE18D42E3FE0A21FF00051EFB341A
                37C19FF8276FC228F4FB4F10587ECCBFB300F199BAD3B42D5B4FD29CDCD96917
                378AB68DA71F1B78DD6E6EAEF45D2B5900D48ACBC7D67E32F8CBA1699F1C7C20
                9FB555F7856CAEBFE0A55FF05169231A67C23FD86BE0F58D8C5E288BF655FD93
                EFBC5F19D37C33AB58E9FA9BDED9595F395D3A332F8CFC5E971A9EA9A069DAAF
                A5FF00C1BBEFF0FDFF00E09D7747E13F8975AF17FC2F1FB5F7EDC23E1C788FC4
                779AC6A5AFEB3E023FB51FC4C7F066ADADEA7E21861D4352BCBDD31B4ABD9EE2
                F94DC3CBA8C8D36C90BC717CFB6569F05A6F841F0575ED47E1B78CB42FF827FF
                00C3EF12E9163FB0D7EC7DA741733FC7DFF82A97C7E9208BC49E16F8D1F177C2
                9E2A6B4BEF156957BA869BA9F89B4FB0F13BC2751782FBC79E32BAB4D2ED6D23
                B3FA83FE082B2F8A6F3F63DF8D3A9F8EF40B3F0978EB57FF0082857FC140F52F
                1B78474BD7A4F1368BE13F174FFB5078FD3C45E1AD0B5C786D9753B3B2BB8AE6
                DE3B98ED6D5671019FCA89A771401FB63451450015E01FB587FC9ACFED2BFF00
                6403E31FFEABAF1157BFD7CFFF00B5825C3FECB1FB4AC7676B25E5D3FECFFF00
                18D2D6CE003CEBAB86F875E22582D6118C6E91B62018EAC2803F96FF00D8FB4D
                F836DFF04CDF8336FA7D87C49F8F5FF04E5BBF871F07EC3F698F858B378CE4FD
                AE3FE0967FB50786FC05E10D6B59F8FDF07DE3822F135BF86ED359B8B4F18CD6
                7A45B437BA10D757C51E1A4D53C3FAA5C69B63F67597FC2DFB7F8B5F083FB2BE
                33F806E3F6DB1E0869FF0063AFDACAE6CD2C3F673FF82B87EC9FA368CFE305F8
                03FB435D78344B63A478E347B6BFD56FC5D69D05C49A7B5C9F167866DEFB4DD5
                BC65E1EB0F0BFD8FFC3DF1BFC2BE0AFD8A6C6E17E1DFC06FF828D699FB227C21
                87E0A78D34EDDA2FEC95FF000548FD9B3C13F0C3C1BAC8F801F16E4D3ED1EF74
                0F1AF8334ABE9AC9666D3E4BFD0A59A4F1168516BDE1FD4BC43A2597A09B8F82
                A3E09FC53D5E6F835E37F0D7EC33A6FC557B4FDAE3F65BD323D53C3FFB47FF00
                C1217F6B1F0C0B0F12EA3FB467C05D47C237931D23C256B3EA5E1FF17CB3F819
                E15D3A3D793C65E1EFED1B0D67C49651004FA0699F0CD3E137C61B2B4F82FE33
                F167EC4973E3C79FF6D7FF00827ADFC17FA8FED25FF04B0F8F4C89E2FD4FE2E7
                ECC9A5F83DCEA72784E3D49F4BF1841A77842647B58AE4F8BBC02F791DDCFA43
                78E7ED83FB2FD8FED9DF0ABC2BFB317C68FDA260B1F887F1C3E17EB7F0DBFE09
                DBFF000561F01DE581F037ED69F0D7C6165FDB70FEC7DFB5E2F845A3D2B5DD6B
                5186D6D6F20819459EBD71A28F10786E2D3B5ED3755D264FAE2EB46F8AB0FC64
                F841A7DE7C54F09685FB775AF80B50FF00862AFDB7A08D23FD9BBFE0A73F0374
                8D36E3C5AFF007F6A4D0FE1E2C36CBAEDA6957177A99B5B28E7164F7D278CBC1
                4F7113F8ABC3DA7F9B40DE15BBF03FED093E91F0035CD4BF67B5F15DD597FC15
                17FE097B7E8DA97C54FD937E2A6A7696BE35BCFDA97F6311E149A1FED6D3AFEE
                7ECDE3510F85E5B55D69613E28F0B1D2FC5B69AD695AC807E49587EC53FF0005
                078FC1BFB3CF8DECBF6FEFDA4DFE25FF00C1323C431F863F682FD8C749FD9B3F
                67BD5BE23FECC5E15B9F87EDF0FBC3DF1A7F63FF0084F69607C25FB43E991E84
                B7579A2F881ACFEDD7BA35EEB034A7D37C4B06B5A0B7CC3FB747807F6DEFD87F
                F678FDAEBF69DF097FC158FE3A7C6DF811FB70F823E16F8B7E12FED29E05F845
                F0EEEEC3F68AD775BBCD03E17F8A7E047C66F8936F1DD789FF00674D4B43F0E6
                ABE20BDF0F58E977163A4B43A16B76510F0FEB09776171FD164BA578A4EB3FB3
                769727ED23A6C9F18754D1147FC12BFF00E0A9B34765E22F0B7ED31E03D6B4BB
                9F188FD8A3F6D7D3F47B8B34F1EDEEA3A46949702591AD62F112E931F8834497
                45F1768B7D6CFF0098FF00F055A1E3A9FF00604FF8291DFF00C2AD27C39F01FC
                56EBF0F97FE0A4DFF04FAF1AEA6B7BE16F09FC4AD7FE2C7C33D73C39FB70FEC8
                9E21B6B58C6A9A6F8BEEB468BCCBA4B1D3AC3C471DD5E5EDEC7A178B3C33AB5A
                5E007E9327FC1033F685FB07ECFBA53FFC162BF6AA8746FD96CE8D71F023C2BA
                5FC11FD9D747F017C37D4FC3DE179FC1BA06ADE1FF0087D65A58D1DAEB4DD36E
                EF2D6C6EAF6D2F27B15BB91ADA58647776B567FF000430FDB17C29E33F8D5F15
                3E1B7FC16EBF6AEF0DFC5DFDA17C3BA37837E2C7C44F127C0AF817E35D5F5CF0
                8787B4CD4B4AF0FE85A2492A58DCF80574B8B57D55F4E93C3B79A49D3A6D5EF6
                E2D04171793CADFD24D1401FCF67EC87FF000433F883FB3A7ED09FB12FC6BF8A
                1FF0505F1DFED09E17FD81748F8E1A47ECFF00F0724FD9C7E0BFC1CF09E851FC
                7FF865AC7C37F883777BAB7C3A297BAD5D5F1D4EDF56B9BDD49AFEEAEAF74EF3
                E69DA5BBBF92EBFA13A28A0028A28A00FC09FF00839322F063FF00C135A16F1F
                EBBAF7853C2107ED6FFB1A4BE20F15F86B52D4746D5BC2BA09FDA0BC150788BC
                4765AA68D6B7577A74D65A6CBAB4F04F6B1ACB15C416D245E6BC690CFE5D1783
                B50D63E257C17B4D4BE217C27BAFDB7A3F0089BF622FDBC755F07E8175FB3C7F
                C1527F67E9740B0F1B5DFC13F8FD0783639F4F7F104365630DECD6F61335EC1F
                D971F8CFC1FE658DDF8B341B1FA93FE0BF371E29B5FF00826FF88DFC11A4783B
                5AF160FDA73F6126F0E58F8D7526D1F4B7D7ADFF006D4F80D75A0C50EA56E92D
                C5899AF6DB4EB59E5B4B5BC992C6F7507482508D8F91153E17A7C1CF899A86B3
                F093C44DFB0FDDFC45BC9FF6C8FD8F4CAB6FFB42FF00C125BF69D8751B5F126B
                7F1E3E026A7E07B813E93E0EB2BEBC87C64CBE1631DC5826B43C67E159EF2C35
                2BFD2E200CB8FE1B7C0E6D13F695B4F0AFECA526B1F033C432AD9FFC14CFFE09
                45AE782F47BEF895FB3FF8875FD2EF27BCFDA7BF63CB0F0D0857C53A76A4DA7C
                FAB1B5F064CF67E22FEC69B5AF0AC9A5F8B74DD674AD7368693A3DFDBFECE36B
                E20FDA42CF5AD1EF0A45FF0004B5FF0082BDF87A0D0FC56F35C78964874EB7FD
                913F6DA811ED348F1FDC6B6B6B0686ADA9B69F6DE2D1606156F0A78EF49D3EEA
                FBD175DB6F8873FC41F80FE13F88BF1CFC19A5FED42BA25C5D7FC1353FE0A73A
                1E81A6CDF09BF6B8F066B966DE20B9FD95BF69EF0CF85AE6DB4AD7753D674BD3
                AC2FEE749D32EECECF5E8635F137835BC3FAC6917763A5606991F9DA7FED197F
                E1FF00D9BAD2FA3D44CBA6FF00C154BFE092B7AF6BE2AB7BFF00F84A63B9B79F
                F6B6FD8E6DAEA1B1B3F16A7886CB4FBFD602699696369E318746BA0B0E8BE3DD
                1B52B6BB00BDA058EAD65F107E3A5DF843E04F86BC1DFB4FDFF87EE351FF0082
                867FC131F508344D43E0A7EDD1F0BEE238FC21A97ED4BFB2AC9AFC50E9FACEAD
                A969ED0C11EAAA9143AA3AA784BC6F6DA66B11695AB68DE6EBA3FC2C8BE0FF00
                C1D5B8F8DFE28FF862EF0FFC483A87EC29FB72196FAD3F686FF8256FC77D2C5E
                F84E0FD9B7F69D5F1F4124E9E15B79A4D63C0ED278DE38FECF1CEDE0CF18C465
                9B41D4E7F41BE834983C0DF03F4FF157C7BD4BC5FF00B316AFE20D1B55FF0082
                6C7FC14EF4017DAB7C5DFD92FE266B01FC3BE13F821FB556A1AEE1BC47A36A8C
                64F0836AFE235B1835A42FE14F18C565E209F49D4B57D582E7E24FFC275F1F2F
                34AF837E107FDB0FC39E1FB9B1FDBB3F60E410D97C0EFF008292FC0A9F4883C3
                1A37ED2FFB36BF8DD1AD21D72EB4EF2AC219EEA4B845B88EF7C17E2F3230F0AF
                8874F00D95B2F89767F1B3E216B9E1AF85DF0F7C17FF00050193C17771FED2BF
                B31DF2DBF86FF663FF0082B1FC00F0BC16FE1FD3FE297C23D7FC44D796BA4789
                34BB4D634EB18F50D40DDDEE832F899BC35E2E8755D1351F096B717E547FC11C
                5BC2F27EC59ACC5FB3669DE25FD989DA4F8E765FB707FC140BE336A3A4E8B6FF
                00B13FC18F067C7EF8B3AF787FF64EFD9D478E4CFA5E97ABD968522EB135B69E
                EBE1CF0B4FE3FBAF10EA126B1AADE5869B75FA3B2DAFC1FB1F823F09E3B8F8AD
                E34D73FE09F577E2C175FB257ED7F68FACE87FB46FFC12BFE3768B7979E17F0F
                FC3CF8B9ADF8D617D4F4BF0AE9B7D2EBDE1017BE2ED3D5B45489FC21E39B7D57
                49D41EEEDFF242D7FE0995FF000533F0A7C37F1FFEC6FE0AFF008289F8C87C5C
                FD98BE287887F6B2F853FB28788FF66EF817AC7C06FDAD7E185C7C69B9F8AD6B
                F16BE09EB7E3411E9FE20BEB3D7FC6B712DC7827C6975A958E8DE2D87418EF66
                D1F4BD43C27AF900FD73BAD5BC0563F0AFE12DEEB3F0A3C5DA5FEC6B69E37FEC
                CFD84BF606D2747D46EBF687FF0082917C66177FF09A68DF1CBF681D33C6CEB7
                D168536AB16B9E38161E27F2FF0076A7C6DE39BBB47820D36C3BCB69BE2DC9F1
                63E20E9C7E27782F51FDB8AFBE1FEFFDAE7F6B1874D8AF3F667FF825CFECED75
                696BE346F813F03DBC56B1D85DF8AEEED5745D4D2DF5968EE3536D3A2F1978B2
                3B2D1B4CF05F86E7FCADBFF83DFB7A9F895F0FBF6FFB0FF82D4F8DEFFE007C59
                F014DF00BE287ED25AAFEC17FB38E9DF127F62BF15E9BE29D334E8FE19FC46F8
                31E3381E3FD9F7C397DACA1D3BC55A8E9106957561ADF87F41B8F115BC9A6592
                6ADA2798AFFC1323FE0A7917C39F8CFF00F04F3B9FF82A4EA517C4FF0005F88B
                5EFDA7BE03FC1DF117ECCFF00AD7E117EDFF00E0DB7F1AD87C40BCF1D6BBF187
                568A5D63E22EB136BBACDADA78B7C3FE3AFF0084920B7D5351D265D4C6BFA1EA
                5A56A33007EB7DD45F08F50F821E1D4BDF08F8BECFFE09EB79E2692D7E097ECF
                B6FA7EA5ADFED37FF057DF8FFE299A7F170F1B7C468BC4AF6B7FE27F0BF8A2F6
                C755D67EC7ADBC07C4B125DF88FC5377A3784AC1EDB51F803FE0B63378957F62
                6FDB7AFBE23F87747F8E9FB68DD7ECEBA31F89961E11D69E4F801FF04C7FD9C3
                C53E33F03EAD65F0A3C29AFDC5AA2EA9E2BF164DA5696925CA58586B5E291A4A
                6A5730F87FC33A0E81656BE71FB217C35FDB73F6D5FF00828DFC5FD134BFF82C
                67ED07A5FC44FD9F3F647F84D71AEEA5E30FD8DFF664F0FF00C4FF00811E35F8
                89F12BE23E83F12BF676D7FE12DF69F73E1EF865AD69CFE01D06E351D67C3F0A
                3EBD6BA968CCD77AA69765A2CB2FDFDE20FF008378FE31F8DBE007C44FD993C7
                1FF0579FDAAF5DF83BF18FC5BACF8E3E31786ECFE0E7ECFDA25F7C52F13F887C
                416FE26D6F5CF1CF8D2D74D7F11789EEEEEEAC34812CDA86B3761E0D1ED6D0A7
                D92DAD60B700FE9C28AA5A6D97F66E9D61A77DAAF2FBEC1656965F6DD466173A
                85E7D9608E0FB55F5C055171349E5EF770ABB99D8E1738ABB40051451401F813
                FF0007185B5BC9FB16FC00BABAF888DF086DB4AFF828B7EC397F37C568A4D0E0
                9BE1943FF0B76D6C65F8836F71E2782E34AB57D112F1F53126A704968BFD95FB
                F4923DC8D344BF1C74DF8DBA9DE47A6FC3AF067FC14474BF04E7C53E028A75F0
                8FECA7FF00057DFD9D3C256F0D927887C3675192FD7C0FE34D0EC2E7EC893492
                EA3A8F852E357B5B4D547897C1FABE8F712CFF00F07144FF0062FD87BE0EEA0B
                E03FF85A4FA6FEDFFF00B0DDF45F0C047A149FF0B19EDFE396844780827898AE
                9DFF0013819D3B17CC96FF00F130C4E44265CF9446BF02F4DF817E1F09E26F1D
                47FF0004DF8BC5AE7E177C5389754F097ED33FF0463FDA4FC317971A1FFC239E
                2DBCF102CFAAFC3DF076837DA95DE97BF59B4B94F08C77B75A56BABABFC3FD62
                36F0E807C7BF16BF65EF86BE34B9FD9A7F6A0F827F1BFF006B2F825FB25FEC83
                F103E39D89D0FE030F07E99FB4EFFC1257E237C5CF0A68BE11F8EFF0E3C6BF0F
                3C75A3F896E752F8690DBC56CF71A0DA69D7379E12B2D6E5BFD19F58F04EA760
                3C2BDE43FB2BFEDDD1C9E27F82F77FF0588FDB813E3DFC41B1D73E217EC35F18
                62F1BFC029FF0064CFDADFE1E59A43E32D37C176B7BA6F806F350F87DE328340
                DF6D7966BAC6AD1C96E8DE2BD1E0F1169B6BAD691A2FD911DC7C6BD33E3B4973
                A1DFFC3FF05FFC14D3C33F0EEC12CAF6EECC785BF668FF0082C0FECBFE037835
                3B3934DB8591ED7C27E31D1ADF56F29EEACA5BBD47C1BA86BC8F226BDE0BD72D
                A2BDE3E0B1F8223E0878DF56D13C3FE36D43FE09DFA9F8E7545FDA3BF678BAD3
                B58F0DFED13FF0496FDA43C3B79A6F89EF3E227C2AB1F0F31D67E1F687E1ED69
                F4FD72EB48D0A2BA3A13EB767E2FF0BDCDDF85EF2ED1403E52B8F0DFED95A568
                BE1DF8BD63FF000537FF0082999F807F0EF55D67E15FEDB7F0A5749FD90FC73F
                B597EC45F16EC9F4DBD93C61E38B7D1FE1A4F1FC5BF03DAD9DD45793DC689A5F
                DA5F45F10E8FE2BD2DB58D1AE274B7EB2DFE097EDD6F36A7F09AFBFE0B47FB57
                E9DF15BE32A5F78A7FE09F3FB470D37F657D57F63AFDA97C2D7FA20F1CE81F0F
                750FF8473E1F5DDFF857C656DA459EA8B35A26BF72BA9585B37897C3D6DAE5B6
                9FAFE8DA2FD5BA55978E2DBE30F866D742F89FE19D33F6FBD23E189BEFD99FF6
                99D660D1AD3F67AFF82B57ECBDA45AFF00C251A17C3DF8B337C3F71A55FF0088
                F49B2D4218EE6EB4E82DF54D1AE25B9F177866C750F0BEA9AF68B2F1B6D69F0A
                E3F855F129EDFE1478CF52FD87F5EF1FEA76DFB6F7EC53A9FDB53E3AFF00C130
                FF006808B51D3FC757BF187E07E9BE016935487C370EB4F078B27B6F0A5D5DAC
                2BAE69DE36F03DCCDA54D796B7401F3FCBF0A7F6C3F12E9BA678FF0048FF0082
                917FC155A4D33E084DA8F833F6F0FD93F4BD47F64DBDFDAEBE05EBBA858D8EB5
                A1FC47F8653786BE15DBE9DF1BBC370436725F436DA568D7571E22D1F5292FFC
                377D7D7B613787F55CDB6F807FB4E9D42FB48D47FE0B67FB74C9F0D7F6A2B6D3
                6FBFE09D5FB66F877C49FB3DEB5FB3BEB7AF78B747825F08FC13F8FBE1FB0F06
                C37B6BE2892F6099AC2F6CB5DD034FF135BEA22CAC1343D6AC1F4FBCFB822D2F
                C7773E3CF861A36B3F1BF47B2FDA8A3F0FEA0DFF0004F8FF00828941A5787750
                F84DFB707C16D474C7F1C587ECD3FB4D597811AD349F17EA6969E65EDCE9960B
                A5FF0069DBE943C65E0A934BBC87C51A7687CBC2BA55EE9FF1C6EF48F811AEEB
                1E02D52EA7D37FE0A83FF04B4BEB68FC5BE21F879E21F165BB6AAFFB567EC89A
                7E94904DE308756934DBCD6BCAF0C347078AE2B29753D1ADF45F1E689ADE9BAC
                807C717FFB39FED97E29B4D2F4FF000A7FC1447FE0AA517C7BFD9D75BD126FDB
                8BF6375F8D9F0353E2BF8EBE16EAF1CD6561F17BF634F88179E02D0F46F1868D
                7171A7EA9A9E9B2CF63326B3169F7DE1F9E6F0A78874CB8B58A587E0978EF4FF
                0010C5F112EBFE0B07FF00053EF107EC5DF1F2D742F06FC05FDA8340F8C5E06F
                2BF661F8F6FA95CF81F54F855FB64781751F055B4FA12DC788934FD3A1D52FAD
                FC3C9A76A8B79E1AF105B6837E34FBDD4BEC6363E1FD45BF67AB4F18FED07AEE
                B7E15D52E347B8FF00825E7FC156B41BCD2FC43E29D1F52F1B4363630FECADFB
                52EAB1FD9ACBC78DAF3E9B61A646BE2082DEC3C610C16D617AFA4F8E746D2B50
                D53574AFF84DEEFC75F18AF34EF845E17B3FDAA2CFC3FA50FF00828F7FC13FAE
                2D60D43E0B7EDD5F07B56D0DFC0F37ED35FB2FDAF8C258B4AD6F55D4AC74C8F4
                EB5D4AFC85BE8F407F04F8C92C6F2D340D574700FC44FF0082837C01FDAC3E1B
                FECEFA87847C7DFB7BFED89AA7ED33F04BE2F7EC7FAF78EFF677FDA4BE28699F
                127F658FDB6FC14FFB5D7C16F06F803E39FC15D7B45D0F4CD53C05A5DA78BBC4
                9E07D4F58D1C7F68DFE8371A7DBE9B796D750DCF87359D5FF6D347975ED2756F
                8D76767F1D2CA7F18E93A7CEDFF0545FF82A15E2E9FE14F05FC17F0E782740BE
                D62E7F64BFD8FE2D4EE2E2D7C157BA045ACCCCB1C0D7D67E138F52BFD575B9B5
                EF18EAEF0DC7CABFB48FECF7FB33FED33FB2FF0082FE0278FF00E31F8C6DFF00
                613F889F103C1737EC57FB6108EF66F8E3FF0004D9FDA13C39E39D1AC63FD977
                E29EB7E27822D4FE1FE92F79A643E14D26EBC5525ADEE8F7B14DE17D6AE20D42
                DFC1970DF18695FF0004B5FDACE2F863A27EC3779FF051EFDA734CFDA7BF64DD
                43C3FF001DBE18FECCD7F0FC0BF0BFC01FDAABE197827C6B26A317C4EF805E24
                D4FC34EBAF6AB24F756B2DCBF8DD7C4B2F86FC5BA8585D6BB05D41A9E85AFEA0
                01FABB3EA3E08B2D07E017F6A7C11F13E95F0622F115CC5FF04DCFF826569F6E
                DE1CF8A5FB4FFC43F0EDDBF8D3FE1AAFF6A4D37C5921BAD0F4ED36E663E2B4B7
                F17ED87406D54789FC5C350F17EA1E1DD3BC2DDFC76FF12E1F1DFC4986DBE2BF
                83AF3F6BDBDF08E3F6DAFDB67FE25EBF017FE09CBF0316C63F18B7C00FD9DA0F
                1AC6DA5DB6B8966B0EA305A6AD13C8DE545E33F1C62D8F83341D57F1FF00FE09
                F5F08FE377ED85FF000524FDBC6C3C29FF000553FDBF3C3F7FF09FF67EFD95BC
                37AE78A7C73F0D3F678F0E7ED05E14B8F19DC7C54BBF1CFC02F18785FC6BE0AD
                42C3E12CBE1CD6345BB95A0F0C69FA5C57371A8FDB1A5D61174DBD93F5FAEBFE
                0843E0FBEF82F6FF00B3CDEFFC1483FE0A5F77F0717C730FC49D57C1773E31FD
                8D2787C65E364F189F88379AEFC4BD664F824752F8A8FA86B6C753D421F12DE6
                AB0EA33E1EFE3BDC00003CE913E16FFC2AAF87BB3E1C78D23FD84D3569F4FF00
                D963F6424B1B9D57F682FF0082AB7ED01AE6A379E2F7F8C5F192D7C6528D53C4
                1E14D4AEA1BCF1288BC5B3DB2EABF68D4BC63E379ACB44B1B18A4F02F1559C92
                7FC1667FE092DAA7C74F8987E22FEDA67E23FED513FC4EF017C361E25D5BF675
                FD917E1AF89BF603FDA1757F02FECF5E0FD5FC9B6D36CF59BA4B38F58BABED5A
                18FC41E22168FAB4B6FA2E87078574DB1FBFAEFF00E08E3AA5FF00C5AB4F8E97
                9FF0552FF82A7CFF001474DF04EA5F0E747F123FC41FD8EBC8F0F78335AD634F
                D7B5AD17C31E1B5F82634AF0B8BDBAD27477B8B8D3AC6D679D746B28A59248AC
                EDA3899FB347FC112FE13FECD7F1CBE0AFC768FF006C6FDBC7E37EB1F027E227
                C69F8BBE14F077C78F891F03BC4FE0EF107C52F8FBF0DFC5FF000B3E227C42F8
                8771E11F875A0EBFE3BD625D27C69A94505FEA1AECB2DBAD8D95BC6C2CAD85AB
                007ED15145140057F9D9FF00C1347FE095F27ED5DFB05FFC143FF68D8FF6F2FD
                BCFF0067F83C25FB46FEDB1E1DD43E0A7ECFFF001A64F04FC11F1A5AF813C35A
                0F8C84BE34F0341612FF006EBEA725CD9DB5EC625C4F068F688151A04C7FA265
                7F9F6FFC1323F6B4FDBD7E0DFEC4DFF051DF833FB367FC12DBC4FF00B5B7C13D
                57F6AFFDBC26F117ED1769FB4AFC33F83DA4F84AF6FF00C17A75B789F459BE16
                F8DB45B9BED7DF48D3349B0D43CA8278FEDB26B1169F044B74163700FB07FE09
                333F8F3FE188BFE09C1A5F8DF4CF0C7ECF9FB430F82FA847FF0004DDFDB5BC37
                2EAA9F087E325A6A1E25F106A7ADFEC27FB5DE9F2866B7BAD52EECEE1A2D2AE0
                4F06A76B711EABE14B8D2BC4DA2DE5B45FA236B67E1DD4747FDA260D03F666D6
                F57F04EB3716D61FF0540FF82476A8D65E23D73C0BAE78AAE22BB7FDAD7F62FB
                2816CED7C5506A4D677BAF799E1A96C2D7C523C30FA8E911685E3CD1F56B1D57
                F37FFE09296DF0C34BFF00825D7C349BC0D67E36F8EBFB26CBF027C35A2FFC14
                C3F636F17DC6BEDF167E0078CF57B697C65A6FEDB3FB35683ACB41A8D9693756
                96EBE23FECFF000BCD08BEB6F0BD8EBFE1512F8AF47D6ADB59FD39D574AF154B
                AE7C0DF0F6B5F1FF0046B8F8C8FA7447FE0963FF00055BD3E7D3BC55E0BFDA4F
                C27E23B75F132FEC8FFB5BCFE096B7D37C532EAD69A6E9F018A5B95B2F16C169
                65E21F0FC9A6F8B747B9B7B500A5369104F69FB3F5AEB3F1FEF757D021BAB387
                FE0971FF000569D36F34EF17788F48D4BC502D74E4FD8F3F6D1B9B88A04F14C3
                AF5C68B69A04B2EB0F696DE2C1636B63752F86FC7BA5E8B75A8F4AEBF1067F88
                1F19BC45E11F809E14F0E7ED6371E16F33FE0A07FF0004DAD5F52D2F54F82DFB
                797C18315D7839BF692FD9875AD7E2B2D23C43E20D42C62B3D36DF5BD4EDED05
                DC62DFC21E38B7D2AEADBC3DA9E91930EA56BADEA5FB44DD683FB3FDBEA2D25B
                DC693FF0561FF824E5F5BDAF8B5BC4B378DADED63B6FDAF3F64882F2DECAC7C7
                4DACD8E9FABEA0D269B6BA75B78D2DACDC4F1F87FC73A0DEDB5CE7DE2F8667F0
                87C1BD3FC45F1FB56F147ECEBE22F135BEADFF0004C2FF0082AB785F5F4F14FC
                49FD977E2178B1BFB0FC3DFB397ED2FAEEB2127F1169579770AF85E2D43C5134
                D67E268224F0A78C56CBC49068F7DE2200E27C3C9F062C7E10FC2A36FF0014BC
                73A9FEC136BE31861FD8DBF6BEB78AEEC7F698FF008247FED076BA97FC21ABFB
                3F7C77D47C5F14FA9689E10B2BAB97F0AF9FE32B3922D3218E6F08F8DD351D2A
                FB4CBCAF68D46EFE36E9FF001E7549A0F057C3DF877FF0518D0FC0D3C5F103E1
                445716FA0FECB3FF000588FD9B7C2D6515ADE6A3E0AD53C40248BC1BE34D1236
                68AD8EA525FEA9E10935E3A6EAEFE26F08EB765A8CEE8DBC713FC66F895ABF87
                BE0F784B44FDB4F4BF00883F6EFF00D83A5BED320F821FF051CF8112DA45E10D
                3BF688FD9EB56F1998F44D5758B65096767A9EAD1DBCE91EA0DE0BF1B9D3D26F
                0B6B1A57915E43FB3FB7C09F0FF9FE3DF1BF88BFE09B577E335BEF807FB4543A
                C6B9A47ED2DFF046CFDA5B406BBF095BF82FC5D7BE2185BC43F0F3C31A06A17F
                2E930CDAF8966F0A36A17DE1BF12C179E10BFB43A4807E5BFECB7A3FC361FB63
                FF00C153E0F835F11FE227EC5BFB0458FC30FD8AAE7F6B3D5FE206B5E30F0A7E
                D39FB37C115B7C5A8E6FF8278FC09F08CA64D4BE1849AEEB7A9EBBA3C32680DA
                9CDA759E8B6FA478384CDE21F0BDD699FAEDA9DDEB167A7FC0F7F88FFB338F08
                7853461A7E9DFF0004BEFF00823C781B51D0745F1278D356F05C115D68DFB41F
                ED83676D12691E07B4F0BDB5EF87B517D2F517BDD13C14F2FDAEFDFC4FE2EBAF
                0BC1A67E797ED73FF04C0F895FB5EFED23AE6ADE2EFDA1BF68CFD9FF00FE0A5F
                E07F0D7C1DF897E1DB1F82BF13342F827FB387FC1423C15FB369F10F85F40F8F
                5F00FC67A6E977CFF097E255A68BE34BBD32E60D50EA4FE10BFF001446E96179
                E1CD7ACB54B9F1CB6FD877C7FF000EFC7373FB67F83BFE0AE3FF000549D27F66
                7F1A786BFE199FF6A5F893F137C59A778BBF6C6FD873C73E14D5DEE6D7C09FB4
                8C5E21D36F25D27C1BA6EA5E29BD7BED5B40874B8F417D56C75A0DAB681A9CBA
                EE9401FABAF078D2DBC5DFB41E9163F1EBC376BFB425C684D27FC14CFF00E0A8
                0C89E18F84DFB0F7C24D3EDE0F10B7EC7DFB1C5DF8BDEE74EF0C6B5A4E953CD7
                31C571777034397524F1678A9752D5F53D1F4D969793F0D6D3E14FC2A97C41F0
                4BC5DE04FD83BC2DAF2699FB107FC13F6C6C6F07ED23FF000530F8EE6FE4F146
                81F16BE36F843C513417D2E8735F5BDD78A60D0BC572EE94ACDE35F1E5CE996D
                651D8D87E48FFC3A13F699B1F061FD80352FF829D7ED3DA17C56F0AFC4693F69
                3FD893C3BE2DF17F8434EFD90FF6DDF0C781FC6563F16E2D67C11AFD8E95AA6A
                7E17F1AE9125D596A1ACE8BAD378B92C754B8B6F14DBDA78A34FBCB96D3F13E2
                BFECC3FB4ECFF1F7F61FFDA2FE0FFF00C158FF006DA6F19FC44FDA9FC19FF04D
                FF00DA9FC1BF1EDBE1E37ED51FB216BDF14A693C51AA784BC2361A5698FA1785
                ED75087C0EB732CF69651D9EB312786B57B4BBF10D85CD998003F7334F6F8D57
                FF001A7C5D07FC255F0CFC59FF000520D63E1DFD9FE34FC65B249F5EFD973FE0
                901FB36789205D6ED3C05E034F10C5159F8A3C63AA5B590BE8EDAF12C2FF00C4
                B79A2DBEB9AFC3A2F84745D034C8BD23FE0DF61E171FB0C7C425F047C42BEF8B
                9E0B5FDBABF6F15F087C57D535C8FC4FA97C4EF0BAFED35E3F1E1FF885A87892
                2B7B45F10CFAD5A0B3D4A4BE5B4B513BEA4D288A012044F1BD37FE0DD1F8750F
                C14F18FC01D5BFE0A6DFF055ABFF00867F1335DF11F89FE2A785ECBE397C07B0
                D27E267883C5BABC5ABF89B55F1CC979F0CAF751F164BA935B594578754D4AFB
                ED515AADBCBBED82409FAC7FB0C7EC51F0F7F606F81D37C09F86FE3CF8B3F137
                48BEF88DF11BE2AEB5E38F8DBAEF857C47F113C43E33F8A7E25BAF16F8BB51D6
                756F06E89E1FB0B8F3AFAF6EA55D9A6C4C3CE3BDA5273401F63514514005787F
                ED35A85D691FB36FED07AAD869B26B17BA5FC0FF008AFA859E8F0CF0DA4BAA5D
                59780B5EB8B6D362B99D4C76CD3BC491091D4AA994120806BDC2BE67FDB475AD
                1FC33FB1CFED63E23F10DAC97BE1FF000FFECCFF001DB5AD72CA08E3926BBD1F
                49F85BE29BED4AD618E5051DA482DE640ACA412C01045007F311FB15C3F080FF
                00C131BF67387C5FAF78FBF681FF0082709F01FC1293C71E204D6F5FB6FDADFF
                00E0913FB56F82FC21E18BDD7FE20693E22D3521F1068BE0BD1B5DB8B7D7A0D4
                EC922BEF09DB6BEB7F12EB5E05D582F877EDBFB07C7AF0A7C79F0AC63C7DE00B
                CFF8280E89F0DAD60F82BF156FFCEF04FECCFF00F0596FD943C3B6577E225F86
                5F1223D1D2E348F067C4EF0D5BDFEBB70975A4B6AB268CDACA7886C6D752F0BF
                8835AD1B4BF0CFD8E6D3E3B597C3AF8033784FC27E06F847FF000537F865FB25
                FC1A5D77E134DA9CBA57ECC3FF00055AFD8E3C25E13F0AE83E0FD42DFC47A846
                441E27F0E6897F63A6A6AF2C36FA9F8535DD4BECDA9DA5E7843C47A57DB7D3F5
                183F66AB8F8376FA7EAFA7F8EBC3DFF04D9F167C42F22E92F0DF7817E3FF00FC
                118BF6E6F0D78CEC3FB11E091A56D4BE05785AD358D6965826892E6C7C297B35
                AC8ADA87803C629FF08F0053D2EDBE0C1F82BE2E93C3FF000BFE22F897FE09E5
                71F1062FF868CFD92E1B3F12691FB587FC120BF694F0EEA969E2293E21FC1ED0
                7C0734DE20F0CF86F4CD566D23C472E91E1C9165D061D51BC59E16B9D4FC37A8
                C9A7C1E897369F111BE22FC0C6BFF8BBE0283F6B94F0749FF0EF9FF828B5AC76
                2DF037FE0A29F066EB4FB8F1745FB29FED590F81628AC5B57BED2DA0D57ECDA6
                9B88AE64B49BC6DE098AD67B2F12787F4EA3169FFB427873E3F8D264D73C19E1
                7FF82A8FC3AF046A13FC2BF1C5DB49E06FD9CBFE0B09FB21782351B896C340F8
                8D6DA2C52D87873C73E1DB4D6644B98ECE21A8785757D4A2D634E8EFBC1BE22B
                CB0939AD6AE7E09D8FC25F17F8C6C7E1C78D752FF826BF8BFC5FADE9FF00B6BF
                EC9D7DA2788B4EF8E1FF0004BAFDA47C37AFDAF8C6FBE36FC38D1FC1D7A75BF8
                71A2E9DAD4969E20D5EC7C3292A692CFA778E7C2D3B6957DA935D0072F34FE19
                BBF007C7C9EDFF00668F16EB3FB386B7E2ABCD37FE0A7DFF0004B5685F5CF8C9
                FB1C7C52D5EF2E3C492FED63FB1FE9BE0E16F3F8A744D66FEC3FE1320BE178AD
                8EB6A63F17785CD96BF69AE699A97E66FF00C16B24F09DB7FC137FC5E3E34FC4
                2F13FC6EB53F0D7C3D77FF0004D4FF0082957C3ED72E0CDFB47FC22D7BC71E04
                D6350FD8D3F6BBF14785A236FE28D763D3F4F935B89F5444D3FC53FF000AE135
                A8D347F11687AADB5C7EBA9D0FE314FF0014BC0DE12BBF8BFE0FD0FF006F1F0C
                F83358D5FF00E09BFF00B74B8D3AEFE11FFC14A3F65CD274BB4F19CBFB3AFED3
                30F85192C7C53ABC169A9C577AADA69B1D94F9B7B7F1D784161860F12585A7E5
                E7FC158F55D7A5FF008261FEDEFE2CFD9C3C136BF0F7C0BE35F14F867C29FF00
                0520FD833E21EA16B0F89FF635FDA63C4DF13FE1AEB3FF000BFF00E0D4B6D198
                AFB49F11EA31695717706950B68FE24B5F15D9F8B746934CB94F12FF006A007F
                6F7451450014514500145145007E0FFF00C1C8B7515B7FC12B3E2125FF008BB5
                5F01F872EBF680FD8DE0F1678BB44D77FE118D43C37E1B8FF6AAF8477977AFDA
                EBC11CE8F269D2DA596A115D08E4F225D2E19B6B7915C0E811FC5DB5F8BBE024
                D33E23F8060FF828168FF0C6C6E7F67FFDA6AE62FEC0FD963FE0B0FF00B2FE8D
                A4DCF882CFC0DF13BFE1087BAB2D1FC63A35A5FCBA83B696B7F7DA05C5C1F137
                87E1D4FC2BE20F10684DDE7FC1C63FF0915D7FC13BB44F0E7847C35178B7C4BE
                2FFDB27F624F0CE81E1E9755B0D0E2D575AB9FDA3BC097DA2E94FA96A4A6DAC9
                6F6EF4EB1B1334E523886A46573B2160DE233DA7C15B2F82966DACF843C75E1D
                FF0082647C43F1746759F0B35BCBF0EFE3F7FC117FF6BBF0DEBCA8D7BA39D110
                DE7C26F09E95E20B89A5379A7CF770784AFF00508AF2CDEFFC07E222DA10054B
                58BE11C1F0D7E361F0E7C27F1A6B3FB1945AD3C5FB7C7FC137FC43A76A09F1E7
                FE09D3F154DC49E306FDA0BF665D1BC3D706F6CBC3F05E597FC24CBA7F82A792
                D654D322F16FC3FB992EADEF74DD57D5243E29D5754F823A26BFF1F3C3EDF192
                E746BB4FF8264FFC1547C3B1E8BE2AF877FB45F84FC4F10D5EC7F659FDAA53C3
                CD6FA6F89F50D66D345D25EEB4C8E7B7B0F14269367AF786AE743F15690D6FA4
                4DABE87F1E53E2AF86FC35AFF8D3C07E04FF0082957C3EF0C6B8DFB22FED492D
                859683F03BFE0A6FFB3AF86E7BAF114DF03BE38D8787AD0C167AA416D3DB5DEB
                5A0E9702DE6857B76DE2CF080974A9757B41C94DAD7C297F86FF00193C5FA3FC
                1AF13EA1FB1C6BDE21D57C2FFF00052BFF00827B7893C3F7571F157F623F8BB7
                17361E2CD5BF68EF841E0ED02596E6CF4F8A66B3F165FD9F8384F0EA904BA6F8
                F3C16EFA947A9278900357C396FAACFADFC75D43C17FB3F691A37C4FB8D32F87
                FC14F7FE0947AADF26BDF0FBE3A786FC4DA7DF68737ED49FB202EAF69068FE28
                BFF10DBE9B76E97B69A7E9769E308D24D27C4D1F87FC57A4A4963CD691A7FC3F
                D43E1DFC05177F1D7C47AB7C004F1E6A97BFF04D4FF8292DC5D6A5AAFC66FD8F
                3E2A6B1AA378420FD913F6A8FF0084F234D4756D3A7BEB6D5FC10EBE309218B5
                68F4187C23E2D8F4DF1558786F52D73D3EFF0042D6A7D43E0BFC2BF89BF1B21B
                AF1DAB5B788FFE094BFF00054AB1BAD135A97E23AF88B409751D37F66EF8FF00
                AB692D6D65E37D5B54D2AC912EEC2571A578FB46B5B5D4ED0DA78A74495AC394
                B6D4F57B91F1B3E245B7ECED6D378F6CD353F0FF00FC15BFFE0985696D1F8CF4
                6F8D1E1FD6B406D307ED63FB2C784B5D4B7B2F8897FAAD9E8915DD9DDDBDBDAC
                7E32D2ADB52D0F52583C63E1CB7874E00D9D320F89F07C58F883A8689F077C0F
                E17FDB467F0A5BCFFB767EC537431FB3B7FC1497E0A5AC769E08BAF8FF00FB32
                6B1E339A2D1A5F1045A7FD96CE2B9D51239623ACD9F843C766181FC2BAEE9FE5
                96961F092CBE1C7C2D860F8B5E3DD1FF006328BC76F63FB157ED51369BE20D17
                F68DFF008253FED2F65AC27C3D9BF666F8ED378A2337D63E0DB8BFBDBDF08A59
                78BA086DED61DFE0DF122DEE9F7BE1DBE8BD4CE8BE0A3E1FF81DE02F127C67D6
                757FD987C67E22F0C789FF00E0971FF0509F0F788750F107C52FD9BFE24EB102
                58786FF67DF8B9E3CF1424EDAF5B6A4649FC3BA55CF8A24953C49612CDE0EF13
                0BCD6C69F71E20AA2F7C613F88FE2DF8975DFD9EBC33A87ED45E1CF07693E0FF
                00F829DFEC47A5E8F36A5F0C3F6EEF80775A6C9E17D3FF006ABFD99FC3FE2875
                D37C7F7D05A8B97B3967B4B9BEBEB2B5D4FE1FF884C9AAE95E12B9D2002C5B2F
                C576F8A7F11A5D33E16F83FC29FB7BE97E0D693F6B0FD92EE668348FD947FE0A
                AFF01B4CD36D7C1F79F17BE09EA3E2E8AE2C74EF1047657FA2D947A85FA4977A
                3DC5FC5E0FF181D5346BBF0DEBB6FE6D141F03346F817A14CDE29F88127FC13A
                A1F88301F83BF167CDD47C3BFB4F7FC118FF00693F09EAD79E15B9F08F8AAEFC
                52975A9F827C17A2EA17973A1092FD655F0B5BEA371A1EAF06BDE04D784DE1EE
                CED7C39F0DE1F007C20F036A1F17B5CF14FEC41E31F1268DE29FF826EFFC140B
                C33E2CBBD67E2D7EC4DF18B5092FB42F0C7C10F88FE37F148B8BA4D29A6B9D53
                C2DA36A5E251243756F7173F0FBC6115C5DDDE97FDBFD9E9573F185BE25F8EBC
                4DA7FC3AF0D695FF000506F86FE0FF000FD8FED9DFB32698F0E83F037FE0A6BF
                B3BD868C7C23A2FC65F82E7C64ADA79D5A287C9B5D2B53BC98DC68D751CDE07F
                15DCBE9979A16A96C01E65FB0A1F8EF6FF00F05BDFDAEF49FDA1B40F00DAFC43
                D23FE09C5FB2FE917BF12BE194F6567E12FDA4347D23E37FC60B4F0A7C7E4F08
                C20DC781EF751B164D2EEB43BC9F503A75CF856E6DED2F750D31B48B89FF00A3
                3AFE643FE0941A47C12D4BFE0AB7FB66789FF670F1DF88F57F81DE16FD847F64
                3F07FC39F85BE28F39756FD9E74FF117C58FDA0B56F10FECEF75A1EAF15BEB3F
                0CCF8375AF0B788AD0783F5C59EEB45FEDC6D2A23A7E9FA46956369FD37D0014
                514500145145007E09FF00C1C69677D73FB01780A5D37C6B6BF0DAF2C3F6E2FD
                88EEADFE205D41A3DD47E079DFE3DF85EC2D7C5EB63E2046D3EFBFB2A5BDB7D4
                1A1BF02DD934C904D98C3AB52B8B4F8C317C61F18B699E0AF875E1CFDBEED3C0
                D6B37ED0FF00B3DDE4A745FD94FF00E0ACDFB3368B6C7C273FC42F868DE216BA
                B3F0F78C34FB2B8B5D2D2EF50FB4DEF87AE352B3F0FF008A06B7E15D5BC27AB4
                973FE0E2CBEB01FB0F7C1AF0B6B1E05D4BE267877E20FF00C140BF61CF067897
                C01A0F86AC3C65E23F1968127C6ED1BC417FE12F0D7837559ADECBC5B7FAA8F0
                EC7A643A5DECD0C174DAB79123C4B2EE4E2CE85F0D93C21F0DBE1EDD7C4AD675
                AFD8AFE2078A2C75BFF82707EDBFA54D3DCFC56FF827BFED012DF7FC235E1DF8
                01E3DD7FC4F045A8E8FA626AD34DE1FD0DFC4C18CD14D7FF000EBC5D15C2C9A6
                26B201E72B6BF03AC3E04E8A7569FE21EB3FF04D38BC76F7FF000CBC7C9A65F7
                857F6A6FF8227FED2FE0CD724B093C3DE2892489B5DF03F83FC33ABDDDEDBA6A
                17B0DEFF00C2296F752E99AC26ADF0FF00518E6D23E8711FC71D2FE2EE910CFA
                8780FC3BFF000515F0E7C3C1FD91AFC70C5E15FD96BFE0AE7FB39F8598F9BA6E
                AE96D14D6DE0CF1AE956529B916D035C6A1E10BFD71AE2D4788FC13ADDEC1A86
                669F3FC627F89DE34F16F867E1FF0085B43FF8282FC31F08689A5FEDBDFB23A5
                C5969BF06BFE0A59FB38D8C1A97853C3BF1DBE0D4DAFA5BE9ABADDC431347A3E
                B9791ACBA65D4375E02F16CADA7AE85AA5879E69F0FC06BCF849A14173E27F10
                EABFF04C3F1D78D74AD47E047C4EB59351F027C70FF82457ED55E1AF167FC231
                67E04D5B51D4A25D5BE14F86F49F115FDE69B6536A89E5F82EEBED9E18D5A097
                C19A958C5A380417FA67C16FF8529E2D4D77C23E303FF04F1D4BC7CD75E3CF85
                DA3D8C1A17ED21FF00045FFDAAFC39A8C7AAEB3E25F0CAF83DEEEFFC1BE17D23
                59D564D7BED7A2CB76BE161AD45AB693FDB1F0FB5FDDE1CF4ED2C7C5AB3F8ADE
                02B0BAF1D7C3CD0FF6F0D3FC20C7F66FFDA9E316FA6FECE1FF000559FD9BBC3F
                6FFF0009027C2CF8BE9E0C8E4B4D0FC5763677EBA8496FA7DADE5EE87702EBC4
                FE101AA787353F19E846CDA49F1F745F8A5AD4BA245E0A5FF828AFC22F0BE91F
                F0B8BC0F36956FE06F83FF00F056CFD933418E0D2B4AF889E11B76962D2FC27E
                35B082E22B482FB75E9F09EB935C787F5233F847C51A1EA13F0D7367FB39697F
                06F59D44A6B5AE7FC12C7E2678AFEDDAB68DA7BEA5E13F8ADFF0494FDA8340F1
                3CD7BAB6B1A6C7A591AC7C0CF0D691AFDC4735C43692DAC9F0E757D3BCE8221E
                11D5EEDBC2200CB56F872DF0D3E2B2D9FC10F1A789FF0063B9BC58DA7FEDC1FF
                0004FDB8B4D467F8F3FF0004EDF8D905D5AF8CAF3E327ECF5A4782EE135197C3
                4B77F64F15FD83C0F70E5925B2F18F801E779EFEC751E9E4D33C4D378A7E06D9
                6B1F1CF4D93E343F87EE6DBFE09ADFF0539B06D2BC43F0F7F69EF03EBD670788
                6D3F652FDAF6CBC23359E9DE35BED4EDF4FD3E792DA36D3EDFC4715826BFE14B
                9D07C4DA6EA36F61B32695F18E1F8C1E14F0E6B1E32F07782FFE0A61F0DFC2DA
                827C06F8EB7BA7C7E18F81DFF054BFD973C312DBF88355F87DF126C3C3113596
                9DAC59C178EFA8E9B656F75A8F8435499FC4FE1C86EBC39AF6ABA6EA1CEE8A7E
                145C7847E2DF88B48F85BAD5EFEC5DE3CF13EBDE1EFF008284FEC3BE27B636FF
                00123F609F8F0D1D8F88B5DF8E7F0F3C3FE1891AE743D29AE4597887548FC257
                A9137DBF4EF887E0FB8B8966D55F59007E8915C5ED9FC75D4744FD9DAE357D2B
                535BBB0FF8299FFC127354FEC7F1ADC26ABE2A6BFB8B8FDA87F642B4BA16F65E
                318FC51169FA9EA62D34F8EC6C3C629A74D34317877C75A46BD67AAE3AE91E1D
                4F0B7C16D3F57F8EBE24D4BE0A49AFD8BFFC135BFE0A6DA54F06A1F127F66BF1
                C6BD2BF876D3F650FDAB6EB568EDDF5ED2AFAEF488BC2226F16416F078803DB7
                857C4DFD9BE35B0F0FEABE20EE75AF0978F0F89FE157C36F14FC67B2F0BFED2B
                E198AF6EFF00E09A5FF0511B992D3C55E13FDA8FE1AEA167178A25FD9B7F693B
                6D00D8D978C3529F49B4B2B6D534792E153C4B67A55AF8D7C2D7165AF697ABDB
                F8533E0D62D352BEF8E9F11F46F80D7D35C6A3669E13FF0082B3FF00C1316FE1
                D3BC652DF49E24D112C1FF006A9F801E1D6B75B7F8A32DFE9BA6DFC82EB4982C
                E1F1E687A4C886DED3C67E173A538036E74EF88779E31F8C17D7DFB3EF842FFE
                3F3F84ED6CFF00E0A19FB0843A7697ACFC17FDBF3E0DDCD9C7E0CD37F6A3FD97
                66F193C1A6EB9AFAD8E95FD9AB6DAE1866B886DA2F0878ACDACF65E0BD6AD7CC
                458FC32BDF85BE038F50F89DE2FD67F60DFF0084A6D6FF00F638FDB16DD355D3
                7F690FF82517C7ED0A4D47C26DF09FE3ADEF8CED9B56F0F786B4ABE379E1AFB7
                78CA03FD9492DEF83FC730DC6977569747D393C3DA6EADA4FC14F04E93FB414D
                A878535D9AE3C67FF0494FF8289BDCC7E3AD63E1E78BF5DD206943F64BF8EDAC
                EA09047F116D351B4FF895DADB6B97AB73E2DD22C6F34ABF96CBC61E14D2F58D
                5B4ED6E7E205F7C41F88BF11FC1DF0874DD23F688D1AC2C3C3DFF0534FF8277B
                CFA1EB3E0AFDADBE166ABE1C93C2DA4FED0DFB3A9F149834CF14EA33585A490E
                91AB5C369D6FE20B2D36FF00C1DE2C1A6EB3A2E9CFE1A00F3DFF0082695BFC7A
                FF0087BBFF00C1507FE1A2FC33E09B1F89DA1FECC7FF0004F7F0E789BC6BF0C6
                6925F007C561609FB43587877E2BE93A44E86E7E1FBF882CB48F3DBC337D737F
                2E9D2E99776915EEB16D676D7973FD10D7F36FFF000464B3F8111FFC1427FE0A
                C90FECFDF107C49F11FE17F85FE1E7FC138FC37F0A4F8B750FEDED47E16FC33B
                EF875F1EFC456DF0634ED535B8A2F10E890787358BDF13E88DE1EF10AB5F692B
                E12B3D36E5CCDA6BC367FD24500145145001451450015FCACFFC10823DBFF04C
                8FF82A9465088C7EDE3FF051C48F31AA2BC6BE08F08A65027CA5410CBF2AA805
                0AED1B79FEA9ABF94CFF0082296B365A6FFC10BFF6E6F8ABA0DB698DE37F157C
                50FF008295FC51F1ADB595A5ACF6327C40860F135BD9C06CAC2E5669E33A6787
                BC228B15C5C4331896255758BECD230078F7FC13122F89DA97EC75FF0004DD3A
                F4BE0DFD9DBF6C1D3BF65CF0443FB05FED23E1EBFD607C13FDB13E11D859DE78
                8753FD85BF6A5B230958354B4B5D2E393FB3AE24BD9A13A8FF00C253E112F7DA
                5F8B349B4FB22D74EF87D73E12FDA01744FD9F2EB5AFD99B58D5FECBFF00052C
                FF008257F882C4EABF163F64DF89BACCB6BE23BCFDA5FF00654D17C19BC6B7A6
                6A2DB3C56F6DE1716916B234A4F14F84A7B2F135A6B1A56B7F10FF00C131F4BF
                849E12FF00825B7ECFEB7BE28F137ED07FF04EEF1F7C08F85969FB58F85A5D5F
                5AD53E30FF00C135BF6ADD3FC3BA5F8BF5FF00DA0BC0304910D7BC15E0B9B55B
                FD3BC4CD358C6B3786258346F1A68A66D0354D66EB4FFD1CBED23E31AFC4FF00
                869E16F13F8FBC33A37FC1477E187856FE6FD8D7F6C7BED3D3C3DF027FE0A75F
                B39D9C8DE2FD73E007C6497C0702E9567ABCDA7C0F2EA7E1F5B5BAB9D16EDD7C
                75E0DB6BEB11AE595A8062EA9A46ABA96B1FB3869FABFC7D8E7F8877B676B73F
                F04A9FF82AD69D1DAF89BC3DF18BC35E33B1B5D7AD3F641FDB122D04D869DE34
                B8F10D8695616E239A5B7B5F16DBDA5A6ABA449A0F8D3474DD2D80D7EF3C67FB
                42EABE09F817609F12A7B29E3FF829EFFC12735BB8D275FF00077ED0BE17F16E
                9E3437FDAE3F63EB8D6A3B4D2BC4D7FE20B0D3EE1D6F05AE9F67E2C16375A278
                8E3F0E78B749F36C7286B5F0F750F09FC6CF1C587C0FF11EBFFB1DF8DF5EBEF0
                57FC14DFFE09CBE23D0E6D53E297EC5DF1BDEF6CB57D6BF690F853E0EF0B9B99
                351D1E730D978875283C1ED1C1AA41F60F1F785A69F501ACC7ACF47AED8EBB34
                5F04BE19F8CFF681897E2A2EB773A9FF00C1257FE0A8B0456BE24F087C59D1FC
                57A7C1E24D1FF65DFDA435DF0BDC45A7F8B753D5B4CF0FC3A26A1A75FC96765E
                39D3B44D3B5AD21EDFC5BA5BC7A40079E5C681E0ED57C13FB38E9D37C7BF1878
                83F673BEF11E9FA87FC131FF00E0A6DA45D4FAD7C62FD8EBE2EEB7763C23A57E
                CA9FB5649AF3C177E2CD17539A083C2064F15183FB60DACDE10F18269BE23B3D
                0755D6BD6EDE7F8AB7FF0017BE206B5A3FC3AF07F817F6FBF0D780234FDAF7F6
                29BAD4AD53F66EFF008299FECF9611CDE12B0F8D1F05B53F13C22D1759107936
                363AD5EC725D69325DC5E0DF1A2CBA7DCF87F55B4E661BD8EFBC55F1DBC75A17
                ECF719BBD4ACE0F08FFC15EBFE0968D696DE357F135978C2D458D87EDA1FB38F
                872D6D561F8B136A1A5D8EAB335D68D6109F1C697A0CF6124369E35F09369D1E
                70B4F09587803E0EF817C41F1E13C4FF00B3A789BC410F88BFE0933FF0542D16
                F22F19788FF65CF88FE22B7B9F0FFC3BFD9DFE37F8B357B99A6F11C250FF00C2
                3365ABF896F12D7C5F6324DE0FF1498BC40DA7CBE2700C8834EF825A2FC01F0E
                DB2F887E20DC7FC13A2DFC5325DFC1CF8D027D53C3DFB50FFC11A7F688F0D6AD
                3E891783FC612EB826D63C25E10F0EDF6A32E8EB36A0930F0BDB4571A278822D
                77C15AB9B8D23BFB7B7F8EDA77C759E782C3E1AE89FF00051ED0FC05F66F88BE
                0C9603E08FD98BFE0B19FB26F8152C34D4F157876E6E52F6D3C09E36D020F12E
                9F6F14F336AD73E14BBF123699A8AEB7E12F10E957915FB4D77E266ABF133E25
                FC49F0BFC1AF0F785FF6E0F873E138343FF82847EC136BA94173F0D7F6F9F808
                D657BE13F09FC7AF80B77E2210E9BE25BF9AD348B98FC3BAF6A36B0CF244B77E
                03F173E9925BE9D75A1F915BC3F0347C18F09F8274AF88BE26B2FD823E2178EA
                C354FD83FF006BDF0C5DEA717C4FFF008253FED32D0C5E12D13E007C4A8B5B90
                6ABF0DB44D335CBAD4F4AD2C6B820B3D3A3D7F51F87BE29B7B2D2E5D1FFB5403
                9BD46D7F675D2BE00DD492C7F12EF7FE099F0FC4891AF74DB0B3BEF087ED51FF
                000431FDA5FC153C2E2F3447D185EEBDF0D3C31A06ABA834A63863993C190DE8
                9627D63C05ACF97A1F8CFED93653E9FF00B53FFC12820FDA9BC3B637DFB55E89
                FF000508FD97743F843FB697C2BD2E0D03E12FEDDBFB3CFDA75E9EDCF8EAC7C2
                8AFA77873C57E1EB8D7744BB3E18D598C16F36B9A9EA5E11B9974CD775BB3B2F
                BC3483F1A2CFE337FC26F6BE05F0E785BFE0A59F0DBC056FA37ED37F04B4D98F
                843E06FF00C1543F66AF0941168167F123E107883C4023D21F5BD19B5DD3AE74
                BB9BF65BEF0BEA1AF4BE13F11490E83E20D2B559BE11F8BDA7E9D61E30FF0082
                57787FF66EF12699E22FF827FF00C4FF00F82B87C0BD7FC3DF093C6D1EA5E1BF
                8D5FB0D7C79F85BE12F8B7E31F117ECCDA6F8435A47BDD0FC3F26ADA1EA57927
                873524B3B8F0A5C68B7DA5DA7DB346F10E811787403FAE2A28A2800A28A2800A
                F9FF00F6B1F0B69DE38FD963F696F04EAD189349F17FECFF00F193C2DA9C5BE6
                883E9DE20F873E23D22F63F32D9A3923062BB906E8DD187F0942011F4057937C
                7BFF009217F1A3FEC937C45FFD43B58A00FC2EFD983FE0861FB0CFC45FD9C3F6
                3CF88FE24F127ED87AC789B45F80FF000ABC51E0CD6E2FDB9FF6A5B31E0BBFF1
                67C2DD1D759B9F87B6DA2F8AA0B4F0243756FAB5FDB791A1C56500B7BC782348
                E0611D7AFDC7FC1BFBFB1BC179E3EB9F09FC69FF008282FC3E83E2DC3045F17F
                4EF087EDDFFB42A59FC5D920D0DBC2B1DC7C4C7F106ADA85C78CDC690D1E918B
                D9E54167025B8558C306FD15FD81F1FF000C33FB171002FF00C626FECE830A8A
                8A31F07FC1DF285501502FDDC051F857D6D401F83D73FF000402FD87FC3FE18F
                87D6FAAFC73FDBD74FF097ECFE0F887E181D4BF6F6F8F7A6E83F06E5D134BD52
                CE1F12781D4EAF0DA7C3B7B0D3F53D6EDD6EB4D5B1115B6A17484A472CBBBB0B
                2FF82127EC996FE2DF147C48D37E3F7FC1456DBC75F1074CD0B4CF1AF8EF4DFF
                0082847ED376BE2AF1B68FE1CB492D3C35A7F89FC4D69AF2DDF88AD2C6DEE678
                ADA1BB9E64852E1D6211ABB03F9BDFF0545FDA97E2F7ED63FB437C64FF00826C
                FC3FFDA5BC25F03345D6BF683FD987F61DD53F65FB7D03C037BF193F6A1F879F
                B41781FC29F16BF69FF8CDA8F893C50EFADFC34F07787BC09E2BD4B4DB0BAF0D
                E9D2B5C5EF86AFD6E2E67FED7D3ED6C7F687F61DFDBF742FDA9BE36FED83FB31
                E8DF03F5CF84B7FF00B0A78D3C23F09BC4B7DA87C49F857E38D2F5CBED634BD4
                2E747B6D12C7C05AA5FDE69496F65A45B9945F469E54B2CB652325F69FA9DB58
                807CA765FF0006EEFEC1161E0FF007C3B8BC6DFB6FB7C3EF851AEE99E26F85DE
                03FF0086E2FDA320F05FC36F1168C7509347D7BC03E18B3D6E1B1F075EDA4BA9
                DECD0DDE9B05ACD13DCCA51D04B3093E68FDBF3FE085FF00B0BF86FF0067FF00
                8A3F1305CFED4DE26F17EB5AA7ECFDE14F12DFF8FBF6C9FDA5FE2041E2FF000A
                5B7ED03E04874FF0BF8C34EF187896F6DBC51A7D99F126B735ADADF473A5A4FA
                849736C2DAE364A3FA74AF857FE0A45B53F63EF887F710278C7E021DCD858D02
                FED0BF0A40279015405F51F77B5007DD5451450014514500145145007E607FC1
                5EFE07F80BF682FD8DAD7E1CFC434D663D0F51FDAABF610863D47C37E24F1078
                475FD166D6BF6D4F80BE0FBED4B44F10785E586F34ABA1A7789B5B822B981BCC
                81AF16780C3716F6D2C3F3DFFC382FF64BB6F1078F75DD13F682FF00828E7869
                7E279B26F885A5685FB7FF00ED196D63E357B0F0F597852DA4F175EDD6AF36A3
                E2D64D3B4FB7B20754BFBCD96E16DE3F2A08A18A2FB37FE0A54EB07ECAAF726E
                D6C16C7F693FD856FF00ED5E5C3334234EFDB9BF672BDFDC5BCED1C77329FB3E
                D8E17740EEC884AEEC8FBDA803F0A66FF837B3F622B8F0F7803C2375F153F6F7
                BBF09FC26BCD0EFF00E14785E7FDBB3F68993C3DF0BAEFC33A5BE8BE1BBAF875
                A236B06DBC172E9D6735C5ADB49A7476ED04573245118A362B5AF6DFF0405FD8
                B6DFC47AAF8C8FC57FDBEE7F17EBBA5E8DA0EB7E2997F6F9FDA723F11EB5E1DD
                02E755BBD23C39AAEB969E2086EB51B0825D7B5A923B69A57585B55BA687C86B
                89CC9FB7F45007E181FF008377FF00E09C6FE0CD37E1C3DBFED60DF0F347BDD3
                352D23C04DFB6F7ED587C19A56A1A36BA3C51A3DFE9BE16FF84AC58584F67A9A
                AEA30CB0DB23457405C214946FA49BFE0809FF0004DE87C6FA7EBB79A9FED527
                E235F786F55D1F48D62EFF006F3FDAB53C6B73E15B4BCB2BCD5F4ED37503E305
                BF9F4F82EEFB4AB99A089DA059AE2D9A55CC89BBF5CFE3E7C4F6F821F02BE34F
                C6787C3977E2D93E10FC24F88DF13E2F09E9D29B6BEF13B7803C1DAC78A93C3B
                633AC531826BD3A42DAA38865DAD72A763E369FE4D3E00FEDC1F196FFE2C7ED3
                5FF052BF1B7C6FF87BFF000514F087EC1DFB01F83F5EB8F0FF00C1ED63E16FC2
                3F829F027E21FED65AEC7F177F696F849F08FC6DE12D3F55BFF89F17853C37FB
                3C7C2AB1173E259353D567BABA4B768ECA6B9992C403F579BFE0DCEFF82523F8
                7B51F094BF073E344FE17D5E5BCB9D5BC3B2FED9DFB64BE83AADD6A1AD1F126A
                175A8E8DFF0009E0B4BC96E7512D7F2BC90317B9769DB321DD5D169BFF000402
                FF00826E683E208BC61E18F09FED2BE14F19DB6897BE1CB3F197873F6EAFDB5F
                4CF1558687A8CB6B717BA5D9EBB178F8DC416D2CD636733DAAB98647B489A48E
                43147B3F537E02FC4F8BE36FC10F83FF001921D26CB418BE2B7C33F037C458B4
                3D37C49A678C6C3468FC65E1AD37C431E956BE2BD1552CFC4696EBA82C22F6D1
                5619BC9DF1E5192BD6E803F1A1FF00E0833FF04F3FF844BC69E03B6D2FF6AAD3
                FC17F11E5F165CFC40F09D9FEDF3FB700F0CF8E2FBC76D14BE31D47C5FE1DB8F
                8812D8F89E7D526B6B49EEE4BFB7B8FB5BDAC66E85C88C0AD287FE086BFB09C3
                AA7833C40B77FB61B78ABE1BD8F8834CF86FE2E6FF008283FEDC8BE26F877A67
                8A2DAD2C35CD3BC0BAAC7F1011FC2905CDAD8585ACB0D8881278AC614B85B8F2
                90AFEC2D1401F8BDFB06FEC5DF017F632FF828CFEDF5A07C15D2FC76F3FC4EFD
                96FF00603F8BDE39F147C51F89DF113E3378DFC41E32F137C59FF8287783753B
                DBBF881F15751D5F59B9592C3E18783E27824D4255FF00893DBB30C8435FB435
                F067C39B709FF0537FDAEEE0215127EC1BFF0004E3B70C062222DBF681FF0082
                A6308D067682A2E01202AF0E9D4631F79D0014514500145145007E72FF00C151
                FF00674F853FB4E7ECD1E10F875F17B45F10EB1E1C87F6B5FD88F53B16F09F89
                BC59E0EF11693A8EA1FB597C1FF04DE6A7A4F88BC137DA76A1A3C9FD95E2FF00
                125B1BCB7B98E4B44D45EEEDDA0BAB3B39A0F9CED3FE0DF7FF00825ADBE85E2D
                F0BCDF06BE326A3E1AF1EDFEABAA78E7C3FA8FEDA9FB6DCBA1F8CB54D74AB6BB
                A9F8AB4987E22476FE23B9BF31C7F689EF639DE6F2D7CC2FB457DF9FB6435AA7
                C21F0935DB04857F6A6FD85F69FB4C56604FFF000DB5FB3D8B31E6CAF12B032F
                903CADC4C9FEAD5642EA8DF555007E334DFF000401FF0082565C6B1A4F88AE3E
                017C4BB9D7F40B6BEB2D0F5BB9FDB2BF6DE9F55D1ECB53FB22EA565A65FCBF11
                DA5B082E56C6CD658627449059C41C388930C8FF00E0DF6FF824A4763AF69ADF
                B2CEA97761E2A9EE2EBC5369A8FED1FF00B566A90F89AEEF63860BFBEF10A6A3
                E39946B971711DBDA452DC5D0964952CA04919D608047FB3945007E2DDF7FC10
                07FE09993C9E1D7D3BE1C7C79F0D47E0A7BF93C0567E17FDB57F6CDD1B4EF87A
                DAA6989A2EA87C05A5DBF8F4DB784C5D5A29B7996C6180491B3238643B6A8F87
                BFE0DF9FF8271F87743F15E8B6FA2FED4575FF0009FDFF00F6A7C41D427FDB9F
                F6C5B3BAF1FDF8821D356EBC6967A1F8DACEC3C472AE9D6B6BA4F9D7364EE6CE
                D6288B129BEBF6CABF18FF00E0ACDFB735E7ECABADFECC3F0A9BF68CD0BF629F
                087C759FE38F8A3E207ED77E29F06784BC6B63F0F7C29F00BC01A778B13E1978
                1744F8850CFE1ED43C65E33BEF106916BA65AEA36DA8BC96BE1BD716CEC2FEF4
                D908803871FF0006FC7FC12ABC471787ADFC33E10F8DB65A67C2BD5A1D3FC21A
                4F84BF6E1FDADEE34BF865E20F0DD99D212D7C336B378EAED7C1B7D656B797D6
                7E55A9B77822D62E2355884ABB746CFF00E0DECFF827658F88AFFC5D6E9FB5A4
                7E29D5AC34ED2755F1247FB72FED696FAF6A7A6691F6B3A4E9FA86B36BE2E8AE
                AF2DED0DFDF9861926648FEDD36C54F35F77967FC12F3F6B1F09FECEFF000CBF
                E09ABFB187C77D5356F11FEDD7FF000513F05FC79FDB5BE27D90B1F0BE93AC78
                6F5BF89C9F107F6A5F1AF8C3E25685A325B0F0DC57D73ADDDF87F4BB38ECE200
                785AE6DD45B268AF12FF0042D401F8710FFC1BAFFF0004B45F067873C0177F0B
                FE3B6A9E11F096A1A6EADE19D02FFF006D2FDB18E89A06A9A3DD497BA46A1A27
                87AD3C75069DA2CF6B3CA668A6B3B3B768DD03A18D8B16B67FE0DE1FF825B36B
                2DE247F859F1D9BC4526910E8126BC7F6D9FDB48EB4FA1DB5D3DF5B68CFAA1F1
                FF009ED691CF24932DB190C6AEECE143124FEDE51401F87917FC1BA5FF000499
                B5F0B4BE08D2FE037C52D0FC257734175AB787746FDB13F6CDB0D0F5DBDB7D56
                0D760BFD6F458FE201B3BF9E3D42DA3D41656B7045CE661B6408CBD59FF8208F
                FC13725F11E8DE2FBAF05FED1D7DE28F0FD95F695A3F882F3F6EFF00DB966D6E
                C346D567D3AEB56D12CF57FF0085882EACECEEE4D274E69ADE09A1494D8C25C3
                186131FECC51401F91BFF04F0FD86BF66CFD877F69BFDBBFC35FB387C33BAF87
                DA4FC40B7FD993C51E23BDD5BC7FF133E25F883C59A8AE81F15A63A9EB1E28F8
                ABABEB5A95CB25E6ABE22C29BC6506EE563967609FAE55F2AFC3368CFED5FF00
                B512470470F93E02FD9A63768D998DC3FD97E2F4826914A22C4CA8F145B50B8D
                B6E872A58AA7D554005145140051451400578C7833F673F809F0DFE19F89BE0C
                FC38F839F0DFE1DFC28F194BE339FC51F0F3C03E10D13C17E12D6AE3E219BB3E
                36BABCD17C330DAC0D2EA62FAE56695515D95D541558E309ECF45007F38DFB16
                FF00C1067FE092DF113F62DFD973C5FE31FD8BBC07AB789BE26FECC1F02BC51E
                3BD6E3F177C53D26FBC47E22F14FC25F0CEA5AF6B376DA1EBF6CB6F3DC5C6A77
                F2EFB7487CB374DE50882A01F4A47FF06F7FFC12612C7C37A59FD9B3C6B3695E
                0D96C6E3C1FA55D7ED6DFB675E697E13B9D2ECA4D374AB9F0C69977F10DE0D02
                5B3B69A482096D2281E14919633182457DCDFF0004F98FCAFD833F6238F09FBB
                FD90BF66B43E598DA3053E0CF8297E46889465F9782A48200C64015F5FD007E2
                F695FF0006F87FC123F4496E6E74BFD95751B4BCBDB3B5B0BEBF5FDA33F6AB93
                51BFB3B042961697FA8CBE3969EFA3B70CEB124D2388FCC7D9B37BEE641FF06F
                57FC120AD749D3F40B6FD906DADB42D22F21BFD2B46B7F8E5FB4AC3A4E997D6F
                78DA85B5EE9FA6C5E3210D8CD1DC33CEB2C288CB2397043126BF6928A00FC39F
                17FF00C1083FE08A7E061FF0B13E227ECCBE07F0CC0975E1CF0C3F8C7C7FFB41
                7C76B0B16BCF12EBDA6785BC25E1BB8D63C51E3458269350D5359D1F4DB3B291
                D8CF77AA5A41023CD340ADD73FFC1BE5FF00047592C974D93F618F86F269C923
                4AB632F8ABE2B49662566DEF2FD9DFC40537B37CC5F6E49249249AFC7CF197C7
                1F8A3FB76FFC150BC23FB3CCDFB4178CBC5FE2FF00D9FBF6F9FDA03C6FAE7EC0
                B0787741F09FC0DF879F003F614F0F6A9E20FD9AFC7FF17BC54FE13BCD56F355
                F887F11ACBE13EA76FE207D6B52B7B3D3FC736D1DBE8F3BE9F083FB9FF00F04A
                2FF82896BBFF00051AF83BF16FC7BE30F84BE0AF823E32F839F1F7C71F0275CF
                00F857E31CDF162F1FFE109B7D1C45E30D62D754F0D785355F01C3AACD77A935
                8E9DAB6910CF359E9D6F7B944BD48ADC03CD2C3FE0DF1FF82356992A4F6BFB01
                7C183246004FB5DC78E75045DB9DAC22BFD6258F70CF0DB7236A631B1314F5BF
                F837BFFE090DABD8DF69BFF0C71A3E9BA15E8492EFC1BE14F8BFF1FF00C13E06
                BFB8864D3E749AE7C15E12F15D968ED2C874AB18E49CD8EF9111964322B303FB
                4745007E0DDFFF00C1B63FF047ED7F50B6F10EA9FB32F8F63D6126BAD42CDA4F
                DAB7F6B133E8136A5B24B9B4D29E0F1DBC7A72A3242BB2D5C27FA2C782CB1A57
                129FF0429FF82737ECB1FB497EC45F197F673F81FE24F067C4AD27F6B64D7AF7
                C45A9FC6BF8F3F11DAFA1D2BF67EF8EDE28BA9AEB45F891E2EBCD35E77BAF09F
                87E57BF92069D63D30AC62E77FD9AE3FA1AAF96FE3F7882DF43F8AFF00B0EE97
                25B4933F8BBF6A1F16787AD64899123B39AD7F62AFDAFBC546E2742016431785
                E7842AF3BAE10F446A00FA928A28A0028A28A002B87F899A4FF6EFC36F883A10
                B49EFF00FB67C0FE2BD24585A24CF7379FDA1A05FD98B4B68EDBF78D249E6EC5
                58FE6CB80BCE2BB8A2803F949F077EDF9FF05ABF831FB137EC8A3F67EFF822B6
                9FF16BC19A6FECBDF006D74CF88907ED67E06F14EA7AF585BFC1CF0ADCD8DF1F
                819E1FB0D3BC4BE1D33DB5A9636F34972D0CEDF656CC82D4DE7ED0FC17FDA6BF
                6D6D7FE13FC34F127C62FF00827678EBC39F10BC4DF0FF00C11E21F16786BE1D
                FC6EF807A8E9DE19F126B1A2DA5DF897C3D7F6BF123C41E1ABFD0EE2CAE1E541
                6623D4427CB13DDBBC5231FD15A2803F36F56F1178EEF3E21E9DF1813FE0941E
                20D4FE2F69765369BA6FC52D53C61FB1043F11749D385A5F695059697E38FF00
                84BAEB53B585AD2F2781A18EE23454BF9E2024466F33E38FD91BE02FED7DF00F
                E3CFC6AFDA5FE26FC17F8FDFB41FC54F89FE0AF06FC25D1359F1F78CBF60AF86
                9A9681F0A7C17E21F10F89341D1FC512FC079B4BB5F89DAD25D788E7371E26D5
                ADD6E5A1B3820B6B7B68D2449FF7AE8A00FCB5FDA7FF006B4FDBE7E15FC06F8A
                1F103E0D7FC136FC4BF11BE22784FC2F79AA783FC1ADF1A7E1B788A6D73518A7
                B58ADED57C2DE03B8B8D5B5F648E49A5363A6E6693ECA23898970C9F967F117F
                6B7FF82B87ED2BFB1CFC43F0CFED4DFF0004789BF679F0B6BF6FF0EDEFFE2869
                7FB587C2AF105CE9A34AF89DE15BABCD59BF67B96D6E3C4D6F1DB5CE8B0CC2C2
                E2E2469A0B852A5E25124DFD4B51400514514005145140051451401F017FC14E
                F4FF0015EA3FB1A78DE0F01F82E6F889E36B6F89FF00B2E6ABE0EF025B5FCBA4
                C9E2BF13E85FB557C14D6B41D08EAD05B5D9D1E3B8BAD3ED237BB36972B02334
                AF14C913A37E5BFC5DFF0082A77FC1687E1B7C4AF077C3F87FE080BE34D474AD
                7FC57E16D367F1D781BF6BBF07FC69F0C1F0EEB9AC1D1AE2ECDEF80BC2B6B69E
                0B92DCABCCF71AFDE58456D1DBACD7496D6D343703FA45A2803F3D4FED31FB6D
                2E161FF826778EB6AAA03E67ED49FB3145F30032B108F587DC806D196D872AC3
                680A859F07ED25FB70CEC231FF0004D7F12D92E11449A87ED57FB3BA41932451
                8CFF0066DD5D3AA22EF724464E230155CB7CBFA0F45007E7FDC7ED01FB7525B5
                BFD93FE09DB6935C34317DAA0B8FDAEBE12DADB432142248ADE78F4B99AE5548
                8C066861C8272A9B5437CBFF001774AFDBF7E20FC3AB3F037C15FD926FFF0063
                5D6B49F16E91E2AD2BC73F02FF006A7FD9AA09A67B3B2D52CAF742F13F83FC61
                F0EFC43A0F8AF48BB8353BB49ECAF749988996CAE616496D11A3FDA0A2803F22
                3F65BD23F6D3FD943F67FF00855FB397C3EFD847C1179E08F83BE0BD23C19E17
                D43C4FFB76E83AD789753B4B0CBCF7DE20BFD3FE1869B6CD732C93DDCACD6B63
                6F1167558E1B58F62C5F45695F19BF6F472DFDB7FB0B7C31B1845BB08068DFB6
                5E95AC5C7DAA36854457115F78074E8E081919CACB1CB2BE60C343186535F76D
                1401E0169F123E33C961199BF66ED76CF511147E65A9F899F0CE5B0490C88924
                70DFC37864915630CC19AD22C9555DAA0964FC97FDAFBF6EFF00F82C1FC1AFDA
                DF45F841FB337FC12374FF00DA87E076A1E01F0B6BE9F112C7F680D1BC070DCE
                BDAC6A9E218356D22FFE21789ECEDBC3FE0AB8B1834DD3E1974CBBB6BB68DF17
                0977776B7F638FDE7A2803F283F623F1C7ED2BF127F6C6FDA8FC65FB4E7ECBB0
                7ECA9E30B9FD90FF0060BD26CBC0DA7FC64F0DFC76D2EEE0B0F8B9FF00050DD4
                2FA683C79E12D334BB033DB4BAD25BC9651C2EF1AADBCC5B65E415FABF451400
                5145140051451401F15FFC14067F89965FB35C9A87C1BF87961F15BE25E91F1F
                3F638D6BC27F0F354D6CF85F4AF135EE89FB61FC06D56E2CB53F14ADADF0F09D
                AC76D65793CBAA9B1BD5B28ED1EE5ADEE96DDA293F2B3E22FEDB9FF0704E9BF1
                63E1E68DE0DFF82317C14D3BE136A9F123C1BE1CF16F88EFFF006D8F87FF0011
                AE23F096A5E2082C35DD4D752F0C7F635FF82625B232CDFDAD378475C8AC845E
                64B657E76DB37F44F45007C3575E3EFF00828FDB2E6DBF647FD8AAF53ED36B6E
                91C1FF000501F8D90CCB6F35D436CD76F1DCFECD91C689046E6774495DC25BBA
                C4B3C9E547272BA37C5FFF00829BDFDBEBB3DFFEC1DFB28E80748B269F4BB1BD
                FF00828678DAE6FBC4D7086FF6D868C348F807736D68CCB676803EA1736099D4
                A1059425C1B6FD0FA2803E0683E3AFEDE361E1617FAE7FC13FFC2B7BE298E79E
                23E18F87BFB61F817C41A735BABB8B39EDFC45E3AF0C78543068D213223D9446
                3690AA7DA1503B73927C61FDADBC7B0E99A6F8E7FE09851B5AD8EA5A76B16A9E
                31FDA4FF00675F1168FA56B1A74C8DA76AD651DA0BF9629ED5DBCD8EE23B4492
                3F2D8C78708ADFA3945007F3B9F12FF632F1A7C49FDB7FE147FC141A5FF8263F
                8F744FDA63E12EA9657D6DE30D17FE0A29A1787343F19E9163F0F35CF87BA178
                3FC45E10B17BCD3ECF49D2E1D6A4BBFECED26D74986F276B94D43FB5AD752D56
                0BEFD1887F681FDBFE49D623FF0004E9F0EDADA8B791CCF3FED9BF0DF2B3A6D5
                8EDE3B7B5F0E49B9593243964C1500800EE1FA1745007C0B3FC6CFF828025AEE
                B1FD827E184974265416F79FB6AE8F656FF65F2F224FB4DB7802E596452113CA
                116D1F310E42A6E8F4DF8CBFF0512BCBAB5B49FF0060FF00815A34134F05BBEA
                1A97EDD172D6163148761BAB94D1BE145E5C79510552C2DEDA6931F72390802B
                EFEA2803E30D47E24FEDD5A335B093F646F803E23B79D6556FF8417F6CAF125D
                DC58340B17942F60F1D7C25F0DC6A920765436D35C91E436F58818F77E5DFC5A
                FDB2BFE0BEBA2FED35E27F037C15FF008247FC13F881F00B45D2FC097561E2ED
                7FF6A8F067852E66B8D674C96E7C43143E3BD7351B08B5C31CF65796BE469DE0
                F91EC19606B8FB5C7736AF37F42745007E78FEC71ADFED0BE2AF8CBFB48789FF
                00692F815E1CF801E38D4BC23FB3A416BE11F077C50B9F8CBE17BAD2ED347F89
                323DF587C4197C31E158F529A1BABCBFB29EDA0B0B8481F4BDAB75728F1F97FA
                1D451400514514005145140051451401FCBEDBF88FFE0E3AF84BFB207ECADE12
                FD94BF649FF827EEAB6FE10FD997E05E853683E3DF899F15A4F8CB6171E16F87
                DE18D366F0D78B3C23F1153E1C691E0BD65A2B18ADAEAC1AFF00518ED264BC8B
                ED3BA385D7F52BE087C52FF82B8EBBF083E1D6B3F18FF62CFD86BC27F15F52F0
                8E8975E3EF0D0FDBBFE2E7879346F144B676E757B0FEC2F0AFC0FF001E69BA1F
                972F9E05A5878CFC530C415234D4F525513B7E9C51401F024DE3FF00F82A0A96
                5B5FD90BF60578951045E77FC145FF0068585B2237CAB245FB2CB84019615054
                9E0B1C2ED01A383C7FFF000547C3ACFF00B207EC030AAC5FB9F23FE0A33FB444
                FBA4551E5C6EAFFB2C44214CAA0DCBBF03A29C007EFF00A2803F357E24C3FF00
                0524F893F0F3C79E016FD9CBF63CF023F8FF00C27E21F06DE78CBE1E7FC146FF
                0068EF0B78F7C3765E20D2EE7437D7BC15E31D13F66CB4BDF0BEB36704E93D96
                A56F207B3B9B5B795049F6740DF2EFEC71FB24FEDFFF00B1E2FC55D5B46F87BF
                B397C5DF88FF001BBC49A0788FE297C63FDA07FE0A0FFB467C59F8A5E2E3E0EF
                0EDB7853C0FA1DE6B83E0168F6765A6E8D6114F05A59D9E9D6AB1FDB67663334
                B94FDCCA2803F3FAE35DFF0082A43C71FD8FE0FF00FC13FECE4C0DE93FED17FB
                44DFC483E60228DA2F8596A5B68F2977955CF944ED4DCA234B4F197FC152AC0A
                5ADDFECCBFF04FEF1246248CB6B169FB71FED13E072206E1E14F0CCBFB3C7884
                6F842A8590EAA049B87EEED827CDFA0545007E1E7ED97F1AFF00E0BEFE0AF067
                836F3F644FD83BF608F885E2DB9F1C5B5AF8A6C60FDAFF00C6FF0011FEC5E0B3
                A2F88259A6B8D0BE29784BE05DAE96B1DDAF87A217F63E24D6AE098DD469022B
                979F4EE53C1BA97FC15CBE24FC59FF00827F6B3FB6DFECC1FB35FC38F07F83FF
                006B1D4FC4DE29D5BF653F8B9F153E2178F3C2124FFB1AFED55E12D3752F1C78
                3F52F0C5CF87FC3BE13B9D4BC69A5E917BAAB78E2578A5BCB7B38EDEF4EAB692
                C7FBDD4500145145001451450014514500145145001451450014514500145145
                0014514500145145001451450014514500145145001451450014514500145145
                0014514500145145001451450014514500145145001451450014514500145145
                0014514500145145001451450014514500145145001451450014514500145145
                0014514500145145001451450014514500145145001451450014514500145145
                0014514500145145001451450014514500145145001451450014514500145145
                0014514500145145001451450014514500145145001451450014514500145145
                0014514500145145001451450014514500145145001451450014514500145145
                0014514500145145001451450014514500145145001451450014514500145145
                001451450014514500145145001451450014514500145145007C49FB62FEDCBE
                09FD8F66F857E1BB9F859F18BE3E7C57F8CB75E3A9FE1FFC14F809A3783B56F8
                89ABF833E12786E0F17FC5FF00886C7E20EB7E1CD1AC349F0E585EE869335C6A
                F14D3DE78AF46B2B586E25BF1E54DFB0A7ED3DE26FDA77F625F835FB5B7C4FF0
                841F0D64F8B9E05D67E2FDAF86ECF4DD610693F0B757D6FC41AD7C30D49AC6E2
                5BCBABD9EF3C22BE11D464920675B89752924B68A28A6B78A3C6FDB1BFE09EFF
                0007BF6D2D5BC03E29F1978DBE367C24F1EFC3AF0BFC50F87FA37C47FD9F3E20
                43F0D3C757DF0CFE33E93A4691F133E1BEB3AEBD85F9BAD27545F0FE833ED8A3
                82E6DA7D2229ACEE2CDDA632FD47F0F7E10FC3FF00863F077C0FF013C31E1FB5
                3F0B3E1EFC34F0CFC21F0F785B5844D6AC8FC3FF0009F85AC7C19A4F87F548F5
                0575D5A2FECDD3EDEDA459D5C4ABB83860EC0807CC3FB337FC14A3F62DFDB0BE
                21EB7F0A7F673F8C177F10BC75E1BF085FF8EB58D21FE167C63F06D9DAF85B4A
                D7F47F0AEA1A847E20F1EF87B4AD32F1E1D435CD36D0DADBDE4B3EE69B1115B5
                BA30F03FB5B7FC140BC3DFB307C78F0BFC38D49B4C6F07F80FF654FDA2FF006D
                BFDA5E55F0B78ABC4FE38B1F81FF0007EEFC13F0DBC0FE18F84FA6E8D3DA5ADD
                788FC49E2FF89161244D74D7F0A58FC34D66DA682CA6D6348BEB5F56FD9C7FE0
                9D1FB0AFEC85E34D57E237ECC3FB297C12F819E3BD73C2D77E08D5FC5BF0E3C1
                1A578735DBFF00086A1AB68BAEDF786EE350B3412359CD79E1CD02E5E0042B49
                A3DB3104C31EDF3DFDAB3F600F09FED3DF1D3C07F1435ABCB487C2FACFECEBFB
                42FEC77FB48F8605DEBBA2EB9F103F67BF8D90F85BC6DA1B7833C53A0CA93F85
                B5EF0D78CFE1A7846EED2E21FB37FA1F8C35E6371E6DB584338078C7ECA1FF00
                0521F891F1D7F689FDA23C0DF1EBE05DAFEC3BF0D7F67BF00FECD763A8F87BF6
                87F197C3C7F8A7E22F8C9FB4FEBBE36BFF008796565E2BF02F89F53F0C5869D3
                E85A1784AD5743957FB59B59F16B59E50D9F953FEAA78C3C67E0EF877E18D67C
                6BE3FF0015F867C0BE0CF0E599D43C43E2DF186BBA57863C31A0E9E8F1C4D7BA
                CEBDAD4B05A6970869225F367963505D4646467F26BC7FFF000474F81737C0BF
                885E04F044FAAFC45F8C5E3DFDA6BF67FF00DA927F8F5FB59789354F8F7F13AC
                3E22FC12F11FC22B0B6D5349F1FF008A2DEEB55F0EC89E0EF86DA97866D069CD
                6DE45B78A2F2D11E0B3BA9634FD80BFD3EC354B0BCD2F53B2B4D474CD46D2E34
                FD434EBFB686EEC2FAC2EE17B6BBB2BCB3B8568EEA196391E3789D59595D9482
                090403E60FD95FF6D4FD9AFF006CCF0EF89FC45FB3E7C55F0478F62F07F8E7E2
                5F81B5ED23C3FE37F02789F5CB0FF856DF153C71F09E2F174FA7F82F54D4C5AE
                85E239FC057FACE87A8CCF10D4349D5F4EBC5480DCBC50FC39FF00053BFF0082
                ABEB9FB07E8DF17346F857FB2DFC50FDA37C77F083F66697F692F895E21D0AEF
                C15A07C2AF827E0EF196A7F11FE1F7C11D6FE20DF78AB5AD22FF00C6435CF16F
                C38D7AD65D0BC2D1DE6A51E99E1BD5EF9501B6B58AEFF40FF670FD947E01FEC9
                BE1AF12F857E037C35F09FC3FD37C5FE3AF883F103C432787BC35E1BD0EF754D
                57E217C49F1C7C50B8D32EEE740B3B3373A6E9179F1075EB1D26CA5574D3F4F4
                B6B38711C3F3781FED25FF0004D2FD9D7F6A9F8B76DF177E28EB1F1A63BCBAD3
                7E08E87E3AF00784FE2FF8AFC37F093E2DF87BF676F8A1E21F8C1F093C3BF14B
                E1D5BC8F61E27B2D2F5CF17F8B2E040A96C245F125D890BB3A3C601F4AFC13F8
                CDE0CF89961AAF83A0F8B9F03BE23FC6AF8476FE1EF0AFED1BE1DF827E35D2BC
                4761F0DFE2ABE9F2DBF88740D57C3897D7BAB781237D4348F112DA586BBE55E0
                8B4D74977C96F395F9EFF69DFF008294FEC7BFB21FC65F80DF037E397C73F843
                E00F19FC6FF146B1A3CD078CFE2F7C2FF038F85BE17D33E15FC4EF88BA77C49F
                89565E2FD5ACAEB40D0755BCF86C9E17B1BF683CAB8D5BC59A75AA3979369F9C
                7FE09B1FB0D7C72FD987E2EFED27F13BE3D784FF0066FD2F50F891F62F09FC27
                B8FD9C7C75E313E13F077C19D17E277C59F88DE1EF8676DF07F5DF02786A0F08
                B457BF1475BD62FB5ABAF12F8CB51D4F54F11EA4D25CD959C3A6DB5BFE84FC57
                FD993E06FC6EF1BFC19F88BF13BE1DF86FC57E2FF80BE34D47C77F0E758D4F4A
                D3EEAE34FD5F54F86FF11FE16DD58EA2F7113B6AFA77F66FC52F13CEBA74E5A0
                5BD8AC2F5505CE9F68F1006DFC5BF8EBF0C7E097C08F88BFB4978DFC476C9F08
                3E177C2CF137C64F1278A34231EBB04FE02F09F85EEFC5F7DAA787D34E661AFB
                4F6364CF6B15AB39B969E048779963DDF913F05BFE0AF9A8EB3FB4FF00C57F01
                FED99E0AF86BFF0004E4F847F08BE0BFC18D6E5D37F697F8D5F08A0F1BF8D7E2
                77ED27AFF8D75DF8570E9FE2BD2B5F1A469B1D8F84BE14F8C2E753D052DEE2E6
                C2E65BC92E6E85969D0CF75FB21F177E137C3DF8F1F0AFE237C12F8B3E1AB7F1
                87C2FF008B5E07F13FC38F883E15B9BCD4B4D875FF0006F8C745BBF0FF008874
                91A9E873DADF692F35A5F5CA25DD8DCDADC40C525B796DE58A274FC71FDA63FE
                08E9A5EADFB397C61F84BFB306A5A36A7F12BF692875AD03E3C7C75FDAC7E287
                C76F1EFC71D73C3D79F03B57F837E1CBBF087C73D1350B8D6FC20BA6409E1AB4
                BAF0EDA5A43A66B7A336B1A2DEFD9ACF55BD5BB00FDB0F1778BFC25F0FBC2FAF
                78DFC79E28F0E7823C15E14D26F35DF1478BBC5DADE99E1AF0BF86B43D3606B8
                D4358D7B5FD66582D346B4B78A37924B8B89A28D150966500D7CA1FB207EDFDF
                B2CFEDBDA5F8BA6F809F193E1678D3C43E08F1DFC61F086BDE06F0AFC53F873E
                36F18D8683F0A7E3578E7E0DE93F12EEF42F05EA57D3D87877C58BE0CB4F10E8
                BA8CC91C779A5F8BF499D09FB520AFA77C37E0AB2D2BE1CE81F0EBC406CBC5DA
                7E9BE0AD2BC15ADB6A9A4592E9DE27B2B3D0ADF42D48EA3A0BF9D6EB05EC71CD
                E659B79B1EDB968CEF5EBE6BFB3BFECC7F06BF65AF0AF893C21F06BC21A5785F
                4BF167C49F8AFF001475D9AD349D0AC2FEFB5EF8BBF167C7BF18758D3A6B9D12
                CECC4DA7697A87C45D72C34BB4911FEC5A75B59DA233880BB807BFD15E09F13F
                F67CF0FF00C54D5B5BD6354F88BF1EBC252EBBF0EE0F86F358FC2FF8E7F12FE1
                9E91A769F6DE33D33C6F1F8A343D2BC1BA85A41A2F888CFA5C362DAF5BA4778F
                A75CDCE9CF2BD9DCCF13EB49F03BC2F2EAF36B0FE2BF8C9E64BE33F1778DBFB3
                E2F8E9F17ADB478AF3C6FE053E01D6B41834AB5D6A3863D160859F52D3F470A6
                D749D4D86A1A547A5DCC713C601EA7AC6B1A4787748D535FD7F54D3742D0742D
                36F758D6B5AD62F6D74BD2346D234BB592F751D5354D46F5A3834EB6B68209A6
                92799D123485998A2A123F3CFF0064DFF82AB7EC4BFB677C64F8D1F03BE06FC7
                FF00839E34F1B7C2DF1B0D03C27A5F85BE28F84BC4BA97C63F055A7C21F843F1
                1F5DF8A7F0FF0049D365F3B51D1B4ED4FE266B9E169A5805C85BDF86BAABEF54
                52B17DF5E0DF0BD97823C21E15F05E9DA8788F57D3FC23E1BD0FC2F61AAF8C7C
                4DAEF8D7C5DA9D9681A5DAE936BA878A7C65E28B8BBD4FC5BA94F1DA472DCEA7
                A8DD5CDD5D4D24B3DC4B34B2C8EDC8F80BE0DF80BE1AF8C3E36F8F3C27A5CB67
                E26FDA0FE22E87F14BE276A13DD4B76756F167873E107C2EF81BA3CB66936469
                96D0F87FE1078320169111189A2BBB80A24BDB82C01F1DFEDBDFF0507B7FD8F7
                C49E05F007857F671F8CBFB4F7C47F157C37F8B9F1CF5DF07FC20BAF879A1AFC
                3FF809F01A2F0B1F89FF0012FC53E22F899AC68DA7C66197C67E1DB2D3F49867
                92E351BABB36F1792E22F3BC97C29FB607ED3175FF000476D27FE0A0BE26D0FE
                1C59FC656FD9C7FE1B7356F01DAD86A71F84A4F83115CBFED0327C26D37CDB93
                7165AD5C7C328C786E0D4AEA7648759B98AF6E51A28A688FBAFEDB9FF04E3F81
                1FB79DBE863E29F89FE367C3FD5748F007C4EF8497FE23F80BF14B56F851AFF8
                C7E107C628BC347E21FC26F1E5E69314B1F8BFC3BA8DCF837C277AFA65E43246
                26D0D40C4375A84377F0278FFF00E08FDE3EF1078A3F69BB8F02FC42F08FC3ED
                0BF695D2BE287C00D5AFA2F15FC51D76F7C3BFB1AFC48F86DFB1EFC20B6F869A
                4F82EF4269105F683E1DF83DF1DADB4A81255B7B1BAF1D6937B15C895EF56D00
                3F547E2A7ED1B0685F0D7E0FEB9F0B74FB0F14FC40FDA4BC43F0F7C29F027C2B
                AFB5DE9D1EA6FE38B18BC57E20F186B96B683CD5D3BC21E0FB1F19F8CB51B413
                D9BDC5B78127D3ADEE60BED4B4EDFF0022FEDF9FF0551D07F618F1A4BE07B7FD
                9DBE28FC78BCF0AFC13B6FDA33E2F6ABE05F137C33F0B68BF0AFE0F5FF00C57D
                0FE0EE87A95F3F8E354B3B9F12EB1AC6AFA86A96DA5E85A6DACB35F49A04E88F
                1C715ECD63F7EE9DF027E1D693E3FF0087FF001174FD36EADF55F855F0A759F8
                35F0E7495BC66F0DF83BC17E22D47C1D7FAEC7A3694EA4C37774BF0FFC1968F7
                6F23B8B7F0FC512796B2DCF9FE71F133F630FD9F3E2FF88FE27F8A3C7DE0FB9D
                6B51F8C761FB30695F11626D6F55834FF1169BFB207C5EF137C70F82561358C3
                2AA5BC367AF78BB5C92EA2844697905D7913ABA6EDC01F54D145140051451400
                5145140051451400514514005145140051451400514514005145140051451400
                5145140051451400514514005145140051451400514514005145140051451400
                5145140051451400514514005145140051451400514514005145140051451400
                5145140051451400514514005145140051451400514514005145140051451400
                5145140051451400514514005145140051451400514514005145140051451401
                FFD9}
              Stretch = True
            end
          end
        end
        object GroupBox18: TGroupBox
          Left = 504
          Top = 8
          Width = 266
          Height = 180
          Caption = 'Valori calcolati (parte finestrata)'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clHotLight
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 2
          object Label24: TLabel
            Left = 9
            Top = 27
            Width = 99
            Height = 14
            AutoSize = False
            Caption = 'Ag - Area del vetro'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
          end
          object Label54: TLabel
            Left = 181
            Top = 27
            Width = 18
            Height = 14
            AutoSize = False
            Caption = '[m'#178']'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
          end
          object Label55: TLabel
            Left = 9
            Top = 55
            Width = 97
            Height = 14
            AutoSize = False
            Caption = 'Af - Area del telaio'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
          end
          object Label56: TLabel
            Left = 181
            Top = 55
            Width = 18
            Height = 14
            AutoSize = False
            Caption = '[m'#178']'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
          end
          object Label57: TLabel
            Left = 9
            Top = 83
            Width = 101
            Height = 14
            AutoSize = False
            Caption = 'Lg - Perimetro vetro'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
          end
          object Label58: TLabel
            Left = 181
            Top = 83
            Width = 14
            Height = 14
            AutoSize = False
            Caption = '[m]'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
          end
          object Label41: TLabel
            Left = 9
            Top = 111
            Width = 118
            Height = 14
            Caption = 'Uw - Trasmittanza totale'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
          end
          object Label42: TLabel
            Left = 181
            Top = 111
            Width = 42
            Height = 14
            AutoSize = False
            Caption = '[W/m'#178#176'C]'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
          end
          object Label70: TLabel
            Left = 9
            Top = 139
            Width = 94
            Height = 14
            Caption = 'Percentuale vetrata'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
          end
          object Label71: TLabel
            Left = 181
            Top = 139
            Width = 49
            Height = 14
            Caption = '[0..100] %'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
          end
          object DBEdit24: TDBEdit
            Tag = 29
            Left = 134
            Top = 23
            Width = 40
            Height = 22
            BevelKind = bkFlat
            BorderStyle = bsNone
            Color = cl3DLight
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            ReadOnly = True
            TabOrder = 0
          end
          object DBEdit25: TDBEdit
            Tag = 30
            Left = 134
            Top = 51
            Width = 40
            Height = 22
            BevelKind = bkFlat
            BorderStyle = bsNone
            Color = cl3DLight
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            ReadOnly = True
            TabOrder = 1
          end
          object DBEdit26: TDBEdit
            Tag = 31
            Left = 134
            Top = 79
            Width = 40
            Height = 22
            BevelKind = bkFlat
            BorderStyle = bsNone
            Color = cl3DLight
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            ReadOnly = True
            TabOrder = 2
          end
          object DBEdit21: TDBEdit
            Tag = 33
            Left = 134
            Top = 107
            Width = 40
            Height = 22
            BevelKind = bkFlat
            BorderStyle = bsNone
            Color = cl3DLight
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            ReadOnly = True
            TabOrder = 3
          end
          object DBEdit32: TDBEdit
            Tag = 15
            Left = 134
            Top = 135
            Width = 40
            Height = 22
            BevelKind = bkFlat
            BorderStyle = bsNone
            Color = cl3DLight
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            ReadOnly = True
            TabOrder = 4
          end
        end
        object GroupBox19: TGroupBox
          Left = 504
          Top = 190
          Width = 266
          Height = 63
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 3
          object Label101: TLabel
            Left = 222
            Top = 17
            Width = 16
            Height = 14
            AutoSize = False
            Caption = '[%]'
          end
          object Label30: TLabel
            Left = 9
            Top = 17
            Width = 133
            Height = 15
            AutoSize = False
            Caption = 'Incremento di Sicurezza'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object Label161: TLabel
            Left = 9
            Top = 42
            Width = 170
            Height = 14
            Caption = 'Nota: non applicato per la Legge 10'
          end
          object DBEdit42: TDBEdit
            Tag = 42
            Left = 155
            Top = 13
            Width = 40
            Height = 22
            BevelKind = bkFlat
            BorderStyle = bsNone
            TabOrder = 0
            OnChange = DBEdit42Change
          end
          object RxSpinButton3: TSpinButton
            Left = 198
            Top = 13
            Width = 20
            Height = 22
            DownGlyph.Data = {
              56000000424D56000000000000003E0000002800000006000000060000000100
              010000000000180000000000000000000000020000000200000000000000FFFF
              FF00CC0000008400000000000000CC000000CC000000CC000000}
            FocusControl = DBEdit42
            TabOrder = 1
            UpGlyph.Data = {
              56000000424D56000000000000003E0000002800000006000000060000000100
              010000000000180000000000000000000000020000000200000000000000FFFF
              FF00CC000000CC000000CC0000000000000084000000CC000000}
            OnDownClick = RxSpinButton1DownClick
            OnUpClick = RxSpinButton1UpClick
          end
        end
        object GroupBox11: TGroupBox
          Left = 0
          Top = 8
          Width = 503
          Height = 180
          Caption = ' Caratteristiche termiche della parte finestrata '
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clHotLight
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 1
          object Label29: TLabel
            Left = 10
            Top = 42
            Width = 65
            Height = 14
            AutoSize = False
            Caption = 'Tipo di vetro'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
          end
          object Label59: TLabel
            Left = 271
            Top = 27
            Width = 119
            Height = 14
            AutoSize = False
            Caption = 'Kg - Trasmittanza vetro'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
          end
          object Label60: TLabel
            Left = 452
            Top = 27
            Width = 42
            Height = 14
            AutoSize = False
            Caption = '[W/m'#178#176'C]'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
          end
          object Label153: TLabel
            Left = 271
            Top = 55
            Width = 134
            Height = 14
            AutoSize = False
            Caption = 'Kg L10 - Trasmittanza vetro'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
          end
          object Label154: TLabel
            Left = 452
            Top = 55
            Width = 42
            Height = 14
            AutoSize = False
            Caption = '[W/m'#178#176'C]'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
          end
          object Label63: TLabel
            Left = 10
            Top = 94
            Width = 166
            Height = 31
            AutoSize = False
            Caption = 
              'Ki - Trasmittanza lineica del separatore dei vetri (vetro doppio' +
              ')'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            WordWrap = True
          end
          object SpeedButton3: TSpeedButton
            Left = 245
            Top = 98
            Width = 23
            Height = 23
            Glyph.Data = {
              36100000424D3610000000000000360000002800000020000000200000000100
              2000000000000010000000000000000000000000000000000000D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00000000000000
              0000000000000000000000000000D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC000000000000000000000000000000000000000000D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC0000000000FFFF
              FF00000000000000000000000000D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC0000000000FFFFFF00000000000000000000000000D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC0000000000FFFF
              FF00000000000000000000000000D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC0000000000FFFFFF00000000000000000000000000D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00000000000000
              00000000000000000000000000000000000000000000D8E9EC00000000000000
              00000000000000000000000000000000000000000000D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00000000000000
              0000FFFFFF00000000000000000000000000000000000000000000000000FFFF
              FF000000000000000000000000000000000000000000D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00000000000000
              0000FFFFFF00000000000000000000000000C0C0C0000000000000000000FFFF
              FF000000000000000000000000000000000000000000D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00000000000000
              0000FFFFFF00000000000000000000000000C0C0C0000000000000000000FFFF
              FF000000000000000000000000000000000000000000D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC000000
              0000000000000000000000000000000000000000000000000000000000000000
              000000000000000000000000000000000000D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC0000000000FFFFFF00000000000000000000000000D8E9EC0000000000FFFF
              FF00000000000000000000000000D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC000000000000000000000000000000000000000000D8E9EC00000000000000
              0000000000000000000000000000D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00000000000000000000000000D8E9EC00D8E9EC00D8E9EC000000
              00000000000000000000D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC0000000000FFFFFF0000000000D8E9EC00D8E9EC00D8E9EC000000
              0000FFFFFF0000000000D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00000000000000000000000000D8E9EC00D8E9EC00D8E9EC000000
              00000000000000000000D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00}
            OnClick = SpeedButton3Click
          end
          object Label64: TLabel
            Left = 274
            Top = 102
            Width = 38
            Height = 14
            AutoSize = False
            Caption = '[W/m'#176'C]'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
          end
          object Label102: TLabel
            Left = 6
            Top = 202
            Width = 167
            Height = 14
            AutoSize = False
            Caption = 'Resistenza termica della tapparella'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            Visible = False
          end
          object SpeedButton4: TSpeedButton
            Left = 245
            Top = 202
            Width = 23
            Height = 23
            Glyph.Data = {
              36100000424D3610000000000000360000002800000020000000200000000100
              2000000000000010000000000000000000000000000000000000D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00000000000000
              0000000000000000000000000000D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC000000000000000000000000000000000000000000D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC0000000000FFFF
              FF00000000000000000000000000D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC0000000000FFFFFF00000000000000000000000000D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC0000000000FFFF
              FF00000000000000000000000000D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC0000000000FFFFFF00000000000000000000000000D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00000000000000
              00000000000000000000000000000000000000000000D8E9EC00000000000000
              00000000000000000000000000000000000000000000D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00000000000000
              0000FFFFFF00000000000000000000000000000000000000000000000000FFFF
              FF000000000000000000000000000000000000000000D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00000000000000
              0000FFFFFF00000000000000000000000000C0C0C0000000000000000000FFFF
              FF000000000000000000000000000000000000000000D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00000000000000
              0000FFFFFF00000000000000000000000000C0C0C0000000000000000000FFFF
              FF000000000000000000000000000000000000000000D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC000000
              0000000000000000000000000000000000000000000000000000000000000000
              000000000000000000000000000000000000D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC0000000000FFFFFF00000000000000000000000000D8E9EC0000000000FFFF
              FF00000000000000000000000000D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC000000000000000000000000000000000000000000D8E9EC00000000000000
              0000000000000000000000000000D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00000000000000000000000000D8E9EC00D8E9EC00D8E9EC000000
              00000000000000000000D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC0000000000FFFFFF0000000000D8E9EC00D8E9EC00D8E9EC000000
              0000FFFFFF0000000000D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00000000000000000000000000D8E9EC00D8E9EC00D8E9EC000000
              00000000000000000000D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00}
            Visible = False
            OnClick = SpeedButton4Click
          end
          object Label103: TLabel
            Left = 269
            Top = 202
            Width = 42
            Height = 14
            AutoSize = False
            Caption = '[m'#178#176'C/W]'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            Visible = False
          end
          object Label104: TLabel
            Left = 41
            Top = 227
            Width = 132
            Height = 14
            AutoSize = False
            Caption = 'Permeabilit'#224' del serramento'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            Visible = False
          end
          object SpeedButton5: TSpeedButton
            Left = 245
            Top = 227
            Width = 23
            Height = 22
            Glyph.Data = {
              36100000424D3610000000000000360000002800000020000000200000000100
              2000000000000010000000000000000000000000000000000000D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00000000000000
              0000000000000000000000000000D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC000000000000000000000000000000000000000000D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC0000000000FFFF
              FF00000000000000000000000000D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC0000000000FFFFFF00000000000000000000000000D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC0000000000FFFF
              FF00000000000000000000000000D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC0000000000FFFFFF00000000000000000000000000D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00000000000000
              00000000000000000000000000000000000000000000D8E9EC00000000000000
              00000000000000000000000000000000000000000000D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00000000000000
              0000FFFFFF00000000000000000000000000000000000000000000000000FFFF
              FF000000000000000000000000000000000000000000D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00000000000000
              0000FFFFFF00000000000000000000000000C0C0C0000000000000000000FFFF
              FF000000000000000000000000000000000000000000D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00000000000000
              0000FFFFFF00000000000000000000000000C0C0C0000000000000000000FFFF
              FF000000000000000000000000000000000000000000D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC000000
              0000000000000000000000000000000000000000000000000000000000000000
              000000000000000000000000000000000000D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC0000000000FFFFFF00000000000000000000000000D8E9EC0000000000FFFF
              FF00000000000000000000000000D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC000000000000000000000000000000000000000000D8E9EC00000000000000
              0000000000000000000000000000D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00000000000000000000000000D8E9EC00D8E9EC00D8E9EC000000
              00000000000000000000D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC0000000000FFFFFF0000000000D8E9EC00D8E9EC00D8E9EC000000
              0000FFFFFF0000000000D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00000000000000000000000000D8E9EC00D8E9EC00D8E9EC000000
              00000000000000000000D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00}
            Visible = False
            OnClick = SpeedButton5Click
          end
          object Label105: TLabel
            Left = 269
            Top = 227
            Width = 42
            Height = 14
            AutoSize = False
            Caption = '[m'#179'/h m'#178']'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            Visible = False
          end
          object Label106: TLabel
            Left = 42
            Top = 253
            Width = 131
            Height = 14
            Caption = 'Permeabilit'#224' del cassonetto'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            Visible = False
          end
          object SpeedButton6: TSpeedButton
            Left = 245
            Top = 253
            Width = 23
            Height = 23
            Glyph.Data = {
              36100000424D3610000000000000360000002800000020000000200000000100
              2000000000000010000000000000000000000000000000000000D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00000000000000
              0000000000000000000000000000D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC000000000000000000000000000000000000000000D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC0000000000FFFF
              FF00000000000000000000000000D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC0000000000FFFFFF00000000000000000000000000D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC0000000000FFFF
              FF00000000000000000000000000D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC0000000000FFFFFF00000000000000000000000000D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00000000000000
              00000000000000000000000000000000000000000000D8E9EC00000000000000
              00000000000000000000000000000000000000000000D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00000000000000
              0000FFFFFF00000000000000000000000000000000000000000000000000FFFF
              FF000000000000000000000000000000000000000000D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00000000000000
              0000FFFFFF00000000000000000000000000C0C0C0000000000000000000FFFF
              FF000000000000000000000000000000000000000000D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00000000000000
              0000FFFFFF00000000000000000000000000C0C0C0000000000000000000FFFF
              FF000000000000000000000000000000000000000000D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC000000
              0000000000000000000000000000000000000000000000000000000000000000
              000000000000000000000000000000000000D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC0000000000FFFFFF00000000000000000000000000D8E9EC0000000000FFFF
              FF00000000000000000000000000D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC000000000000000000000000000000000000000000D8E9EC00000000000000
              0000000000000000000000000000D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00000000000000000000000000D8E9EC00D8E9EC00D8E9EC000000
              00000000000000000000D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC0000000000FFFFFF0000000000D8E9EC00D8E9EC00D8E9EC000000
              0000FFFFFF0000000000D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00000000000000000000000000D8E9EC00D8E9EC00D8E9EC000000
              00000000000000000000D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00}
            Visible = False
            OnClick = SpeedButton6Click
          end
          object Label107: TLabel
            Left = 269
            Top = 253
            Width = 42
            Height = 14
            AutoSize = False
            Caption = '[m'#179'/h m'#178']'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            Visible = False
          end
          object Label108: TLabel
            Left = 45
            Top = 279
            Width = 128
            Height = 14
            AutoSize = False
            Caption = 'Lunghezza del cassonetto'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            Visible = False
          end
          object Label109: TLabel
            Left = 224
            Top = 279
            Width = 42
            Height = 14
            AutoSize = False
            Caption = '[m]'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            Visible = False
          end
          object Label61: TLabel
            Left = 10
            Top = 133
            Width = 117
            Height = 14
            AutoSize = False
            Caption = 'Kf - Trasmittanza telaio'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
          end
          object SpeedButton2: TSpeedButton
            Left = 245
            Top = 129
            Width = 23
            Height = 23
            Glyph.Data = {
              36100000424D3610000000000000360000002800000020000000200000000100
              2000000000000010000000000000000000000000000000000000D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00000000000000
              0000000000000000000000000000D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC000000000000000000000000000000000000000000D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC0000000000FFFF
              FF00000000000000000000000000D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC0000000000FFFFFF00000000000000000000000000D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC0000000000FFFF
              FF00000000000000000000000000D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC0000000000FFFFFF00000000000000000000000000D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00000000000000
              00000000000000000000000000000000000000000000D8E9EC00000000000000
              00000000000000000000000000000000000000000000D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00000000000000
              0000FFFFFF00000000000000000000000000000000000000000000000000FFFF
              FF000000000000000000000000000000000000000000D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00000000000000
              0000FFFFFF00000000000000000000000000C0C0C0000000000000000000FFFF
              FF000000000000000000000000000000000000000000D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00000000000000
              0000FFFFFF00000000000000000000000000C0C0C0000000000000000000FFFF
              FF000000000000000000000000000000000000000000D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC000000
              0000000000000000000000000000000000000000000000000000000000000000
              000000000000000000000000000000000000D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC0000000000FFFFFF00000000000000000000000000D8E9EC0000000000FFFF
              FF00000000000000000000000000D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC000000000000000000000000000000000000000000D8E9EC00000000000000
              0000000000000000000000000000D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00000000000000000000000000D8E9EC00D8E9EC00D8E9EC000000
              00000000000000000000D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC0000000000FFFFFF0000000000D8E9EC00D8E9EC00D8E9EC000000
              0000FFFFFF0000000000D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00000000000000000000000000D8E9EC00D8E9EC00D8E9EC000000
              00000000000000000000D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
              EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00}
            OnClick = SpeedButton2Click
          end
          object Label62: TLabel
            Left = 274
            Top = 133
            Width = 42
            Height = 14
            AutoSize = False
            Caption = '[W/m'#178#176'C]'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
          end
          object DBComboBox5: TDBComboBox
            Tag = 18
            Left = 82
            Top = 38
            Width = 176
            Height = 22
            Style = csDropDownList
            BevelKind = bkFlat
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ItemHeight = 14
            ParentFont = False
            TabOrder = 0
            OnChange = DBComboBox5Change
          end
          object DBEdit27: TDBEdit
            Tag = 32
            Left = 408
            Top = 23
            Width = 40
            Height = 22
            BevelKind = bkFlat
            BorderStyle = bsNone
            Color = cl3DLight
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            ReadOnly = True
            TabOrder = 1
          end
          object DBEdit38: TDBEdit
            Tag = 37
            Left = 408
            Top = 51
            Width = 40
            Height = 22
            BevelKind = bkFlat
            BorderStyle = bsNone
            Color = cl3DLight
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            ReadOnly = True
            TabOrder = 2
          end
          object DBEdit29: TDBEdit
            Tag = 25
            Left = 180
            Top = 98
            Width = 40
            Height = 22
            BevelKind = bkFlat
            BorderStyle = bsNone
            Color = clWhite
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            TabOrder = 3
            OnChange = DBEdit29Change
          end
          object RxSpinButton2: TSpinButton
            Left = 223
            Top = 98
            Width = 20
            Height = 22
            DownGlyph.Data = {
              56000000424D56000000000000003E0000002800000006000000060000000100
              010000000000180000000000000000000000020000000200000000000000FFFF
              FF00CC0000008400000000000000CC000000CC000000CC000000}
            FocusControl = DBEdit29
            TabOrder = 4
            UpGlyph.Data = {
              56000000424D56000000000000003E0000002800000006000000060000000100
              010000000000180000000000000000000000020000000200000000000000FFFF
              FF00CC000000CC000000CC0000000000000084000000CC000000}
            OnDownClick = RxSpinButton1DownClick
            OnUpClick = RxSpinButton1UpClick
          end
          object DBEdit43: TDBEdit
            Tag = 43
            Left = 174
            Top = 202
            Width = 49
            Height = 22
            Color = clWhite
            TabOrder = 7
            Visible = False
          end
          object RxSpinButton4: TSpinButton
            Left = 224
            Top = 202
            Width = 20
            Height = 22
            DownGlyph.Data = {
              56000000424D56000000000000003E0000002800000006000000060000000100
              010000000000180000000000000000000000020000000200000000000000FFFF
              FF00CC0000008400000000000000CC000000CC000000CC000000}
            FocusControl = DBEdit43
            TabOrder = 9
            UpGlyph.Data = {
              56000000424D56000000000000003E0000002800000006000000060000000100
              010000000000180000000000000000000000020000000200000000000000FFFF
              FF00CC000000CC000000CC0000000000000084000000CC000000}
            Visible = False
            OnDownClick = RxSpinButton1DownClick
            OnUpClick = RxSpinButton1UpClick
          end
          object DBEdit44: TDBEdit
            Tag = 44
            Left = 174
            Top = 227
            Width = 49
            Height = 22
            Color = clWhite
            TabOrder = 8
            Visible = False
          end
          object RxSpinButton5: TSpinButton
            Left = 224
            Top = 227
            Width = 20
            Height = 22
            DownGlyph.Data = {
              56000000424D56000000000000003E0000002800000006000000060000000100
              010000000000180000000000000000000000020000000200000000000000FFFF
              FF00CC0000008400000000000000CC000000CC000000CC000000}
            FocusControl = DBEdit44
            TabOrder = 10
            UpGlyph.Data = {
              56000000424D56000000000000003E0000002800000006000000060000000100
              010000000000180000000000000000000000020000000200000000000000FFFF
              FF00CC000000CC000000CC0000000000000084000000CC000000}
            Visible = False
            OnDownClick = RxSpinButton1DownClick
            OnUpClick = RxSpinButton1UpClick
          end
          object DBEdit45: TDBEdit
            Tag = 45
            Left = 174
            Top = 253
            Width = 49
            Height = 22
            Color = clWhite
            TabOrder = 11
            Visible = False
          end
          object RxSpinButton6: TSpinButton
            Left = 224
            Top = 253
            Width = 20
            Height = 22
            DownGlyph.Data = {
              56000000424D56000000000000003E0000002800000006000000060000000100
              010000000000180000000000000000000000020000000200000000000000FFFF
              FF00CC0000008400000000000000CC000000CC000000CC000000}
            FocusControl = DBEdit45
            TabOrder = 12
            UpGlyph.Data = {
              56000000424D56000000000000003E0000002800000006000000060000000100
              010000000000180000000000000000000000020000000200000000000000FFFF
              FF00CC000000CC000000CC0000000000000084000000CC000000}
            Visible = False
            OnDownClick = RxSpinButton1DownClick
            OnUpClick = RxSpinButton1UpClick
          end
          object DBEdit46: TDBEdit
            Tag = 46
            Left = 174
            Top = 279
            Width = 49
            Height = 22
            Color = clWhite
            TabOrder = 13
            Visible = False
          end
          object DBEdit28: TDBEdit
            Tag = 26
            Left = 180
            Top = 129
            Width = 40
            Height = 22
            BevelKind = bkFlat
            BorderStyle = bsNone
            Color = clWhite
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            TabOrder = 5
            OnChange = DBEdit28Change
          end
          object RxSpinButton1: TSpinButton
            Left = 223
            Top = 129
            Width = 20
            Height = 22
            DownGlyph.Data = {
              56000000424D56000000000000003E0000002800000006000000060000000100
              010000000000180000000000000000000000020000000200000000000000FFFF
              FF00CC0000008400000000000000CC000000CC000000CC000000}
            FocusControl = DBEdit28
            TabOrder = 6
            UpGlyph.Data = {
              56000000424D56000000000000003E0000002800000006000000060000000100
              010000000000180000000000000000000000020000000200000000000000FFFF
              FF00CC000000CC000000CC0000000000000084000000CC000000}
            OnDownClick = RxSpinButton1DownClick
            OnUpClick = RxSpinButton1UpClick
          end
        end
      end
      object TabSheetElementiDisponibili: TTabSheet
        Caption = 'Solari'
        object GroupBox1: TGroupBox
          Left = 0
          Top = 0
          Width = 771
          Height = 495
          Align = alTop
          Caption = 'Sezione Solari'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 0
          object GroupBox23: TGroupBox
            Left = 8
            Top = 183
            Width = 657
            Height = 225
            Caption = 'Dati Aggetti'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clHotLight
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            TabOrder = 1
            object Bevel2: TBevel
              Left = 12
              Top = 85
              Width = 275
              Height = 64
            end
            object Bevel1: TBevel
              Left = 12
              Top = 19
              Width = 275
              Height = 64
            end
            object Bevel3: TBevel
              Left = 12
              Top = 151
              Width = 275
              Height = 64
            end
            object Label113: TLabel
              Left = 193
              Top = 44
              Width = 82
              Height = 14
              Caption = 'Verticale Sinistro'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
            end
            object Label114: TLabel
              Left = 20
              Top = 30
              Width = 66
              Height = 14
              Caption = 'Profondit'#224' (d)'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
            end
            object Label115: TLabel
              Left = 193
              Top = 110
              Width = 78
              Height = 14
              Caption = 'Verticale Destro'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
            end
            object Label116: TLabel
              Left = 20
              Top = 59
              Width = 59
              Height = 14
              Caption = 'Distanza (c)'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
            end
            object Label117: TLabel
              Left = 154
              Top = 30
              Width = 14
              Height = 14
              AutoSize = False
              Caption = '[m]'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
            end
            object Label118: TLabel
              Left = 154
              Top = 59
              Width = 14
              Height = 14
              AutoSize = False
              Caption = '[m]'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
            end
            object Label119: TLabel
              Left = 20
              Top = 97
              Width = 66
              Height = 14
              Caption = 'Profondit'#224' (d)'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
            end
            object Label120: TLabel
              Left = 20
              Top = 125
              Width = 59
              Height = 14
              Caption = 'Distanza (c)'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
            end
            object Label121: TLabel
              Left = 154
              Top = 97
              Width = 14
              Height = 14
              AutoSize = False
              Caption = '[m]'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
            end
            object Label122: TLabel
              Left = 154
              Top = 125
              Width = 14
              Height = 14
              AutoSize = False
              Caption = '[m]'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
            end
            object Label123: TLabel
              Left = 193
              Top = 176
              Width = 35
              Height = 14
              Caption = 'Balconi'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
            end
            object Label124: TLabel
              Left = 20
              Top = 163
              Width = 66
              Height = 14
              Caption = 'Profondit'#224' (b)'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
            end
            object Label125: TLabel
              Left = 20
              Top = 191
              Width = 59
              Height = 14
              Caption = 'Distanza (d)'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
            end
            object Label126: TLabel
              Left = 154
              Top = 163
              Width = 14
              Height = 14
              AutoSize = False
              Caption = '[m]'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
            end
            object Label127: TLabel
              Left = 154
              Top = 191
              Width = 14
              Height = 14
              AutoSize = False
              Caption = '[m]'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
            end
            object Image6: TImage
              Left = 305
              Top = 23
              Width = 190
              Height = 189
              Picture.Data = {
                07544269746D617082A60100424D82A60100000000003600000028000000BE00
                0000BD00000001001800000000004CA60100130B0000130B0000000000000000
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
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
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
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
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
                FFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
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
                FFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
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
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
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
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
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
                FFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
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
                FFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
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
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
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
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
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
                FFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
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
                FFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
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
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
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
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
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
                FFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
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
                FFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
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
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
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
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
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
                FFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
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
                FFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
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
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFB86D60962512911B07A74939E8D0CCFFFFFFB86D60962512911B07A7
                4939E8D0CCFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
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
                FFFFFFFFFFFFFFFFFFD3A59DA54535FFFFFFFFFFFFFFFFFFFFFFFFD3A59DA545
                35FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFDFBFBA03B2AF8F0EFFFFFFFFFFFFFFFFFFFF8F0EFA03B2AFDFBFBF1E2DFA7
                49399D3422DCB7B1911B07FFFFFFF1E2DFA749399D3422DCB7B1911B07FFFFFF
                EDDBD8AA5041911B07A23E2DEDDBD8FFFFFFAE5749921E0AFFFFFFAE5749921E
                0AFFFFFF911B07FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFBF7F7A54535FB
                F7F7FFFFFFFFFFFFFFFFFFEDDBD8AA5041911B07A23E2DEDDBD8FFFFFF911B07
                FFFFFFFFFFFFFFFFFFAE5749921E0AFFFFFF911B07FFFFFFF1E2DFAC5445911B
                07A23E2DE5C9C4FFFFFFD09E95962512972916CB938A911B07FFFFFF911B07FF
                FFFF911B07FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
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
                C17F73CC978EFFFFFFFFFFFFFFFFFFCB938AC17F73FFFFFFB15E50C99086F2E5
                E3AA5041911B07FFFFFFB15E50C99086F2E5E3AA5041911B07FFFFFFAE5749C6
                897FFFFFFFD5A9A1A74939FFFFFF911B07F8F0EFFFFFFF911B07F8F0EFFFFFFF
                911B07FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFD5A9A1C17F73D3A59DFFFF
                FFFFFFFFFFFFFFAE5749C6897FFFFFFFD5A9A1A74939FFFFFF911B07FFFFFFFF
                FFFFFFFFFF911B07F8F0EFFFFFFF911B07FFFFFFB05B4DC99086FDFBFBDEBBB5
                A23E2DFFFFFF94220EECD7D4F8F0EFBA7064911B07FFFFFF911B07FFFFFF911B
                07FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFE8D0CC91
                1B07911B07911B07911B07911B07E8D0CCFFFFFF94220EFBF7F7FFFFFFF9F4F3
                911B07FFFFFF94220EFBF7F7FFFFFFF9F4F3911B07FFFFFF921E0AF8F0EFFFFF
                FFFFFFFFFFFFFFFFFFFF911B07FFFFFFFFFFFF911B07FFFFFFFFFFFF911B07FF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFB15E50FDFBFBB86D60FFFFFFFFFFFF
                FFFFFF921E0AF8F0EFFFFFFFFFFFFFFFFFFFFFFFFF911B07FFFFFFFFFFFFFFFF
                FF911B07FFFFFFFFFFFF911B07FFFFFF94220EFBF7F7FFFFFFFFFFFFFFFFFFFF
                FFFFA74939D3A59DE3C5C0EFDEDB911B07FFFFFF911B07FFFFFF911B07FFFFFF
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
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFA34231E1C2
                BCFFFFFFE1C2BCA34231FFFFFFFFFFFF94220EFBF7F7FFFFFFF9F4F3911B07FF
                FFFF94220EFBF7F7FFFFFFF9F4F3911B07FFFFFF94220E911B07911B07911B07
                911B07FFFFFF911B07FFFFFFFFFFFF911B07FFFFFFFFFFFF911B07FFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFE1C2BCC78C82FFFFFFD2A299DEBBB5FFFFFFFFFFFF94
                220E911B07911B07911B07911B07FFFFFF911B07FDFBFBFFFFFFFFFFFF911B07
                FFFFFFFFFFFF911B07FFFFFF94220EFBF7F7FFFFFFFFFFFFFFFFFFFFFFFFF6ED
                EBC78C82B566589E3726911B07FFFFFF911B07FFFFFF911B07FFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFCC978EBC7468FFFFFF
                BC7468CC978EFFFFFFFFFFFFB05B4DC99086FBF7F7C78C82911B07FFFFFFB05B
                4DC99086FBF7F7C78C82911B07FFFFFFB05B4DDCB7B1FFFFFFDEBBB5A94D3DFF
                FFFF911B07FFFFFFFFFFFF911B07FFFFFFFFFFFF911B07FFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFB15E50F2E5E3FFFFFFF8F0EFB15E50FFFFFFFFFFFFB05B4DDCB7
                B1FFFFFFDEBBB5A94D3DFFFFFF911B07DCB7B1F9F4F3FFFFFF911B07FFFFFFFF
                FFFF911B07FFFFFFB05B4DC78C82FDFBFBDAB3ADA23E2DFFFFFFA23E2DDFBEB8
                FFFFFFECD7D4962512FFFFFF911B07FFFFFF911B07FFFFFFFFFFFFFFFFFFFFFF
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
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF4E9E7992C1AF8F0EF972916F4
                E9E7FFFFFFFFFFFFEFDEDBA74939972916CC978E911B07FFFFFFEFDEDBA74939
                972916CC978E911B07FFFFFFF2E5E3A94D3D911B07A74939EDDBD8911B07911B
                07911B07911B07911B07911B07FFFFFF911B07FFFFFFFFFFFFFFFFFFFFFFFFED
                DBD8B05B4DFFFFFFFFFFFFFFFFFFB86D60EAD4D0FFFFFFF2E5E3A94D3D911B07
                A74939EDDBD8FFFFFF911B07CE9A92A23E2D911B07911B07911B07FFFFFF911B
                07FFFFFFF1E2DFAE5749911B07A23E2DE5C9C4FFFFFFE5C9C4A54535911B0799
                2C1AD3A59DFFFFFF911B07FFFFFF911B07FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFB05B4DBA7064B05B4DFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF911B07FFFFFF
                FFFFFF911B07FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFBD776CDAB3
                ADFFFFFFFFFFFFFFFFFFE1C2BCB86D60FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF911B07FFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFF911B07FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
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
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFD9B0A9911B07D9B0A9FFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFB05B4DFFFFFFFFFFFFB0
                5B4DFFFFFFFFFFFF911B07FFFFFFFFFFFFFFFFFFF6EDEB9E3726FDFBFBFFFFFF
                FFFFFFFFFFFFFFFFFFA03B2AF4E9E7FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFB05B4DFFFFFFFFFFFF911B07FFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                911B07FFFFFF911B07FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
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
                FFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
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
                FFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
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
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFBCBEBE7A7C7C6F6A6B77727370696C7770736F6A6C7772746B6A6C
                7372746C696B6562647772746E696B7772736F6A6B7572746D6A6C7771766F69
                6E7371776B696F7772746E696B7271736B6A6C7772736F6A6B7572746D6A6C72
                71756A696D7572746C696B7373736B6B6B7772736F6A6B7772746F6A6C727272
                6A6A6A7671726F6A6B7772736E696A7671736E696B7572746D6A6C777B7C767A
                7B6C686D6D696E6B6A6C6C6B6D6D696F6E6A706C6B6D6B6A6C6C6B6F6B6A6E6E
                6B6D6E6B6D6E6B6D6E6B6D6D6A6C6E6B6D6E6B6D6D6A6C6E6A6F6E6A6F6E6B6D
                6E6B6D6D6A6C6E6B6D6E6B6D6D6A6C6C6B6D6C6B6D6E6A6F6E6A6F6D6A6C6E6B
                6D6E6B6D6D6A6C706A6F706A6F6C6B6D6C6B6D6D6A6C6E6B6D6E6B6D6D6A6C6E
                6A6F6D696E6C6B6F6C6B6F6D6A6C6E6B6D6D696E6E6A6F6D6A6C6E6B6D6E6A6F
                6D696E6E6A6F6E6A6F6E6B6D6E6B6D6D6A6C6D6A6C797B7C787A7B7573736D6B
                6B7572746C696B7572746D6A6C7571766C686D7772736F6A6B7472726D6B6B75
                71766C686D7572746D6A6C7572746D6A6C7572746D6A6C7573736C6A6A767173
                6F6A6C7572746D6A6C7573736D6B6B7470756C686D7372746B6A6C6562647471
                736C696B7572746A696B7372746A696B7372746D6B6B7573736C696B74717370
                6A6B7771726D6A6C767375706B6C777273717374FFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FF7072720F11115752534D4849564F524E474A5550524E494B51505249484A55
                52544340424E494B5550524E494A5550514C494B5451534C464B56505549474D
                5250564C474957525449484A5150524D48495651524C494B5451534A494D5150
                544B484A5451534949495252524D48495550514C47495752544949495252524D
                48495651524D48495651524D484A5550524B484A54515315191A000203646065
                736F746B6A6C7372746561676D696F7372746B6A6C7372766B6A6E7572746C69
                6B7572746D6A6C7673756C696B7572746D6A6C7571766C686D7572746D6A6C76
                73756C696B7572746D6A6C7372746A696B7571766D696E7673756C696B757274
                6D6A6C7771766E686D7372746B6A6C7673756C696B7572746D6A6C7571766D69
                6E7271756A696D7572746D6A6C7672776460656D6A6C7471736C686D7571766E
                6A6F7571766D6A6C7572746B686A75727427292A0103044442425452524B484A
                524F514A47495451534B474C5450554D48495651524D4B4B5351514B474C5450
                554B484A5451534B484A5350524B484A5451534B49495452524D484A5550524B
                484A5350524B49495452524B474C5450554A494B515052423F414D4A4C545153
                4B484A51505249484A52515349484A5351514B49495552544B484A5650514F49
                4A5350524C494B565152555051161819FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF777274
                6863654EB3E74BB0E451B0E151B0E152B2E04FAFDD4BAFE54CB0E650B1DD51B2
                DE54B2E055B3E152B2E051B1DF74B4D682C2E4BAD0D6BBD1D7C6D2D8C7D3D9C3
                D4D7BBCCCF69BBE462B4DD75BFE379C3E7A5CCDBACD3E2C2D1D3BAC9CB8CBED5
                83B5CC50B2E04FB1DF51B0E14EADDE50B0E54CACE144ABE244ABE241ADE341AD
                E350B2E24FB1E14EB4DF4AB0DB3EABE142AFE56F696A0D0708FCFEFFFBFDFEFD
                FDFDFFFFFFFEFEFEFEFEFEFEFEFEFFFFFFFDFDFDFFFFFFFEFEFEFFFFFFFEFDFF
                FFFEFFFEFDFFFFFEFFFCFEFEFCFEFEFEFDFFFFFEFFFCFEFEFDFFFFFCFEFEFDFF
                FFFEFEFEFEFEFEFFFDFFFFFEFFFCFEFEFDFFFFFEFEFEFFFFFFFCFEFEFCFEFEFE
                FEFEFFFFFFFEFDFFFFFEFFFEFDFFFFFEFFFCFEFEFCFEFEFEFEFEFEFEFEFCFFFD
                FDFFFEFCFEFEFBFDFDFEFDFFFEFDFFFEFDFFFFFEFFFFFFFFFFFFFFFCFEFFFDFF
                FFFCFEFEFCFEFEFBFDFDFCFEFE8E8E8E00000058ADDA5FB4E15FB1E061B3E26A
                BADF67B7DC67B6DF68B7E061B6DE62B7DF99C1D3A8D0E2C6D2D8C4D0D6BCCFD7
                BFD2DAA3CCDB98C1D05EB8E15AB4DD53B2E354B3E45EB3E05FB4E15BB4E05BB4
                E058B3E058B3E052B3DF53B4E055B1E058B4E361B4E160B3E058B4DF59B5E057
                B5E058B6E15FB4E15EB3E05BB3E15AB2E05AB3DF5AB3DF59B4E15BB6E387BCD7
                8DC2DDB7CDD2C3D9DE5A5858FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF7E797B57525448
                ADE146ABDF4BAADB4AA9DA4AAAD84BABD942A6DC43A7DD4CADD94CADD94DABD9
                4DABD94BABD94FAFDD77B7D97FBFE1ACC2C8ADC3C9B7C3C9B7C3C9ADBEC1A6B7
                BA59ABD45AACD566B0D46AB4D892B9C899C0CFB4C3C5B3C2C489BBD282B4CB4C
                AEDC4BADDB4CABDC4AA9DA48A8DD48A8DD40A7DE40A7DE3CA8DE3DA9DF47A9D9
                48AADA45ABD644AAD53AA7DD3DAAE05F595A0E0809F4F6F7FBFDFEFDFDFDFDFD
                FDFDFDFDFEFEFEFEFEFEFDFDFDFEFEFEFEFEFEFDFDFDFEFEFEFEFDFFFDFCFEFD
                FCFEFDFCFEFBFDFDFBFDFDFDFCFEFEFDFFFCFEFEFBFDFDFBFDFDFBFDFDFDFDFD
                FDFDFDFFFCFEFFFDFFFCFEFEFBFDFDFDFDFDFDFDFDFBFDFDFBFDFDFDFDFDFEFE
                FEFEFDFFFDFCFEFDFCFEFDFCFEFBFDFDFBFDFDFDFDFDFDFDFDFBFEFCFBFEFCFC
                FEFEFCFEFEFCFBFDFDFCFEFDFCFEFDFCFEFDFDFDFDFDFDFCFEFFFBFDFEFBFDFD
                FCFEFEFAFCFCFCFEFE7979790B0B0B51A6D359AEDB58AAD959ABDA5FAFD460B0
                D55EADD65DACD55BB0D860B5DD98C0D29AC2D4B5C1C7B4C0C6ACBFC7AABDC590
                B9C888B1C053ADD652ACD54AA9DA4CABDC57ACD957ACD953ACD853ACD852ADDA
                52ADDA4CADD94BACD850ACDB4EAAD958ABD859ACD952AED951ADD84EACD74EAC
                D757ACD957ACD954ACDA54ACDA54ADD954ADD950ABD856B1DE86BBD68DC2DDAF
                C5CAB6CCD15B5959FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF7673755C595B4CAEDE4BAD
                DD4BAADB4BAADB4CABDC4EADDE51ADD84CA8D342A8DD43A9DE58AED858AED875
                AFD279B3D6A8C1CBAAC3CDAFC2C9ADC0C7A5C1CCA1BDC863B3DC5CACD549ABDB
                49ABDB50ACDB53AFDE69B3D76BB5D98ABCD88BBDD9B2C1C4AEBDC07CB2D178AE
                CD5CAED859ABD54AA9DA49A8D94BABD949A9D73EA7DA40A9DC3DAADD3CA9DC47
                A7DC47A7DC42A8DC48AEE26761660D070CF8F9EFFFFFF6FFFEFEFFFDFDFEFFFD
                FDFEFCFFFFFBFFFEFAFEFEFEFEFEFEFFFEFEFFFEFEFEFFFDFEFFFDFEFFFDFDFE
                FCFFFEFEFFFEFEFEFFFDFEFFFDFFFEFEFFFEFEFFFEFEFFFDFDFEFFFDFEFFFDFF
                FEFEFFFEFEFFFEFEFFFEFEFEFFFDFDFEFCFFFEFEFFFEFEFFFEFEFFFEFEFFFEFD
                FFFEFDFEFFFDFDFEFCFFFEFEFFFEFEFFFDFFFFFDFFFFFEFEFFFDFDFBFEFCFBFE
                FCFEFFFDFDFEFCFEFEFEFEFEFEFEFEFEFEFEFEFEFFFDFEFFFDFFFEFEFFFEFEFF
                FCFEFFFDFF8986820502004AA7D450ADDA54AED753ADD65FB0D65EAFD557AEDA
                58AFDB87B3CB93BFD7BAC6C6BAC6C6B1C0C9B1C0C98EBED087B7C956ACDA56AC
                DA54AED753ADD64DA9D84FABDA56ADD955ACD854ADD954ADD956ADD954ABD755
                ADDC54ACDB56ADD557AED654ADD955AEDA57AEDA55ACD857ADD756ACD657AEDA
                55ACD856ACDA57ADDB4EABDC4EABDC6EB1D275B8D9C0C5C6C1C6C7B9C4C8C0CB
                CF525155FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF7C797B55525451B3E349ABDB4BAADB
                4AA9DA4BAADB4CABDC50ACD751ADD843A9DE43A9DE58AED85DB3DD7BB5D883BD
                E0A7C0CAA9C2CCAEC1C8AEC1C89FBBC697B3BE5BABD45AAAD34AACDC48AADA4E
                AAD94FABDA65AFD368B2D680B2CE8ABCD8B4C3C6B4C3C684BAD97CB2D15BADD7
                5DAFD94BAADB4BAADB4CACDA4BABD93FA8DB40A9DC3AA7DA3DAADD46A6DB48A8
                DD44AADE51B7EB6862670D070CFBFCF2FFFFF6FFFEFEFFFEFEFFFFFEFFFFFEFF
                FEFAFFFFFCFEFEFEFFFFFFFFFEFEFFFEFEFFFFFFFFFFFFFFFFFFFFFFFFFFFEFE
                FFFEFEFEFFFDFEFFFDFFFEFEFFFEFEFFFDFDFFFFFFFEFFFDFEFFFDFFFEFEFFFE
                FEFFFEFEFFFEFEFDFEFCFFFFFEFFFEFEFFFEFEFFFEFEFFFEFEFFFEFDFFFEFDFD
                FEFCFFFFFEFFFEFEFFFEFEFFFDFFFFFDFFFFFEFEFFFFFFFCFFFDFCFFFDFDFEFC
                FEFFFDFDFDFDFFFFFFFEFEFEFEFEFEFEFFFDFEFFFDFFFDFDFFFEFEFFFCFEFFFD
                FF8B888407040049A6D353B0DD54AED753ADD65EAFD55DAED455ACD85BB2DE91
                BDD594C0D8B9C5C5B7C3C3B1C0C9ACBBC489B9CB82B2C456ACDA55ABD954AED7
                53ADD64FABDA50ACDB55ACD857AEDA55AEDA55AEDA57AEDA57AEDA52AAD955AD
                DC58AFD759B0D854ADD954ADD956ADD956ADD958AED856ACD656ADD957AEDA56
                ACDA56ACDA4EABDC52AFE075B8D97CBFE0BEC3C4BEC3C4B8C3C7BEC9CD5A595D
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFF7771765F595E4BAEE049ACDE55ACD853AAD653
                AFDA52AED950ADDA50ADDA53ABD955ADDB83B5CC8BBDD4B4CAC5B0C6C1B6C1C9
                B6C1C9A6C2C9A3BFC661B2DF5AABD844AADE45ABDF55AFD855AFD84CACDA4BAB
                D953ADDC54AEDD61B7D564BAD895BED596BFD6ADC3C9A6BCC27AB4D174AECB4F
                AEDA4EADD954ACDA53ABD947AADE43A6DA3DA7DC3EA8DD3EAED93EAED988B4CC
                98C4DC64675E0306002A89FE2A89FE2A89FE2A89FE2A89FE2A89FE2A89FE2A89
                FE2A89FE2A89FE2A89FE2A89FE2A89FE2A89FE2A89FE2A89FE2A89FE2A89FE2A
                89FE2A89FE2A89FE2A89FE2A89FE2A89FE2A89FE2A89FE2A89FE2A89FE2A89FE
                2A89FE2A89FE2A89FE2A89FE2A89FE2A89FE2A89FE2A89FE2A89FE2A89FE2A89
                FE2A89FE2A89FE2A89FE2A89FE2A89FE2A89FE2A89FE2A89FE2A89FE2A89FE2A
                89FE2A89FE2A89FE2A89FE2A89FE2A89FE2A89FE2A89FE2A89FE2A89FE485F91
                00002854ACD556AED756ACDA56ACDA5BB0D859AED67FB3CA89BDD4B6C2C6B7C3
                C7ADC1CCACC0CB8DC3CE85BBC657ACDE57ACDE56AED756AED753ABD955ADDB56
                AEDC56AEDC56AED657AFD75AAED859ADD754ADD955AEDA4EB2D54DB1D45DAEDB
                5BACD95AAFD55AAFD553ACD856AFDB5BAEDB5AADDA52AED953AFDA58ACDC57AB
                DB7AB4CA80BAD0B1C4C1B4C7C4B7C2CAB6C1C9B0C3CAB6C9D0535052FFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFF7F797E56505549ACDE48ABDD56ADD955ACD850ACD754B0
                DB4FACD950ADDA55ADDB58B0DE89BBD291C3DAB0C6C1B3C9C4B7C2CAB7C2CAA3
                BFC69CB8BF5BACD958A9D641A7DB46ACE052ACD554AED74DADDB4CACDA50AAD9
                52ACDB5BB1CF61B7D58CB5CC92BBD2ADC3C9AEC4CA7FB9D679B3D04BAAD650AF
                DB52AAD854ACDA45A8DC46A9DD3EA8DD3EA8DD39A9D445B5E092BED69DC9E160
                635A0306002A89FEF9F1D5F3E3AAEED580EFD888F8EECBF6EABFEED57EEED57E
                F4E4AFF9F1D4F0DB91EED681F2DE9CF9F1D6F3E1A5EED581EFD98AF9F0D2F5E8
                BAEED581EED57FF5E6B4F9F0D3F0DA8DEED581F2E0A0F9F1D6F2DE9CEED581F0
                DA8DF5E6B6F5E6B4EED57FEED683F6EABFF9F0D2EFD98AEED581F3E1A5F9F1D6
                F1DD98EED682F0DB91F9F1D4F4E4AFEED57EEFD785F7ECC5F7ECC5EFD787EED5
                80F3E3AAF9F1D5F1DC94EED682F1DD98F9F1D6F3E3AA2A89FE273E700000314F
                A7D05BB3DC57ADDB56ACDA57ACD460B5DD8ABED58DC1D8B8C4C8B5C1C5ACC0CB
                AABEC983B9C481B7C256ABDD57ACDE57AFD855ADD654ACDA54ACDA50A8D655AD
                DB56AED657AFD759ADD75AAED855AEDA54ADD94AAED14FB3D65CADDA5DAEDB5A
                AFD55BB0D657B0DC55AEDA56A9D65BAEDB52AED953AFDA58ACDC5DB1E183BDD3
                89C3D9B1C4C1B5C8C5B7C2CAB8C3CBAFC2C9B2C5CC5C595BFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFF7572745D5A5C4AACDC4BADDD50ADDA4FACD952ADDA53AEDB56AED7
                57AFD86FB2D376B9DAAAC0CCABC1CDBAC5C9BAC5C9B6C5C7B3C2C464B5DB5EAF
                D54CABDC4BAADB4BAADB4AA9DA45ABDF44AADE4DACDD4BAADB43A9DA47ADDE53
                AEDB53AEDB62B2D765B5DA8ABCD38EC0D7B1C4C9AABDC27BB3D076AECB5EADD8
                5EADD847ACD947ACD944AADB45ABDC74B1CB7FBCD6BBC4C7C4CDD06563630604
                042A89FEF0DA8DEED57BF4E54EF2E257EFD873EED875F1E15AF4E450EED57EEE
                D970EFDD67F5E64DEFD971EFDA6EEED678F0DB6BEFD874EED872EED679F3E258
                F3E255EED57BEFD971F2DF61F5E54DEED775EFDA6FEFD874F4E450F0DE62EFD9
                71EED57BF4E452F1E257EED777EFD971F2E05DF1E450EED678F0DA6FF0DA6DF1
                E451EED67AEED57CEED57EF2E452F1E259EFD775EFD873F2E15AF4E4AEEED581
                EFD96FF0DC69F3E64DF0DA6DF0DA6DEED5812A89FE20408C00003C53A8D059AE
                D649A8DA4CABDD82B4CA8DBFD5B1C4C9B2C5CAADC3C9ACC2C8A3C0CFA0BDCC5C
                B1D959AED655ADDB55ADDB4FACD950ADDA4FABDE4EAADD4CABDC4CABDC58AED8
                57ADD754ACDA55ADDB56ABD857ACD954ACDA53ABD95CAED85CAED859AFD959AF
                D95DB0D65CAFD552AED753AFD860B0D95EAED76EB1D275B8D9B9C4C8BAC5C9B7
                C3C9B7C3C9B2C2C8B3C3C99BBFCF99BDCD534F54FFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FF7D7A7C54515352B4E449ABDB4EABD84DAAD752ADDA53AEDB57AFD856AED774
                B7D87CBFE0ABC1CDABC1CDB7C2C6B9C4C8B4C3C5A9B8BA5EAFD55AABD14CABDC
                4BAADB4BAADB4AA9DA43A9DD42A8DC4BAADB4CABDC46ACDD45ABDC51ACD952AD
                DA5EAED362B2D784B6CD8BBDD4B0C3C8B0C3C881B9D67EB6D360AFDA5DACD747
                ACD945AAD745ABDC4AB0E180BDD785C2DCBCC5C8C9D2D56563630503032A89FE
                EED57FF0DA6DFAF329F2E747EED679EED778F6EABFF9F0D1F0D98DEED57EF0E1
                5AFBF720F2DE62EED57DEFDC69FBF525F0DB6BEED57CEED775F7EC3FF7ED39EF
                D874EED57DF4E454FBF522F0DD69EED57CF1DD65FBF61FF2E358EED57DEFD873
                F8ED36F4EC41EED775EED581F5E6B4FBF5E2F0DB93EED580F2DF9CF8F0D4F3E1
                A5EED57EF0D98DF9F1D4F6E9BCEED784EED683F5E8B9F9F2D8F0DA8EEED57CF1
                E15BF9F622F2E05DEED57CF0DB922A89FE18388400004253A8D05BB0D84DACDE
                50AFE18CBED48DBFD5B0C3C8AFC2C7ADC3C9ACC2C8A1BECD9AB7C65AAFD758AD
                D554ACDA54ACDA50ADDA51AEDB4EAADD4EAADD4CABDC4CABDC59AFD958AED853
                ABD954ACDA58ADDA57ACD955ADDB55ADDB5BADD75CAED857ADD759AFD95DB0D6
                5CAFD552AED754B0D95EAED761B1DA76B9DA7DC0E1B8C3C7B8C3C7B8C4CAB6C2
                C8B2C2C8B1C1C795B9C993B7C75D595EFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF737274
                5B5A5C51B1DF4AAAD83DA6DF3FA8E14FACD952AFDC6FB1CE74B6D3A1BDC8A5C1
                CCB2C5C8B3C6C9A7C1CFA3BDCB64B6D95DAFD240A7DE43AAE14FADDB4FADDB48
                A8DD49A9DE4BAADB4AA9DA3FA7DC40A8DD4CACDA4DADDB50AEDC4DABD950AFDB
                51B0DC62B1D865B4DB91BDD495C1D8B2C2C8ABBBC181B5CC7DB1C856ACDA55AB
                D97EB4CD89BFD8BBC4C7BBC4C7BDC5C5C5CDCD6564600403002A89FEF3E2A6F1
                DC96F0DB92EFD88AF2E0A1F2DF9EEFD98CF0DB92F1DD98F3E2A8EED57EF1DC96
                EFD785F3E2A7F0DA8EF1DC95EED684F2E0A2F2DF9DF0DA8EF0DA90F1DE9AF3E1
                A4EED581F0DC94EFD889F3E2A6EFD889F1DC96EED581F3E1A4F1DE9BF0DA90F0
                DA8EF2DF9DF2E0A2EFD787F1DC94F0DB92F3E2A7EFD785F1DC96EED57EF3E2A6
                F1DC94F0DB91EFD98CF2DF9EF2E0A1EFD88AF0DB93F1DC94F3E2A6EED681F1DD
                96EED681F3E2A6F0DB922A89FE29407200002E44A8D848ACDC84B3C992C1D7BF
                C7C7BBC3C3ACC0CBACC0CBA1C0CF9EBDCC69B3D765AFD34EACDA51AFDD58ACD6
                5AAED856AED754ACD54FAEDA4FAEDA50ACDD51ADDE54ADD954ADD94DAEDA4DAE
                DA52AED953AFDA5BADD75CAED85EAFD55FB0D658ADDA57ACD95DAEDB5CADDA5B
                ADDC5BADDC75B3D17AB8D6B5C2C4B8C5C7B5C3C9B6C4CAB8C4C8B5C1C595BED4
                90B9CF5FB1DA5FB1DA535151FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF7A797B5251534F
                AFDD4DADDB3CA5DE3BA4DD4EABD852AFDC77B9D67CBEDBA7C3CEA6C2CDB0C3C6
                B0C3C6A3BDCB99B3C15CAED15AACCF41A8DF43AAE14CAAD84DABD949A9DE49A9
                DE4BAADB4BAADB40A8DD3FA7DC4AAAD84BABD94FADDB4DABD94DACD84EADD95F
                AED561B0D78AB6CD92BED5B1C1C7B3C3C989BDD482B6CD58AEDC5DB3E188BED7
                8AC0D9BBC4C7BBC4C7BFC7C7C4CCCC61605C0C0B072A89FE2A89FE2A89FE2A89
                FE2A89FE2A89FE2A89FE2A89FE2A89FE2A89FE2A89FE2A89FE2A89FE2A89FE2A
                89FE2A89FE2A89FE2A89FE2A89FE2A89FE2A89FE2A89FE2A89FE2A89FE2A89FE
                2A89FE2A89FE2A89FE2A89FE2A89FE2A89FE2A89FE2A89FE2A89FE2A89FE2A89
                FE2A89FE2A89FE2A89FE2A89FE2A89FE2A89FE2A89FE2A89FE2A89FE2A89FE2A
                89FE2A89FE2A89FE2A89FE2A89FE2A89FE2A89FE2A89FE2A89FE2A89FE2A89FE
                2A89FE2A89FE2A89FE445B8D00003042A6D653B7E790BFD590BFD5BDC5C5BCC4
                C4AEC2CDAABEC99DBCCB97B6C564AED263ADD14DABD94FADDB59ADD75AAED857
                AFD856AED74FAEDA4EADD94EAADB4FABDC54ADD955AEDA4CADD94BACD853AFDA
                54B0DB5DAFD95DAFD95FB0D65EAFD558ADDA58ADDA5DAEDB5BACD959ABDA5CAE
                DD7AB8D682C0DEB9C6C8BAC7C9B4C2C8B5C3C9B6C2C6B2BEC28DB6CC89B2C85D
                AFD860B2DB5C5A5AFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF787273605A5B57AFDD52AA
                D83BA7DD3DA9DF6CAFD074B7D8A7C0CAA8C1CBB8C4C8B7C3C7A4BFCDA3BECC60
                B5DD58ADD54EABD84CA9D649A9DE48A8DD4AAADF49A9DE4DACD84EADD946ACDD
                44AADB44A9DD43A8DC3EA7E03FA8E151ABDA51ABDA4FADDB4FADDB4FAEDA51B0
                DC62B1D864B3DA84BCD58AC2DBB9C5C5B4C0C09FBCC5A6C3CCAFC0C9B1C2CBB8
                C4C8B9C5C9ACC2CDAFC5D064636509080AFFFDF9FFFEFAFFFFFEFFFFFEFDFFFE
                FCFFFDFEFEFEFEFEFEFFFFFFFEFEFEFDFFFEFDFFFEFFFFFFFEFEFEFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFEFEFFFFFEFFFFFEFFFFFFFFFFFFFD
                FFFEFDFFFEFFFFFFFEFEFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FEFEFEFFFFFEFFFFFEFFFFFFFFFFFFFFFFFEFFFFFEFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFEFEFEFFFFFFFFFFFFFFFFFEFFFFFEFEFFFDFFFFFEFEFFFDFDFEFCFD
                FDFDFDFDFD8C898506030070AAC785BFDCB1C3CAB0C2C9ABC1CDABC1CD97BED4
                92B9CF58B0D856AED653ABD952AAD848ABDF49ACE057AEDA56ADD94DABD94EAC
                DA4FAEDA4DACD84DAEDA4DAEDA57AFD856AED750ADDA50ADDA58ADDA58ADDA5D
                AFD85EB0D95DAFD95CAED859ADD75BAFD95AAED85AAED872B1D379B8DAB4C3C5
                B4C3C5BAC6C8B9C5C7B0C2C9AFC1C88FBCD18AB7CC58B0D957AFD85EAFD464B5
                DA554F54FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF807A7B5751525DB5E354ACDA3BA7DD
                3FABE176B9DA7CBFE0A9C2CCAAC3CDB6C2C6B5C1C5A1BCCA9AB5C356ABD356AB
                D34FACD94FACD947A7DC49A9DE49A9DE49A9DE4DACD84DACD844AADB43A9DA44
                A9DD43A8DC3DA6DF3FA8E150AAD952ACDB4DABD94EACDA4EADD94FAEDA5EADD4
                61B0D77CB4CD83BBD4B8C4C4BAC6C6A7C4CDA7C4CDB1C2CBAFC0C9B5C1C5B9C5
                C9A7BDC8A6BCC764636509080AF2EFEBFFFFFBFEFFFDFEFFFDFDFFFEFDFFFEFF
                FFFFFEFEFEFFFFFFFFFFFFFDFFFEFDFFFEFFFFFFFFFFFFFFFFFFFEFEFEFEFEFE
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFEFFFDFEFEFEFFFFFFFDFFFEFDFF
                FEFFFFFFFFFFFFFFFFFFFEFEFEFEFEFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFEFEFFFDFEFEFEFFFFFFFFFFFEFFFFFEFFFFFFFFFEFEFEFEFEFFFFFFFEFEFE
                FFFFFFFFFEFEFFFFFFFFFFFEFFFEFDFFFFFEFEFFFDFFFFFEFFFFFEFCFCFCFFFF
                FF8A878306030074AECB8EC8E5AEC0C7ACBEC5A7BDC9A3B9C58EB5CB89B0C656
                AED654ACD454ACDA53ABD946A9DD47AADE54ABD756ADD94EACDA4DABD94FAEDA
                4FAEDA4BACD84DAEDA56AED755ADD651AEDB51AEDB57ACD959AEDB5BADD65BAD
                D65DAFD95CAED85AAED859ADD75AAED85EB2DC77B6D87DBCDEB5C4C6B6C5C7B8
                C4C6B8C4C6AFC1C8ACBEC588B5CA83B0C556AED758B0D960B1D662B3D85E585D
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFF78717460595C54B2DD50AED972B0CE7AB8D6C1
                C8C5BEC5C2BDC5C5BBC3C3A0BECF9CBACB54B2DD4EACD73EA9DC40ABDE51ACD9
                51ACD948AADA48AADA42ABDE42ABDE46ACDD45ABDC3FA8DB40A9DC45ABDB44AA
                DA43A8DC43A8DC42ABDE43ACDF52ADDA52ADDA51AEDB4EABD84FACDD4EABDC56
                B1DE53AEDB8CB8CF93BFD6BEC6C6BDC5C5BBC4C7BAC3C6A2C2CF9DBDCA5FB2D8
                5EB1D764636709080CF7F7F7FDFDFDFFFFFEFFFFFEFFFFFFFFFEFEFCFEFEFDFF
                FFFEFFFDFFFFFEFFFFFFFFFFFFFEFFFDFFFFFEFFFFFEFFFFFEFEFFFDFFFFFEFF
                FFFEFFFFFEFEFFFDFFFFFEFFFFFEFFFFFEFEFFFDFFFFFEFFFFFFFFFFFFFEFFFD
                FFFFFEFFFFFEFFFFFEFEFFFDFFFFFEFFFFFEFFFFFEFEFFFDFFFFFEFFFFFEFFFF
                FEFEFFFDFFFFFEFFFFFFFFFFFFFFFFFEFEFFFDFDFFFEFDFFFEFEFFFDFFFFFEFF
                FFFEFFFFFEFFFEFEFFFFFFFFFFFFFFFFFFFFFFFFFEFEFEFDFFFFFBFDFD848686
                000202A7BAC2AEC1C9A6BECAA4BCC881B8D37DB4CF57AEDA56ADD955AEDA54AD
                D94DABD94EACDA4CAFDB49ACD847AADE47AADE4BAADB4CABDC4EABD850ADDA55
                AFD855AFD850ADDA52AFDC5AADDA5AADDA5AAED858ACD65BB0D85AAFD757ACD9
                57ACD94FADDB4FADDB75B2D27CB9D9BDC5C5BEC6C6BBC4C7BCC5C8B9C5C5B6C2
                C287BDD681B7D053AFDE50ACDB5BAED45CAFD55FAFD863B3DC554F50FFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFF7F787B58515453B1DC52B0DB7CBAD883C1DFBEC5C2C1C8
                C5BEC6C6BCC4C49DBBCC93B1C24DABD64EACD73CA7DA40ABDE50ABD851ACD949
                ABDB48AADA40A9DC40A9DC41A7D845ABDC41AADD42ABDE44AADA45ABDB45AADE
                44A9DD3EA7DA43ACDF4FAAD752ADDA50ADDA4FACD94EABDC4DAADB4DA8D556B1
                DE8DB9D094C0D7BEC6C6BFC7C7BBC4C7B8C1C499B9C693B3C05BAED45DB0D65A
                595D0A090DF6F6F6FEFEFEFCFDFBFFFFFEFFFEFEFFFFFFFDFFFFFDFFFFFEFFFD
                FEFFFDFDFDFDFFFFFFFFFFFEFFFFFEFDFEFCFFFFFEFFFFFEFFFFFEFFFDFCFFFF
                FEFFFFFEFFFFFEFDFEFCFFFFFEFFFFFEFFFFFEFDFDFDFFFFFFFFFFFEFFFFFEFD
                FEFCFFFFFEFFFFFEFFFFFEFFFDFCFFFFFEFFFFFEFFFFFEFDFEFCFFFFFEFFFFFE
                FFFFFEFCFCFCFFFFFFFEFFFDFFFFFEFCFFFDFDFFFEFFFFFEFFFFFEFCFDFBFFFF
                FEFFFFFFFFFFFFFEFEFEFFFFFFFFFFFFFFFFFFF8FAFAFDFFFF787A7A080A0A9F
                B2BAB8CBD3A8C0CCA2BAC67BB2CD78AFCA56ADD957AEDA53ACD854ADD94FADDB
                4EACDA46A9D54AADD947AADE47AADE4BAADB4CABDC50ADDA50ADDA51ABD455AF
                D84FACD950ADDA59ACD959ACD95AAED85AAED857ACD45BB0D857ACD958ADDA4D
                ABD951AFDD79B6D681BEDEBAC2C2BFC7C7BAC3C6BCC5C8B9C5C5B3BFBF7FB5CE
                79AFC84BA7D651ADDC5DB0D65FB2D85FAFD863B3DC5E5859FFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFF7772745F5A5C98BDD1A1C6DAC4CCD3C8D0D7D4D6D6D2D4D4CCD0D5
                C6CACF95BBCD8DB3C580B1CB81B2CC84B1CC82AFCA7CB1CC7CB1CC7EB1CB80B3
                CD85B3CB80AEC67CAECC7CAECC83B2C883B2C882B2CA82B2CA86B2CA86B2CA85
                B3CB84B2CA81B0CC82B1CD88B5CA87B4C981B2C881B2C88BB5CC96C0D7CCD2D1
                D0D6D5D0D3D7CFD2D6CFD3D8C3C7CC8DB8CB88B3C68BB4CD8FB8D16E6D690B0A
                06FFFEFFFDFCFEFFFFFFFEFEFEFFFFFEFFFFFEFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFEFFFFFEFEFEFEFFFFFFFFFFFEFFFFFEFEFFFDFFFFFEFFFFFEFFFFFEFFFEFE
                FFFFFFFFFFFEFFFFFEFEFEFEFFFFFFFFFFFEFFFFFEFEFEFEFFFFFFFFFFFEFFFF
                FEFEFFFDFFFFFEFFFFFEFFFFFEFFFEFEFFFFFFFFFFFEFFFFFEFEFEFEFFFFFFFF
                FFFEFFFFFEFFFEFEFFFFFFFFFFFEFFFFFEFEFFFDFFFFFEFFFFFFFEFEFEFFFFFE
                FFFFFEFFFFFEFFFFFEFFFFFEFFFFFEFEFDFFFFFEFF918F8F040202C1C8C5C9D0
                CDB3C7D2ACC0CB8EB8CB8DB7CA8AB5D088B3CE85B4CA88B7CD88B4CB87B3CA85
                B2CD87B4CF8BB4CD89B2CB82B4CA81B3C987B5CD86B4CC88B3CE88B3CE86B5D0
                83B2CD85B3CB87B5CD8DB6CC8EB7CD8EB6CF8DB5CE91B8CE8EB5CB98BBCFA0C3
                D7C5CCD5C8CFD8CFD2D6D1D4D8CCD3D6CBD2D5C6CED5BBC3CA8DB5CE8AB2CB8E
                B4CC90B6CE8CB5CB8FB8CE8EB7CD90B9CF5A5B57FFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FF7772741510122C516523485C4A525940484F4F5151484A4A4D515645494E2B
                5163193F511748621F506A194661224F6A1247621B506B1447611D506A19475F
                2250681345631D4F6D3160763362781848601F4F671B475F224E6619475F2957
                6F2756722655712B586D2B586D1F506627586E2E586F2D576E444A494C525145
                484C4E515544484D4E52571D485B2651641D465F264F68201F1B040300626163
                7271736A6A6A6A6A6A636462696A686B6B6B6A6A6A7272726B6B6B6A6B696A6B
                697373736A6A6A6A6B696A6B697374726A6B696A6B696A6B697573736C6A6A6A
                6B696A6B697373736A6A6A6A6B696A6B697373736A6A6A6A6B696A6B69737472
                6A6B696A6B696A6B697573736C6A6A6A6B696A6B697373736A6A6A6C6A696C6A
                697573736C6A6A6A6B696A6B697374726A6B696969697373736B6C6A6A6B6969
                6A687374726A6B696B6C6A69686A7372742B29290402024249464D5451354954
                3C505B1E485B2751641C476225506B19485E2251671B475E245067194661224F
                6A1D465F27506916485E1F51671A48602250681B4661244F6A174661204F6A19
                475F2351691E475D2750661E465F274F6820475D2950661C3F5325485C495059
                4148514E515545484C4B525542494C48505740484F2850691E465F294F671F45
                5D27506620495F275066275066191A16FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC4C9C7
                777C7A6C6A6A7573737171717373737072727072727073717174727772717873
                727171717171717173736F717172727272727272727272727271737370727274
                727274727200000000000072727272727272737172737170737126292709080A
                3231332E30312E303130303030303009080A2827297072727072727171717272
                72737472727371737472727371747272727070393D8B5C60AE707371686B696A
                696B6C6B6D6161616A6A6A686A6A717373686B69696C6A686A6A717373696969
                6A6A6A696B6B7173736A6A6A6B6B6B686A6A7173736969696A6A6A696B6B7173
                736A6A6A6B6B6B686A6A7173736969696A6A6A696B6B7173736A6A6A6B6B6B68
                6A6A7173736969696A6A6A696B6B7173736A6A6A6B6B6B686A6A717373696969
                6A6A6A6D6B6B757373686A6A696B6B7373736A6A6A686A6A686A6A7474746A6A
                6A69686A6B6A6C707272686A6A7A7B795C5D5B6464726E6E7C71737370727273
                7472737472717171727272737373727272727272727272707371707371707272
                7072727573737472727272727272727374727374727272727171717374727172
                7072727272727271747270737173717175737372737172737172727273737370
                7273717374747272757373727272737373747271747271707371707371717270
                7273717374727273717A7A7AFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF8D908E38373981808288
                8A8B8F91928B8B8B90909039383A8F8E90FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000
                000000000000FFFFFFFFFFFFFFFFFFFFFFFF79787A38373B7F7E828084857E82
                8379808370777A3D3B3B7B7979FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
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
                FFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00000000000000000000
                0000000000FFFFFFFFFFFFFFFFFF7A797B31303488878B7C80817C8081737A7D
                6970733331317D7B7BFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFF747D733D373C847E83747D80727B7E67767F64737C3D
                3A3C7C797BFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
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
                0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFF818A80332D32847E8370797C6E777A61707965747D302D2F8A87
                89FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00
                00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFF7A797B3D383A6F6A6C546B7A546B7A5168784E65753F3A3C7E797BFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFF
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
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF7978
                7A353032605B5D49606F4B62714B62724D64743530327F7A7CFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF7B7B7B3A3838
                5351512C53732F56763C5E763E60783C3A3A7D7B7BFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFF
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
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF85858532303058565626
                4D6D1E456530526A3F6179323030888686FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF79787A3B383A625F613D586C3A55
                692448603559713E393A7F7A7BFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
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
                FFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFF7A797B3330326A67694C677B4A65793C6078
                375B733530317F7A7BFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFF7979793939396464644563764866794D66764B64743C
                383D7D797EFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
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
                0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFF868686303030616161405E714462754861714B6474312D328884
                89FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00
                00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFF787A7B3D383A635E60586B735A6D755B6A7356656E3B3A3C7A797BFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFF
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
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF797B
                7C332E307D787A63767E64777F64737C5E6D76302F317B7A7CFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF777A7839383A
                79787A67778367778363737A5C6C733C393B7D7A7CFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFF
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
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF828583302F3179787A56
                66725E6E7A6070775E6E75343133878486FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF7C787D322F316360625367785569
                7A4E6879455F703232327C7C7CFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
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
                FFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFF7D797E3B383A6F6C6E55697A516576445E6F
                3C56673A3A3A7A7A7AFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFF7F887E353032746F714162723D5E6E35576F2F516936
                31328A8586FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
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
                0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFF767F753C37396E696B3F607037586830526A30526A3B36377F7A
                7BFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00
                00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFF797C7A342F306E696A33576F2B4F672A516D2F56723731327F797AFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFF
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
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF43454564
                2B2CFFFFFF480808FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF777A
                783D383968636433576F23475F2D54703B627E3F393A807A7BFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFB64745EA7B79DFD5D5372D
                2D810300FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF878585353031
                6B666749616D506874626E707C888A333131878585FFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFF
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
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF7B0C0AFFE8E6FFFDFDFEF4F4810300
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF7B79793D38396661625E
                7682647C887783857682843B39397C7A7AFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFF770C09FFEDEAFBFCFFF2F3F7820302FFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF7B7A7C302F336D6C70777C7F7C81
                847F8483868B8A3330327D7A7CFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
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
                FFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFB34845EC817EFAFBFF88898D800100FFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFF79787A39383C7675797B80837E83867E8382
                7D82813D3A3C7D7A7CFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFF4140424C1011FFFFFF820000FFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFF8386843330328380827B80817B808179818181898934
                3035888489FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
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
                0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFF820000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFF787B793A37397E7B7D787D7E7B8081788080767E7E39353A7E7A
                7FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00
                00FFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFF0000FFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFF470A06FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFF7C7A7A333032807D7F6A7A806A7A80777D827E84893431337C797BFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFF
                FF0909030B0B05FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF060300545149FFFFFF0000FFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF7C7A
                7A3B383A726F7161717765757B72787D767C813C393B7D7A7CFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FF161884040400
                0C0C060000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                00000000000000000000000C0C060404001618840000FFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF848686322E33
                76727742627948687F60727D6A7C87353032898486FFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFF545149060300FF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFF0B0B05090903FFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF787A7A3B373C6B676C33
                536A3252694F616C586A753D383A7E797BFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFF000000FFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFF1D2221FFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF79787C3331317775752E5369254A
                60244F70325D7E3530327F7A7CFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
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
                FFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFF79787C3B39397977773B6076284D631B4667
                224D6E3F3A3C7F7A7CFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFF7E897F332E30827D7F596D78455964224A661F476336
                31328A8586FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
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
                0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFF747F753C37397A7577596D7850646F2E5672234B673B3637807B
                7CFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00
                00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF4E0906510C0948
                0C064C100A774547FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFF7A7A7A302F3175747650687A496173456074415C703631337E797BFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF800100FFF1F0FCFEFFF8FA
                FBB29598694C4FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF7A7A
                7A39383A6A696B435B6D40586A425D714661753E393B7F7A7CFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF810201FFEFEEFCFEFFFBFDFEFFFBFE
                2C0F12FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF858684313032
                605F61204D6E184566375A6E44677B333032878486FFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFF810300FFF2EEFFF9F5FFF9F5FFB6B3691A17FF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF7A7B793837395453551B
                486924517235586C3E61753B383A7C797BFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFF8204008204004A0A064A0A06570805FFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF7A7A7A343133625F615D6A72606D
                754E6574546B7A3331317D7B7BFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFF840400FFF2EDFDFFFFFDFFFFD9B7B8927071FFFFFFFFFFFFFFFFFF
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
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFF7B7B7B3A37397C797B6E7B8368757D516877
                4D64733D3B3B7D7B7BFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FF830300FFF2EDFCFEFEFCFEFED9B7B8351314FFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFF848484322E3389858A717D83626E74435E72415C7036
                31338A8587FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF480807
                4B0B0A490A06490A06612B2AFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
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
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFF7C7C7C3A363B787479616D735D696F435E72415C703B3638807B
                7DFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFF7979793130325352544261764B6A7F4A6274465E703530317F7A7BFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
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
                FFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF7A7A
                7A3837394B4A4C38576C405F74455D6F3D55673E393A7F7A7BFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF858585333131
                545252294D6B2C506E1F4E6D2251703530328A8587FFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
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
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000
                00000000000000000000000000FFFFFFFFFFFFFFFFFF7979793C3A3A5654542E
                5270284C6A1645641645643E393B7E797BFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000
                000000000000FFFFFFFFFFFFFFFFFFFFFFFF7D7B7B3530325E595B2D516F274B
                69204864274F6B3C393B7C797BFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
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
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFF7876762D282A595456294D6B2145632C5470
                325A762C292B757274FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000
                FF0000FF0000FF0000FF48538F1A1818222020191A18212220191717211F1F0F
                14138A8F8EFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
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
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
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
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
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
                FFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
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
                FFFFFF0000FFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FF000000FFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00
                00FFFFFFFF000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000
                000000FFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
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
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FF0000
                000000004B4C4A0000000000000000000000000000000000004C4A4A05030331
                314F0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFF000000
                000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000000000FFFFFF0000
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
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
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFF000000FF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFF0000FFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
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
                FFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
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
                FFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
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
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
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
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
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
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF4C4C4C4A0A09
                6E2E2DFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFB44745EC7F7DFFFFFFB5B7B766
                2F2AFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
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
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF780B09FFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFF780C0BFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
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
                FFFFFFFFFFFFFFB24645E67A79FFFFFFACB1B0662F2CFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFF5050504C0C0870302CFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
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
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
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
                FFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
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
                FFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
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
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
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
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
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
                FFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
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
                FFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
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
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
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
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
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
                FFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
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
                FFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
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
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
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
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
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
                FFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
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
                FFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
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
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
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
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
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
                FFFFFFFFFFFFFFFFFFFFFFFF0000}
            end
            object Image7: TImage
              Left = 510
              Top = 23
              Width = 130
              Height = 189
              Picture.Data = {
                07544269746D61709E210100424D9E2101000000000036000000280000008200
                0000BD000000010018000000000068210100130B0000130B0000000000000000
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
                FFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFB86D60962512911B07A74939E8D0CCFFFFFFB86D60962512911B07A7
                4939E8D0CCFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
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
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFD3A59DA54535FFFFFFFFFF
                FFFFFFFFFFFFFFD3A59DA54535FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFDFBFBA03B2AF8
                F0EFFFFFFFFFFFFFFFFFFFF8F0EFA03B2AFDFBFBF1E2DFA749399D3422DCB7B1
                911B07FFFFFFF1E2DFA749399D3422DCB7B1911B07FFFFFFEDDBD8AA5041911B
                07A23E2DEDDBD8FFFFFFAE5749921E0AFFFFFFAE5749921E0AFFFFFF911B07FF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFD7ACA5A23E2D911B07A23E2DD7ACA5FFFFFF
                FFFFFF911B07FFFFFFFFFFFFFFFFFF911B07FFFFFF911B07911B07911B07911B
                07911B07FFFFFF911B07911B07911B07911B07911B07FFFFFFEDDBD8A7493991
                1B07A94D3DEDDBD8FFFFFF911B07FFFFFFFFFFFFFFFFFF911B07FFFFFFAE5749
                921E0AFFFFFFD09E95962512972916CB938A911B07FFFFFF911B07FFFFFF911B
                07FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFC17F73CC978EFFFFFFFFFFFFFFFFFFCB938AC17F73FFFFFFB15E50C9
                9086F2E5E3AA5041911B07FFFFFFB15E50C99086F2E5E3AA5041911B07FFFFFF
                AE5749C6897FFFFFFFD5A9A1A74939FFFFFF911B07F8F0EFFFFFFF911B07F8F0
                EFFFFFFF911B07FFFFFFFFFFFFFFFFFFFFFFFFDEBBB5A03B2AE6CCC8FFFFFFE6
                CCC8A03B2ADAB3ADFFFFFF911B07FFFFFFFFFFFFFFFFFF911B07FFFFFFCE9A92
                BD776CFFFFFFFFFFFFFFFFFFFFFFFFCE9A92BD776CFFFFFFFFFFFFFFFFFFFFFF
                FFAE5749C99086FBF7F7C99086AE5749FFFFFF911B07FFFFFFFFFFFFFFFFFF91
                1B07FFFFFF911B07F8F0EFFFFFFF94220EECD7D4F8F0EFBA7064911B07FFFFFF
                911B07FFFFFF911B07FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFE8D0CC911B07911B07911B07911B07911B07E8D0
                CCFFFFFF94220EFBF7F7FFFFFFF9F4F3911B07FFFFFF94220EFBF7F7FFFFFFF9
                F4F3911B07FFFFFF921E0AF8F0EFFFFFFFFFFFFFFFFFFFFFFFFF911B07FFFFFF
                FFFFFF911B07FFFFFFFFFFFF911B07FFFFFFFFFFFFFFFFFFFFFFFFAA5041E1C2
                BCFFFFFFFFFFFFFFFFFFDFBEB8AA5041FFFFFF911B07FFFFFFFFFFFFFFFFFF91
                1B07FFFFFFFFFFFFCE9A92C17F73FFFFFFFFFFFFFFFFFFFFFFFFCE9A92C17F73
                FFFFFFFFFFFFFFFFFF921E0AFBF7F7FFFFFFF9F4F3921E0AFFFFFF911B07FFFF
                FFFFFFFFFFFFFF911B07FFFFFF911B07FFFFFFFFFFFFA74939D3A59DE3C5C0EF
                DEDB911B07FFFFFF911B07FFFFFF911B07FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFA34231E1C2BCFFFFFF
                E1C2BCA34231FFFFFFFFFFFF94220EFBF7F7FFFFFFF9F4F3911B07FFFFFF9422
                0EFBF7F7FFFFFFF9F4F3911B07FFFFFF94220E911B07911B07911B07911B07FF
                FFFF911B07FFFFFFFFFFFF911B07FFFFFFFFFFFF911B07FFFFFFFFFFFFFFFFFF
                FFFFFF921E0AFDFBFBFFFFFFFFFFFFFFFFFFFBF7F7921E0AFFFFFF911B07FDFB
                FBFFFFFFFFFFFF911B07FFFFFFFFFFFFFFFFFFCE9A92C99086FFFFFFFFFFFFFF
                FFFFFFFFFFCE9A92C99086FFFFFFFFFFFF921E0AFBF7F7FFFFFFFBF7F7921E0A
                FFFFFF911B07FBF7F7FFFFFFFFFFFF911B07FFFFFF911B07FFFFFFFFFFFFF6ED
                EBC78C82B566589E3726911B07FFFFFF911B07FFFFFF911B07FFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFCC
                978EBC7468FFFFFFBC7468CC978EFFFFFFFFFFFFB05B4DC99086FBF7F7C78C82
                911B07FFFFFFB05B4DC99086FBF7F7C78C82911B07FFFFFFB05B4DDCB7B1FFFF
                FFDEBBB5A94D3DFFFFFF911B07FFFFFFFFFFFF911B07FFFFFFFFFFFF911B07FF
                FFFFFFFFFFFFFFFFFFFFFF921E0AFBF7F7FFFFFFFFFFFFFFFFFFFBF7F7921E0A
                FFFFFF911B07DCB7B1F9F4F3FFFFFF911B07FFFFFFFFFFFFFFFFFFFFFFFFCE9A
                92D2A299FFFFFFFFFFFFFFFFFFFFFFFFCE9A92D2A299FFFFFFAE5749C99086FB
                F7F7C99086AE5749FFFFFF911B07C99086FDFBFBDAB3AD921E0AFFFFFF911B07
                FFFFFFFFFFFFA23E2DDFBEB8FFFFFFECD7D4962512FFFFFF911B07FFFFFF911B
                07FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFF4E9E7992C1AF8F0EF972916F4E9E7FFFFFFFFFFFFEFDEDBA7
                4939972916CC978E911B07FFFFFFEFDEDBA74939972916CC978E911B07FFFFFF
                F2E5E3A94D3D911B07A74939EDDBD8911B07911B07911B07911B07911B07911B
                07FFFFFF911B07FFFFFFFFFFFFFFFFFFFFFFFFAA5041E1C2BCFFFFFFFFFFFFFF
                FFFFDFBEB8AA5041FFFFFF911B07CE9A92A23E2DFFFFFF911B07FFFFFF911B07
                911B07911B07911B07921E0AFFFFFF911B07911B07911B07911B07921E0AFFFF
                FFEDDBD8A94D3D911B07A94D3DEDDBD8FFFFFF911B07C78C829D3422921E0ADA
                B3AD911B07911B07911B07FFFFFFE5C9C4A54535911B07992C1AD3A59DFFFFFF
                911B07FFFFFF911B07FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFB05B4DBA7064B05B4DFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF911B07FFFFFF
                FFFFFF911B07FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFDAB3ADA23E
                2DE6CCC8FFFFFFE6CCC89E3726DAB3ADFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFF911B07FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFF911B07FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFD9B0A9911B07
                D9B0A9FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFB05B4DFFFFFFFFFFFFB05B4DFFFFFFFFFFFF911B07FFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFD7ACA5A03B2A911B07A03B2AD7ACA5FFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFF911B07FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFB05B4DFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF911B07FFFFFF911B07FFFFFFFFFFFFFF
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
                FFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFBEBFBD7A7A7A6B6B6B7974736F6A697772746E696B7772746E696B
                7573736D6B6B7673756C696B7572746562646E6C6C7C7A7AC5C7C7FFFFFFFFFF
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
                FFFFFFFFFFFFFFFFFFFFFFFFFF7273711010105353534E49485651504E494B56
                51534D484A5651534A48485351514B484A5451534B484A434042535151131111
                707272FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF717270666464BEBCBC58B4
                E358B4E365B5DE6BBBE4A1C4D1ABCEDBCED7DBCAD3D7BCD2D8B9CFD5BACED9BB
                CFDA9CD0E72E6279747173FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF7A7B79
                535151B6B4B44EAAD94EAAD961B1DA6ABAE3A0C3D0A1C4D1B8C1C5B7C0C4ACC2
                C8ABC1C7A9BDC8A6BAC589BDD41C50677B787AFFFFFFFFFFFFFFFFFFFFFFFFFF
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
                FFFFFFFFFF7072725E595BB9B4B657AEDA58AFDB9FBBC6A8C4CFB8C2C9B5BFC6
                AEC1C9AFC2CAB1C1C7AFBFC57ABAD971B1D060B3E0045784777273FFFFFFFFFF
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
                FFFFFFFFFFFFFFFFFFFFFFFFFF797B7B555052BBB6B859B0DC62B9E5A5C1CCA5
                C1CCB5BFC6B4BEC5AFC2CAB1C4CCB1C1C7A9B9BF6FAFCE6EAECD5DB0DD004E7B
                7D7879FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF7073715B575CB9B5BA9EBB
                C9A6C3D1B5C4C7B3C2C5A6C4C5A5C3C4A8C0CCA9C1CD7CBCDA70B0CE60AED960
                AED966B6DB06567B787473FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF797C7A
                534F54C3BFC4A4C1CFA7C4D2B4C3C6B4C3C6A3C1C2A8C6C7A6BECAA3BBC76FAF
                CD70B0CE60AED963B1DC66B6DB0151767D7978FFFFFFFFFFFFFFFFFFFFFFFFFF
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
                FFFFFFFFFF70727259585CCAC9CDBFC5CABDC3C8B4C1C9B5C2CABEC6C6BBC3C3
                74B9DA6BB0D15EADD85EADD866B4D863B1D55CB1DE015683767173FFFFFFFFFF
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
                FFFFFFFFFFFFFFFFFFFFFFFFFF787A7A525155D2D1D5BCC2C7BCC2C7B3C0C8B7
                C4CCBBC3C3B3BBBB6AAFD069AECF60AFDA62B1DC61AFD360AED25AAFDC004E7B
                7E797BFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF7472725C595BCCC9CBB0C1
                CAAEBFC8ADC3C8ACC2C770B7D967AED054ACDA55ADDB5DAFD95DAFD959ADD757
                ABD54FB0E2005587767173FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF7E7C7C
                524F51CCC9CBB0C1CAAFC0C9A9BFC4A6BCC168AFD166ADCF55ADDB56AEDC5CAE
                D85DAFD959ADD757ABD54EAFE1004E807E797BFFFFFFFFFFFFFFFFFFFFFFFFFF
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
                FFFFFFFFFF7073715B585ACCC9CBA5C1CCA3BFCA79B9DB70B0D25CB1D95BB0D8
                64B1D861AED553ADD655AFD85AADDA58ABD851B0DB005883757274FFFFFFFFFF
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
                FFFFFFFFFFFFFFFFFFFFFFFFFF787B79535052D3D0D2A0BCC79BB7C26FAFD16F
                AFD159AED65BB0D862AFD663B0D755AFD854AED759ACD959ACD952B1DC00507B
                7C797BFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF7272725E595AC9C4C56BB4
                DA63ACD25EAED75EAED759B0DC56ADD95CADDA5CADDA56ABD855AAD752ACDB51
                ABDA59B2DE005783747173FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF7B7B7B
                555051C5C0C165AED465AED45FAFD85FAFD852A9D557AEDA5BACD95DAEDB57AC
                D958ADDA50AAD952ACDB58B1DD004F7B7C797BFFFFFFFFFFFFFFFFFFFFFFFFFF
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
                FFFFFFFFFF7271735D5958B9B5B44EABDC52AFE06AB1D668AFD45AAFD759AED6
                4FAEDA4FAEDA51ADD854B0DB56ACDA56ACDA52B1DD005783767173FFFFFFFFFF
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
                FFFFFFFFFFFFFFFFFFFFFFFFFF7B7A7C555150B7B3B24FACDD52AFE069B0D567
                AED35BB0D858ADD54EADD94EADD952AED951ADD856ACDA57ADDB51B0DC00507C
                7E797BFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF7171715A595BB1B0B25BAF
                D95AAED857AFD856AED754ACDA55ADDB57AEDA55ACD84BADDD49ABDB4EADD84F
                AED95DB2E0005583767173FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF7B7B7B
                504F51B5B4B65AAED85AAED857AFD856AED754ACDA55ADDB58AFDB56ADD948AA
                DA49ABDB4FAED94EADD85EB3E1004E7C7D787AFFFFFFFFFFFFFFFFFFFFFFFFFF
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
                FFFFFFFFFF7072735D5A5CB9B6B860AFD660AFD656AED756AED754ABDD53AADC
                51ACD952ADDA55ABD956ACDA52ADDA52ADDA57B3DE005883727173FFFFFFFFFF
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
                FFFFFFFFFFFFFFFFFFFFFFFFFF787A7B524F51BBB8BA61B0D75FAED557AFD857
                AFD854ABDD52A9DB53AEDB54AFDC56ACDA55ABD952ADDA52ADDA55B1DC004F7A
                7A797BFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF6F71715C595BB8B5B761B1
                DA5DADD659ACD95AADDA53B2D353B2D355ABD955ABD958AFD758AFD756ADD956
                ADD95BB3DC005780777176FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF7A7C7C
                535052B6B3B55EAED75FAFD859ACD95AADDA4FAECF54B3D455ABD957ADDB58AF
                D758AFD757AEDA58AFDB5AB2DB00517A7E787DFFFFFFFFFFFFFFFFFFFFFFFFFF
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
                FFFFFFFFFF72717359585AB5B4B658AFDB56ADD95CB1D95AAFD752AED951ADD8
                4FADDB4EACDA51ADD854B0DB62AFD662AFD669B6DD0A577E767075FFFFFFFFFF
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
                FFFFFFFFFFFFFFFFFFFFFFFFFF7B7A7C515052B8B7B957AEDA57AEDA59AED659
                AED653AFDA51ADD84DABD94EACDA53AFDA52AED963B0D763B0D767B4DB014E75
                7E787DFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF7170725C595BB6B3B557AD
                D757ADD756ADD956ADD952AED952AED959ADD759ADD761B0D762B1D860AFD65E
                ADD458B3E0005683757373FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF7B7A7C
                535052B6B3B559AFD958AED856ADD956ADD952AED954B0DB5CB0DA5AAED860AF
                D663B2D960AFD65EADD458B3E0004F7C7C7A7AFFFFFFFFFFFFFFFFFFFFFFFFFF
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
                FFFFFFFFFF7171715C5A5AB4B2B252AFDC52AFDC5CAED85CAED85AAFD75CB1D9
                62B0D564B2D75FB0D65EAFD559AEDB58ADDA5DB3DD015781767172FFFFFFFFFF
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
                FFFFFFFFFFFFFFFFFFFFFFFFFF7A7A7A545252BAB8B84FACD94FACD95BADD75D
                AFD95BB0D85CB1D964B2D764B2D760B1D75DAED457ACD957ACD95BB1DB004E78
                7E797AFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF6F71715D585ABAB5B757AF
                D856AED758AED859AFD968B0D868B0D861B2D75FB0D560AFD660AFD656ABD958
                ADDB78B9D5175874757274FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF797B7B
                555052BAB5B758B0D956AED756ACD65AB0DA65ADD568B0D85EAFD45FB0D561B0
                D760AFD657ACDA58ADDB80C1DD10516D7C797BFFFFFFFFFFFFFFFFFFFFFFFFFF
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
                FFFFFFFFFF6E73725C595BB7B4B66AAFD66AAFD666AFD564ADD361B1DA5FAFD8
                5FB0D65FB0D65EAFD55EAFD562AFD666B3DAB4C7CA485B5E747075FFFFFFFFFF
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
                FFFFFFFFFFFFFFFFFFFFFFFFFF757A79545153BAB7B96BB0D76EB3DA68B1D767
                B0D65DADD65FAFD85FB0D660B1D760B1D75DAED465B2D96EBBE2BBCED13F5255
                7C787DFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF7272725A5A5AB4B4B460AF
                DA63B2DD66B2D663AFD356AED655ADD54EABDC50ADDE65B0D668B3D9A7BDC8AD
                C3CEC7CFCF525A5A727272FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF7B7B7B
                505050B7B7B75EADD85EADD864B0D465B1D557AFD754ACD44BA8D94FACDD66B1
                D76FBAE0ACC2CDADC3CECCD4D44A52527B7B7BFFFFFFFFFFFFFFFFFFFFFFFFFF
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
                FFFFFFFFFF6F7171545153B4B1B352AED951ADD84BABD94BABD95CAEDD5AACDB
                5AADD361B4DAB2C1C3B9C8CABDC8C6BBC6C4B7CAD240535B736F74FFFFFFFFFF
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
                FFFFFFFFFFFFFFFFFFFFFFFFFF7072725C595BB8B5B753AFDA53AFDA4BABD94C
                ACDA58AAD959ABDA61B4DA69BCE2B8C7C9B8C7C9BBC6C4BAC5C3B4C7CF455860
                757176FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF777979565153BBB6B85DAE
                D45DAED44DACD84DACD85FB3CD64B8D2A8BCC7ADC1CCB3C6CBB0C3C89ABECE96
                BACA74BFE5034E747D7A7CFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF717373
                5D585AB9B4B660B1D75EAFD54EADD94FAEDA62B6D06FC3DDADC1CCADC1CCAFC2
                C7AEC1C696BACA90B4C463AED40D587E747173FFFFFFFFFFFFFFFFFFFFFFFFFF
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
                FFFFFFFFFF787A7A535052B9B6B854AFDC54AFDC68AFD06EB5D6ACC1C9B1C6CE
                B7C3C9B6C2C89DBECD9ABBCA66B4D960AED343ADE2004D827F7A7CFFFFFFFFFF
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
                FFFFFFFFFFFFFFFFFFFFFFFFFF7072725C595BB4B1B351ACD954AFDC70B7D877
                BEDFAFC4CCAFC4CCB8C4CAB4C0C69BBCCB92B3C260AED35DABD040AADF00578C
                746F71FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF787A7B555051B5B0B161AE
                D56AB7DEB4C2C1B8C6C5B4C2C8B6C4CAABC1CCA6BCC768B3D963AED44EABD84E
                ABD84AB0E1004E7F7B7B7BFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF707273
                5E595AB6B1B269B6DD70BDE4B8C6C5B8C6C5B5C3C9B2C0C6A9BFCA9EB4BF63AE
                D461ACD251AEDB4DAAD749AFE0005788727272FFFFFFFFFFFFFFFFFFFFFFFFFF
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
                FFFFFFFFFF7C7A79545055C2BEC3B1C0C3B8C7CAB7C4CCB4C1C9AEC3CBACC1C9
                77B8D76DAECD4EACDA4FADDB4CADD94CADD94EADDE004D7E7F7A7CFFFFFFFFFF
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
                FFFFFFFFFFFFFFFFFFFFFFFFFF7371705A565BCAC6CBB9C8CBB6C5C8B3C0C8B2
                BFC7AABFC7A8BDC570B1D069AAC94EACDA50AEDC4CADD94DAEDA4FAEDF005687
                757072FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF797B7B4F5152CDCFD0BFC7
                C7BBC3C3A5C0CAA5C0CA67B5D962B0D440A8DD3FA7DC4CA9DA4FACDD4DAEDA4A
                ABD750B2E0004E7C7D7B7BFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF717373
                57595ACBCDCEBDC5C5BAC2C2A5C0CA9CB7C15DABCF5FADD140A8DD41A9DE4FAC
                DD4DAADB4AABD74EAFDB48AAD8005886737171FFFFFFFFFFFFFFFFFFFFFFFFFF
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
                FFFFFFFFFF797979555150D7D3D2ADC0C8ABBEC670B4D76CB0D341A7DC40A6DB
                48A9DB46A7D942A7DB45AADE45A9D947ABDB4AAEDE004E7E7E7976FFFFFFFFFF
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
                FFFFFFFFFFFFFFFFFFFFFFFFFF7272725D5958CCC8C7B5C8D0A6B9C16FB3D668
                ACCF43A9DE41A7DC4BACDE48A9DB46ABDF44A9DD49ADDD47ABDB49ADDD005686
                7D7875FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF7B7A7C525351BEBFBD91AE
                BD92AFBE79A8BE7BAAC071A5BC75A9C07AA6BE7DA9C173A7BE76AAC17AA9BF78
                A7BD7CAEC51F5168636387FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF7A797B
                0203010203010001100001100000160001170001180002190001190000170001
                180000170000160002180001180000175151750000FF0000FF0000FF0000FF00
                00FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF
                0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000
                FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFF7A7A7A3B39398987877C7C7C8686867A7B77535450033696053898
                003792073E997E7C7C8886867D7A7C030002868987373A38858585FFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF58585811120EC3C4C0FFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFF737373888686FFFFFFFFFFFFFFFFFFFFFFFF2A
                89FE6396F66497F76299F42A89FEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF848785
                727272FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF393939020202020300020300
                ADAEAAFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF7A7A7A757274FFFFFFFFFF
                FFFFFFFFFFFFFF2A89FEEDD47EE2D480B3C5822A89FEFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFF7073717B7A7EFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF84878571
                74725353537A7A7ABBC0BEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF737373
                737072FFFFFFFFFFFFFFFFFFFFFFFF2A89FEDAD07EE9D47ED8D0802A89FEFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFF707371717074FFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFF7B7B7B757274FFFFFFFFFFFFFFFFFFFFFFFF2A89FEB4C884D6D081
                EDD47E2A89FEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF7272727B7A7CFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFF7272727C797BFFFFFFFFFFFFFFFFFFFFFFFF2A
                89FED5CF80E0D280E3D37E2A89FEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF7B7B7B
                727173FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF7B7B7B747173FFFFFFFFFF
                FFFFFFFFFFFFFF2A89FEEDD47EE3D37FB8CA822A89FEFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFF7272727F7A7CFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF727272
                747173FFFFFFFFFFFFFFFFFFFFFFFF2A89FEE5D37EEAD47ECECE802A89FEFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFF737373767173FFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFF7B7B7B757274FFFFFFFFFFFFFFFFFFFFFFFF2A89FEC0CC81D6D180
                ECD47E2A89FEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF7272727D7A7CFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFF7272727D7A7CFFFFFFFFFFFFFFFFFFFFFFFF2A
                89FEC4CD81D9D280EAD47E2A89FEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF7B7B7B
                737072FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF7B7B7B757274FFFFFFFFFF
                FFFFFFFFFFFFFF2A89FEE8D37EE7D47EC9CD802A89FEFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFF7272727C797BFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF737373
                747173FFFFFFFFFFFFFFFFFFFFFFFF2A89FEEBD47EE5D37FBCCB812A89FEFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFF727272747173FFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFF7B7B7B757274FFFFFFFFFFFFFFFFFFFFFFFF2A89FECFCF80DCD280
                E5D37E2A89FEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF7272727D7A7CFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFF7272727C797BFFFFFFFFFFFFFFFFFFFFFFFF2A
                89FEB3CA82D4D181EDD47E2A89FEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF7B7B7B
                747173FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF7B7B7B747173FFFFFFFFFF
                FFFFFFFFFFFFFF2A89FEE0D27EECD47ED6D07F2A89FEFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFF7272727F7A7CFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF727272
                747173FFFFFFFFFFFFFFFFFFFFFFFF2A89FEEED57EE2D37FB7CA822A89FEFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFF737373767173FFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFF7B7B7B757274FFFFFFFFFFFFFFFFFFFFFFFF2A89FEDCD17FE7D37E
                DDD27F2A89FEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF7272727D7A7CFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFF7272727D7A7CFFFFFFFFFFFFFFFFFFFFFFFF2A
                89FEAFC883D6D181EDD47E2A89FEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF7B7B7B
                737072FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF7B7B7B757274FFFFFFFFFF
                FFFFFFFFFFFFFF2A89FED3D07FE1D37FE2D27E2A89FEFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFF7272727E797BFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF737373
                747173FFFFFFFFFFFFFFFFFFFFFFFF2A89FEEDD47EE2D37FBBCA822A89FEFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFF727272767173FFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFF7B7B7B747173FFFFFFFFFFFFFFFFFFFFFFFF2A89FEE4D37EECD47E
                CECF7F2A89FEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF7072727D7A7CFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFF7272727D7A7CFFFFFFFFFFFFFFFFFFFFFFFF2A
                89FEBECB80D7D180EDD47E2A89FEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF797B7B
                757274FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF747474747173FFFFFFFFFF
                FFFFFFFFFFFFFF2A89FE8DC387D5D283E8D37E2A89FEFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFF737373737072FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF7A7A7A
                757274FFFFFFFFFFFFFFFFFFFFFFFF2A89FEE8D47EE5D37FC2CD812A89FEFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFF7373737D7A7CFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFF7272727D7A7CFFFFFFFFFFFFFFFFFFFFFFFF2A89FEEAD47EE5D37F
                C5CE802A89FEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF7A7A7A747173FFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFF7C7C7C737072FFFFFFFFFFFFFFFFFFFFFFFF2A
                89FEC9CD80DAD180E7D37E2A89FEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF737373
                7D7A7CFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF717171757274FFFFFFFFFF
                FFFFFFFFFFFFFF2A89FEB9CC81D4D180EED57E2A89FEFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFF727272777274FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF7C7C7C
                747173FFFFFFFFFFFFFFFFFFFFFFFF2A89FEE2D27EEED57ED2D07F2A89FEFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFF7373737D787AFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0E1011FFFFFFFFFFFF
                FFFFFFFFFFFF480807FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFF7272727D7A7CFFFFFFFFFFFFFFFFFFFFFFFF2A89FEEED57EE3D37E
                BACB832A89FEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF7A7A7A777274FFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF13
                1111FFFFFFFFFFFFFFFFFFFFFFFF810300FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFF7B7B7B747173FFFFFFFFFFFFFFFFFFFFFFFF2A
                89FED7D07EE3D37FE0D27E2A89FEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF727272
                7F7A7CFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFF131111FFFFFFFFFFFFFFFFFFFFFFFF820400FFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF737373747173FFFFFFFFFF
                FFFFFFFFFFFFFF2A89FEACC981D3D180ECD47E2A89FEFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFF707272777274FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF111111FFFFFFFFFFFFFFFFFFFFFFFF8003
                00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF7B7B7B
                747173FFFFFFFFFFFFFFFFFFFFFFFF2A89FED9D17EE5D37EDCD17F2A89FEFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFF7173737E797BFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF1111114909054B0B07
                4A09084B0A09820501FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFF7272727D7A7CFFFFFFFFFFFFFFFFFFFFFFFF2A89FEEED57EE2D37F
                B8CB832A89FEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF7A797B767173FFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0D
                1211FFFFFFFFFFFFFFFFFFFFFFFF840300FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFF7A7A7A747173FFFFFFFFFFFFFFFFFFFFFFFF2A
                89FEE0D27FEED57ED3D0802A89FEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF737274
                7E797BFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFF0D1211FFFFFFFFFFFFFFFFFFFFFFFF850401FFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF737373757274FFFFFFFFFF
                FFFFFFFFFFFFFF2A89FEB3CD7ED3D27FEED57E2A89FEFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFF737373747173FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF131111FFFFFFFFFFFFFFFFFFFFFFFF470A
                08FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF7B7B7B
                747173FFFFFFFFFFFFFFFFFFFFFFFF2A89FEC9CF7DDAD37FE6D37E2A89FEFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFF7373737C797BFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFF7272727D7A7CFFFFFFFFFFFFFFFFFFFFFFFF2A89FEEBD47EE5D37E
                C0CC822A89FEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF7A7A7A757274FFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFF7B7B7B747173FFFFFFFFFFFFFFFFFFFFFFFF2A
                89FEE9D47EE7D47EC7CD802A89FEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF727272
                7D7A7CFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF737373747173FFFFFFFFFF
                FFFFFFFFFFFFFF2A89FEC7CE81DAD280EAD47E2A89FEFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFF727272757274FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF7B7B7B
                747173FFFFFFFFFFFFFFFFFFFFFFFF2A89FEBCCB81D7D281ECD47E2A89FEFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFF7373737C797BFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFF7272727D7A7CFFFFFFFFFFFFFFFFFFFFFFFF2A89FEE5D37EEAD47E
                D2CF802A89FEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF787A7A747173FFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFF7A7A7A747173FFFFFFFFFFFFFFFFFFFFFFFF2A
                89FEEDD47EE3D37FB9CA822A89FEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF717373
                7C797BFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF737373757274FFFFFFFFFF
                FFFFFFFFFFFFFF2A89FED5D07FE0D27FE1D27E2A89FEFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFF737373747173FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF7B7B7B
                747173FFFFFFFFFFFFFFFFFFFFFFFF2A89FEADC781D4D181ECD47E2A89FEFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFF7373737C797BFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFF7272727D7A7CFFFFFFFFFFFFFFFFFFFFFFFF2A89FEDAD27FE7D47E
                DCD17F2A89FEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF787A7A757274FFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFF7B7B7B747173FFFFFFFFFFFFFFFFFFFFFFFF2A
                89FEEED57EE1D37FB8C9812A89FEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF707272
                7D7A7CFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF737373747173FFFFFFFFFF
                FFFFFFFFFFFFFF2A89FEE0D27FEBD47ED6D17F2A89FEFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFF727272757274FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF7B7B7B
                747173FFFFFFFFFFFFFFFFFFFFFFFF2A89FEB0C882D5D181EDD47E2A89FEFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFF7373737C797BFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFF7272727D7A7CFFFFFFFFFFFFFFFFFFFFFFFF2A89FED0CF80DCD280
                E5D37E2A89FEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF7A7A7A747173FFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFF7A7A7A747173FFFFFFFFFFFFFFFFFFFFFFFF2A
                89FEECD47EE5D37FBCCB822A89FEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF737373
                7C797BFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF737373757274FFFFFFFFFF
                FFFFFFFFFFFFFF2A89FEE7D37EE9D47ECACE802A89FEFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFF737373747173FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF7B7B7B
                747173FFFFFFFFFFFFFFFFFFFFFFFF2A89FEC1CC80D7D281EBD47E2A89FEFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFF7373737C797BFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFF7373737F7A7BFFFFFFFFFFFFFFFFFFFFFFFF2A89FEC0CD82D6D180
                EBD47E2A89FEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF7A7A7A777273FFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFF7B7B7B767172FFFFFFFFFFFFFFFFFFFFFFFF2A
                89FEE6D37EE9D47ECACD812A89FEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF727272
                7E797AFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF737373727173FFFFFFFFFF
                FFFFFFFFFFFFFF2A89FEEBD47EE3D37FB6CB822A89FEFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFF747272747173FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF7C7C7C
                727173FFFFFFFFFFFFFFFFFFFFFFFF2A89FED0CE80DED27FE3D37E2A89FEFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFF7573737D7A7CFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFF7372747C797BFFFFFFFFFFFFFFFFFFFFFFFF2A89FEADCA83D3D181
                EDD47E2A89FEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF7A7A7A747075FFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFF7A797B747173FFFFFFFFFFFFFFFFFFFFFFFF2A
                89FEDED17EEAD47ED8D07F2A89FEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF737373
                7D797EFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF727173747173FFFFFFFFFF
                FFFFFFFFFFFFFF2A89FEEDD47EDED37FA0CF842A89FEFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFF717373747075FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF747375
                747173FFFFFFFFFFFFFFFFFFFFFFFF2A89FEC5C26EE2D17BC1C06D2A89FEFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFF717373757176FFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFF4949491212120508060104024B4948FFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFF7A7A7A666B6AFFFFFFFFFFFFFFFFFFFFFFFF2A89FE2A89FE2A89FE
                2A89FE2A89FEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF6A6B697A797BFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0B0C1A00001118192DFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFF7A7A7A00020100030204000004000001010101
                0101000037000038000036000035000001000001000000010101010200010200
                858486FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF2F3044FFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF8386842A262B6561663358
                6C3D62764F59595862625A615E5D64613E576748617129586E3261772E586F15
                3F5636627900273E8785850000FF0000FF0000FF0000FF0000FF0000FF0000FF
                0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000
                FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF00
                00FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF
                0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000
                FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF00
                00FF0000FF0000FF0000FF0000FF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF6F7270
                666267BCB8BD97BCD0A1C6DAC7D1D1C7D1D1CBD2CFC9D0CDA6BFCFA1BACA87B6
                CC84B3C98BB5CC8AB4CB8EBAD1335F76747272FFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFF000025FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFF7A7A7A575053BDB6B999BAC9A1C2D1B9C4C8B4BFC39EBFCF9ABBCB
                60B1D65EAFD457AEDA55ACD851ACD952ADDA59B5E000507B7D7B7BFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFF000000090C0A030402FFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFF7272725D5659C7C0C3A0C1D0A2C3D2B8C3C7B2
                BDC19ABBCB97B8C85FB0D55DAED357AEDA56ADD952ADDA51ACD954B0DB005782
                747272FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000001013110003010203016C6D6B
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFE9E5E4484443602A29FBC5C4490A06FFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF777A78565051D4CECFB4C5
                C8B3C4C7B4C2C8B2C0C684BDCC7FB8C77DB2D37CB1D25EAFD45DAED358ABD859
                ACD95BB0DD004D7A7B787AFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF12
                1113FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFB54747E97B7BDCD6D7322C2D830200FFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF727573
                5E5859CCC6C7B2C3C6B3C4C7B5C3C9B3C1C781BAC982BBCA7FB4D580B5D661B2
                D75EAFD45BAEDB5BAEDB59AEDB025784747173FFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF780A0AFFE7E7FFF9FAFAF4F5
                840300FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFF7A7A7A525153CECDCFB8C3C7B9C4C8A5C2D0A7C4D2A6C0C7A2BCC3
                86B5D086B5D076B5D172B1CD63AFD365B1D567B7E0004F787D7B7BFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF770B07FF
                ECE8FAFEFFEFF3F4840202FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFF71717159585ACCCBCDBAC5C9B3BEC29DBAC8A0
                BDCBAAC4CBA9C3CA8AB9D483B2CD77B6D277B6D269B5D964B0D463B3DC075780
                757373FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFB54945EC807CF7FBFC868A8B830101FFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF7A7A7A525153D4D3D597BE
                D48CB3C95EADD665B4DD94BFCE99C4D3B3C1C7AFBDC385B5CD87B7CF81B7D07C
                B2CB67B2D9034E757D7B7BFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0A
                090BFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFE3DDDE453F404E110FE7AAA8810300FFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF717171
                59585AC6C5C78FB6CC87AEC465B4DD65B4DD90BBCA95C0CFB6C4CAB3C1C78CBC
                D487B7CF82B8D181B7D06BB6DD0B567D737171FFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FF000000121113000000030402000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                800200FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFF7C7D7B544F50BFBABB4AABDD4BACDE6BB2D771B8DD7CB7D17CB7D1
                93BCD299C2D8AFBFC6AEBEC587B9CF84B6CC7DBDDC10506F7B787AFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFF00000000010B4D4C5CFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFF4B0A09FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFF7172705E595AB3AEAF49AADC49AADC67AED36B
                B2D77BB6D078B3CD8EB7CD97C0D6B3C3CAB2C2C988BAD085B7CD79B9D8165675
                6C696BFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF01030DFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF787A7B535052B2AFB141AA
                DD40A9DC48AADA4EB0E05FB1DB5BADD773B3D27ABAD9A0BFCEA2C1D0A4BFC9A0
                BBC588BBD52D607A1212121818181D212214181920212517181C18212A0D161F
                151E270F18210E1F2C05162310202C0717230B1F310115270F1F2F0616261B1E
                2613161E0B212D01172309202F001625151E2B0D1623101F2F06152518212A0C
                151E1E212614171C161F2C0C152214202C0B17230F1F2B06162210202C071723
                091E3300152A00000B10202D17171D1F1F2515191A1D21220D18201520280018
                28051F2F1A1A200000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF00
                00FF0000FF0000FF0000FF0000FF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF717374
                5B585AB6B3B541AADD41AADD49ABDB4AACDC57A9D35DAFD975B5D478B8D79DBC
                CBA1C0CFA7C2CCA7C2CC8ABDD72F627C2F2F2F7171716A6E6F6B6F706C6D7161
                62664D565F5C656E565F6850596241525F41525F42525E3C4C58304456364A5C
                4050604F5F6F60636B5C5F67394F5B364C583047563E55644D56634E57644453
                63435262565F68626B7465686D5C5F64525B685059664A566248546040505C43
                535F40505C3E4E5A31465B33485D4757645464716B6B716E6E74686C6D686C6D
                525D65414C542E48584862720F0F15FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFF787A7B535052B4B1B352ACDB52ACDB4FABDA50ACDB49ABD94CAEDC
                5AB2DB5EB6DF88B7D28CBBD6A6C2CDA8C4CFB3CDD3405A603A363B8682878388
                897B8081727C83606A715E717E576A774F697A46607129506C284F6B2F54702B
                506C294D652D5169486171587181737D7D6872725067773E55652A4C69254764
                315775365C7A4B6575516B7B727E80727E807A8387646D7160717A5B6C754D67
                75405A68284F6F284F6F3F5D7637556E2E4E6535556C5F6D7378868C80838187
                8A8878807F78807F5569743E525D18456A164368171816FFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFF6F71725B585AB5B2B450AAD950AAD950ACDB4F
                ABDA49ABD948AAD857AFD85BB3DC88B7D287B6D1A3BFCAA4C0CBAFC9CF405A60
                3A363B8783887B8081787D7E6D777E636D74566976526572476172445E6F2C53
                6F1E4561264B67264B67395D75456981587181607989737D7D6F7979556C7C4F
                66763658752C4E6B2046642F5573496373577181707C7E75818370797D677074
                5E6F785B6C754C6674486270264D6D234A6A3C5A7343617A43637A4B6B826E7C
                827482888083817F8280767E7D6F7776556974475B661B486D18456A171816FF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF7A797B545252B9B7B74DAA
                DB4CA9DA42A8DC43A9DD47ACD945AAD747A9D94CAEDE62B2D764B4D987B8D28A
                BBD5A4C4D13959663A363B8480856B7B8269798064767D5D6F764B6575445E6E
                395B723E60773C5B723251683E5869435D6E687476717D7F7B807E7C817F777E
                816E7578586C7D5064754462733F5D6E2C4F69264963436474557686757B8076
                7C816879825E6F785168784D64744061753E5F73415C70324D61355366527083
                707878767E7E798180798180757E8270797D65777E607279526979465D6D3054
                6C264A621B1918FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF727173
                5B5959B6B4B450ADDE4CA9DA41A7DB44AADE46ABD847ACD94AACDC4BADDD5EAE
                D361B1D684B5CF89BAD4A5C5D2395966322E33736F7460707764747B5D6F7657
                6970445E6E3D57672F516832546B39586F3D5C73546E7F5E7889758183768284
                8085837F8482737A7D6A71745165764B5F703D5B6C4260713C5F793558724061
                7158798972787D6F757A5D6E775A6B744C6373475E6E37586C3A5B6F445F7348
                63774C6A7D59778A7880807981817B838278807F6E777B6871755B6D74576970
                4A6171445B6B375B732C50681B1918FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFF7B7A7C535151B6B4B452ADDA4FAAD746A7D947A8DA54ACDA53ABD9
                49ABDB48AADA44A8DE4AAEE46DB4D671B8DA9DC7DA2E586B434343565656485B
                684E616E5B697553616D525F6D4754623C4E5F384A5B364D5D4B627280848583
                87888E9293878B8C9593938987877D84876B72755E6B734A575F4757684B5B6C
                69737A6B757C7C8085777B8070787F6169705B66745762705464704B5B673F53
                64384C5D4F5F6C65758289888C88878B8C8F9384878B787D7E80858669737A6D
                777E676E7760677047576746566650606D50606D171919FFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFF7271735B5959B6B4B452ADDA52ADDA4AABDD48
                A9DB52AAD853ABD94AACDC4AACDC44A8DE48ACE269B0D26CB3D593BDD0376174
                1010103232321427341326331725311826321724321A27351325361426371027
                3710273725292A242829242829262A2B2927272B292922292C21282B1B28301B
                28301424351727381E282F1D272E23272C24282D1F272E20282F1924321B2634
                16263216263211253612263716263316263328272B28272B25282C25282C2429
                2A24292A1E282F1E282F1E252E202730152535172737172734172734070909FF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF797C7A525155B3B2B651AF
                DA51AFDA4FADDB4AA8D63CADD83DAED94FABDA4FABDA48ACDC47ABDB50ACDD51
                ADDE74B9DA1257783A38377C7A797A7A7A7171717C7A797B7978747F756B766C
                7B777C7C787D777C7A6E73717B79797D7B7B777B7C6E7273797B7B787A7A7B7A
                7C7271737979797A7A7A767F756C756B7B777C7C787D787B79707371787A7B77
                797A7C7D7B70716F7B7B7B7A7A7A7C7A7A7472727A7A7A7A7A7A7580766B766C
                7B777C7C787D6F71717779797A7A7A7A7A7A7373737A7A7A7979797A7A7A797B
                7C3F41427A7A7AFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF717472
                59585CB5B4B850AED950AED94DABD94CAAD838A9D43EAFDA4EAAD951ADDC46AA
                DA46AADA4FABDC50ACDD6EB3D4125778878584FFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFF7A7A7A525153B5B4B657AFD854ACD54EAAD951ADDC50ADDA4DAAD7
                43A9DE44AADF46A9DB46A9DB4CADD94EAFDB5FB5DF004E787B7979FFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFF73737359585AB1B0B256AED756AED750ACDB4F
                ABDA51AEDB4EABD842A8DD42A8DD47AADC4AADDF4CADD94BACD85AB0DA004E78
                7B7979FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF797B7C565152B7B2B343A9
                DE46ACE155ACD855ACD851ABDA51ABDA4DABD94CAAD847AADE47AADE49ABDB4C
                AEDE65B4DF05547F6A6C6CFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFF
                FF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF6F7172
                5D5859B8B3B443A9DE45ABE055ACD856ADD952ACDB52ACDB4EACDA4EACDA46A9
                DD47AADE47A9D94CAEDE5BAAD5002D58000101FFFFFF000000000000FFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                000000000000FFFFFF535353FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFF7B7B7B545153B5B2B447AADC48ABDD49AADC4BACDE50AFD74EADD5
                4FACD950ADDA56ACDA54AAD84AA9DA4DACDD77B0CF002D4C0201030000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                00000000000000000000000000000000000D150EFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFF7272725B585AB6B3B547AADC46A9DB48A9DB49
                AADC4FAED64FAED650ADDA53B0DD56ACDA55ABD94CABDC51B0E184BDDC27607F
                424143FFFFFF000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000000000FFFFFF000000FFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF787A7B515052B7B6B851AF
                DA51AFDA51ADD851ADD848ABDD49ACDE5EAED75FAFD85CAED85BADD776B2D07B
                B7D5B2C8CE3B51578C8E8EFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFF
                FF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF717374
                59585AB4B3B550AED94FADD852AED951ADD843A6D849ACDE5EAED75DADD65BAD
                D75EB0DA7DB9D784C0DEAEC4CA455B616E7070FFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFF7A7A7A535052B3B0B24CABDC4BAADB54ACDA54ACDA4EAAD94FABDA
                4FADDB4FADDB67ADD271B7DCBAC4C4BBC5C5C3D3D94151577D797EFFFFFFFFFF
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
                FFFFFFFFFFFFFFFFFFFFFFFFFF7272725D5A5CB5B2B44CABDC4DACDD53ABD955
                ADDB50ACDB50ACDB4FADDB4EACDA71B7DC78BEE3BDC7C7BDC7C7B9C9CF4A5A60
                747075FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF787A7B525050BAB8B857AE
                DA53AAD648A9DB4AABDD50AFDB4FAEDA74B0CD7BB7D4A5BFC6ABC5CCB1C5CAAE
                C2C781C2E10E4F6E7A797BFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFF0E1010FFD3D16D302E8F3C3AFFDFDDFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF6F7172
                5D5B5BB6B4B456ADD956ADD949AADC49AADC4EADD952B1DD7EBAD783BFDCAAC4
                CBAAC4CBADC1C6A6BABF71B2D1175877727173FFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0F11117F4240FFD4D2D27F
                7DA24F4DFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFF707272555051B3AEAF41A8DF44ABE24CABDC4AA9DA74AED180BADD
                BCC5C9BCC5C9B3C3C9B1C1C77AB9D571B0CC42ABDE004E81767173FFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF100F13
                FCF8F7FFFEFDF5F2F41A1719FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFF797B7B565152B3AEAF41A8DF43AAE14BAADB4D
                ACDD7EB8DB86C0E3B9C2C6BBC4C8B0C0C6ADBDC372B1CD6EADC943ACDF004F82
                7F7A7CFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFF111014FAF6F5FFFEFDFAF7F9181517FFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF7272725D5A5CB2AFB144AA
                DA45ABDB70AECC7BB9D7A9C5C5ABC7C7BCC5C8B8C1C464B5DA5CADD24BA9DE4A
                A8DD4BAEE0005486767173FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFF0A1309AB7F85FFF4FAD6847F9C4A45FFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF7B7B7B
                524F51B4B1B346ACDC48AEDE7AB8D680BEDCA6C2C2ABC7C7B9C2C5B3BCBF5DAE
                D35BACD14CAADF4AA8DD4AADDF0050827E797BFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0A1309F8CCD25A2E348B39
                34FFD1CCFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFF7072735A5A5AB3B3B372B0CE7BB9D7B6C3C5B8C5C7B1C4C9B0C3C8
                81BAD975AECD3FA9DE3FA9DE43A9DA45ABDC4EAEDC005684757274FFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF111111
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFF787A7B525252BBBBBB7BB9D782C0DEB7C4C6B8
                C5C7B1C4C9ABBEC374ADCC71AAC93DA7DC3FA9DE44AADB45ABDC50B0DE004F7D
                7C797BFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFF101010FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF7472715C585DC5C1C6B3C3
                CAB4C4CBB2C5CAB1C4C989BED97DB2CD43A9DD41A7DB47A9D747A9D74AACDC49
                ABDB48AFE0005687757274FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF7D7B7A
                545055CBC7CCB3C3CAB3C3CAAFC2C7AABDC27CB1CC77ACC745ABDF44AADE4BAD
                DB4BADDB48AADA49ABDB48AFE0004F807C797BFFFFFFFFFFFFFFFFFFFFFFFFFF
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
                FFFFFFFFFF6F73745B585ACCC9CBAEC4CAACC2C879BAD96EAFCE42ABDE40A9DC
                41A9DE42AADF43AADB44ABDC44A9DD43A8DC47ABE100548A757274FFFFFFFFFF
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
                FFFFFFFFFFFFFFFFFFFFFFFFFF767A7B545153D3D0D2ABC1C7A4BAC06DAECD69
                AAC93FA8DB3FA8DB41A9DE40A8DD43AADB41A8D942A7DB45AADE44A8DE004C82
                7C797BFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF7171715B585ACAC7C976B8
                DB6AACCF43AADB43AADB40ACDC3EAADA43A8DC43A8DC3DA7DD3EA8DE3CA6DC3D
                A7DD44ABE200558C747173FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF7C7C7C
                535052C3C0C26CAED168AACD42A9DA44ABDC3BA7D740ACDC43A8DC45AADE3EA8
                DE3DA7DD3FA9DF3CA6DC43AAE1004D847C797BFFFFFFFFFFFFFFFFFFFFFFFFFF
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
                FFFFFFFFFF7273715C5758B8B3B440A8DD3EA6DB4AA9DA49A8D942A7DE42A7DE
                43A8DC44A9DD42A7DB42A7DB40A8DD3FA7DC41A9DE00568B757072FFFFFFFFFF
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
                FFFFFFFFFFFFFFFFFFFFFFFFFF7A7B79565152BAB5B641A9DE42AADF49A8D94A
                A9DA41A6DD42A7DE44A9DD43A8DC44A9DD44A9DD3DA5DA41A9DE43ABE0004E83
                7F7A7CFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF7373735D575CB4AEB354B1
                DE4EABD84AADDF45A8DA47AEDB44ABD843ACDF41AADD44ACE141A9DE4AAEDE45
                A9D93FAAE300558E767173FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF7A7A7A
                4F494EB5AFB445A2CF4AA7D43EA1D341A4D63CA3D041A8D539A2D53BA4D739A1
                D63CA4D93FA3D341A5D539A4DD00467F7F7A7CFFFFFFFFFFFFFFFFFFFFFFFFFF
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
                FFFFFFFFFF8286871A191B2120222422211C1A19222321191A1822212319181A
                2222221919192422221C1A1A2321210200001C1B171B1A168A8F8EFFFFFFFFFF
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
                FFFFFFFFFFFFFFFF0000}
            end
            object DBEdit49: TDBEdit
              Tag = 49
              Left = 90
              Top = 26
              Width = 35
              Height = 22
              BevelKind = bkFlat
              BorderStyle = bsNone
              Color = clWhite
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
              TabOrder = 0
            end
            object DBEdit50: TDBEdit
              Tag = 50
              Left = 90
              Top = 55
              Width = 35
              Height = 22
              BevelKind = bkFlat
              BorderStyle = bsNone
              Color = clWhite
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
              TabOrder = 2
            end
            object DBEdit51: TDBEdit
              Tag = 51
              Left = 90
              Top = 93
              Width = 35
              Height = 22
              BevelKind = bkFlat
              BorderStyle = bsNone
              Color = clWhite
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
              TabOrder = 4
            end
            object DBEdit52: TDBEdit
              Tag = 52
              Left = 90
              Top = 121
              Width = 35
              Height = 22
              BevelKind = bkFlat
              BorderStyle = bsNone
              Color = clWhite
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
              TabOrder = 6
            end
            object DBEdit53: TDBEdit
              Tag = 53
              Left = 90
              Top = 159
              Width = 35
              Height = 22
              BevelKind = bkFlat
              BorderStyle = bsNone
              Color = clWhite
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
              TabOrder = 8
            end
            object DBEdit54: TDBEdit
              Tag = 54
              Left = 90
              Top = 187
              Width = 35
              Height = 22
              BevelKind = bkFlat
              BorderStyle = bsNone
              Color = clWhite
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
              TabOrder = 10
            end
            object RxSpinButton9: TSpinButton
              Left = 127
              Top = 26
              Width = 20
              Height = 22
              DownGlyph.Data = {
                56000000424D56000000000000003E0000002800000006000000060000000100
                010000000000180000000000000000000000020000000200000000000000FFFF
                FF00CC0000008400000000000000CC000000CC000000CC000000}
              FocusControl = DBEdit49
              TabOrder = 1
              UpGlyph.Data = {
                56000000424D56000000000000003E0000002800000006000000060000000100
                010000000000180000000000000000000000020000000200000000000000FFFF
                FF00CC000000CC000000CC0000000000000084000000CC000000}
              OnDownClick = RxSpinButton1DownClick
              OnUpClick = RxSpinButton1UpClick
            end
            object RxSpinButton10: TSpinButton
              Left = 127
              Top = 55
              Width = 20
              Height = 22
              DownGlyph.Data = {
                56000000424D56000000000000003E0000002800000006000000060000000100
                010000000000180000000000000000000000020000000200000000000000FFFF
                FF00CC0000008400000000000000CC000000CC000000CC000000}
              FocusControl = DBEdit50
              TabOrder = 3
              UpGlyph.Data = {
                56000000424D56000000000000003E0000002800000006000000060000000100
                010000000000180000000000000000000000020000000200000000000000FFFF
                FF00CC000000CC000000CC0000000000000084000000CC000000}
              OnDownClick = RxSpinButton1DownClick
              OnUpClick = RxSpinButton1UpClick
            end
            object RxSpinButton11: TSpinButton
              Left = 127
              Top = 93
              Width = 20
              Height = 22
              DownGlyph.Data = {
                56000000424D56000000000000003E0000002800000006000000060000000100
                010000000000180000000000000000000000020000000200000000000000FFFF
                FF00CC0000008400000000000000CC000000CC000000CC000000}
              FocusControl = DBEdit51
              TabOrder = 5
              UpGlyph.Data = {
                56000000424D56000000000000003E0000002800000006000000060000000100
                010000000000180000000000000000000000020000000200000000000000FFFF
                FF00CC000000CC000000CC0000000000000084000000CC000000}
              OnDownClick = RxSpinButton1DownClick
              OnUpClick = RxSpinButton1UpClick
            end
            object RxSpinButton12: TSpinButton
              Left = 127
              Top = 121
              Width = 20
              Height = 22
              DownGlyph.Data = {
                56000000424D56000000000000003E0000002800000006000000060000000100
                010000000000180000000000000000000000020000000200000000000000FFFF
                FF00CC0000008400000000000000CC000000CC000000CC000000}
              FocusControl = DBEdit52
              TabOrder = 7
              UpGlyph.Data = {
                56000000424D56000000000000003E0000002800000006000000060000000100
                010000000000180000000000000000000000020000000200000000000000FFFF
                FF00CC000000CC000000CC0000000000000084000000CC000000}
              OnDownClick = RxSpinButton1DownClick
              OnUpClick = RxSpinButton1UpClick
            end
            object RxSpinButton13: TSpinButton
              Left = 127
              Top = 159
              Width = 20
              Height = 22
              DownGlyph.Data = {
                56000000424D56000000000000003E0000002800000006000000060000000100
                010000000000180000000000000000000000020000000200000000000000FFFF
                FF00CC0000008400000000000000CC000000CC000000CC000000}
              FocusControl = DBEdit53
              TabOrder = 9
              UpGlyph.Data = {
                56000000424D56000000000000003E0000002800000006000000060000000100
                010000000000180000000000000000000000020000000200000000000000FFFF
                FF00CC000000CC000000CC0000000000000084000000CC000000}
              OnDownClick = RxSpinButton1DownClick
              OnUpClick = RxSpinButton1UpClick
            end
            object RxSpinButton14: TSpinButton
              Left = 127
              Top = 187
              Width = 20
              Height = 22
              DownGlyph.Data = {
                56000000424D56000000000000003E0000002800000006000000060000000100
                010000000000180000000000000000000000020000000200000000000000FFFF
                FF00CC0000008400000000000000CC000000CC000000CC000000}
              FocusControl = DBEdit54
              TabOrder = 11
              UpGlyph.Data = {
                56000000424D56000000000000003E0000002800000006000000060000000100
                010000000000180000000000000000000000020000000200000000000000FFFF
                FF00CC000000CC000000CC0000000000000084000000CC000000}
              OnDownClick = RxSpinButton1DownClick
              OnUpClick = RxSpinButton1UpClick
            end
          end
          object GroupBox22: TGroupBox
            Left = 8
            Top = 19
            Width = 657
            Height = 161
            Caption = 'Attenuazione solare del vetro e degli schermi'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clHotLight
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            TabOrder = 0
            object Label65: TLabel
              Left = 8
              Top = 25
              Width = 160
              Height = 14
              Caption = 'Fattore di Shading dello schermo '
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
            end
            object Label110: TLabel
              Left = 264
              Top = 25
              Width = 98
              Height = 14
              Caption = '[1.00 = Trasparente]'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
            end
            object Label111: TLabel
              Left = 8
              Top = 52
              Width = 132
              Height = 14
              Caption = 'Fattore di Shading del vetro'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
            end
            object Label112: TLabel
              Left = 264
              Top = 52
              Width = 98
              Height = 14
              Caption = '[1.00 = Trasparente]'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
            end
            object SpeedButton7: TSpeedButton
              Left = 235
              Top = 21
              Width = 23
              Height = 23
              Glyph.Data = {
                36100000424D3610000000000000360000002800000020000000200000000100
                2000000000000010000000000000000000000000000000000000D8E9EC00D8E9
                EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
                EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
                EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
                EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
                EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
                EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
                EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
                EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
                EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
                EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
                EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
                EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
                EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
                EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
                EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
                EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
                EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
                EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
                EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
                EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
                EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
                EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
                EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
                EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
                EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
                EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
                EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
                EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
                EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
                EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
                EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
                EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
                EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
                EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
                EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
                EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
                EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00000000000000
                0000000000000000000000000000D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
                EC000000000000000000000000000000000000000000D8E9EC00D8E9EC00D8E9
                EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
                EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC0000000000FFFF
                FF00000000000000000000000000D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
                EC0000000000FFFFFF00000000000000000000000000D8E9EC00D8E9EC00D8E9
                EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
                EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC0000000000FFFF
                FF00000000000000000000000000D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
                EC0000000000FFFFFF00000000000000000000000000D8E9EC00D8E9EC00D8E9
                EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
                EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00000000000000
                00000000000000000000000000000000000000000000D8E9EC00000000000000
                00000000000000000000000000000000000000000000D8E9EC00D8E9EC00D8E9
                EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
                EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00000000000000
                0000FFFFFF00000000000000000000000000000000000000000000000000FFFF
                FF000000000000000000000000000000000000000000D8E9EC00D8E9EC00D8E9
                EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
                EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00000000000000
                0000FFFFFF00000000000000000000000000C0C0C0000000000000000000FFFF
                FF000000000000000000000000000000000000000000D8E9EC00D8E9EC00D8E9
                EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
                EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00000000000000
                0000FFFFFF00000000000000000000000000C0C0C0000000000000000000FFFF
                FF000000000000000000000000000000000000000000D8E9EC00D8E9EC00D8E9
                EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
                EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC000000
                0000000000000000000000000000000000000000000000000000000000000000
                000000000000000000000000000000000000D8E9EC00D8E9EC00D8E9EC00D8E9
                EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
                EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
                EC0000000000FFFFFF00000000000000000000000000D8E9EC0000000000FFFF
                FF00000000000000000000000000D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
                EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
                EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
                EC000000000000000000000000000000000000000000D8E9EC00000000000000
                0000000000000000000000000000D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
                EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
                EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
                EC00D8E9EC00000000000000000000000000D8E9EC00D8E9EC00D8E9EC000000
                00000000000000000000D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
                EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
                EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
                EC00D8E9EC0000000000FFFFFF0000000000D8E9EC00D8E9EC00D8E9EC000000
                0000FFFFFF0000000000D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
                EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
                EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
                EC00D8E9EC00000000000000000000000000D8E9EC00D8E9EC00D8E9EC000000
                00000000000000000000D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
                EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
                EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
                EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
                EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
                EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
                EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
                EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
                EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
                EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
                EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
                EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
                EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
                EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
                EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
                EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
                EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
                EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
                EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
                EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
                EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
                EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
                EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
                EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
                EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
                EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
                EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
                EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
                EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
                EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
                EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
                EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
                EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
                EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
                EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
                EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
                EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
                EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
                EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
                EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
                EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
                EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00}
              OnClick = SpeedButton7Click
            end
            object SpeedButton8: TSpeedButton
              Left = 235
              Top = 115
              Width = 23
              Height = 23
              Glyph.Data = {
                36100000424D3610000000000000360000002800000020000000200000000100
                2000000000000010000000000000000000000000000000000000D8E9EC00D8E9
                EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
                EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
                EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
                EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
                EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
                EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
                EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
                EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
                EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
                EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
                EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
                EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
                EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
                EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
                EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
                EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
                EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
                EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
                EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
                EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
                EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
                EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
                EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
                EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
                EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
                EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
                EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
                EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
                EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
                EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
                EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
                EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
                EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
                EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
                EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
                EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
                EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00000000000000
                0000000000000000000000000000D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
                EC000000000000000000000000000000000000000000D8E9EC00D8E9EC00D8E9
                EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
                EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC0000000000FFFF
                FF00000000000000000000000000D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
                EC0000000000FFFFFF00000000000000000000000000D8E9EC00D8E9EC00D8E9
                EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
                EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC0000000000FFFF
                FF00000000000000000000000000D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
                EC0000000000FFFFFF00000000000000000000000000D8E9EC00D8E9EC00D8E9
                EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
                EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00000000000000
                00000000000000000000000000000000000000000000D8E9EC00000000000000
                00000000000000000000000000000000000000000000D8E9EC00D8E9EC00D8E9
                EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
                EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00000000000000
                0000FFFFFF00000000000000000000000000000000000000000000000000FFFF
                FF000000000000000000000000000000000000000000D8E9EC00D8E9EC00D8E9
                EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
                EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00000000000000
                0000FFFFFF00000000000000000000000000C0C0C0000000000000000000FFFF
                FF000000000000000000000000000000000000000000D8E9EC00D8E9EC00D8E9
                EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
                EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00000000000000
                0000FFFFFF00000000000000000000000000C0C0C0000000000000000000FFFF
                FF000000000000000000000000000000000000000000D8E9EC00D8E9EC00D8E9
                EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
                EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC000000
                0000000000000000000000000000000000000000000000000000000000000000
                000000000000000000000000000000000000D8E9EC00D8E9EC00D8E9EC00D8E9
                EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
                EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
                EC0000000000FFFFFF00000000000000000000000000D8E9EC0000000000FFFF
                FF00000000000000000000000000D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
                EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
                EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
                EC000000000000000000000000000000000000000000D8E9EC00000000000000
                0000000000000000000000000000D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
                EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
                EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
                EC00D8E9EC00000000000000000000000000D8E9EC00D8E9EC00D8E9EC000000
                00000000000000000000D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
                EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
                EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
                EC00D8E9EC0000000000FFFFFF0000000000D8E9EC00D8E9EC00D8E9EC000000
                0000FFFFFF0000000000D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
                EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
                EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
                EC00D8E9EC00000000000000000000000000D8E9EC00D8E9EC00D8E9EC000000
                00000000000000000000D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
                EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
                EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
                EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
                EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
                EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
                EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
                EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
                EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
                EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
                EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
                EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
                EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
                EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
                EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
                EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
                EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
                EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
                EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
                EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
                EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
                EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
                EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
                EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
                EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
                EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
                EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
                EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
                EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
                EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
                EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
                EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
                EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
                EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
                EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
                EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
                EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
                EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
                EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
                EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
                EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
                EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00}
              Visible = False
              OnClick = SpeedButton8Click
            end
            object Label40: TLabel
              Left = 8
              Top = 82
              Width = 116
              Height = 14
              AutoSize = False
              Caption = 'Posizione dello schermo'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
            end
            object Label33: TLabel
              Left = 8
              Top = 112
              Width = 102
              Height = 41
              AutoSize = False
              Caption = 'Attenuazione solare '#13#10'   vetro + schermo'#13#10'        (Shading)'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
              Visible = False
              WordWrap = True
            end
            object Label35: TLabel
              Left = 264
              Top = 119
              Width = 24
              Height = 14
              AutoSize = False
              Caption = '[0..1]'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
              Visible = False
            end
            object Label164: TLabel
              Left = 416
              Top = 25
              Width = 162
              Height = 14
              Caption = 'Valori utilizzati nella Legge 10'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = [fsBold]
              ParentFont = False
              Visible = False
            end
            object Label165: TLabel
              Left = 416
              Top = 92
              Width = 214
              Height = 14
              Caption = 'Valori utilizzati nei carichi termici estivi'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = [fsBold]
              ParentFont = False
              Visible = False
            end
            object SpeedButton9: TSpeedButton
              Left = 235
              Top = 48
              Width = 23
              Height = 23
              Glyph.Data = {
                36100000424D3610000000000000360000002800000020000000200000000100
                2000000000000010000000000000000000000000000000000000D8E9EC00D8E9
                EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
                EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
                EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
                EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
                EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
                EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
                EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
                EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
                EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
                EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
                EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
                EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
                EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
                EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
                EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
                EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
                EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
                EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
                EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
                EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
                EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
                EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
                EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
                EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
                EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
                EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
                EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
                EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
                EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
                EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
                EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
                EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
                EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
                EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
                EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
                EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
                EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00000000000000
                0000000000000000000000000000D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
                EC000000000000000000000000000000000000000000D8E9EC00D8E9EC00D8E9
                EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
                EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC0000000000FFFF
                FF00000000000000000000000000D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
                EC0000000000FFFFFF00000000000000000000000000D8E9EC00D8E9EC00D8E9
                EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
                EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC0000000000FFFF
                FF00000000000000000000000000D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
                EC0000000000FFFFFF00000000000000000000000000D8E9EC00D8E9EC00D8E9
                EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
                EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00000000000000
                00000000000000000000000000000000000000000000D8E9EC00000000000000
                00000000000000000000000000000000000000000000D8E9EC00D8E9EC00D8E9
                EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
                EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00000000000000
                0000FFFFFF00000000000000000000000000000000000000000000000000FFFF
                FF000000000000000000000000000000000000000000D8E9EC00D8E9EC00D8E9
                EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
                EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00000000000000
                0000FFFFFF00000000000000000000000000C0C0C0000000000000000000FFFF
                FF000000000000000000000000000000000000000000D8E9EC00D8E9EC00D8E9
                EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
                EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00000000000000
                0000FFFFFF00000000000000000000000000C0C0C0000000000000000000FFFF
                FF000000000000000000000000000000000000000000D8E9EC00D8E9EC00D8E9
                EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
                EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC000000
                0000000000000000000000000000000000000000000000000000000000000000
                000000000000000000000000000000000000D8E9EC00D8E9EC00D8E9EC00D8E9
                EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
                EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
                EC0000000000FFFFFF00000000000000000000000000D8E9EC0000000000FFFF
                FF00000000000000000000000000D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
                EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
                EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
                EC000000000000000000000000000000000000000000D8E9EC00000000000000
                0000000000000000000000000000D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
                EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
                EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
                EC00D8E9EC00000000000000000000000000D8E9EC00D8E9EC00D8E9EC000000
                00000000000000000000D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
                EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
                EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
                EC00D8E9EC0000000000FFFFFF0000000000D8E9EC00D8E9EC00D8E9EC000000
                0000FFFFFF0000000000D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
                EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
                EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
                EC00D8E9EC00000000000000000000000000D8E9EC00D8E9EC00D8E9EC000000
                00000000000000000000D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
                EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
                EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
                EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
                EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
                EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
                EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
                EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
                EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
                EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
                EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
                EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
                EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
                EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
                EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
                EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
                EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
                EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
                EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
                EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
                EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
                EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
                EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
                EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
                EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
                EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
                EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
                EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
                EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
                EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
                EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
                EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
                EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
                EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
                EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
                EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
                EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
                EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
                EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
                EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
                EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
                EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00}
              OnClick = SpeedButton9Click
            end
            object DBEdit47: TDBEdit
              Tag = 47
              Left = 173
              Top = 21
              Width = 35
              Height = 22
              BevelKind = bkFlat
              BorderStyle = bsNone
              Color = clWhite
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
              TabOrder = 0
              OnChange = DBEdit47Change
            end
            object DBEdit48: TDBEdit
              Tag = 48
              Left = 173
              Top = 48
              Width = 35
              Height = 22
              BevelKind = bkFlat
              BorderStyle = bsNone
              Color = clWhite
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
              TabOrder = 2
              OnChange = DBEdit48Change
            end
            object RxSpinButton7: TSpinButton
              Left = 210
              Top = 21
              Width = 20
              Height = 22
              DownGlyph.Data = {
                56000000424D56000000000000003E0000002800000006000000060000000100
                010000000000180000000000000000000000020000000200000000000000FFFF
                FF00CC0000008400000000000000CC000000CC000000CC000000}
              FocusControl = DBEdit47
              TabOrder = 1
              UpGlyph.Data = {
                56000000424D56000000000000003E0000002800000006000000060000000100
                010000000000180000000000000000000000020000000200000000000000FFFF
                FF00CC000000CC000000CC0000000000000084000000CC000000}
              OnDownClick = RxSpinButton1DownClick
              OnUpClick = RxSpinButton1UpClick
            end
            object RxSpinButton8: TSpinButton
              Left = 210
              Top = 48
              Width = 20
              Height = 22
              DownGlyph.Data = {
                56000000424D56000000000000003E0000002800000006000000060000000100
                010000000000180000000000000000000000020000000200000000000000FFFF
                FF00CC0000008400000000000000CC000000CC000000CC000000}
              FocusControl = DBEdit48
              TabOrder = 3
              UpGlyph.Data = {
                56000000424D56000000000000003E0000002800000006000000060000000100
                010000000000180000000000000000000000020000000200000000000000FFFF
                FF00CC000000CC000000CC0000000000000084000000CC000000}
              OnDownClick = RxSpinButton1DownClick
              OnUpClick = RxSpinButton1UpClick
            end
            object DBComboBox8: TDBComboBox
              Tag = 16
              Left = 173
              Top = 78
              Width = 132
              Height = 22
              Style = csDropDownList
              BevelKind = bkFlat
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ItemHeight = 14
              ParentFont = False
              TabOrder = 4
              OnChange = DBComboBox8Change
            end
            object DBEdit17: TDBEdit
              Tag = 17
              Left = 173
              Top = 115
              Width = 35
              Height = 22
              BevelKind = bkFlat
              BorderStyle = bsNone
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
              TabOrder = 5
              Visible = False
            end
            object SpinButton3: TSpinButton
              Left = 210
              Top = 115
              Width = 20
              Height = 22
              DownGlyph.Data = {
                56000000424D56000000000000003E0000002800000006000000060000000100
                010000000000180000000000000000000000020000000200000000000000FFFF
                FF00CC0000008400000000000000CC000000CC000000CC000000}
              FocusControl = DBEdit17
              TabOrder = 6
              UpGlyph.Data = {
                56000000424D56000000000000003E0000002800000006000000060000000100
                010000000000180000000000000000000000020000000200000000000000FFFF
                FF00CC000000CC000000CC0000000000000084000000CC000000}
              Visible = False
              OnDownClick = RxSpinButton1DownClick
              OnUpClick = RxSpinButton1UpClick
            end
          end
        end
      end
      object TabSheetPareteDettagli: TTabSheet
        Caption = 'Parete Dettagli'
        ImageIndex = 5
        object GroupBox2: TGroupBox
          Left = 0
          Top = 0
          Width = 426
          Height = 217
          Caption = ' Stratigrafia della parete selezionata '
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clHotLight
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 0
          object DBGrid4: TDBGrid
            Left = 2
            Top = 16
            Width = 415
            Height = 185
            BorderStyle = bsNone
            DataSource = DataSource3
            FixedColor = clInfoBk
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            Options = [dgEditing, dgTitles, dgColLines, dgTabs]
            ParentFont = False
            ReadOnly = True
            TabOrder = 0
            TitleFont.Charset = DEFAULT_CHARSET
            TitleFont.Color = clHotLight
            TitleFont.Height = -11
            TitleFont.Name = 'Arial'
            TitleFont.Style = [fsBold]
            Visible = False
          end
        end
      end
    end
    object Panel9: TPanel
      Left = 1
      Top = 504
      Width = 779
      Height = 42
      Align = alBottom
      BevelOuter = bvNone
      TabOrder = 1
      object BtnAvanti: TSpeedButton
        Left = 368
        Top = 14
        Width = 80
        Height = 26
        Hint = 'Vai al Passo Successivo'
        Caption = '&Avanti >'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        ParentShowHint = False
        ShowHint = True
        OnClick = BtnAvantiClick
      end
      object BtnIndietro: TSpeedButton
        Left = 285
        Top = 14
        Width = 80
        Height = 26
        Hint = 'Vai al Passo Precedente'
        Caption = '< &Indietro'
        Enabled = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        ParentShowHint = False
        ShowHint = True
        OnClick = BtnIndietroClick
      end
      object ButtonCancel: TSpeedButton
        Left = 495
        Top = 14
        Width = 80
        Height = 26
        Hint = 'Annulla le modifiche apportate'
        Caption = '&Cancella'
        NumGlyphs = 2
        OnClick = ButtonCancelClick
      end
      object Label81: TLabel
        Left = 8
        Top = 20
        Width = 19
        Height = 14
        AutoSize = False
        Caption = '0 %'
      end
      object Label86: TLabel
        Left = 185
        Top = 20
        Width = 31
        Height = 14
        AutoSize = False
        Caption = '100 %'
      end
      object Panel10: TPanel
        Left = 0
        Top = 0
        Width = 779
        Height = 12
        Align = alTop
        Color = clSilver
        TabOrder = 0
      end
      object Bar: TProgressBar
        Left = 31
        Top = 19
        Width = 150
        Height = 16
        Min = 0
        Max = 100
        TabOrder = 1
      end
    end
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 616
    Width = 959
    Height = 19
    Panels = <
      item
        Text = 'Percorso database'
        Width = 100
      end
      item
        Text = 'dir db'
        Width = 800
      end>
    SimplePanel = False
  end
  object DataSource1: TDataSource
    DataSet = Table1
    Left = 496
    Top = 16
  end
  object Table1: TTable
    DatabaseName = 'd:\bmsistemi\archivi'
    TableName = 'Pareti.db'
    Left = 464
    Top = 8
  end
  object DataSource2: TDataSource
    AutoEdit = False
    DataSet = Table2
    OnDataChange = DataSource2DataChange
    Left = 728
    Top = 18
  end
  object Table2: TTable
    AfterPost = Table2AfterPost
    Filtered = True
    IndexName = 'Percategoria'
    TableName = 'materiali.db'
    Left = 728
    Top = 50
    object Table2Categoria: TStringField
      FieldName = 'Categoria'
    end
    object Table2Spessore: TFloatField
      FieldName = 'Spessore'
    end
    object Table2Descrizione: TStringField
      FieldName = 'Descrizione'
      Size = 50
    end
    object Table2Indicemat: TSmallintField
      FieldName = 'Indice mat'
    end
    object Table2Lambda: TFloatField
      FieldName = 'Lambda'
    end
    object Table2Condutt: TFloatField
      FieldName = 'Condutt.'
    end
    object Table2Pesospecifico: TFloatField
      FieldName = 'Peso specifico'
    end
    object Table2Permeabilit: TFloatField
      FieldName = 'Permeabilit'#224
    end
    object Table2Revisione: TIntegerField
      FieldName = 'Revisione'
    end
    object Table2CapTerm: TFloatField
      FieldName = 'Cap.Term.'
    end
    object Table2Disegno: TStringField
      FieldName = 'Disegno'
      Size = 50
    end
    object Table2Indice: TFloatField
      FieldName = 'Indice'
    end
    object Table2Orizz: TStringField
      FieldName = 'Orizz.'
      Size = 3
    end
    object Table2FormaBMP: TStringField
      FieldName = 'FormaBMP'
      Size = 2
    end
  end
  object DataSource3: TDataSource
    DataSet = Table3
    Left = 768
    Top = 21
  end
  object Table3: TTable
    AfterPost = Table3AfterPost
    DatabaseName = 'd:\bmsistemi\archivi'
    IndexName = 'PerNumero'
    MasterFields = 'Numero'
    MasterSource = DataSource4
    TableName = 'strati.DB'
    Left = 608
    Top = 13
  end
  object DataSource4: TDataSource
    DataSet = Table4
    Left = 679
    Top = 24
  end
  object Table4: TTable
    DatabaseName = 'd:\bmsistemi\archivi'
    TableName = 'Pareti.DB'
    Left = 559
    Top = 16
  end
  object Table5: TTable
    Left = 839
    Top = 50
  end
  object DataSource5: TDataSource
    DataSet = Table5
    Left = 839
    Top = 2
  end
  object DataSource6: TDataSource
    DataSet = Table6
    Left = 407
    Top = 29
  end
  object DataSource7: TDataSource
    DataSet = Table7
    Left = 375
    Top = 8
  end
  object Table7: TTable
    DatabaseName = 'D:\bmsistemi\progetti\prova3'
    TableName = 'Immagini.DB'
    Left = 343
    Top = 24
  end
  object Table6: TTable
    Left = 887
    Top = 45
  end
  object PopupMenu1: TPopupMenu
    Left = 288
    Top = 24
    object MoveUp1: TMenuItem
      Caption = 'Sposta riga su'
      OnClick = MoveUp1Click
    end
    object MoveDown1: TMenuItem
      Caption = 'Sposta riga gi'#249
      OnClick = MoveDown1Click
    end
    object N1: TMenuItem
      Caption = '-'
    end
    object CopiaElemento1: TMenuItem
      Caption = 'Copia Elemento'
      OnClick = CopiaElemento1Click
    end
  end
  object Timer1: TTimer
    Enabled = False
    Interval = 500
    OnTimer = Timer1Timer
    Left = 904
    Top = 16
  end
end
