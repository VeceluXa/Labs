program Ex2;

{
  Each tick:
    1. Red bacteria changes to green
    2. Green bacteria splits to red and green bacterias
  Input:
    n - amount of red bacterias
    k - ticks of time
  Output an amount of red and green bacterias
}

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils;

// r - amount of red bacterias
// g - amount of green bacterias
// k - time passed
// i - count
// gTemp - temp value of green bacterias
// flag - bool to track if value out of bounds
var k, i: Integer;
    r, g, gTemp: Int64;
    flag: Boolean;

begin
  // Input variables
  write('Enter the amount of red bacterias (natural number): ');
  readln(r);
  write('Enter the amount of time ticks (natural number): ');
  readln(k);

  g := 0;
  flag := false;
  for i := 1 to k do
  begin
    if ((r >= 0) and (g >= 0)) then
    begin
      gTemp := g;
      g := g + r;
      r := gTemp;
    end
    else
      flag := true;
  end;

  // Output results
  if flag then
  begin
    writeln('Values of bacterias out of Integer bounds. Try different numbers.')
  end
  else
  begin
    writeln('The amount of bacterias after ', k, ' ticks passed:');
    writeln('Red: ', r);
    writeln('Green: ', g);
  end;

  // Stop console from closing
  Readln;
end.
