program Lab6_2;
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
function multiplyMatrixNum(const M, Num) : TMatrix;
type
  TMatrix = Array[1..3, 1..3] of Integer;
var i, j: Integer;
begin
  for i:= 1 to 3 do
    for j:= 1 to 3 do
      Result[i,j] := TMatrix(M)[i,j] * Integer(Num);
end;

// Multiplication of two matrices
function multiplyMatrix(const M1, M2) : TMatrix;
type
  TMatrix = Array[1..3, 1..3] of Integer;
var
  i,j,k: Integer;
begin
  for i := 1 to 3 do
    for j := 1 to 3 do
    begin
      Result[i,j] := 0;
      for k := 1 to 3 do
        Result[i,j] := Result[i,j] + TMatrix(M1)[i,k]*TMatrix(M2)[k,j];
    end;
end;


// Sum* of two matrices
// Take sign value.
// If Sign = true, result is sum
// If Sign = false, result is difference
function sumMatrix(const M1, M2, Sign) : TMatrix;
type
  TMatrix = Array[1..3, 1..3] of Integer;
var
  i,j: Integer;
begin
  if(Boolean(Sign)) then
  begin
    for i := 1 to 3 do
      for j := 1 to 3 do
        Result[i,j] := TMatrix(M1)[i,j] + TMatrix(M2)[i,j];
  end
  else
  begin
    for i := 1 to 3 do
      for j := 1 to 3 do
        Result[i,j] := TMatrix(M1)[i,j] - TMatrix(M2)[i,j];
  end;

end;

// Output matrix on screen
procedure writeMatrix(const M);
type
  TMatrix = Array[1..3, 1..3] of Integer;
var
  i,j: Integer;
begin
  for i := 1 to 3 do
  begin
    for j := 1 to 3 do
      write(TMatrix(M)[i,j]:3, ' ');
    writeln;
  end;

end;

// Input Matrix
procedure inputMatrix(var M);
type
  TMatrix = Array[1..3, 1..3] of Integer;
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
        val(InpStr, TMatrix(M)[i,j], Error);
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
  Temp4: Integer;
  Temp5: Boolean;
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
  Temp5 := true;
  Temp2 := sumMatrix(A,B,Temp5);

  // (3*B)
  Temp4 := 3;
  Temp3 := multiplyMatrix(B,Temp4);

  // (A - 3*B)
  Temp5 := false;
  Temp3 := sumMatrix(A,Temp3,Temp5);

  // (A + B)*(A - 3*B)
  Temp2 := multiplyMatrix(Temp2,Temp3);

  // A^2 - (A + B)*(A - 3*B)
  Temp5 := false;
  Temp1 := sumMatrix(Temp1,Temp2,Temp5);

  // Output result
  writeMatrix(Temp1);

  // Stop console from closing
  readln;
end.
