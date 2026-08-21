set SHIFTS;   #  times when shifts start

set HOURS;    #  hours that must be covered

set CUSTOMERS;  #  the banks

set SHIFTHOUR{HOURS} within SHIFTS;  #a set of sets.
                                     #for each hour, list which shift
                                     #   workers are available

param shiftUB >= 0;  # maximum numnber of workers that can be hired for any shift

param LBworkers >= 0;  # minimum number of workers in any hour
param UBworkers >= 0;  # maximum number of workers in any hour

param cost{SHIFTS} >= 0;  # pay for a worker in a shift

param demand{CUSTOMERS,HOURS} >= 0;  # requirements of the banks to meet demand

param missedcallcost{CUSTOMERS,HOURS} > 0; # penalty for underperformance

param missedcallsUB >= 0;  # maximum worker shortage per hour

param allowmiss{CUSTOMERS} >= 0; # total shortage allowed
