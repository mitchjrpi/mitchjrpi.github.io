set MACHINE;
set PRODUCT;

var P{p in PRODUCT} >= 0;
var X{m in MACHINE, p in PRODUCT} >= 0;
var TOTAL>=0;

param table{m in MACHINE, p in PRODUCT} >= 0;


maximize production: TOTAL;

subject to findtot: TOTAL = sum{p in PRODUCT} P[p];

subject to balance1: P['p1'] = 0.5*TOTAL;
subject to balance2: P['p2'] = 0.25*TOTAL;
subject to balance3: P['p3'] = 0.25*TOTAL;

subject to definitions {p in PRODUCT}:
     P[p]=sum{j in MACHINE} table[j,p]*X[j,p];

subject to conservation {m in MACHINE}:
     sum{p in PRODUCT} X[m,p] <= 1;
