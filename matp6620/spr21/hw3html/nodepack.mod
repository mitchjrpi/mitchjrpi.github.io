#
#  generate a random geometric node packing problem
#  and solve the LP relaxation
#
#  also include clique constraints in this model
#
param n = 15;    #  number of nodes
param n2a = (n-1)/2;
param n2 = (n-1)/2 -1;
param n3 = 2;  #floor(n/4);
param n5 = 10;  #4+floor(n/2);

#
#  generate the edges
#
#  vertices are uniformly distributed in the unit square.
#  edges are constructed between close vertices.
#

option randseed 0;

set indset1 within 1..n;
set indset2 within 1..n;


param member;
let member := 1 + floor(Uniform(0,n));
let indset1 := {member};
for {l in 2..n5} {
   let member := 1 + floor(Uniform(0,n));
   for {k in 1..5} {
      if member in indset1 then {
         let member := 1 + floor(Uniform(0,n));
      }
      else {
         let indset1 := indset1 union {member};
         break;
      }
   }
}
         

let member := 1 + floor(Uniform(0,n));
let indset2 := {member};
for {l in 2..n3} {
   let member := 1 + floor(Uniform(0,n));
   for {k in 1..5} {
      if member in indset2 then {
         let member := 1 + floor(Uniform(0,n));
      }
      else {
         let indset2 := indset2 union {member};
         break;
      }
   }
}



set EDGES := {i in 1..n-1, j in i+1..n :
                   (i in indset1 and j=i+4)
                   or
                   (j in indset1 and j+4=i+n)
                   or
                   (i in indset2 and j=i+2)
                   or
                   (j in indset2 and j+2=i+n)
                   or (j=i+1) or (i=1 and j=n)};

#
# generate node values
#
param c{1..n} = 20 + floor(5*Uniform(0,1)), integer;

#

var x{1..n} >=0, <= 1;

#

maximize weightedsum: sum{i in 1..n} c[i] * x[i];

subject to adjacency{(i,j) in EDGES}: x[i] + x[j] <= 1;
