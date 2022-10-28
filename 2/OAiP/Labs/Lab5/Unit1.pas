unit Unit1;

interface

type
  TMatrix = Array[1..3, 1..3] of Integer;

function multiplyMatrix(M: TMatrix; Num: Integer) : TMatrix; overload;

implementation

// Multiplication of matrix and Integer
function multiplyMatrix(M: TMatrix; Num: Integer) : TMatrix; overload;
var i, j: Integer;
begin
  for i:= 1 to 3 do
    for j:= 1 to 3 do
      Result[i,j] := M[i,j] * Num;
end;

end.
