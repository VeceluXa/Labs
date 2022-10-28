Program Lab_7;

{$APPTYPE CONSOLE}

uses
  System.SysUtils;

Const
  N=10;

Var
  Arr: array[1..N] of Integer;

  i: Integer;

Begin
  // getting array
  for i:=1 to N do
  begin
    Write('Enter element number #', i, ': ');

    Readln(Arr[i]);
  end;

  // insert sort algorithm
  asm
        // i := 1
        // border := 10
        mov ebx, 1
        mov ecx, 10
      @1:
        // while i < border
        cmp ebx, ecx
        jae @2

        // x := Arr[i]
        lea edi, [Arr + ebx*4]
        mov eax, [edi]

        // j := j - 1
        mov edx, ebx
        dec edx
      @3:
        // while j >= 0
        cmp edx, -1
        je @4

        // while A[j] > x
        lea edi, [Arr + edx*4]
        mov ebp, [edi]
        cmp eax, ebp
        jae @4

        // A[j+1] := A[j]
        lea edi, [Arr + edx*4 + 4]
        mov [edi], ebp

        // j := j - 1
        dec edx

        jmp @3

      @4:
        // A[j+1] := x
        Inc edx
        lea edi, [Arr + edx*4]
        mov [edi], eax

        // i := i + 1
        inc ebx
        jmp @1
      @2:
  end;

  // printing array
  Write('Sorted array is: ');
  for i:=1 to 10 do
  begin
    Write(Arr[i], ' ');
  end;

  readln;
End.
