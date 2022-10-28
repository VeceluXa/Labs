program Lab5;
{
  Calculate A^2 - (A + B)*(A - 3*B), where
      (( 4, 5, 6),          (( 0,-1, 2),
  A =  (-1, 0, 3),      B =  ( 1, 0,-2),
       (-1, 2,-1))           ( 3, 1, 2))
  using functions.
  Output: result of expression
}
{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils,
  Unit1 in 'Unit1.pas';

{$i Incl1.pas}
{$i W:\BSUIR\2\OAiP\Labs\Lab5\Incl2.txt}
{$i \Folder\Incl3.ini}
{$i Incl4}

// Temp1, Temp2, Temp3 - temporary matrices
// to store results of operations
var
  A, B, Temp1, Temp2, Temp3: TMatrix;
begin

  // Input
  {$i Incl5.pas}
end.
