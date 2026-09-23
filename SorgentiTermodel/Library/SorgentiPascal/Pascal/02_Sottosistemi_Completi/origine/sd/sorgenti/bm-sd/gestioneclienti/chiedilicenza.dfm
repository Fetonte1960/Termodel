object FChiediLicenza: TFChiediLicenza
  Left = 441
  Top = 135
  Width = 555
  Height = 296
  Caption = 'Inserire il codice della licenza d'#39'uso'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Label2: TLabel
    Left = 8
    Top = 184
    Width = 76
    Height = 13
    Caption = 'Ragione sociale'
  end
  object Label3: TLabel
    Left = 8
    Top = 240
    Width = 98
    Height = 13
    Caption = 'Codice di attivazione'
  end
  object Button1: TButton
    Left = 389
    Top = 232
    Width = 75
    Height = 25
    Caption = 'Conferma'
    TabOrder = 0
    OnClick = Button1Click
  end
  object Edit1: TEdit
    Left = 111
    Top = 224
    Width = 106
    Height = 32
    CharCase = ecUpperCase
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    MaxLength = 4
    ParentFont = False
    TabOrder = 1
  end
  object GroupBox1: TGroupBox
    Left = 8
    Top = 8
    Width = 537
    Height = 169
    TabOrder = 2
    object Label1: TLabel
      Left = 2
      Top = 15
      Width = 533
      Height = 140
      Align = alTop
      Caption = 
        'Il codice licenza d'#39'uso '#232' strettamente personale del responsabil' +
        'e ,'#13#10'pertanto '#232' da custodire con cura ed utilizzare solo al mome' +
        'nto '#13#10'dell'#39' installazione del programma.'#13#10'A scopo di sicurezza v' +
        'iene fornito in busta chiusa e sigillato dal '#13#10'timbro aziendale.' +
        #13#10'La comunicazione di questo codice ad altre persone ci autorizz' +
        'a '#13#10'alla revoca della licenza d'#39'uso sensa alcun rimborso economi' +
        'co.'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -16
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
  end
  object Button2: TButton
    Left = 468
    Top = 232
    Width = 75
    Height = 25
    Caption = 'Uscita'
    TabOrder = 3
    OnClick = Button2Click
  end
  object Edit2: TEdit
    Left = 7
    Top = 200
    Width = 530
    Height = 21
    TabOrder = 4
  end
end
