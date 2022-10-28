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

