#
#  given a nonconvex quadratically constrained problem:
#
#    min   c0^Tx + 0.5 x^T Q0 x
#    st    ck^Tx + 0.5 x^T Qk x <= gk,  k=1,...,nQ
#          -0.5 <= xi - xj <= 0.5
#          0.5 <= xi+xj <= 1.5    (n(n-1) linear constraints)
#          0 <= x <= e
#
#  set up a convex QP (socp) relaxation.
#
#  The Qk matrices are generated to only have nonzeroes in
#  the top p times p submatrix, off the leading diagonal
#  NOTE: for these problems, take p=n. Smaller values of
#  p don't really make sense.
#
#
#  The other variables only show up in the linear parts of the ck's
#                                                  (k=0,1,...nQ)
#
param n > 0;
param m >= 0;
param nQ > 0;
param p := n;
param c0{j in 1..n}:=Uniform(-1,1);   #  objective function
param cmat{k in 1..nQ,j in 1..n}:=Uniform(-1,1); # linear parts of quadratic
                                                 # constraints
param Q{i in 1..n-1, j in i+1..n, k in 0..nQ}:= Uniform(-1,1); # quadratic parts
#param Q{i in 1..p-1, j in i+1..p, k in 0..nQ}:= Uniform(0,n); # quadratic parts

param feasval := 0.5;  #  make xj=feasval for all j feasible.
param g{k in 1..nQ} := 0.1 + feasval*sum{j in 1..n} cmat[k,j]
          + 0.5 * feasval * feasval * sum{i in 1..p-1, j in i+1..p} Q[i,j,k];
param UBobj := feasval*sum{j in 1..n} c0[j]
          + 0.5 * feasval * feasval * sum{i in 1..p-1, j in i+1..p} Q[i,j,0];

#param g{k in 1..nQ} := Uniform(1,100); # only use this for small
                                        # values of n, where knitro
                                        # license limits allow

param UBx{i in 1..n};
param LBx{i in 1..n};

param UB{i in 1..n-1, j in i+1..n};
param LB{i in 1..n-1, j in i+1..n};

param UBP{i in 1..n-1, j in i+1..n};
param LBP{i in 1..n-1, j in i+1..n};

var x{j in 1..n} >=0, <= 1;

var w{i in 1..p-1, j in i+1..p} >= 0;

#
#let p:= n;

minimize c0obj: sum{j in 1..n} c0[j] * x[j]
  + 0.5 * sum{i in 1..p-1, j in i+1..p} Q[i,j,0] *x[i] * x[j];

minimize c0objlin: sum{j in 1..n} c0[j] * x[j]
  + 0.5 * sum{i in 1..p-1, j in i+1..p} Q[i,j,0] *w[i,j];

minimize optLBx{i in 1..p}: x[i];
maximize optUBx{i in 1..p}: x[i];

minimize optLB{i in 1..p-1, j in i+1..p}: x[i] - x[j];
maximize optUB{i in 1..p-1, j in i+1..p}: x[i] - x[j];

minimize optLBP{i in 1..p-1, j in i+1..p}: x[i] + x[j];
maximize optUBP{i in 1..p-1, j in i+1..p}: x[i] + x[j];

subject to cQ{k in 1..nQ}:
  sum{j in 1..n} cmat[k,j]*x[j] +
  0.5 * sum{i in 1..p-1, j in i+1..p} Q[i,j,k] *x[i] * x[j] <= g[k];

subject to conLBP{i in 1..n-1, j in i+1..n}:
  x[i] + x[j] >= 0.5;

subject to conUBP{i in 1..n-1, j in i+1..n}:
  x[i] + x[j] <= 1.5;

subject to conLBM{i in 1..n-1, j in i+1..n}:
  x[i] - x[j] >= -0.5;

subject to conUBM{i in 1..n-1, j in i+1..n}:
  x[i] - x[j] <= 0.5;

subject to cQlin{k in 1..nQ}:
  sum{j in 1..n} cmat[k,j]*x[j] +
  0.5 * sum{i in 1..p-1, j in i+1..p} Q[i,j,k] * w[i,j] <= g[k];

subject to McCormicka{i in 1..p-1, j in i+1..p}: w[i,j] >= x[i] + x[j] - 1;
subject to McCormickb{i in 1..p-1, j in i+1..p}: w[i,j] <= x[i];
subject to McCormickc{i in 1..p-1, j in i+1..p}: w[i,j] <= x[j];

subject to McCormickaB{i in 1..p-1, j in i+1..p}:
  w[i,j] >= UBx[j]*x[i] + UBx[i]*x[j] - UBx[i]*UBx[j];
subject to McCormickbB{i in 1..p-1, j in i+1..p}:
  w[i,j] <= UBx[j]*x[i] + LBx[i]*x[j] - UBx[j]*LBx[i];
subject to McCormickcB{i in 1..p-1, j in i+1..p}:
  w[i,j] <= LBx[j]*x[i] + UBx[i]*x[j] - LBx[j]*UBx[i];
subject to McCormickdB{i in 1..p-1, j in i+1..p}:
  w[i,j] >= LBx[j]*x[i] + LBx[i]*x[j] - LBx[i]*LBx[j];

subject to soc{i in 1..p-1, j in i+1..p}:
  (x[i] + x[j])^2 <= 4*w[i,j] + (UB[i,j]+LB[i,j])*(x[i]-x[j])
  - UB[i,j] * LB[i,j];

subject to socP{i in 1..p-1, j in i+1..p}:
  (x[i] - x[j])^2 <= -4*w[i,j] + (UBP[i,j]+LBP[i,j])*(x[i]+x[j])
  - UBP[i,j] * LBP[i,j];

subject to bound_obj:  sum{j in 1..n} c0[j] * x[j] 
  + 0.5 * sum{i in 1..p-1, j in i+1..p} Q[i,j,0] *w[i,j] <= UBobj;
