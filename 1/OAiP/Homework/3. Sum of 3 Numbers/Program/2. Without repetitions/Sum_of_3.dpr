program Sum_of_3;
{
  Given number N find all possible combinations
  of sum of 3 numbers to form this number.
  Input: N
  Output: All different combinations, total amount of them
}

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils;

// N - given number
// Count - amount of combinations
// i,j,k - counts for loops
// Error - error value for method 'val'
// InputStr - input string for method 'val'
var
  N, Count, i, j, k, Error: Integer;
  InputStr: String;

begin
  // Input
  writeln('Enter N:');
  repeat
    readln(InputStr);
    val(InputStr, N, Error);
    if (Error <> 0) or (N < 0) then
      writeln('Error! Enter a valid number.');
  until (Error = 0) and (N >= 0);

  // Algorithm
  Count := 0;
  for i := 0 to N do
    for j := 0 to N - i do
    begin
      writeln(i, ' + ', j, ' + ', N - i - j);
      Count := Count + 1;
    end;


  writeln('Total amount of combinations is ', Count);

  // Stop console from closing
  readln;
end.
