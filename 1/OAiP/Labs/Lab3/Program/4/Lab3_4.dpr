program Lab3_4;

{
  Given array A, count all of it's elements.
  Output: number same elements in given sequence
}

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils;

// M - Size of array A
const
  M = 15;

// i, j - counts for array
// N - number of elements in array B
// A - array of numbers
// B - array of counted numbers from array A
var
  i, j, N: Integer;
  A: Array [1..M] of Integer = (1,5,2,6,7,1,2,5,6,7,2,2,6,4,2);
  B: Array [1..2*M] of Integer;

begin
  // Fill array B with 0
  for i := 1 to 2*M do
    B[i] := 0;

  // Sort Array using Bubble sort algorithm
  for i := 1 to M do
  begin
    for j := 1 to M - i do
    begin
      if A[j] > A[j+1] then
      begin
        // Swap A[j] and A[j+1] using swap xor algorithm
        A[j] := A[j] xor A[j+1];
        A[j+1] := A[j] xor A[j+1];
        A[j] := A[j] xor A[j+1];
      end;
    end;
  end;

  // The main algorithm
  // Initialize first elements of B and set the indexes
  // to needed positions to start for loop
  B[1] := A[1];
  B[2] := 1;
  N := 2;
  i := 2;
  j := 2;
  while i <= M do
  begin
    if A[i] = A[i-1] then
    begin
      // Increment count of A[i] element in B
      B[j] := B[j] + 1;
    end
    else
    begin
      // Add new element to array B
      B[j+1] := A[i];
      // Move cursor j to position for A[i] to count and increment B[j]
      j := j + 2;
      B[j] := B[j] + 1;
      // Change size of array B by 2
      N := N + 2;
    end;
    i := i + 1;
  end;

  // Output B
  writeln('Counted numbers:');
  writeln('Number | Count|');
  writeln('_______|______|');
  for i := 1 to N do
  begin
    if i mod 2 <> 0 then
    begin
      write(B[i]:7, '|');
    end
    else
    begin
      writeln(B[i]:6, '|');
    end;
  end;
  writeln('_______|______|');

  // Stop console from closing
  readln;
end.
