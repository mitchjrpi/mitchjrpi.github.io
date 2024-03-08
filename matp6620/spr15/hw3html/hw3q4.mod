set vertices;   #  look for maxcut on complete graph with these vertices


param value{vertices,vertices};  #  lengths of edges

var x{i in vertices, j in vertices} >= 0 <= 1;
  # 0-1 variable indicating if edge in cut

maximize maxcut: sum{i in vertices, j in vertices} value[i,j]*x[i,j];

subject to symmetry {i in vertices, j in vertices}:
  x[i,j]=x[j,i];
subject to reflexivity {i in vertices}: x[i,i]=0;
