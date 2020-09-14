object DataModule1: TDataModule1
  OldCreateOrder = False
  Height = 362
  Width = 412
  object FDPhysMySQLDriverLink1: TFDPhysMySQLDriverLink
    VendorLib = 'libmySQL.dll'
    Left = 54
    Top = 25
  end
  object ConexaoEscola: TFDConnection
    Params.Strings = (
      'Database=ouvidoria'
      'User_Name=root'
      'Server=127.0.0.1'
      'CharacterSet=utf8'
      'Password=root'
      'DriverID=MySQL')
    UpdateOptions.AssignedValues = [uvUpdateMode]
    LoginPrompt = False
    Left = 166
    Top = 25
  end
end
