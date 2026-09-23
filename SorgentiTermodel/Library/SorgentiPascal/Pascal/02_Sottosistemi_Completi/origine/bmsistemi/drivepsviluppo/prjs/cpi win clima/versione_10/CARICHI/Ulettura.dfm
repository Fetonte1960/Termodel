object FLettura: TFLettura
  Left = 287
  Top = 192
  BorderStyle = bsDialog
  Caption = 
    'Lettura del disegno: elenco dei locali e relative strutture scam' +
    'bianti'
  ClientHeight = 635
  ClientWidth = 975
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnActivate = FormActivate
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object PageControl1: TPageControl
    Left = 0
    Top = 0
    Width = 975
    Height = 608
    ActivePage = TabSheet2
    Align = alClient
    Style = tsButtons
    TabIndex = 0
    TabOrder = 0
    object TabSheet2: TTabSheet
      Caption = 'Lettura del disegno'
      ImageIndex = 1
      object Panel4: TPanel
        Left = 687
        Top = 0
        Width = 280
        Height = 577
        Align = alRight
        BevelOuter = bvNone
        TabOrder = 0
        object Panel7: TPanel
          Left = 0
          Top = 0
          Width = 280
          Height = 402
          Align = alTop
          BevelOuter = bvNone
          TabOrder = 0
          object GroupBox5: TGroupBox
            Left = 0
            Top = 0
            Width = 280
            Height = 395
            Align = alTop
            Caption = 'Dati del locale selezionato'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clHotLight
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentFont = False
            TabOrder = 0
            object SB_Conferma: TSpeedButton
              Left = 9
              Top = 361
              Width = 124
              Height = 26
              Hint = 'Chiude la finestra'
              Caption = 'Salva Modifiche'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = []
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
                E000E3DFE000E3DFE000C6C6C600000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                00000000000000000000000000003E32280000000000E3DFE000E3DFE000E3DF
                E000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DF
                E000E3DFE000CACACA000F0D0C006A5E4E007C6E5B00625B4F0099A0A400B5BC
                C000ABB3B800C3C9CC00C3C9CC00D1D5D700E0E2E400E7E9EA00D7DBDD00B0B5
                B8004D473E0076614A0070604A00D8C39B00413C360000000000E3DFE000E3DF
                E000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DF
                E000E3DFE00000000000998977009E896E009C8565003C383300D0D4D700D0D4
                D600434A4E0042494D0042494D00B5BCC000C9CED100E2E5E600EAECED00E2E5
                E600554F45007361480078664D00DAC1A100403C370000000000E3DFE000E3DF
                E000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DF
                E000E3DFE00000000000DEC4A400A38B6900A18A7000433E3800DADEE000E8EA
                EB00464E5100444C4F00444C4F00BEC4C700B5BCC000C2C8CB00DCE0E100E6E8
                E9005851470079684E00806C4D00DBC3A300433F380000000000E3DFE000E3DF
                E000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DF
                E000E3DFE00000000000E1C8A800A68D6B00A48F72004D474000DDE1E200ECEF
                F0005E656700474F5200474F5200C6CACD00B9BFC200B5BCC000C0C6CA00D7DA
                DC005D554B007F694E00846F4F00DCCCBA00493E310000000000E3DFE000E3DF
                E000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DF
                E000E3DFE00000000000E1C9AA00A68E6C00A48C6C004D474000D3D8DA00E2E6
                E7005E656700474F5200474F5200D4D7D900BFC5C700B5BCC000ABB3B800C9CE
                CF00544C43007F694D00846F4F00DCCAB300493E310000000000E3DFE000E3DF
                E000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DF
                E000E3DFE00000000000E2C9AA00AA917000A78F6F0059534A008C939700DADD
                DF00DEE1E300E8EAEB00E8EAEB00E7E9EA00DADDDF00C9CECF00C0C6C9008E96
                9B00686156007A654B008C735400DDC6AA004E46340000000000E3DFE000E3DF
                E000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DF
                E000E3DFE00000000000E2C4AB00AD947200AC906F00AE9271004E4A4100514A
                4200635B5200796F6200766C5F0071695C006F665A006B6358006A635700635B
                520060533B004B423900B3977800CBB9A4005348360000000000E3DFE000E3DF
                E000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DF
                E000E3DFE00000000000E2C9A900AF947400B69E8100B8A08300B9A28600B79F
                8200B69D7F00B59C7E00B79F8200B2987900B9A28600B8A18500B8A18500BAA3
                8700B79F8200BDA78C00B8A08300BBA58A00594A360000000000E3DFE000E3DF
                E000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DF
                E000E3DFE00000000000E3CEAA00B29B7B009A8E7A007A7A7A00737373007373
                7300737373007373730073737300726F6B006F6F6F0073737300737373007373
                730073737300696969007E776F00B9A286005D513A0000000000E3DFE000E3DF
                E000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DF
                E000E3DFE00000000000E4D1B000B6A183005B5B7300FFFFFF00FFFFFF00FFFF
                FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                FF00FFFFFF00FFFFFF0073737300B8A08300645C510000000000E3DFE000E3DF
                E000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DF
                E000E3DFE00000000000E5CCAE00B6A07D0073737300CECECE00CDCDCD00CDCD
                CD00CDCDCD00CDCDCD00CDCDCD00CDCDCD00CDCDCD00CDCDCD00CDCDCD00CDCD
                CD00CDCDCD00C5C5C50073737300BAA387006960540000000000E3DFE000E3DF
                E000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DF
                E000E3DFE00000000000E5CAB500B9A27F0073737300FFFFFF00FFFFFF00FFFF
                FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                FF00FFFFFF00FFFFFF0073737300BAA387006D5C450000000000E3DFE000E3DF
                E000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DF
                E000E3DFE00000000000E7D2B700BBA0820063636300FFFFFF00FFFFFF00FFFF
                FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                FF00FFFFFF00FFFFFF0073737300BBA48800705E460000000000E3DFE000E3DF
                E000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DF
                E000E3DFE00000000000E6D3B900BFA3840073737300CECECE00CDCDCD00CDCD
                CD00CDCDCD00CDCDCD00CDCDCD00CDCDCD00CDCDCD00CDCDCD00CDCDCD00CDCD
                CD00CDCDCD00BFBFBF0073737300BBA488007662480000000000E3DFE000E3DF
                E000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DF
                E000E3DFE00000000000E7D3B900BFA4850073737300FFFFFF00FFFFFF00FFFF
                FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                FF00FFFFFF00FFFFFF0073737300B8A083007C694F0000000000E3DFE000E3DF
                E000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DF
                E000E3DFE00000000000E7D3B600C1AB870073737300FFFFFF00FFFFFF00FFFF
                FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                FF00FFFFFF00FFFFFF0073737300B8A08300806C520000000000E3DFE000E3DF
                E000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DF
                E000E3DFE00000000000E9D5BA00C3A78800706668007B81C800747CCB00737A
                CB00737BCB00727CCC00737DCB00646BBF00707ACC00626AC100737CCC005B65
                C2005964C3006A6CBA0070666800B69E81008670540000000000E3DFE000E3DF
                E000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DF
                E000E3DFE00000000000E8D6BB00C5AA8A00685F60007E8DE0006E82E0006E80
                E000687ADC007181DC006878DA007381D4006E7DD4006572CE006472CF006775
                CE005B67C4005865C30069616200B7A387008771560000000000E3DFE000E3DF
                E000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DF
                E000E3DFE00000000000F4D7C300E5CDA9007A757500BBC5EF00BEC8F100BCC6
                F000B2BCEE00B5BEEE00B8C1EE00B6BFED00ADB7E900AFB8E900ADB7E900AFB8
                E900B1B9E900BABFE50077727300E3CDB300D6BEA10000000000E3DFE000E3DF
                E000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DF
                E000E3DFE000E3DFE00000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                00000000000000000000000000000000000000000000E3DFE000E3DFE000E3DF
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
              ParentFont = False
              ParentShowHint = False
              ShowHint = True
              OnClick = SB_ConfermaClick
            end
            object PageControl4: TPageControl
              Left = 2
              Top = 15
              Width = 276
              Height = 346
              ActivePage = TabSheet8
              Align = alTop
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
              Style = tsButtons
              TabIndex = 0
              TabOrder = 0
              object TabSheet8: TTabSheet
                Caption = 'Generale'
                object GroupBox7: TGroupBox
                  Left = 0
                  Top = 0
                  Width = 268
                  Height = 315
                  Align = alClient
                  TabOrder = 0
                  object Label3: TLabel
                    Left = 8
                    Top = 42
                    Width = 55
                    Height = 13
                    Caption = 'Descrizione'
                  end
                  object Label31: TLabel
                    Left = 8
                    Top = 94
                    Width = 25
                    Height = 13
                    Caption = 'Zona'
                  end
                  object Label32: TLabel
                    Left = 8
                    Top = 125
                    Width = 40
                    Height = 13
                    Caption = 'Impianto'
                  end
                  object Label33: TLabel
                    Left = 8
                    Top = 230
                    Width = 61
                    Height = 13
                    Caption = 'Altezza netta'
                  end
                  object Label34: TLabel
                    Left = 8
                    Top = 180
                    Width = 47
                    Height = 13
                    Caption = 'Superficie'
                  end
                  object Label35: TLabel
                    Left = 8
                    Top = 258
                    Width = 158
                    Height = 13
                    Caption = 'Ventilazione meccanica (Trattata)'
                  end
                  object Label36: TLabel
                    Left = 117
                    Top = 230
                    Width = 14
                    Height = 13
                    Caption = '[m]'
                  end
                  object Label37: TLabel
                    Left = 104
                    Top = 180
                    Width = 17
                    Height = 13
                    Caption = '[m'#178']'
                  end
                  object Label38: TLabel
                    Left = 226
                    Top = 258
                    Width = 32
                    Height = 13
                    Caption = '[Vol/h]'
                  end
                  object Label58: TLabel
                    Left = 8
                    Top = 277
                    Width = 147
                    Height = 26
                    Caption = 
                      'Ricambi Naturali (Infiltrazioni) + '#13#10'Ventil. meccanica (non trat' +
                      'tata)'
                    WordWrap = True
                  end
                  object Label9: TLabel
                    Left = 226
                    Top = 284
                    Width = 32
                    Height = 13
                    Caption = '[Vol/h]'
                  end
                  object Label39: TLabel
                    Left = 8
                    Top = 208
                    Width = 136
                    Height = 13
                    Caption = 'Dati ereditati dalla zona'
                    Font.Charset = DEFAULT_CHARSET
                    Font.Color = clWindowText
                    Font.Height = -11
                    Font.Name = 'MS Sans Serif'
                    Font.Style = [fsBold]
                    ParentFont = False
                  end
                  object Label40: TLabel
                    Left = 8
                    Top = 153
                    Width = 145
                    Height = 13
                    Caption = 'Dati calcolati dal disegno'
                    Font.Charset = DEFAULT_CHARSET
                    Font.Color = clWindowText
                    Font.Height = -11
                    Font.Name = 'MS Sans Serif'
                    Font.Style = [fsBold]
                    ParentFont = False
                  end
                  object Label57: TLabel
                    Left = 8
                    Top = 15
                    Width = 115
                    Height = 13
                    Caption = 'Dati inseriti nel CAD'
                    Font.Charset = DEFAULT_CHARSET
                    Font.Color = clWindowText
                    Font.Height = -11
                    Font.Name = 'MS Sans Serif'
                    Font.Style = [fsBold]
                    ParentFont = False
                  end
                  object Label65: TLabel
                    Left = 140
                    Top = 180
                    Width = 35
                    Height = 13
                    Caption = 'Volume'
                  end
                  object Label66: TLabel
                    Left = 223
                    Top = 180
                    Width = 17
                    Height = 13
                    Caption = '[m'#179']'
                  end
                  object DBEdit1: TDBEdit
                    Tag = 4
                    Left = 8
                    Top = 59
                    Width = 217
                    Height = 21
                    BevelKind = bkFlat
                    BorderStyle = bsNone
                    TabOrder = 0
                  end
                  object DBEdit14: TDBEdit
                    Tag = 7
                    Left = 73
                    Top = 226
                    Width = 40
                    Height = 21
                    BevelKind = bkFlat
                    BorderStyle = bsNone
                    TabOrder = 4
                  end
                  object DBEdit15: TDBEdit
                    Tag = 6
                    Left = 60
                    Top = 176
                    Width = 40
                    Height = 21
                    BevelKind = bkFlat
                    BorderStyle = bsNone
                    Color = cl3DLight
                    ReadOnly = True
                    TabOrder = 3
                  end
                  object DBComboBox6: TDBComboBox
                    Tag = 5
                    Left = 73
                    Top = 90
                    Width = 145
                    Height = 21
                    Style = csDropDownList
                    BevelKind = bkFlat
                    ItemHeight = 13
                    TabOrder = 1
                    OnChange = DBComboBox6Change
                  end
                  object DBComboBox7: TDBComboBox
                    Tag = 8
                    Left = 73
                    Top = 121
                    Width = 145
                    Height = 21
                    Style = csDropDownList
                    BevelKind = bkFlat
                    ItemHeight = 13
                    TabOrder = 2
                    OnChange = DBComboBox7Change
                  end
                  object DBEdit16: TDBEdit
                    Tag = 3
                    Left = 183
                    Top = 254
                    Width = 40
                    Height = 21
                    BevelKind = bkFlat
                    BorderStyle = bsNone
                    Color = cl3DLight
                    ReadOnly = True
                    TabOrder = 5
                  end
                  object DBEdit26: TDBEdit
                    Tag = 2
                    Left = 183
                    Top = 280
                    Width = 40
                    Height = 21
                    BevelKind = bkFlat
                    BorderStyle = bsNone
                    Color = cl3DLight
                    ReadOnly = True
                    TabOrder = 6
                  end
                  object Ed_Volume: TEdit
                    Left = 180
                    Top = 177
                    Width = 40
                    Height = 21
                    BevelKind = bkFlat
                    BorderStyle = bsNone
                    Color = cl3DLight
                    ReadOnly = True
                    TabOrder = 7
                  end
                end
              end
              object TabSheet11: TTabSheet
                Caption = 'Climatizzazione'
                ImageIndex = 2
                object GroupBox12: TGroupBox
                  Left = 0
                  Top = 0
                  Width = 268
                  Height = 315
                  Align = alClient
                  Caption = 'Sorgenti interne di calore'
                  Font.Charset = DEFAULT_CHARSET
                  Font.Color = clWindowText
                  Font.Height = -11
                  Font.Name = 'MS Sans Serif'
                  Font.Style = [fsBold]
                  ParentFont = False
                  TabOrder = 0
                  object Label41: TLabel
                    Left = 8
                    Top = 50
                    Width = 69
                    Height = 13
                    Caption = 'Orario persone'
                    Font.Charset = DEFAULT_CHARSET
                    Font.Color = clWindowText
                    Font.Height = -11
                    Font.Name = 'MS Sans Serif'
                    Font.Style = []
                    ParentFont = False
                  end
                  object Label42: TLabel
                    Left = 8
                    Top = 102
                    Width = 123
                    Height = 13
                    Caption = 'Ricambio aria per persona'
                    Font.Charset = DEFAULT_CHARSET
                    Font.Color = clWindowText
                    Font.Height = -11
                    Font.Name = 'MS Sans Serif'
                    Font.Style = []
                    ParentFont = False
                  end
                  object Label43: TLabel
                    Left = 8
                    Top = 129
                    Width = 101
                    Height = 13
                    Caption = 'Sensibile per persona'
                    Font.Charset = DEFAULT_CHARSET
                    Font.Color = clWindowText
                    Font.Height = -11
                    Font.Name = 'MS Sans Serif'
                    Font.Style = []
                    ParentFont = False
                  end
                  object Label44: TLabel
                    Left = 8
                    Top = 155
                    Width = 95
                    Height = 13
                    Caption = 'Latente per persona'
                    Font.Charset = DEFAULT_CHARSET
                    Font.Color = clWindowText
                    Font.Height = -11
                    Font.Name = 'MS Sans Serif'
                    Font.Style = []
                    ParentFont = False
                  end
                  object Label45: TLabel
                    Left = 196
                    Top = 102
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
                  object Label46: TLabel
                    Left = 196
                    Top = 129
                    Width = 60
                    Height = 13
                    Caption = '[W/persona]'
                    Font.Charset = DEFAULT_CHARSET
                    Font.Color = clWindowText
                    Font.Height = -11
                    Font.Name = 'MS Sans Serif'
                    Font.Style = []
                    ParentFont = False
                  end
                  object Label47: TLabel
                    Left = 196
                    Top = 155
                    Width = 60
                    Height = 13
                    Caption = '[W/persona]'
                    Font.Charset = DEFAULT_CHARSET
                    Font.Color = clWindowText
                    Font.Height = -11
                    Font.Name = 'MS Sans Serif'
                    Font.Style = []
                    ParentFont = False
                  end
                  object Label48: TLabel
                    Left = 8
                    Top = 182
                    Width = 108
                    Height = 13
                    Caption = 'Orario apparecchiature'
                    Font.Charset = DEFAULT_CHARSET
                    Font.Color = clWindowText
                    Font.Height = -11
                    Font.Name = 'MS Sans Serif'
                    Font.Style = []
                    ParentFont = False
                  end
                  object Label49: TLabel
                    Left = 8
                    Top = 208
                    Width = 140
                    Height = 13
                    Caption = 'Sensibile per apparecchiature'
                    Font.Charset = DEFAULT_CHARSET
                    Font.Color = clWindowText
                    Font.Height = -11
                    Font.Name = 'MS Sans Serif'
                    Font.Style = []
                    ParentFont = False
                  end
                  object Label50: TLabel
                    Left = 196
                    Top = 208
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
                  object Label51: TLabel
                    Left = 8
                    Top = 235
                    Width = 134
                    Height = 13
                    Caption = 'Latente per apparecchiature'
                    Font.Charset = DEFAULT_CHARSET
                    Font.Color = clWindowText
                    Font.Height = -11
                    Font.Name = 'MS Sans Serif'
                    Font.Style = []
                    ParentFont = False
                  end
                  object Label52: TLabel
                    Left = 196
                    Top = 235
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
                  object Label53: TLabel
                    Left = 8
                    Top = 261
                    Width = 90
                    Height = 13
                    Caption = 'Orario illuminazione'
                    Font.Charset = DEFAULT_CHARSET
                    Font.Color = clWindowText
                    Font.Height = -11
                    Font.Name = 'MS Sans Serif'
                    Font.Style = []
                    ParentFont = False
                  end
                  object Label54: TLabel
                    Left = 8
                    Top = 288
                    Width = 122
                    Height = 13
                    Caption = 'Sensibile per illuminazione'
                    Font.Charset = DEFAULT_CHARSET
                    Font.Color = clWindowText
                    Font.Height = -11
                    Font.Name = 'MS Sans Serif'
                    Font.Style = []
                    ParentFont = False
                  end
                  object Label55: TLabel
                    Left = 200
                    Top = 258
                    Width = 21
                    Height = 13
                    Caption = '[W]'
                  end
                  object Label56: TLabel
                    Left = 8
                    Top = 76
                    Width = 78
                    Height = 13
                    Caption = 'Numero persone'
                    Font.Charset = DEFAULT_CHARSET
                    Font.Color = clWindowText
                    Font.Height = -11
                    Font.Name = 'MS Sans Serif'
                    Font.Style = []
                    ParentFont = False
                  end
                  object Label59: TLabel
                    Left = 8
                    Top = 24
                    Width = 136
                    Height = 13
                    Caption = 'Dati ereditati dalla zona'
                    Font.Charset = DEFAULT_CHARSET
                    Font.Color = clWindowText
                    Font.Height = -11
                    Font.Name = 'MS Sans Serif'
                    Font.Style = [fsBold]
                    ParentFont = False
                  end
                  object Label64: TLabel
                    Left = 196
                    Top = 288
                    Width = 33
                    Height = 13
                    Caption = '[W/m'#178']'
                    Font.Charset = DEFAULT_CHARSET
                    Font.Color = clWindowText
                    Font.Height = -11
                    Font.Name = 'MS Sans Serif'
                    Font.Style = []
                    ParentFont = False
                  end
                  object DBComboBox8: TDBComboBox
                    Tag = 10
                    Left = 120
                    Top = 46
                    Width = 138
                    Height = 21
                    Style = csDropDownList
                    BevelKind = bkFlat
                    Font.Charset = DEFAULT_CHARSET
                    Font.Color = clWindowText
                    Font.Height = -11
                    Font.Name = 'MS Sans Serif'
                    Font.Style = []
                    ItemHeight = 13
                    ParentFont = False
                    TabOrder = 0
                    OnChange = DBComboBox8Change
                  end
                  object DBEdit18: TDBEdit
                    Tag = 12
                    Left = 153
                    Top = 98
                    Width = 40
                    Height = 21
                    BevelKind = bkFlat
                    BorderStyle = bsNone
                    Font.Charset = DEFAULT_CHARSET
                    Font.Color = clWindowText
                    Font.Height = -11
                    Font.Name = 'MS Sans Serif'
                    Font.Style = []
                    ParentFont = False
                    TabOrder = 2
                  end
                  object DBEdit19: TDBEdit
                    Tag = 13
                    Left = 153
                    Top = 125
                    Width = 40
                    Height = 21
                    BevelKind = bkFlat
                    BorderStyle = bsNone
                    Font.Charset = DEFAULT_CHARSET
                    Font.Color = clWindowText
                    Font.Height = -11
                    Font.Name = 'MS Sans Serif'
                    Font.Style = []
                    ParentFont = False
                    TabOrder = 3
                  end
                  object DBEdit20: TDBEdit
                    Tag = 14
                    Left = 153
                    Top = 151
                    Width = 40
                    Height = 21
                    BevelKind = bkFlat
                    BorderStyle = bsNone
                    Font.Charset = DEFAULT_CHARSET
                    Font.Color = clWindowText
                    Font.Height = -11
                    Font.Name = 'MS Sans Serif'
                    Font.Style = []
                    ParentFont = False
                    TabOrder = 4
                  end
                  object DBComboBox9: TDBComboBox
                    Tag = 15
                    Left = 120
                    Top = 178
                    Width = 138
                    Height = 21
                    Style = csDropDownList
                    BevelKind = bkFlat
                    Font.Charset = DEFAULT_CHARSET
                    Font.Color = clWindowText
                    Font.Height = -11
                    Font.Name = 'MS Sans Serif'
                    Font.Style = []
                    ItemHeight = 13
                    ParentFont = False
                    TabOrder = 5
                    OnChange = DBComboBox9Change
                  end
                  object DBEdit21: TDBEdit
                    Tag = 16
                    Left = 153
                    Top = 204
                    Width = 40
                    Height = 21
                    BevelKind = bkFlat
                    BorderStyle = bsNone
                    Font.Charset = DEFAULT_CHARSET
                    Font.Color = clWindowText
                    Font.Height = -11
                    Font.Name = 'MS Sans Serif'
                    Font.Style = []
                    ParentFont = False
                    TabOrder = 6
                  end
                  object DBEdit22: TDBEdit
                    Tag = 17
                    Left = 153
                    Top = 231
                    Width = 40
                    Height = 21
                    BevelKind = bkFlat
                    BorderStyle = bsNone
                    Font.Charset = DEFAULT_CHARSET
                    Font.Color = clWindowText
                    Font.Height = -11
                    Font.Name = 'MS Sans Serif'
                    Font.Style = []
                    ParentFont = False
                    TabOrder = 7
                  end
                  object DBComboBox10: TDBComboBox
                    Tag = 18
                    Left = 120
                    Top = 257
                    Width = 138
                    Height = 21
                    Style = csDropDownList
                    BevelKind = bkFlat
                    Font.Charset = DEFAULT_CHARSET
                    Font.Color = clWindowText
                    Font.Height = -11
                    Font.Name = 'MS Sans Serif'
                    Font.Style = []
                    ItemHeight = 13
                    ParentFont = False
                    TabOrder = 8
                    OnChange = DBComboBox10Change
                  end
                  object DBEdit23: TDBEdit
                    Tag = 19
                    Left = 153
                    Top = 284
                    Width = 40
                    Height = 21
                    BevelKind = bkFlat
                    BorderStyle = bsNone
                    Font.Charset = DEFAULT_CHARSET
                    Font.Color = clWindowText
                    Font.Height = -11
                    Font.Name = 'MS Sans Serif'
                    Font.Style = []
                    ParentFont = False
                    TabOrder = 9
                  end
                  object DBEdit24: TDBEdit
                    Tag = 11
                    Left = 153
                    Top = 72
                    Width = 40
                    Height = 21
                    BevelKind = bkFlat
                    BorderStyle = bsNone
                    Font.Charset = DEFAULT_CHARSET
                    Font.Color = clWindowText
                    Font.Height = -11
                    Font.Name = 'MS Sans Serif'
                    Font.Style = []
                    ParentFont = False
                    TabOrder = 1
                  end
                end
              end
              object TabSheet3: TTabSheet
                Caption = 'Soffitto - Pavimento'
                ImageIndex = 2
                object GroupBox11: TGroupBox
                  Left = 0
                  Top = 0
                  Width = 268
                  Height = 315
                  Align = alClient
                  Caption = 'Dati del pavimento e del soffitto del locale'
                  Font.Charset = DEFAULT_CHARSET
                  Font.Color = clWindowText
                  Font.Height = -11
                  Font.Name = 'MS Sans Serif'
                  Font.Style = [fsBold]
                  ParentFont = False
                  TabOrder = 0
                  object Label60: TLabel
                    Left = 16
                    Top = 130
                    Width = 73
                    Height = 13
                    Caption = 'Tipo pavimento'
                    Font.Charset = DEFAULT_CHARSET
                    Font.Color = clWindowText
                    Font.Height = -11
                    Font.Name = 'MS Sans Serif'
                    Font.Style = []
                    ParentFont = False
                  end
                  object Label61: TLabel
                    Left = 16
                    Top = 23
                    Width = 55
                    Height = 13
                    Caption = 'Tipo soffitto'
                    Font.Charset = DEFAULT_CHARSET
                    Font.Color = clWindowText
                    Font.Height = -11
                    Font.Name = 'MS Sans Serif'
                    Font.Style = []
                    ParentFont = False
                  end
                  object Label62: TLabel
                    Left = 16
                    Top = 183
                    Width = 88
                    Height = 13
                    Caption = 'Confine pavimento'
                    Font.Charset = DEFAULT_CHARSET
                    Font.Color = clWindowText
                    Font.Height = -11
                    Font.Name = 'MS Sans Serif'
                    Font.Style = []
                    ParentFont = False
                  end
                  object Label63: TLabel
                    Left = 16
                    Top = 77
                    Width = 70
                    Height = 13
                    Caption = 'Confine soffitto'
                    Font.Charset = DEFAULT_CHARSET
                    Font.Color = clWindowText
                    Font.Height = -11
                    Font.Name = 'MS Sans Serif'
                    Font.Style = []
                    ParentFont = False
                  end
                  object DBComboBox11: TDBComboBox
                    Tag = 24
                    Left = 114
                    Top = 169
                    Width = 145
                    Height = 21
                    Style = csDropDownList
                    BevelKind = bkFlat
                    Font.Charset = DEFAULT_CHARSET
                    Font.Color = clWindowText
                    Font.Height = -11
                    Font.Name = 'MS Sans Serif'
                    Font.Style = []
                    ItemHeight = 13
                    ParentFont = False
                    TabOrder = 5
                    Visible = False
                    OnChange = DBComboBox11Change
                  end
                  object DBComboBox12: TDBComboBox
                    Tag = 25
                    Left = 114
                    Top = 224
                    Width = 145
                    Height = 21
                    Style = csDropDownList
                    BevelKind = bkFlat
                    Font.Charset = DEFAULT_CHARSET
                    Font.Color = clWindowText
                    Font.Height = -11
                    Font.Name = 'MS Sans Serif'
                    Font.Style = []
                    ItemHeight = 13
                    ParentFont = False
                    TabOrder = 7
                    Visible = False
                    OnChange = DBComboBox12Change
                  end
                  object DBComboBox13: TDBComboBox
                    Tag = 26
                    Left = 114
                    Top = 62
                    Width = 145
                    Height = 21
                    Style = csDropDownList
                    BevelKind = bkFlat
                    Font.Charset = DEFAULT_CHARSET
                    Font.Color = clWindowText
                    Font.Height = -11
                    Font.Name = 'MS Sans Serif'
                    Font.Style = []
                    ItemHeight = 13
                    ParentFont = False
                    TabOrder = 1
                    Visible = False
                    OnChange = DBComboBox13Change
                  end
                  object DBComboBox14: TDBComboBox
                    Tag = 27
                    Left = 114
                    Top = 114
                    Width = 145
                    Height = 21
                    Style = csDropDownList
                    BevelKind = bkFlat
                    Font.Charset = DEFAULT_CHARSET
                    Font.Color = clWindowText
                    Font.Height = -11
                    Font.Name = 'MS Sans Serif'
                    Font.Style = []
                    ItemHeight = 13
                    ParentFont = False
                    TabOrder = 3
                    Visible = False
                    OnChange = DBComboBox14Change
                  end
                  object Combo_TipoSoffitto: TComboBox
                    Left = 18
                    Top = 46
                    Width = 240
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
                    OnChange = Combo_TipoSoffittoChange
                  end
                  object Combo_ConfineSoffitto: TComboBox
                    Left = 18
                    Top = 100
                    Width = 240
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
                    TabOrder = 2
                    OnChange = Combo_ConfineSoffittoChange
                  end
                  object Combo_TipoPavimento: TComboBox
                    Left = 18
                    Top = 152
                    Width = 240
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
                    TabOrder = 4
                    OnChange = Combo_TipoPavimentoChange
                  end
                  object Combo_ConfinePavimento: TComboBox
                    Left = 18
                    Top = 206
                    Width = 240
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
                    TabOrder = 6
                    OnChange = Combo_ConfinePavimentoChange
                  end
                end
              end
            end
          end
        end
        object GroupBox6: TGroupBox
          Left = 0
          Top = 400
          Width = 280
          Height = 144
          Caption = 'Avvisi anomalie del disegno'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clHotLight
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 1
          object Memo1: TMemo
            Left = 2
            Top = 15
            Width = 276
            Height = 111
            Align = alTop
            BevelKind = bkFlat
            BorderStyle = bsNone
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            Lines.Strings = (
              '')
            ParentFont = False
            ScrollBars = ssVertical
            TabOrder = 0
          end
        end
        object Panel3: TPanel
          Left = 0
          Top = 529
          Width = 280
          Height = 48
          Align = alBottom
          BevelOuter = bvLowered
          TabOrder = 2
          object Label2: TLabel
            Left = 6
            Top = 15
            Width = 27
            Height = 13
            Caption = 'Piano'
          end
          object ComboBox1: TComboBox
            Left = 42
            Top = 11
            Width = 169
            Height = 21
            BevelKind = bkFlat
            Style = csDropDownList
            ItemHeight = 13
            TabOrder = 0
            OnChange = ComboBox1Change
          end
        end
      end
      object Panel6: TPanel
        Left = 0
        Top = 0
        Width = 687
        Height = 577
        Align = alClient
        BevelOuter = bvNone
        TabOrder = 1
        object GroupBox13: TGroupBox
          Left = 0
          Top = 440
          Width = 687
          Height = 137
          Align = alBottom
          Caption = 
            ' Dati locale selezionato  (cliccare su una linea o su un cerchio' +
            ' per selezionare) '
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clHotLight
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 0
          object DBGrid4: TDBGrid
            Left = 2
            Top = 15
            Width = 265
            Height = 117
            BorderStyle = bsNone
            FixedColor = clInfoBk
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            Options = [dgTitles, dgColLines, dgTabs, dgRowSelect, dgAlwaysShowSelection]
            ParentFont = False
            ReadOnly = True
            TabOrder = 0
            TitleFont.Charset = DEFAULT_CHARSET
            TitleFont.Color = clHotLight
            TitleFont.Height = -11
            TitleFont.Name = 'MS Sans Serif'
            TitleFont.Style = [fsBold]
            OnCellClick = DBGrid4CellClick
            OnEnter = DBGrid4Enter
            OnKeyDown = DBGrid4KeyDown
            OnKeyPress = DBGrid4KeyPress
            OnKeyUp = DBGrid4KeyUp
          end
          object GroupBox9: TGroupBox
            Left = 271
            Top = 14
            Width = 411
            Height = 120
            Caption = 'Parete selezionata'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentFont = False
            TabOrder = 1
            object DBGrid5: TDBGrid
              Left = 6
              Top = 13
              Width = 399
              Height = 103
              BorderStyle = bsNone
              FixedColor = clInfoBk
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              Options = [dgTitles, dgColLines, dgTabs, dgRowSelect, dgAlwaysShowSelection]
              ParentFont = False
              ReadOnly = True
              TabOrder = 0
              TitleFont.Charset = DEFAULT_CHARSET
              TitleFont.Color = clHotLight
              TitleFont.Height = -11
              TitleFont.Name = 'MS Sans Serif'
              TitleFont.Style = [fsBold]
              OnCellClick = DBGrid5CellClick
              OnEnter = DBGrid5Enter
            end
          end
        end
        object PageControl2: TPageControl
          Left = 0
          Top = 0
          Width = 687
          Height = 40
          Align = alTop
          Style = tsButtons
          TabOrder = 1
        end
        object Panel5: TPanel
          Left = 0
          Top = 40
          Width = 687
          Height = 400
          Align = alClient
          BevelOuter = bvNone
          TabOrder = 2
          object Image1: TImage
            Left = 0
            Top = 0
            Width = 687
            Height = 400
            Align = alClient
            OnMouseDown = Image1MouseDown
          end
        end
      end
    end
    object TabSheet1: TTabSheet
      Caption = 'Locali e strutture scambianti'
      object GroupBox2: TGroupBox
        Left = 0
        Top = 0
        Width = 519
        Height = 290
        Caption = 'Elenco dei locali'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clHotLight
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 0
        object DBGrid1: TDBGrid
          Left = 2
          Top = 15
          Width = 515
          Height = 273
          Align = alClient
          FixedColor = clSilver
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          Options = [dgTitles, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit]
          ParentFont = False
          TabOrder = 0
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -11
          TitleFont.Name = 'MS Sans Serif'
          TitleFont.Style = [fsBold]
        end
      end
      object GroupBox3: TGroupBox
        Left = 1
        Top = 290
        Width = 520
        Height = 283
        Caption = 'Strutture scambianti del locale selezionato'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clHotLight
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 1
        object DBGrid2: TDBGrid
          Left = 2
          Top = 15
          Width = 516
          Height = 266
          Align = alClient
          FixedColor = clSilver
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          Options = [dgTitles, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit]
          ParentFont = False
          TabOrder = 0
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -11
          TitleFont.Name = 'MS Sans Serif'
          TitleFont.Style = [fsBold]
        end
      end
      object GroupBox1: TGroupBox
        Left = 523
        Top = 0
        Width = 438
        Height = 573
        Caption = 'Dati del locale selezionato'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clHotLight
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 2
        object SpeedButton1: TSpeedButton
          Left = 7
          Top = 541
          Width = 124
          Height = 26
          Hint = 'Chiude la finestra'
          Caption = 'Salva Modifiche'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
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
            E000E3DFE000E3DFE000C6C6C600000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            00000000000000000000000000003E32280000000000E3DFE000E3DFE000E3DF
            E000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DF
            E000E3DFE000CACACA000F0D0C006A5E4E007C6E5B00625B4F0099A0A400B5BC
            C000ABB3B800C3C9CC00C3C9CC00D1D5D700E0E2E400E7E9EA00D7DBDD00B0B5
            B8004D473E0076614A0070604A00D8C39B00413C360000000000E3DFE000E3DF
            E000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DF
            E000E3DFE00000000000998977009E896E009C8565003C383300D0D4D700D0D4
            D600434A4E0042494D0042494D00B5BCC000C9CED100E2E5E600EAECED00E2E5
            E600554F45007361480078664D00DAC1A100403C370000000000E3DFE000E3DF
            E000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DF
            E000E3DFE00000000000DEC4A400A38B6900A18A7000433E3800DADEE000E8EA
            EB00464E5100444C4F00444C4F00BEC4C700B5BCC000C2C8CB00DCE0E100E6E8
            E9005851470079684E00806C4D00DBC3A300433F380000000000E3DFE000E3DF
            E000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DF
            E000E3DFE00000000000E1C8A800A68D6B00A48F72004D474000DDE1E200ECEF
            F0005E656700474F5200474F5200C6CACD00B9BFC200B5BCC000C0C6CA00D7DA
            DC005D554B007F694E00846F4F00DCCCBA00493E310000000000E3DFE000E3DF
            E000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DF
            E000E3DFE00000000000E1C9AA00A68E6C00A48C6C004D474000D3D8DA00E2E6
            E7005E656700474F5200474F5200D4D7D900BFC5C700B5BCC000ABB3B800C9CE
            CF00544C43007F694D00846F4F00DCCAB300493E310000000000E3DFE000E3DF
            E000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DF
            E000E3DFE00000000000E2C9AA00AA917000A78F6F0059534A008C939700DADD
            DF00DEE1E300E8EAEB00E8EAEB00E7E9EA00DADDDF00C9CECF00C0C6C9008E96
            9B00686156007A654B008C735400DDC6AA004E46340000000000E3DFE000E3DF
            E000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DF
            E000E3DFE00000000000E2C4AB00AD947200AC906F00AE9271004E4A4100514A
            4200635B5200796F6200766C5F0071695C006F665A006B6358006A635700635B
            520060533B004B423900B3977800CBB9A4005348360000000000E3DFE000E3DF
            E000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DF
            E000E3DFE00000000000E2C9A900AF947400B69E8100B8A08300B9A28600B79F
            8200B69D7F00B59C7E00B79F8200B2987900B9A28600B8A18500B8A18500BAA3
            8700B79F8200BDA78C00B8A08300BBA58A00594A360000000000E3DFE000E3DF
            E000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DF
            E000E3DFE00000000000E3CEAA00B29B7B009A8E7A007A7A7A00737373007373
            7300737373007373730073737300726F6B006F6F6F0073737300737373007373
            730073737300696969007E776F00B9A286005D513A0000000000E3DFE000E3DF
            E000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DF
            E000E3DFE00000000000E4D1B000B6A183005B5B7300FFFFFF00FFFFFF00FFFF
            FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
            FF00FFFFFF00FFFFFF0073737300B8A08300645C510000000000E3DFE000E3DF
            E000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DF
            E000E3DFE00000000000E5CCAE00B6A07D0073737300CECECE00CDCDCD00CDCD
            CD00CDCDCD00CDCDCD00CDCDCD00CDCDCD00CDCDCD00CDCDCD00CDCDCD00CDCD
            CD00CDCDCD00C5C5C50073737300BAA387006960540000000000E3DFE000E3DF
            E000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DF
            E000E3DFE00000000000E5CAB500B9A27F0073737300FFFFFF00FFFFFF00FFFF
            FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
            FF00FFFFFF00FFFFFF0073737300BAA387006D5C450000000000E3DFE000E3DF
            E000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DF
            E000E3DFE00000000000E7D2B700BBA0820063636300FFFFFF00FFFFFF00FFFF
            FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
            FF00FFFFFF00FFFFFF0073737300BBA48800705E460000000000E3DFE000E3DF
            E000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DF
            E000E3DFE00000000000E6D3B900BFA3840073737300CECECE00CDCDCD00CDCD
            CD00CDCDCD00CDCDCD00CDCDCD00CDCDCD00CDCDCD00CDCDCD00CDCDCD00CDCD
            CD00CDCDCD00BFBFBF0073737300BBA488007662480000000000E3DFE000E3DF
            E000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DF
            E000E3DFE00000000000E7D3B900BFA4850073737300FFFFFF00FFFFFF00FFFF
            FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
            FF00FFFFFF00FFFFFF0073737300B8A083007C694F0000000000E3DFE000E3DF
            E000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DF
            E000E3DFE00000000000E7D3B600C1AB870073737300FFFFFF00FFFFFF00FFFF
            FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
            FF00FFFFFF00FFFFFF0073737300B8A08300806C520000000000E3DFE000E3DF
            E000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DF
            E000E3DFE00000000000E9D5BA00C3A78800706668007B81C800747CCB00737A
            CB00737BCB00727CCC00737DCB00646BBF00707ACC00626AC100737CCC005B65
            C2005964C3006A6CBA0070666800B69E81008670540000000000E3DFE000E3DF
            E000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DF
            E000E3DFE00000000000E8D6BB00C5AA8A00685F60007E8DE0006E82E0006E80
            E000687ADC007181DC006878DA007381D4006E7DD4006572CE006472CF006775
            CE005B67C4005865C30069616200B7A387008771560000000000E3DFE000E3DF
            E000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DF
            E000E3DFE00000000000F4D7C300E5CDA9007A757500BBC5EF00BEC8F100BCC6
            F000B2BCEE00B5BEEE00B8C1EE00B6BFED00ADB7E900AFB8E900ADB7E900AFB8
            E900B1B9E900BABFE50077727300E3CDB300D6BEA10000000000E3DFE000E3DF
            E000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DFE000E3DF
            E000E3DFE000E3DFE00000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            00000000000000000000000000000000000000000000E3DFE000E3DFE000E3DF
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
          ParentFont = False
          ParentShowHint = False
          ShowHint = True
          OnClick = SB_ConfermaClick
        end
        object PageControl3: TPageControl
          Left = 2
          Top = 15
          Width = 434
          Height = 511
          ActivePage = TabSheet10
          Align = alTop
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          Style = tsButtons
          TabIndex = 1
          TabOrder = 0
          object TabSheet6: TTabSheet
            Caption = 'Generale'
            object GroupBox8: TGroupBox
              Left = 0
              Top = 0
              Width = 417
              Height = 476
              Enabled = False
              TabOrder = 0
              object Label4: TLabel
                Left = 10
                Top = 26
                Width = 55
                Height = 13
                Caption = 'Descrizione'
              end
              object Label5: TLabel
                Left = 10
                Top = 54
                Width = 25
                Height = 13
                Caption = 'Zona'
              end
              object Label6: TLabel
                Left = 10
                Top = 82
                Width = 40
                Height = 13
                Caption = 'Impianto'
              end
              object Label7: TLabel
                Left = 10
                Top = 110
                Width = 61
                Height = 13
                Caption = 'Altezza netta'
              end
              object Label8: TLabel
                Left = 10
                Top = 139
                Width = 47
                Height = 13
                Caption = 'Superficie'
              end
              object Label10: TLabel
                Left = 10
                Top = 164
                Width = 112
                Height = 26
                Caption = 'Ventilazione meccanica'#13#10'        (aria esterna)'
                WordWrap = True
              end
              object Label11: TLabel
                Left = 184
                Top = 110
                Width = 14
                Height = 13
                Caption = '[m]'
              end
              object Label12: TLabel
                Left = 184
                Top = 139
                Width = 17
                Height = 13
                Caption = '[m'#178']'
              end
              object Label13: TLabel
                Left = 184
                Top = 171
                Width = 32
                Height = 13
                Caption = '[Vol/h]'
              end
              object Label1: TLabel
                Left = 10
                Top = 203
                Width = 103
                Height = 13
                Caption = 'Ricambi d'#39'aria naturali'
              end
              object Label30: TLabel
                Left = 184
                Top = 203
                Width = 32
                Height = 13
                Caption = '[Vol/h]'
              end
              object DBEdit2: TDBEdit
                Tag = 4
                Left = 135
                Top = 22
                Width = 170
                Height = 21
                BevelKind = bkFlat
                BorderStyle = bsNone
                TabOrder = 0
              end
              object DBEdit3: TDBEdit
                Tag = 7
                Left = 135
                Top = 106
                Width = 41
                Height = 21
                BevelKind = bkFlat
                BorderStyle = bsNone
                TabOrder = 1
              end
              object DBEdit4: TDBEdit
                Tag = 6
                Left = 135
                Top = 135
                Width = 41
                Height = 21
                BevelKind = bkFlat
                BorderStyle = bsNone
                TabOrder = 2
              end
              object DBComboBox1: TDBComboBox
                Tag = 5
                Left = 135
                Top = 50
                Width = 170
                Height = 21
                BevelKind = bkFlat
                ItemHeight = 13
                TabOrder = 3
              end
              object DBComboBox2: TDBComboBox
                Tag = 8
                Left = 135
                Top = 78
                Width = 170
                Height = 21
                BevelKind = bkFlat
                ItemHeight = 13
                TabOrder = 4
              end
              object DBEdit6: TDBEdit
                Tag = 3
                Left = 135
                Top = 167
                Width = 41
                Height = 21
                BevelKind = bkFlat
                BorderStyle = bsNone
                TabOrder = 5
              end
              object DBEdit25: TDBEdit
                Tag = 2
                Left = 135
                Top = 199
                Width = 41
                Height = 21
                BevelKind = bkFlat
                BorderStyle = bsNone
                TabOrder = 6
              end
            end
          end
          object TabSheet10: TTabSheet
            Caption = 'Climatizzazione'
            ImageIndex = 2
            object GroupBox10: TGroupBox
              Left = 0
              Top = 0
              Width = 417
              Height = 481
              Caption = 'Sorgenti interne di calore'
              Enabled = False
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = [fsBold]
              ParentFont = False
              TabOrder = 0
              object Label14: TLabel
                Left = 10
                Top = 26
                Width = 69
                Height = 13
                Caption = 'Orario persone'
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWindowText
                Font.Height = -11
                Font.Name = 'MS Sans Serif'
                Font.Style = []
                ParentFont = False
              end
              object Label15: TLabel
                Left = 10
                Top = 77
                Width = 123
                Height = 13
                Caption = 'Ricambio aria per persona'
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWindowText
                Font.Height = -11
                Font.Name = 'MS Sans Serif'
                Font.Style = []
                ParentFont = False
              end
              object Label16: TLabel
                Left = 10
                Top = 103
                Width = 101
                Height = 13
                Caption = 'Sensibile per persona'
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWindowText
                Font.Height = -11
                Font.Name = 'MS Sans Serif'
                Font.Style = []
                ParentFont = False
              end
              object Label17: TLabel
                Left = 10
                Top = 129
                Width = 95
                Height = 13
                Caption = 'Latente per persona'
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWindowText
                Font.Height = -11
                Font.Name = 'MS Sans Serif'
                Font.Style = []
                ParentFont = False
              end
              object Label18: TLabel
                Left = 203
                Top = 77
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
              object Label19: TLabel
                Left = 203
                Top = 103
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
              object Label20: TLabel
                Left = 203
                Top = 129
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
              object Label21: TLabel
                Left = 10
                Top = 154
                Width = 108
                Height = 13
                Caption = 'Orario apparecchiature'
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWindowText
                Font.Height = -11
                Font.Name = 'MS Sans Serif'
                Font.Style = []
                ParentFont = False
              end
              object Label22: TLabel
                Left = 10
                Top = 180
                Width = 140
                Height = 13
                Caption = 'Sensibile per apparecchiature'
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWindowText
                Font.Height = -11
                Font.Name = 'MS Sans Serif'
                Font.Style = []
                ParentFont = False
              end
              object Label23: TLabel
                Left = 203
                Top = 180
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
              object Label24: TLabel
                Left = 10
                Top = 206
                Width = 134
                Height = 13
                Caption = 'Latente per apparecchiature'
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWindowText
                Font.Height = -11
                Font.Name = 'MS Sans Serif'
                Font.Style = []
                ParentFont = False
              end
              object Label25: TLabel
                Left = 203
                Top = 206
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
              object Label26: TLabel
                Left = 10
                Top = 232
                Width = 90
                Height = 13
                Caption = 'Orario illuminazione'
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWindowText
                Font.Height = -11
                Font.Name = 'MS Sans Serif'
                Font.Style = []
                ParentFont = False
              end
              object Label27: TLabel
                Left = 10
                Top = 258
                Width = 122
                Height = 13
                Caption = 'Sensibile per illuminazione'
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWindowText
                Font.Height = -11
                Font.Name = 'MS Sans Serif'
                Font.Style = []
                ParentFont = False
              end
              object Label28: TLabel
                Left = 203
                Top = 258
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
              object Label29: TLabel
                Left = 10
                Top = 51
                Width = 78
                Height = 13
                Caption = 'Numero persone'
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWindowText
                Font.Height = -11
                Font.Name = 'MS Sans Serif'
                Font.Style = []
                ParentFont = False
              end
              object DBComboBox3: TDBComboBox
                Tag = 10
                Left = 157
                Top = 22
                Width = 130
                Height = 21
                BevelKind = bkFlat
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWindowText
                Font.Height = -11
                Font.Name = 'MS Sans Serif'
                Font.Style = []
                ItemHeight = 13
                ParentFont = False
                TabOrder = 0
              end
              object DBEdit7: TDBEdit
                Tag = 12
                Left = 157
                Top = 73
                Width = 41
                Height = 21
                BevelKind = bkFlat
                BorderStyle = bsNone
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWindowText
                Font.Height = -11
                Font.Name = 'MS Sans Serif'
                Font.Style = []
                ParentFont = False
                TabOrder = 1
              end
              object DBEdit8: TDBEdit
                Tag = 13
                Left = 157
                Top = 99
                Width = 41
                Height = 21
                BevelKind = bkFlat
                BorderStyle = bsNone
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWindowText
                Font.Height = -11
                Font.Name = 'MS Sans Serif'
                Font.Style = []
                ParentFont = False
                TabOrder = 2
              end
              object DBEdit9: TDBEdit
                Tag = 14
                Left = 157
                Top = 125
                Width = 41
                Height = 21
                BevelKind = bkFlat
                BorderStyle = bsNone
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWindowText
                Font.Height = -11
                Font.Name = 'MS Sans Serif'
                Font.Style = []
                ParentFont = False
                TabOrder = 3
              end
              object DBComboBox4: TDBComboBox
                Tag = 15
                Left = 157
                Top = 150
                Width = 130
                Height = 21
                BevelKind = bkFlat
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWindowText
                Font.Height = -11
                Font.Name = 'MS Sans Serif'
                Font.Style = []
                ItemHeight = 13
                ParentFont = False
                TabOrder = 4
              end
              object DBEdit10: TDBEdit
                Tag = 16
                Left = 157
                Top = 176
                Width = 41
                Height = 21
                BevelKind = bkFlat
                BorderStyle = bsNone
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWindowText
                Font.Height = -11
                Font.Name = 'MS Sans Serif'
                Font.Style = []
                ParentFont = False
                TabOrder = 5
              end
              object DBEdit11: TDBEdit
                Tag = 17
                Left = 157
                Top = 202
                Width = 41
                Height = 21
                BevelKind = bkFlat
                BorderStyle = bsNone
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWindowText
                Font.Height = -11
                Font.Name = 'MS Sans Serif'
                Font.Style = []
                ParentFont = False
                TabOrder = 6
              end
              object DBComboBox5: TDBComboBox
                Tag = 18
                Left = 157
                Top = 228
                Width = 130
                Height = 21
                BevelKind = bkFlat
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWindowText
                Font.Height = -11
                Font.Name = 'MS Sans Serif'
                Font.Style = []
                ItemHeight = 13
                ParentFont = False
                TabOrder = 7
              end
              object DBEdit12: TDBEdit
                Tag = 19
                Left = 157
                Top = 254
                Width = 41
                Height = 21
                BevelKind = bkFlat
                BorderStyle = bsNone
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWindowText
                Font.Height = -11
                Font.Name = 'MS Sans Serif'
                Font.Style = []
                ParentFont = False
                TabOrder = 8
              end
              object DBEdit13: TDBEdit
                Tag = 11
                Left = 157
                Top = 47
                Width = 41
                Height = 21
                BevelKind = bkFlat
                BorderStyle = bsNone
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWindowText
                Font.Height = -11
                Font.Name = 'MS Sans Serif'
                Font.Style = []
                ParentFont = False
                TabOrder = 9
              end
            end
          end
        end
      end
    end
  end
  object Panel8: TPanel
    Left = 0
    Top = 608
    Width = 975
    Height = 27
    Align = alBottom
    BevelOuter = bvLowered
    TabOrder = 1
    object SpeedButton4: TSpeedButton
      Left = 2
      Top = 1
      Width = 93
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
      OnClick = SpeedButton4Click
    end
  end
end
