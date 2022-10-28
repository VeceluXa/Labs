program HW1;

{
  Output all Perfect Numbers in range [M..N]
  Input:
    M - start of range
    N - end of range
  Output: sequence of Perfect Numbers
}

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils;

{
  M - start of range
  N - end of range
  Error - value for catching errors in input
  i - counter for 'for' loop in range [M..N]
  j - counter for 'for' loop in range [i..1]
  Sum - sum of divisors of i
  InputStr - string to enter data
}
var
  M, N, Error, i, j, Sum: Integer;
  InputStr: String;

begin
  // Input M
  write('Enter M: ');
  repeat
    readln(InputStr);
    val(InputStr, M, Error);
    if ((Error <> 0) or (M < 0)) then
      write('Error. Enter valid number: ');
  until (Error = 0) and (M > 0);

  // Input N
  write('Enter N: ');
  repeat
    readln(InputStr);
    val(InputStr, N, Error);
    if (Error <> 0) then
      write('Error. Enter valid number: ')
    else if M > N then
    begin
      write('M > N. Enter valid number: ');
      Error := -1;
    end;
  until (Error = 0) and (M <= N);

  // Check Array for Perfect Numbers
  writeln('Perfect Numbers in range [M..N] are:');
  for i := M to N do
  begin
    Sum := 0;
    for j := i - 1 downto 1 do
    begin
      if (i mod j = 0) then
        Sum := Sum + j;
    end;
    if Sum = i then
      write(i, ' ');
  end;

  // Stop console from closing
  readln;
end.
