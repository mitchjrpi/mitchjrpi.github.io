  # graph is on a grid.
  # nodes are numbered from left to right and then from top to bottom.
  # origins are the left side and the top
  # destinations are scattered through the grid
  # arcs all point either down or to the right
param gridwidth:=4;
param gridheight:=4;
param nnodes := gridwidth*gridheight;

param ndest := 3;
