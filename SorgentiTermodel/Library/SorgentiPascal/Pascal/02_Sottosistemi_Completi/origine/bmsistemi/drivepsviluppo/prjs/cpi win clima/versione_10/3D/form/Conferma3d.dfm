object FConferma: TFConferma
  Left = 600
  Top = 187
  BorderStyle = bsDialog
  Caption = 'FConferma'
  ClientHeight = 96
  ClientWidth = 275
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
  object LbSpeedButton1: TLbSpeedButton
    Left = 10
    Top = 60
    Width = 80
    Height = 23
    Hint = 'Cancella l'#39'elemento selezionato'
    Alignment = taCenter
    Caption = 'Si'
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
    Left = 96
    Top = 60
    Width = 80
    Height = 23
    Hint = 'Crea un nuovo elemento '
    Alignment = taCenter
    Caption = 'No'
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
    Left = 183
    Top = 60
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
  end
  object Label1: TLabel
    Left = 16
    Top = 16
    Width = 32
    Height = 13
    Caption = 'Label1'
  end
end
