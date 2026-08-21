set PRODUCTS;
set RESOURCES;
set PAIRS within {PRODUCTS,PRODUCTS};
set TRIPLES within {PRODUCTS,PRODUCTS,PRODUCTS};

var x{p in PRODUCTS} binary;
var y{(i,j) in PAIRS} binary;
var z{(i,j,k) in TRIPLES} binary;

param price{p in PRODUCTS};
param priceP{(i,j) in PAIRS};
param priceT{(i,j,k) in TRIPLES};
param avail{r in RESOURCES};
param use{r in RESOURCES, p in PRODUCTS};
param useP{(i,j) in PAIRS, r in RESOURCES};
param useT{(i,j,k) in TRIPLES, r in RESOURCES};


maximize objective: sum{p in PRODUCTS} price[p] * x[p]
  + sum{(i,j) in PAIRS} priceP[i,j] * y[i,j]
  + sum{(i,j,k) in TRIPLES} priceT[i,j,k] * z[i,j,k];

subject to resourcelimit{r in RESOURCES}:
  sum{p in PRODUCTS} use[r,p] * x[p]
   + sum{(i,j) in PAIRS} useP[i,j,r] * y[i,j]
   + sum{(i,j,k) in TRIPLES} useT[i,j,k,r] * z[i,j,k]
   <= avail[r];

subject to mcc1{(i,j) in PAIRS}: y[i,j] <= x[i];
subject to mcc2{(i,j) in PAIRS}: y[i,j] <= x[j];
subject to mcc3{(i,j) in PAIRS}: y[i,j] >= x[i] + x[j] - 1;

subject to mcc4{(i,j,k) in TRIPLES}: z[i,j,k] <= x[i];
subject to mcc5{(i,j,k) in TRIPLES}: z[i,j,k] <= x[j];
subject to mcc6{(i,j,k) in TRIPLES}: z[i,j,k] <= x[k];
subject to mcc7{(i,j,k) in TRIPLES}: z[i,j,k] >= x[i] + x[j] + x[k] - 2;
