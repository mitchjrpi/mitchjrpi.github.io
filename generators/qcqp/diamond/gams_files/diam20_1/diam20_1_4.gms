* problem 4
SET Vars   /x1*x20/;
SET QuadCons   /qc1*qc1/;
ALIAS(Vars,j,jj);
 
SET Pairs(Vars,Vars)  / 
x1.x2 ,  x1.x3 ,  x1.x4 ,  x1.x5 ,  x1.x6 ,  x1.x7 ,  x1.x8 ,  x1.x9 ,  x1.x10 ,  x1.x11 ,  x1.x12 ,  x1.x13 ,  x1.x14 ,  x1.x15 ,  x1.x16 ,  x1.x17 ,  x1.x18 ,  x1.x19 ,  x1.x20 ,  x2.x3 ,  x2.x4 ,  x2.x5 ,  x2.x6 ,  x2.x7 ,  x2.x8 ,  x2.x9 ,  x2.x10 ,  x2.x11 ,  x2.x12 ,  x2.x13 ,  x2.x14 ,  x2.x15 ,  x2.x16 ,  x2.x17 ,  x2.x18 ,  x2.x19 ,  x2.x20 ,  x3.x4 ,  x3.x5 ,  x3.x6 ,  x3.x7 ,  x3.x8 ,  x3.x9 ,  x3.x10 ,  x3.x11 ,  x3.x12 ,  x3.x13 ,  x3.x14 ,  x3.x15 ,  x3.x16 ,  x3.x17 ,  x3.x18 ,  x3.x19 ,  x3.x20 ,  x4.x5 ,  x4.x6 ,  x4.x7 ,  x4.x8 ,  x4.x9 ,  x4.x10 ,  x4.x11 ,  x4.x12 ,  x4.x13 ,  x4.x14 ,  x4.x15 ,  x4.x16 ,  x4.x17 ,  x4.x18 ,  x4.x19 ,  x4.x20 ,  x5.x6 ,  x5.x7 ,  x5.x8 ,  x5.x9 ,  x5.x10 ,  x5.x11 ,  x5.x12 ,  x5.x13 ,  x5.x14 ,  x5.x15 ,  x5.x16 ,  x5.x17 ,  x5.x18 ,  x5.x19 ,  x5.x20 ,  x6.x7 ,  x6.x8 ,  x6.x9 ,  x6.x10 ,  x6.x11 ,  x6.x12 ,  x6.x13 ,  x6.x14 ,  x6.x15 ,  x6.x16 ,  x6.x17 ,  x6.x18 ,  x6.x19 ,  x6.x20 ,  x7.x8 ,  x7.x9 ,  x7.x10 ,  x7.x11 ,  x7.x12 ,  x7.x13 ,  x7.x14 ,  x7.x15 ,  x7.x16 ,  x7.x17 ,  x7.x18 ,  x7.x19 ,  x7.x20 ,  x8.x9 ,  x8.x10 ,  x8.x11 ,  x8.x12 ,  x8.x13 ,  x8.x14 ,  x8.x15 ,  x8.x16 ,  x8.x17 ,  x8.x18 ,  x8.x19 ,  x8.x20 ,  x9.x10 ,  x9.x11 ,  x9.x12 ,  x9.x13 ,  x9.x14 ,  x9.x15 ,  x9.x16 ,  x9.x17 ,  x9.x18 ,  x9.x19 ,  x9.x20 ,  x10.x11 ,  x10.x12 ,  x10.x13 ,  x10.x14 ,  x10.x15 ,  x10.x16 ,  x10.x17 ,  x10.x18 ,  x10.x19 ,  x10.x20 ,  x11.x12 ,  x11.x13 ,  x11.x14 ,  x11.x15 ,  x11.x16 ,  x11.x17 ,  x11.x18 ,  x11.x19 ,  x11.x20 ,  x12.x13 ,  x12.x14 ,  x12.x15 ,  x12.x16 ,  x12.x17 ,  x12.x18 ,  x12.x19 ,  x12.x20 ,  x13.x14 ,  x13.x15 ,  x13.x16 ,  x13.x17 ,  x13.x18 ,  x13.x19 ,  x13.x20 ,  x14.x15 ,  x14.x16 ,  x14.x17 ,  x14.x18 ,  x14.x19 ,  x14.x20 ,  x15.x16 ,  x15.x17 ,  x15.x18 ,  x15.x19 ,  x15.x20 ,  x16.x17 ,  x16.x18 ,  x16.x19 ,  x16.x20 ,  x17.x18 ,  x17.x19 ,  x17.x20 ,  x18.x19 ,  x18.x20 ,  x19.x20    / ; 

PARAMETER c0(Vars)
  /  
x1   3.39143212e-01 
x2  -2.83329953e-01 
x3   9.66304373e-01 
x4  -7.06385966e-02 
x5  -9.99847819e-01 
x6  -8.53173930e-01 
x7  -7.30706023e-01 
x8   6.21459470e-01 
x9  -1.35606990e-02 
x10   9.92215109e-01 
x11  -1.94454382e-01 
x12   9.26207421e-01 
x13   1.81860309e-02 
x14   1.85561203e-01 
x15  -8.26704519e-01 
x16  -9.47444171e-01 
x17   6.16606974e-01 
x18   3.06380270e-01 
x19   9.39473940e-01 
x20   5.67090484e-01 
 / 
 
