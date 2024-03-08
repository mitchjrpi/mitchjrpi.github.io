#  Model file for a vehicle routing problem
#
#  Have v vehicles, each with identical capacity D.
#
#  Have n customers with demand d_j.
#
#  The depot is node 0.
#
#  Have travel times t_ij
#
#  Look to minimize the total travel time.
#
#  There is one set of variables:
#    x_ijk: indicates whether edge ij is used by vehicle k
#

param  v;    #  number of vehicles
param  n;    #  number of customers (= #cities - 1)

param c{i in 0..n, j in 0..n} >= 0;   # cost of having i immediately before j

param D;  # vehicle capacity
param d{i in 1..n};  # customer demands
param dmin;  # the smallest demand
param dsort{i in 1..n}; # the distances, sorted
set demands ordered by Reals;  # a set used to sort the distances

param maxtourlength default 25;  # an estimate of the maximum number of customers
                                 # visited by a single vehicle
param used; # a parameter used in the calculation of maxtourlength


var x{i in 0..n, j in 0..n, k in 1..v} binary ;
    # 0-1 variable indicating if i is immediately before j on the subtour
    # of vehicle k



minimize tourcost: sum{i in 0..n, j in 0..n, k in 1..v} c[i,j]*x[i,j,k];

subject to leavebase {k in 1..v}:
  sum{j in 0..n} x[0,j,k] = 1;

subject to return2base {k in 1..v}:
  sum{j in 0..n} x[j,0,k] = 1;

subject to flowconservation {i in 1..n, k in 1..v}:
  sum{j in 0..n} x[i,j,k] = sum{h in 0..n} x[h,i,k];
  
subject to visitcustomer {i in 1..n}:
  sum{j in 0..n, k in 1..v} x[i,j,k]=1;
  
subject to capacity {k in 1..v}:
  sum{i in 1..n, j in 0..n} x[i,j,k]*d[i] <= D;

subject to preventloops {i in 1..n, k in 1..v}: x[i,i,k] = 0;
