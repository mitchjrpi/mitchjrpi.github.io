######################
### model file for knapsack problem
######################

param n > 0;

param c{1..n} >=0 ;

param a{1..n} >=0 ;

param b >=0 ;

param ncuts ;

set Cover{j in 1..ncuts} within {1..n} ;

var x{1..n} >=0, <= 1;

maximize objective: sum{i in 1..n} c[i]*x[i];

subject to capacity: sum{i in 1..n} a[i] * x[i] <= b;

subject to covercon{j in 1..ncuts}: sum{i in Cover[j]} x[i] <= card(Cover[j])-1;
