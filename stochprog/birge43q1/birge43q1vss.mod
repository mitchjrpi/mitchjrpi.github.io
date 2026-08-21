# This model takes the solution to the deterministic version
# and calculates its value in the expected version.
# x,y is the solution to the deterministic version,
# z is the number of seats we can actually sell based on the demand.

set TICKETCLASSES;
set SCENARIOS;

var z{p in TICKETCLASSES, s in SCENARIOS} >= 0;

param x{p in TICKETCLASSES} >= 0;
param y{p in TICKETCLASSES, s in SCENARIOS} >= 0;

param profit{p in TICKETCLASSES} >= 0;
param spaceuse{p in TICKETCLASSES} >= 0;
param demand{p in TICKETCLASSES, s in SCENARIOS} >= 0;
param planesize >= 0;


maximize revenue: (1/3) * sum{p in TICKETCLASSES, s in SCENARIOS}
   profit[p] * z[p,s];

subject to scenariolimit{p in TICKETCLASSES, s in SCENARIOS}:
   z[p,s] <= demand[p,s];

subject to ysolution{p in TICKETCLASSES, s in SCENARIOS}:
   z[p,s] <= y[p,s];
