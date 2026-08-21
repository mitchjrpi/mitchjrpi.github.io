ampl: model hw3q1np.mod; data hw3q1np.dat; solve; display x;
CPLEX 12.6.2.0: optimal solution; objective 17
11 dual simplex iterations (0 in phase I)
x [*] :=
a  1
b  0
c  1
d  0
e  1
f  0
g  0
h  0
j  0
;

ampl: display oddholecon;
oddholecon [*] :=
1  4
;

ampl: display clique3;
clique3 :=
a f g   1
c d j   1
c g h   1
c h j   1
d e j   4
f g h   0
;

