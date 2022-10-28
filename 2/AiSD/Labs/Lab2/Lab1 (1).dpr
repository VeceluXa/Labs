program Lab1;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils,
  List in 'List.pas';

var
  InputStr: String;
  RemoveId, Error, i: Integer;
  List: TList;

// Procedure to calculate Counters given players and id to remove
procedure CalcCounter(NumPlayers, RemoveId:Integer);
var data, id, i:Integer;
begin

  // Set initial values of every node to 0
  for i := 0 to 63 do
  begin
    data := i + 1;
    id := i;
    List.SetData(id, data);
    write(i:4, ' | ');
  end;


  i := RemoveId;
  while List.length <> 1 do
  begin
    List.WriteDataById(i);
    write(', ');
    List.RemoveById(i);

    i := i + 2;
  end;

  write(' | ');
  List.WriteDataById(0);





end;

begin

  // Input
  writeln('Enter count before removal:');
  repeat
    readln(InputStr);
    val(InputStr, RemoveId, Error);
    if (Error <> 0) or (RemoveId < 0) then
      writeln('Error! Enter a valid RemoveId (>0)');
  until (Error = 0) and (RemoveId >= 0);

  // Calculate Counters for players in range 1 to 64
  List := TList.Create(64);
  for i := 1 to 64 do
    CalcCounter(i, RemoveId);

  List.Write;

  // Stop console from closing
  readln;
end.
