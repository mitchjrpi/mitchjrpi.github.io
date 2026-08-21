ampl: model matching.mod;
ampl: data matching.dat;
ampl: solve;
ILOG CPLEX 9.100, licensed to "rensselaer-troy, ny", options: e m b q 
CPLEX 9.1.0: optimal solution; objective 6.5
14 dual simplex iterations (0 in phase I)
ampl: display x;
x :=
A B   0
A F   0
A G   1
B C   1
C D   0
C G   0
C H   0
C J   0
D E   0.5
D J   0.5
E F   0
E J   0.5
F G   0
F H   1
G H   0
H J   0
;
