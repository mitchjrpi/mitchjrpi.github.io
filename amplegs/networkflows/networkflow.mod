#
# a min cost network flow problem.
#
# each arc is directed, with cost and capacity.
# each node can be either a supply node (supply[i]>0),
# a demand node (supply[i]<0), or a
# transshipment node (supply[i]=0).
#
# require flow conservation at the nodes (so net flow out is
# equal to the paramater supply[i] ).
#

set NODES;
set ARCS within NODES cross NODES;

param cost{(i,j) in ARCS};
param capacity{(i,j) in ARCS} >= 0;
param supply{i in NODES};  # positive or negative. Sum is zero

check: sum{i in NODES} supply[i]=0;

var x{(i,j) in ARCS} >= 0, <= capacity[i,j];


minimize objective: sum{(i,j) in ARCS} cost[i,j] * x[i,j];

subject to flowbalance{i in NODES}:
  sum{(i,j) in ARCS} x[i,j] - sum{(j,i) in ARCS} x[j,i] = supply[i];
