set VARS := {1,2};

var x{VARS};

minimize objective: 8*x[1]*x[2] + 0.25*(x[1]-x[2])^4;
