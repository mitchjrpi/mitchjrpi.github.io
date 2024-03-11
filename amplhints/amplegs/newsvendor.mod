#
# single item stochastic newsvendor problem
#
# have a purchase price p, sale price v, salvage value q
#
# have scenarios s with demands d[s] and probabilities prob[s]
#

set SCENARIOS;

param demand{SCENARIOS} >= 0;
param prob{SCENARIOS} >= 0;
param purchase >= 0;
param sale >= 0;
param salvage >= 0;

var x >= 0;
var y{s in SCENARIOS} >= 0, <= demand[s];
var unsold{SCENARIOS} >= 0;

maximize expected_profit: -purchase*x +
  sum{s in SCENARIOS} prob[s]*(sale*y[s] + salvage*unsold[s]);

subject to sellLEbuy{s in SCENARIOS}:
  y[s] + unsold[s] - x = 0;
