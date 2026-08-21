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

# cut parameters

param ncuts{SCENARIOS} default 0;

param zeta{s in SCENARIOS,EDGES,1..ncuts[s]};
param rhs{s in SCENARIOS,1..ncuts[s]};

#  subproblem parameters

param xMP{EDGES};

# Master Problem variables
var x{(i,j) in EDGES} >= 0, <= capexpUB[i,j]; # how much to increase capacity

var theta{SCENARIOS} >= 0;  #  recourse cost

var masterval >= 0;

#  subproblem variables
var y{EDGES,SCENARIOS} >= 0;  # flows in different scenarios

var z{SINKS,SCENARIOS} >= 0;  # shortfalls in different scenarios

var pi{EDGES} >= 0;  #  variables in dual of subproblem
var sigma{v in SINKS union TRANSS};

var dualobjval;

# Master Problem

minimize cost: masterval;

subject to calc_obj: masterval = sum{(i,j) in EDGES} capexpcost[i,j]*x[i,j]
+ sum{s in SCENARIOS} prob[s] * theta[s];

subject to UBtheta{s in SCENARIOS}:
  theta[s] <=  sum{j in SINKS} shortfallcost[j] *demand[j,s];

subject to cuts{s in SCENARIOS, k in 1..ncuts[s]}:
  sum{(i,j) in EDGES} zeta[s,i,j,k] * x[i,j] + theta[s] >= rhs[s,k];

# subproblem

minimize unmetdemand{s in SCENARIOS}:
  sum{v in SINKS} z[v,s];
  
subject to flowUB{(i,j) in EDGES, s in SCENARIOS}:
  y[i,j,s] <= capacity[i,j] + x[i,j];

subject to shortfall{v in SINKS, s in SCENARIOS}:
  z[v,s] >= demand[v,s] - sum{(u,v) in EDGES} y[u,v,s];

subject to flowconservation{j in TRANSS, s in SCENARIOS}:
  sum{(i,j) in EDGES} y[i,j,s] = sum{(j,k) in EDGES} y[j,k,s];
  
# dual subproblem

maximize dualobj: dualobjval;

subject to dualobjcalc{s in SCENARIOS}: dualobjval =
  - sum{(i,j) in EDGES} (capacity[i,j] + xMP[i,j])*pi[i,j]
  + sum{v in SINKS} demand[v,s] * sigma[v];

subject to dualconssource{(i,j) in EDGES : i in SOURCES && j in SINKS union TRANSS}:
  sigma[j] - pi[i,j] <= 0;
  
subject to dualconsother{(i,j) in EDGES : i in SINKS union TRANSS && j in SINKS union TRANSS}:
  sigma[j] - sigma[i] - pi[i,j] <= 0;
  
subject to sigmaUB{v in SINKS}: sigma[v] <= shortfallcost[v];
  
   
