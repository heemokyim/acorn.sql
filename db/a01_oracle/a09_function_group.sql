/* 
 그룹함수?
 - 테이블의 전체 행을 하나 이상의 컬럼을 기준으로 그룹화하여
   그룹별로 결과를 출력하는 함수, 그룹함수는 통계적인 결과를 출력하는 데 사용된다.
 형식.
 select 그룹할컬럼, 그룹함수()
 from 테이블
 where 조건.
 group by 그룹할컬럼
 having 그룹의조건
 **/
SELECT * FROM emp;
-- 전체 데이터와 부서별 데이터 건수 확인
SELECT count(*) FROM emp; -- 총데이터 건수
SELECT deptno, count(*) cnt, round(avg(sal)) avg, 
	   sum(sal) tot,max(sal) max,min(sal) min 
FROM emp
GROUP BY deptno;
-- having 은 그룹함수가 적용된 값을 조건처리할 때 활용된다.
-- 데이터 건수가 4건이상인 데이터만 출력하자.
SELECT deptno, count(*) cnt
FROM EMP
GROUP BY deptno
HAVING count(*)>=4;
-- 확인예제1) : 부서별로 평균연봉을 출력하되, 평균연봉이 2000이상경우를
--              출력하세요.
SELECT deptno, round(avg(sal)) avgSal
FROM EMP
GROUP BY DEPTNO
HAVING avg(sal)>=2000;
-- 확인예제2) : 부서별로 가장 최근에 입사한 사원과 입사일을 출력하세요.
SELECT deptno, max(hiredate) "최근입사일"
FROM EMP
GROUP BY DEPTNO;
SELECT *
FROM EMP
WHERE (deptno,hiredate)in(
	SELECT deptno, max(hiredate) "최근입사일"
	FROM EMP
	GROUP BY DEPTNO
);
-- 확인예제3) : 입사일 기준 분기별로 가장 급여가 높은 급여를 
--		분기   급여액   출력
SELECT ceil(to_number(to_char(hiredate,'MM'))/3)||'/4분기' season, max(sal) "최고급여"
FROM emp
GROUP BY ceil(to_number(to_char(hiredate,'MM'))/3);

SELECT 
hiredate,
ceil(to_number(to_char(hiredate,'MM'))/3)||'/4분기' season 
FROM emp;


