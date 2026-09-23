object FListbox: TFListbox
  Left = 705
  Top = 414
  BorderIcons = []
  BorderStyle = bsNone
  ClientHeight = 82
  ClientWidth = 104
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object ListBox1: TListBox
    Left = 3
    Top = 3
    Width = 97
    Height = 73
    ItemHeight = 13
    Items.Strings = (
      'Parete'
      'Finestra')
    TabOrder = 0
    OnDblClick = ListBox1DblClick
  end
end
