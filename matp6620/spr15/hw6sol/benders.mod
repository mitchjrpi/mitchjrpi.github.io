#
#  based on a Benders decomposition approach for
#  Nemhauser&Wolsey, p427, question 1.
#
#  The structure is:
#
#    min sum c_ij y_ij  +  sum f_j x_j
#    subject to 
#        sum_j  y_ij  =  1  for all i
#        sum_i y_ij - nCust x_j <= 0  for all j
#        y >= 0,  x binary
#
#  NOTE: The example question has max cy - fx. To make it comply
#  with the above format, the sign of each entry of c is changed in
#  the run file.
#
#
#  Subproblem:
#    max  sum_i v_i  +  nCust sum_j x_j u_j
#    subject to
#         v_i + u_j >= c_ij
#         v free,  u <= 0
#
#  The extreme point solutions are denoted (pv^k,pu^k), k in K
#  The extreme rays are denoted (rv^l,ru^l), l in L.
#
#
#  Master problem:
#    min sum f_j x_j  +  z
#    subject to
#         z - nCust sum_j pu^k_j x_j >= sum_i pv^k_i  for k in K
#           - nCust sum_j ru^l_j x_j >= sum_i rv^l_i  for l in L
#             x binary
#
#  i runs from 1 to nCust, j runs from 1 to nFac.
#

param nCust;
param nFac;

param C{1..nCust,1..nFac};

param f{1..nFac};

param nExtPts default 0;
param nExtRays default 0;

param extptu{1..nExtPts,1..nFac};
param extptv{1..nExtPts,1..nCust};

param extrayu{1..nExtRays,1..nFac};
param extrayv{1..nExtRays,1..nCust};
#

var x{1..nFac} binary;
param xbar{1..nFac} default 1;
var z;
var y{1..nCust,1..nFac} >= 0;

var u{1..nFac} <= 0;
var v{1..nCust};
var vabs{1..nCust} >= 0;

#
# subproblem
#
maximize subprobobj: sum{i in 1..nCust} v[i]
      + nCust * sum{j in 1..nFac} xbar[j] * u[j];

subject to subprobcon{i in 1..nCust, j in 1..nFac}: v[i] + u[j] <= C[i,j];

subject to vabs1{i in 1..nCust}: vabs[i] >= v[i];
subject to vabs2{i in 1..nCust}: vabs[i] >= -v[i];

subject to normalize:
   sum{i in 1..nCust} vabs[i] - sum{j in 1..nFac} u[j] <= 100;

#
# master problem
#
minimize MPobj: z + sum{j in 1..nFac} f[j] * x[j];

subject to extptcons{k in 1..nExtPts}:
   z - nCust * sum{j in 1..nFac} extptu[k,j] * x[j]
     >= sum{i in 1..nCust}extptv[k,i]; 

subject to extraycons{k in 1..nExtRays}:
   - nCust * sum{j in 1..nFac} extrayu[k,j] * x[j]
     >= sum{i in 1..nCust}extrayv[k,i]; 

#
# integer programming formulation
#
minimize IPobj: sum{i in 1..nCust, j in 1..nFac} C[i,j]*y[i,j]
   + sum{j in 1..nFac} f[j] * x[j];

subject to meetdemand{i in 1..nCust}: sum{j in 1..nFac} y[i,j] = 1;

subject to use_open_facs{j in 1..nFac}:
   sum{i in 1..nCust} y[i,j] - nCust * x[j] <= 0;
