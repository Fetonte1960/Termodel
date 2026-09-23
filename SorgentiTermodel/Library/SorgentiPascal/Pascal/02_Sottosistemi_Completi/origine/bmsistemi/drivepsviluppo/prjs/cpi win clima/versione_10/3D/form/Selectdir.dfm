object Fseldir: TFseldir
  Left = 613
  Top = 217
  BorderStyle = bsDialog
  Caption = 'Selezionare una cartella'
  ClientHeight = 204
  ClientWidth = 435
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 148
    Width = 218
    Height = 13
    Caption = 'P:\prjs\cpi win clima\VERSIONE_10\3D\form'
  end
  object LbSpeedButton1: TLbSpeedButton
    Left = 2
    Top = 172
    Width = 80
    Height = 23
    Hint = 'Cancella l'#39'elemento selezionato'
    Alignment = taCenter
    Caption = 'Seleziona'
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
  object Binserisci: TLbSpeedButton
    Left = 87
    Top = 173
    Width = 80
    Height = 23
    Hint = 'Crea un nuovo elemento '
    Alignment = taCenter
    Caption = 'Annulla'
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
  object LbSpeedButton2: TLbSpeedButton
    Left = 175
    Top = 173
    Width = 80
    Height = 23
    Hint = 'Crea un nuovo elemento '
    Alignment = taCenter
    Caption = 'Crea'
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
  object DirectoryListBox1: TDirectoryListBox
    Left = 8
    Top = 40
    Width = 241
    Height = 97
    DirLabel = Label1
    ItemHeight = 16
    TabOrder = 0
  end
  object DriveComboBox1: TDriveComboBox
    Left = 8
    Top = 8
    Width = 145
    Height = 19
    DirList = DirectoryListBox1
    TabOrder = 1
  end
  object Edit1: TEdit
    Left = 264
    Top = 174
    Width = 161
    Height = 21
    TabOrder = 2
  end
end
