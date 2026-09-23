object FRunComp: TFRunComp
  Left = 502
  Top = 182
  Width = 435
  Height = 317
  Caption = 'Scelta del tipo di componenete'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnActivate = FormActivate
  PixelsPerInch = 96
  TextHeight = 13
  object DBText1: TDBText
    Left = 256
    Top = 8
    Width = 137
    Height = 17
    DataField = 'Descrizione'
    DataSource = FProgcomp.DataSource1
  end
  object DBCtrlGrid1: TDBCtrlGrid
    Left = 0
    Top = 0
    Width = 137
    Height = 289
    ColCount = 1
    DataSource = FProgcomp.DataSource1
    PanelHeight = 96
    PanelWidth = 121
    TabOrder = 0
    RowCount = 3
    OnDblClick = DBCtrlGrid1DblClick
    object DBImage1: TDBImage
      Left = 0
      Top = 0
      Width = 121
      Height = 96
      Align = alClient
      DataField = 'Immagine'
      DataSource = FProgcomp.DataSource1
      ReadOnly = True
      TabOrder = 0
      OnClick = DBImage1Click
    end
  end
  object DBCtrlGrid2: TDBCtrlGrid
    Left = 120
    Top = 0
    Width = 129
    Height = 289
    ColCount = 1
    DataSource = FProgcomp.DataSource1
    PanelHeight = 96
    PanelWidth = 113
    TabOrder = 1
    RowCount = 3
    object DBMemo1: TDBMemo
      Left = 0
      Top = 0
      Width = 113
      Height = 96
      Align = alClient
      DataField = 'Comento'
      DataSource = FProgcomp.DataSource1
      ReadOnly = True
      TabOrder = 0
    end
  end
  object Button1: TButton
    Left = 256
    Top = 264
    Width = 75
    Height = 25
    Caption = 'Scegli'
    TabOrder = 2
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 336
    Top = 264
    Width = 75
    Height = 25
    Caption = 'Annulla'
    TabOrder = 3
  end
  object Button3: TButton
    Left = 256
    Top = 232
    Width = 75
    Height = 25
    Caption = 'Indietro'
    TabOrder = 4
    OnClick = Button3Click
  end
  object pp1: TPanel
    Left = 256
    Top = 24
    Width = 161
    Height = 129
    TabOrder = 5
    object L4: TLabel
      Left = 16
      Top = 72
      Width = 81
      Height = 13
      Caption = 'Tipo scambiatore'
    end
    object Ppl: TPanel
      Left = 8
      Top = 8
      Width = 113
      Height = 25
      TabOrder = 0
      object Label1: TLabel
        Left = 8
        Top = 8
        Width = 6
        Height = 13
        Caption = 'L'
      end
      object Spl: TSpinEdit
        Left = 32
        Top = 0
        Width = 73
        Height = 22
        MaxValue = 0
        MinValue = 0
        TabOrder = 0
        Value = 0
      end
    end
    object Pph: TPanel
      Left = 8
      Top = 40
      Width = 113
      Height = 25
      TabOrder = 1
      object Label2: TLabel
        Left = 8
        Top = 8
        Width = 8
        Height = 13
        Caption = 'H'
      end
      object Sph: TSpinEdit
        Left = 32
        Top = 0
        Width = 73
        Height = 22
        MaxValue = 0
        MinValue = 0
        TabOrder = 0
        Value = 0
      end
    end
    object CB4: TComboBox
      Left = 8
      Top = 92
      Width = 145
      Height = 21
      ItemHeight = 13
      TabOrder = 2
      Text = 'CB3'
    end
  end
  object Comb1: TPanel
    Left = 256
    Top = 24
    Width = 161
    Height = 145
    TabOrder = 6
    object Label3: TLabel
      Left = 48
      Top = 8
      Width = 51
      Height = 13
      Caption = 'Dimensioni'
    end
    object Label4: TLabel
      Left = 40
      Top = 48
      Width = 71
      Height = 13
      Caption = 'Tipo Quadrotto'
    end
    object L3: TLabel
      Left = 40
      Top = 88
      Width = 81
      Height = 13
      Caption = 'Tipo scambiatore'
    end
    object CB1: TComboBox
      Left = 8
      Top = 24
      Width = 145
      Height = 21
      ItemHeight = 13
      TabOrder = 0
      Text = 'CB1'
    end
    object CB2: TComboBox
      Left = 8
      Top = 64
      Width = 145
      Height = 21
      ItemHeight = 13
      TabOrder = 1
      Text = 'CB2'
    end
    object CB3: TComboBox
      Left = 8
      Top = 112
      Width = 145
      Height = 21
      ItemHeight = 13
      TabOrder = 2
      Text = 'CB3'
    end
  end
end
