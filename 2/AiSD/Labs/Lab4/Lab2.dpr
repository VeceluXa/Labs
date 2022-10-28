program Lab2;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils,
  List in 'List.pas',
  SingleList in 'SingleList.pas';

var
  InpStr: String;
  i, Count, Error, Number: Integer;
  List, fList: TList;
  SinglyList: TSinglyList;


begin

  // Create Lists
  List := TList.Create();
  fList := TList.Create();

  // Input amount of numbers to input (>0)
  write('Enter amount of numbers to input: ');
  repeat
    readln(InpStr);
    val(InpStr, Count, Error);
    if (Error <> 0) or (Count <= 0) then
      writeln('Error! Input a valid number (>0).');
  until (Error = 0) and (Count > 0);

  for i := 1 to Count do
  begin

    // Input a number (>0)
    repeat
      write('Enter number[',i,']: ');
      readln(InpStr);
      val(InpStr, Number, Error);
      if ((Error <> 0) or (Number <= 0)) or
          (not ((Number > 100)and(Number < 999)) and
          not ((Number > 1000000)and(Number < 9999999))) then
        writeln('Error! Input a valid number (>0, 100-999, 1000000-9999999).');
    until (Error = 0) and (Number > 0) and
    (((Number >= 100)and(Number <=999))or((Number >= 1000000)and(Number <= 9999999)));
    List.Add(Number);
  end;

  writeln('Numbers in order:');
  for i := 0 to Count - 1 do
    writeln(List.GetDataById(i));
  writeln;

  writeln('Numbers in reversed order:');
  for i := Count - 1 downto 0 do
    writeln(List.GetDataById(i));
  writeln;


  SinglyList := TSinglyList.Create();
  // Remove nodes with 100<=data<=999
  i := 1;
  while i <= List.length do
  begin
    if List.GetDataById(i-1) > 999 then
    begin
      SinglyList.Add(List.GetDataById(i-1));
    end;
    i := i + 1;
  end;



  writeln('Numbers without operator''s num:');
  for i := 1 to SinglyList.length do
    writeln(SinglyList.GetDataById(i-1));

  // Sort List
  SinglyList.Sort;

  writeln;
  writeln('Sorted numbers:');
  for i := 1 to SinglyList.length do
    writeln(SinglyList.GetDataById(i));

  readln;
end.
