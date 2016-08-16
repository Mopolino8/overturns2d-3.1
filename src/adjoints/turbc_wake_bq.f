C        Generated by TAPENADE     (INRIA, Tropics team)
C  Tapenade 3.6 (r4343) - 10 Feb 2012 10:52
C
C  Differentiation of turbc_wake in reverse (adjoint) mode:
C   gradient     of useful results: q
C   with respect to varying inputs: q
C
C*************************************************************
      SUBROUTINE TURBC_WAKE_BQ(q, qb, jd, kd, js, je, ks, ke, idir)
      USE PARAMS_GLOBAL
      IMPLICIT NONE
C*************************************************************
C*************************************************************
      INTEGER jd, kd
      REAL q(jd, kd, nq)
      REAL qb(jd, kd, nq)
      INTEGER js, je, ks, ke, idir
C
C.. local variables
C
      INTEGER j, k, jj, j1, k1, kc, iadd, iadir
      REAL tmp
      REAL tmp0
      INTEGER branch
      REAL tmpb
      INTRINSIC SIGN
      REAL tmp0b
      INTRINSIC ABS
C
      IF (idir .GE. 0.) THEN
        iadir = idir
      ELSE
        iadir = -idir
      END IF
C
      IF (iadir .NE. 1) THEN
        IF (iadir .EQ. 2) THEN
C
          DO kc=1,ke-ks+1
            IF (idir .EQ. 2) THEN
              CALL PUSHINTEGER4(k)
              k = ke - kc + 1
              CALL PUSHINTEGER4(k1)
              k1 = ke + kc
              CALL PUSHCONTROL2B(2)
            ELSE IF (idir .EQ. -2) THEN
              CALL PUSHINTEGER4(k)
              k = ks + kc - 1
              CALL PUSHINTEGER4(k1)
              k1 = ks - kc
              CALL PUSHCONTROL2B(1)
            ELSE
              CALL PUSHCONTROL2B(0)
            END IF
          ENDDO
          DO kc=ke-ks+1,1,-1
            DO j=je,js,-1
              jj = jd - j + 1
              tmp0b = qb(jj, k, nmv+1)
              qb(jj, k, nmv+1) = 0.0
              qb(j, k1, nmv+1) = qb(j, k1, nmv+1) + tmp0b
              tmpb = qb(j, k, nmv+1)
              qb(j, k, nmv+1) = 0.0
              qb(jj, k1, nmv+1) = qb(jj, k1, nmv+1) + tmpb
            ENDDO
            CALL POPCONTROL2B(branch)
            IF (branch .NE. 0) THEN
              IF (branch .EQ. 1) THEN
                CALL POPINTEGER4(k1)
                CALL POPINTEGER4(k)
              ELSE
                CALL POPINTEGER4(k1)
                CALL POPINTEGER4(k)
              END IF
            END IF
          ENDDO
        END IF
      END IF
      END
