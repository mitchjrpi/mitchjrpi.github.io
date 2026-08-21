#  Model file for a clustering problem.
#  This is the LP relaxation.
#
#  The construction of the problem is random, and is designed so that
#  the LP relaxation is not optimal to the clustering problem,
#  and it is likely that adding triangle inequalities is sufficient.
#
# empirically, the triangle inequalities suffice for approximately:
#    100% of problems with n=7
#     97% of problems with n=8
#     95% of problems with n=10
#     90% of problems with n=12.
#
#  There are n vertices. The construction forces n-3 of the edge
#  weights to equal 1 and the rest to equal -1.
#
#  Further, no more than two edges incident to any vertex have positive
#  weight,
#  and every cycle of length 3 contains at least one edge of negative
#  length.


param  n := 10;    #  number of observations

option randseed 1936458999;

#  var x{edges};
var x{i in 1..n-1, j in i+1..n} >= 0, <=1;  # 0-1 variable indicating if
                                            # i and j in same cluster
#

param nedge := (n*(n-1))/ 2;
param npos := n-3;
param countrow{i in 1..n};
for {i in 1..n} {
  let countrow[i] := 0;
}
set posset within 1..nedge;
param member;

param nn;
let nn:= 0;
param indexi{1..nedge};
param indexj{1..nedge};
param indexij{i in 1..n-1, j in i+1..n};
for {i in 1..n-1} {
  for {j in i+1..n} {
     let nn := nn+1;
     let indexi[nn]:=i;
     let indexj[nn]:=j;
     let indexij[i,j]:=nn;
  }
}

let member := 1 + floor(Uniform(0,nedge));
let countrow[indexi[member]] := 1;
let countrow[indexj[member]] := 1;

let posset := {member};
param maketri;
param ii;
param jj;
for {l in 2..npos} {
   let member := 1 + floor(Uniform(0,nedge));
   for {k in 1..50} {
      if member in posset or (countrow[indexi[member]] > 1)
           or (countrow[indexj[member]] > 1)
         then {
         let member := 1 + floor(Uniform(0,nedge));
      }
      else {
         let ii:= indexi[member];
         let jj:= indexj[member];
         let maketri := 0;
         for {kk in 1..ii-1} {
           if indexij[kk,ii] in posset and indexij[kk,jj] in posset then {
               let maketri := 1;
           }
         }
         for {kk in ii+1..jj-1} {
           if indexij[ii,kk] in posset and indexij[kk,jj] in posset then {
               let maketri := 1;
           }
         }
         for {kk in jj+1..n} {
           if indexij[ii,kk] in posset and indexij[jj,kk] in posset then {
               let maketri := 1;
           }
         }
         if maketri = 0 then {
           let posset := posset union {member};
           let countrow[indexi[member]] := countrow[indexi[member]] + 1;
           let countrow[indexj[member]] := countrow[indexj[member]] + 1;
           break;
         }
         else {
           let member := 1 + floor(Uniform(0,nedge));
         }
      }
   }
}

param w{i in 1..n-1, j in i+1..n};
     # benefit of having i and j in same cluster.
param index;

for {i in 1..n-1} {
  for {j in i+1..n} {
    if indexij[i,j] in posset then {
      let w[i,j] := 1;
    }
    else {
      let w[i,j] := -1;
    }
  }
}

#

display w;

maximize cluster: sum{i in 1..n-1, j in i+1..n: j>i} w[i,j]*x[i,j];
