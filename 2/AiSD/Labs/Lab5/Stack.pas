Unit Stack;

Interface
  // block of importing libararies
  Uses
    List;

  // block of types
  Type
    TStack=class
      private
        List: IntList;    // data of stack

      public
        constructor Create();   // create stack
        procedure Push(Data: Char);    // push element to stack
        function Pop(): Char;    // get element from stack with deleting it
        function Get(): Char;    // get element from stack without deleting int
    end;

Implementation
  // creates stack
  constructor TStack.Create();
  begin
    inherited;

    // initialize list
    List:=IntList.Create();
  end;

  // pushes element to stack
  // Data - number to push
  procedure TStack.Push(Data: Char);
  begin
    List.InsertFront(Data);
  end;

  // get element from stack with deleting it
  // return number
  function TStack.Pop(): Char;
  begin
    Result:=List.PopFront();
  end;

  // get element from stack without deleting int
  // returns number
  function TStack.Get(): Char;
  begin
    Result:=List.GetElem(1);
  end;
end.

