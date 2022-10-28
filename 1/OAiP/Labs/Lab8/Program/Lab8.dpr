program Lab8;

{
  Sort given array X[1..7,1..10] by 2 rules:
  1. Sort elements in columns by non-increase
  2. Sort columns by increase of absolute minimal
     value in each column

  Input: Array X[1..7,1..10]
  Output: Sorted array
}

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils;

// N - number of rows in array X
// M - number of columns in array X
const
  N = 7;
  M = 10;

// X - given array
// MinAbs - array of minimal absolute values
// i,j,k - counters for loops
// min - minimal value
// temp - temp value to swap 2 elements
// InputStr - string for input
// Error - error value
var
  X: Array[1..N+1, 1..M] of Integer;
  MinAbs: Array[1..M] of Integer;
  i, j, k, min, temp, Error: Integer;
  InputStr: String;

begin
  // Input X
  randomize;
  for i := 1 to N do
    for j := 1 to M do
      X[i,j] := random(20) - 10;

  // Input X[1..N, 1..M] using method val
//  writeln('Input X[1..N, 1..M]:');
//  for i := 1 to N do
//    for j := 1 to M do
//    repeat
//      write('X[',i,',',j ,']: ');
//      readln(InputStr);
//      val(InputStr, X[i,j], Error);
//      if Error <> 0 then
//        writeln('Error! Enter a valid number');
//    until Error = 0;

  // Output X
  writeln('Given array is:');
  for i := 1 to N do
  begin
    for j := 1 to M do
      write(X[i,j]:4, ' ');
    writeln;
  end;

  // Sort elements in columns by non-increase
  // using insertion sort
  for j := 1 to M do
  begin

    // Iterate through rows
    for i := 1 to N do
    begin

      // Initialize first minimal element's index
      k := i;
      temp := X[i,j];

      // Iterete until element is bigger than previous one
      while (k > 1) and (X[k-1,j] < temp) do
      begin
        X[k,j] := X[k-1,j];
        k := k - 1;
      end;

      // Insert value right after minimal one
      X[k, j] := temp;

    end;
  end;


  // Find absolute minimal value in each column
  for j := 1 to M do
  begin

    // Set first minimal value in column
    min := abs(X[1,j]);

    // Find absolute minimal value in column
    // Iterate through rows
    for i := 2 to N do
      if abs(X[i,j]) < min then
        min := abs(X[i,j]);

    // Set absolute minimal value in end of column
    MinAbs[j] := min;
  end;

  // Output absolute minimal values before sort
  writeln;
  writeln('Absolute minimal values before sort:');
  for j := 1 to M do
    write(MinAbs[j]:4, ' ');
  writeln;

  // Sort columns by increase of absolute minimal value
  // using selection sort
  // Iterate through columns
  for j := 1 to M do
  begin

    // Initialize minimal column and first row
    min := j;

    // Find minimal column
    for k := j + 1 to M do
      if MinAbs[k] < MinAbs[min] then
        min := k;

    // Swap columns
    for i := 1 to N do
    begin
      temp := X[i,j];
      X[i,j] := X[i,min];
      X[i,min] := temp;
    end;

    // Swap MinAbs values
    temp := MinAbs[j];
    MinAbs[j] := MinAbs[min];
    MinAbs[min] := temp;
  end;

  // Output X
  writeln;
  writeln('Sorted array is:');
  for i := 1 to N do
  begin
    for j := 1 to M do
      write(X[i,j]:4, ' ');
    writeln;
  end;

  // Output absolute minimal values after sort
  writeln;
  writeln('Absolute minimal values after sort:');
  for j := 1 to M do
    write(MinAbs[j]:4, ' ');

  // Stop console from closing
  readln;
end.
