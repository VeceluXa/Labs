program Lab5;
{
  Calculate infinite function Y using stoppers
  Eps1 and Eps2.

  Output: X, Eps1/Eps2, Y
}

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils;

// Eps1, Eps2 - checkers to stop infinite loop
// XS - starting X
// XF - finishing X
// HX - step of X
const
  Eps1 = 0.00001;
  Eps2 = 0.000001;
  XS = 0.1;
  XF = 0.9;
  HX = 0.1;

// X - argument
// Y - function
// i - count for loop
// k - count for sum
// Frac = Num / Denum
// Num = x^(4*k+1)
// Denum = (4*k+1)!
var
  X, Y, Frac, Num: Real;
  i, k, Denum: Integer;
  HasReached: Boolean;

begin

  writeln('Calculate Y with:');
  writeln('Eps1 = ', Eps1:5:5);
  writeln('Eps2 = ', Eps2:6:6);
  writeln('_____________________________');
  writeln('|  X  |    Eps1  |   Eps2   |');
  writeln('|_____|__________|__________|');

  // Set starting X
  X := XS;

  // Iterate through X loop
  repeat

    write('| ', X:1:1, ' | ');

    Y := 0;             // Set starting Y
    Denum := 1;         // Set starting denumerator
    k := 0;             // Set starting Sum index
    Frac := X;          // Calculate Fraction when k = 0
    HasReached := false;

    // Calculate Y
    repeat

      // Add fraction to sum Y
      Y := Y + Frac;

      // Iterate sum counter
      k := k + 1;

      // Calculate numerator
      // Raise X in power of N using logarithmic method
      // exp( N * ln(X) )
      Num := exp((4*k+1)*ln(X));

      // Calculate factorial in denumerator
      for i := 0 to 3 do
      begin
        Denum := Denum * ( 4*k + 1 - i);
      end;

      // Calculate fraction
      Frac := Num / Denum;

      // Check if fraction is smaller than Eps1
      if not HasReached and (Frac <= Eps1) then
      begin
        HasReached := true;

        // Output after Eps1 has been reached
        write(Y:6:6, ' | ');
      end;
    until Frac <= Eps2 ;

    // Output after Eps2 has been reached
    writeln(Y:6:6, ' |');

    // Iterate X
    X := X + HX;
  until X > XF;

  writeln('|_____|__________|__________|');

  // Stop console from closing
  readln;
end.
