#
#  given a nonconvex quadratically constrained problem:
#
#    min   c0^Tx + 0.5 x^T Q0 x
#    st    ck^Tx + 0.5 x^T Qk x <= gk,  k=1,...,nQ
#          Ax <= b    (m linear constraints)
#          0 <= x <= e
#
#  set up a convex QP (socp) relaxation.
#
#  The Qk matrices are generated to only have nonzeroes in
#  the top p times p submatrix, off the leading diagonal
#
#  The other variables only show up in the linear parts of the ck's
#                                                  (k=0,1,...nQ)
#
#  In this version, the SOCP constraints are only defined for a
#  subset of the pairs.
#
param n > 0;
param m >= 0;
param nQ > 0;
param p > 0;
param spar := 0.3;  #  sparsity of Q
set PAIRS within {i in 1..p-1,j in 2..p: i<j};
param c0{j in 1..n}:=Uniform(-1,1);   #  objective function
param cmat{k in 1..nQ,j in 1..n}:=Uniform(-1,1); # linear parts of quadratic
                                                 # constraints
param uniQ{i in 1..n-1, j in i+1..n, k in 0..nQ}:= Uniform01();
param Q{i in 1..n-1, j in i+1..n, k in 0..nQ}=
if uniQ[i,j,k] < spar then Uniform(-1,1) else 0; # quadratic parts
#param Q{i in 1..p-1, j in i+1..p, k in 0..nQ}:= Uniform(0,n); # quadratic parts

param xbar{i in 1..n} := 0.2 + 0.6* floor (2*Uniform01());
param g{k in 1..nQ} := 0.1 + sum{j in 1..n} cmat[k,j] * xbar[j]
          + 0.5 * sum{i in 1..p-1, j in i+1..p} Q[i,j,k] * xbar[i] * xbar[j];
#param g{k in 1..nQ} := Uniform(1,100);

param A{k in 1..m,j in 1..n} := Uniform(-1,1);  # linear constraints
param b{k in 1..m} := 0.1 + sum{j in 1..n} A[k,j]*xbar[j];

param UBx{i in 1..n};
param LBx{i in 1..n};

param UB{i in 1..n-1, j in i+1..n};
param LB{i in 1..n-1, j in i+1..n};

param UB13{i in 1..n-1, j in i+1..n};
param LB13{i in 1..n-1, j in i+1..n};

param UB31{i in 1..n-1, j in i+1..n};
param LB31{i in 1..n-1, j in i+1..n};

param UBP{i in 1..n-1, j in i+1..n};
param LBP{i in 1..n-1, j in i+1..n};

param UBP13{i in 1..n-1, j in i+1..n};
param LBP13{i in 1..n-1, j in i+1..n};

param UBP31{i in 1..n-1, j in i+1..n};
param LBP31{i in 1..n-1, j in i+1..n};

param UBobj;

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

minimize optLB13{i in 1..p-1, j in i+1..p}: x[i] - 3* x[j];
maximize optUB13{i in 1..p-1, j in i+1..p}: x[i] - 3* x[j];

minimize optLB31{i in 1..p-1, j in i+1..p}: 3* x[i] - x[j];
maximize optUB31{i in 1..p-1, j in i+1..p}: 3* x[i] - x[j];

minimize optLBP{i in 1..p-1, j in i+1..p}: x[i] + x[j];
maximize optUBP{i in 1..p-1, j in i+1..p}: x[i] + x[j];

minimize optLBP13{i in 1..p-1, j in i+1..p}: x[i] + 3* x[j];
maximize optUBP13{i in 1..p-1, j in i+1..p}: x[i] + 3* x[j];

minimize optLBP31{i in 1..p-1, j in i+1..p}: 3* x[i] + x[j];
maximize optUBP31{i in 1..p-1, j in i+1..p}: 3* x[i] + x[j];

subject to cQ{k in 1..nQ}:
  sum{j in 1..n} cmat[k,j]*x[j] +
  0.5 * sum{i in 1..p-1, j in i+1..p} Q[i,j,k] *x[i] * x[j] <= g[k];

subject to lincon{k in 1..m}:
  sum{j in 1..n} A[k,j]*x[j] <= b[k];

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

subject to soc{(i,j) in PAIRS}:
  (x[i] + x[j])^2 <= 4*w[i,j] + (UB[i,j]+LB[i,j])*(x[i]-x[j])
  - UB[i,j] * LB[i,j];

subject to soc13{(i,j) in PAIRS}:
  (x[i] + 3*x[j])^2 <= 12*w[i,j] + (UB13[i,j]+LB13[i,j])*(x[i]-3*x[j])
  - UB13[i,j] * LB13[i,j];

subject to soc31{(i,j) in PAIRS}:
  (3*x[i] + x[j])^2 <= 12*w[i,j] + (UB31[i,j]+LB31[i,j])*(3*x[i]-x[j])
  - UB31[i,j] * LB31[i,j];

subject to socP{(i,j) in PAIRS}:
  (x[i] - x[j])^2 <= -4*w[i,j] + (UBP[i,j]+LBP[i,j])*(x[i]+x[j])
  - UBP[i,j] * LBP[i,j];

subject to socP13{(i,j) in PAIRS}:
  (x[i] - 3*x[j])^2 <= -12*w[i,j] + (UBP13[i,j]+LBP13[i,j])*(x[i]+3*x[j])
  - UBP13[i,j] * LBP13[i,j];

subject to socP31{(i,j) in PAIRS}:
  (3*x[i] - x[j])^2 <= -12*w[i,j] + (UBP31[i,j]+LBP31[i,j])*(3*x[i]+x[j])
  - UBP31[i,j] * LBP31[i,j];

subject to bound_obj:  sum{j in 1..n} c0[j] * x[j] 
  + 0.5 * sum{i in 1..p-1, j in i+1..p} Q[i,j,0] *w[i,j] <= UBobj;
