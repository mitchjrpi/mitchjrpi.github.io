#
#  This is a curve fitting model, from Ecker&Kupferschmid, exercise 2.8.
#  The objective is to minimize the sum of absolute values of deviations.
#

#
#  The measurement should be a polynomial in the underlying t.
#  We want to find an expression for the curve.
#

param n_obs;  # the number of observations or measurements.

param power;

var curve{p in 0..power};   # curve[p] is the coefficient of the pth power.

var pos{i in 1..n_obs} >= 0;  # pos and neg are the positive and
var neg{i in 1..n_obs} >= 0;  #  negative parts of the error.
var error{i in 1..n_obs};

param t{i in 1..n_obs} >= 0;        #  t is the underlying variable,
param measure{i in 1..n_obs} >= 0;  # measure is measured for each
                                    # value of t 

minimize objective: sum{i in 1..n_obs} (pos[i] + neg[i]);

subject to curve_error{i in 1..n_obs}:
    error[i] = measure[i] - sum{p in 0..power} t[i]**p * curve[p];

subject to abserror{i in 1..n_obs}: error[i] = pos[i] - neg[i];
