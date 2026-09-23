object FSceltaArch: TFSceltaArch
  Left = 750
  Top = 138
  Width = 510
  Height = 563
  Caption = 'FSceltaArch'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 460
    Width = 494
    Height = 65
    Align = alBottom
    BevelInner = bvLowered
    TabOrder = 0
    object Label1: TLabel
      Left = 8
      Top = 2
      Width = 97
      Height = 13
      Caption = 'Frase da cercare'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 13339492
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Button1: TLbSpeedButton
      Left = 266
      Top = 15
      Width = 80
      Height = 23
      Alignment = taCenter
      Caption = 'Esci'
      ColorWhenDown = 535020206
      HotTrackFont.Charset = DEFAULT_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -11
      HotTrackFont.Name = 'MS Sans Serif'
      HotTrackFont.Style = []
      Style = bsModern
      OnClick = Button1Click
    end
    object Button2: TLbSpeedButton
      Left = 183
      Top = 15
      Width = 80
      Height = 23
      Alignment = taCenter
      Caption = 'Seleziona'
      ColorWhenDown = 535020206
      HotTrackFont.Charset = DEFAULT_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -11
      HotTrackFont.Name = 'MS Sans Serif'
      HotTrackFont.Style = []
      Style = bsModern
      OnClick = Button2Click
    end
    object Label2: TLabel
      Left = 8
      Top = 48
      Width = 32
      Height = 13
      Caption = 'Label2'
    end
    object LbSpeedButton1: TLbSpeedButton
      Left = 354
      Top = 15
      Width = 143
      Height = 23
      Alignment = taCenter
      Caption = 'Cancella la riga selezionata'
      ColorWhenDown = 535020206
      HotTrackFont.Charset = DEFAULT_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -11
      HotTrackFont.Name = 'MS Sans Serif'
      HotTrackFont.Style = []
      Style = bsModern
      OnClick = LbSpeedButton1Click
    end
    object CheckBox1: TCheckBox
      Left = 132
      Top = 20
      Width = 46
      Height = 17
      Caption = 'Filtra'
      TabOrder = 1
      OnClick = CheckBox1Click
    end
    object Edit1: TEdit
      Left = 5
      Top = 18
      Width = 121
      Height = 21
      BevelKind = bkFlat
      BorderStyle = bsNone
      TabOrder = 0
    end
  end
  object DBGrid1: TDBGrid
    Left = 0
    Top = 0
    Width = 240
    Height = 460
    Align = alClient
    Ctl3D = False
    DataSource = DS1
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    Options = [dgTitles, dgColLines, dgRowLines, dgTabs, dgRowSelect]
    ParentCtl3D = False
    ParentFont = False
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = 13339492
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = [fsBold]
    OnDblClick = DBGrid1DblClick
    Columns = <
      item
        Expanded = False
        Visible = True
      end>
  end
  object DBGrid2: TDBGrid
    Left = 240
    Top = 0
    Width = 254
    Height = 460
    Align = alRight
    DataSource = Dsa
    TabOrder = 2
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
  end
  object DS1: TDataSource
    DataSet = T1
    Left = 288
    Top = 16
  end
  object T1: TTable
    OnFilterRecord = T1FilterRecord
    Left = 288
    Top = 56
  end
  object Ta: TTable
    MasterSource = DS1
    Left = 344
    Top = 88
  end
  object Dsa: TDataSource
    DataSet = Ta
    Left = 360
    Top = 144
  end
end
