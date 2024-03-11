set CRUDE;
set PROCESS;
set REFINED;

param  contractsize{REFINED} > 0;
param  crudequantities{CRUDE} > 0;

param  production{REFINED,PROCESS} > 0;
param  crudeuse{CRUDE,PROCESS} > 0;

param  price{REFINED};

var  x{PROCESS}  >= 0;

maximize profit: sum{i in REFINED}
     price[i]*(sum{j in PROCESS}production[i,j]*x[j]);

subject to contracts{i in REFINED}:
  sum{j in PROCESS} production[i,j]*x[j] >= contractsize[i];

subject to available{i in CRUDE}:
  sum{j in PROCESS} crudeuse[i,j]*x[j] <= crudequantities[i];

#maximize profit: 6*(9*x1+5*x2) + 9*(7*x1+9*x2);
#
#subject to contract1: 9*x1 + 5*x2 >= 500;
#subject to contract2: 7*x1 + 9*x2 >= 300;
#
#subject to grade1: 5*x1 + 3*x2 <= 1500;
#subject to grade2: 7*x1 + 9*x2 <= 1900;
#subject to grade3: 2*x1 + 4*x2 <= 1000;
