#
#  this is a capacitated facility location model from
#  Nemhauser and Wolsey, page 430, question 17.
#
param m > 0;  #  number of customers
param n > 0;  #  number of facilities

param f{1..n} >= 0;  #  fixed charge of opening facility
param s{1..n} >= 0;  #  capacity of facility

param d{1..m} >= 0;  #  demands of customers

param c{1..m,1..n} >= 0;  #  per unit shipping costs

var x{1..n};  #  decision to open facilities

var y{1..m,1..n} >= 0;  #  proportion of demand met from each facility

var z{1..n} binary;   #  a binary variable to force x to be binary when desired

param u{1..n} default 0;

#

minimize obj: sum{i in 1..m} sum{j in 1..n} c[i,j]* y[i,j]
  +  sum{j in 1..n} f[j]*x[j];

subject to D{i in 1..m}: sum{j in 1..n} y[i,j] = 1;

subject to C{j in 1..n}: sum{i in 1..m} d[i]*y[i,j] <= s[j]*x[j];

subject to B{i in 1..m,j in 1..n}: y[i,j] <= x[j];

subject to S: sum{j in 1..n} s[j]*x[j] >= sum{i in 1..m} d[i];

subject to I{j in 1..n}: x[j] = z[j];

minimize zSCobj: sum{i in 1..m} sum{j in 1..n} c[i,j]* y[i,j]
  +  sum{j in 1..n} f[j]*x[j]
  +  sum{j in 1..m} u[j] * (sum{i in 1..m} d[i]*y[i,j] - s[j]*x[j] );
