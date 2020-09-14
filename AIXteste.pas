unit AIXteste;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Vcl.StdCtrls, Vcl.Mask,
  Vcl.DBCtrls, Vcl.ExtCtrls, Vcl.OleCtrls, SHDocVw, mshtml, IPPeerClient,
  REST.Client, Data.Bind.Components, Data.Bind.ObjectScope, Rest.Json,
  System.Win.TaskbarCore, Vcl.Taskbar, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.Grids, Vcl.DBGrids;

type
  TForm1 = class(TForm)
    Panel1: TPanel;
    Button1: TButton;
    Button2: TButton;
    DTdataNascimento: TDateTimePicker;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    CBestadoCivil: TComboBox;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    email: TEdit;
    endereco: TEdit;
    nome: TEdit;
    matricula: TEdit;
    Label11: TLabel;
    pesAluno: TEdit;
    Label12: TLabel;
    Button4: TButton;
    Button5: TButton;
    Panel2: TPanel;
    RESTClient1: TRESTClient;
    RESTRequest1: TRESTRequest;
    RESTResponse1: TRESTResponse;
    qryAlunos: TFDQuery;
    qryGeraMatricula: TFDQuery;
    bairro: TEdit;
    Label8: TLabel;
    cidade: TEdit;
    Label9: TLabel;
    estado: TEdit;
    Label10: TLabel;
    qryAlteraExclui: TFDQuery;
    cpf: TMaskEdit;
    cep: TMaskEdit;
    Label13: TLabel;
    qryListaAlunos: TFDQuery;
    DSlistaAlunos: TDataSource;
    DBGridAlunos: TDBGrid;
    Label14: TLabel;
    procedure Button1Click(Sender: TObject);
    procedure CBestadoCivilKeyPress(Sender: TObject; var Key: Char);
    procedure Button4Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure pesAlunoKeyPress(Sender: TObject; var Key: Char);
    procedure DBGridAlunosCellClick(Column: TColumn);
    procedure Button5Click(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
    procedure NovoEdit(NovoEdit : integer);
  end;

  TClassJson = class
    private
      Fcep        : integer;
      Fbairro     : string;
      Flogradouro : string;
      Fcidade     : string;
      Festado     : string;
    public
      property cep: integer read Fcep write Fcep;
      property bairro: string read Fbairro write Fbairro;
      property logradouro: string read Flogradouro write Flogradouro;
      property cidade: string read Fcidade write Fcidade;
      property estado: string read Festado write Festado;
    end;
var
  Form1: TForm1;

implementation
  uses DM_Principal;

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
var
  matriculaControle : integer;
begin

  matriculaControle := 0;
  qryGeraMatricula.Open;
  qryListaAlunos.Open;

  if qryListaAlunos.IsEmpty then
    qryListaAlunos.Close;

  if qryGeraMatricula.IsEmpty then
    matricula.Text := '0000000000001'
  else
  begin
    matriculaControle := StrToInt(qryGeraMatricula.FieldByName('matricula').AsString) + 1;
    matricula.Text    := formatfloat('#############0000000000000', matriculaControle);
  end;

  nome.Text     := '';
  cpf.Text      := '';
  email.Text    := '';
  cep.Text      := '';
  endereco.Text := '';
  bairro.Text   := '';
  cidade.Text   := '';
  estado.Text   := '';

  nome.Enabled             := True;
  cpf.Enabled              := True;
  email.Enabled            := True;
  DTdataNascimento.Enabled := True;
  CBestadoCivil.Enabled    := True;
  cep.Enabled              := True;
end;

procedure TForm1.Button2Click(Sender: TObject);
var
  matriculaControle, matriculaQry : integer;
  checaArrouba : string;
begin

  qryGeraMatricula.Close;
  qryGeraMatricula.Open;
  checaArrouba := EmptyStr;

  if nome.Text = EmptyStr then
  begin

    ShowMessage('Campo nome obrigatório!');
    exit;
  end
  else
  begin

    if not (email.Text = EmptyStr) then
    begin
       checaArrouba := Copy(email.Text, 1, Pos('@', email.Text));

       if checaArrouba = EmptyStr then
       begin
         ShowMessage('Campo e-mail inválido, precisa ter ''@'' - ex:teste@teste.com.br');
         exit;
       end;
    end;
  end;

  matriculaControle := StrToInt(matricula.Text);

  if qryGeraMatricula.FieldByName('matricula').AsString = EmptyStr then
    matriculaQry := 0
  else
    matriculaQry := StrToInt(qryGeraMatricula.FieldByName('matricula').AsString);

  if matriculaQry = matriculaControle then
  begin
    NovoEdit(1);
    ShowMessage('Cadastro editado com sucesso!');
  end
  else
  begin
    NovoEdit(0);
    ShowMessage('Novo cadastro salvo com sucesso!');
  end;

  qryListaAlunos.Close;
  qryListaAlunos.Open;

end;

procedure TForm1.Button4Click(Sender: TObject);
var
  ClasseJson : TClassJson;

begin

  cep.EditMask := '';

  if length(cep.text) < 8 then
  begin

    ShowMessage('Preencher valor do CEP com 8 digitos!');
    cep.EditMask := '99999-999;1;_';
    exit;
  end;

  RESTRequest1.Client.BaseURL := 'https://serviceweb.aix.com.br/aixapi/api/cep/' + cep.Text;
  RESTRequest1.Execute;
  ClasseJson := TClassJson.Create();
  ClasseJson := TJson.JsonToObject<TClassJson>(RESTResponse1.JSONText);

  endereco.Text := ClasseJson.Flogradouro;
  bairro.Text   := ClasseJson.Fbairro;
  cidade.Text   := ClasseJson.Fcidade;
  estado.Text   := ClasseJson.Festado;

  cep.EditMask := '99999-999;1;_';
end;

procedure TForm1.Button5Click(Sender: TObject);
var
  matriculaControle : Integer;

begin

  if qryListaAlunos.IsEmpty then
  begin

    qryListaAlunos.Close;
  end
  else
  begin

    qryAlteraExclui.Close;
    qryAlteraExclui.SQL.Clear;

    qryAlteraExclui.SQL.Add('DELETE FROM ALUNOS');
    qryAlteraExclui.SQL.Add('WHERE MATRICULA = ' + QuotedStr(DBGridAlunos.DataSource.DataSet.FieldByName('matricula').AsString));
    qryAlteraExclui.ExecSQL;

    nome.Text     := '';
    cpf.Text      := '';
    email.Text    := '';
    cep.Text      := '';
    endereco.Text := '';
    bairro.Text   := '';
    cidade.Text   := '';
    estado.Text   := '';

    matriculaControle := 0;
    qryGeraMatricula.Close;
    qryGeraMatricula.Open;

    if qryGeraMatricula.IsEmpty then
      matricula.Text := '0000000000001'
    else
    begin
      matriculaControle := StrToInt(qryGeraMatricula.FieldByName('matricula').AsString) + 1;
      matricula.Text    := formatfloat('#############0000000000000', matriculaControle);
    end;

    qryListaAlunos.Close;
    qryListaAlunos.Open;

    if qryListaAlunos.IsEmpty then
      qryListaAlunos.Close;

    ShowMessage('Cadastro excluído com sucesso!');
  end;
end;

procedure TForm1.CBestadoCivilKeyPress(Sender: TObject; var Key: Char);
begin

  key:=#0;
end;

procedure TForm1.DBGridAlunosCellClick(Column: TColumn);
begin

  if qryListaAlunos.Active then
  begin
    qryAlunos.Close;
    qryAlunos.SQL.Clear;

    qryAlunos.SQL.Add('SELECT * FROM ALUNOS');
    qryAlunos.SQL.Add('WHERE MATRICULA = ' + QuotedStr(DBGridAlunos.DataSource.DataSet.FieldByName('matricula').AsString));
    qryAlunos.Open;

    matricula.Text        := qryAlunos.FieldByName('matricula').AsString;
    nome.Text             := qryAlunos.FieldByName('nome').AsString;

    cpf.EditMask          := '';
    cpf.Text              := qryAlunos.FieldByName('cpf').AsString;
    cpf.EditMask          := '999.999.999-99;1;_';

    email.Text            := qryAlunos.FieldByName('email').AsString;
    DTdataNascimento.Date := qryAlunos.FieldByName('matricula').AsDateTime;

    if qryAlunos.FieldByName('estado_civil').AsString = 's' then
      CBestadoCivil.ItemIndex := 0
    else
      if qryAlunos.FieldByName('estado_civil').AsString = 'c' then
        CBestadoCivil.ItemIndex := 1
      else
        CBestadoCivil.ItemIndex := 2;

    cep.EditMask     := '';
    cep.Text         := qryAlunos.FieldByName('cep').AsString;
    cep.EditMask     := '99999-999;1;_';

    endereco.Text    := qryAlunos.FieldByName('endereco').AsString;
    bairro.Text      := qryAlunos.FieldByName('bairro').AsString;
    cidade.Text      := qryAlunos.FieldByName('cidade').AsString;
    estado.Text      := qryAlunos.FieldByName('estado').AsString;

    qryAlunos.Close;

    nome.Enabled             := True;
    cpf.Enabled              := True;
    email.Enabled            := True;
    DTdataNascimento.Enabled := True;
    CBestadoCivil.Enabled    := True;
    cep.Enabled              := True;
  end;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin

  CBestadoCivil.ItemIndex := 0;
end;

procedure TForm1.NovoEdit(NovoEdit: integer);
begin

  if NovoEdit = 0 then
  begin
    qryAlteraExclui.Close;
    qryAlteraExclui.SQL.Clear;
    qryAlteraExclui.SQL.Add('INSERT INTO ALUNOS (MATRICULA,');
    qryAlteraExclui.SQL.Add('NOME,');
    qryAlteraExclui.SQL.Add('ENDERECO,');
    qryAlteraExclui.SQL.Add('CPF,');
    qryAlteraExclui.SQL.Add('EMAIL,');
    qryAlteraExclui.SQL.Add('DATA_NASCIMENTO,');
    qryAlteraExclui.SQL.Add('ESTADO_CIVIL,');
    qryAlteraExclui.SQL.Add('CEP,');
    qryAlteraExclui.SQL.Add('ESTADO,');
    qryAlteraExclui.SQL.Add('CIDADE,');
    qryAlteraExclui.SQL.Add('BAIRRO)');
    qryAlteraExclui.SQL.Add('VALUES (');
    qryAlteraExclui.SQL.Add(QuotedStr(matricula.Text));
    qryAlteraExclui.SQL.Add(',' + QuotedStr(nome.Text));

    if not (endereco.Text = EmptyStr) then
      qryAlteraExclui.SQL.Add(',' + QuotedStr(endereco.Text))
    else
      qryAlteraExclui.SQL.Add(',null');

    cpf.EditMask := '';

    if not (cpf.Text = EmptyStr) then
      qryAlteraExclui.SQL.Add(',' + QuotedStr(cpf.Text))
    else
      qryAlteraExclui.SQL.Add(',null');

    cpf.EditMask := '999.999.999-99;1;_';

    if not (email.Text = EmptyStr) then
      qryAlteraExclui.SQL.Add(',' + QuotedStr(email.Text))
    else
      qryAlteraExclui.SQL.Add(',null');

    qryAlteraExclui.SQL.Add(',' + QuotedStr(FormatDateTime('yyyy-mm-dd', DTdataNascimento.Date)));

    case CBestadoCivil.ItemIndex of

      0 : qryAlteraExclui.SQL.Add(',' + QuotedStr('s'));
      1 : qryAlteraExclui.SQL.Add(',' + QuotedStr('c'));
      2 : qryAlteraExclui.SQL.Add(',' + QuotedStr('v'));
    end;

    cep.EditMask := '';

    if not (cep.Text = EmptyStr) then
      qryAlteraExclui.SQL.Add(',' + QuotedStr(cep.Text))
    else
      qryAlteraExclui.SQL.Add(',null');

    cep.EditMask := '99999-999;1;_';

    if not (estado.Text = EmptyStr) then
      qryAlteraExclui.SQL.Add(',' + QuotedStr(estado.Text))
    else
      qryAlteraExclui.SQL.Add(',null');

    if not (cidade.Text = EmptyStr) then
      qryAlteraExclui.SQL.Add(',' + QuotedStr(cidade.Text))
    else
      qryAlteraExclui.SQL.Add(',null');

    if not (bairro.Text = EmptyStr) then
      qryAlteraExclui.SQL.Add(',' + QuotedStr(bairro.Text) + ')')
    else
      qryAlteraExclui.SQL.Add(',null)');
    qryAlteraExclui.ExecSQL;
  end
  else
  begin

    qryAlteraExclui.Close;
    qryAlteraExclui.SQL.Clear;
    qryAlteraExclui.SQL.Add('UPDATE ALUNOS');
    qryAlteraExclui.SQL.Add('SET');
    qryAlteraExclui.SQL.Add('NOME = ' + QuotedStr(nome.Text));

    if not (endereco.Text = EmptyStr) then
      qryAlteraExclui.SQL.Add(',ENDERECO = ' + QuotedStr(endereco.Text));

    cpf.EditMask := '';

    if not (cpf.Text = EmptyStr) then
      qryAlteraExclui.SQL.Add(',CPF = ' + QuotedStr(cpf.Text));

    cpf.EditMask := '999.999.999-99;1;_';

    if not (email.Text = EmptyStr) then
      qryAlteraExclui.SQL.Add(',EMAIL = ' + QuotedStr(email.Text));

    qryAlteraExclui.SQL.Add(',DATA_NASCIMENTO = ' + QuotedStr(FormatDateTime('yyyy-mm-dd', DTdataNascimento.Date)));

    case CBestadoCivil.ItemIndex of

      0 : qryAlteraExclui.SQL.Add(',ESTADO_CIVIL = ''S''');
      1 : qryAlteraExclui.SQL.Add(',ESTADO_CIVIL = ''C''');
      2 : qryAlteraExclui.SQL.Add(',ESTADO_CIVIL = ''V''');
    end;

    cep.EditMask := '';

    if not (cep.Text = EmptyStr) then
      qryAlteraExclui.SQL.Add(',CEP = ' + QuotedStr(cep.Text));

    cep.EditMask := '99999-999;1;_';

    if not (estado.Text = EmptyStr) then
      qryAlteraExclui.SQL.Add(',ESTADO = ' + QuotedStr(estado.Text));

    if not (cidade.Text = EmptyStr) then
      qryAlteraExclui.SQL.Add(',CIDADE = ' + QuotedStr(cidade.Text));

    if not (bairro.Text = EmptyStr) then
      qryAlteraExclui.SQL.Add(',BAIRRO = ' + QuotedStr(bairro.Text));

    qryAlteraExclui.SQL.Add('WHERE');
    qryAlteraExclui.SQL.Add('MATRICULA = ' + QuotedStr(matricula.Text));
    qryAlteraExclui.ExecSQL;
    end;

end;
procedure TForm1.pesAlunoKeyPress(Sender: TObject; var Key: Char);
begin

  if Key = #13 then
  begin

    qryListaAlunos.Close;
    qryListaAlunos.SQL.Clear;

    qryListaAlunos.SQL.Add('SELECT * FROM ALUNOS');
    qryListaAlunos.SQL.Add('WHERE NOME LIKE ''%' + pesAluno.Text + '%''');
    qryListaAlunos.Open;

    if qryListaAlunos.IsEmpty then
    begin

      ShowMessage('Pesquisa não encontrou nenhum aluno! tente novamente');
      qryListaAlunos.Close;
    end;
  end;
end;
end.
