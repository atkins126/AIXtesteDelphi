object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 805
  ClientWidth = 673
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 75
    Width = 673
    Height = 730
    Align = alClient
    Color = clWhite
    ParentBackground = False
    TabOrder = 0
    object Label1: TLabel
      Left = 56
      Top = 109
      Width = 31
      Height = 13
      Caption = 'Nome:'
    end
    object Label2: TLabel
      Left = 56
      Top = 165
      Width = 32
      Height = 13
      Caption = 'E-mail:'
    end
    object Label3: TLabel
      Left = 440
      Top = 165
      Width = 100
      Height = 13
      Caption = 'Data de Nascimento:'
    end
    object Label4: TLabel
      Left = 56
      Top = 226
      Width = 59
      Height = 13
      Caption = 'Estado Civil:'
    end
    object Label5: TLabel
      Left = 440
      Top = 109
      Width = 23
      Height = 13
      Caption = 'CPF:'
    end
    object Label6: TLabel
      Left = 55
      Top = 322
      Width = 23
      Height = 13
      Caption = 'CEP:'
    end
    object Label7: TLabel
      Left = 56
      Top = 386
      Width = 49
      Height = 13
      Caption = 'Endere'#231'o:'
    end
    object Label11: TLabel
      Left = 56
      Top = 55
      Width = 47
      Height = 13
      Caption = 'Matricula:'
    end
    object Label12: TLabel
      Left = 352
      Top = 55
      Width = 80
      Height = 13
      Caption = 'Pesquisar Aluno:'
    end
    object Label8: TLabel
      Left = 440
      Top = 386
      Width = 32
      Height = 13
      Caption = 'Bairro:'
    end
    object Label9: TLabel
      Left = 56
      Top = 450
      Width = 37
      Height = 13
      Caption = 'Cidade:'
    end
    object Label10: TLabel
      Left = 312
      Top = 450
      Width = 37
      Height = 13
      Caption = 'Estado:'
    end
    object Label13: TLabel
      Left = 239
      Top = 551
      Width = 193
      Height = 19
      Caption = 'Lista de alunos cadastrados'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object Label14: TLabel
      Left = 56
      Top = 15
      Width = 160
      Height = 19
      Caption = 'Manuten'#231#227'o de Alunos'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object DTdataNascimento: TDateTimePicker
      Left = 440
      Top = 184
      Width = 169
      Height = 21
      Date = 44084.664298773150000000
      Time = 44084.664298773150000000
      Enabled = False
      TabOrder = 5
    end
    object CBestadoCivil: TComboBox
      Left = 56
      Top = 245
      Width = 145
      Height = 21
      Enabled = False
      TabOrder = 6
      OnKeyPress = CBestadoCivilKeyPress
      Items.Strings = (
        'S - Solteiro(a)'
        'C - Casado(a)'
        'V - Vi'#250'vo(a)')
    end
    object email: TEdit
      Left = 56
      Top = 184
      Width = 353
      Height = 21
      Enabled = False
      TabOrder = 4
    end
    object endereco: TEdit
      Left = 55
      Top = 405
      Width = 322
      Height = 21
      Enabled = False
      TabOrder = 0
    end
    object nome: TEdit
      Left = 56
      Top = 128
      Width = 353
      Height = 21
      Enabled = False
      TabOrder = 2
    end
    object matricula: TEdit
      Left = 55
      Top = 74
      Width = 90
      Height = 21
      Enabled = False
      TabOrder = 8
    end
    object pesAluno: TEdit
      Left = 352
      Top = 74
      Width = 257
      Height = 21
      TabOrder = 1
      TextHint = 'Pesquisar pelo nome do aluno'
      OnKeyPress = pesAlunoKeyPress
    end
    object Button4: TButton
      Left = 207
      Top = 340
      Width = 82
      Height = 23
      Caption = 'Pesquisar Cep'
      TabOrder = 9
      OnClick = Button4Click
    end
    object bairro: TEdit
      Left = 440
      Top = 405
      Width = 169
      Height = 21
      Enabled = False
      TabOrder = 10
    end
    object cidade: TEdit
      Left = 55
      Top = 469
      Width = 234
      Height = 21
      Enabled = False
      TabOrder = 11
    end
    object estado: TEdit
      Left = 312
      Top = 469
      Width = 65
      Height = 21
      Enabled = False
      TabOrder = 12
    end
    object cpf: TMaskEdit
      Left = 440
      Top = 128
      Width = 169
      Height = 21
      Enabled = False
      EditMask = '999.999.999-99;1;_'
      MaxLength = 14
      TabOrder = 3
      Text = '   .   .   -  '
    end
    object cep: TMaskEdit
      Left = 56
      Top = 341
      Width = 127
      Height = 21
      Enabled = False
      EditMask = '99999-999;1;_'
      MaxLength = 9
      TabOrder = 7
      Text = '     -   '
    end
    object DBGridAlunos: TDBGrid
      Left = 0
      Top = 576
      Width = 673
      Height = 153
      DataSource = DSlistaAlunos
      TabOrder = 13
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'Tahoma'
      TitleFont.Style = []
      OnCellClick = DBGridAlunosCellClick
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 0
    Width = 673
    Height = 75
    Align = alTop
    Color = clHighlight
    ParentBackground = False
    TabOrder = 1
    object Button1: TButton
      Left = 55
      Top = 29
      Width = 60
      Height = 25
      Caption = 'Novo'
      TabOrder = 0
      OnClick = Button1Click
    end
    object Button2: TButton
      Left = 121
      Top = 29
      Width = 59
      Height = 25
      Caption = 'Salvar'
      TabOrder = 1
      OnClick = Button2Click
    end
    object Button5: TButton
      Left = 186
      Top = 29
      Width = 58
      Height = 25
      Caption = 'Excluir'
      TabOrder = 2
      OnClick = Button5Click
    end
  end
  object RESTClient1: TRESTClient
    Accept = 'application/json, text/plain; q=0.9, text/html;q=0.8,'
    AcceptCharset = 'UTF-8, *;q=0.8'
    BaseURL = 'https://serviceweb.aix.com.br/aixapi/api/cep/30110012'
    Params = <>
    HandleRedirects = True
    RaiseExceptionOn500 = False
    Left = 104
    Top = 96
  end
  object RESTRequest1: TRESTRequest
    Client = RESTClient1
    Params = <>
    Response = RESTResponse1
    SynchronizedEvents = False
    Left = 184
    Top = 96
  end
  object RESTResponse1: TRESTResponse
    ContentType = 'application/json'
    Left = 272
    Top = 96
  end
  object qryAlunos: TFDQuery
    Connection = DataModule1.ConexaoEscola
    Left = 552
    Top = 329
  end
  object qryGeraMatricula: TFDQuery
    Connection = DataModule1.ConexaoEscola
    SQL.Strings = (
      'SELECT MATRICULA FROM ALUNOS'
      'ORDER BY MATRICULA DESC LIMIT 1')
    Left = 552
    Top = 385
  end
  object qryAlteraExclui: TFDQuery
    Connection = DataModule1.ConexaoEscola
    SQL.Strings = (
      'SELECT MATRICULA FROM ALUNOS'
      'ORDER BY MATRICULA DESC LIMIT 1')
    Left = 472
    Top = 329
  end
  object qryListaAlunos: TFDQuery
    Connection = DataModule1.ConexaoEscola
    SQL.Strings = (
      'SELECT * FROM ALUNOS'
      'ORDER BY MATRICULA')
    Left = 568
    Top = 593
  end
  object DSlistaAlunos: TDataSource
    AutoEdit = False
    DataSet = qryListaAlunos
    Left = 488
    Top = 595
  end
end
