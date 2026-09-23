object DMTutti: TDMTutti
  OldCreateOrder = False
  Left = 490
  top = 110
  Height = 750
  Width = 950
  object T_Campi: TTable
    OnNewRecord = ONNewRecord
    OnFilterRecord = ONFilterRecord
    Left = 160
    Top = 5
  end
  object DS_Campi: TDataSource
    DataSet = T_Campi
    Left = 50
    Top = 5
  end
  object T_Rec: TTable
    OnNewRecord = ONNewRecord
    OnFilterRecord = ONFilterRecord
    Left = 160
    Top = 50
  end
  object DS_Rec: TDataSource
    DataSet = T_Rec
    Left = 50
    Top = 50
  end
end
