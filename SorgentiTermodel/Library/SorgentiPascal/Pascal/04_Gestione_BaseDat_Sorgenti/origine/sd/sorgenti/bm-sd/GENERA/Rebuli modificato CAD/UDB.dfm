object DM1: TDM1
  OldCreateOrder = False
  Left = 244
  Top = 190
  Height = 480
  Width = 696
  object TT1: TTable
    AfterPost = TT1AfterPost
    OnNewRecord = TT1NewRecord
    DatabaseName = 'c:\programmi\ded\sofrad\esempi\esempio3'
    TableName = 'Ambienti.DB'
    Left = 16
    Top = 8
  end
  object TT2: TTable
    DatabaseName = 'c:\programmi\ded\sofrad\esempi\esempio3'
    TableName = 'default.DB'
    Left = 72
    Top = 8
  end
  object TT3: TTable
    MasterSource = Form1.DataSource1
    Left = 128
    Top = 8
  end
  object TT4: TTable
    Left = 176
    Top = 8
  end
end
