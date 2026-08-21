#
# a min cost network flow problem.
#
# each arc is directed, with cost and capacity.
# each node can be either a supply node (supply[i]>0),
# a demand node (supply[i]<0), or a
# transshipment node (supply[i]=0).
#
# require flow conservation at the nodes (so net flow out at time t is
# equal to the paramater supply[i,t] ).
#
# have travel times for each arc.
# supplies are available at different times.
# goods need to arrive at destinations before demand time.
#
# note: need to define an arc from a node to itself, so that
# goods can stay at their current point.
#

set NODES;
set ARCS within NODES cross NODES;

param T;  #  time horizon
param cost{(i,j) in ARCS};
param capacity{(i,j) in ARCS} >= 0;
param traveltime{(i,j) in ARCS} >= 0;

param supply{i in NODES, t in 1..T} default 0;
   # positive or negative. Sum is zero

#check: sum{i in NODES, t in 1..T} supply[i,t]=0;

var x{(i,j) in ARCS, t in 1..T} >= 0, <= capacity[i,j];
  # the amount of flow leaving node i at time t
  # and arriving at node j at time t+traveltime[i,j].


minimize objective: sum{(i,j) in ARCS, t in 1..T} cost[i,j] * x[i,j,t];

subject to flowbalance{i in NODES, t in 1..T}:
  sum{(i,j) in ARCS} x[i,j,t]
- sum{(j,i) in ARCS, s in 1..t: t-s=traveltime[j,i] } x[j,i,s] = supply[i,t];
