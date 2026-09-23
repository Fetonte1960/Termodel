object FormCaricamento: TFormCaricamento
  Left = 541
  Top = 358
  BorderStyle = bsNone
  ClientHeight = 61
  ClientWidth = 312
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
  object Panel_Caricamento: TPanel
    Left = 0
    Top = 0
    Width = 312
    Height = 61
    Align = alClient
    AutoSize = True
    BevelOuter = bvNone
    BorderWidth = 1
    BorderStyle = bsSingle
    Ctl3D = False
    Font.Charset = ANSI_CHARSET
    Font.Color = clHotLight
    Font.Height = -13
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentCtl3D = False
    ParentFont = False
    TabOrder = 0
    object Label1: TLabel
      Left = 11
      Top = 22
      Width = 282
      Height = 19
      Alignment = taCenter
      Caption = 'Attendere .... Calcolo dei carichi estivi'
      Font.Charset = ANSI_CHARSET
      Font.Color = 13339492
      Font.Height = -16
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
    end
  end
end
