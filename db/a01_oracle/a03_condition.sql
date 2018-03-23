/*
 다중행 주석을 처리할 때, 활용한다.. 
1. 조건 조회 형식
select 컬럼명1, 컬럼명2
from 테이블명
where 조건조회할컬럼명1 = 해당검색할조건데이터
 */
SELECT * FROM emp;
-- 연봉이 3000이상인 사원을 출력하세요...
SELECT * FROM EMP
WHERE sal >=3000;
-- 이름이 ALLEN사람의 정보를 출력하세요..
SELECT * FROM EMP
WHERE ENAME = 'ALLEN';
-- AND : 조건이 두가지 이상 다 TURE 일때, 처리될 내용
-- 1) 범위 처리.. 연봉이 2000이상 3000미만인 데이터를 출력하세요.
SELECT * FROM EMP
WHERE sal >=2000 AND sal <3000;
SELECT * FROM emp;
-- 2) 두개이상의 컬럼의 조건이 만족할 때
--    JOB이 'SALESMAN'이며  연봉이 1500 미만인 데이터를 출력하세요..
SELECT * FROM EMP
WHERE job ='SALESMAN' AND sal < 1500;
-- OR  : 해당 조건이 하나만 참이면 참으로 인지하여,
--   데이터를 출력하는 처리..
-- 1) 범위에서 극단/최소 데이터를 출력할 때..
--   연봉이 1000미만 이거나  5000이상인 데이터를 출력하세요..
SELECT * FROM EMP
WHERE SAL <1000 OR sal>=5000;
-- 선택컬럼과 혼합한 예제..
-- ex) 이름이 MILLER이 사람의 사원번호와 사원명, 직급을 출력하세요.
SELECT empno, ename, job
FROM EMP
WHERE ename = 'MILLER';
-- 연습예제)
-- 1) JOB이 'SALESMAN'이고, DEPTNO가 30인 사원의
--    empno, job, sal를 한글 이름으로 출력하세요..
SELECT empno "사번", job "직책", sal "연봉"
FROM EMP
WHERE job = 'SALESMAN' 
AND deptno = 30;
-- 2) DEPTNO가 30이거나 SAL이 2000미만인 사원의 이름과 연봉, 부서번호를
--   출력하세요.
SELECT ename, sal, DEPTNO
FROM EMP
WHERE DEPTNO = 30 OR sal <2000;
-- 3) SAL와 COMM의 합산이 2000이상인 데이터의 사번, 이름, 연봉, 합산액,
-- DEPTNO를 출력    하세요
--  데이터 + null : null 이기에 정상적으로 원하는 데이터가 나오지 않는다.
--  nvl(컬럼명, null값일때 대체할 데이터 )  nvl(comm, 0)
SELECT empno, ename, sal, comm,sal+nvl(comm,0) tot, deptno
FROM EMP
WHERE (sal+nvl(comm,0))>=2000;
SELECT * FROM EMP;
-- 반대 조건 처리 : not 연산 처리(!=, <>), not 활용
-- ex) 부서번호가 10이 아닌 사원들을 출력하세요..
SELECT * FROM EMP
WHERE NOT deptno=10;
-- 확인예제) job이 'ANALYST'가 아니고, 부서번호가 30인 사원을 출력하세요.
SELECT * FROM EMP
WHERE JOB <> 'ANALYST'
AND DEPTNO =30;
-- BETWEEN A AND B: 특정한 컬럼의 데이터가 범위에 해당할 때 처리하는 KEYWORD이다.
-- EX)급여가 1000에서 3000사이에 있는 사원의 이름과 급여를 출력하세요..
SELECT ENAME, SAL
FROM EMP
WHERE sal BETWEEN 1000 AND 3000;
-- in(조건데이터1, 조건데이터2, 조건데이터3)
-- or조건과 동일하게 하나의 컬럼에 데이터를 or 조건으로 연결하여 처리하고자 할때
-- 활용할 수 있다..
-- 해당 조건데이터가 하나라도 있으면 출력이 된다.
SELECT * FROM emp;
-- 사원 번호과 7499, 7566, 7654 인 경우 출력하세요..
SELECT *
FROM EMP
WHERE empno IN (7499,7566,7654);
-- 확인예제 ) job이 'CLERK'이거나 'ANALYST'이고, deptno가 20인 데이터를
--  출력하세요..
SELECT *
FROM EMP
WHERE job IN ('CLERK','ANALYST')
AND deptno = 20;
/*
like 연산자
 비슷한 데이터를 조회할 때, 포함되 키워드로 연관된 데이터를
 조건으로 처리할 때, 활용된다.
 1) 형식 : 컬럼명  like '%포함될 문자열%'
          컬럼명 like '시작문자열%' 
          컬럼명 like '%끝나는문자열'
**/
SELECT * FROM EMP
WHERE job LIKE '%A%';
--  컬럼명 '_A%' __(자리수에 맞춰서 검색하고자 할 때 활용된다.)
--        두번째 글자가 A가 포함된 문자열이 있는 데이터를 출력한다.
SELECT empno, ENAME
FROM EMP
WHERE ename LIKE '_A%';
SELECT * FROM emp;
-- 확인예제 : 3번째와 4번째 문자열이 ER을 포함한 JOB(직책)이 있는 사원을 출력하세요
SELECT * FROM EMP
WHERE job LIKE '__ER%';
/*
NULL : 미확정, 알수 없는 이라는 뜻으로 데이터베이스에서 데이터가 들어 가지 않는
상태를 말한다. 문자열같은 경우 ''(공백)이 들어 간 것과 큰 차이로 처리된다.

보너스(comm)를 받지 않는 사원에 대한 검색.
 */
SELECT * FROM emp;
SELECT * FROM EMP
WHERE comm IS NULL;
-- 오라클에서 데이터에 대한 null 여부를 조회 할 때는 컬럼명 is null을 활용한다.
 







 
