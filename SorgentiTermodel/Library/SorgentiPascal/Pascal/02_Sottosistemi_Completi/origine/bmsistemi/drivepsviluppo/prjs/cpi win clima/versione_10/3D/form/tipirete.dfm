object Ftipirete: TFtipirete
  Left = 729
  Top = 207
  Width = 589
  Height = 328
  Caption = 'Ftipirete'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object PageControl1: TPageControl
    Left = 0
    Top = 105
    Width = 573
    Height = 185
    ActivePage = TabSheet2
    Align = alClient
    TabIndex = 1
    TabOrder = 0
    object TabSheet1: TTabSheet
      Caption = 'Idrauliche'
    end
    object TabSheet2: TTabSheet
      Caption = 'Aerauliche'
      ImageIndex = 1
      object GroupBox1: TGroupBox
        Left = 0
        Top = 0
        Width = 565
        Height = 157
        Align = alClient
        Caption = #167'TIPIRETE:Definizione della tipologia dei canali:'
        TabOrder = 0
        object Label1: TLabel
          Left = 8
          Top = 24
          Width = 126
          Height = 13
          Caption = 'Tipologia canale principale'
        end
        object DBComboBox1: TDBComboBox
          Tag = 15
          Left = 144
          Top = 21
          Width = 81
          Height = 21
          ItemHeight = 13
          TabOrder = 0
        end
        object GroupBox2: TGroupBox
          Left = 8
          Top = 72
          Width = 273
          Height = 81
          Caption = 'Uscite orizzontali'
          TabOrder = 1
          object Label2: TLabel
            Left = 8
            Top = 24
            Width = 147
            Height = 13
            Caption = 'Tipologia canale ( ultimo tratto )'
          end
          object DBComboBox2: TDBComboBox
            Tag = 16
            Left = 176
            Top = 21
            Width = 81
            Height = 21
            ItemHeight = 13
            TabOrder = 0
          end
          object DBCheckBox1: TDBCheckBox
            Tag = 27
            Left = 8
            Top = 48
            Width = 97
            Height = 17
            Caption = 'Canale flessibile'
            TabOrder = 1
            ValueChecked = 'SI'
            ValueUnchecked = 'NO'
          end
        end
        object GroupBox3: TGroupBox
          Left = 288
          Top = 72
          Width = 273
          Height = 81
          Caption = 'Uscite verticali'
          TabOrder = 2
          object Label3: TLabel
            Left = 8
            Top = 24
            Width = 147
            Height = 13
            Caption = 'Tipologia canale ( ultimo tratto )'
          end
          object DBComboBox3: TDBComboBox
            Tag = 17
            Left = 176
            Top = 21
            Width = 81
            Height = 21
            ItemHeight = 13
            TabOrder = 0
          end
          object DBCheckBox2: TDBCheckBox
            Tag = 28
            Left = 8
            Top = 48
            Width = 97
            Height = 17
            Caption = 'Canale flessibile'
            TabOrder = 1
            ValueChecked = 'Si'
            ValueUnchecked = 'No'
          end
        end
      end
    end
  end
  object GroupBox4: TGroupBox
    Left = 0
    Top = 0
    Width = 573
    Height = 105
    Align = alTop
    Caption = #167'TIPIRETE::'
    TabOrder = 1
    object Label4: TLabel
      Left = 9
      Top = 24
      Width = 72
      Height = 13
      Caption = 'Colore nel CAD'
    end
    object DBComboBox4: TDBComboBox
      Tag = 14
      Left = 88
      Top = 22
      Width = 105
      Height = 21
      ItemHeight = 13
      Items.Strings = (
        'Rosso'
        'Giallo '
        'Verde '
        'Blu'
        'Ciano'
        'Magenta')
      TabOrder = 0
    end
  end
end
