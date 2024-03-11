set YARN;
set COMPANIES;
set OUTSIDE within COMPANIES;

var produce {YARN,COMPANIES} >= 0;

param batchsize;
param switchcost;

param demand {YARN} >= 0;

param capacity {COMPANIES} >= 0;

param machinehours {YARN, COMPANIES} >= 0;

param distance {COMPANIES}  >= 0;
param transportcost {YARN} >= 0;

param productioncost {YARN, COMPANIES} >= 0;

minimize costs:
  sum{i in YARN, j in COMPANIES}
( distance[j]*transportcost[i] + productioncost [i,j] ) *  produce[i,j];

subject to meetdemand{i in YARN}:
  sum {j in COMPANIES} produce[i,j] = demand[i];

subject to capacityconstraint {j in COMPANIES}:
  sum {i in YARN} machinehours[i,j] * produce[i,j] <= capacity[j];
