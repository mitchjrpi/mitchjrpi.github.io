param n;
param m;

param c{1..n};
param A{1..m,1..n};
param b{1..m};

var  x{1..n} >= 0;

minimize objective: sum{j in 1..n} c[j]*x[j];

subject to constraints{i in 1..m}:  sum{j in 1..n} A[i,j]*x[j] <= b[i];

subject to bound1: x[1] <= 0;
subject to bound2: x[2] >= 1;
