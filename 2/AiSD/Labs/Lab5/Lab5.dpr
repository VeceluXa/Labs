program Lab5;

{$APPTYPE CONSOLE}

{ This program translates mathematical expressions written in infix notation
  to postfix notation }

// importing libraries
uses
  System.SysUtils,
  Stack in 'Stack.pas',
  List in 'List.pas';

// block of variables
Var
  PostNot, InfNot: String;

  Stack: TStack;
  Sym, Temp: Char;
  Rang: Integer;


  INLen, SLen: Integer;

  RelPrior, StPrior: Array[0..7] of Byte;
  TempRel, TempSt: Integer;

  i: Integer;

  {
    PostNotation - math expression in postfix notation;
    InNotation - math expression in infix notatioin;

    Stack - stack of opearnds of expression.

    PNLen - length of expression in postfix notation;
    SLen - amount of operands in stack;
    Operators - the set of operators, which are can be processed by the program.

    i - cycle iterator.

    Input - user's input;
    Error - holds the position of invalid symbol in the entered string (Input);
    AllowedSyms - the set of allowed symbols to enter from keyboard.
  }

function GetInfExpression: String;
// getting expression in postfix notation with validation enetered data
const
  AllowedSyms: set of Char = ['a'..'z', '(', ')', '+','-','*','/', '^'];

var
  Error: Integer;
  Input: String;

  i: Integer;

begin
  repeat
    writeln('Enter expression in infix notation: ');
    readln(Input);

    // validation of entered string
    Error:=0;
    i:=0;
    repeat
      Inc(i);
      if not (Input[i] in AllowedSyms) then Error:=i;
    until(Error <> 0) or (i = Input.Length);

    // if user has entered incorrect value
    if (Error <> 0) then
    begin
      writeln;
      writeln('Invalid symbol is on position ', Error);
      writeln('Expression must consists from digits and operators: +, -, *, /');
      writeln;
    end;
  until(Error = 0);

  Result:=Input;
end;

//Procedure SetPriorities(const Operators; const Priors; var Result);
//type
//  TOperators=array[1..6] of Char;
//  TPriors=array[0..7] of Integer;
//
//var
//  COperators:

Begin
  // getting expression in postfix notation with validation enetered data
  InfNot:=GetInfExpression();

  // setting priorities for symbols coming to the stack
  RelPrior[Ord('+') mod 10]:=1;
  RelPrior[Ord('-') mod 10]:=1;
  RelPrior[Ord('*') mod 10]:=3;
  RelPrior[Ord('/') mod 10]:=3;
  RelPrior[Ord('^') mod 10]:=6;
  RelPrior[Ord('(') mod 10]:=9;
  RelPrior[Ord(')') mod 10]:=0;

  // setting priorities for symbols in stack
  StPrior[Ord('+') mod 10]:=2;
  StPrior[Ord('-') mod 10]:=2;
  StPrior[Ord('*') mod 10]:=4;
  StPrior[Ord('/') mod 10]:=4;
  StPrior[Ord('^') mod 10]:=5;
  StPrior[Ord('(') mod 10]:=0;

  // seetting start meanings for variables
  INLen:=InfNot.Length;
  Stack:=TStack.Create();
  Stack.Push(#0);
  Stack.Push(InfNot[1]);
  PostNot:='';

  // transforming given expression from postfix to infix notation
  for  i:=2 to INLen do
  begin
    // getting symbol
    Sym:=InfNot[i];
    TempRel:=RelPrior[Ord(Sym) mod 10];

    while ((not (Sym in ['a'..'z'])) and    // in it is not an opereand
          (TempRel <= StPrior[Ord(Stack.Get()) mod 10]) and (Stack.Get <> #0)) or   // and priority is less or equall
          (Stack.Get in ['a'..'z']) do   // or there is an operand in stack
    begin
      // pop element from stack
      Temp:=Stack.Pop();

      if Temp <> '(' then
      begin
        PostNot:=PostNot + Temp;

        // modifying rang
        if Temp in ['a'..'z'] then
          Inc(Rang, 1)
        else
          Dec(Rang, 1);
      end;
    end;
    If Sym <> ')' then Stack.Push(Sym);
  end;

  // clearing the stack
  while Stack.Get <> #0 do
  begin
    Temp:=Stack.Pop();
    PostNot:=PostNot + Temp;

    if Temp in ['a'..'z'] then
      Inc(Rang, 1)
    else
      Dec(Rang, 1);
  end;

  // printing results
  writeln;
  writeln('Given expression in postfix notation: ');
  writeln(PostNot, '    | Rang:', Rang);

  readln;
End.

