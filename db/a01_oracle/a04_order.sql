/*
정렬 처리..
select *
from 테이블명
where 조건구문..
order by 정렬할 컬럼명 [asc/desc]

급여가 가장 많은 사원에서 내림차순으로의 이름과 급여를 출력하세요.    
*/
SELECT * FROM emp;
SELECT ename, sal
FROM EMP
order BY sal DESC;
-- 연봉이 3000이하인 데이터 중에서, 급여가  낮은 데이터에서 높은 데이터로
-- 정렬하세요..
SELECT ENAME, SAL	
FROM EMP
WHERE sal <= 3000
ORDER BY sal;
-- ex) 확인예제 
-- comm(보너스)가 NULL이 아닌 데이터 중에, 연봉이 2000미만인 데이터를
-- 연봉 기준으로 내림차순해서, 사원명, 연봉, 보너스를 출력하세요.

