param m;
param n;

var x{p in 1..n} >= 0;

param price{p in 1..n} = Uniform01();
param use{r in 1..m, p in 1..n} = Uniform01();
param avail{r in 1..m} = sum{j in 1..n} use[r,j];


minimize objective: sum{p in 1..n} price[p] * x[p];

subject to resourcelimit{r in 1..m}:
  sum{p in 1..n} use[r,p] * x[p] = avail[r];
