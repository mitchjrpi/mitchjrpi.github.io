#  Model file to generate a robust LP instance.

param  m := 10;
param  n := 30;    #  number of observations

param Gamma{i in 1..m} := 15;  # max number of perturbations to protect against

#  var x{1..n};
var x{i in 1..n} >= 0;

#  robust variables y for each row
var y{i in 1..m} >= 0;

#  robust variables w for each row and column
var w{i in 1..m, j in 1..n} >= 0;

#  obj function is all ones
param c{i in 1..n} := 1;

#  A read from data file
param A{i in 1..m, j in 1..n};

#  b chosen to ensure vector of ones is feasible in robust problem
#  with constraints Ax >= b
param b{i in 1..m} := sum{j in 1..n} (A[i,j]-1);

#  nonrobust LP
minimize objective: sum{i in 1..n} c[i] * x[i];

subject to robustcon{i in 1..m}: sum{j in 1..n} A[i,j] * x[j]
  -Gamma[i]*y[i] - sum{j in 1..n} w[i,j] >= b[i];
  
subject to consistency{i in 1..m, j in 1..n}:
  x[j] - y[i] - w[i,j] <= 0;
  