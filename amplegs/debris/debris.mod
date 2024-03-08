#
#  debris removal: enough to get paths through to required sites
#
#  have several origins for paths (both for clearing paths
#  and for delivering supplies)
#
#  have several required destinations, with with its own demand
#
#  graph is directed
#
#  each arc requires its own time to repair
#
#  have limit on amount that can be shipped from any one origin
#
#  have limit on number of origins that can be opened
#
#
#  objective:
#   minimize combination of longest travel time with total debris removal cost
#

set NODES;
set ARCS within (NODES cross NODES) default {};

set ORIGINS within NODES default {};
set DESTINATIONS within NODES default {};
set TRANSHIP = NODES diff (ORIGINS union DESTINATIONS);

param repairtime {ARCS} >= 0;
param traveltime {ARCS} >= 0;

param demand{DESTINATIONS} >= 1;

param capacity >= 1 default 1;   #  same capacity for each origin

param origin_limit >= 1 default 1;  # number of origins that can be opened

param obj_weight >= 0;  # weight for repair time in objective function

#

var open {(i,j) in ARCS} >=0, <=1;
#var open {(i,j) in ARCS} binary;
       #  indicate whether arc (i,j) has been restored

var flow {k in DESTINATIONS, (i,j) in ARCS} >= 0;
       #  proportion of demand for k that flows along (i,j)

var useorigin {i in ORIGINS} >= 0, <= 1;
#var useorigin {i in ORIGINS} binary;
var useorigdest {k in DESTINATIONS, i in ORIGINS} >= 0, <= 1;

var maxdelay >= 0;  # find the maximum delay for any of the destinations

#

minimize objective:
   #maxdelay + obj_weight * sum{(i,j) in ARCS} repairtime[i,j]*open[i,j];
   maxdelay + (1/origin_limit) * sum{(i,j) in ARCS} repairtime[i,j]*open[i,j];

subject to finddelay{k in DESTINATIONS}:
   maxdelay >= sum{(i,j) in ARCS} traveltime[i,j]*flow[k,i,j];

subject to onlyuseopen{(i,j) in ARCS, k in DESTINATIONS}:
   flow[k,i,j] <= open[i,j];

subject to capacitylimit{i in ORIGINS}:
   sum{(i,j) in ARCS, k in DESTINATIONS} demand[k]*flow[k,i,j]
   -  sum{(l,i) in ARCS, k in DESTINATIONS} demand[k]*flow[k,l,i]
   <= capacity*useorigin[i];

subject to openusedorigins{i in ORIGINS, k in DESTINATIONS}:
   useorigin[i] >= useorigdest[k,i];

subject to limitorigins: sum{i in ORIGINS} useorigin[i] <= origin_limit;

subject to flowconservationorigin{i in ORIGINS, k in DESTINATIONS}:
   sum{(i,j) in ARCS} flow[k,i,j]
   = useorigdest[k,i] + sum{(l,i) in ARCS} flow[k,l,i];
   #  origin i can pump in at most a proportion useorigin[i] of the
   #  demand for any destination

subject to flowconservationdest{k in DESTINATIONS}:
   sum{(i,k) in ARCS} flow[k,i,k] = 1;
   #  need to meet demand at destination k

subject to flowconservationdest0{k in DESTINATIONS, (k,l) in ARCS}:
   flow[k,k,l] = 0;
   # material destined for k cannot be shipped back out again

subject to flowconservationtransp{j in TRANSHIP, k in DESTINATIONS}:
   sum {(i,j) in ARCS} flow[k,i,j]
   =  sum{(j,l) in ARCS} flow[k,j,l];
   #  flow conservation at each transshipment point,
   #  for flow destined for each destination

subject to flowconservationotherdest{j in DESTINATIONS, k in DESTINATIONS: j<>k}:
   sum {(i,j) in ARCS} flow[k,i,j]
   =  sum{(j,l) in ARCS} flow[k,j,l];
   #  flow conservation at each other destination j,
   #  for flow destined for each destination k






#
