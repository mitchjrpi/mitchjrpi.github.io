set vertices;   #  points to match

param x1{vertices};
param x2{vertices};   #  coordinates of vertices

param dist{i in vertices, j in vertices} :=
  sqrt((x1[i]-x1[j])**2+(x2[i]-x2[j])**2);  # distance between vertices

var x{i in vertices, j in vertices} >= 0;  # 0-1 variable indicating if edge in
                                      # matching

minimize perfect: sum{i in vertices, j in vertices} dist[i,j]*x[i,j];

subject to degree {i in vertices}:
  sum{j in vertices}x[i,j]=1;   #  degree constraints
subject to symmetry {i in vertices, j in vertices}:
  x[i,j]=x[j,i];
subject to reflexivity {i in vertices}: x[i,i]=0;
