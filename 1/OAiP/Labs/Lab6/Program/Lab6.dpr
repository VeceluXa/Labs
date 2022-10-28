program Lab6;

{
  Find days of first monday in every month in given year
  Input: Year
  Output: Array of Days according to month
}

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils;

// TMonth - type of months in year
type
  TMonth = (January, February, March, April,
            May, June, July, August,
            September, October, November, December);

// YearShift - shift in month according to disparate variation
// of Gauss's algorithm
const
  YearShift: Array[1..12] of Integer =
              (0, 3, 2, 5, 0, 3,
               5, 1, 4, 6, 2, 4);

// WDay - day of week
// D - day
// m - month
// Y - year
// YTemp - temp value of year
// Day - array of days of fist Mondays
// Month - array of months' names
// InputStr - string to input value
// Error - value for errors in Val method
var
  Error, m, D, WDay, Y, YTemp: Integer;
  Day: Array[1..12] of Integer;
  InputStr: String;
  Month: TMonth;

begin

  // Input Year greater than 0 using method Val
  // Input string, take that string and convert it to integer
  // If conversion fails pass index of failed char conversion to Error
  // If Error is not equal to 0, repeat cycle
  // If Inputted year is smaller than 0, repeat cycle
  write('Enter year: ');
  repeat
    readln(InputStr);
    val(InputStr, Y, Error);
    if (Error <> 0) or (Y <= 0) then
      writeln('Error! Enter a valid number.');
  until (Error = 0) and (Y > 0);

  // Iterate through month to find first monday of month m
  for m := 1 to 12 do
  begin

    // Set first day of month
    D := 1;

    // If month is January or December
    // take previous year
    if m < 3 then
      YTemp := Y - 1
    else
      YTemp := Y;

    // Find day of first monday in given month using disparate
    // variation of Gauss's formula
    // Iterate through days of month until you find first Monday
    repeat

      // Find day of week in given D of m
      WDay := ( D + YearShift[m] +
                    YTemp +
                    YTemp div 4 -
                    YTemp div 100 +
                    YTemp div 400 ) mod 7;

      // Go to the next day
      D := D + 1;
    until WDay = 1;

    Day[m] := D - 1;
  end;

  // Output first mondays in months
  // Iterate from January to December
  for Month := January to December do
  begin

    // Output name of month
    case Month of
      January:   write('January: ');
      February:  write('February: ');
      March:     write('March: ');
      April:     write('April: ');
      May:       write('May: ');
      June:      write('June: ');
      July:      write('July: ');
      August:    write('August: ');
      September: write('September: ');
      October:   write('October: ');
      November:  write('November: ');
      December:  write('December: ');
    end;

    // Output day of first Monday
    writeln(Day[ord(Month) + 1]);
  end;

  // Stop console from closing;
  readln;
end.
