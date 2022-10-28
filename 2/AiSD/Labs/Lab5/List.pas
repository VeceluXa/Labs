Unit List;

{ This module holds different representation of dynamic structures
  of data: list }

Interface

  // block of types
  Type
    PElem=^Elem;    // pointer on list's element
      Elem = Record
        Data: Char;     // data that list process
        Next: PElem;    // pointer on the next element of the list
      End;

    IntList=class
      protected
        FirstElem: PElem;
        Length: Integer;

      public
        // constructures
        constructor Create;

        // procedures
        procedure InsertBack(Data: Char);
        procedure InsertFront(Data: Char);
        procedure InsertMiddle(Data: Char; Pos: Integer);
        procedure SetElem(Data: Char; Pos: Integer);

        // functions
        function PopBack: Char;
        function PopFront: Char;
        function PopMiddle(Pos: Integer): Char;
        function GetElem(Pos: Integer): Char;

        // setters
        function GetLength:Integer;
    end;

Implementation

  // CONSTUCTORS IMPLEMENTATION

  // This constructure just initialize fields of the class
  Constructor IntList.Create;
  begin
    // initialize fields meanings
    New(Self.FirstElem);
    FirstElem^.Next:=Nil;

    Length:=0;
  end;

  // PROCEDURES IMPLEMENTATION

  Procedure IntList.InsertBack(Data: Char);

  { Adds new element to the end of the list
    Data - meaning of elemeng }

  var
    NewElem: PElem;
    i: Integer;

  begin
    // getting pointer of last element
    NewElem:=FirstElem;
    while NewElem^.Next <> Nil do
    begin
      NewElem:=NewElem^.Next;
    end;

    // if last element is not first one, create new element
    if Length > 0 then
    begin
      New(NewElem^.Next);
      NewElem:=NewElem^.Next;
    end;

    // set data to new end element
    NewELem^.Data:=Data;
    NewElem^.Next:=Nil;

    Inc(Length);
  end;

  Procedure IntList.InsertFront(Data: Char);

  { Inserts new element before the first one
    Data - mening of new element }

  var
    NewElem: PElem;

  begin
    // creating new element
    New(NewElem);
    NewElem^.Next:=FirstElem;

    // setting meaning to new elemenet
    FirstElem:=NewElem;
    FirstElem^.Data:=Data;

    Inc(Length);
  end;

  Procedure IntList.InsertMiddle(Data: Char; Pos: Integer);

  { Inserts new element on the special position
    Data - meaning of new element
    Pos - position of new element }

  var
    NextElem, PrevElem: PElem;
    NewElem: PElem;

    i: Integer;

  begin
    if Pos <= 1 then InsertFront(Data) else
    begin
      // getting element before new element
      PrevElem:=FirstElem;
      for i:=1 to Pos-2 do
      begin
        PrevElem:=PrevElem^.Next;
      end;

      // creating new element
      New(NewElem);
      NextElem:=PrevElem^.Next;

      // here the list spreads its legs
      PrevElem^.Next:=NewElem;
      NewElem^.Next:=NextElem;

      NewElem^.Data:=Data;

      Inc(Length);
    end;
  end;

  Procedure IntList.SetElem(Data: Char; Pos: Integer);

  { Sets meaning to alredy existing element
    Data - meaning to set
    Pos - position of element to set }

  var
    Elem: PElem;

    i: Integer;

  begin
    // getting element
    Elem:=FirstElem;
    for i:=1 to Pos-1 do
      Elem:=Elem^.Next;

    Elem^.Data:=Data;
  end;

  // FUNCTIONS IMPLEMENTATION

  Function IntList.PopBack: Char;

  { Deletes and returns last element of the list }

  var
    PopElem: PElem;
    i: Integer;

  begin
    // finding element to pop
    PopElem:=FirstElem;
    for i:=1 to Length-1 do
      PopElem:=PopElem^.Next;

    // returning and deleting that element
    Result:=PopElem^.Data;
    Dispose(PopElem);

    Dec(Length);
  end;

  Function IntList.PopFront: Char;

  { Deletes and return first element of the list }

  var
    PopElem: PElem;

  begin
    // getting firs element
    PopElem:=FirstElem;
    FirstElem:=PopElem^.Next;

    // returning and deleting that element
    Result:=PopElem^.Data;
    PopElem^.Next:=Nil;
    PopElem:=Nil;


    Dec(Length);

    if Length = 0 then
    begin
      New(Self.FirstElem);
      FirstElem^.Next:=Nil;
    end;
  end;

  Function IntList.PopMiddle(Pos: Integer): Char;

  { Deletes and returns element on the position Pos }

  var
    PrevElem, NextElem: PElem;
    PopElem: PElem;

    i: Integer;

  begin
    // finding element to pop
    PrevElem:=FirstElem;
    for i:=1 to Pos-2 do
    begin
      PrevElem:=PrevElem^.Next;
    end;


    Result:=PrevElem^.Next^.Data;

    // linking neighboring elements
    NextElem:=PrevElem^.Next^.Next;
    PrevElem^.Next:=NextElem;

    // unbounding that element
    PrevElem^.Next^.Next:=Nil;
    PrevElem^.Next:=Nil;

    Dec(Self.Length);
  end;

  Function IntList.GetElem(Pos: Integer): Char;

  { Gets meaning of element on the position Pos }

  var
    Elem: PElem;

    i: Integer;

  begin
    // finding element
    Elem:=FirstElem;
    for i:=1 to Pos-1 do
      Elem:=Elem^.Next;

    Result:=Elem^.Data;
  end;

  Function IntList.GetLength: Integer;

  { Returns length of the list }

  begin
    Result:=Length;
  end;
End.

