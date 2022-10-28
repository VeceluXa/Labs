program Eratosthene;
{
  Compute Prime Numbers using Sieve of Eratosthenes Algorithm.
  Input: N - end number
  Output: Primes - array of Prime Numbers
}
{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils;

var
  N, Error, i, j: Integer;
  InputStr: String;
  Primes: Array of Boolean;

begin
  // Input N
  write('Enter N: ');
  repeat
    readln(InputStr);
    val(InputStr, N, Error);
    if (Error <> 0) or (N <= 1) then
      write('Error. Enter valid number: ');
  until (Error = 0) and (N > 1);

  // Algorithm
  SetLength(Primes, N);
  Primes[1] := false;
  for i := 2 to N do
    Primes[i] := true;

  i := 2;
  while(i <= exp(ln(N)/2)) do
  begin
    if Primes[i] then
    begin
      j := i*i;
      while j <= N do
      begin
        Primes[j] := false;
        j := j + i;
      end;
    end;
    i := i + 1;
  end;

  // Output Primes
  writeln('Prime Numbers are: ');
  for i := 1 to N do
    if Primes[i] then
      write(i, ' ');


  // Stop console from closing
  Readln;
end.
