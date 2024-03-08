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

var move_pat{CITIES,CITIES} >= 0;  #  number of patients moved from city to city
                                   #  note this includes patients from city i who go to hospital i

var move_nurse{CITIES,CITIES} >= 0;  #  number of nurses moved from city to city
                                     #  note this includes non-IC nurses from city i
                                     #     who become IC nurses at hospital i

var capacity_expansion{CITIES} >= 0;  #  number of beds converted to IC beds

var average >= 0;  # average #IC beds/population over the cities

###################

minimize totalcosts:
  sum{i in CITIES} costs[i] * capacity_expansion[i]
  +  sum{i in CITIES, j in CITIES} transp_costs[i,j] * move_pat[i,j]
  +  sum{i in CITIES, j in CITIES} nurse_cost[i,j] * move_nurse[i,j];
  
subject to assigndemand{i in CITIES}:  #  make sure all patients receive an IC bed
     # note that the sum includes the patients from city i who are admitted to hospital i
  sum{j in CITIES} move_pat[i,j] = demand[i];

subject to expandcapacity{i in CITIES}:  #  add additional IC beds as necessary to accomodate patients
     # note that the sum includes the patients from city i who are admitted to hospital i
  sum{j in CITIES} move_pat[j,i] - capacity_expansion[i] <= avail_IC[i];

subject to nurse_ratio{i in CITIES}:  # make sure each patient has enough nurses
    # note that the sum includes non-IC nurses at hospital i who become IC nurses at hospital i
  capacity_expansion[i] * nurse_per_pat - sum{j in CITIES} move_nurse[j,i] <= 0;
 
subject to nurse_avail{i in CITIES}:  #  can only assign nurses who are available
    # note that the sum includes non-IC nurses at hospital i who become IC nurses at hospital i
  sum{j in CITIES} move_nurse[i,j] <= extra_nurses[i];
  
subject to calcaverage:  #  calculate the average number of IC beds per person
  sum{i in CITIES} (used_IC[i]+avail_IC[i]+capacity_expansion[i])/pop[i] - average*card{CITIES} = 0;
  
subject to balance{i in CITIES}:  # make sure no city is too far below the average
  (used_IC[i]+avail_IC[i]+capacity_expansion[i])/pop[i] - minratio * average >= 0;
  
subject to zonerestriction1{i in ZONE1, j in ZONE2}: move_nurse[i,j] = 0;  # nurses can only work in current zone

subject to zonerestriction2{i in ZONE1, j in ZONE2}: move_nurse[j,i] = 0;  # nurses can only work in current zone

