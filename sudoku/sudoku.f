c
c  Given a sudoku input, this code writes out two files:
c   (1) an ampl dat file suitable for use with sudokuInit.mod
c   (2) a latex file for generating a grid for hand-solving
c
c
c
      IMPLICIT NONE

      CHARACTER*1  INPUT(9,9),OUTPUT(9,9),OUTPUTLATEX(9,9)
      INTEGER I,J
      REAL*8  TEMP
c
      OPEN(9,file='sudokufinput')
      OPEN(12,file='sudokuIf.dat')
      OPEN(10,file='sudokuIf.tex')

c
c  read in the problem
c
      DO 100 I=1,9
        READ(9,9500)(INPUT(I,J),J=1,9)
  100 CONTINUE

c
c  check the input
c
      DO 150 I=1,9
        WRITE(6,900)I,(INPUT(I,J),J=1,9)
  150 CONTINUE
c
c  convert the dots to zeroes
c
      DO 200 I=1,9
        DO 180 J=1,9
          IF (INPUT(I,J) .EQ. '.') THEN
               OUTPUT(I,J) = '0'
               OUTPUTLATEX(I,J) = ' '
            ELSE
               OUTPUT(I,J) = INPUT(I,J)
               OUTPUTLATEX(I,J) = INPUT(I,J)
          ENDIF
  180   CONTINUE
  200 CONTINUE
c
c  write out the ampl data file
c
      WRITE(12,*)'param size := 9;'
      WRITE(12,*)''
      WRITE(12,*)'param nsubsets := 3;'
      WRITE(12,*)''
      WRITE(12,*)'set ROWSUBS[1] := 1 2 3;'
      WRITE(12,*)'set ROWSUBS[2] := 4 5 6;'
      WRITE(12,*)'set ROWSUBS[3] := 7 8 9;'
      WRITE(12,*)''
      WRITE(12,*)'set COLSUBS[1] := 1 2 3;'
      WRITE(12,*)'set COLSUBS[2] := 4 5 6;'
      WRITE(12,*)'set COLSUBS[3] := 7 8 9;'
      WRITE(12,*)''
      WRITE(12,*)'param GRID:'
      WRITE(12,*)'   1 2 3 4 5 6 7 8 9 :='
      WRITE(12,*)''

      DO 300 I=1,9
        WRITE(12,900)I,(OUTPUT(I,J),J=1,9)
  300 CONTINUE

      WRITE(12,*)';'

c
c  Start the LaTeX output
c
      WRITE(10,9050)
      WRITE(10,9000)
      WRITE(10,9055)
      WRITE(10,9000)
      WRITE(10,9060)
      WRITE(10,9000)
      WRITE(10,9064)
      WRITE(10,9065)
      WRITE(10,9070)
      WRITE(10,9075)
c
c  the actual table numbers
c
      DO 500 I=1,9
        WRITE(10,9200)(OUTPUTLATEX(I,J),J=1,9)
        WRITE(10,9075)
  500 CONTINUE
c
c  Finish off the table.
c
      WRITE(10,9080)
      WRITE(10,9085)
      WRITE(10,9000)
      WRITE(10,9086)
c
c  Finish off the LaTeX file
c
      WRITE(10,9090)
c
 9000 FORMAT('')
 9050 FORMAT('\\documentclass[12pt]{article}')
 9055 FORMAT('\\renewcommand{\\baselinestretch}{2}')
 9060 FORMAT('\\begin{document}')
 9064 FORMAT('{\\Large')
 9065 FORMAT('\\begin{center}')
 9070 FORMAT('\\begin{tabular}{|p{0.4in}|p{0.4in}|p{0.4in}|',
     *'p{0.4in}|p{0.4in}|p{0.4in}|p{0.4in}|p{0.4in}|p{0.4in}|}')
 9075 FORMAT('\\hline')
 9080 FORMAT('\\end{tabular}')
 9085 FORMAT('\\end{center}')
 9086 FORMAT('}')
 9090 FORMAT('\\end{document}')
 9200 FORMAT(A2,' & ',A2,' & ',A2,' & ',A2,' & ',A2,' & ',
     *  A2,' & ',A2,' & ',A2,' & ',A2,' \\\\ ')
c

      
 9500 FORMAT(9A1)



  900 FORMAT(I1,' ',A1,' ',A1,' ',A1,' ',A1,' ',A1,' ',A1,
     *   ' ',A1,' ',A1,' ',A1)

      STOP
      END
