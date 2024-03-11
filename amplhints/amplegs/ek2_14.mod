set MACHINE;
set PRODUCT;

var x{p in PRODUCT} >= 0;
var TOTAL>=0;

param r{p in PRODUCT, m in MACHINE} >= 0;
param c{m in MACHINE} >= 0;



maximize production: TOTAL;

subject to findtot: TOTAL = sum{p in PRODUCT} x[p];

subject to capacity {m in MACHINE}:
     sum{p in PRODUCT} r[p,m] * x[p] <= c[m];

subject to balance: x['p1'] >= TOTAL/3;
