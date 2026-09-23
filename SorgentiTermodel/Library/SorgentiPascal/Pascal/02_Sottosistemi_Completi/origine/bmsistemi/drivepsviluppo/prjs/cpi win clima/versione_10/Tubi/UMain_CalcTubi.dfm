object FMainTubi: TFMainTubi
  Left = 259
  Top = 97
  BorderStyle = bsDialog
  Caption = 'Calcolo delle reti di tubazioni '
  ClientHeight = 621
  ClientWidth = 832
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnActivate = FormActivate
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 594
    Width = 832
    Height = 27
    Align = alBottom
    BevelOuter = bvLowered
    TabOrder = 0
    object Button1: TSpeedButton
      Left = 743
      Top = 0
      Width = 86
      Height = 26
      Hint = 'Chiude la finestra'
      Caption = 'Chiudi'
      Glyph.Data = {
        36100000424D3610000000000000360000002800000020000000200000000100
        2000000000000010000000000000000000000000000000000000E3DFE000E3DF
        E000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DF
        E000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DF
        E000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DF
        E000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DF
        E000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DF
        E000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DF
        E000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DF
        E000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DF
        E000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DF
        E000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DF
        E000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DF
        E000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DF
        E000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DF
        E000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DF
        E000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DF
        E000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DF
        E000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DF
        E000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DF
        E000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DF
        E000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DF
        E000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DF
        E000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DF
        E000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DF
        E000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DF
        E000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DF
        E000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DF
        E000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DF
        E000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DF
        E000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DF
        E000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DF
        E000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DF
        E000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DF
        E000E3DFE000E3DFE000E3DFE000E3DFE0001014130014191A0024631300276A
        1600246313002463130024631300246313002463130024631300246313002463
        13002463130024631300246313002565140024631300373C3900E3DFE000E3DF
        E000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DF
        E000E3DFE000E3DFE000E3DFE000E3DFE0005F645E00E4E4E500365635002463
        1300389724003897240038972400389724003897240038972400389724003897
        2400389724003897240038972400389724002D7A1D0024282500E3DFE000E3DF
        E000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DF
        E000E3DFE000E3DFE000E3DFE000E3DFE00058605700FEFEFE00F8F8F9007A7A
        7900202A21002A741A003C8C34003B902E00348C220036902400369024003793
        2500369024003690240037932500389724002A741A00262A2700E3DFE000E3DF
        E000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DF
        E000E3DFE000E3DFE000E3DFE000E3DFE0005F645E00F1F1F200E3E4E400FEFE
        FE00C1C1C1003C403C002A5E1E003E883A00437F440040823F003E843C003E84
        3C003E883A003C8C34003C8C34003C8C34002A741A00262A2700E3DFE000E3DF
        E000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DF
        E000E3DFE000E3DFE000E3DFE000E3DFE000536452002A2E2B0006060600B5B5
        B500FEFEFE00E8E8E90078787700202A210032592E00437F4400457B4600457B
        4600457B4600457B4600457B4600437F440032592E00262A2700E3DFE000E3DF
        E000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DF
        E000E3DFE000E3DFE000E3DFE000E3DFE00042454100181F22000711AF000606
        0600B0B0AF00F5F5F600EDEDEE00BABAB900333835001E2822003D543F00457B
        46003D543F003D543F003D543F004A724B0036563500262A2700E3DFE000E3DF
        E000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DF
        E000E3DFE000E3DFE000E3DFE000E3DFE00043494200181F2200111EFD000A15
        B90006060600ADAEAD00EEEFEF00E2E3E300DDDDDE00696A6900202A21003D54
        3F003D543F003D543F003D543F003D543F0030353200262A2700E3DFE000E3DF
        E000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DF
        E000B3B4B2003F413E00434D4300242825000B0D0D0001032600101DFC001A28
        FC000A15B90006060600A8A8A800E9E9E900D5D5D600E2E3E30043494200222A
        2300333835003035320030353200353B3700262A2700262A2700E3DFE000E3DF
        E000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DF
        E00058605700283AE3000F17ED000E15E4000E15E4000F17ED00111EFD00111E
        FD001421FD000A15B90006060600A2A3A200E4E4E500D5D5D60043494200161B
        1D00252926001E2822001E28220025292600181F2200262A2700E3DFE000E3DF
        E000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DF
        E0005C605A004057F600111EFD000E18F2000E19F6000E18F2000E15E5000E15
        E4000E15E400111EFD000711AF0006060600A0A0A000E1E2E200414340000809
        0A0014191A00131717001317170014191A000E101000262A2700E3DFE000E3DF
        E000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DF
        E000586057004056F5000E18F2000E15E4000E15E4000E15E4000E15E4000E15
        E4000E15E4000E15E4001421FD00050D97002A2E2B00E3E4E4003F413E000101
        010008090A00060606000606060008090A000404040025292600E3DFE000E3DF
        E000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DF
        E000586057003A4FF3000D1AF8000D1AF8000D1AF8000D1AF800101DFC001421
        FD00111EFD001421FD00111EFD0002033000434D4300D1D1D200414340000101
        0100010102000101010001010100030303000101010025292600E3DFE000E3DF
        E000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DF
        E000536452004057F6003E54F7003E54F7003B51F8004057F6002E40FB000F1C
        FB001421FD001421FD00010222007C7C7B007A7A790053645200424742000101
        0100010102000101010001010100030303000101010025292600E3DFE000E3DF
        E000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DF
        E0007F7E7D000B0D0D0024282500161B1D00101413002D322E004057F6000D1A
        F8001421FD00010222006F6F6D00EDEDEE00696A690042444100222A23000101
        0100010102000101010001010100030303000101010025292600E3DFE000E3DF
        E000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DF
        E000E3DFE000E3DFE000E3DFE000E3DFE000353B37002A2E2B004057F6000D1A
        F8000102220074747400EFF0F100DDDDDE009E9E9E009B9B9B00303532000101
        0100010102000101010001010100030303000101010025292600E3DFE000E3DF
        E000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DF
        E000E3DFE000E3DFE000E3DFE000E3DFE00042444100353B37004057F6000103
        2C005F645E00F5F5F600E2E2E300DEDFE000DEDFE000E3E4E40040423F000101
        0100010102000101010001010100030303000101010025292600E3DFE000E3DF
        E000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DF
        E000E3DFE000E3DFE000E3DFE000E3DFE00042474200181F2200010326005C60
        5A00F6F6F700E8E8E900E2E3E300DDDDDE00D5D5D600DBDBDC003F413E000101
        0100010102000101010001010100030303000101010025292600E3DFE000E3DF
        E000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DF
        E000E3DFE000E3DFE000E3DFE000E3DFE0005C605A00ABACAB0087878500F7F7
        F800EEEFEF00E8E8E900E6E6E700E2E2E300D8D8D900D1D1D200333835000101
        0100010102000101010001010100030303000101010025292600E3DFE000E3DF
        E000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DF
        E000E3DFE000E3DFE000E3DFE000E3DFE00058605700FEFEFE00FEFEFE00F2F2
        F300EEEFEF00E7E7E800D8D8D900C1C1C1009D9D9D0087878500181F22000101
        01000101020001010100010101000303030001010100262A2700E3DFE000E3DF
        E000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DF
        E000E3DFE000E3DFE000E3DFE000E3DFE0005F645E00FEFEFE00F7F7F800EDED
        EE00DBDBDC00C1C1C100ABACAB009B9B9B008D8D8C008D8D8C00262A27000404
        0400060606000404040004040400060606000101010024282500E3DFE000E3DF
        E000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DF
        E000E3DFE000E3DFE000E3DFE000E3DFE00014191A00767676005C605A00434D
        4300414340003F413E003A3E3B00333835002D322E002A2E2B000B0D0D000101
        01000101010001010100010101000404040001010100373C3900E3DFE000E3DF
        E000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DF
        E000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DF
        E000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DF
        E000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DF
        E000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DF
        E000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DF
        E000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DF
        E000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DF
        E000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DF
        E000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DF
        E000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DF
        E000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DF
        E000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000}
      ParentShowHint = False
      ShowHint = True
      OnClick = Button1Click
    end
  end
  object Panel2: TPanel
    Left = 584
    Top = 0
    Width = 248
    Height = 594
    Align = alRight
    BevelOuter = bvNone
    TabOrder = 1
    object PC_DatiRete: TPageControl
      Left = 3
      Top = 106
      Width = 246
      Height = 399
      ActivePage = TabSheet2
      Style = tsButtons
      TabIndex = 1
      TabOrder = 0
      object TabSheet1: TTabSheet
        Caption = 'Dati Rete'
        object GB_CriteriCalcolo: TGroupBox
          Left = 4
          Top = 60
          Width = 231
          Height = 167
          Caption = 'Criteri di calcolo'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clHotLight
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 1
          object GroupBox2: TGroupBox
            Left = 8
            Top = 87
            Width = 215
            Height = 70
            Caption = 'Rami favoriti'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentFont = False
            TabOrder = 0
            object Label1: TLabel
              Left = 8
              Top = 21
              Width = 117
              Height = 13
              Caption = 'Perdite unitarie ammesse'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
            end
            object Label3: TLabel
              Left = 8
              Top = 46
              Width = 81
              Height = 13
              Caption = 'Velocita massima'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
            end
            object Label22: TLabel
              Left = 176
              Top = 21
              Width = 32
              Height = 13
              Caption = '[Pa/m]'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
            end
            object Label23: TLabel
              Left = 176
              Top = 46
              Width = 24
              Height = 13
              Caption = '[m/s]'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
            end
            object DBEdit1: TDBEdit
              Tag = 3
              Left = 131
              Top = 17
              Width = 41
              Height = 21
              BevelKind = bkFlat
              BorderStyle = bsNone
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
              ReadOnly = True
              TabOrder = 0
            end
            object DBEdit2: TDBEdit
              Tag = 4
              Left = 131
              Top = 42
              Width = 41
              Height = 21
              BevelKind = bkFlat
              BorderStyle = bsNone
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
              ReadOnly = True
              TabOrder = 1
            end
          end
          object GroupBox3: TGroupBox
            Left = 8
            Top = 15
            Width = 215
            Height = 70
            Caption = 'Tratto  principale'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentFont = False
            TabOrder = 1
            object Label5: TLabel
              Left = 8
              Top = 18
              Width = 117
              Height = 13
              Caption = 'Perdite unitarie ammesse'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
            end
            object Label7: TLabel
              Left = 8
              Top = 44
              Width = 81
              Height = 13
              Caption = 'Velocit'#224' massima'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
            end
            object Label17: TLabel
              Left = 176
              Top = 18
              Width = 32
              Height = 13
              Caption = '[Pa/m]'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
            end
            object Label20: TLabel
              Left = 176
              Top = 44
              Width = 24
              Height = 13
              Caption = '[m/s]'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
            end
            object DBEdit4: TDBEdit
              Tag = 2
              Left = 131
              Top = 40
              Width = 41
              Height = 21
              BevelKind = bkFlat
              BorderStyle = bsNone
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
              ReadOnly = True
              TabOrder = 1
            end
            object DBEdit3: TDBEdit
              Tag = 1
              Left = 131
              Top = 14
              Width = 41
              Height = 21
              BevelKind = bkFlat
              BorderStyle = bsNone
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
              ReadOnly = True
              TabOrder = 0
            end
          end
        end
        object GroupBox6: TGroupBox
          Left = 4
          Top = 1
          Width = 231
          Height = 58
          Caption = 'Settore'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clHotLight
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 0
          object ComboBox2: TComboBox
            Left = 11
            Top = 21
            Width = 211
            Height = 21
            BevelKind = bkFlat
            Style = csDropDownList
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ItemHeight = 0
            ParentFont = False
            TabOrder = 0
            OnChange = ComboBox2Change
          end
        end
        object GB_RisCalcolo: TGroupBox
          Left = 4
          Top = 227
          Width = 231
          Height = 70
          Caption = ' Valori di Portata e Prevalenza '
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clHotLight
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 2
          object Label25: TLabel
            Left = 13
            Top = 20
            Width = 34
            Height = 13
            Caption = 'Portata'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
          end
          object Label26: TLabel
            Left = 13
            Top = 45
            Width = 53
            Height = 13
            Caption = 'Prevalenza'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
          end
          object Label24: TLabel
            Left = 138
            Top = 20
            Width = 18
            Height = 13
            Caption = '[l/s]'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
          end
          object Label27: TLabel
            Left = 138
            Top = 45
            Width = 25
            Height = 13
            Caption = '[kPa]'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
          end
          object ED_Portata: TEdit
            Left = 73
            Top = 16
            Width = 60
            Height = 21
            BevelKind = bkFlat
            BorderStyle = bsNone
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            ReadOnly = True
            TabOrder = 0
          end
          object ED_Prevalenza: TEdit
            Left = 73
            Top = 41
            Width = 60
            Height = 21
            BevelKind = bkFlat
            BorderStyle = bsNone
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            ReadOnly = True
            TabOrder = 1
          end
        end
      end
      object TabSheet2: TTabSheet
        Caption = 'Dati dell'#39'elemento selezionato'
        ImageIndex = 1
        object GB_DatiOggetto: TGroupBox
          Left = 0
          Top = 0
          Width = 238
          Height = 369
          Caption = ' Dati Oggetto '
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clHotLight
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 0
          object Label9: TLabel
            Left = 8
            Top = 18
            Width = 39
            Height = 13
            Caption = 'Codice :'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
          end
          object Label10: TLabel
            Left = 57
            Top = 19
            Width = 3
            Height = 13
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
          end
          object Label11: TLabel
            Left = 7
            Top = 37
            Width = 51
            Height = 13
            Caption = 'Tipo tubo :'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
          end
          object LB_Lunghezza: TLabel
            Left = 7
            Top = 62
            Width = 123
            Height = 13
            Caption = 'Lunghezza totale dell'#39'arco'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
          end
          object Label18: TLabel
            Left = 7
            Top = 87
            Width = 107
            Height = 13
            Caption = 'Sigla diametro del tubo'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
          end
          object Label19: TLabel
            Left = 7
            Top = 112
            Width = 80
            Height = 13
            Caption = 'Portata calcolata'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
          end
          object Label29: TLabel
            Left = 211
            Top = 62
            Width = 14
            Height = 13
            Caption = '[m]'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
          end
          object Label30: TLabel
            Left = 211
            Top = 112
            Width = 18
            Height = 13
            Caption = '[l/s]'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
          end
          object Edit1: TEdit
            Left = 136
            Top = 58
            Width = 72
            Height = 21
            BevelKind = bkFlat
            BorderStyle = bsNone
            Color = clWhite
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            ReadOnly = True
            TabOrder = 1
          end
          object GroupBox5: TGroupBox
            Left = 8
            Top = 244
            Width = 225
            Height = 117
            Caption = 'Dati del terminale'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentFont = False
            TabOrder = 5
            object Label13: TLabel
              Left = 16
              Top = 23
              Width = 34
              Height = 13
              Caption = 'Portata'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
            end
            object Label16: TLabel
              Left = 16
              Top = 46
              Width = 33
              Height = 13
              Caption = 'Perdita'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
            end
            object Label21: TLabel
              Left = 16
              Top = 70
              Width = 39
              Height = 13
              Caption = 'Potenza'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
            end
            object Label31: TLabel
              Left = 160
              Top = 23
              Width = 18
              Height = 13
              Caption = '[l/s]'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
            end
            object Label32: TLabel
              Left = 160
              Top = 46
              Width = 19
              Height = 13
              Caption = '[Pa]'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
            end
            object Label33: TLabel
              Left = 160
              Top = 70
              Width = 17
              Height = 13
              Caption = '[W]'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
            end
            object Label28: TLabel
              Left = 15
              Top = 95
              Width = 43
              Height = 13
              Caption = 'Sbilancio'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
            end
            object Label34: TLabel
              Left = 160
              Top = 95
              Width = 19
              Height = 13
              Caption = '[Pa]'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
            end
            object Edit2: TEdit
              Left = 60
              Top = 19
              Width = 90
              Height = 21
              BevelKind = bkFlat
              BorderStyle = bsNone
              Color = clWhite
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
              ReadOnly = True
              TabOrder = 0
            end
            object Edit3: TEdit
              Left = 60
              Top = 42
              Width = 90
              Height = 21
              BevelKind = bkFlat
              BorderStyle = bsNone
              Color = clWhite
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
              ReadOnly = True
              TabOrder = 1
            end
            object Edit6: TEdit
              Left = 60
              Top = 66
              Width = 90
              Height = 21
              BevelKind = bkFlat
              BorderStyle = bsNone
              Color = clWhite
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
              ReadOnly = True
              TabOrder = 2
            end
            object Edit7: TEdit
              Left = 60
              Top = 91
              Width = 90
              Height = 21
              BevelKind = bkFlat
              BorderStyle = bsNone
              Color = clWhite
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
              ReadOnly = True
              TabOrder = 3
            end
          end
          object Edit4: TEdit
            Left = 120
            Top = 83
            Width = 88
            Height = 21
            BevelKind = bkFlat
            BorderStyle = bsNone
            Color = clWhite
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            ReadOnly = True
            TabOrder = 2
          end
          object Edit5: TEdit
            Left = 120
            Top = 108
            Width = 88
            Height = 21
            BevelKind = bkFlat
            BorderStyle = bsNone
            Color = clWhite
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            ReadOnly = True
            TabOrder = 3
          end
          object GroupBox7: TGroupBox
            Left = 8
            Top = 133
            Width = 226
            Height = 109
            Caption = 'Perdite localizzate'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentFont = False
            TabOrder = 4
            object MPerdite: TMemo
              Left = 6
              Top = 17
              Width = 215
              Height = 84
              BevelKind = bkFlat
              BorderStyle = bsNone
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
              ReadOnly = True
              TabOrder = 0
            end
          end
          object ED_TipoTubo: TEdit
            Left = 66
            Top = 33
            Width = 162
            Height = 21
            BevelKind = bkFlat
            BorderStyle = bsNone
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            ReadOnly = True
            TabOrder = 0
          end
        end
      end
      object TabSheet3: TTabSheet
        Caption = 'Dati del canale'
        ImageIndex = 2
        object GroupBox1: TGroupBox
          Left = 0
          Top = 7
          Width = 238
          Height = 161
          Caption = 'Dati del pezzo selezionato'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 0
          object Label2: TLabel
            Left = 8
            Top = 59
            Width = 124
            Height = 13
            Caption = 'Dimensione orizzontale (A)'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
          end
          object Label4: TLabel
            Left = 188
            Top = 59
            Width = 22
            Height = 13
            Caption = '[mm]'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
          end
          object Label6: TLabel
            Left = 8
            Top = 82
            Width = 114
            Height = 13
            Caption = 'Dimensione verticale (B)'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
          end
          object Label8: TLabel
            Left = 188
            Top = 83
            Width = 22
            Height = 13
            Caption = '[mm]'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
          end
          object Label12: TLabel
            Left = 8
            Top = 108
            Width = 45
            Height = 13
            Caption = 'Diametro '
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
          end
          object Label14: TLabel
            Left = 188
            Top = 107
            Width = 22
            Height = 13
            Caption = '[mm]'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
          end
          object Label15: TLabel
            Left = 8
            Top = 34
            Width = 33
            Height = 13
            Caption = 'Codice'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
          end
          object LIndpCan: TLabel
            Left = 48
            Top = 24
            Width = 5
            Height = 13
          end
          object EACan: TEdit
            Left = 136
            Top = 54
            Width = 49
            Height = 21
            BevelKind = bkFlat
            BorderStyle = bsNone
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            ReadOnly = True
            TabOrder = 0
          end
          object EBCan: TEdit
            Left = 136
            Top = 78
            Width = 49
            Height = 21
            BevelKind = bkFlat
            BorderStyle = bsNone
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            ReadOnly = True
            TabOrder = 1
          end
          object ERCan: TEdit
            Left = 136
            Top = 102
            Width = 49
            Height = 21
            BevelKind = bkFlat
            BorderStyle = bsNone
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            ReadOnly = True
            TabOrder = 2
          end
          object ECodiceCan: TEdit
            Left = 136
            Top = 30
            Width = 97
            Height = 21
            BevelKind = bkFlat
            BorderStyle = bsNone
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            ReadOnly = True
            TabOrder = 3
          end
        end
      end
    end
    object Memo1: TMemo
      Left = 1
      Top = 512
      Width = 246
      Height = 81
      BevelKind = bkFlat
      BorderStyle = bsNone
      Lines.Strings = (
        '')
      ReadOnly = True
      TabOrder = 1
    end
    object GroupBox8: TGroupBox
      Left = 4
      Top = 1
      Width = 241
      Height = 99
      Caption = ' Nome della rete visualizzata '
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clHotLight
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 2
      object DBGrid_NomeRete: TDBGrid
        Left = 7
        Top = 18
        Width = 227
        Height = 73
        BorderStyle = bsNone
        FixedColor = clInfoBk
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        Options = [dgTitles, dgColLines, dgConfirmDelete, dgCancelOnExit]
        ParentFont = False
        TabOrder = 0
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clHotLight
        TitleFont.Height = -11
        TitleFont.Name = 'MS Sans Serif'
        TitleFont.Style = [fsBold]
        OnCellClick = DBGrid_NomeReteCellClick
        OnKeyDown = DBGrid_NomeReteKeyDown
        OnKeyPress = DBGrid_NomeReteKeyPress
        OnKeyUp = DBGrid_NomeReteKeyUp
      end
    end
  end
  object Panel5: TPanel
    Left = 0
    Top = 0
    Width = 584
    Height = 594
    Align = alClient
    TabOrder = 2
    object PageControl1: TPageControl
      Left = 1
      Top = 1
      Width = 582
      Height = 43
      Align = alTop
      Style = tsButtons
      TabOrder = 0
    end
    object Panel3: TPanel
      Left = 1
      Top = 44
      Width = 582
      Height = 549
      Align = alClient
      BevelOuter = bvNone
      TabOrder = 1
      OnResize = Panel3Resize
      object Image1: TImage
        Left = 0
        Top = 0
        Width = 582
        Height = 549
        Align = alClient
        OnMouseDown = Image1MouseDown
      end
    end
  end
  object Timer1: TTimer
    Left = 136
    Top = 525
  end
end
