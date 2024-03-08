c
c  This routine generates a clustering problem in the random
c   manner described in    G. Palubeckis, ORSA JOC 9 (1997) 30--42:
c
c   Characteristics take the values 0,1,2 uniformly distributed.
c
c
      PROGRAM INITPGP
c
c  For the sake of safety, insist on explicit types for each variable.
c
      IMPLICIT NONE
c
c  Parameters of this routine.
c
      INTEGER NOBSVN,NCHAR
      INTEGER OBSVN(1000,20)
c
c  Local variables.
c
      INTEGER I,J
c
c  Stuff for the random number generator.
c
      REAL*8 DRAND
      INTEGER*4 ISEED
      COMMON /RANDOM/ISEED
c
c  Read in the data.
c
      OPEN(17,FILE='fort.17')
      READ(17,*) NOBSVN,NCHAR,ISEED
c
c  Write out the data
c
      WRITE(6,*) 'Number of observations: ',NOBSVN
      WRITE(6,*) 'Number of characteristics: ',NCHAR
      WRITE(6,*) 'ISEED: ',ISEED
c
      IF (NOBSVN .GT. 1000) THEN
        WRITE(6,*) 'Number of observations must be no larger than 1000'
        STOP
      ENDIF
      IF (NCHAR .GT. 20) THEN
        WRITE(6,*) 'Number of characteristics must be no bigger than 20'
        STOP
      ENDIF
      DO 1000 I=1,NOBSVN
        DO 400 J=1,NCHAR
              OBSVN(I,J)=3*DRAND()
  400   CONTINUE
 1000 CONTINUE

      WRITE(6,*)'Observations:'
      DO 1200 I=1,NOBSVN
        WRITE(6,9990)I,(OBSVN(I,J),J=1,NCHAR)
 1200 CONTINUE

 9990 FORMAT(I4,':',20I3)
      STOP
      END
