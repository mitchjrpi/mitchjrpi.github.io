#  Model file for a traveling salesman problem
#
#  There is one set of variables:
#    x: corresponds to the edges in the tour
#
#  We need to use two edges incident to each node.
#


param  p;    #  number of customers (= #cities - 1)


var x{i in 0..p, j in i+1..p} binary ;  # 0-1 variable indicating if
                                        # i is immediately before j

param c{i in 0..p, j in 0..p} >= 0;   # cost of having i immediately before j


minimize tourcost: sum{i in 0..p, j in i+1..p} c[i,j]*x[i,j];

subject to incident {i in 0..p}:
  sum{j in 0..i-1} x[j,i] + sum{j in i+1..p} x[i,j] = 2;
