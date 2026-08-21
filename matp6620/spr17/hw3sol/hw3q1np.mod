#
#
#  node packing model for the given graph
#
#  also include clique constraints in this model
#    for cliques of size 3
#
 
set nodes ordered;
set edges within {nodes,nodes};

param c{nodes} >= 0;

param noh;   # number of odd hole constraints

set oddhole{j in 1..noh} within {nodes};
param rhsoh{j in 1..noh};

#

var x{nodes} >=0, <= 1;

#

maximize weightedsum: sum{i in nodes} c[i] * x[i];

subject to adjacency{(i,j) in edges}: x[i] + x[j] <= 1;

subject to clique3{i in nodes, j in nodes, k in nodes : ord(i) < ord(j)
  && ord(j) < ord(k)
  && (i,j) in edges && (i,k) in edges && (j,k) in edges} :
  x[i] + x[j] + x[k] <= 1;

subject to oddholecon{j in 1..noh}:
  sum{i in oddhole[j]} x[i] <= rhsoh[j];
