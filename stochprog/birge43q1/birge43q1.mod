set TICKETCLASSES;
set SCENARIOS;

var x{p in TICKETCLASSES} >= 0;
var y{p in TICKETCLASSES, s in SCENARIOS} >= 0;

param profit{p in TICKETCLASSES} >= 0;
param spaceuse{p in TICKETCLASSES} >= 0;
param demand{p in TICKETCLASSES, s in SCENARIOS} >= 0;
param planesize >= 0;


maximize revenue: (1/3) * sum{p in TICKETCLASSES, s in SCENARIOS}
   profit[p] * y[p,s];

subject to spacelimit: sum{p in TICKETCLASSES}
   spaceuse[p] * x[p] <= planesize;

subject to tixlessthanseats{p in TICKETCLASSES, s in SCENARIOS}:
   y[p,s] <= x[p];

subject to scenariolimit{p in TICKETCLASSES, s in SCENARIOS}:
   y[p,s] <= demand[p,s];
