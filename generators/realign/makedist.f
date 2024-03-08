c
c  This file reads in latitudes and longitudes and outputs distances
c
      IMPLICIT NONE
      REAL*8   LAT(32),LAT1(32),LAT2(32),LAT3(32)
      REAL*8   LONG(32),LONG1(32),LONG2(32),LONG3(32)
      INTEGER  DIST(32,32)
c
      REAL*8   PI,RRR
      PARAMETER(PI=3.1415927,RRR=6378.388)
c
      INTEGER  I,J
      REAL*8   Q1,Q2,Q3
c
      OPEN(7,FILE='latlong')
      OPEN(8,FILE='distnew')
c
      DO 100 I=1,32
        READ(7,*)LAT1(I),LAT2(I),LAT3(I),LONG1(I),LONG2(I),LONG3(I)
        LAT(I)=PI*(LAT1(I)+5.0*LAT2(I)/300.0)/180.0
        LONG(I)=PI*(LONG1(I)+5.0*LONG2(I)/300.0)/180.0
        DIST(I,I)=0
  100 CONTINUE
c
      DO 200 I=1,31
        DO 200 J=I+1,32
          Q1=COS(LONG(I)-LONG(J))
          Q2=COS(LAT(I)-LAT(J))
          Q3=COS(LAT(I)+LAT(J))
          DIST(I,J)=RRR*ACOS(0.5*((1.0+Q1)*Q2 - (1.0-Q1)*Q3)) + 1.0
          DIST(J,I)=DIST(I,J)
  200 CONTINUE

c      WRITE(8,*)'Distances (city-by-city):'
      DO 400 I=1,32
        WRITE(8,9000)(DIST(I,J),J=1,32)
  400 CONTINUE
c
 9000 FORMAT(32I6)
c
      STOP
      END