PARAMETER g(QuadCons)
  /  
qc1   1.38749491e+00 
 / 
 
TABLE Q0(j,jj)
                x1                 x2                 x3                 x4                 x5                 x6                 x7                 x8                 x9                 x10                 x11                 x12                 x13                 x14                 x15                 x16                 x17                 x18                 x19                 x20                
x1   0.000000000000      4.02552634e-01      5.66936769e-01      6.28573555e-01     -8.24410209e-01      3.97625369e-01      8.13949947e-01      3.77713048e-01      1.13646306e-01      9.45669291e-01     -8.47506646e-01     -4.37887225e-02      4.45778300e-02     -3.53683771e-01      2.95461546e-01      8.65925683e-01      6.90817456e-01      3.39018781e-01      3.56813941e-01     -4.27725867e-01    
x2   4.02552634e-01      0.000000000000      7.47396771e-01      5.76254059e-01     -7.69894999e-01     -3.63695935e-01     -8.69443436e-01     -2.74691464e-01     -5.87901674e-01     -9.07296348e-01     -9.74352482e-01     -9.85606794e-01     -8.31683809e-01      1.59785864e-01     -2.04409532e-01      8.15561951e-01      7.94985190e-01      6.75406312e-01      7.99700031e-01     -5.81586642e-01    
x3   5.66936769e-01      7.47396771e-01      0.000000000000     -4.33677630e-02      5.47627710e-01     -3.84947227e-01     -2.82956667e-01      9.53451320e-01      1.94649285e-01     -3.14093028e-01     -4.47555926e-01      1.09534735e-01      2.88713135e-01      5.70441164e-01      4.50466728e-01     -3.30828155e-01     -7.98652877e-01     -1.52812741e-01      6.85970281e-01     -1.76962399e-01    
x4   6.28573555e-01      5.76254059e-01     -4.33677630e-02      0.000000000000      8.99436241e-01      6.27441361e-01     -9.25448705e-01      7.67115366e-01     -7.87989405e-01      3.02836339e-01     -1.42224299e-01     -3.90603933e-01      1.41495588e-02     -2.55808670e-01     -4.92348989e-01      6.81970869e-02     -5.84824497e-01      9.88600596e-01      7.07832713e-01     -4.74438515e-01    
x5  -8.24410209e-01     -7.69894999e-01      5.47627710e-01      8.99436241e-01      0.000000000000      4.97380569e-01      5.27635252e-01     -9.76237269e-01      6.95033108e-01     -5.72344347e-01      9.61025937e-01     -2.42255131e-01      2.70261381e-01     -4.58163500e-01      8.67109149e-02     -3.56658125e-01      6.13828059e-01     -7.16443971e-01      1.44229213e-01      1.13639768e-03    
x6   3.97625369e-01     -3.63695935e-01     -3.84947227e-01      6.27441361e-01      4.97380569e-01      0.000000000000      8.39026522e-01      4.78175017e-02     -4.31657110e-01      3.57732466e-01     -6.69061859e-01      9.29837914e-01     -3.85125200e-01      7.59147857e-03     -5.98508541e-01     -8.10672160e-01      1.49590802e-01     -4.36693941e-01     -4.11490589e-01     -5.23529910e-01    
x7   8.13949947e-01     -8.69443436e-01     -2.82956667e-01     -9.25448705e-01      5.27635252e-01      8.39026522e-01      0.000000000000      2.10104189e-01     -4.24505144e-01      3.45135700e-01     -1.49784817e-01      6.32716328e-01      7.70946683e-01      7.46989642e-01     -3.70114221e-01      6.75992156e-02      6.71304493e-01     -5.33844503e-02      1.71445574e-01      7.95847947e-01    
x8   3.77713048e-01     -2.74691464e-01      9.53451320e-01      7.67115366e-01     -9.76237269e-01      4.78175017e-02      2.10104189e-01      0.000000000000     -3.61699685e-01     -8.84207916e-01      6.42263504e-02     -4.39136706e-01     -5.04362385e-01      3.22052183e-01      8.75475253e-01     -9.79728919e-01     -5.05785217e-01     -6.19577871e-01     -3.24312319e-01     -4.76177532e-01    
x9   1.13646306e-01     -5.87901674e-01      1.94649285e-01     -7.87989405e-01      6.95033108e-01     -4.31657110e-01     -4.24505144e-01     -3.61699685e-01      0.000000000000      8.68632240e-01      9.20840223e-01     -8.26517459e-01     -7.76227936e-01      8.72664314e-01     -4.07724501e-01      7.55621690e-02     -8.71230648e-01      8.00172090e-01      3.53434440e-01      3.19545938e-01    
x10   9.45669291e-01     -9.07296348e-01     -3.14093028e-01      3.02836339e-01     -5.72344347e-01      3.57732466e-01      3.45135700e-01     -8.84207916e-01      8.68632240e-01      0.000000000000     -6.47639399e-01     -6.86476659e-01      7.20645528e-01     -6.42478946e-01     -7.82655827e-01     -5.71912353e-01     -9.63178851e-01     -4.57162512e-01     -6.35833992e-01     -2.21048053e-01    
x11  -8.47506646e-01     -9.74352482e-01     -4.47555926e-01     -1.42224299e-01      9.61025937e-01     -6.69061859e-01     -1.49784817e-01      6.42263504e-02      9.20840223e-01     -6.47639399e-01      0.000000000000     -9.16846274e-01     -1.41089723e-01     -2.50962322e-01      9.36057531e-02      4.09051404e-01     -9.57006610e-01      6.40644979e-01     -5.81253377e-01      6.07565017e-01    
x12  -4.37887225e-02     -9.85606794e-01      1.09534735e-01     -3.90603933e-01     -2.42255131e-01      9.29837914e-01      6.32716328e-01     -4.39136706e-01     -8.26517459e-01     -6.86476659e-01     -9.16846274e-01      0.000000000000     -1.03708151e-01     -6.41017734e-01     -1.00984163e-01      8.47771499e-02     -4.73013080e-01     -9.75991999e-01      1.09934875e-01     -9.40567887e-03    
x13   4.45778300e-02     -8.31683809e-01      2.88713135e-01      1.41495588e-02      2.70261381e-01     -3.85125200e-01      7.70946683e-01     -5.04362385e-01     -7.76227936e-01      7.20645528e-01     -1.41089723e-01     -1.03708151e-01      0.000000000000      1.24273572e-01     -8.69483866e-01     -3.76636262e-01     -9.89167440e-01     -2.59204708e-01      7.18373973e-01      7.35196184e-01    
x14  -3.53683771e-01      1.59785864e-01      5.70441164e-01     -2.55808670e-01     -4.58163500e-01      7.59147857e-03      7.46989642e-01      3.22052183e-01      8.72664314e-01     -6.42478946e-01     -2.50962322e-01     -6.41017734e-01      1.24273572e-01      0.000000000000     -8.60270950e-01     -7.30413672e-01      8.61440785e-01     -9.78469613e-01     -1.30563923e-01     -5.29382966e-01    
x15   2.95461546e-01     -2.04409532e-01      4.50466728e-01     -4.92348989e-01      8.67109149e-02     -5.98508541e-01     -3.70114221e-01      8.75475253e-01     -4.07724501e-01     -7.82655827e-01      9.36057531e-02     -1.00984163e-01     -8.69483866e-01     -8.60270950e-01      0.000000000000      8.04588492e-01      7.68036662e-01     -5.71988393e-01      9.66911430e-01      6.01865489e-01    
x16   8.65925683e-01      8.15561951e-01     -3.30828155e-01      6.81970869e-02     -3.56658125e-01     -8.10672160e-01      6.75992156e-02     -9.79728919e-01      7.55621690e-02     -5.71912353e-01      4.09051404e-01      8.47771499e-02     -3.76636262e-01     -7.30413672e-01      8.04588492e-01      0.000000000000      1.28715858e-01      6.21802103e-01     -3.70535705e-01     -5.51102775e-01    
x17   6.90817456e-01      7.94985190e-01     -7.98652877e-01     -5.84824497e-01      6.13828059e-01      1.49590802e-01      6.71304493e-01     -5.05785217e-01     -8.71230648e-01     -9.63178851e-01     -9.57006610e-01     -4.73013080e-01     -9.89167440e-01      8.61440785e-01      7.68036662e-01      1.28715858e-01      0.000000000000     -4.02733282e-01     -4.49561096e-02      8.72607663e-01    
x18   3.39018781e-01      6.75406312e-01     -1.52812741e-01      9.88600596e-01     -7.16443971e-01     -4.36693941e-01     -5.33844503e-02     -6.19577871e-01      8.00172090e-01     -4.57162512e-01      6.40644979e-01     -9.75991999e-01     -2.59204708e-01     -9.78469613e-01     -5.71988393e-01      6.21802103e-01     -4.02733282e-01      0.000000000000     -5.61101294e-01      6.82833240e-01    
x19   3.56813941e-01      7.99700031e-01      6.85970281e-01      7.07832713e-01      1.44229213e-01     -4.11490589e-01      1.71445574e-01     -3.24312319e-01      3.53434440e-01     -6.35833992e-01     -5.81253377e-01      1.09934875e-01      7.18373973e-01     -1.30563923e-01      9.66911430e-01     -3.70535705e-01     -4.49561096e-02     -5.61101294e-01      0.000000000000     -3.40706114e-01    
x20  -4.27725867e-01     -5.81586642e-01     -1.76962399e-01     -4.74438515e-01      1.13639768e-03     -5.23529910e-01      7.95847947e-01     -4.76177532e-01      3.19545938e-01     -2.21048053e-01      6.07565017e-01     -9.40567887e-03      7.35196184e-01     -5.29382966e-01      6.01865489e-01     -5.51102775e-01      8.72607663e-01      6.82833240e-01     -3.40706114e-01      0.000000000000    
 ;

