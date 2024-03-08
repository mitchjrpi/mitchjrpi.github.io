var x1 binary;
var x2 binary;
var x3 binary;
var x4 binary;
var x12 binary;
var x13 binary;
var x14 binary;
var x23 binary;
var x24 binary;
var x124 binary;
var x134 binary;
var x234 binary;

maximize IPobj: 6*x1 + 5*x2 + 5*x3 + 4*x4 + 2*x12 + 3*x14 + 4*x23 + 4*x24;

minimize con1orig: x13 + x24 + x124 <= 1;
minimize con2orig: 3*x234 + 2*x13 + 5*x134 + 4*x2 <= 6;
minimize con3orig: 5*x1 + 4*x2 + 6*x3 + 4*x4 <= 14;
