object FormEureka: TFormEureka
  Left = 158
  Top = 192
  Width = 550
  Height = 329
  Caption = 'Eureka Form - Assicurarsi che il form sia tra quelli autocreati'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object LabelInfo: TLabel
    Left = 16
    Top = 16
    Width = 389
    Height = 96
    Caption = 
      'Inserite il form nel progetto e assicuratevi che NON sia tra que' +
      'lli autocreati.'#13#10'Attenzione: Il Form richiede InterfacciaDLLs (d' +
      'irettiva CTRL_NUM)'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    WordWrap = True
  end
  object Label1: TLabel
    Left = 8
    Top = 128
    Width = 510
    Height = 29
    Caption = 'Attivate EurekaLog nelle opzioni di progetto'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clRed
    Font.Height = -24
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold, fsUnderline]
    ParentFont = False
  end
  object Label2: TLabel
    Left = 19
    Top = 183
    Width = 124
    Height = 13
    Caption = 'Informazioni supplementari'
  end
  object MemoErr: TMemo
    Left = 16
    Top = 200
    Width = 513
    Height = 73
    Lines.Strings = (
      'Attenzione: Ulteriori informazioni impostabili dall'#39'applicazione')
    TabOrder = 0
  end
end
