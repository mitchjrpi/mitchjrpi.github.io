#
# socp formulation of dual SDP
#
param n;  # dimension of matrix
param m;  # number of linear constraints

param C{1..n,1..n};
param b{1..m};
param A{1..m,1..n,1..n};

var y{1..m};
var S{1..n,1..n};

maximize objective : sum{i in 1..m} b[i]*y[i];

subject to linear{j in 1..n, k in 1..n}: sum{i in 1..m} y[i]*A[i,j,k]+S[j,k]=C[j,k];

subject to symmetry{i in 1..n, j in i+1..n}: S[i,j]=S[j,i];

subject to diag{i in 1..n}: S[i,i] >= 0;

subject to subdets{i in 1..n, j in i+1..n}: S[i,j]**2 <= S[i,i]*S[j,j];
