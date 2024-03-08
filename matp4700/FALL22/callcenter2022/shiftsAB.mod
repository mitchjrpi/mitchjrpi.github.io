set SHIFTS;   #  times when shifts start

set HOURS;    #  hours that must be covered

set CUSTOMERS;  #  the banks

set SHIFTHOUR{HOURS} within SHIFTS;  #a set of sets.
                                     #for each hour, list which shift
                                     #   workers are available

param shiftUB >= 0;  # maximum number of workers that can be hired for any shift

param LBworkers >= 0;  # minimum number of workers in any hour
param UBworkers >= 0;  # maximum number of workers in any hour

param cost{SHIFTS} >= 0;  # pay for a worker in a shift

param demand{CUSTOMERS,HOURS} >= 0;  # requirements of the banks to meet demand

param missedcallcost{CUSTOMERS,HOURS} > 0; # penalty for underperformance

param missedcallsUB >= 0;  # maximum worker shortage per hour

param allowmiss{CUSTOMERS} >= 0; # total shortage allowed

var workers{SHIFTS} >= 0;
var workcust{CUSTOMERS,SHIFTS} >= 0;
#var workhour{CUSTOMERS,HOURS} >= 0;
var missedcalls{CUSTOMERS,HOURS} >= 0;

minimize totalcost: sum{j in SHIFTS} cost[j] * workers[j]
  +  (sum{i in CUSTOMERS, t in HOURS} missedcallcost[i,t]*missedcalls[i,t]);

subject to shiftbound{s in SHIFTS}: workers[s] <= shiftUB;

subject to cover{i in CUSTOMERS, t in HOURS}:
  sum{j in SHIFTHOUR[t]} workcust[i,j] >= demand[i,t] - missedcalls[i,t];

subject to totalwork{t in SHIFTS}:
  sum{i in CUSTOMERS} workcust[i,t] = workers[t];

subject to quality{i in CUSTOMERS}:
  sum{t in HOURS} missedcalls[i,t] <= allowmiss[i];
  
subject to missedperhour{i in CUSTOMERS, t in HOURS}:
  missedcalls[i,t] <= missedcallsUB;

subject to mincover{t in HOURS}:
  sum{j in SHIFTHOUR[t]} workers[j] >= LBworkers;
  
subject to capacity{t in HOURS}:
  sum{j in SHIFTHOUR[t]} workers[j] <= UBworkers;
  
