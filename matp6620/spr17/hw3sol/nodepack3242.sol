ampl: model nodepack3242.mod;
ampl: solve;
CPLEX 12.6.2.0: optimal solution; objective 162
18 dual simplex iterations (0 in phase I)
ampl: display x;
x [*] :=
 1  0.5
 2  0.5
 3  0.5
 4  0.5
 5  0.5
 6  0.5
 7  0.5
 8  0.5
 9  0.5
10  0.5
11  0.5
12  0.5
13  0.5
14  0.5
15  0.5
;

ampl: display adjacency;
adjacency [*,*]
:    2   3   4   5    6    7   8    9   10  11   12   13   14   15    :=
1    0   .   .   .    .    .   .    .   .    .   .    .    .    20
2    .   0   .   .     0   .   .    .   .    .   .    21   .    .
3    .   .   2   .    .    0   .    .   .    .   .    .    18   .
4    .   .   .   11   .    .   10   .   .    .   .    .    .    .
5    .   .   .   .    10   .   .    0   .    .   .    .    .    .
6    .   .   .   .    .    9   .    .    3   .   .    .    .    .
7    .   .   .   .    .    .   11   .   .    3   .    .    .    .
8    .   .   .   .    .    .   .    0   .    .   .    .    .    .
9    .   .   .   .    .    .   .    .   21   0   .     0   .    .
10   .   .   .   .    .    .   .    .   .    0   .    .     0   .
11   .   .   .   .    .    .   .    .   .    .   20   .    .    .
12   .   .   .   .    .    .   .    .   .    .   .     0    0   .
13   .   .   .   .    .    .   .    .   .    .   .    .     3   .
14   .   .   .   .    .    .   .    .   .    .   .    .    .     0
;

ampl: subject to clique1: x[9]+x[10]+x[11] <= 1;
ampl: solve;
CPLEX 12.6.2.0: optimal solution; objective 151.5
5 dual simplex iterations (2 in phase I)
ampl: display x;
x [*] :=
 1  0.5
 2  0.5
 3  0.5
 4  0.5
 5  0.5
 6  0.5
 7  0.5
 8  0.5
 9  0
10  0.5
11  0.5
12  0.5
13  0.5
14  0.5
15  0.5
;

ampl: subject to clique2: x[12]+x[13]+x[14] <= 1;
ampl: solve;
CPLEX 12.6.2.0: optimal solution; objective 141.5
3 dual simplex iterations (0 in phase I)
ampl: display x;
x [*] :=
 1  0.5
 2  0.5
 3  0.5
 4  0.5
 5  0.5
 6  0.5
 7  0.5
 8  0.5
 9  0
10  0.5
11  0.5
12  0
13  0.5
14  0.5
15  0.5
;

ampl: display adjacency;
adjacency [*,*]
:    2   3    4    5      6      7     8     9  10  11  12  13  14   15    :=
1    1   .    .     .      .     .      .    .   .   .   .   .   .   19
2    .   16   .     .     0      .      .    .   .   .   .   4   .   .
3    .   .    0     .      .    4       .    .   .   .   .   .   0   .
4    .   .    .   10.5     .     .    12.5   .   .   .   .   .   .   .
5    .   .    .     .    10.5    .      .    0   .   .   .   .   .   .
6    .   .    .     .      .    8.5     .    .   3   .   .   .   .   .
7    .   .    .     .      .     .     8.5   .   .   2   .   .   .   .
8    .   .    .     .      .     .      .    0   .   .   .   .   .   .
9    .   .    .     .      .     .      .    .   0   0   .   0   .   .
10   .   .    .     .      .     .      .    .   .   0   .   .   0   .
11   .   .    .     .      .     .      .    .   .   .   0   .   .   .
12   .   .    .     .      .     .      .    .   .   .   .   0   0   .
13   .   .    .     .      .     .      .    .   .   .   .   .   0   .
14   .   .    .     .      .     .      .    .   .   .   .   .   .    1
;

ampl: subject to oh1: x[2]+x[3]+x[4]+x[5]+x[6]<= 2;
ampl: solve;
CPLEX 12.6.2.0: optimal solution; objective 132.5
3 dual simplex iterations (0 in phase I)
ampl: display x;
x [*] :=
 1  0
 2  0
 3  0.5
 4  0.5
 5  0.5
 6  0.5
 7  0.5
 8  0.5
 9  0
10  0.5
11  0.5
12  0
13  1
14  0
15  1
;

ampl: subject to oh2: x[3]+x[4]+x[5]+x[6]+x[7] <= 2;
ampl: subject to oh3: x[4]+x[5]+x[6]+x[7]+x[8] <= 2;
ampl: solve;
CPLEX 12.6.2.0: optimal solution; objective 131
4 dual simplex iterations (0 in phase I)
ampl: display x;
x [*] :=
 1  0.5
 2  0.5
 3  0.5
 4  0.5
 5  0
 6  0.5
 7  0.5
 8  0.5
 9  0
10  0.5
11  0.5
12  0
13  0.5
14  0.5
15  0.5
;

ampl: display adjacency;
adjacency [*,*]
:    2   3   4   5   6   7   8    9  10  11  12  13  14   15    :=
1    0   .   .   .   .   .   .    .   .   .   .   .   .   20
2    .   0   .   .   0   .   .    .   .   .   .   4   .   .
3    .   .   0   .   .   0   .    .   .   .   .   .   0   .
4    .   .   .   0   .   .    2   .   .   .   .   .   .   .
5    .   .   .   .   0   .   .    0   .   .   .   .   .   .
6    .   .   .   .   .   0   .    .   1   .   .   .   .   .
7    .   .   .   .   .   .   18   .   .   1   .   .   .   .
8    .   .   .   .   .   .   .    0   .   .   .   .   .   .
9    .   .   .   .   .   .   .    .   0   0   .   0   .   .
10   .   .   .   .   .   .   .    .   .   0   .   .   1   .
11   .   .   .   .   .   .   .    .   .   .   0   .   .   .
12   .   .   .   .   .   .   .    .   .   .   .   0   0   .
13   .   .   .   .   .   .   .    .   .   .   .   .   0   .
14   .   .   .   .   .   .   .    .   .   .   .   .   .    0
;

ampl: subject to oh4: x[1]+x[2]+x[13]+x[14]+x[15] <= 2;
ampl: solve;
CPLEX 12.6.2.0: optimal solution; objective 131
1 dual simplex iterations (0 in phase I)
ampl: display x;
x [*] :=
 1  0
 2  1
 3  0
 4  1
 5  0
 6  0
 7  1
 8  0
 9  0
10  1
11  0
12  1
13  0
14  0
15  1
;


