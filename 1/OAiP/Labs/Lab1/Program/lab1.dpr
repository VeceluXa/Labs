program lab1;

uses
  System.SysUtils;

var
  xS, xF, x, xH: Real;
  nS, nF, n, nH: Integer;
  atg, root, sum, num, denum, f: Real;
  flag: boolean;
  k: Integer;

begin

  // Initialize task variables
  xS := 0.6;
  xF := 1.1;
  xH := 0.1;
  nS := 10;
  nF := 15;
  nH := 1;


  x := xS;
  while (x <= xF) do
  begin
    // Calculate arctg(x)
    atg := arctan(x);

    // Reset Error boolean after loop
    flag := false;


    // Reset n to start value every loop
    n := nS;

    while (n <= nF) do
    begin

      // Exit loop if base of logarithm <= 0
      if (n * n * n * (x + 1) <= 0) then
      begin
        write('Error. x = ', x, ', n = ', n);
        n := n + nH;
        continue;
      end;

      // Calculate Power((n * Power((x + 1), 1 / 3)), 1 / 2)
      // using exp(power*ln(base)) equivalent
      root := exp( 1/6 * ln( (n*n*n) * ( x + 1 ) ) );

      k := 1;
      sum := 0;
      while (k <= n) do
      begin

        // Exit this loop if denumerator is 0 or base of exp(power*ln(base)) < 0
        if ( (cos( n * x ) = 0) or  (exp(-k*x) + n * exp((k-1)*ln(x)) < 0) ) then
        begin
          write('Error. x = ', x, ', n = ', n);
          flag := true;
          break;
        end;


        // Calculate the fraction
        num := exp( 1 / 5 * ln( exp(-k*x) + n * exp( (k-1)*ln(x) ) ) );
        denum := cos( k * x );
        // Add fraction to the sum
        sum := sum + num / denum;

        // Iterate k
        k := k + 1;

      end;

      if (flag) then
      begin
        n := n + nH;
        continue;
      end;

      // Calculate and output the result of multiplication
      f := atg * root * sum;
      writeln('x = ', x:1:1, ', n = ', n, ', f = ', f:13:8);

      // Iterate n
      n := n + nH;

    end;

    // Iterate x
    x := x + xH;
  end;


  // Stop console from closing
  Readln;
end.
