#
#  given a bilevel problem
#
#    min  c^Tx + d^Tw
#    st   Bw >= b
#         0 <= w <= u
#          x in argmin_x { 0.5x^Tx + w^Tx : Hx >= g}
#
#  LPCC formulation: (equiv since lower level obj coercive)
#
#    min  c^Tx + d^Tw
#    st   Bw >= b
#         0 <= w <= u
#         x + w - H^T y = 0
#         0 <= y \perp Hx - g >= 0
#
#  nonconvex QCQP formulation:
#         
#    min  c^Tx + d^Tw
#    st   Bw >= b
#         0 <= w <= u
#         x + w - ytilde = 0
#         H^Ty - ytilde = 0
#         0 <= y,  Hx - g >= 0
#         ytilde^T x - g^T y <= 0
#
# lifted variable formulation, with our constraints:
#
#    min  c^Tx + d^Tw
#    st   Bw >= b
#         0 <= w <= u
#         x + w - ytilde = 0
#         H^Ty - ytilde = 0
#         0 <= y,  Hx - g >= 0
#         e^T sigma - g^T y <= 0
#         (ytilde+x)_i^2 <= 4 sigma_i + u_i (ytilde-x)_i
#
# note that McCormick constraints are not available without doing
# a bunch of work to find bounds, since we don't have bounds
# on either x or y (or ytilde).
#
#
param n > 0;   # dimension of x  (small)
param bdim >= 0;  # dimension of b
param gdim >= 0;  # dimension of g

param d{j in 1..n}:=floor(Uniform(-10,5));   #  objective function
param c{j in 1..n}:=floor(Uniform(-10,10));   #  objective function

param u{j in 1..n} = 1;

param B{i in 1..bdim,j in 1..n}=floor(Uniform(-5,6)) ; # 

param H{i in 1..gdim,j in 1..n}=floor(Uniform(2,6)) ; # 
#param H{i in 1..gdim,j in 1..n}=floor(Uniform(-5,6)) ; # 

#
# now ensure feasibility
#
param xbar{i in 1..n} = 1;
param wbar{i in 1..n} = 0.5 * u[i];
param wfix{i in 1..n};
  #  make sure xbar,wbar is feasible.

param bbar{i in 1..bdim} = sum{k in 1..n} B[i,k]*wbar[k];
param gbar{i in 1..gdim} = sum{j in 1..n} H[i,j]* xbar[j];

param b{i in 1..bdim} = bbar[i] - 0.5;
param g{i in 1..gdim} = gbar[i] - 1;
#param b{i in 1..bdim} = bbar[i] - floor(Uniform(1,4));
#param g{i in 1..gdim} = gbar[i] - floor(Uniform(1,4));
#

var x{j in 1..n};
var w{j in 1..n} >= 0, <= u[j];

var y{j in 1..gdim} >= 0;
var ytilde{j in 1..n};

var sigma{j in 1..n};
#

minimize bilevelobj: sum{i in 1..n} (c[i] * x[i] + d[i]*w[i]);

minimize innerQPobj: sum{i in 1..n} x[i]*(0.5*x[i]+wfix[i]);

subject to bcon{i in 1..bdim}:
  sum{k in 1..n} B[i,k]*w[k]  >= b[i];

subject to gcon{i in 1..gdim}:
  sum{j in 1..n} H[i,j]*x[j] >= g[i];

subject to def_ytilde{i in 1..n}:
  ytilde[i] = sum{j in 1..gdim} H[j,i]*y[j];

subject to KKTgrad{i in 1..n}:
  x[i] + w[i] - ytilde[i] = 0;

subject to lifted:
  sum{i in 1..n} sigma[i] - sum{j in 1..gdim} g[j]*y[j] <= 0;

subject to quadcon{i in 1..n}:
  (x[i] + ytilde[i])^2 <= 4*sigma[i] + u[i]*(ytilde[i]-x[i]);

subject to unlifted:
  sum{i in 1..n} x[i]*ytilde[i] - sum{j in 1..gdim} g[j]*y[j] <= 0;

option ipopt_options "max_iter=300";
