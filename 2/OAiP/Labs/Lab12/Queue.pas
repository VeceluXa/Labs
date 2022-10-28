unit Queue;

interface

// Types declaration
type
  ptr = ^myQueue;

  myQueue = record
    data: real;
    next: ptr;
  end;
  { ptr - record thats is used as a queue }

// Procedures and functions declaration
procedure create(var head: ptr);
procedure push(var head: ptr; const x: real);
function pop(var head: ptr): real;
function top(var head: ptr): real;
function empty(var head: ptr): Boolean;
procedure makeNull(var head: ptr);

implementation

// Procedure to create queue
procedure create(var head: ptr);
begin
  head := nil;
end;

// Procedure to push element to the queue
procedure push(var head: ptr; const x: real);
var
  tmpEl, tmpEl2: ptr;
begin
  new(tmpEl);
  tmpEl.data := x;
  tmpEl.next := nil;

  if head = nil then
  begin
    head := tmpEl;
    exit;
  end;

  tmpEl2 := head;
  while tmpEl2.next <> nil do
    tmpEl2 := tmpEl2.next;
  tmpEl2.next := tmpEl;
end;

// Procedure to pop element from the queue
function pop(var head: ptr): real;
var
  tmpEl: ptr;
begin
  result := head^.data;
  tmpEl := head;
  head := head^.next;
  dispose(tmpEl);
end;

// Procedure to get the top element of the stack
function top(var head: ptr): real;
begin
  result := head^.data;
end;

// Function to check if the queue is empty
function empty(var head: ptr): Boolean;
begin
  result := (head = nil);
end;

// Function to null the queue
procedure makeNull(var head: ptr);
begin
  while not empty(head) do
    pop(head);
end;

end.
