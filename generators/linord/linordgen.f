c
c  This routine generates a random DEGENERATE linear ordering problem.
c    The coefficients mat_ij are uniformly distributed between 0 and 99
c    for i < j,and uniformly distributed between 0 and (100*RATIO)-1
c    for i > j.  They are INTEGRAL.
c
c    Further, PROPZERO of the coefficients are zero.
c
c  The objective is to find an ordering that maximizes the
c    sum MAT(I,J) : I is before J in the ordering
c
c  The program reads in four parameters from the file fort.15:
c
c     MATSIZE:   The number of sectors in the instance. Can be no larger
c                than 250.
c     ISEED:     A random seed.
c     RATIO and PROPZERO:  See the first two paragraphs.
c
c  MATSIZE and ISEED are integers, the other two numbers can be anything
c     between 0 and 1. The format of file  fort.15  is
c     MATSIZE, ISEED, RATIO, PROPZERO
c
c  So that it is not too easy to guess a good solution, the columns and
c     rows are randomly permuted before the coefficients are calculated.
c
c  All output is sent to the standard output.
c     Some descriptions of the instance are written out first,
c     and then finally the entries MAT(I,J) are written out.
c
c
c
      PROGRAM  LINORD
c
c  For the sake of safety, insist on explicit types for each variable.
c
      IMPLICIT NONE
c
c  Parameters of this routine.
c
      INTEGER  MATSIZE,MAT(250,250)
      INTEGER  PERM(250),WORK1(250),WORK2(250)
      INTEGER  I,J,K
      REAL*8   PROPZERO,PERMOBJ
c
c  Stuff for the random number generator.
c
      REAL*8 DRAND,RATIO
      INTEGER*4 ISEED
      COMMON /RANDOM/ISEED
c

c
c  First, generate the problem data, constant offset, and sum of entries.
c
      OPEN(15,FILE='fort.15')
      READ(15,*) MATSIZE, ISEED,RATIO,PROPZERO
      WRITE(6,*) 'MATSIZE is ',MATSIZE
      WRITE(6,*) 'Seed is ',ISEED
      WRITE(6,*) 'Ratio is ',RATIO
      WRITE(6,*)'Proportion of cost coeffs that are zero: ',PROPZERO
      IF (MATSIZE .GT. 250) THEN
        WRITE(6,*)'MATSIZE can be no larger than 250;  STOP'
        STOP
      ENDIF
      PERMOBJ = 0.D0
c
c  Generate the entries using a random permutation.
c
c
c  First generate the random permutation PERM
c
      DO 2 I=1,MATSIZE
        MAT(I,I)=0
        WORK1(I)=10000*DRAND()
    2 CONTINUE
      CALL SORT(MATSIZE,WORK1,PERM,WORK2)
      WRITE(6,*)'Permutation:'
      WRITE(6,991)(PERM(I),I=MATSIZE,1,-1)
      DO 5 I=1,MATSIZE
         DO 5 J=1,MATSIZE
          IF (DRAND() .GT. PROPZERO) THEN
            K = 100*DRAND()
            MAT(PERM(I),PERM(J)) = K
           ELSE
            MAT(PERM(I),PERM(J)) = 0
          ENDIF
          IF (DRAND() .GT. PROPZERO) THEN
            K = 100*RATIO*DRAND()
            MAT(PERM(J),PERM(I)) = K
           ELSE
            MAT(PERM(J),PERM(I)) = 0
          ENDIF
    5 CONTINUE

      DO 10 I=1,MATSIZE
        MAT(I,I)=0
        DO 10 J=I+1,MATSIZE
          PERMOBJ=PERMOBJ-MAT(PERM(I),PERM(J))+MAT(PERM(J),PERM(I))
   10 CONTINUE
c

      WRITE(6,*) 'The generating permutation has value ',PERMOBJ
c
c  Write out the matrix
c
      WRITE(6,*)'The entries of the matrix:'
      DO 100 I=1,MATSIZE
        DO 100 J=1,MATSIZE
  100     WRITE(6,990)MAT(I,J)
c
  990 FORMAT(I3)
  991 FORMAT(15I4)
c
      STOP
      END
c
c  This subroutine sorts integers into ascending order.
c
      SUBROUTINE SORT(N,RAW,ORDER,SORTED)

      IMPLICIT NONE

      INTEGER  N,RAW(*),ORDER(*),SORTED(*)
c
c  N is the number of integers
c
c  RAW contains the numbers
c  SORTED contains the numbers sorted.
c
c  ORDER contains the result.  RAW(ORDER(I)) gives the Ith
c    highest entry in RAW
c
      INTEGER  I,LIST1(1024),LIST2(1024)
      INTEGER  ORDER1(1024),ORDER2(1024)
      INTEGER  LLENG1,LLENG2,LENGTH,LOOP,INDEX,INDEX0
c
c  We merge longer and longer lists.
c
c      WRITE(6,*)'Original data:'
c      WRITE(6,1200)(RAW(I),I=1,N)
c
c  Initialize
c
      DO 100 I=1,N
        ORDER(I)=I
  100   SORTED(I)=RAW(I)
c
      LENGTH=1
c
c  Perform up to 12 sets of merges, so we go from lists of length 1 to
c    lists of length 2 to lists of length 4 etc.
c
      DO 1000 LOOP=1,12
        INDEX=0
        IF (LENGTH .GE. N) GOTO 1010
