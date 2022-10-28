program Lab3;

{$R *.res}

{$APPTYPE CONSOLE}

uses
  System.SysUtils;

type
  pt = ^elem;

elem = Record
  Coef: integer;
  step: integer;
  next: pt;
End;

Var
  First, Second, Third: pt;
  N, X: integer;
  FlagOfEquance: Boolean;

// Entere polynom
Function Input(): integer;
Var
  Number, Error: integer;
  s: string;
begin
  Repeat
    Readln(s);
    Val(s, Result, Error);
    if Error <> 0 then
      Writeln('Enter a valid number!');
  Until Error = 0;
end;

// Constructor of list
procedure make(X: pt; N: integer);
Var
y: pt;
Coef: integer;
s: String;
begin
  while (N >= 0) do
  begin
  Write('Enter coefficient (X^', N, '): ');
  Coef := Input();
  if Coef <> 0 then
  begin
    X^.Coef := Coef;
    X^.step := N;

    y := X;
    New(X);

    y^.next := X;
  end;
  N := N - 1;

  end;
  y^.next := nil;

end;

Procedure Println(p: pt);
begin
  if p^.step <> 0 then
  begin
    if p^.Coef = 1 then
      write('x^', p^.step)
    else if p^.Coef > 1 then
      write(p^.Coef, 'x^', p^.step)
    else if p^.Coef = -1 then
      write('-x^', p^.step)
    else if p^.Coef < 0 then
      write(p^.Coef, 'x^', p^.step);
  end
  else
    write(p^.Coef);

  while p <> nil do
  begin

    p := p^.next;
    if (p <> nil) then
    begin

      if (p^.Coef < 0) then
      begin
        write(' - ');
        if p^.step <> 0 then
        begin
          if p^.Coef = -1 then
            write('x^', p^.step)
          else
            write(-1 * p^.Coef, 'x^', p^.step);
        end
        else
        begin
          write(-1 * p^.Coef);
        end;
      end
      else
      begin

        write(' + ');
        if p^.step <> 0 then
        begin
          if p^.Coef = 1 then
            write('x^', p^.step)
          else
            write(p^.Coef, 'x^', p^.step);
          end
          else
          begin
            write(p^.Coef);
        end;
      end;
    end;

  end;
end;

function Equality(p: pt; q: pt): Boolean;
Var
Flag: Boolean;
begin
Flag := true;
while (p <> nil) and (q <> nil) and Flag do
begin
if p^.step = q^.step then
begin
if p^.Coef <> q^.Coef then
Flag := False;
end
else
Flag := False;
p := p^.next;
q := q^.next;
end;

if Flag then
  Writeln('Polynomials p and q are equal')
else
  Writeln('Polynomials p and q are not equal');

Result := Flag;

end;

function Meaning(p: pt; X: integer): integer;
Var
I, Mult: integer;
begin
  Result := 0;
  while p <> nil do
  begin
    Mult := 1;
    for I := 1 to p^.step do
      Mult := Mult * X;
    Result := Result + p^.Coef * Mult;

    p := p^.next;
  end;

  Writeln('P(', X, ') = ', Result);

end;

Procedure Add(p: pt; q: pt; r: pt);
Var
y: pt;
begin

  while (q <> nil) and (p <> nil) do
  begin

    if p^.step < q^.step then
    begin
      r^.Coef := q^.Coef;
      r^.step := q^.step;
      q := q^.next;
    end
    else if p^.step = q^.step then
    begin
      r^.Coef := q^.Coef + p^.Coef;
      r^.step := q^.step;
      p := p^.next;
      q := q^.next;
    end
    else if p^.step > q^.step then
    begin
      r^.Coef := p^.Coef;
      r^.step := p^.step;
      p := p^.next;
    end;

    y := r;
    New(r);
    y^.next := r;

  end;

  y^.next := nil;
end;

begin
  New(First);
  New(Second);
  New(Third);

  Write('Enter the highest degree for the first polynomial: ');
  N := Input();
  make(First, N);
  Println(First);
  Writeln;

  Write('Enter the highest degree for the second polynomial: ');
  N := Input();
  make(Second, N);
  Println(Second);
  Writeln;

  FlagOfEquance := Equality(First, Second);

  Write('Enter X: ');
  Readln(X);
  Writeln('Value of the first polynomial: ');
  Meaning(First, X);

  write('Enter X: ');
  Readln(X);
  Writeln('Value of the second polynomial: ');
  Meaning(Second, X);

  Write('Sum of two polynomials: ');
  Add(First, Second, Third);
  Println(Third);
  Readln;

end.
