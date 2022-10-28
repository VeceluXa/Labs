program Bookify;

uses
  Vcl.Forms,
  Main in 'Main.pas' {Form_Main},
  Vcl.Themes,
  Vcl.Styles,
  Add in 'Add.pas' {FormAdd},
  List in 'List.pas',
  Database in 'Database.pas',
  Help in 'Help.pas' {FormHelp};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  TStyleManager.TrySetStyle('Windows10 Charcoal');
  Application.CreateForm(TForm_Main, Form_Main);
  Application.CreateForm(TFormAdd, FormAdd);
  Application.CreateForm(TFormHelp, FormHelp);
  Application.Run;
end.