TABLE cmat(QuadCons,jj)
                x1                 x2                 x3                 x4                 x5                 x6                 x7                 x8                 x9                 x10                 x11                 x12                 x13                 x14                 x15                 x16                 x17                 x18                 x19                 x20                
qc1  3.94857169e-01     -2.21704933e-01      1.75107121e-01     -9.02597899e-01      7.52359862e-01      3.54426120e-01      1.57021251e-01      8.28945405e-02      8.91504337e-01     -3.24063268e-01      4.42365027e-01      6.45222683e-01     -3.13771336e-01      4.74635135e-01     -6.96253013e-02     -8.31061627e-01     -3.00245397e-01     -1.02943350e-01      4.52313226e-01      9.34591318e-01    
 ;

TABLE Q(j,jj,QuadCons)
                      qc1               
x1.x1    
x1.x2     -9.30946610e-01    
x1.x3      6.84701377e-01    
x1.x4      4.43794304e-01    
x1.x5      6.22805764e-01    
x1.x6     -4.24913524e-01    
x1.x7     -3.42626208e-01    
x1.x8     -2.62185912e-01    
x1.x9      9.04685232e-01    
x1.x10      7.71060457e-01    
x1.x11     -8.53214938e-01    
x1.x12      4.74072733e-01    
x1.x13     -9.18724251e-01    
x1.x14      9.33427349e-01    
x1.x15     -3.35169299e-01    
x1.x16     -7.25623850e-01    
x1.x17      8.90043172e-01    
x1.x18     -3.97555648e-01    
x1.x19      6.23714055e-01    
x1.x20     -1.76437172e-01    
x2.x1     -9.30946610e-01      
 x2.x2    
