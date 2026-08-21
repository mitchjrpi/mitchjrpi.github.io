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

param securitycost >= 0;

param edgecapacity >= 0 default 5;

#
# variables
#

var flow{FOODS, EDGES} >= 0;  # units of food f shipped along edge (i,j)

var foodsourced{FOODS, SOURCES} >= 0;  # units of food i leaving source j
# var fooddelivered{FOODS, INTERNAL};  # units of food i arriving at destination

var buylocal{FOODS,INTERNAL} >= 0;          # units of food i that is purchased locally
var vouchers{FOODS,DEMANDPOINTS} >= 0;          # units of food i that is supplied in the form
                                          #    of vouchers to demand points that have markets

var foodsupplied{FOODS,DEMANDPOINTS} >= 0;  #  net units of food i supplied
                               #    (includes just food supplied directly)

var ration{FOODS,DEMANDPOINTS} >= 0;  #  units of food i supplied
                                 #    (includes both food supplied directly and also vouchers)

var shortfall{NUTRIENTS,DEMANDPOINTS} >= 0, <=0.25; # shortfall of units of nutrient i supplied
var overshoot{NUTRIENTS,DEMANDPOINTS} >= 0; # overshoot of units of nutrient i supplied
       # the shortfall and overshoot variables are normalized

var NVS{DEMANDPOINTS} >= 0;  #  nutritional value score:
                       #    percentage of nutrional requirements met

var NVSworst >= 0;  #  lowest NVS over the demand points

var cost;   #  in US dollars

var localspending;
var voucherspending;
var externalspending;
var transportspending;
var totalweightbought;


#
# objective function: maximize nutritional value
#

maximize objective: NVSworst;
  
#
# constraints
#

subject to onlybuyatmarkets{f in FOODS, j in INTERNAL diff MARKETS}:
  buylocal[f,j] = 0;   #  can only buy locally at market nodes

subject to onlybuymarketfoods{f in FOODS diff FOODS_MARKET, j in MARKETS}:
  buylocal[f,j] = 0;   #  can only buy locally what the markets sell

subject to vouchermarket{f in FOODS, d in DEMANDPOINTS diff MARKETS}:
  vouchers[f,d] = 0;   #  can only use vouchers at DEMANDPOINTS that have MARKETS

subject to vouchermarket2{f in FOODS diff FOODS_MARKET, d in DEMANDPOINTS}:
  vouchers[f,d] = 0;   #  can only buy locally what the markets sell

#
# flow conservation
#

subject to available{f in FOODS, s in SOURCES}:  #  food shipped from sources
  sum{(s,j) in EDGES} flow[f,s,j] = foodsourced[f,s];
  
subject to reachdest{f in FOODS, d in DEMANDPOINTS}:  #  what food is delivered for use at demand point 
  foodsupplied[f,d] = sum{(j,d) in EDGES} flow[f,j,d]  -  sum{(d,i) in EDGES} flow[f,d,i]
                         + buylocal[f,d];

subject to flowconservation{f in FOODS, i in INTERNAL diff DEMANDPOINTS}:
  sum{(k,i) in EDGES} flow[f,k,i] + buylocal[f,i]  =  sum{(i,j) in EDGES} flow[f,i,j];

#
# calculate assignments to DEMANDPOINTS
#

subject to calculateration{f in FOODS, d in DEMANDPOINTS}:  # determine ration for each person
   ration[f,d]  =  foodsupplied[f,d] + vouchers[f,d];

#
# calculate nutrition for each person in each DEMANDPOINT
#
#    need to scale to account for population size and for changing units from tons to 100g
#
subject to nutrition{n in NUTRIENTS, d in DEMANDPOINTS}:  # calculate shortfall and overshoot
   (1 - shortfall[n,d] + overshoot[n,d]) * demand[n] * popsize[d]
        = sum{f in FOODS} ration[f,d] * composition[f,n] * scalefactor;

subject to findNVS{d in DEMANDPOINTS}:  #  calculate average shortfall, as a percentage
   card(NUTRIENTS) * NVS[d] = sum{n in NUTRIENTS} (1 - shortfall[n,d]);

subject to findNVSworst{d in DEMANDPOINTS}:   #  find the worst shortfall
   NVSworst <= NVS[d];

#
# markets that are also distribution points have limited availability of some items
#

subject to capacity{m in MARKETS inter DEMANDPOINTS, f in FOODS}:
  buylocal[f,m] + vouchers[f,m] <= capmarket[m,f];

#
# put lower bound on calorie count
#
subject to checkcal{d in DEMANDPOINTS}:
  sum{f in FOODS} (
    foodsupplied[f,d] + vouchers[f,d]
    )  *  composition[f,'Energy']  * scalefactor  #  total supply of calories
    >= EnergyLB * popsize[d];

#
# calculate costs
#
subject to findcost:
  cost  =
    sum{f in FOODS, s in SOURCES} foodsourced[f,s]*purchasecost[f] # buy remote food
    + sum{f in FOODS, m in MARKETS} buylocal[f,m]*localcost[m,f]   #  buy local food
    + sum{f in FOODS, (i,j) in EDGES} transpcost[i,j]*flow[f,i,j]  # transportation costs
    + sum{f in FOODS, d in DEMANDPOINTS} vouchercost[d,f]*vouchers[f,d];   # voucher cost to WFP

subject to obeycostUB:
  cost <= costUB;

subject to obeylocalLB:
  100 * (sum{f in FOODS, j in MARKETS} buylocal[f,j]*localcost[j,f]
  + sum{f in FOODS, j in DEMANDPOINTS} vouchercost[j,f]*vouchers[f,j])
  >= (  sum{f in FOODS, j in MARKETS} buylocal[f,j]*localcost[j,f]
      + sum{f in FOODS, j in DEMANDPOINTS} vouchercost[j,f]*vouchers[f,j]
      + sum{f in FOODS, s in SOURCES} foodsourced[f,s]*purchasecost[f]
      #+ sum{f in FOODS, (i,j) in EDGES} transpcost[i,j]*flow[f,i,j]
        )
      * localLB;

subject to obeyvoucherLB:
  100 * (sum{f in FOODS, j in DEMANDPOINTS} vouchercost[j,f]*vouchers[f,j])
  >= (  sum{f in FOODS, j in MARKETS} buylocal[f,j]*localcost[j,f]
      + sum{f in FOODS, j in DEMANDPOINTS} vouchercost[j,f]*vouchers[f,j]
      + sum{f in FOODS, s in SOURCES} foodsourced[f,s]*purchasecost[f]
      #+ sum{f in FOODS, (i,j) in EDGES} transpcost[i,j]*flow[f,i,j]
        )
      * voucherLB;

#
# some constraints to make it easier to display results
#

subject to localspend:
  localspending = sum{f in FOODS, j in MARKETS} buylocal[f,j]*localcost[j,f]
  + sum{f in FOODS, j in DEMANDPOINTS} vouchercost[j,f]*vouchers[f,j];

subject to voucherspend:
  voucherspending = sum{f in FOODS, j in DEMANDPOINTS} vouchercost[j,f]*vouchers[f,j];

subject to externalspend:
  externalspending = sum{f in FOODS, s in SOURCES} foodsourced[f,s]*purchasecost[f];

subject to transpspend:
  transportspending = sum{f in FOODS, (i,j) in EDGES} transpcost[i,j]*flow[f,i,j];

subject to findweight:
  totalweightbought = sum{f in FOODS, s in SOURCES} foodsourced[f,s]
    + sum{f in FOODS, m in MARKETS} buylocal[f,m]
    + sum{f in FOODS, d in DEMANDPOINTS} vouchers[f,d];

