unit Help;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TFormHelp = class(TForm)
    MemoHelp: TMemo;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormHelp: TFormHelp;

implementation



{$R *.dfm}

procedure TFormHelp.FormCreate(Sender: TObject);
var
  HelpFile: TextFile;
  HelpText: String;
begin

  MemoHelp.Lines.Clear;

  AssignFile(HelpFile, ExtractFileDir(Application.ExeName) + '\help.txt');
  Reset(HelpFile);

  while not EOF(HelpFile) do
  begin
    readln(HelpFile, HelpText);
    MemoHelp.Lines.Add(HelpText);
  end;

  CloseFile(HelpFile);

end;

end.
