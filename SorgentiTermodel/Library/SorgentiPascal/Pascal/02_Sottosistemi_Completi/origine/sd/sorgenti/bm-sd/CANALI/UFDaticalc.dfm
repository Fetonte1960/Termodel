object Form2: TForm2
  Left = 477
  Top = 194
  Width = 849
  Height = 417
  Caption = 'Da aggiungere a fabbricato'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox1: TGroupBox
    Left = 8
    Top = 8
    Width = 825
    Height = 369
    Caption = 'Canali'
    TabOrder = 0
    object GroupBox2: TGroupBox
      Left = 8
      Top = 16
      Width = 809
      Height = 113
      Caption = 'Criteri di calcolo'
      TabOrder = 0
      object Label1: TLabel
        Left = 16
        Top = 40
        Width = 82
        Height = 13
        Caption = 'Tronco principale'
      end
      object Label2: TLabel
        Left = 16
        Top = 72
        Width = 24
        Height = 13
        Caption = 'Rami'
      end
      object Label3: TLabel
        Left = 168
        Top = 24
        Width = 175
        Height = 13
        Caption = 'Perdita di carico lineare Dp/m (Pa/m)'
      end
      object Label4: TLabel
        Left = 392
        Top = 24
        Width = 111
        Height = 13
        Caption = 'Massima velocit'#242' (m/s )'
      end
      object Edit1: TEdit
        Left = 168
        Top = 40
        Width = 49
        Height = 21
        TabOrder = 0
        Text = '0.8'
      end
      object Edit2: TEdit
        Left = 168
        Top = 64
        Width = 49
        Height = 21
        TabOrder = 1
        Text = '0.8'
      end
      object Edit3: TEdit
        Left = 384
        Top = 40
        Width = 49
        Height = 21
        TabOrder = 2
        Text = '10'
      end
      object Edit4: TEdit
        Left = 384
        Top = 64
        Width = 49
        Height = 21
        TabOrder = 3
        Text = '10'
      end
    end
    object GroupBox3: TGroupBox
      Left = 8
      Top = 136
      Width = 809
      Height = 225
      Caption = 
        'Tipologia costruttiva di default (dati presenti anche in tipolog' +
        'ia tubazioni)'
      TabOrder = 1
      object Label5: TLabel
        Left = 8
        Top = 176
        Width = 98
        Height = 13
        Caption = 'Inserimento serrande'
      end
      object Label6: TLabel
        Left = 8
        Top = 24
        Width = 33
        Height = 13
        Caption = 'Codice'
      end
      object Label7: TLabel
        Left = 152
        Top = 32
        Width = 55
        Height = 13
        Caption = 'Descrizione'
      end
      object Label8: TLabel
        Left = 352
        Top = 32
        Width = 88
        Height = 13
        Caption = 'Serie dimensionale'
      end
      object Label9: TLabel
        Left = 8
        Top = 88
        Width = 82
        Height = 13
        Caption = 'Tronco principale'
      end
      object Label10: TLabel
        Left = 72
        Top = 112
        Width = 56
        Height = 13
        Caption = 'Ultimo tratto'
      end
      object Label11: TLabel
        Left = 176
        Top = 56
        Width = 43
        Height = 13
        Caption = 'Tipologia'
      end
      object Label12: TLabel
        Left = 288
        Top = 56
        Width = 73
        Height = 13
        Caption = 'Fattore di forma'
      end
      object Label13: TLabel
        Left = 392
        Top = 56
        Width = 89
        Height = 13
        Caption = 'Massima larghezza'
      end
      object Label14: TLabel
        Left = 488
        Top = 56
        Width = 77
        Height = 13
        Caption = 'Massima altezza'
      end
      object Label15: TLabel
        Left = 72
        Top = 112
        Width = 64
        Height = 13
        Caption = 'se orizzontale'
      end
      object Label16: TLabel
        Left = 584
        Top = 32
        Width = 43
        Height = 13
        Caption = 'Materiale'
      end
      object Label17: TLabel
        Left = 592
        Top = 56
        Width = 42
        Height = 13
        Caption = 'Flessibile'
      end
      object Label18: TLabel
        Left = 72
        Top = 136
        Width = 54
        Height = 13
        Caption = 'se verticale'
      end
      object Label19: TLabel
        Left = 440
        Top = 80
        Width = 28
        Height = 13
        Caption = '( mm )'
      end
      object Label20: TLabel
        Left = 224
        Top = 184
        Width = 78
        Height = 13
        Caption = 'Sbilancio minimo'
      end
      object Label21: TLabel
        Left = 368
        Top = 184
        Width = 25
        Height = 13
        Caption = '( Pa )'
      end
      object Label22: TLabel
        Left = 696
        Top = 56
        Width = 42
        Height = 13
        Caption = 'Terminali'
      end
      object Edit5: TEdit
        Left = 48
        Top = 24
        Width = 89
        Height = 21
        TabOrder = 0
        Text = 'Canalerett'
      end
      object Edit6: TEdit
        Left = 216
        Top = 24
        Width = 129
        Height = 21
        TabOrder = 1
        Text = 'Canale rettangolare diffusori circolari'
      end
      object ComboBox1: TComboBox
        Left = 464
        Top = 24
        Width = 113
        Height = 21
        ItemHeight = 13
        TabOrder = 2
        Text = 'Canali lamiera'
      end
      object ComboBox2: TComboBox
        Left = 168
        Top = 80
        Width = 89
        Height = 21
        ItemHeight = 13
        TabOrder = 3
        Text = 'Rettangolare'
        Items.Strings = (
          'Circolare'
          'Rettangolare')
      end
      object Edit7: TEdit
        Left = 288
        Top = 80
        Width = 41
        Height = 21
        TabOrder = 4
        Text = '0.5'
      end
      object Edit8: TEdit
        Left = 392
        Top = 80
        Width = 33
        Height = 21
        TabOrder = 5
        Text = '0'
      end
      object Edit9: TEdit
        Left = 488
        Top = 80
        Width = 33
        Height = 21
        TabOrder = 6
        Text = '0'
      end
      object ComboBox3: TComboBox
        Left = 168
        Top = 104
        Width = 89
        Height = 21
        ItemHeight = 13
        TabOrder = 7
        Text = 'Rettangolare'
        Items.Strings = (
          'Circolare'
          'Rettangolare')
      end
      object Edit10: TEdit
        Left = 288
        Top = 104
        Width = 41
        Height = 21
        TabOrder = 8
        Text = '0.5'
      end
      object Edit11: TEdit
        Left = 392
        Top = 104
        Width = 33
        Height = 21
        TabOrder = 9
        Text = '0'
      end
      object Edit12: TEdit
        Left = 488
        Top = 104
        Width = 33
        Height = 21
        TabOrder = 10
        Text = '0'
      end
      object ComboBox4: TComboBox
        Left = 168
        Top = 128
        Width = 89
        Height = 21
        ItemHeight = 13
        TabOrder = 11
        Text = 'Circolare'
        Items.Strings = (
          'Circolare'
          'Rettangolare')
      end
      object Edit13: TEdit
        Left = 288
        Top = 128
        Width = 41
        Height = 21
        TabOrder = 12
        Text = '0.5'
      end
      object Edit14: TEdit
        Left = 392
        Top = 128
        Width = 33
        Height = 21
        TabOrder = 13
        Text = '0'
      end
      object Edit15: TEdit
        Left = 488
        Top = 128
        Width = 33
        Height = 21
        TabOrder = 14
        Text = '0'
      end
      object ComboBox5: TComboBox
        Left = 640
        Top = 24
        Width = 89
        Height = 21
        ItemHeight = 13
        TabOrder = 15
        Text = 'Lamiera zincata'
      end
      object ComboBox6: TComboBox
        Left = 592
        Top = 104
        Width = 49
        Height = 21
        ItemHeight = 13
        TabOrder = 16
        Text = 'No'
        Items.Strings = (
          'Si'
          'No')
      end
      object ComboBox7: TComboBox
        Left = 592
        Top = 128
        Width = 49
        Height = 21
        ItemHeight = 13
        TabOrder = 17
        Text = 'No'
        Items.Strings = (
          'Si'
          'No')
      end
      object ComboBox8: TComboBox
        Left = 128
        Top = 176
        Width = 65
        Height = 21
        ItemHeight = 13
        TabOrder = 18
        Text = 'NO'
        Items.Strings = (
          'NO'
          'Sui rami'
          'Sui terminali')
      end
      object Edit16: TEdit
        Left = 320
        Top = 176
        Width = 33
        Height = 21
        TabOrder = 19
        Text = '10'
      end
      object ComboBox9: TComboBox
        Left = 656
        Top = 104
        Width = 89
        Height = 21
        ItemHeight = 13
        TabOrder = 20
        Text = 'Bocchettatipo'
      end
      object ComboBox10: TComboBox
        Left = 656
        Top = 136
        Width = 89
        Height = 21
        ItemHeight = 13
        TabOrder = 21
        Text = 'Diffusoretipo'
      end
    end
  end
end
