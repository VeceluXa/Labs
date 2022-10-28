Unit SingList;

{ This module holds different representation of dynamic structures
  of data: list }

Interface

  // block of types
  Type
    PElem=^Elem;    // pointer on list's element
      Elem = Record
        Data: String;   // data that list process
        Next: PElem;    // pointer on the next element of the list
      End;

    SingleList=class
      protected
        FirstElem: PElem;
        Length: Integer;

      public
        // constructures
        constructor Create;

        // procedures
        procedure InsertBack(Data: String);
        procedure InsertFront(Data: String);
        procedure InsertMiddle(Data: String; Pos: Integer);
        procedure SetElem(Data: String; Pos: Integer);
        procedure InsertSort(IsAscending: Boolean);

        // functions
        function PopBack: String;
        function PopFront: String;
        function PopMiddle(Pos: Integer): String;
        function GetElem(Pos: Integer): String;

        // setters
        function GetLength:Integer;
    end;

Implementation

  // CONSTUCTORS IMPLEMENTATION

  // This constructure just initialize fields of the class
  Constructor SingleList.Create;
  begin
    // initialize fields meanings
//    New(Self.FirstElem);
    Self.FirstElem.Next:=Nil;
    Self.FirstElem.Data:='';

    Self.Length:=0;
  end;

  // PROCEDURES IMPLEMENTATION

  Procedure SingleList.InsertBack(Data: String);

  { Adds new element to the end of the list
    Data - meaning of elemeng }

  var
    NewElem: PElem;
    i: Integer;


  begin
    // getting pointer of last element
    NewElem:=Self.FirstElem;
    while NewElem^.Next <> Nil do
    begin
      NewElem:=NewElem^.Next;
    end;

    // if last element is not first one, create new element
    if Self.Length > 0 then
    begin
      New(NewElem^.Next);
      NewElem:=NewElem^.Next;
    end;

    // set data to new end element
    NewELem^.Data:=Data;
    NewElem^.Next:=Nil;

    Inc(Self.Length);
  end;

  Procedure SingleList.InsertFront(Data: String);

  { Inserts new element before the first one
    Data - mening of new element }

  var
    NewElem: PElem;

  begin
    // creating new element
    New(NewElem);
    NewElem^.Next:=Self.FirstElem;

    // setting meaning to new elemenet
    Self.FirstElem:=NewElem;
    Self.FirstElem^.Data:=Data;

    Inc(Self.Length);
  end;

  Procedure SingleList.InsertMiddle(Data: String; Pos: Integer);

  { Inserts new element on the special position
    Data - meaning of new element
    Pos - position of new element }

  var
    NextElem, PrevElem: PElem;
    NewElem: PElem;

    i: Integer;

  begin
    // getting element before new element
    PrevElem:=Self.FirstElem;
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

    Inc(Self.Length);
  end;

  Procedure SingleList.SetElem(Data: string; Pos: Integer);

  { Sets meaning to alredy existing element
    Data - meaning to set
    Pos - position of element to set }

  var
    Elem: PElem;

    i: Integer;

  begin
    // getting element
    Elem:=Self.FirstElem;
    for i:=1 to Pos-1 do
      Elem:=Elem^.Next;

    Elem^.Data:=Data;
  end;

  function IsBigger(A, B: String): Boolean;

  { Comparator cheks if A > B }

  begin
    Result:=A > B;
  end;

  function IsLower(A, B: String): Boolean;

  { Comparator cheks if A < B }

  begin
    Result:=A < B;
  end;

  Procedure SingleList.InsertSort(IsAscending: Boolean);

  { Sorts list using Insertiong Sort algorithm }

  var
    Comp: Function(A, B: String): Boolean;

    X: String;
    Low, High: Integer;
    i, j: Integer;

  begin
    // get direction of sorting
    if IsAscending then
      Comp:=IsBigger
    else
      Comp:=IsLower;

    // initialization
    Low:=2;
    High:=Length;

    // sorting algorithm
    for i:=Low to High do
    begin
      X:=Self.GetElem(i);

      // go down
      j:=i - 1;
      while (j >= 1) and Comp(Self.GetElem(j), X) do
      begin
        Self.SetElem(Self.GetElem(j), j+1);
        Dec(j);
      end;

      Self.SetElem(X, j+1);
      Inc(j);
    end;
  end;

  // FUNCTIONS IMPLEMENTATION

  Function SingleList.PopBack: String;

  { Deletes and returns last element of the list }

  var
    PopElem: PElem;
    i: Integer;

  begin
    // finding element to pop
    PopElem:=Self.FirstElem;
    for i:=1 to Length-1 do
      PopElem:=PopElem^.Next;

    // returning and deleting that element
    Result:=PopElem^.Data;
    Dispose(PopElem);

    Dec(Self.Length);
  end;

  Function SingleList.PopFront: String;

  { Deletes and return first element of the list }

  var
    PopElem: PElem;

  begin
    // getting firs element
    PopElem:=Self.FirstElem;
    Self.FirstElem:=PopElem^.Next;

    // returning and deleting that element
    Result:=PopElem^.Data;
    Dispose(PopElem^.Next);
    Dispose(PopElem);

    Dec(Self.Length);
  end;

  Function SingleList.PopMiddle(Pos: Integer): String;

  { Deletes and returns element on the position Pos }

  var
    PrevElem, NextElem: PElem;
    PopElem: PElem;

    i: Integer;

  begin
    // finding element to pop
    PrevElem:=Self.FirstElem;
    for i:=1 to Pos-2 do
    begin
      PrevElem:=PrevElem^.Next;
    end;


    Result:=PrevElem^.Next^.Data;

    // linking neighboring elements
    NextElem:=PrevElem^.Next^.Next;
    PrevElem^.Next:=NextElem;

    // deleting that element
    Dispose(PrevElem^.Next^.Next);
    Dispose(PrevElem^.Next);

    Dec(Self.Length);
  end;

  Function SingleList.GetElem(Pos: Integer): String;

  { Gets meaning of element on the position Pos }

  var
    Elem: PElem;

    i: Integer;

  begin
    // finding element
    Elem:=Self.FirstElem;
    for i:=1 to Pos-1 do
      Elem:=Elem^.Next;

    Result:=Elem^.Data;
  end;

  Function SingleList.GetLength: Integer;

  { Returns length of the list }

  begin
    Result:=Length;
  end;
End.

