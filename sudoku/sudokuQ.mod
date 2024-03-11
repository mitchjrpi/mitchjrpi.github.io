#  for a 9x9 grid, each of the numbers 1..9 appears once in
#  each row and once in each column. Further, the grid is
#  divided into 3x3 squares, and each number appears once in
#  each square.
#
#  this is essentially a vertex colouring problem with nine colours:
#  each row, each column, and each 3x3 square constitutes
#  a clique in the graph.
#
#  the locations of some numbers are already given, and the
#  objective is to find a feasible assignment of the remaining
#  numbers.
#  the objective function in the ampl formulation is irrelevant.

param  size;

set NUMBER = 1..size;
set ROW = 1..size;
set COLUMN = 1..size;

param nsubsets;

set ROWSUBS{1..nsubsets} within ROW;
set COLSUBS{1..nsubsets} within COLUMN;

set KNOWN within {NUMBER, ROW, COLUMN};

var x{NUMBER, ROW, COLUMN} >= 0, <= 1;

maximize total : sum {n in NUMBER, i in ROW, j in COLUMN} x[n,i,j]**2;

subject to rowonce{n in NUMBER, i in ROW}: sum{j in COLUMN} x[n,i,j]=1;

subject to colonce{n in NUMBER, j in COLUMN}: sum{i in ROW} x[n,i,j]=1;

subject to numonce{i in ROW, j in COLUMN}: sum{n in NUMBER} x[n,i,j]=1;

subject to squares{n in NUMBER, r in 1..nsubsets, s in 1..nsubsets}:
  sum{i in ROWSUBS[r], j in ROWSUBS[s]} x[n,i,j] = 1;

subject to given{(n,i,j) in KNOWN}: x[n,i,j] = 1;
