#
# Reference: "The nutritious supply chain", Ergun, Den Hertog et al,
#   INFORMS Journal on Optimization, 2021, 3(2), pages 200-226.
#
# trying to get nutrients to people in need
#
# simplifying assumption: everyone has the same nutritional requirements
#
# objective is to maximize the percentage of nutritional needs met,
#    minimized over all the groups.  (so max-min).
#
# food is supplied over an external network.
#
# People are located at various demand points
#
# some food can be purchased locally at some of the demand points,
#   if the recipients are provided with vouchers.
#
# tradeoffs between nutrition and costs and other measures of efficiency
#   are enforced through the use of constraint (upper bounds on costs, etc)
#
# as in the diet problem, nutrients are supplied through foods, which
#    have their own nutritional profile, and also their own costs (purchse and transportation).
#

set NUTRIENTS;   #  nutrients
set FOODS;       #  foodstuffs

set SOURCES;     #  international sources for transportation network
set INTERNAL;    #  nodes in the country
set NODES := SOURCES union INTERNAL;
                 #  for transportation network
set EDGES within {NODES,NODES};
                 #  directed arcs for transportation network

set DEMANDPOINTS within INTERNAL;  #  demand points
set MARKETS within INTERNAL; #  internal nodes with local markets

set FOODS_MARKET within FOODS;  #  only a subset of the foods
                                    #  are available at the markets

#
# nutrients are measured per 100 grams, foodstuffs are measured in metric tons
# 1 metric ton equals 10^6 grams.
#

param demand{NUTRIENTS} >= 0;   #  minimum desired demand for each nutrient
param composition{FOODS,NUTRIENTS} >= 0; #  for each food i, how much it contains of
                                         #    nutrient j, per gram
                                    
# param supply{FOODS,SOURCES} >= 0;   #  maximum amount of each food available at each source
param purchasecost{FOODS} >= 0;  #  price per unit, same at all external sources
param transpcost{EDGES} >= 0;    #  price per unit (assumed same for all foods)
# param traveltime{EDGES} >= 0;   #  time for one unit to traverse an edge

param popsize{DEMANDPOINTS};   #  number of people

#param localavail{FOODS} >= 0;   #  the maximum that can be purchased locally
                                #    (implicitly, this is assuming we have just a single sink)
param localcost{INTERNAL, FOODS} >= 0, default 0;  # cost for WFP to buy foods locally
param vouchercost{i in INTERNAL, f in FOODS} >= 0, default 0.99*localcost[i,f];
                                      #  cost to the WFP of a voucher for 1 unit of food j

param costUB >= 0;  #  the maximum amount the WFP has available to cover all costs of the program
param EnergyLB >= 0;   #  lower bound on average desired calorie intake over the whole population
param localLB >= 0; #  lower bound on percentage of food purchased locally,
                    #     either wholesale or using vouchers
param voucherLB >= 0; #  lower bound on percentage of demand met through vouchers
# param averageleadtimeUB >= 0;  #  lower bound on average lead time for one unit to arrive at sink

param capmarket{MARKETS, FOODS} >= 0, default 10;
  # maximum amount of any one food available at each market, either for buylocal or vouchers

param scalefactor default 10^4;  #  number of (100 grams) in a metric ton
