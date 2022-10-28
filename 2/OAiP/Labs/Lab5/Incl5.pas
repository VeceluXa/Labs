inputMatrix(A);
  inputMatrix(B);

  // Output A
  writeln('A:');
  writeMatrix(A);
  writeln;

  // Output B
  writeln('B:');
  writeMatrix(B);

  // Output expression
  writeln;
  writeln('A^2 - (A + B)*(A - 3*B) =');

  // Perform calculations
  // (A^2)
  Temp1 := multiplyMatrix(A,A);

  // (A + B)
  Temp2 := sumMatrix(A,B,true);

  // (3*B)
  Temp3 := multiplyMatrix(B,3);

  // (A - 3*B)
  Temp3 := sumMatrix(A,Temp3,false);

  // (A + B)*(A - 3*B)
  Temp2 := multiplyMatrix(Temp2,Temp3);

  // A^2 - (A + B)*(A - 3*B)
  Temp1 := sumMatrix(Temp1,Temp2,false);

  // Output result
  writeMatrix(Temp1);

  // Stop console from closing
  readln;