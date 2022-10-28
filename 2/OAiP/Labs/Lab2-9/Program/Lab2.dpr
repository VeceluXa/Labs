program Lab2;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils;

// TArray - user generated dynamic array of Integer
type
  TArray = array of Integer;

// Create Array based on id with set length
// id = 1 -> Create Random array
// id = 2 -> Create Reversed array
// id = 3 -> Create Sorted array
function Create(id, length: Integer): TArray;

// i - index
var
  i: Integer;
begin

  // Set length of array
  SetLength(Result, Length);

  Case id of

    // Create Random array
    1:
    begin

      // Randomize seed
      Randomize;

      // Randomize values of array
      for i := 1 to Length do
      Result[i] := Random(1000);
    end;

    // Create Reversed array
    2:
    begin

      // Make Arr[i] val equal to Length - index
      for i := 1 to Length do
      Result[i] := Length - i + 1;
    end;

    // Create Sorted array
    3:
    begin

      // Make Arr[i] val equal to index
      for i := 1 to Length do
        Result[i] := i;
    end;

    // Error
    else
    begin
      writeln('Error!');
      Result := nil;
    end;
  End;
end;

// Insertion sort
// ArrGiven - given array
function InsertionSort(ArrGiven: TArray): Integer;

// Arr - array which is sorted
// i, j - indexes
// temp - temp value to swap
var
  Arr: TArray;
  i,j,temp: Integer;
begin

  // Copy given array
  Arr := Copy(ArrGiven);

  // Make Result equal to 0
  // to increment without errors
  Result := 0;

  // Sort array from 1 to Length
  for i := 1 to High(Arr)+1 do
  begin

    // Set default j index to i - 1
    j := i - 1;

    // Save value of Arr[i]
    temp := Arr[i];

    // While Arr[j] > Arr[i] move it to Arr[j+1]
    while (j >= 0) and (Arr[j]>temp) do
    begin

      // Move Arr[j] to Arr[j+1]
      Arr[j+1] := Arr[j];

      // Decrement index to move
      // Arr[j] further
      j := j - 1;

      // Increment Result after swap
      Result := Result + 1;
    end;

    // Make Arr[j+1] := temp after moving it forward
    Arr[j+1] := temp;

    // Increment Result after swap
    Result := Result + 1;
  end;
end;

// Quick sort
// ArrGiven - given array
function QuickSort(ArrGiven: TArray): Integer;
var
// Arr - copy of given array;
// St - stack
// length - length of Arr
// i,j - indexes
// S, L, x - parameters for non recursive quick sort
// temp - temp parameter for swap
  Arr: TArray;
  St: Array of Array of Integer;
  length: Integer;
  i, j, S, L, R, x, temp: Integer;
begin

  // Copy given array
  Arr := Copy(ArrGiven);

  // Get length of array
  Length := High(Arr) + 1;
  SetLength(St, Length, Length);

  Result := 0;

  S := 1;

  St[1,1] := 1;
  St[1,2] := Length;

  repeat
    L := St[S,1];
    R := St[S,2];

    S := S - 1;

    repeat
      i := L;
      j := R;

      x := Arr[(L+R) div 2];

      repeat

        while Arr[i] < x do
          i := i + 1;

        while Arr[j] > x do
          j := j - 1;

        if i <= j then
        begin
          temp := Arr[i];
          Arr[i] := Arr[j];
          Arr[j] := temp;
          Result := Result + 1;
          i := i + 1;
          j := j - 1;
        end;

      until i > j;

      if i < R then
      begin
        S := S + 1;
        St[S,1] := i;
        St[S,2] := R;
      end;

      R := j;

    until L >= R;

  until S = 0;
end;

// ArrLengths - array that contains lengths of arrays to calculate
const
  ArrLengths: TArray = [100, 250, 500, 1000, 2000, 3000];

// i - index
// ArrSorted - sorted array length ArrLengths[i]
// ArrReversed - reversed array length ArrLengths[i]
// ArrRandom - random array length ArrLengths[i]
var
  i: Integer;
  ArrSorted, ArrReversed, ArrRandom: TArray;
begin

  // Iterate through lengths
  for i := 0 to 5 do
  begin

    // Create 3 types of array
    ArrRandom := Create(1, ArrLengths[i]);
    ArrReversed := Create(2, ArrLengths[i]);
    ArrSorted := Create(3, ArrLengths[i]);

    // Output result of random array sorts
    write('N = ', ArrLengths[i]:4, ', Random,   ');
    write(InsertionSort(ArrRandom):8, ' ');
    writeln(QuickSort(ArrRandom):8);

    // Output result of reversed array sorts
    write('N = ', ArrLengths[i]:4, ', Reversed, ');
    write(InsertionSort(ArrReversed):8, ' ');
    writeln(QuickSort(ArrReversed):8);

    // Output results of sorted array sorts
    write('N = ', ArrLengths[i]:4, ', Sorted,   ');
    write(InsertionSort(ArrSorted):8, ' ');
    writeln(QuickSort(ArrSorted):8);
  end;

  // Stop console from closing
  readln;
end.
