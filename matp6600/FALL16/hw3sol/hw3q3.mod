#
#  solve   min ||x||_1  st  Ax=b  as an LP.
#
#  A and b are in the data file.
#

param m > 0, integer;
param n > 0, integer;

param A{i in 1..m, j in 1..n};

param b{i in 1..m};

#  variables t >= abs(x)

var x{1..n};
var t{1..n};

#

minimize L1norm: sum{j in 1..n} t[j];

subject to exactfit{i in 1..m}: sum{j in 1..n} A[i,j]*x[j] = b[i];

subject to calc_tplus{j in 1..n}: -x[j] + t[j] >= 0;
subject to calc_tminus{j in 1..n}: x[j] + t[j] >= 0;