x2.x3      2.95475265e-01    
x2.x4     -5.98549960e-01    
x2.x5      9.40539876e-01    
x2.x6     -6.48877061e-02    
x2.x7     -7.96790629e-02    
x2.x8      7.00218845e-01    
x2.x9     -6.71228687e-01    
x2.x10      8.54061704e-01    
x2.x11      8.25337120e-01    
x2.x12      5.69287364e-01    
x2.x13     -4.56109747e-01    
x2.x14      6.80040417e-01    
x2.x15      2.47862753e-01    
x2.x16     -1.48899429e-01    
x2.x17     -9.00062394e-01    
x2.x18      1.04692354e-01    
x2.x19     -9.55947160e-01    
x2.x20     -4.00969293e-01    
x3.x1      6.84701377e-01      
 x3.x2      2.95475265e-01      
 x3.x3    
x3.x4      9.40148211e-01    
x3.x5      3.08890263e-01    
x3.x6     -8.59039588e-01    
x3.x7      4.68439173e-01    
x3.x8      4.03018044e-01    
x3.x9     -9.57947315e-01    
x3.x10      3.23660823e-01    
x3.x11     -1.39460253e-01    
x3.x12      1.39248290e-02    
x3.x13     -8.75292420e-01    
x3.x14      8.54611858e-01    
x3.x15     -6.26629134e-01    
x3.x16      5.21570883e-01    
x3.x17      1.28701124e-02    
x3.x18     -3.72493376e-02    
x3.x19      2.91551388e-02    
x3.x20     -7.80200898e-01    
x4.x1      4.43794304e-01      
 x4.x2     -5.98549960e-01      
 x4.x3      9.40148211e-01      
 x4.x4    
x4.x5     -4.49240535e-02    
x4.x6     -3.65089105e-03    
x4.x7     -6.58525284e-01    
x4.x8      6.02947292e-01    
x4.x9     -8.29036154e-01    
x4.x10      2.83575285e-01    
x4.x11      9.17284671e-01    
x4.x12     -5.74202170e-02    
x4.x13     -9.87241056e-01    
x4.x14     -6.15670441e-01    
x4.x15     -1.13789473e-01    
x4.x16     -6.42415721e-02    
x4.x17      2.31938487e-01    
x4.x18     -9.06092563e-01    
x4.x19      9.39454059e-01    
x4.x20      9.94716568e-02    
x5.x1      6.22805764e-01      
 x5.x2      9.40539876e-01      
 x5.x3      3.08890263e-01      
 x5.x4     -4.49240535e-02      
 x5.x5    
x5.x6      4.70254187e-01    
x5.x7     -1.24114279e-01    
x5.x8      9.79613253e-01    
x5.x9      6.49053646e-01    
x5.x10      5.02143337e-01    
x5.x11     -6.12111749e-01    
x5.x12      6.71398906e-01    
x5.x13     -1.80110678e-01    
x5.x14      3.56723672e-01    
x5.x15      4.53891493e-01    
x5.x16      8.06705266e-01    
x5.x17      4.56250071e-01    
x5.x18     -3.92620211e-01    
x5.x19      3.98529157e-01    
x5.x20      6.32366571e-01    
x6.x1     -4.24913524e-01      
 x6.x2     -6.48877061e-02      
 x6.x3     -8.59039588e-01      
 x6.x4     -3.65089105e-03      
 x6.x5      4.70254187e-01      
 x6.x6    
