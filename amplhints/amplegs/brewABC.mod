set PRODUCTS;
set RESOURCES;

var x{p in PRODUCTS} >= 0;

param price{p in PRODUCTS} >= 0;
param avail{r in RESOURCES} >= 0;
param use{r in RESOURCES, p in PRODUCTS} >= 0;


maximize objective: sum{p in PRODUCTS} price[p] * x[p];

subject to resourcelimit{r in RESOURCES}:
  sum{p in PRODUCTS} use[r,p] * x[p] <= avail[r];
