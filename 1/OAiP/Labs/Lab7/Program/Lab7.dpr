program Lab7;

{
  Given mathematical expression in Infix Notation
  (Allowed Symbols [digits, '(', ')', '*',
  '/', '+', '-']) convert it to Postfix Notation

  Input: Expression in Infix Notation - String
  Output: Expression in Postfix Notation - String
}

{$APPTYPE CONSOLE}

{$R *.res}

// Import library with TStack
uses
  System.SysUtils, System.Generics.Collections;

// Error - error value to check for allowed symbols
// i - index for 'for' loop to iterate through string
// Stack - stack of elements to calculte algorythm
// AllowedSyms - set of elements that are allowed in given expression
// Digits - set of elements to check if current element is digit
// InputStr - input string
// InfNot - expression in Infix Notation
// PostNot - expression in Postfix Notation (Reverse Polish Notation)
var
  Error, i: Integer;
  Stack: TStack<String>;
  AllowedSyms: set of Char = ['0','1','2','3','4','5','6','7',
                              '8','9','+','-','*','/','(',')'];
  Digits: set of Char = ['0','1','2','3','4','5','6','7','8','9'];
  InputStr, InfNot, PostNot: String;

begin

  // Enter a mathematical expression
  // in Infix Notation
  repeat

    // Input line
    writeln('Enter a mathematical expression in Infix Notation:');
    readln(InputStr);

    // Check if all chars in InputStr are allowed
    // If not, Error := index of failure
    Error:=0;
    i:=0;
    repeat
      i := i + 1;
      if not (InputStr[i] in AllowedSyms) then Error:=i;
    until(Error <> 0) or (i = InputStr.Length);

    // If Error was found output index of failed element
    if (Error <> 0) then
    begin
      writeln;
      writeln('Invalid symbol on position ', Error);
      writeln('Expression must consist of digits and operators: +, -, *, /');
      writeln;
    end;
  until Error = 0;

  // After completing all checks equate inputted string
  // to InfNot
  InfNot := InputStr;

  // Initialize stack
  Stack := TStack<String>.Create;

  // Iterate through chars of inputted line InfNot
  for i := 1 to InfNot.Length do
  begin

    // Check if current symbol is number
    // If so, add it to final line
    if InfNot[i] in Digits then
      PostNot.Insert(PostNot.Length, InfNot[i]);

    // Check if current symbol is '('
    // If so, push it to stack
    if InfNot[i] = '(' then
      Stack.Push(InfNot[i]);

    // Check if current symbol is ')'
    // If so, move all elements from stack to final
    // line until '(' is present
    if InfNot[i] = ')' then
    begin
      while Stack.Peek <> '(' do
      begin
        PostNot.Insert(PostNot.Length, Stack.Peek);
        Stack.Pop;
      end;
      Stack.Pop;
    end;

    // Check if current symbol is either '*' or '/'
    if (InfNot[i] = '*') or (InfNot[i] = '/') then
    begin

      // Check if top of stack contains the same symbol
      // If not, push current symbol to stack
      // Else, move all elements from stack to final line
      // while top of stack is '*' or '/'
      if (Stack.Count = 0) or ((Stack.Peek <> '*') and (Stack.Peek <> '/')) then
        Stack.Push(InfNot[i])
      else
      begin
        while (Stack.Count > 0) and ((Stack.Peek = '*') or (Stack.Peek = '/')) do
        begin
          PostNot.Insert(PostNot.Length, Stack.Peek);
          Stack.Pop;
        end;
        Stack.Push(InfNot[i]);
      end;
    end;

    // If current symbol is eiter '+' of '-'
    if (InfNot[i] = '+') or (InfNot[i] = '-') then
    begin

      // Check if top of stack is '('
      // If so, push current symbol to stack
      // Else, move all elements from stack to
      // final line until '(' is present
      if (Stack.Count > 0) and (Stack.Peek = '(') then
        Stack.Push(InfNot[i])
      else
      begin
        while (Stack.Count > 0) and (Stack.Peek <> '(')  do
        begin
          PostNot.Insert(PostNot.Length, Stack.Peek);
          Stack.Pop;
        end;
        Stack.Push(InfNot[i]);
      end;
    end;
  end;

  // After cycle move all elements from stack to final line
  while Stack.Count > 0 do
  begin
    PostNot.Insert(PostNot.Length, Stack.Peek);
    Stack.Pop;
  end;

  // Output final line in reverse polish notation
  writeln;
  writeln('Expression in Postfix Notation:');
  writeln(PostNot);

  // Stop console from closing
  readln;
end.