c
c  Sort each sublist.
c
  200   CONTINUE
        IF (LENGTH+INDEX .GE. N) GOTO 990
        LLENG1=LENGTH
        LLENG2=MIN(LENGTH,N-INDEX-LENGTH)
        INDEX0=INDEX
        DO 250 I=1,LLENG1
          INDEX0=INDEX0+1
          LIST1(I)=SORTED(INDEX0)
          ORDER1(I)=ORDER(INDEX0)
  250   CONTINUE
        DO 260 I=1,LLENG2
          INDEX0=INDEX0+1
          LIST2(I)=SORTED(INDEX0)
          ORDER2(I)=ORDER(INDEX0)
  260   CONTINUE
        CALL MERGE(LLENG1,LLENG2,LIST1,LIST2,ORDER1,ORDER2)
        DO 320 I=1,LLENG1+LLENG2
          INDEX=INDEX+1
          SORTED(INDEX)=LIST1(I)
          ORDER(INDEX)=ORDER1(I)
  320   CONTINUE
        GOTO 200
  990   CONTINUE
c        WRITE(6,*)'After ',LOOP,' loop, get:'
c        WRITE(6,*)'Sorted data:'
c        WRITE(6,1200)(SORTED(I),I=1,N)
c        WRITE(6,*)'ORDER:'
c        WRITE(6,1200)(ORDER(I),I=1,N)
        LENGTH=2*LENGTH

 1000 CONTINUE
 1010 CONTINUE
c
c  Get out of here.
c
c      WRITE(6,*)'Sorted data:'
c      WRITE(6,1200)(SORTED(I),I=1,N)
c      WRITE(6,*)'ORDER:'
c      WRITE(6,1200)(ORDER(I),I=1,N)

 1200 FORMAT(10I6)

      RETURN
      END

      SUBROUTINE MERGE(LLENG1,LLENG2,LIST1,LIST2,ORDER1,ORDER2)

      IMPLICIT NONE

      INTEGER LLENG1,LLENG2,LIST1(*),LIST2(*),ORDER1(*),ORDER2(*)
      INTEGER I,LISTWORK(1024),ORDWORK(1024)
      INTEGER SEEN1,SEEN2,INDEX
c
c  LIST1 and LIST2 contain the two ordered lists to be merged.
c  ORDER1 and ORDER2 contain the positions these entries originally
c    occupied.
c
c      WRITE(6,*)'Original list 1:'
c      WRITE(6,1200)(LIST1(I),I=1,LLENG1)
c      WRITE(6,*)'Original list 2:'
c      WRITE(6,1200)(LIST2(I),I=1,LLENG2)
c      WRITE(6,*)'Original order 1:'
c      WRITE(6,1200)(ORDER1(I),I=1,LLENG1)
c      WRITE(6,*)'Original order 2:'
c      WRITE(6,1200)(ORDER2(I),I=1,LLENG2)
      SEEN1=1
      SEEN2=1

      DO 1000 INDEX=1,LLENG1+LLENG2
        IF (SEEN1 .GT. LLENG1) THEN
          LISTWORK(INDEX)=LIST2(SEEN2)
          ORDWORK(INDEX)=ORDER2(SEEN2)
          SEEN2=SEEN2+1
          GOTO 1000
        ENDIF
        IF (SEEN2 .GT. LLENG2) THEN
          LISTWORK(INDEX)=LIST1(SEEN1)
          ORDWORK(INDEX)=ORDER1(SEEN1)
          SEEN1=SEEN1+1
          GOTO 1000
        ENDIF
        IF (LIST1(SEEN1) .LT. LIST2(SEEN2)) THEN
          LISTWORK(INDEX)=LIST1(SEEN1)
          ORDWORK(INDEX)=ORDER1(SEEN1)
          SEEN1=SEEN1+1
         ELSE
          LISTWORK(INDEX)=LIST2(SEEN2)
          ORDWORK(INDEX)=ORDER2(SEEN2)
          SEEN2=SEEN2+1
        ENDIF
 1000 CONTINUE
c
c  Put the results in the right place
c
      DO 1100 I=1,LLENG1+LLENG2
        LIST1(I)=LISTWORK(I)
        ORDER1(I)=ORDWORK(I)
 1100 CONTINUE

c      WRITE(6,*)'Merged list:'
c      WRITE(6,1200)(LIST1(I),I=1,LLENG1+LLENG2)
c      WRITE(6,*)'Merged order:'
c      WRITE(6,1200)(ORDER1(I),I=1,LLENG1+LLENG2)

 1200 FORMAT(10I6)

      RETURN
      END
c
c  A user-friendly routine to return a random number, uniformly 
c  distributed in (0,1).  The seed is held in common, so that the 
c  user can identify it.  
c
      double precision function drand()
      INTEGER*4 ISEED
      REAL*8 rand1
      COMMON/RANDOM/ISEED
      drand=rand1(iseed)
      RETURN
      END
c
      double precision function rand1(iseed)
c
c         actual generator
c
      integer*4 iseed
      integer a,p,b15,b16,xhi,xalo,leftlo,fhi,k
      data a,b15,b16,p/16807,32768,65536,2147483647/
c
      if (iseed.le.0) then
         iseed = 63887
      end if
c
      xhi = iseed / b16
      xalo = (iseed - xhi * b16) * a
      leftlo = xalo / b16
      fhi = xhi * a + leftlo
      k = fhi / b15
      iseed = (((xalo - leftlo*b16) - p) + (fhi - k*b15)*b16)+k
      if (iseed.lt.0) iseed = iseed + p
      rand1 = 4.656612875d-10 * iseed
c
      return
      end
c
