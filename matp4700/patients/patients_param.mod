set ZONE1;   #  nurses must work within their current zone
set ZONE2;

set CITIES := ZONE1 union ZONE2;   #  hospital catchment areas

param demand{CITIES} >= 0;  # expected additional demand for IC beds for each catchment area

param avail_IC{CITIES} >= 0;  # number of IC beds currently available
param used_IC{CITIES} >= 0;   # number of IC beds currently used

param extra_nurses{CITIES} >= 0;  # extra nurses available to be IC nurses
param nurse_cost {CITIES,CITIES} >= 0;  # cost to reassign nurses

param costs{CITIES} >= 0;  # opportunity costs for transitioning a regular bed to an IC bed

param pop{CITIES} >= 0;  #  populations of cities

param transp_costs{CITIES,CITIES} >= 0;  # cost to transport a patient from one city to another (may not be symmetric)

param nurse_per_pat >= 0;  # minimum number of workers per patient

param minratio >= 0; # each city must end up with at least minratio of the average capacity

###################
