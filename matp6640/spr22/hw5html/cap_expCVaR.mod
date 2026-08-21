# network capacity expansion
#
# assume a single source, can produce any amount.
#
# have a set of sinks with stochastic demands.
#
# can make capacity expansions at a cost
#
# have a cost for failing to meet demands.
#
set SOURCES;
set SINKS;
set TRANSS;
set NODES = SOURCES union SINKS union TRANSS;
set EDGES within {NODES,NODES};

set SCENARIOS;

param nS >= 0;

param demand{SINKS,SCENARIOS} >= 0;
param shortfallcost{SINKS} >= 0;

param capacity{EDGES};
param capexpUB{EDGES};
param capexpcost{EDGES};

param prob{SCENARIOS} >= 0;

#
param alpha >=0, <= 1;
param cost_bound;
#

var x{(i,j) in EDGES} >= 0, <= capexpUB[i,j]; # how much to increase capacity

var y{EDGES,SCENARIOS} >= 0;  # flows in different scenarios

var z{SINKS,SCENARIOS} >= 0;  # shortfalls in different scenarios

#
var eta;
var value{SCENARIOS} >= 0;
#

minimize cominedcost: sum{(i,j) in EDGES} capexpcost[i,j]*x[i,j]
  + sum{s in SCENARIOS} prob[s] * (sum{v in SINKS} shortfallcost[v]*z[v,s])
  + 0.1*(eta + (sum{s in SCENARIOS} prob[s]*value[s]) / alpha);

subject to calc_v{s in SCENARIOS}:
  value[s] >= sum{v in SINKS} shortfallcost[v]*z[v,s] - eta;

#subject to expected_cost: sum{(i,j) in EDGES} capexpcost[i,j]*x[i,j]
#+ sum{s in SCENARIOS} prob[s] * (sum{v in SINKS} shortfallcost[v]*z[v,s])
#<= cost_bound;

subject to flowUB{(i,j) in EDGES, s in SCENARIOS}:
  y[i,j,s] <= capacity[i,j] + x[i,j];

subject to shortfall{v in SINKS, s in SCENARIOS}:
  z[v,s] >= demand[v,s] - sum{(u,v) in EDGES} y[u,v,s];

subject to flowconservation{j in TRANSS, s in SCENARIOS}:
  sum{(i,j) in EDGES} y[i,j,s] = sum{(j,k) in EDGES} y[j,k,s];
