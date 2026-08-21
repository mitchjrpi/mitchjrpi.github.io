#  Model file for a linear ordering problem.
#  This is the LP relaxation, with no triangle inequalities included.


param  p;    #  number of sectors


var x{i in 1..p-1, j in i+1..p} >= 0, <=1;  # 0-1 variable indicating if
                                          # i is before j

param c{i in 1..p, j in 1..p};   # cost of having i before j

minimize ordering: sum{i in 1..p-1, j in i+1..p: j>i} c[i,j]*x[i,j];
