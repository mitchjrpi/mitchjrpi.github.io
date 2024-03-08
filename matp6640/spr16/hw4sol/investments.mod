#
# split wealth among assets
# look to maximize expected return, over a given set of scenarios
#

set ASSETS;
set SCENARIOS;

param prob{SCENARIOS} >= 0;
param lb{ASSETS} >= 0;
param ub{ASSETS} <= 1;
param returns{ASSETS,SCENARIOS};

var x{ASSETS} >= 0;
var y{s in SCENARIOS};

minimize expected_loss: -sum{s in SCENARIOS} prob[s]*y[s];

subject to assetallocation: sum{i in ASSETS} x[i] = 1;

subject to calculate_gain {s in SCENARIOS}:
   sum{i in ASSETS} returns[i,s] * x[i] - y[s] = 1;

subject to lowerbound{i in ASSETS}: x[i] >= lb[i];
subject to upperbound{i in ASSETS}: x[i] <= ub[i];
