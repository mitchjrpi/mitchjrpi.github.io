c
c  This routine generates a random maxcut problem.
c    The problems correspond to Ising spin glasses.
c    The graph is a GRIDSIZE by GRIDSIZE grid embedded on a torus.
c
c    References include:
c
c@techreport{desimone1,
c    AUTHOR  =  {C. De Simone and M. Diehl and M. J\"{u}nger and
c                  P. Mutzel and G. Reinelt and G. Rinaldi},
c    TITLE   =  {Exact ground states of Ising spin glasses:
c                  {New} experimental results with a branch and cut algorithm},
c    YEAR    =  1995,
c    INSTITUTION={Instit\"{u}t f\"{u}r Informatik, Universit\"{a}t zu K\"{o}ln},
c    ADDRESS =  {Pohligstra{\ss}e 1, D--50969, K\"{o}ln, Germany}  }
c
c@article{BJR2,
c    AUTHOR  =  {F. Barahona and M. Gr\"{o}tschel and
c                    M. J{\"{u}}nger and G. Reinelt},
c    TITLE   =  {An application of combinatorial optimization to statistical
c                     physics and circuit layout design},
c    JOURNAL =  {Operations Research},
c    YEAR    =  1988,
c    VOLUME  =  {36(3)},
c    PAGES   =  {493--513}   }
c
c  In this routine, the number of +1's and -1's may differ.
c
      IMPLICIT NONE
c
c  Local variables.
c
      INTEGER I,J,K,PREVIOUS
      INTEGER GRIDSIZE,NVERT,NEDGE,C(20000),TOTALC
c
c  Stuff for the random number generator.
c
      REAL*8 DRAND
      INTEGER*4 ISEED
      COMMON /RANDOM/ISEED
c
c  The vertices are numbered row by row from left to right.
c  The horizontal edges are numbered first, and then the vertical edges.
c

      OPEN(7,FILE='fort.7')
      READ(7,*) GRIDSIZE, ISEED
      NVERT = GRIDSIZE*GRIDSIZE
      NEDGE = 2*NVERT
      WRITE(6,9010) NVERT,NEDGE,ISEED

c
c  Generate the objective function.
c    The cost is either =1 or -1.
c
      TOTALC = 0
      DO 80 I=1,NEDGE
        J=2.D0*DRAND()
        C(I) = 2*J-1
        TOTALC = TOTALC + C(I)
   80 CONTINUE



c
c  write out the edge lengths
c
c    first the horizontal edges
c
      K=0
      DO 200 I=0,GRIDSIZE-1
        PREVIOUS=I*GRIDSIZE
        DO 150 J=1,GRIDSIZE-1
          K=K+1
          WRITE(6,9000)PREVIOUS+J,PREVIOUS+J+1,C(K)
  150   CONTINUE
        K=K+1
        WRITE(6,9000)PREVIOUS+GRIDSIZE,PREVIOUS+1,C(K)
  200 CONTINUE
c
c    and now the vertical edges
c
      DO 400 I=0,GRIDSIZE-2
        PREVIOUS=I*GRIDSIZE
        DO 350 J=1,GRIDSIZE
          K=K+1
          WRITE(6,9000)PREVIOUS+J,PREVIOUS+J+GRIDSIZE,C(K)
  350   CONTINUE
  400 CONTINUE

      PREVIOUS=GRIDSIZE*(GRIDSIZE-1)
      DO 550 J=1,GRIDSIZE
        K=K+1
        WRITE(6,9000)PREVIOUS+J,J,C(K)
  550 CONTINUE
c
 9000 FORMAT(2I6,I4)
 9010 FORMAT(3I8)
c
      STOP
      END
