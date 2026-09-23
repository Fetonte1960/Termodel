object FMaskgen: TFMaskgen
  Left = 348
  Top = 204
  Width = 504
  Height = 314
  Caption = 'FMaskgen'
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
    Left = 0
    Top = 0
    Width = 496
    Height = 246
    Align = alClient
    Caption = 'GroupBox1'
    TabOrder = 0
    object Label1: TLabel
      Left = 16
      Top = 24
      Width = 32
      Height = 13
      Caption = 'Label1'
      Visible = False
    end
    object Label2: TLabel
      Left = 16
      Top = 48
      Width = 32
      Height = 13
      Caption = 'Label2'
      Visible = False
    end
    object Label3: TLabel
      Left = 16
      Top = 72
      Width = 32
      Height = 13
      Caption = 'Label3'
      Visible = False
    end
    object Label4: TLabel
      Left = 16
      Top = 96
      Width = 32
      Height = 13
      Caption = 'Label4'
      Visible = False
    end
    object Label5: TLabel
      Left = 16
      Top = 120
      Width = 32
      Height = 13
      Caption = 'Label5'
      Visible = False
    end
    object Label6: TLabel
      Left = 16
      Top = 144
      Width = 32
      Height = 13
      Caption = 'Label6'
      Visible = False
    end
    object Label7: TLabel
      Left = 16
      Top = 168
      Width = 32
      Height = 13
      Caption = 'Label7'
      Visible = False
    end
    object Label8: TLabel
      Left = 16
      Top = 192
      Width = 32
      Height = 13
      Caption = 'Label8'
      Visible = False
    end
    object Label9: TLabel
      Left = 16
      Top = 216
      Width = 32
      Height = 13
      Caption = 'Label9'
      Visible = False
    end
    object DBEdit1: TDBEdit
      Left = 184
      Top = 16
      Width = 121
      Height = 21
      DataSource = DataSource1
      TabOrder = 0
      Visible = False
    end
    object DBEdit2: TDBEdit
      Left = 184
      Top = 40
      Width = 121
      Height = 21
      DataSource = DataSource1
      TabOrder = 1
      Visible = False
    end
    object DBEdit3: TDBEdit
      Left = 184
      Top = 64
      Width = 121
      Height = 21
      DataSource = DataSource1
      TabOrder = 2
      Visible = False
    end
    object DBEdit4: TDBEdit
      Left = 184
      Top = 88
      Width = 121
      Height = 21
      DataSource = DataSource1
      TabOrder = 3
      Visible = False
    end
    object DBEdit5: TDBEdit
      Left = 184
      Top = 112
      Width = 121
      Height = 21
      DataSource = DataSource1
      TabOrder = 4
      Visible = False
    end
    object DBEdit6: TDBEdit
      Left = 184
      Top = 136
      Width = 121
      Height = 21
      DataSource = DataSource1
      TabOrder = 5
      Visible = False
    end
    object DBEdit7: TDBEdit
      Left = 184
      Top = 160
      Width = 121
      Height = 21
      DataSource = DataSource1
      TabOrder = 6
      Visible = False
    end
    object DBEdit8: TDBEdit
      Left = 184
      Top = 184
      Width = 121
      Height = 21
      DataSource = DataSource1
      TabOrder = 7
      Visible = False
    end
    object DBEdit9: TDBEdit
      Left = 184
      Top = 208
      Width = 121
      Height = 21
      DataSource = DataSource1
      TabOrder = 8
      Visible = False
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 246
    Width = 496
    Height = 41
    Align = alBottom
    TabOrder = 1
    object BOk: TButton
      Left = 8
      Top = 8
      Width = 75
      Height = 25
      Caption = 'Ok'
      TabOrder = 0
      OnClick = BOkClick
    end
    object BCancel: TButton
      Left = 88
      Top = 8
      Width = 75
      Height = 25
      Caption = 'Cancel'
      TabOrder = 1
    end
  end
  object DataSource1: TDataSource
    DataSet = Table1
    Left = 448
    Top = 16
  end
  object Table1: TTable
    Left = 448
    Top = 56
  end
end
