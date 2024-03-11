#  Model file for a matching problem
#  This is the LP relaxation, with all degree constraints included

set NODES;   #  vertices

set EDGES within NODES cross NODES ;

var x{(u,v) in EDGES} >=0, <= 1;

param c{(u,v) in EDGES};  #  obj fn coefficient

maximize matching: sum{(u,v) in EDGES} c[u,v] * x[u,v];

subject to degree{v in NODES}:
 sum{(u,v) in EDGES} x[u,v] + sum{(v,w) in EDGES} x[v,w]  <=  1;
