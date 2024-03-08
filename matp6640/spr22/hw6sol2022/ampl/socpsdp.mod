#
# socp formulation of primal SDP
#
param n;  # dimension of matrix
param m;  # number of linear constraints

param C{1..n,1..n};
param b{1..m};
param A{1..m,1..n,1..n};

var X{1..n,1..n};

minimize objective : sum{i in 1..n, j in 1..n} C[i,j]*X[i,j];

subject to linear{i in 1..m}: sum{j in 1..n, k in 1..n} A[i,j,k]*X[j,k]=b[i];

subject to symmetry{i in 1..n, j in i+1..n}: X[i,j]=X[j,i];

subject to diag{i in 1..n}: X[i,i] >= 0;

subject to subdets{i in 1..n, j in i+1..n}: X[i,j]**2 <= X[i,i]*X[j,j];