x6.x7     -6.09024791e-01    
x6.x8      1.89299186e-01    
x6.x9     -1.21299872e-01    
x6.x10      9.89450823e-01    
x6.x11      6.87777335e-01    
x6.x12     -1.08487815e-01    
x6.x13      2.50284934e-01    
x6.x14     -7.46205188e-01    
x6.x15     -9.85599552e-01    
x6.x16      4.31232089e-01    
x6.x17     -8.81648341e-01    
x6.x18     -1.52079922e-01    
x6.x19      8.69441087e-01    
x6.x20      8.54518774e-01    
x7.x1     -3.42626208e-01      
 x7.x2     -7.96790629e-02      
 x7.x3      4.68439173e-01      
 x7.x4     -6.58525284e-01      
 x7.x5     -1.24114279e-01      
 x7.x6     -6.09024791e-01      
 x7.x7    
x7.x8     -2.50929789e-01    
x7.x9     -5.82432463e-01    
x7.x10     -9.97916885e-01    
x7.x11     -2.24722697e-01    
x7.x12     -7.13987687e-01    
x7.x13      1.17729229e-01    
x7.x14     -3.40382183e-01    
x7.x15     -4.53249941e-01    
x7.x16      3.31599300e-01    
x7.x17      6.36482062e-01    
x7.x18      3.84453808e-01    
x7.x19     -2.17997874e-01    
x7.x20     -1.08505772e-01    
x8.x1     -2.62185912e-01      
 x8.x2      7.00218845e-01      
 x8.x3      4.03018044e-01      
 x8.x4      6.02947292e-01      
 x8.x5      9.79613253e-01      
 x8.x6      1.89299186e-01      
 x8.x7     -2.50929789e-01      
 x8.x8    
x8.x9     -5.39159163e-01    
x8.x10      5.57869448e-01    
x8.x11      8.00233372e-01    
x8.x12     -5.35222230e-01    
x8.x13      3.30980166e-01    
x8.x14      4.36856386e-01    
x8.x15      6.33654163e-01    
x8.x16     -9.19645583e-01    
x8.x17      9.84467665e-01    
x8.x18      7.80554989e-01    
x8.x19     -1.63067246e-01    
x8.x20     -8.38900837e-01    
x9.x1      9.04685232e-01      
 x9.x2     -6.71228687e-01      
 x9.x3     -9.57947315e-01      
 x9.x4     -8.29036154e-01      
 x9.x5      6.49053646e-01      
 x9.x6     -1.21299872e-01      
 x9.x7     -5.82432463e-01      
 x9.x8     -5.39159163e-01      
 x9.x9    
x9.x10     -7.42030522e-01    
x9.x11     -9.83717813e-01    
x9.x12     -8.34055836e-04    
x9.x13     -5.23129614e-01    
x9.x14     -3.08517903e-01    
x9.x15     -8.15045024e-01    
x9.x16      5.81567100e-01    
x9.x17      2.45428511e-01    
x9.x18      7.78134780e-01    
x9.x19      4.20069884e-01    
x9.x20     -5.15879505e-01    
x10.x1      7.71060457e-01      
 x10.x2      8.54061704e-01      
 x10.x3      3.23660823e-01      
 x10.x4      2.83575285e-01      
 x10.x5      5.02143337e-01      
 x10.x6      9.89450823e-01      
 x10.x7     -9.97916885e-01      
 x10.x8      5.57869448e-01      
 x10.x9     -7.42030522e-01      
 x10.x10    
x10.x11     -3.43965898e-01    
x10.x12      9.61776867e-01    
x10.x13      9.21822105e-01    
x10.x14      5.45312007e-01    
x10.x15     -3.11049374e-01    
x10.x16     -7.04405350e-01    
x10.x17      7.48493397e-01    
x10.x18      3.67447528e-01    
x10.x19     -5.83784551e-01    
x10.x20      1.24460819e-01    
x11.x1     -8.53214938e-01      
 x11.x2      8.25337120e-01      
 x11.x3     -1.39460253e-01      
 x11.x4      9.17284671e-01      
 x11.x5     -6.12111749e-01      
 x11.x6      6.87777335e-01      
 x11.x7     -2.24722697e-01      
 x11.x8      8.00233372e-01      
 x11.x9     -9.83717813e-01      
 x11.x10     -3.43965898e-01      
 x11.x11    
x11.x12     -1.02836477e-01    
x11.x13     -2.64756600e-01    
x11.x14     -3.54147933e-01    
x11.x15      9.53232879e-01    
x11.x16      2.76312734e-01    
x11.x17     -8.32153420e-02    
x11.x18     -8.52018212e-01    
x11.x19     -6.61457475e-01    
x11.x20      6.06259670e-01    
x12.x1      4.74072733e-01      
 x12.x2      5.69287364e-01      
 x12.x3      1.39248290e-02      
 x12.x4     -5.74202170e-02      
 x12.x5      6.71398906e-01      
 x12.x6     -1.08487815e-01      
 x12.x7     -7.13987687e-01      
 x12.x8     -5.35222230e-01      
 x12.x9     -8.34055836e-04      
 x12.x10      9.61776867e-01      
 x12.x11     -1.02836477e-01      
 x12.x12    
