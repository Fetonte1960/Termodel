object DM1: TDM1
  OldCreateOrder = False
  Left = 782
  Top = 222
  Height = 288
  Width = 316
  object DataSource1: TDataSource
    DataSet = TT1
    Left = 32
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
    Left = 160
    Top = 8
  end
  object TT1: TTableQ
    DesignActivation = True
    AttachedAutoRefresh = True
    AttachMaxCount = 1
    FieldDefs = <>
    IndexDefs = <>
    SortOptions = []
    PersistentBackup = False
    ProgressFlags = [mtpcLoad, mtpcSave, mtpcCopy]
    FilterOptions = []
    Version = '3.01'
    LanguageID = 0
    SortID = 0
    SubLanguageID = 1
    LocaleID = 1024
    OnNewRecord = TT1NewRecord
    Left = 104
    Top = 64
  end
  object TT3: TTableQ
    DesignActivation = True
    AttachedAutoRefresh = True
    AttachMaxCount = 1
    FieldDefs = <>
    IndexDefs = <>
    SortOptions = []
    PersistentBackup = False
    ProgressFlags = [mtpcLoad, mtpcSave, mtpcCopy]
    FilterOptions = []
    Version = '3.01'
    LanguageID = 0
    SortID = 0
    SubLanguageID = 1
    LocaleID = 1024
    Left = 104
    Top = 176
  end
  object TT2: TTableQ
    DesignActivation = True
    AttachedAutoRefresh = True
    AttachMaxCount = 1
    FieldDefs = <>
    IndexDefs = <>
    SortOptions = []
    PersistentBackup = False
    ProgressFlags = [mtpcLoad, mtpcSave, mtpcCopy]
    FilterOptions = []
    Version = '3.01'
    LanguageID = 0
    SortID = 0
    SubLanguageID = 1
    LocaleID = 1024
    OnNewRecord = TT2NewRecord
    Left = 104
    Top = 120
  end
end
