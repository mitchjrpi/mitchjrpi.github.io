#
#  Use the Richard and Tawarmalani lifting to give a tighter
#  LP relaxation to an LPCC
#
#  This requires multiplying each constraint by new variables
#  f_i and fbar_i and then linearizing
#
#  The understanding is f_i=y_i / (y_i+w_i) and fbar_i = 1-f_i
#  (with f_i=0 if y_i+w_i=0)
#
#  With this understanding, we can exploit products.
#
#  Eg:   y_if_i = y_i,  y_i fbar_i = 0, etc.
#
#  given an LPCC
#
#    min  c^Tx + d^Ty
#    st   Ax + By >= b
#          x >= 0
#         0 <= y  perp  w := q + Nx + My >= 0
#
#  with Mt := (M+M^T)/2 psd and x of low dimension.
#
#
#  A, B, N randomly generated to be sparse.
#  Mt generated as L L^T where L is a tall skinny sparse matrix.
#  M constructed by unsymmetrizing Mt.
#  c, d nonnegative to ensure boundedness.
#  To ensure feasibility, a solution yb, xb is generated and then
#  b and q are constructed so that this solution is feasible.
#
#
param n > 0;   # dimension of x  (small)
param m > 0;   # dimension of y  (larger)  Must be even.
param bdim >= 0;  # dimension of b
param Mrank >= 0;  # rank of M (no larger than m)
param spar >=0, <= 1;  #  sparsity of A, B, N, L

param c{j in 1..n}:=floor(Uniform(0,10));   #  objective function
param d{j in 1..m}:=floor(Uniform(0,10));   #  objective function

param uniA{i in 1..bdim, j in 1..n} = Uniform01();
param A{i in 1..bdim,j in 1..n}=
if uniA[i,j] < spar then floor(Uniform(-5,6)) else 0; # 

param uniB{i in 1..bdim, j in 1..m} = Uniform01();
param B{i in 1..bdim,j in 1..m}=
if uniB[i,j] < spar then floor(Uniform(-5,6)) else 0; # 

param uniN{i in 1..m, j in 1..n} = Uniform01();
param N{i in 1..m,j in 1..n}=
if uniN[i,j] < spar then floor(Uniform(-5,6)) else 0; # 

param uniL{i in 1..m, j in 1..Mrank} = Uniform01();
param L{i in 1..m,j in 1..Mrank}=
if uniL[i,j] < spar then floor(Uniform(-5,6)) else 0; # 

param Mt{i in 1..m, j in 1..m} = sum{k in 1..Mrank} L[i,k]*L[j,k];
               #  symmetric version of M
param Mdelta{i in 1..m-1, j in i+1..m} = floor(Uniform(-2,3));
param M{i in 1..m, j in 1..m} =
if abs(Mt[i,j]) = 0 then 0
  else if i=j then Mt[i,j]
    else if i<j then Mt[i,j] + Mdelta[i,j]
      else Mt[i,j] - Mdelta[j,i];
               #  final version of M

#
# check M is correct
#
#param Mdiag{i in 1..m} = M[i,i];
#param MMT{i in 1..m-1, j in i+1..m} = (M[i,j]+M[j,i])/2;

#param Mdiagdiff{i in 1..m} = Mdiag[i] - Mt[i,i];
#param Mdiff{i in 1..m-1, j in i+1..m} = MMT[i,j]-Mt[i,j];


#
# now ensure feasibility
#
param ybar{i in 1..m} =
  if i < m/3 then floor(Uniform(0,10)) else 0;
param xbar{i in 1..n} = floor(Uniform(0,10));
  #  make sure xbar and ybar are feasible.

param UBbar := sum{j in 1..n} c[j]*xbar[j] + sum{k in 1..m} d[k]*ybar[k];

param qbar{i in 1..m} = -sum{j in 1..n} N[i,j]*xbar[j]
  - sum{k in 1..m} M[i,k]*ybar[k];

param bbar{i in 1..bdim} = sum{j in 1..n} A[i,j]* xbar[j]
  + sum{k in 1..m} B[i,k]*ybar[k];

param q{i in 1..m} =
  #if i < m/2 then qbar[i] else qbar[i]+floor(Uniform(0,3));
  if i < (2*m)/3 then qbar[i] else qbar[i]+floor(Uniform(1,11));

#param b{i in 1..bdim} = bbar[i] - floor(Uniform(0,3));
param b{i in 1..bdim} = bbar[i] - floor(Uniform(1,11));
#

var x{j in 1..n} >=0;

var y{i in 1..m} >= 0, <= 100;
var w{i in 1..m} >= 0, <= 100;

