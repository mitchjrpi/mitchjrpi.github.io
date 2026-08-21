# stocahstic server location problem
#
# the customer demands are stochastic, everything else is deterministic
#
# have a set of possible locations for servers
#
# any server can satisfy any customer
#
# server has a capacity, but this is not a hard capacity,
# so we have complete recourse (except for the policy of not
# opening any servers).
#
# if the capacity is violated then we pay a cost
#
# have a set of sinks with stochastic demands.
#
# can make capacity expansions on arcs at a cost
#
# have a shortfall cost for failing to meet demands.
#
param nSERVERS;
param nCUSTOMERS;
param nSCENARIOS;

set SERVERS := 1..nSERVERS;
set CUSTOMERS := 1..nCUSTOMERS;
#set EDGES within {SERVERS,CUSTOMERS};

set SCENARIOS := 1..nSCENARIOS;

param opencost{SERVERS} >= 1, integer;  # cost to open a server
param openlimit >=1, integer;  #  maximum number of open server locations
param demand{CUSTOMERS,SCENARIOS} >= 0, integer;   # demand depends on scenario
param demandsum{s in SCENARIOS} := sum{j in CUSTOMERS} demand[j,s];   # total scenario demand
param shortfallcost{SERVERS} >= 0;      # per unit cost for unmet demand

param capacity{SERVERS} >=1, integer;    #  capacity of open servers
param revenue{SERVERS,CUSTOMERS};    # profit per unit sent from a server to a customer

param prob{SCENARIOS} >= 0;  # probabilities of scenarios

param averagedemand{j in CUSTOMERS} := ceil(sum{s in SCENARIOS} prob[s]*demand[j,s]);
param averagedemandsum := sum{j in CUSTOMERS} averagedemand[j];   # total scenario demand

var x{SERVERS} binary; # whether to open a server

var y{SERVERS,CUSTOMERS,SCENARIOS} >= 0, integer;  # flows in different scenarios

var z{SERVERS,SCENARIOS} >= 0, integer;  # shortfalls in different scenarios

var yaverage{SERVERS,CUSTOMERS} >= 0, integer;  # flows in mean scenario
var zaverage{SERVERS} >= 0, integer;  # shortfalls in mean scenario

#

minimize cost: sum{i in SERVERS} opencost[i]*x[i]
+ sum{s in SCENARIOS} prob[s] * (sum{v in SERVERS} shortfallcost[v]*z[v,s]
          -  sum{v in SERVERS, j in CUSTOMERS} revenue[v,j]*y[v,j,s]);

minimize costaverage: sum{i in SERVERS} opencost[i]*x[i]
+ (sum{v in SERVERS} shortfallcost[v]*zaverage[v]
          -  sum{v in SERVERS, j in CUSTOMERS} revenue[v,j]*yaverage[v,j]);

subject to serverUB: sum{i in SERVERS} x[i] <= openlimit;
subject to serverLB: sum{i in SERVERS} x[i] >= 1;

subject to shortfall{i in SERVERS, s in SCENARIOS}:
  z[i,s] >= sum{j in CUSTOMERS} y[i,j,s] - capacity[i]*x[i];
  
subject to shortfallclosed{v in SERVERS, s in SCENARIOS}:
  z[v,s] <= demandsum[s]*x[v];
  # can only have shortfall if the facility is open

subject to meetdemand{j in CUSTOMERS, s in SCENARIOS}:
  sum{i in SERVERS} y[i,j,s] = demand[j,s];

subject to meetaveragedemand{j in CUSTOMERS}:
  sum{i in SERVERS} yaverage[i,j] = averagedemand[j];

subject to shortfallaverage{i in SERVERS}:
  zaverage[i] >= sum{j in CUSTOMERS} yaverage[i,j] - capacity[i]*x[i];
  
subject to shortfallclosedaverage{v in SERVERS}:
  zaverage[v] <= averagedemandsum*x[v];
  # can only have shortfall if the facility is open

  