program Lab1;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils,
  Litsl in 'Litsl.pas';

var
  InputStr: String;
  Count, RemoveId, Error, num: Integer;
  List: TList;
  Flag : Boolean;
  R : Char;

// Procedure to calculate Counters given players and id to remove
procedure CalcCounter(NumPlayers, RemoveId:Integer);
var i,j,numb:Integer;
    surname, named, patronymic, Inp : String;
begin

  // Initialize new instance of TList with desired number of players
  List := TList.Create(NumPlayers);

  for i := 0 to NumPlayers - 1 do
  begin

    writeln('Enter surname of #', i+1, ' abonent: ');
    repeat
      Flag:=True;
      readln(Inp);
      if (length(Inp)) > 15 then Flag := false;
      for j:=1 to length(Inp) do
        if(Inp[j]= ' ') then  Flag:=false;
      if not Flag then  writeln('Error! Enter a valid surname!');
    until (Flag=True);

    surname:=Inp;

    writeln('Enter name of #', i+1, ' abonent: ');
    repeat
      Flag:=True;
      readln(Inp);
      if (length(Inp)) > 15 then Flag := false;
      for j:=1 to length(Inp) do
        if(Inp[j]= ' ') then  Flag:=false;
      if not Flag then  writeln('Error! Enter a valid name!');
    until (Flag=True);

    named:=Inp;

    writeln('Enter father name of #', i+1, ' abonent: ');
    repeat
      Flag:=True;
      readln(Inp);
      if (length(Inp)) > 15 then Flag := false;
      for j:=1 to length(Inp) do
        if(Inp[j]= ' ') then  Flag:=false;
      if not Flag then  writeln('Error! Enter a valid father name!');
    until (Flag=True);

    patronymic:=Inp;

    writeln('Enter mobile number of #', i+1, ' abonent: ');
    repeat
      Flag:=True;
      readln(Inp);
      if (length(Inp ) = 7) then
        val(Inp, numb, Error)
      else
        Flag:=false;
      if numb <= 0 then  Flag:=false;
      if not Flag then  writeln('Error! Enter a valid number!');
    until (Error = 0) and (Flag=True);



    // Set values of nodes from 1 to NumPlayers

      List.SetData( numb, surname, named, patronymic);
  end;

 { // Iterate until one node is in the list
  while List.length <> 1 do
  begin

    // Output deleted node
    write(List.GetDataById(i), ' ');



    // Iterate i to move to the next node
    i := i + RemoveId - 1;
  end;   }




end;


procedure WriteCmd;
begin
  writeln;
  writeln('_______________________________');
  writeln;
  writeln('Commands:');
  writeln('1 - display all actions.');
  writeln('2 - find surname by mobile number.');
  writeln('3 - find mobile numbers by surname.');
  writeln('4 - display all abonents.');
  writeln('Another number - exit.');
  writeln;
  writeln('_______________________________');
  writeln;
end;

begin

  // Input count to remove players
  writeln('Enter number of abonents:');
  repeat
    readln(InputStr);
    val(InputStr, Count, Error);
    if (Error <> 0) or (Count < 2) then
      writeln('Error! Enter a valid value!');
  until (Error = 0) and (Count >= 2);

  Removeid:=0; /////

  // Calculate Counters for players in range 1 to 64
  CalcCounter(Count, removeid);

  WriteCmd;

  repeat
    Readln(R);
    case R of
      '1': begin
            writeln;
            WriteCmd;
            writeln;
           end;

      '2':  begin
              writeln;
              Writeln('Enter number to find person.');
              repeat

                readln(InputStr);
                val(InputStr, num, Error);
                if (Error <> 0) or (num <= 0) then
                  writeln('Error! Enter a valid value!');
              until (Error = 0) and (num > 0);

              List.FSur(num);

              writeln;
              WriteCmd;
              writeln;

            end;

      '3':  begin
              Writeln;
              writeln('Enter surname to find person(s)');
              Readln(InputStr);
              List.FNum(InputStr);

              writeln;
              WriteCmd;
              writeln;
            end;

      '4': begin
            writeln;
            List.write;
            writeln;
           end;

      else  R:='0';
    end;


  until R = '0';
end.
