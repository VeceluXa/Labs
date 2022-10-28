program Lab6_1;
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
function multiplyMatrixNum(const M_Temp, Num_Temp) : TMatrix;
var i, j: Integer;
  M: TMatrix absolute M_Temp;
  Num: Integer absolute Num_Temp;
begin
  for i:= 1 to 3 do
    for j:= 1 to 3 do
      Result[i,j] := M[i,j] * Num;
end;

// Multiplication of two matrices
function multiplyMatrix(const M1_Temp, M2_Temp) : TMatrix;
var
  i,j,k: Integer;
  M1: TMatrix absolute M1_Temp;
  M2: TMatrix absolute M2_Temp;
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
function sumMatrix(const M1_Temp, M2_Temp, Sign_Temp) : TMatrix;
var
  i,j: Integer;
  M1: TMatrix absolute M1_Temp;
  M2: TMatrix absolute M2_Temp;
  Sign: Boolean absolute Sign_Temp;

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
procedure writeMatrix(const M_Temp);
var
  i,j: Integer;
  M: TMatrix absolute M_Temp;
begin
  for i := 1 to 3 do
  begin
    for j := 1 to 3 do
      write(M[i,j]:3, ' ');
    writeln;
  end;

end;

// Input Matrix
procedure inputMatrix(var M_Temp);
var
  InpStr: String;
  i,j, Error: Integer;
  M: TMatrix absolute M_Temp;

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
  Temp3 := multiplyMatrixNum(B,Temp4);

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
