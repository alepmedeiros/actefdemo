program Project1;

uses
  Vcl.Forms,
  Unit3 in 'Unit3.pas' {Form3},
  Unit5 in 'Unit5.pas',
  Unit6 in 'Unit6.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm3, Form3);
  Application.Run;
end.
