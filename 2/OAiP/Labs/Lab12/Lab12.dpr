program Lab12;
// The program that calculates the value of the given task

// Console app
{$APPTYPE CONSOLE}

// Modules declaration
uses
  System.SysUtils,
  Queue in 'Queue.pas';

// Vars declaration
var
  N: integer;
  { N - number of elements }

  // Function to round and output real value
function format(const x: real): string;
begin
  result := floattostr(trunc(x * 100 + 0.5) / 100);
end;

function calc(const N: integer): string;
var
  q1, q2, q3: ptr;
  i: integer;
  min, temp: real;
  { q1, q2, q3 - queues to evaluate the given task
    sum - the result of the evaluation
    i - iterator }

begin

  // Initialising queues
  create(q1);
  create(q2);
  create(q3);

  // Generating random values and recording them to queues q1 and q2
  randomize;
  write('A = ');
  temp := (random(100) + 1) / (random(10) + 1);
  push(q1, temp);
  write(format(temp));
  for i := 2 to N do
  begin
    temp := (random(100) + 1) / (random(10) + 1);
    push(q1, temp);
    write(' , ', format(temp));
  end;
  for i := 1 to N do
  begin
    temp := (random(100) + 1) / (random(10) + 1);
    push(q2, temp);
    write(' , ', format(temp));
  end;

  writeln;

  // Evaluating the given task
  min := pop(q1) + pop(q2);
  while not empty(q2) do
  begin
    temp := pop(q1) + pop(q2);
    if temp < min then
      min := temp;
  end;

  result := format(min);
end;

begin

  // Inputting number of elements
  write('Input dimension: ');
  readln(N);

  writeln(calc(N));

  readln;

end.


