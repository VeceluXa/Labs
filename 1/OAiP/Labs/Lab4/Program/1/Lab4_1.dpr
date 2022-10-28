program Lab4_1;

{
  Given matrix X size N*N find all numbers that exist in all rows.
  Input: matrix X size N*N
  Output: numbers that exist in all rows
}

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils;

// N - size of matrix
const
  N = 4;

// X - given array
// Num - array to store found numbers
// M - size of Num
// i, j, k - counts for loops
// Count - count of numbers in rows
// Error - value for input
// InputStr - string for input
// IsFound - boolean to check if same number was found in a row
// IsAbsent - boolean to check if no same numbers exist in table
var
  i, j, k, Error, Count, M: Integer;
  InputStr: String;
  IsFound, IsAbsent: Boolean;
  X: Array [1..N, 1..N] of Integer;
  Num: Array [1..N] of Integer;

begin

  // Input X using following methods:
  // Iterate through rows from i to N
  // Iterate throuth columns from i to N
  // Input integer number using method Val
  // In each input check if previous value is smaller than the current one
  for i := 1 to N do
  begin
    writeln('Enter array X[', i, ']:');
    for j := 1 to N do
      repeat
        readln(InputStr);
        val(InputStr, X[i,j], Error);
        IsFound := true;
        if (j > 1) then
          if X[i,j] < X[i,j-1] then
          begin
            writeln('Enter value, not less than ', X[i,j-1]);
            IsFound := false;
          end;
      until (Error = 0) and IsFound;
  end;

  // Output given array
  writeln('Given array:');
  for i := 1 to N do
  begin
    for j := 1 to N do
      write(X[i,j]:4, ' ');
    writeln;
  end;

  // Algorithm to find same nubmers
  M := 0;

  // Iterate through columns of first row
  for j := 1 to N do
  begin
    Count := 1;
    IsAbsent := false;
    i := 2;

    // Iterate through rows
    // If element is absent in one of rows stop cycle
    while (i <= N) and (not IsAbsent) do
    begin
      k := 1;
      IsFound := false;

      // Iterate through columns of other rows
      while (X[1,j] >= X[i,k]) and (k <= N) and (not IsFound) do
      begin

        // Check if elements are the same
        if X[1,j] = X[i,k] then
        begin
          IsFound := true;

          // Increment count for same elements in each row
          Count := Count + 1;
        end;

        // Move to another element of row i
        k := k + 1;
      end;

      // Check if element is absent in row i
      if IsFound = false then
        IsAbsent := true;

      // Move to another row
      i := i + 1;
    end;
    if Count = N then
    begin
      M := M + 1;
      Num[M] := X[1,j];
    end;
  end;

  // Output unique Num values
  if M > 0 then
  begin
    writeln('Numbers that exist in all rows:');
    write(Num[1], ' ');
    for i := 2 to M do
      if Num[i] <> Num[i-1] then
        write(Num[i], ' ');
  end
  else
    writeln('No such numbers found :(');

  // Stop console from closing
  readln;
end.
