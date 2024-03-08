# network capacity expansion
#
# assume sources can produce any amount.
#
# have a set of sinks with stochastic demands.
#
# can make capacity expansions on arcs at a cost
#
# have a shortfall cost for failing to meet demands.
#
set SOURCES;
set SINKS;
set TRANSS;   #  transshipment nodes
set NODES = SOURCES union SINKS union TRANSS;
set EDGES within {NODES,NODES};

param nS >= 0;

set SCENARIOS default {};

param demand{SINKS,SCENARIOS} >= 0;   # demand depends on scenario
param shortfallcost{SINKS} >= 0;      # per unit cost for unmet demand

param capacity{EDGES};    # initial capacity of edges
param capexpUB{EDGES};    # upper bound on possible capacity expansion
param capexpcost{EDGES};  # cost per unit expansion of capacity

param prob{SCENARIOS} >= 0;  # probabilities of scenarios

var x{(i,j) in EDGES} >= 0, <= capexpUB[i,j]; # how much to increase capacity

var y{EDGES,SCENARIOS} >= 0;  # flows in different scenarios

var z{SINKS,SCENARIOS} >= 0;  # shortfalls in different scenarios

#

minimize cost: sum{(i,j) in EDGES} capexpcost[i,j]*x[i,j]
+ sum{s in SCENARIOS} prob[s] * (sum{v in SINKS} shortfallcost[v]*z[v,s]);

subject to flowUB{(i,j) in EDGES, s in SCENARIOS}:
  y[i,j,s] <= capacity[i,j] + x[i,j];

subject to shortfall{v in SINKS, s in SCENARIOS}:
  z[v,s] >= demand[v,s] - sum{(u,v) in EDGES} y[u,v,s];

subject to flowconservation{j in TRANSS, s in SCENARIOS}:
  sum{(i,j) in EDGES} y[i,j,s] = sum{(j,k) in EDGES} y[j,k,s];