var z{i in 1..m} binary;

var f{i in 1..m} >= 0;
var fbar{i in 1..m} >= 0;

set LIFTS within {1..m} default {};

var xf{j in 1..n,i in 1..m} >= 0;   #  should equal x[j]*f[i]
var xfbar{j in 1..n,i in 1..m} >= 0;   #  should equal x[j]*fbar[i]

var yf{j in 1..m,i in 1..m} >= 0;   #  should equal y[j]*f[i]
var yfbar{j in 1..m,i in 1..m} >= 0;   #  should equal y[j]*fbar[i]

var wf{j in 1..m,i in 1..m} >= 0;   #  should equal w[j]*f[i]
var wfbar{j in 1..m,i in 1..m} >= 0;   #  should equal w[j]*fbar[i]

#

minimize LPCCobj: sum{i in 1..n} c[i] * x[i]
  + sum{j in 1..m} d[j] * y[j];



subject to bcon{i in 1..bdim}:
  sum{j in 1..n} A[i,j]*x[j] + sum{k in 1..m} B[i,k]*y[k] >= b[i];

subject to qcon{i in 1..m}:
  q[i] + sum{j in 1..n} N[i,j]*x[j] + sum{k in 1..m} M[i,k]*y[k] = w[i];

#subject to complementarity:
#  sum{j in 1..m} w[j]*y[j] <= 0;   #  nonconvex quadratic version

subject to yz{i in 1..m}: y[i] <= 100*z[i];
subject to wz{i in 1..m}: w[i] <= 100*(1-z[i]);


subject to bconf{i in 1..bdim, l in 1..m}:
  sum{j in 1..n} A[i,j]*xf[j,l] + sum{k in 1..m} B[i,k]*yf[k,l] >= b[i]*f[l];

subject to bconfbar{i in 1..bdim, l in 1..m}:
  sum{j in 1..n} A[i,j]*xfbar[j,l] + sum{k in 1..m} B[i,k]*yfbar[k,l]
   >= b[i]*fbar[l];

subject to qconf{i in 1..m, l in 1..m}:
  q[i]*f[l] + sum{j in 1..n} N[i,j]*xf[j,l] + sum{k in 1..m} M[i,k]*yf[k,l]
   = wf[i,l];

subject to qconfbar{i in 1..m, l in 1..m}:
  q[i]*fbar[l] + sum{j in 1..n} N[i,j]*xfbar[j,l]
     + sum{k in 1..m} M[i,k]*yfbar[k,l] = wfbar[i,l];

#
#  only impose the lifts for selected variables
#

subject to bconfl{i in 1..bdim, l in LIFTS}:
  sum{j in 1..n} A[i,j]*xf[j,l] + sum{k in 1..m} B[i,k]*yf[k,l] >= b[i]*f[l];

subject to bconfbarl{i in 1..bdim, l in LIFTS}:
  sum{j in 1..n} A[i,j]*xfbar[j,l] + sum{k in 1..m} B[i,k]*yfbar[k,l]
   >= b[i]*fbar[l];

subject to qconfl{i in 1..m, l in LIFTS}:
  q[i]*f[l] + sum{j in 1..n} N[i,j]*xf[j,l] + sum{k in 1..m} M[i,k]*yf[k,l]
   = wf[i,l];

subject to qconfbarl{i in 1..m, l in LIFTS}:
  q[i]*fbar[l] + sum{j in 1..n} N[i,j]*xfbar[j,l]
     + sum{k in 1..m} M[i,k]*yfbar[k,l] = wfbar[i,l];

subject to xffbarl{j in 1..n, l in LIFTS}: xf[j,l]+xfbar[j,l] = x[j];

subject to yffbarl{j in 1..m, l in LIFTS}: yf[j,l]+yfbar[j,l] = y[j];

subject to qffbarl{j in 1..m, l in LIFTS}: wf[j,l]+wfbar[j,l] = w[j];

#
#

subject to ffbar{i in 1..m}: f[i]+fbar[i]=1;

subject to xffbar{j in 1..n, l in 1..m}: xf[j,l]+xfbar[j,l] = x[j];

subject to yffbar{j in 1..m, l in 1..m}: yf[j,l]+yfbar[j,l] = y[j];

subject to qffbar{j in 1..m, l in 1..m}: wf[j,l]+wfbar[j,l] = w[j];

subject to yfid{i in 1..m}: yf[i,i] = y[i];
subject to yfidbar{i in 1..m}: yfbar[i,i] = 0;

subject to wfidbar{i in 1..m}: wfbar[i,i] = w[i];
subject to wfid{i in 1..m}: wf[i,i] = 0;