x12.x13     -4.58614762e-01    
x12.x14     -4.57477471e-01    
x12.x15     -6.63021029e-01    
x12.x16      5.98726357e-02    
x12.x17      9.05861519e-01    
x12.x18      1.50579257e-01    
x12.x19      3.08717389e-02    
x12.x20      9.43178668e-01    
x13.x1     -9.18724251e-01      
 x13.x2     -4.56109747e-01      
 x13.x3     -8.75292420e-01      
 x13.x4     -9.87241056e-01      
 x13.x5     -1.80110678e-01      
 x13.x6      2.50284934e-01      
 x13.x7      1.17729229e-01      
 x13.x8      3.30980166e-01      
 x13.x9     -5.23129614e-01      
 x13.x10      9.21822105e-01      
 x13.x11     -2.64756600e-01      
 x13.x12     -4.58614762e-01      
 x13.x13    
x13.x14     -8.08968477e-01    
x13.x15      4.92876298e-01    
x13.x16     -3.02669964e-01    
x13.x17      1.98673430e-01    
x13.x18     -2.92171037e-01    
x13.x19     -8.28125358e-01    
x13.x20      2.01510916e-01    
x14.x1      9.33427349e-01      
 x14.x2      6.80040417e-01      
 x14.x3      8.54611858e-01      
 x14.x4     -6.15670441e-01      
 x14.x5      3.56723672e-01      
 x14.x6     -7.46205188e-01      
 x14.x7     -3.40382183e-01      
 x14.x8      4.36856386e-01      
 x14.x9     -3.08517903e-01      
 x14.x10      5.45312007e-01      
 x14.x11     -3.54147933e-01      
 x14.x12     -4.57477471e-01      
 x14.x13     -8.08968477e-01      
 x14.x14    
x14.x15      3.80820538e-01    
x14.x16      8.68455832e-01    
x14.x17     -8.13956233e-01    
x14.x18      6.35471691e-01    
x14.x19     -1.33077887e-01    
x14.x20     -2.60413365e-03    
x15.x1     -3.35169299e-01      
 x15.x2      2.47862753e-01      
 x15.x3     -6.26629134e-01      
 x15.x4     -1.13789473e-01      
 x15.x5      4.53891493e-01      
 x15.x6     -9.85599552e-01      
 x15.x7     -4.53249941e-01      
 x15.x8      6.33654163e-01      
 x15.x9     -8.15045024e-01      
 x15.x10     -3.11049374e-01      
 x15.x11      9.53232879e-01      
 x15.x12     -6.63021029e-01      
 x15.x13      4.92876298e-01      
 x15.x14      3.80820538e-01      
 x15.x15    
x15.x16     -3.15616044e-01    
x15.x17     -4.98165829e-01    
x15.x18     -7.19145636e-01    
x15.x19      9.28424027e-01    
x15.x20     -9.76940167e-01    
x16.x1     -7.25623850e-01      
 x16.x2     -1.48899429e-01      
 x16.x3      5.21570883e-01      
 x16.x4     -6.42415721e-02      
 x16.x5      8.06705266e-01      
 x16.x6      4.31232089e-01      
 x16.x7      3.31599300e-01      
 x16.x8     -9.19645583e-01      
 x16.x9      5.81567100e-01      
 x16.x10     -7.04405350e-01      
 x16.x11      2.76312734e-01      
 x16.x12      5.98726357e-02      
 x16.x13     -3.02669964e-01      
 x16.x14      8.68455832e-01      
 x16.x15     -3.15616044e-01      
 x16.x16    
x16.x17     -9.45241998e-01    
x16.x18     -1.02179203e-01    
x16.x19     -7.45400841e-01    
x16.x20      3.71172436e-01    
x17.x1      8.90043172e-01      
 x17.x2     -9.00062394e-01      
 x17.x3      1.28701124e-02      
 x17.x4      2.31938487e-01      
 x17.x5      4.56250071e-01      
 x17.x6     -8.81648341e-01      
 x17.x7      6.36482062e-01      
 x17.x8      9.84467665e-01      
 x17.x9      2.45428511e-01      
 x17.x10      7.48493397e-01      
 x17.x11     -8.32153420e-02      
 x17.x12      9.05861519e-01      
 x17.x13      1.98673430e-01      
 x17.x14     -8.13956233e-01      
 x17.x15     -4.98165829e-01      
 x17.x16     -9.45241998e-01      
 x17.x17    
x17.x18     -8.47750359e-01    
x17.x19      5.98413429e-02    
x17.x20      9.47131404e-01    
x18.x1     -3.97555648e-01      
 x18.x2      1.04692354e-01      
 x18.x3     -3.72493376e-02      
 x18.x4     -9.06092563e-01      
 x18.x5     -3.92620211e-01      
 x18.x6     -1.52079922e-01      
 x18.x7      3.84453808e-01      
 x18.x8      7.80554989e-01      
 x18.x9      7.78134780e-01      
 x18.x10      3.67447528e-01      
 x18.x11     -8.52018212e-01      
 x18.x12      1.50579257e-01      
 x18.x13     -2.92171037e-01      
 x18.x14      6.35471691e-01      
 x18.x15     -7.19145636e-01      
 x18.x16     -1.02179203e-01      
 x18.x17     -8.47750359e-01      
 x18.x18    
