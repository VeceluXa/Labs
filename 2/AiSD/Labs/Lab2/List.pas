unit List;

interface
  type
    nodeptr=^node;
    node = Record
            data:Integer;
            next:nodeptr;
            prev:nodeptr;
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
        procedure SetData(id, val:Integer);

        // Remove node by Id
        procedure RemoveById(id: Integer);

        // Get data by id
        procedure WriteDataById(id: Integer);

        // Return data by id
        function GetDataById(id: Integer): Integer;
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
    first.data := 0;
    self.head := nil;
    self.head := first;

    // Initialize second element and set pointers
    new(second);
    head.next := second;
    second.prev := head;
    second.data := 0;

    // Get ready for loop
    first := second;

    // Create new nodes from 3 to length
    for i := 3 to length do
    begin

      // Initialize new node and set fields
      new(second);
      second.prev := first;
      second.data := 0;
      first.next := second;

      // Get ready for next iteration (t := t + 1)
      first := second;
    end;

    // Set pointers from/to head
    first.next := head;
    head.prev := first;
  end;

  procedure TList.write;
  var el: nodeptr;
  begin
    el := head;
    writeln(el.data);
    while(el.next <> head) do
    begin
      el := el.next;
      writeln(el.data);
    end;
  end;

  procedure TList.SetData(id, val:Integer);
  var
    el:nodeptr;
    i:Integer;
  begin

    // Move pointer to element
    el := self.head;
    for i := 0 to id - 1 do
    begin
      el := el.next;
    end;

    // Set data
    el.data := val;
  end;


  procedure TList.RemoveById(id: Integer);
  var
    el: nodeptr;
    i: Integer;
  begin

    // Move cursor to desired node
    el := self.head;
    for i := 0 to id - 1 do
      el := el^.next;

    // If head is removed set self.head
    // pointer to new location
    if el = self.head then
      self.head := el.next;

    // Remove desired node
    el.prev.next := el.next;
    el.next.prev := el.prev;

    // Set values of deleted node to 0
    el.prev := nil;
    el.next := nil;
    el.data := 0;

    // Change length property
    self.length := self.length - 1;
  end;

  // Write data on screen by id
  procedure TList.WriteDataById(id: Integer);
  var
    el: nodeptr;
    i: Integer;
  begin

    // Move to desired node
    el := self.head;
    for i := 0 to id - 1 do
      el := el.next;

    // Write desired node
    System.write(el.data);

  end;

  function TList.GetDataById(id: Integer): Integer;
  var
    el: nodeptr;
    i: Integer;
  begin

    // Move to desired node
    el := self.head;
    for i := 0 to id - 1 do
      el := el.next;

    // Return data of desired node
    Result := el.data;
  end;


end.
