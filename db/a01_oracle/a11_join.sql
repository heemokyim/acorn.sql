/*
join
데이터베이스 내부에 테이블간의 연관관계를 처리하여
해당 데이터를 나타낼 때가 있다. 
이때, 연관되는 컬럼으로 연결하여 두개이상의 테이블을
나타내는 것을 조인이라고 한다.
형식
	select 별칭1.컬럼명, 별칭1.컬럼명.....
	from 테이블명1 별칭1, 테이블명2 별칭2
	where 별칭1.조인컬럼 = 별칭2.조인컬럼.
ex)
 */
	SELECT a.*, b.*
	FROM emp a, dept b 
	WHERE a.deptno=b.deptno;
-- 부서명, 사원명, 사원번호 , 부서위치
SELECT b.DNAME, a.ENAME, a.EMPNO, b.LOC
FROM emp a, dept b
WHERE a.DEPTNO = b.DEPTNO;
--위와 같이 동일한 데이터를 가지는 컬럼끼리 1:1 매핑하여 조인하는 것을 
-- equi join이라고 한다.
SELECT * FROM SALGRADE;
-- non-equi join : 조인은 조인할 테이블 사이에 컬럼의 값이 직접적
-- 으로 일치하지 않을 시 사용하는 조인으로 '='을 제외한 연산자를
-- 사용한다.
-- 급여를 기준으로 등급을 출력하기.
SELECT e.ename, e.sal, s.grade
FROM emp e, SALGRADE s 
WHERE e.sal  BETWEEN s.LOSAL AND s.HISAL;
-- 컬럼명 between 시작범위 and 마지막범위..
-- 연습예제
-- 1. 급여가 3000에서 5000사이인 직원의 이름과 소속 부서명을 출력하라.
--  A,B alias명 앞에 붙이는 경우 - 공통 컬럼이 있어서 구분할 때.
--  BETWEEN :  컬럼명 BETWEEN A AND B
--             컬럼명 >= A and 컬럼명 <=B
SELECT ENAME, DNAME, SAL
FROM EMP A, DEPT B 
WHERE A.DEPTNO = B.DEPTNO
AND SAL BETWEEN 3000 AND 5000;

-- 2. 직급이 MANAGER인 사원의 이름, 부서명을 출력하라.
SELECT ENAME, DNAME, JOB
FROM EMP A, DEPT B
WHERE A.DEPTNO = B.DEPTNO
AND JOB='MANAGER';
-- 3. ACCOUNTING 부서 소속 사원의 이름과 입사일을 출력하라.
SELECT ENAME, HIREDATE,DNAME
FROM EMP A, DEPT B
WHERE A.DEPTNO = B.DEPTNO
AND DNAME='ACCOUNTING';
-- 4. 평균 연봉 보다 많은 사원의 이름과 부서위치(LOC)를 출력하라.

SELECT AVG(SAL) FROM EMP;

SELECT ENAME, SAL, LOC
FROM EMP A, DEPT B
WHERE A.DEPTNO = B.DEPTNO
AND SAL>=( SELECT AVG(SAL) FROM EMP );
-- 5. 'NEW YORK'에 근무하는 사원 중, 가장 높은 급여를 받는 사람의
--    이름과 급여를 출력하라.
SELECT ENAME, SAL
FROM EMP
WHERE SAL = (
	SELECT MAX(SAL)
	FROM EMP
	WHERE DEPTNO = (
		SELECT DEPTNO
		FROM DEPT
		WHERE LOC='NEW YORK')
);
-- 5. 'NEW YORK'에 근무하는 사원 중, 가장 높은 급여를 받는 사람의
--    이름과 급여를 출력하라.
SELECT ENAME, SAL
FROM EMP
WHERE (DEPTNO, SAL) = (
	SELECT A.DEPTNO, MAX(B.SAL)
	FROM DEPT A, EMP B
	WHERE A.DEPTNO=B.DEPTNO
	AND LOC='NEW YORK'
	GROUP BY A.DEPTNO );
-- 6. BLAKE 와 동일한 근무지에 근무하는 사원의 이름을 출력하라
SELECT ENAME, DEPTNO
FROM EMP
WHERE DEPTNO=( SELECT DEPTNO 
                 FROM EMP 
                WHERE ENAME='BLAKE');
/* Outer join
 * 행이 조인 조건에 만족하지 않을 경우, 그 행은 결과에 나타나지 않게 된다.
 * 이 때, 조인 조건에 만족하지 않는 행들도 나타내기 위해 outer join을 사용한다.
 * 형식  
 *    	select a.*, b.*
 * 		from 테이블1 a, 테이블2 b
 * 		where a.공통컬럼(+) = b.공통컬럼
 *     테이블1의 null값이더라도 모두 출력 처리를 할 때 활용된다.
 *  */
SELECT DISTINCT deptno FROM emp;
SELECT deptno FROM dept;
SELECT ename, d.deptno, dname
FROM emp e, dept d 
WHERE e.DEPTNO(+) = d.deptno;
/* self join
 * 자기 자신의 테이블과 조인을 맺는 것을 말한다.
 * from 절 다음에 동일한 테이블명을 2번 기술하고, where 절에도
 * 조인 조건을 주어야 하는데, 이 때 서로 다른 테이블인 것처럼 인식
 * 할 수 있도록 하기 위해서 별칭을 사용한다.
 * 형식
 * select a.컬럼1... b.컬럼2...
 * from 테이블1 a, 테이블1 b
 * where a.상위컬럼 = b.하위컬럼
 * 
 *  */
SELECT empno, mgr FROM emp;
SELECT DISTINCT empno FROM emp;
SELECT DISTINCT mgr FROM emp;
SELECT w.ename "사원명", m.ename "관리자명"
FROM emp w, emp m
WHERE w.mgr = m.empno;




 
