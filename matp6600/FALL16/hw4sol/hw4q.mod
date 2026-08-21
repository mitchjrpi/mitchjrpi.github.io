#  solve the problem 
#    min c^T x
#    st  0.5 x^T M x <= m
#        0.5 x^T Q x <= q
#

var x1;
var x2;

param M11;
param M12;
param M21;
param M22;

param Q11;
param Q12;
param Q21;
param Q22;

param m;
param q;


param c1;
param c2;

minimize obj: c1*x1 + c2*x2 ;

subject to conM: 0.5*(x1**2 * M11 + 2*x1*x2*M12 + x2**2 * M22) <= m;
subject to conQ: 0.5*(x1**2 * Q11 + 2*x1*x2*Q12 + x2**2 * Q22) <= q;
