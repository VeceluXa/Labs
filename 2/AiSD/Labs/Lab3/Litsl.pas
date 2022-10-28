unit Litsl;

interface
  type
    nodeptr=^node;
    node = Record
            Surname:String;
            Name:String;
            Patronymic:String;
            Number:Integer;
            next:nodeptr;
           End;
    TList = class
      private

        // Pointer to the first node of TList
        head:nodeptr;

      public

        // Property that stores total number
        // of nodes in TList
        length:Integer;

        // Initialize new instance of TList
        constructor Create(length: Integer);

        // Write all data from TList
        procedure Write;

        // Set data to element by id
        procedure SetData( valNum:Integer; valSur, valName, valPatr : String);

        procedure FSur (number : Integer);

        procedure FNum(surname:string);



        // Remove node by Id
  //      procedure RemoveById(id: Integer);

        // Get data by id
  //      procedure WriteDataById(id: Integer);

        function IsSorted(el:nodeptr; Sur, Name, Patr : String):Boolean;

        function GetSurNameById(id: Integer): String;

        // Return data by id
        function GetNameById(id: Integer): String;

        function GetPatronymicById(id: Integer): String;

        function GetNumbById(id: Integer): Integer;

    end;

implementation

  constructor TList.Create(length: Integer);
  var first, second: nodeptr;
  i: Integer;
  begin

    // Set length property
    self.length := length;

    // Initialize head
    new(first);
    first.Surname:='';
    first.Name := '';
    first.Patronymic:='';
    first.Number := 0;
    self.head := nil;
    self.head := first;

    // Initialize second element and set pointers
    new(second);
    head.next := second;
    second.Surname:='';
    second.Name := '';
    second.Patronymic:='';
    second.Number := 0;

    // Get ready for loop
    first := second;

    // Create new nodes from 3 to length
    for i := 3 to length do
    begin

      // Initialize new node and set fields
      new(second);
      second.Surname:='';
      second.Name := '';
      second.Patronymic:='';
      second.Number := 0;
      first.next := second;

      // Get ready for next iteration (t := t + 1)
      first := second;
    end;

    // Set pointers to head
    first.next := nil;
  end;

  procedure TList.write;
  var el: nodeptr;
      i: integer;
  begin
    el := head;
    Writeln;
    Writeln('TELEPHONE BOOK:');
    Writeln('_______________');
    Writeln;
    i:=1;
    while el <> nil do
    begin
      Writeln(i,'.');
      writeln('Surname - ',el.surname,'.');
      writeln('Name - ',el.name,'.');
      writeln('Patronymic - ',el.patronymic,'.');
      writeln('Mobile number - ', el.Number,'.');
      writeln('_______________________________');
      writeln;
      el := el.next;
      inc(i);
    end;
  end;

  procedure TList.FSur(number: Integer);
  var
    el: nodeptr;
    fl:boolean;

  begin
    el:=self.head;
    fl:=false;
    while el <> nil do
    begin
      if (el.Number = number) then
      begin
        Writeln;
        Writeln('_______________');
        writeln;
        writeln('Surname - ',el.surname,'.');
        writeln('Name - ',el.name,'.');
        writeln('Patronymic - ',el.patronymic,'.');
        writeln('Mobile number - ', el.Number,'.');
        writeln;
        writeln('_______________________________');
        writeln;
        fl:=true;
      end;
      el:=el.next;
    end;
    if not Fl then
    begin
      writeln;
      writeln('There isn''t anyone with this number!');
      writeln;
    end;

  end;

  procedure TList.FNum(surname:string);
  var
    el: nodeptr;
    i:integer;

  begin
    el:=self.head;
    i:=0;
    while el <> nil do
    begin
      if (el.surname = surname) then
      begin
        inc(i);
        Writeln;
        Writeln('_______________');
        writeln;
        writeln(i,'.');
        writeln('Surname - ',el.surname,'.');
        writeln('Name - ',el.name,'.');
        writeln('Patronymic - ',el.patronymic,'.');
        writeln('Mobile number - ', el.Number,'.');
        writeln;
        writeln('_______________________________');
        writeln;
      end;
      el:=el.next;
    end;
    if i = 0 then
    begin
      writeln;
      writeln('There isn''t anyone with this surname!');
      writeln;
    end;

  end;

  procedure TList.SetData( valNum:Integer; valSur, valName, valPatr : String);
  var
    el,temp:nodeptr;
    i:Integer;
    flagS : Boolean;
  begin

    // Move pointer to element
    el := self.head;
   { for i := 0 to id - 1 do
    begin
      el := el.next;
    end;        }


    FlagS:=IsSorted(el, valSur, valName, valPatr);

    while (not FlagS) and (el.next <> nil) do
    begin
      el:=el.next;
      FlagS:=IsSorted(el, valSur, valName, valPatr);
    end;

    temp:=el.next;
    new(el.next);
    el.next.Surname:=el.Surname;
    el.next.Name:=el.Name;
    el.next.Patronymic:=el.Patronymic;
    el.next.Number:=el.Number;
    el.next.next:=temp;

    {
    while temp.next.number <> 0 do
    begin
      temp1:=temp.next;
      temp.next:=temp.next.next;
      temp.next.next:=temp1;

      temp.next.Surname:=temp.Surname;
      temp.next.Name:=temp.Name;
      temp.next.Patronymic:=temp.Patronymic;
      temp.next.Number:=temp.Number;
      temp:=temp.next;
    end;
    }

    // Set data
    el.Surname:= valSur;
    el.Name := valName;
    el.Patronymic:= valPatr;
    el.Number := valNum;


    while el.next.next <> nil do
      el:=el.next;
    temp:=el.next;
    el.next:=el.next.next;
    dispose(temp);


  end;


  function TList.IsSorted(el:nodeptr; Sur, Name, Patr : String):Boolean;
  begin

    if Sur < el.surname then
    begin
      result:=true;

    end
    else
      if Sur = el.surname then

      begin

        if Name < el.name then
        begin
          result:=true;

        end
        else

          if name = el.name then
          begin
            if Patr < el.Patronymic then
            begin
              result:=true;

            end
            else
              result:=false;
          end
          else result:=false;
      end
      else result:=false;

    if el.number = 0 then
    begin
      result:=true;

    end;
  end;


  function TList.GetNameById(id: Integer): String;
  var
    el: nodeptr;
    i: Integer;
  begin

    // Move to desired node
    el := self.head;
    for i := 0 to id - 1 do
      el := el.next;

    // Return name of desired node
    Result := el.Name;
  end;

  function TList.GetSurNameById(id: Integer): String;
  var
    el: nodeptr;
    i: Integer;
  begin

    // Move to desired node
    el := self.head;
    for i := 0 to id - 1 do
      el := el.next;

    // Return name of desired node
    Result := el.Surname;
  end;

  function TList.GetPatronymicById(id: Integer): String;
  var
    el: nodeptr;
    i: Integer;
  begin

    // Move to desired node
    el := self.head;
    for i := 0 to id - 1 do
      el := el.next;

    // Return name of desired node
    Result := el.Surname;
  end;

  function TList.GetNumbById(id: Integer): Integer;
  var
    el: nodeptr;
    i: Integer;
  begin

    // Move to desired node
    el := self.head;
    for i := 0 to id - 1 do
      el := el.next;

    // Return number of desired node
    Result := el.Number;
  end;

end.
