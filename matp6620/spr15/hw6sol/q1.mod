var x1 >= 0;
var x2 >= 0;
var x3 >= 0;
param lambda >= 0, default 1;

minimize IPobj: 7*x1 + 6*x2 + 2*x3;

minimize LR1obj: 7*x1 + 6*x2 + 2*x3 + lambda * (5-3*x1-3*x2-x3);
minimize LR2obj: 7*x1 + 6*x2 + 2*x3 + lambda * (4-3*x1-x2-2*x3);

subject to con1: 3*x1 + 3*x2 + x3 >= 5;
subject to con2: 3*x1 + x2 + 2*x3 >= 4;

subject to l2q1: 2*x1 + x2 + 2*x3 >= 4;
subject to l2q2: x1 + x2 + x3 >= 2;

subject to l1q1: 2*x1 + 2*x2 + x3 >= 4;
