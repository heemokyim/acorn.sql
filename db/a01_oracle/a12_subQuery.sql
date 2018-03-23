/*
서브 쿼리
 하나의 select문장의 절 안에 포함된 또 하나의 select문장이다.
 그렇기에 서브 쿼리를 포함하고 있는 쿼리문을 메인쿼리, 포함된 또 
 하나의 쿼리를 서브쿼리라고 한다.
 형식
 	select *  --> 메인쿼리(실행2)
 	from 테이블
 	where 컬럼 = (   --> 서버쿼리(실행1)
 		select *
 		from 테이블
 		where 컬럼 = 데이터
 	)
주의 사항
1. 서버 쿼리는 비교 연산자의 오른쪽에 기술해야 하고 반드시 괄호로 둘러쌓아야 한다.
2. 서브 쿼리는 메인 쿼리가 실행되기 이전에 한번만 실행이 된다. 	
 */
-- 단일행 서브 쿼리
-- 내부 select문장으로부터 오직 하나의 row만을 반환 받으며, 단일 행 비교 연산자
-- (=,>, >=, <, <=, <> )를 사용한다.
SELECT * FROM EMP
WHERE DEPTNO = (
	SELECT deptno FROM emp
	WHERE ename = 'SMITH' );
-- 그룹함수로 결과값을 가져온 후에 데이터 조건에 맞게 검색 처리할 때..
SELECT ename, SAL
FROM emp
WHERE sal > ( SELECT avg(sal) 
                FROM emp );
-- 연습 예제
-- 1. ALLEN과 같은 JOB(직책)을 가진 사람들의 사번 이름 직책을 출력하세요.
SELECT ENAME, JOB
FROM EMP
WHERE JOB = (SELECT JOB FROM EMP WHERE ENAME='ALLEN');
-- 2. 최초로 입사한 사람과 같은 부서에 있는 사람들을 출력하세요.
SELECT * 
FROM EMP
WHERE DEPTNO=(
	SELECT DEPTNO
	FROM EMP
	WHERE HIREDATE =(
				      SELECT MIN(HIREDATE)
	      			FROM EMP)
);
/* 다중행 서브 쿼리
 * 서브 퀄리에서 반환되는 결과가 하나 이상의 행일 때 사용된다.
 * 1. 컬럼 IN( 쿼리 )
 * 	메인쿼리의 비교조건이 서브 쿼리의 결과 중에서 하나라도 일치하면 검색 된다.
 * 2. ANY/SOME(쿼리)
 * 	메인쿼리의 비교 조건이 서브쿼리의 검색 결과와 하나이상 일치할 때 검색.
 * 3. ALL(쿼리)
 * 	메인쿼리의 비교 조건이 서브 쿼리의 검색 결과와 모든 값이 일치될 때 검색.
 * 4. EXISTS(쿼리)/NOT EXISTS(쿼리)
 *  메인쿼리의 비교 조건이 서브 쿼리의 결과 중에서 만족하는 값이 하나라도 존재하면
 *  검색 처리.
 * */
-- IN 조건 처리.
SELECT * FROM EMP;
-- 연봉이 3000 이상인 사원 
SELECT * FROM EMP 
WHERE SAL >=3000;
-- 연봉이 3000 이상인 사원의  JOB과 동일한  사원을 출력하세요..
SELECT * FROM EMP
WHERE JOB IN(
	SELECT JOB FROM EMP
	WHERE SAL>=3000
);
-- 하나라도 일치하면 참..
-- 800,2975,3000
SELECT * FROM EMP
WHERE SAL >= ANY(SELECT SAL
				 FROM EMP
                 WHERE DEPTNO=20); -- 그룹함수의 MIN() 동일
SELECT * FROM EMP
WHERE SAL >= ALL(SELECT SAL
				 FROM EMP
                 WHERE DEPTNO=20); -- 그룹함수의 MAX() 동일
-- EXISTS존재여부..: 해당 데이터가 있으면 검색 처리.
SELECT *
FROM EMP
WHERE EXISTS(SELECT COMM
			 FROM EMP
			WHERE COMM IS NOT NULL);
-- 확인예제) 평균 급여 이상을 받는 모든 사원에 대하여 사원 번호와 이름을 출력하되,
--  출력은 급여를 기준으로 내림차순으로 정렬하세요.
SELECT EMPNO, ENAME, SAL
FROM EMP
WHERE SAL > ( SELECT AVG(SAL) FROM EMP )
ORDER BY SAL DESC;
-- 서브 쿼리로 테이블 만들기..
-- 1. 테이블 만들기 기본형식
--   CREATE TABLE 테이블명(컬럼명 데이터TYPE, .....);
-- 2. 서브쿼리를 이용하면 간편하게 기존있는 테이블 구조와 데이터를
--    복사하여 만들 수 있다.
CREATE TABLE EMP01
AS
SELECT * FROM EMP;
SELECT * FROM EMP01;
CREATE TABLE EMP02
AS
SELECT ENAME, JOB, SAL
FROM EMP;
SELECT * FROM EMP02;
CREATE TABLE EMP03
AS
SELECT *
FROM EMP
WHERE DEPTNO=30;
SELECT * FROM EMP03;
-- 확인예제 - 사원번호, 이름, 부서명, 부서위치가 있는
--          테이블 EMP_DEPT 테이블을 생성하세요.
CREATE TABLE emp_dept
as
SELECT EMPNO, ENAME, DNAME, LOC
FROM EMP a, DEPT b
WHERE a.DEPTNO = b.DEPTNO;
SELECT * FROM emp_dept;
/*구조만 필요하고, 데이터를 신규데이터 넣을 때..*/
-- where 1=0 false로 데이터 나오지 않는다.
--   테이터를 나오지 않지만 테이블 복사시 subquery로 
--   테이블 구조를 복사할 수 있다..
-- where 1=1 true로 데이터가 나온다..

CREATE TABLE emp04
as
SELECT * 
FROM emp
WHERE 1=0;

SELECT * FROM emp04;
-- 서버쿼리를 이용한 데이터 추가.
-- 형식
-- insert into 테이블
-- select * from 테이블
CREATE TABLE dept01
AS
SELECT * FROM dept WHERE 1=0;
SELECT * FROM dept01;
INSERT INTO dept01
SELECT * FROM dept
WHERE deptno=30;
COMMIT;  -- 데이터의 확정처리.(수정, 삭제, 입력 시 실행)
-- rollback : 데이터 확정전(commit)에 원복처리..
SELECT * FROM dept01;
INSERT INTO dept01
SELECT 50, '인사','서울' FROM dual;
-- 확인예제
-- emp05를 구조만 복사하여  이름,직책,급여 컬럼의 테이블을 만들고,
--   emp데이터 중에 급여가 2000~3000 사이의 데이터를 입력하세요.
--   dual테이블을 이용하여 '홍길동', 'SUPERMAN', 5000 입력하세요.
 CREATE TABLE emp05
 AS
 SELECT ename, job, sal
 FROM EMP
 WHERE 1=0;
SELECT * FROM emp05;
INSERT INTO emp05
SELECT ename, job, sal
FROM EMP
WHERE sal BETWEEN 2000 AND 3000;
COMMIT;
INSERT INTO emp05
SELECT '홍길동', 'SUPERMAN', 5000 FROM DUAL;

 










 

