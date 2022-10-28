program Ex3;

{
  You need to buy n floppy disks for minimal price.
  You can buy each of them for 11.50.
  You can buy a box of 12 floppy disks for 114.50.
  You can buy a crate of 12 boxes for 1255.
  Input: n
  Output: price, amount of floppy disks/boxes/crates bought
}

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils;

// n - amount of floppy disks to buy
// floppy - amount of floppy disks
// box - amount of boxes
// crate - amount of crates
// floppyPrice - price of 1 floppy disk
// boxPrice - price of 1 box that contains 12 floppies
// cratePrice - price of 1 crate that contains 12 boxes
// pricePrice - price of n floppy disks
var n: Integer;
    floppy, box, crate: Integer;
    floppyPrice, boxPrice, cratePrice, price: Real;


begin
  // Input
  Write('How much floppy disks do you need to buy: ');
  Readln(n);

  // Set prices
  floppyPrice := 11.50;
  boxPrice := 114.50;
  cratePrice := 1255;

  // Set initial values
  price := 0;
  floppy := 0;
  box := 0;
  crate := 0;

  // Buy crates
  price := price + (n div 144) * cratePrice;
  crate := n div 144;
  n := n mod 144;
  if (n >= 132) then
  begin
    n := 0;
    price := price + cratePrice;
    crate := crate + 1;
  end;

  // But boxes
  price := price + (n div 12) * boxPrice;
  box := n div 12;
  n := n mod 12;
  if (n >= 10) then
  begin
    n := 0;
    price := price + boxPrice;
    box := box + 1;
  end;

  // Buy floppy disks
  price := price + n * floppyPrice;
  floppy := n;

  // Output
  Writeln('Total price: ', price:5:2);
  if (crate > 0) then
    Writeln('Crates bought: ', crate:5);
  if (box > 0) then
    Writeln('Boxes bought: ', box:6);
  if (floppy > 0) then
    Writeln('Floppies bought: ', floppy:3);

  // Stops console from closing
  Readln;
end.
