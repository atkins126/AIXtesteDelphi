program Project2;

uses
  Vcl.Forms,
  AIXteste in '..\AIXteste.pas' {Form1},
  DM_Principal in '..\DM_Principal.pas' {DataModule1: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TDataModule1, DataModule1);
  Application.Run;
end.
