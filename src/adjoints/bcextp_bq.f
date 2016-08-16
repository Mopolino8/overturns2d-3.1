C        Generated by TAPENADE     (INRIA, Tropics team)
C  Tapenade 3.6 (r4343) - 10 Feb 2012 10:52
C
C  Differentiation of bcextp in reverse (adjoint) mode:
C   gradient     of useful results: q
C   with respect to varying inputs: q
C
C***********************************************************************
      SUBROUTINE BCEXTP_BQ(q, qb, jd, kd, js, je, ks, ke, idir)
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
      INTEGER j, k, j1, k1, j2, k2, jc, kc
      INTEGER iadd, iadir
      REAL foso, scale1, scale2
      REAL scale1b, scale2b
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
      REAL tempb2
      REAL tempb1
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
      foso = 0.0
C**** first executable statement
C
      iadd = SIGN(1, idir)
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
            CALL PUSHCONTROL2B(0)
          ELSE IF (idir .EQ. -1) THEN
            CALL PUSHINTEGER4(j)
            j = js + jc - 1
            CALL PUSHCONTROL2B(1)
          ELSE
            CALL PUSHCONTROL2B(2)
          END IF
          CALL PUSHINTEGER4(j1)
          j1 = j + iadd
          CALL PUSHINTEGER4(j2)
          j2 = j1 + iadd
          DO k=ks,ke
            CALL PUSHREAL8(scale1)
            scale1 = q(j1, k, nq)/q(j, k, nq)
            CALL PUSHREAL8(scale2)
            scale2 = q(j2, k, nq)/q(j, k, nq)
            tmp3 = (1.+foso)*q(j1, k, 1)*scale1 - foso*q(j2, k, 1)*
     +        scale2
            CALL PUSHREAL8(q(j, k, 1))
            q(j, k, 1) = tmp3
            tmp4 = (1.+foso)*q(j1, k, 2)*scale1 - foso*q(j2, k, 2)*
     +        scale2
            CALL PUSHREAL8(q(j, k, 2))
            q(j, k, 2) = tmp4
            tmp5 = (1.+foso)*q(j1, k, 3)*scale1 - foso*q(j2, k, 3)*
     +        scale2
            CALL PUSHREAL8(q(j, k, 3))
            q(j, k, 3) = tmp5
            tmp6 = (1.+foso)*q(j1, k, 4)*scale1 - foso*q(j2, k, 4)*
     +        scale2
            CALL PUSHREAL8(q(j, k, 4))
            q(j, k, 4) = tmp6
          ENDDO
        ENDDO
        DO jc=je-js+1,1,-1
          DO k=ke,ks,-1
            CALL POPREAL8(q(j, k, 4))
            tmp6b = qb(j, k, 4)
            qb(j, k, 4) = 0.0
            qb(j1, k, 4) = qb(j1, k, 4) + (foso+1.)*scale1*tmp6b
            scale1b = (foso+1.)*q(j1, k, 4)*tmp6b
            qb(j2, k, 4) = qb(j2, k, 4) - foso*scale2*tmp6b
            scale2b = -(foso*q(j2, k, 4)*tmp6b)
            CALL POPREAL8(q(j, k, 3))
            tmp5b = qb(j, k, 3)
            qb(j, k, 3) = 0.0
            qb(j1, k, 3) = qb(j1, k, 3) + (foso+1.)*scale1*tmp5b
            scale1b = scale1b + (foso+1.)*q(j1, k, 3)*tmp5b
            qb(j2, k, 3) = qb(j2, k, 3) - foso*scale2*tmp5b
            scale2b = scale2b - foso*q(j2, k, 3)*tmp5b
            CALL POPREAL8(q(j, k, 2))
            tmp4b = qb(j, k, 2)
            qb(j, k, 2) = 0.0
            qb(j1, k, 2) = qb(j1, k, 2) + (foso+1.)*scale1*tmp4b
            scale1b = scale1b + (foso+1.)*q(j1, k, 2)*tmp4b
            qb(j2, k, 2) = qb(j2, k, 2) - foso*scale2*tmp4b
            scale2b = scale2b - foso*q(j2, k, 2)*tmp4b
            CALL POPREAL8(q(j, k, 1))
            tmp3b = qb(j, k, 1)
            qb(j, k, 1) = 0.0
            qb(j1, k, 1) = qb(j1, k, 1) + (foso+1.)*scale1*tmp3b
            scale1b = scale1b + (foso+1.)*q(j1, k, 1)*tmp3b
            qb(j2, k, 1) = qb(j2, k, 1) - foso*scale2*tmp3b
            scale2b = scale2b - foso*q(j2, k, 1)*tmp3b
            CALL POPREAL8(scale2)
            tempb1 = scale2b/q(j, k, nq)
            qb(j2, k, nq) = qb(j2, k, nq) + tempb1
            qb(j, k, nq) = qb(j, k, nq) - q(j2, k, nq)*tempb1/q(j, k, nq
     +        )
            CALL POPREAL8(scale1)
            tempb2 = scale1b/q(j, k, nq)
            qb(j1, k, nq) = qb(j1, k, nq) + tempb2
            qb(j, k, nq) = qb(j, k, nq) - q(j1, k, nq)*tempb2/q(j, k, nq
     +        )
          ENDDO
          CALL POPINTEGER4(j2)
          CALL POPINTEGER4(j1)
          CALL POPCONTROL2B(branch)
          IF (branch .EQ. 0) THEN
            CALL POPINTEGER4(j)
          ELSE IF (branch .EQ. 1) THEN
            CALL POPINTEGER4(j)
          END IF
        ENDDO
      ELSE IF (iadir .EQ. 2) THEN
        DO kc=1,ke-ks+1
          IF (idir .EQ. 2) THEN
            CALL PUSHINTEGER4(k)
            k = ke - kc + 1
            CALL PUSHCONTROL2B(0)
          ELSE IF (idir .EQ. -2) THEN
            CALL PUSHINTEGER4(k)
            k = ks + kc - 1
            CALL PUSHCONTROL2B(1)
          ELSE
            CALL PUSHCONTROL2B(2)
          END IF
          CALL PUSHINTEGER4(k1)
          k1 = k + iadd
          CALL PUSHINTEGER4(k2)
          k2 = k1 + iadd
          DO j=js,je
            CALL PUSHREAL8(scale1)
            scale1 = q(j, k1, nq)/q(j, k, nq)
            CALL PUSHREAL8(scale2)
            scale2 = q(j, k2, nq)/q(j, k, nq)
            tmp = (1.+foso)*q(j, k1, 1)*scale1 - foso*q(j, k2, 1)*scale2
            CALL PUSHREAL8(q(j, k, 1))
            q(j, k, 1) = tmp
            tmp0 = (1.+foso)*q(j, k1, 2)*scale1 - foso*q(j, k2, 2)*
     +        scale2
            CALL PUSHREAL8(q(j, k, 2))
            q(j, k, 2) = tmp0
            tmp1 = (1.+foso)*q(j, k1, 3)*scale1 - foso*q(j, k2, 3)*
     +        scale2
            CALL PUSHREAL8(q(j, k, 3))
            q(j, k, 3) = tmp1
            tmp2 = (1.+foso)*q(j, k1, 4)*scale1 - foso*q(j, k2, 4)*
     +        scale2
            CALL PUSHREAL8(q(j, k, 4))
            q(j, k, 4) = tmp2
          ENDDO
        ENDDO
        DO kc=ke-ks+1,1,-1
          DO j=je,js,-1
            CALL POPREAL8(q(j, k, 4))
            tmp2b = qb(j, k, 4)
            qb(j, k, 4) = 0.0
            qb(j, k1, 4) = qb(j, k1, 4) + (foso+1.)*scale1*tmp2b
            scale1b = (foso+1.)*q(j, k1, 4)*tmp2b
            qb(j, k2, 4) = qb(j, k2, 4) - foso*scale2*tmp2b
            scale2b = -(foso*q(j, k2, 4)*tmp2b)
            CALL POPREAL8(q(j, k, 3))
            tmp1b = qb(j, k, 3)
            qb(j, k, 3) = 0.0
            qb(j, k1, 3) = qb(j, k1, 3) + (foso+1.)*scale1*tmp1b
            scale1b = scale1b + (foso+1.)*q(j, k1, 3)*tmp1b
            qb(j, k2, 3) = qb(j, k2, 3) - foso*scale2*tmp1b
            scale2b = scale2b - foso*q(j, k2, 3)*tmp1b
            CALL POPREAL8(q(j, k, 2))
            tmp0b = qb(j, k, 2)
            qb(j, k, 2) = 0.0
            qb(j, k1, 2) = qb(j, k1, 2) + (foso+1.)*scale1*tmp0b
            scale1b = scale1b + (foso+1.)*q(j, k1, 2)*tmp0b
            qb(j, k2, 2) = qb(j, k2, 2) - foso*scale2*tmp0b
            scale2b = scale2b - foso*q(j, k2, 2)*tmp0b
            CALL POPREAL8(q(j, k, 1))
            tmpb = qb(j, k, 1)
            qb(j, k, 1) = 0.0
            qb(j, k1, 1) = qb(j, k1, 1) + (foso+1.)*scale1*tmpb
            scale1b = scale1b + (foso+1.)*q(j, k1, 1)*tmpb
            qb(j, k2, 1) = qb(j, k2, 1) - foso*scale2*tmpb
            scale2b = scale2b - foso*q(j, k2, 1)*tmpb
            CALL POPREAL8(scale2)
            tempb = scale2b/q(j, k, nq)
            qb(j, k2, nq) = qb(j, k2, nq) + tempb
            qb(j, k, nq) = qb(j, k, nq) - q(j, k2, nq)*tempb/q(j, k, nq)
            CALL POPREAL8(scale1)
            tempb0 = scale1b/q(j, k, nq)
            qb(j, k1, nq) = qb(j, k1, nq) + tempb0
            qb(j, k, nq) = qb(j, k, nq) - q(j, k1, nq)*tempb0/q(j, k, nq
     +        )
          ENDDO
          CALL POPINTEGER4(k2)
          CALL POPINTEGER4(k1)
          CALL POPCONTROL2B(branch)
          IF (branch .EQ. 0) THEN
            CALL POPINTEGER4(k)
          ELSE IF (branch .EQ. 1) THEN
            CALL POPINTEGER4(k)
          END IF
        ENDDO
      END IF
      END
