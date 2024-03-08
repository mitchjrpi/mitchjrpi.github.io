#
#  This is a curve fitting model.
#  It's a ridge regression, epsilon tube model, using 1-norms.
#  The objective is to minimize the sum of absolute values of deviations
#      plus a scaled one norm of the vector.
#
#  Model is y_i = b + sum_j w_j x_ij + noise,
#
#  and we want to minimize
#     C ||w,b||_1  +  sum_i max(0, abs(y_i - b - sum_j w_j x_ij) - eps)
#
#  In this version, we have 2-fold cross-validation.
#  The n samples are split into sets TEST and TRAIN,
#    the optimization is run with the TRAIN set,
#    and it is evaluated with the TEST set.
#

param n;  # the number of observations or measurements.

param m;  # the number of characteristics for each observation.

param C >= 0 default 0.1; #  regularization
param eps >=0 default 0.05;  #  tube width

param x{i in 1..n, j in 1..m};  #  predictive variables
param y{i in 1..n};             #  outcome

set TRAIN within {1..n} default {1..(floor(n/2))};
set TEST within {1..n} default {((floor(n/2))+1)..n};

var w{j in 1..m};   # equation of fit
var wabs{j in 1..m} >= 0;
var b;    # intercept

var pos{i in 1..n} >= 0;  # pos and neg are the positive and
var neg{i in 1..n} >= 0;  #  negative parts of the error.
var error{i in 1..n};
var tube_error{i in TRAIN} >= 0;

var errorTRAIN;   #  
var TESTval;   #  only used for cross-validation
var TESTvalt;   #  only used for cross-validation

var va;
var vb;

minimize objective: C * sum{j in 1..m} wabs[j]
   + sum{i in TRAIN} (tube_error[i]);

subject to curve_error{i in 1..n}:
    error[i] = y[i] - b - sum{j in 1..m} w[j] * x[i,j];

subject to abserror{i in 1..n}: error[i] = pos[i] - neg[i];

subject to te{i in TRAIN}: tube_error[i] >= pos[i] + neg[i] - eps;
#subject to tep{i in TRAIN}: tube_error[i] >= pos[i] - eps;
#subject to ten{i in TRAIN}: tube_error[i] >= neg[i] - eps;

subject to wp{j in 1..m}: wabs[j] >= w[j];
subject to wn{j in 1..m}: wabs[j] >= -w[j];

subject to errTR: errorTRAIN = sum{i in TRAIN} (tube_error[i]);
subject to evalTEST: TESTval = sum{i in TEST} (pos[i]+neg[i]);
