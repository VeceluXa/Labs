unit List;

interface
  uses vcl.Graphics, System.SysUtils;
  type
    TItem = class
      public
        Name: String;
        Num: String;
      constructor Create;
    end;
    nodeptr=^node;
    node = Record
            data:TItem;
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
        constructor Create(length: Integer); overload;

        // Initialize new instance of TList
        constructor Create; overload;

        // Set data to element by id
        procedure SetData(id:Integer; val:TItem);

        // Remove node by Id
        procedure RemoveById(id: Integer);

        // Return data by id
        function GetDataById(id: Integer): TItem;

        // Add element to the back
        procedure Add(data: TItem);
    end;

implementation

  constructor TList.Create;
  begin

    self.length := 0;
  end;

  constructor TList.Create(length: Integer);
  var first, second: nodeptr;
  i: Integer;
  begin

    // Set length property
    self.length := length;

    // Initialize head
    new(first);
    first.data := TItem.Create;
    self.head := nil;
    self.head := first;

    // Initialize second element and set pointers
    new(second);
    head.next := second;
    second.data := TItem.Create;

    // Get ready for loop
    first := second;

    // Create new nodes from 3 to length
    for i := 3 to length do
    begin

      // Initialize new node and set fields
      new(second);
      second.data := TItem.Create;
      first.next := second;

      // Get ready for next iteration (t := t + 1)
      first := second;
    end;

    // Set pointers from/to head
    first.next := nil;
  end;

  procedure TList.SetData(id:Integer; val:TItem);
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
    el1, el2: nodeptr;
    i: Integer;
  begin

    // Move cursor to desired node
    el1 := self.head;
    for i := 0 to id - 2 do
      el1 := el1.next;

    el2 := el1.next;

    // If head is removed set self.head
    // pointer to new location
    if el2 = self.head then
      self.head := el2.next;

    if self.length = 1 then
    begin
      self.head := nil;
      self.length := 0;
      exit;
    end;

    // Remove desired node
    el1.next := el2.next;

    // Set values of deleted node to 0
    el2 := nil;

    // Change length property
    self.length := self.length - 1;
  end;

  function TList.GetDataById(id: Integer): TItem;
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

  procedure TList.Add(data: TItem);
  var
    nodeNew, node: nodeptr;
  begin

    // Create new node
    New(nodeNew);
    nodeNew.data := data;

    // If there are no nodes make new node head
    if self.length = 0 then
    begin
       self.head := nodeNew;
       self.head.next := nil;
    end
    else
    begin

      node := self.head;
      while(node.next <> nil) do
        node := node.next;

      node.next := nodeNew;
      nodeNew.next := nil;

    end;

    self.length := self.length + 1;
  end;

constructor TItem.Create;
begin

end;
end.


