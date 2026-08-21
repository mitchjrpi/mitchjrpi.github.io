var x1 >= 0;
var x2 >= 0;

maximize IPobj: 2*x1 + 5*x2;
maximize obj2: x2;

subject to con1: 4*x1 + x2 <= 28;
subject to con2: x1 + 4*x2 <= 27;
subject to con3: x1 - x2 <= 1;

subject to con2q: x2 <= 6;
