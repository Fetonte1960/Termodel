object FGestioneGenera: TFGestioneGenera
  Left = 1099
  Top = 111
  Width = 303
  Height = 661
  Caption = 'Programmazione facile 1.0'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  Position = poDesktopCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 570
    Width = 295
    Height = 37
    Align = alBottom
    TabOrder = 0
    object Button1: TButton
      Left = 8
      Top = 8
      Width = 75
      Height = 25
      Caption = 'Chiudi'
      TabOrder = 0
      OnClick = Button1Click
    end
  end
  object Memo1: TMemo
    Left = 0
    Top = 0
    Width = 295
    Height = 570
    Align = alClient
    Lines.Strings = (
      '')
    ReadOnly = True
    TabOrder = 1
  end
  object MainMenu1: TMainMenu
    Left = 248
    Top = 16
    object F1: TMenuItem
      Caption = 'File'
      object Nuovo1: TMenuItem
        Caption = 'Nuovo'
        OnClick = Nuovo1Click
      end
    end
    object Generaapplicazione1: TMenuItem
      Caption = 'Genera applicazione'
      object Aggiornafilediprogetto1: TMenuItem
        Caption = 'Aggiorna file di progetto'
        OnClick = Aggiornafilediprogetto1Click
      end
      object AggiornaBasedati1: TMenuItem
        Caption = 'Aggiorna Base dati'
      end
      object V1: TMenuItem
        Caption = 'Visualizza base dati'
        OnClick = V1Click
      end
    end
    object Pers11: TMenuItem
      Caption = 'Pers1'
      Visible = False
    end
    object Pers21: TMenuItem
      Caption = 'Pers2'
      Visible = False
    end
    object Pers31: TMenuItem
      Caption = 'Pers3'
      Visible = False
    end
    object Pers41: TMenuItem
      Caption = 'Pers4'
      Visible = False
    end
  end
  object SaveDialog1: TSaveDialog
    DefaultExt = '*.eap'
    Filter = 'Easy program|*.EAP'
    InitialDir = 'c:\'
    Left = 256
    Top = 56
  end
end
