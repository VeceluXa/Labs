unit SingleList;

interface
  type
    nodeptr=^node;
    node = Record
            data:Integer;
            next:nodeptr;
           End;

  TSinglyList = class
    private

      // Pointer to the first node of TList
      head:nodeptr;

    public
      length: Integer;

      // Initialize new instance of TList
        // with set length
        constructor Create(length: Integer); overload;

        // Initialize new instance of TList
        constructor Create(); overload;

        // Write all data from TList
        procedure Write;

        // Add element
        procedure Add(data: Integer);

        // Set data to element by id
        procedure SetData(id, val:Integer);

        // Remove node by Id
        procedure RemoveById(id: Integer);

        // Get data by id
        procedure WriteDataById(id: Integer);

        // Return data by id
        function GetDataById(id: Integer): Integer;

        // Return node by id
        function GetNodeById(id: Integer): nodeptr;

        // Sort List
        procedure Sort();



  end;

implementation

constructor TSinglyList.Create(length: Integer);
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
    second.data := 0;

    // Get ready for loop
    first := second;

    // Create new nodes from 3 to length
    for i := 3 to length do
    begin

      // Initialize new node and set fields
      new(second);
      second.data := 0;
      first.next := second;

      // Get ready for next iteration (t := t + 1)
      first := second;
    end;

    // Set pointers from/to head
    first.next := head;
  end;

  constructor TSinglyList.Create();
  begin
    self.length := 0;
    self.head := nil;
  end;

  procedure TSinglyList.write;
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

  procedure TSinglyList.SetData(id, val:Integer);
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


  procedure TSinglyList.RemoveById(id: Integer);
  var
    el1, el2: nodeptr;
    i: Integer;
  begin

    // Move cursor to desired node
    el1 := self.head;
    for i := 0 to id - 2 do
      el1 := el1^.next;

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

  // Write data on screen by id
  procedure TSinglyList.WriteDataById(id: Integer);
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

  function TSinglyList.GetDataById(id: Integer): Integer;
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

  function TSinglyList.GetNodeById(id: Integer): nodeptr;
  var
    i: Integer;
  begin
    Result := self.head;
    for i := 0 to id - 1 do
      Result := Result.next;
  end;

  procedure TSinglyList.Add(data: Integer);
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
       self.head.next := self.head;
    end
    else
    begin

      node := self.head;
      while(node.next <> self.head) do
        node := node.next;

      node.next := nodeNew;
      nodeNew.next := self.head;

    end;

    self.length := self.length + 1;
  end;

  procedure TSinglyList.Sort();

    procedure Swap(node1, node2: nodeptr);
    var
      data: Integer;
    begin

      data := node1.data;
      node1.data := node2.data;
      node2.data := data;
    end;


  var
    max, node: nodeptr;
    data: Integer;
    i, j: Integer;
  begin

    for i := 0 to self.length - 1 do
    begin
      node := self.GetNodeById(i);
      max := self.GetNodeById(i);
      for j := i to self.length - 1 do
      begin
        node := node.next;
        if (node.data > max.data ) then
          max := node;


      end;

      //Swap(max, self.GetNodeById(i));
      data := self.GetNodeById(i).data;
      self.GetNodeById(i).data := max.data;
      max.data := data;

    end;


  end;

end.
