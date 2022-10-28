program Lab1_20V2;
{
  Calculate A^2 - (A + B)*(A - 3*B), where
      (( 4, 5, 6),          (( 0,-1, 2),
  A =  (-1, 0, 3),      B =  ( 1, 0,-2),
       (-1, 2,-1))           ( 3, 1, 2))
  using functions.
  Output: result of expression
}
{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils;

// Matrix of size (3,3)
type
  TMatrix = Array[1..3, 1..3] of Integer;

// Multiplication of matrix and Integer
function multiplyMatrix(M: TMatrix; Num: Integer) : TMatrix; overload;
var i, j: Integer;
begin
  for i:= 1 to 3 do
    for j:= 1 to 3 do
      Result[i,j] := M[i,j] * Num;
end;

// Multiplication of two matrices
function multiplyMatrix(M1, M2: TMatrix) : TMatrix; overload;
var
  i,j,k: Integer;
begin
  for i := 1 to 3 do
    for j := 1 to 3 do
    begin
      Result[i,j] := 0;
      for k := 1 to 3 do
        Result[i,j] := Result[i,j] + M1[i,k]*M2[k,j];
    end;
end;


// Sum* of two matrices
// Take sign value.
// If Sign = true, result is sum
// If Sign = false, result is difference
function sumMatrix(M1, M2: TMatrix; Sign: Boolean) : TMatrix;
var
  i,j: Integer;
begin
  if(Sign) then
  begin
    for i := 1 to 3 do
      for j := 1 to 3 do
        Result[i,j] := M1[i,j] + M2[i,j];
  end
  else
  begin
    for i := 1 to 3 do
      for j := 1 to 3 do
        Result[i,j] := M1[i,j] - M2[i,j];
  end;

end;

// Output matrix on screen
procedure writeMatrix(M: TMatrix);
var
  i,j: Integer;
begin
  for i := 1 to 3 do
  begin
    for j := 1 to 3 do
      write(M[i,j]:3, ' ');
    writeln;
  end;

end;

// Input Matrix
procedure inputMatrix(var M: TMatrix);
var
  InpStr: String;
  i,j, Error: Integer;
begin
  for i := 1 to 3 do
  begin
    for j := 1 to 3 do
    begin
      repeat
        writeln('Input [', i, ', ', j, ']:');
        readln(InpStr);
        val(InpStr, M[i,j], Error);
        if (Error <> 0) then
          writeln('Error! Enter a valid Integer.');
      until Error = 0;
    end;
  end;
  writeln;
end;


// Temp1, Temp2, Temp3 - temporary matrices
// to store results of operations
var
  A, B, Temp1, Temp2, Temp3: TMatrix;
begin

  // Input
  inputMatrix(A);
  inputMatrix(B);

  // Output A
  writeln('A:');
  writeMatrix(A);
  writeln;

  // Output B
  writeln('B:');
  writeMatrix(B);

  // Output expression
  writeln;
  writeln('A^2 - (A + B)*(A - 3*B) =');

  // Perform calculations
  // (A^2)
  Temp1 := multiplyMatrix(A,A);

  // (A + B)
  Temp2 := sumMatrix(A,B,true);

  // (3*B)
  Temp3 := multiplyMatrix(B,3);

  // (A - 3*B)
  Temp3 := sumMatrix(A,Temp3,false);

  // (A + B)*(A - 3*B)
  Temp2 := multiplyMatrix(Temp2,Temp3);

  // A^2 - (A + B)*(A - 3*B)
  Temp1 := sumMatrix(Temp1,Temp2,false);

  // Output result
  writeMatrix(Temp1);

  // Stop console from closing
  readln;
end.
