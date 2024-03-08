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

set SCENARIOS;

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
