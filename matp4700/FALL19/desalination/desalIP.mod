#
# assign demand to desalination plants
#
# need to meet overall demand
#
# costs: power to run the plants, to move the water,
#    and to process the residual salt
#
# constraints: meet demand, don't change salination of bodies
#    of water too much
#

set PLANTS;  #  desalination plants
set CITIES;  #  demand points for water

# extra plants under consideration
set PLANTSexpand default {};

#  have alternatives for each extra plant under consideration
set PLANToptions{PLANTSexpand};

set NODES := PLANTS union CITIES union PLANTSexpand;

set EDGES within {NODES, NODES};  # any reversible edge is
                                    # included twice

#
# parameters
#

param edgecost{EDGES} >= 0;  # cost to pump 1000 cubic meters of water
                             # should be about $1 to lift 1000 cubic meters
                             #    up 10 feet

param demand{CITIES} >= 0;  #  1000s of cubic meters per day

param wellcost{CITIES} >= 0;  # cost per cubic foot pulled from well
                              # should be high to discourage use

param capacity{PLANTS} >= 0;   # 1000s of cubic meters per day.
                               # should prob be 100-200

param capexpand{PLANTSexpand} >= 0;   # 1000s of cubic meters per day.
                               # should prob be 100-200

param dischargemax{PLANTS} >= 0;  # 1000s of cubic meters per day

param disposalcost{PLANTS} >= 0;  # per 1000 cubic meters

param  opcost{PLANTS} >= 0;  #  operational costs per 1000 cubic meters
                             #  of purified water.
                             #  includes power costs and maintenance costs.
                             #  should be several hundred dollars

param  opcostexpand{PLANTSexpand} >= 0;  #  operational costs per 1000 cubic meters
                             #  of purified water for the additional plants.
                             #  includes power costs and maintenance costs.
                             #  should be several hundred dollars

param  renewcapacity{PLANTS} >= 0;  #  amount of supply that can be handled by
                                    #  renewable energy

param capexpandoptions{p in PLANTSexpand, PLANToptions[p]} >= 0;
                             # capacity for various options for new plants

param fixedcostexpandoptions{p in PLANTSexpand, PLANToptions[p]} >= 0;
                             # fixed cost for various options for new plants

param brinegeneration >= 0;  # cubic meters of brine produced for
                             # each cubic meter of purified water

param bucketcost >= 0; # cost of bucket of carbon offset
param bucketsize >= 0; # size of bucket of carbon offset

#
# variables
#

var supply{PLANTS} >= 0;  # water production of each plant

var ship{EDGES} >= 0;

var discharge{PLANTS} >= 0;  # amount of salt returned to body of water

var disposal{PLANTS} >= 0;  # amount of salt to be disposed of on land

var wells{CITIES} >= 0;  #  demand satisfied from wells and reservoirs

var carbon{PLANTS} >= 0; # energy usage at each plant from non-renewable sources

#
# Some syntax hints:
#
# will need to define variables such as:
#    var openopt{p in PLANTSexpand, PLANToptions[p]} binary;
#         # could be used to indicate whether a particular option has been chosen
#
# If we have a parameter
#     param{p in PLANTSexpand, PLANToptions[p]},
#
#  we can use it either in a sum such as:
#     sum{p in PLANTSexpand, q in PLANToptions[p]} param[p,q] * openopt[p,q]
#
# or in a constraint that depends on p:
#     subject to new_con{p in PLANTSexpand}: sum{q in PLANToptions[p]} param[p,q]*openopt[p,q]
#

#
# objective function: minimize total costs
#                     operational costs to run the plants
#                     plus power to ship the water
#                     plus costs to dispose of excess salt
#

minimize costs: sum{j in PLANTS}  opcost[j]*supply[j]
  + sum{(i,j) in EDGES} edgecost[i,j]*ship[i,j]
  + sum{j in PLANTS} disposalcost[j]*disposal[j]
  + sum{j in CITIES} wellcost[j]*wells[j];
  
#
# constraints
#

subject to finddisposal{j in PLANTS}:
  discharge[j]+disposal[j] = brinegeneration*supply[j];
  
subject to flowconservationplants{j in PLANTS}:
  sum{(j,k) in EDGES} ship[j,k] = supply[j];
  
subject to flowconservationcities{j in CITIES}:
  sum{(i,j) in EDGES} ship[i,j] - sum{(j,k) in EDGES} ship[j,k] + wells[j]
    = demand[j];
 
subject to findcarbon{j in PLANTS}: carbon[j] >= supply[j]-renewcapacity[j];
 
subject to limitcarbon:
   sum{j in PLANTS} carbon[j] <= 0.05 * sum{k in PLANTS} supply[k];
   
subject to limitwells: sum{j in CITIES} wells[j] <= 0.05*sum{k in CITIES} demand[k];

#
# upper bound constraints
#

subject to supplybound{j in PLANTS}: supply[j] <= capacity[j];

subject to dischargebound{j in PLANTS}: discharge[j] <= dischargemax[j]; 
