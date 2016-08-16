C        Generated by TAPENADE     (INRIA, Tropics team)
C  Tapenade 3.6 (r4343) - 10 Feb 2012 10:52
C
C  Differentiation of bcsym in reverse (adjoint) mode:
C   gradient     of useful results: q
C   with respect to varying inputs: q
C
C***********************************************************************
      SUBROUTINE BCSYM_BQ(q, qb, jd, kd, js, je, ks, ke, idir)
      USE PARAMS_GLOBAL
      IMPLICIT NONE
C
C..symmetric bc
C
C***********************************************************************
C***********************************************************************
C
      INTEGER jd, kd
      REAL q(jd, kd, nq)
      REAL qb(jd, kd, nq)
      INTEGER js, je, ks, ke, idir
C
C.. local variables
C
      INTEGER j, k, j1, k1, jc, kc
      INTEGER iadd, iadir
      REAL scale
      REAL scaleb
      REAL tmp
      REAL tmp0
      REAL tmp1
      REAL tmp2
      REAL tmp3
      REAL tmp4
      REAL tmp5
      REAL tmp6
      INTEGER branch
      REAL tmp4b
      REAL tempb0
      REAL tmpb
      INTRINSIC SIGN
      REAL tmp0b
      INTRINSIC ABS
      REAL tmp3b
      REAL tmp6b
      REAL tempb
      REAL tmp2b
      REAL tmp5b
      REAL tmp1b
C
C**** first executable statement
C
      IF (idir .GE. 0.) THEN
        iadir = idir
      ELSE
        iadir = -idir
      END IF
      IF (iadir .EQ. 1) THEN
        DO jc=1,je-js+1
          IF (idir .EQ. 1) THEN
            CALL PUSHINTEGER4(j)
            j = je - jc + 1
            CALL PUSHINTEGER4(j1)
            j1 = je + jc
            CALL PUSHCONTROL2B(2)
          ELSE IF (idir .EQ. -1) THEN
            CALL PUSHINTEGER4(j)
            j = js + jc - 1
            CALL PUSHINTEGER4(j1)
            j1 = js - jc
            CALL PUSHCONTROL2B(1)
          ELSE
            CALL PUSHCONTROL2B(0)
          END IF
          DO k=ks,ke
            CALL PUSHREAL8(scale)
            scale = q(j1, k, nq)/q(j, k, nq)
            tmp3 = q(j1, k, 1)*scale
            CALL PUSHREAL8(q(j, k, 1))
            q(j, k, 1) = tmp3
            tmp4 = -(q(j1, k, 2)*scale)
            CALL PUSHREAL8(q(j, k, 2))
            q(j, k, 2) = tmp4
            tmp5 = q(j1, k, 3)*scale
            CALL PUSHREAL8(q(j, k, 3))
            q(j, k, 3) = tmp5
            tmp6 = q(j1, k, 4)*scale
            CALL PUSHREAL8(q(j, k, 4))
            q(j, k, 4) = tmp6
          ENDDO
        ENDDO
        DO jc=je-js+1,1,-1
          DO k=ke,ks,-1
            CALL POPREAL8(q(j, k, 4))
            tmp6b = qb(j, k, 4)
            qb(j, k, 4) = 0.0
            qb(j1, k, 4) = qb(j1, k, 4) + scale*tmp6b
            scaleb = q(j1, k, 4)*tmp6b
            CALL POPREAL8(q(j, k, 3))
            tmp5b = qb(j, k, 3)
            qb(j, k, 3) = 0.0
            qb(j1, k, 3) = qb(j1, k, 3) + scale*tmp5b
            scaleb = scaleb + q(j1, k, 3)*tmp5b
            CALL POPREAL8(q(j, k, 2))
            tmp4b = qb(j, k, 2)
            qb(j, k, 2) = 0.0
            qb(j1, k, 2) = qb(j1, k, 2) - scale*tmp4b
            scaleb = scaleb - q(j1, k, 2)*tmp4b
            CALL POPREAL8(q(j, k, 1))
            tmp3b = qb(j, k, 1)
            qb(j, k, 1) = 0.0
            qb(j1, k, 1) = qb(j1, k, 1) + scale*tmp3b
            scaleb = scaleb + q(j1, k, 1)*tmp3b
            CALL POPREAL8(scale)
            tempb0 = scaleb/q(j, k, nq)
            qb(j1, k, nq) = qb(j1, k, nq) + tempb0
            qb(j, k, nq) = qb(j, k, nq) - q(j1, k, nq)*tempb0/q(j, k, nq
     +        )
          ENDDO
          CALL POPCONTROL2B(branch)
          IF (branch .NE. 0) THEN
            IF (branch .EQ. 1) THEN
              CALL POPINTEGER4(j1)
              CALL POPINTEGER4(j)
            ELSE
              CALL POPINTEGER4(j1)
              CALL POPINTEGER4(j)
            END IF
          END IF
        ENDDO
      ELSE IF (iadir .EQ. 2) THEN
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
          DO j=js,je
            CALL PUSHREAL8(scale)
            scale = q(j, k1, nq)/q(j, k, nq)
            tmp = q(j, k1, 1)*scale
            CALL PUSHREAL8(q(j, k, 1))
            q(j, k, 1) = tmp
            tmp0 = q(j, k1, 2)*scale
            CALL PUSHREAL8(q(j, k, 2))
            q(j, k, 2) = tmp0
            tmp1 = -(q(j, k1, 3)*scale)
            CALL PUSHREAL8(q(j, k, 3))
            q(j, k, 3) = tmp1
            tmp2 = q(j, k1, 4)*scale
            CALL PUSHREAL8(q(j, k, 4))
            q(j, k, 4) = tmp2
          ENDDO
        ENDDO
        DO kc=ke-ks+1,1,-1
          DO j=je,js,-1
            CALL POPREAL8(q(j, k, 4))
            tmp2b = qb(j, k, 4)
            qb(j, k, 4) = 0.0
            qb(j, k1, 4) = qb(j, k1, 4) + scale*tmp2b
            scaleb = q(j, k1, 4)*tmp2b
            CALL POPREAL8(q(j, k, 3))
            tmp1b = qb(j, k, 3)
            qb(j, k, 3) = 0.0
            qb(j, k1, 3) = qb(j, k1, 3) - scale*tmp1b
            scaleb = scaleb - q(j, k1, 3)*tmp1b
            CALL POPREAL8(q(j, k, 2))
            tmp0b = qb(j, k, 2)
            qb(j, k, 2) = 0.0
            qb(j, k1, 2) = qb(j, k1, 2) + scale*tmp0b
            scaleb = scaleb + q(j, k1, 2)*tmp0b
            CALL POPREAL8(q(j, k, 1))
            tmpb = qb(j, k, 1)
            qb(j, k, 1) = 0.0
            qb(j, k1, 1) = qb(j, k1, 1) + scale*tmpb
            scaleb = scaleb + q(j, k1, 1)*tmpb
            CALL POPREAL8(scale)
            tempb = scaleb/q(j, k, nq)
            qb(j, k1, nq) = qb(j, k1, nq) + tempb
            qb(j, k, nq) = qb(j, k, nq) - q(j, k1, nq)*tempb/q(j, k, nq)
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
      END
