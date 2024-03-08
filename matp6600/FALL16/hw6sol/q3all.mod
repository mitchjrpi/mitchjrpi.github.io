set VARS;
set CONS;

param RHS{CONS};
param OBJCOEFF{VARS};
param OBJSHIFT{VARS};

param CONSCOEFF{CONS,VARS};
param CONSSHIFT{CONS,VARS};

param mu >= 0;

var x{VARS};
var surplus{CONS} >= 0;

minimize objective: sum{j in VARS} OBJCOEFF[j]*(x[j]-OBJSHIFT[j])^2
+ mu*sum{k in CONS} surplus[k]^2;

minimize objectiveL1: sum{j in VARS} OBJCOEFF[j]*(x[j]-OBJSHIFT[j])^2
+ mu*sum{k in CONS} surplus[k];

minimize objective_orig: sum{j in VARS} OBJCOEFF[j]*(x[j]-OBJSHIFT[j])^2;

subject to quadratic{i in CONS}:
 sum{j in VARS} CONSCOEFF[i,j]*(x[j]-CONSSHIFT[i,j])^2 -surplus[i] <= RHS[i];
