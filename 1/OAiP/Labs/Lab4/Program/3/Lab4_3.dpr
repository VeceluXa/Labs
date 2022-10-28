program Lab4_3;

{
  Given matrix X size N*N find all numbers that exist in all rows.
  Output: numbers that exist in all rows
}

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils;

// N - size of matrix
const
  N = 4;
  Arr: array[1..4, 1..4] of Integer =
    ((1, 2, 3, 4),
     (1, 3, 4, 5),
     (1, 2, 3, 4),
     (1, 3, 5, 7));

// X - given array
// Num - array to store found numbers
// M - size of Num
// i, j, k - counts for loops
// Count - count of numbers in rows
// IsFound - boolean to check if same number was found in a row
// IsAbsent - boolean to check if no same numbers exist in table
var
  i, j, k, Count, M: Integer;
  IsFound, IsAbsent: Boolean;
  X: Array [1..N, 1..N] of Integer;
  Num: Array [1..N] of Integer;

begin
  // Input X
  for i := 1 to N do
    for j := 1 to N do
      X[i,j] := Arr[i,j];


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
