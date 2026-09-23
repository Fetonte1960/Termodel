object DM1: TDM1
  OldCreateOrder = False
  Left = 706
  Top = 269
  Height = 288
  Width = 316
  object DataSource1: TDataSource
    DataSet = TT1
    Left = 32
    Top = 64
  end
  object TT1: TTable
    BeforePost = TT1BeforePost
    AfterPost = TT1AfterPost
    OnNewRecord = TT1NewRecord
    Left = 104
    Top = 64
  end
  object DataSource2: TDataSource
    DataSet = TT2
    Left = 32
    Top = 120
  end
  object DataSource3: TDataSource
    DataSet = TT3
    Left = 32
    Top = 176
  end
  object TT2: TTable
    AfterPost = TT2AfterPost
    Left = 104
    Top = 120
  end
  object TT3: TTable
    IndexName = 'PerNumero'
    MasterFields = 'Numero'
    Left = 104
    Top = 176
  end
  object TT0: TTable
    OnNewRecord = TT0NewRecord
    Left = 104
    Top = 8
  end
  object DataSource0: TDataSource
    DataSet = TT0
    Left = 32
    Top = 8
  end
  object TCerca: TTable
    Left = 192
    Top = 16
  end
end
