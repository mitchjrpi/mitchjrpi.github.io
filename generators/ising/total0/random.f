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
