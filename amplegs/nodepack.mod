#  Model file for a node packing problem
#  This is the LP relaxation, with all max clique inequalities included

set NODES;   #  number of vertices

param  k;   #  number of max cliques

set clique{i in 1..k} within NODES;  #  lists of the vertices in the cliques

var x{i in NODES} >=0, <= 1;

param c{i in NODES};  #  obj fn coefficient

maximize packing: sum{i in NODES} c[i] * x[i];

subject to maxclique{j in 1..k}:
 sum{i in clique[j]} x[i] <= 1;
