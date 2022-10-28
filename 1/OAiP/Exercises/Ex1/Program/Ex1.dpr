program Ex1;

{
  High Monk eats 10 pies,
  Medium Monk eats 5 pies,
  Low Monk eats 0.5 pies.
  You input:
    N - number of priests,
    Pies - number of pies
  Calculate all combinations of monks
}


{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils;

// N - amount of monks
// Pies - amount of pies
// HMonks - High Monks
// MMonks - Medium Monks
// LMonks - Low Monks
// InputStr - Input String
// Error - conversion error value
// Flag - flag for catching empty values
var N, Pies, HMonks, MMonks, LMonks, Error: Integer;
    InputStr: String;
    Flag: Boolean;

begin
  // Input
  write('Enter the amount of priests: ');
  repeat
    readln(InputStr);
    val(InputStr, N, Error);
    if ((Error <> 0) or (N < 0)) then
      write('Error. Enter a valid number: ');
  until ((Error = 0) and (N >= 0));

  write('Enter the amount of pies: ');
  repeat
    readln(InputStr);
    val(InputStr, Pies, Error);
    if ((Error <> 0) or (Pies < 0)) then
      write('Error. Enter a valid number: ');
  until ((Error = 0) and (Pies >= 0));

  // Draw the base of table
  writeln('____________________________________________');
  writeln('High Priests | Medium Priests | Low Priests|');
  writeln('_____________|________________|____________|');

  Flag := false;
  for LMonks := 0 to N do
  begin
    if (((2 *  Pies + 9 *  LMonks - 10 * N) mod 10 = 0) or
        ((-2 * Pies - 19 * LMonks + 20 * N) mod 10 = 0)) then
    begin
      // Calculate monks
      HMonks := (2 *  Pies + 9 *  LMonks - 10 * N) div 10;
      MMonks := (-2 * Pies - 19 * LMonks + 20 * N) div 10;

      if ((HMonks >= 0) and (MMonks >= 0) and (LMonks >= 0)) then
      begin
        Flag := true;
        // Output the result
        writeln(HMonks:13, '|', MMonks:16, '|', LMonks:12, '|');
      end;
    end;
  end;

  if not Flag then
    writeln('No values    |No values       |No values   |');

  writeln('_____________|________________|____________|');

  // Stop console from closing
  Readln;
end.
