#
#  generate a disjunctive cut for the set of binary
#  solutions satisfying Ax >= b,
#  to cut off a point xbar
#
#  generated cut is alpha*x >= beta
#
#
#  in this version, the disjunction is more than just splitting
#  on a binary variable
#

param n > 0;
param m > 0;

param xbar{j in 1..n};

param A{i in 1..m, j in 1..n};
param b{i in 1..m};

param disjlb;
param disjub;
param disj{j in 1..n};  # disjunction is disj^Tx <= disjlb vs disj^Tx >= disjub

var alpha{j in 1..n};
var beta;

var u1{j in 1..m} >= 0;
var s1{j in 1..n} >= 0;
var t1{j in 1..n} >= 0;
var u1cv >= 0;   #  disjunctive term for disjunction

var u2{j in 1..m} >= 0;
var s2{j in 1..n} >= 0;
var t2{j in 1..n} >= 0;
var u2cv >= 0;   #  disjunctive term for disjunction

minimize violation: sum{j in 1..n} xbar[j]*alpha[j] - beta;

subject to work0{j in 1..n}:
alpha[j] = sum{i in 1..m} A[i,j]*u1[i] + s1[j] - t1[j] + disj[j]*u1cv;

subject to work1{j in 1..n}:
alpha[j] = sum{i in 1..m} A[i,j]*u2[i] + s2[j] - t2[j] - disj[j]*u2cv;

subject to goodbeta0: beta <= sum{i in 1..m} b[i]*u1[i] - sum{j in 1..n} t1[j]
  + disjub*u1cv;

subject to goodbeta1: beta <= sum{i in 1..m} b[i]*u2[i] - sum{j in 1..n} t2[j]
  - disjlb*u2cv;

subject to normalize:
sum{i in 1..m} u1[i] + sum{j in 1..n} s1[j] + sum {j in 1..n} t1[j] + u1cv +
sum{i in 1..m} u2[i] + sum{j in 1..n} s2[j] + sum {j in 1..n} t2[j] + u2cv
<= (11/0.6);
