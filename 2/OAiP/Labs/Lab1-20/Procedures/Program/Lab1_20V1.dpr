program Lab1_20V1;
{
  Calculate A^2 - (A + B)*(A - 3*B), where
      (( 4, 5, 6),          (( 0,-1, 2),
  A =  (-1, 0, 3),      B =  ( 1, 0,-2),
       (-1, 2,-1))           ( 3, 1, 2))
  using procedures.
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
procedure multiplyMatrix(M: TMatrix; Num: Integer; var Res: TMatrix); overload;
var i, j: Integer;
begin
  for i:= 1 to 3 do
    for j:= 1 to 3 do
      Res[i,j] := M[i,j] * Num;
end;

// Multiplication of two matrices
procedure multiplyMatrix(M1, M2: TMatrix; var Res: TMatrix); overload;
var
  i,j,k: Integer;
begin
  for i := 1 to 3 do
    for j := 1 to 3 do
    begin
      Res[i,j] := 0;
      for k := 1 to 3 do
        Res[i,j] := Res[i,j] + M1[i,k]*M2[k,j];
    end;
end;


// Sum* of two matrices
// Take sign value.
// If Sign = true, result is sum
// If Sign = false, result is difference
procedure sumMatrix(M1, M2: TMatrix; Sign: Boolean; var Res: TMatrix); overload;
var
  i,j: Integer;
begin
  if(Sign) then
  begin
    for i := 1 to 3 do
      for j := 1 to 3 do
        Res[i,j] := M1[i,j] + M2[i,j];
  end
  else
  begin
    for i := 1 to 3 do
      for j := 1 to 3 do
        Res[i,j] := M1[i,j] - M2[i,j];
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
  multiplyMatrix(A, A, Temp1);              // (A^2)
  sumMatrix(A, B, true, Temp2);             // (A + B)
  multiplyMatrix(B, 3, Temp3);              // (3*B)
  sumMatrix(A, Temp3, false, Temp3);        // (A - 3*B)
  multiplyMatrix(Temp2, Temp3, Temp2);      // (A + B)*(A - 3*B)
  sumMatrix(Temp1, Temp2, false, Temp1);    // A^2 - (A + B)*(A - 3*B)

  // Output result
  writeMatrix(Temp1);

  // Stop console from closing
  readln;
end.
