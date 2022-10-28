program Lab2;
{
  Algorithm:
    Given natural number M calculate the sum of squares of digits of this number
    and get a new number M. Repeat until M is either 1 or 4.
  Task:
    Enter a natural number N. In range from 1 to n find all numbers that after
    processing become number 1. Find the amount of all this numbers.

  Input: N
  Output: sequence of numbers and the amount.
}

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils;

var
  N, I, K, J, Sum, Error: Integer;
  InputStr: String;

begin
  // Input
  Write('Enter ''N'' in range [1..30000]: ');
  repeat
    Readln(InputStr);
    Val(InputStr, N, Error);
    if ((Error <> 0) or (N < 1) or (N > 30000)) then
      Write('Error! Enter a valid number: ');
  until (Error = 0) and (N >= 1) and (N <= 30000);

  K := 0;
  for I := 1 to N do
  begin
    J := I;
    // Calculate squares
    repeat
      Sum := 0;
      repeat
        Sum := Sum + (J mod 10)*(J mod 10);
        J := J div 10;
      until J = 0;
      J := Sum;
    until (J = 1) or (J = 4);

    // Output number if (j = 1)
    if (J = 1) then
    begin
      Writeln(I);
      K := K + 1;
    end;
  end;

  // Output
  Writeln('Total amount of numbers is: ', K);

  // Stop console from closing
  Readln;
end.
