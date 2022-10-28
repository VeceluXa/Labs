program Lab8;
{Find line with minimal length}

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils;

// Find line with minimal length
function CalcMin(var myFile: TextFile): String;
var
  tempStr: String; // Temp string
  min: String;     // Line with min length
begin

  // Set first line as minimal
  readln(myFile, min);

  // Compare each line to minimal
  while not EOF(myFile) do
  begin
    readln(myFile, tempStr);
    if tempStr.Length < min.Length then
      min := tempStr;
  end;

  // Return minimal line
  Result := min;
end;

var
  myFile: TextFile;

begin

  // Open File
  AssignFile(myFile, 'File.txt');
  Reset(myFile);

  // Get line with minimum length
  writeln('Line with minimal length:');
  write(CalcMin(myFile));

  // Close file
  Close(myFile);
  readln;
end.