x18.x19     -8.61932353e-01    
x18.x20     -8.21285147e-01    
x19.x1      6.23714055e-01      
 x19.x2     -9.55947160e-01      
 x19.x3      2.91551388e-02      
 x19.x4      9.39454059e-01      
 x19.x5      3.98529157e-01      
 x19.x6      8.69441087e-01      
 x19.x7     -2.17997874e-01      
 x19.x8     -1.63067246e-01      
 x19.x9      4.20069884e-01      
 x19.x10     -5.83784551e-01      
 x19.x11     -6.61457475e-01      
 x19.x12      3.08717389e-02      
 x19.x13     -8.28125358e-01      
 x19.x14     -1.33077887e-01      
 x19.x15      9.28424027e-01      
 x19.x16     -7.45400841e-01      
 x19.x17      5.98413429e-02      
 x19.x18     -8.61932353e-01      
 x19.x19    
x19.x20     -5.86134935e-01    
x20.x1     -1.76437172e-01      
 x20.x2     -4.00969293e-01      
 x20.x3     -7.80200898e-01      
 x20.x4      9.94716568e-02      
 x20.x5      6.32366571e-01      
 x20.x6      8.54518774e-01      
 x20.x7     -1.08505772e-01      
 x20.x8     -8.38900837e-01      
 x20.x9     -5.15879505e-01      
 x20.x10      1.24460819e-01      
 x20.x11      6.06259670e-01      
 x20.x12      9.43178668e-01      
 x20.x13      2.01510916e-01      
 x20.x14     -2.60413365e-03      
 x20.x15     -9.76940167e-01      
 x20.x16      3.71172436e-01      
 x20.x17      9.47131404e-01      
 x20.x18     -8.21285147e-01      
 x20.x19     -5.86134935e-01      
 x20.x20    
 ;

SET mccSet(Vars,Vars)  pairs with large diff for mcc relaxation  / 
x1.x2 
  x1.x3 
  x1.x4 
  x1.x5 
  x1.x6 
  x1.x7 
  x1.x8 
  x1.x9 
  x1.x10 
  x1.x11 
  x1.x12 
  x1.x13 
  x1.x14 
  x1.x15 
  x1.x16 
  x1.x17 
  x1.x18 
  x1.x19 
  x1.x20 
  x2.x3 
  x2.x4 
  x2.x5 
  x2.x6 
  x2.x7 
  x2.x8 
  x2.x9 
  x2.x10 
  x2.x11 
  x2.x12 
  x2.x13 
  x2.x14 
  x2.x15 
  x2.x16 
  x2.x17 
  x2.x18 
  x2.x19 
  x2.x20 
  x3.x5 
  x3.x6 
  x3.x7 
  x3.x8 
  x3.x9 
  x3.x10 
  x3.x11 
  x3.x12 
  x3.x13 
  x3.x14 
  x3.x15 
  x3.x16 
  x3.x17 
  x3.x18 
  x3.x19 
  x3.x20 
  x4.x5 
  x4.x6 
  x4.x7 
  x4.x8 
  x4.x9 
  x4.x10 
  x4.x11 
  x4.x12 
  x4.x13 
  x4.x14 
  x4.x15 
  x4.x16 
  x4.x17 
  x4.x18 
  x4.x19 
  x4.x20 
  x5.x6 
  x5.x7 
  x5.x8 
  x5.x9 
  x5.x10 
  x5.x11 
  x5.x12 
  x5.x13 
  x5.x14 
  x5.x15 
  x5.x16 
  x5.x17 
  x5.x18 
  x5.x19 
  x5.x20 
  x6.x7 
  x6.x8 
  x6.x9 
  x6.x10 
  x6.x11 
  x6.x12 
  x6.x13 
  x6.x14 
  x6.x15 
  x6.x16 
  x6.x17 
  x6.x18 
  x6.x19 
  x6.x20 
  x7.x8 
  x7.x9 
  x7.x10 
  x7.x11 
  x7.x12 
  x7.x13 
  x7.x14 
  x7.x15 
  x7.x16 
  x7.x17 
  x7.x18 
  x7.x19 
  x7.x20 
  x8.x9 
  x8.x10 
  x8.x11 
  x8.x12 
  x8.x13 
  x8.x14 
  x8.x15 
  x8.x16 
  x8.x17 
  x8.x18 
  x8.x19 
  x8.x20 
  x9.x10 
  x9.x11 
  x9.x12 
  x9.x13 
  x9.x14 
  x9.x15 
  x9.x16 
  x9.x17 
  x9.x18 
  x9.x19 
  x9.x20 
  x10.x11 
  x10.x12 
  x10.x13 
  x10.x14 
  x10.x15 
  x10.x16 
  x10.x17 
  x10.x18 
  x10.x19 
  x10.x20 
  x11.x12 
  x11.x13 
  x11.x14 
  x11.x15 
  x11.x16 
  x11.x17 
  x11.x18 
  x11.x19 
  x11.x20 
  x12.x13 
  x12.x14 
  x12.x15 
  x12.x16 
  x12.x17 
  x12.x18 
  x12.x19 
  x12.x20 
  x13.x14 
  x13.x15 
  x13.x16 
  x13.x17 
  x13.x18 
  x13.x19 
  x13.x20 
  x14.x15 
  x14.x16 
  x14.x17 
  x14.x18 
  x14.x19 
  x14.x20 
  x15.x16 
  x15.x17 
  x15.x18 
  x15.x19 
  x15.x20 
  x16.x17 
  x16.x18 
  x16.x19 
  x16.x20 
  x17.x18 
  x17.x19 
  x17.x20 
  x18.x19 
  x18.x20 
  x19.x20 
   / ; 

