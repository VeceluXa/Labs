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
var
  nodeNew, nodeOld: nodeptr;
  i:Integer;
begin

  // Initialize new instance of TList with desired number of players
  List := TList.Create(NumPlayers);
  write(List.length:4, ' | ');

  // Set values of nodes from 1 to NumPlayers
  for i := 0 to NumPlayers - 1 do
  begin
    List.SetData(i, i+1);
  end;

  // Set i to the first node to delete
  i := (RemoveId - 1) mod List.length;

  // Iterate until one node is in the list
  while List.length <> 1 do
  begin
    // Output deleted node
    write(List.GetDataById(i), ' ');

    // Remove node
    List.RemoveById(i);

    // Iterate i to move to the next node
    i := (i + RemoveId - 1) mod List.length;
  end;

  // Output winner
  write(' | ', List.GetDataById(0));
  writeln;
end;

begin

  // Input count to remove players
  writeln('Enter count before removal:');
  repeat
    readln(InputStr);
    val(InputStr, RemoveId, Error);
    if (Error <> 0) or (RemoveId < 0) then
      writeln('Error! Enter a valid RemoveId (>0)');
  until (Error = 0) and (RemoveId >= 0);

  // Calculate Counters for players in range 1 to 64
  for i := 1 to 64 do
    CalcCounter(i, RemoveId);

  // Stop console from closing
  readln;
end.