SET socSet(Vars,Vars)  pairs with large diff for soc relaxation  / 
x1.x3 
  x1.x4 
  x1.x5 
  x1.x7 
  x1.x8 
  x1.x9 
  x1.x10 
  x1.x11 
  x1.x12 
  x1.x13 
  x1.x14 
  x1.x17 
  x1.x18 
  x1.x19 
  x2.x4 
  x2.x7 
  x2.x8 
  x2.x9 
  x2.x10 
  x2.x12 
  x2.x14 
  x2.x16 
  x2.x17 
  x2.x18 
  x2.x20 
  x3.x4 
  x3.x6 
  x3.x7 
  x3.x8 
  x3.x9 
  x3.x10 
  x3.x11 
  x3.x12 
  x3.x14 
  x3.x16 
  x3.x17 
  x3.x18 
  x3.x19 
  x4.x5 
  x4.x6 
  x4.x7 
  x4.x8 
  x4.x9 
  x4.x10 
  x4.x11 
  x4.x12 
  x4.x13 
  x4.x14 
  x4.x15 
  x4.x16 
  x4.x17 
  x4.x18 
  x4.x19 
  x4.x20 
  x5.x6 
  x5.x7 
  x5.x8 
  x5.x9 
  x5.x10 
  x5.x11 
  x5.x12 
  x5.x13 
  x5.x14 
  x5.x15 
  x5.x17 
  x5.x18 
  x6.x7 
  x6.x8 
  x6.x9 
  x6.x10 
  x6.x12 
  x6.x14 
  x6.x17 
  x6.x18 
  x6.x19 
  x6.x20 
  x7.x8 
  x7.x9 
  x7.x10 
  x7.x11 
  x7.x12 
  x7.x13 
  x7.x14 
  x7.x15 
  x7.x16 
  x7.x17 
  x7.x18 
  x7.x19 
  x7.x20 
  x8.x9 
  x8.x10 
  x8.x11 
  x8.x12 
  x8.x13 
  x8.x14 
  x8.x15 
  x8.x16 
  x8.x17 
  x8.x18 
  x8.x19 
  x8.x20 
  x9.x10 
  x9.x11 
  x9.x12 
  x9.x13 
  x9.x14 
  x9.x15 
  x9.x16 
  x9.x17 
  x9.x18 
  x9.x19 
  x9.x20 
  x10.x11 
  x10.x12 
  x10.x13 
  x10.x14 
  x10.x15 
  x10.x16 
  x10.x17 
  x10.x18 
  x10.x19 
  x10.x20 
  x11.x12 
  x11.x14 
  x11.x15 
  x11.x16 
  x11.x17 
  x11.x18 
  x11.x19 
  x12.x13 
  x12.x14 
  x12.x15 
  x12.x16 
  x12.x17 
  x12.x18 
  x12.x19 
  x12.x20 
  x13.x14 
  x13.x17 
  x13.x18 
  x14.x15 
  x14.x16 
  x14.x17 
  x14.x18 
  x14.x19 
  x14.x20 
  x15.x16 
  x15.x17 
  x15.x18 
  x16.x17 
  x16.x18 
  x16.x19 
  x16.x20 
  x17.x18 
  x17.x19 
  x17.x20 
  x18.x19 
  x18.x20 
   / ; 

SET UseSOC(Vars,Vars);
SET notSOC(Vars,Vars);
UseSOC(Vars,Vars)=no;
UseSOC(mccSet)=yes;
UseSOC(socSet)=no;
notSOC(Vars,Vars)=no;
notSOC(Pairs)=yes;
notSOC(UseSOC)=no;
*problem 4 : LBmcc  -1.23847901e+01, LBsocpP  -5.39898744e+00, UBo  -4.21165132e-02
 
POSITIVE VARIABLES x(j);

VARIABLES z;

EQUATIONS
   OBJective
   xub
   cQ(QuadCons)
   conLBP(j,jj)
   conUBP(j,jj)
   conLBM(j,jj)
   conUBM(j,jj);

OBJective.. z =e= SUM(j, c0(j) * x(j))
  + 0.5 * SUM((j,jj)$(ord(jj) gt ord(j)),x(j) * Q0(j,jj)  * x(jj));

xub(j)..  x(j) =l= 1;

cQ(QuadCons).. g(QuadCons) =g=
  SUM(j, cmat(QuadCons,j)*x(j)) +
  0.5 * SUM((j,jj)$(ord(jj) gt ord(j)), Q(j,jj,QuadCons) *x(j) * x(jj));

conLBP(j,jj)$(ord(jj) gt ord(j)) .. 0.5 =l= x(jj) + x(j);

conUBP(j,jj)$(ord(jj) gt ord(j)) .. 1.5 =g= x(jj) + x(j);

conLBM(j,jj)$(ord(jj) gt ord(j)) .. -0.5 =l= x(jj) - x(j);

conUBM(j,jj)$(ord(jj) gt ord(j)) .. 0.5 =g= x(jj) - x(j);

model diam  /all/;

solve diam using nlp minimizing z;
