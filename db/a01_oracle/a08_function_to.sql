/*
to_char()
1. 날짜/숫자를 원하는 형식으로 출력/입력/조회 하고자 할 때,
	주로 활용된다.
2. 형식 : to_char( number데이터/date데이터, 'format')
*/
/* 
1. nvl함수
	null값이 있을 때, 해당 데이터로 처리하고자 할 때,
	활용된다. 일반적으로 문자형이나 숫자형의 데이터값이
	없을 때, 대체되는 문자열이나 숫자를 지정하여
	처리할 때 활용된다
	ex) 문자열 --> ''[공백] nvl(컬럼명, '')
	    숫자 --> 0  nvl(컬럼명, 0)
 * 
 */
SELECT * FROM emp;
SELECT empno, ename, nvl(comm,0) comm
FROM emp;
-- decode()
--  특정데이터를 조건에 따라서 다른 형식의 데이터로
--  나타낼 때 활용된다.. 
--  형식 : decode(컬럼명/데이터, 조건1, 결과1, 
--                  조건2, 결과2,
--                  .....
--                위조건에 해당하는 데이터가 아닐때 처리할 결과값)
--  부서번호에 따라서 부서명으로 지정하는 처리를 하자.
--  10 :총무, 20:인사, 30:기획조정, 40:it사업부, 50:미배정
SELECT ename, deptno,
		decode(deptno,
				10,'총무',
				20,'인사',
				30,'기획조정',
				40,'it사업부',
				'미배정') "부서명"
FROM emp;
SELECT * FROM emp;
-- 사원번호가 짝수인 경우는 연봉의 20%보너스, 홀수인 경우는 30%보너스를 
-- 지급하기로 했다.
-- 사원번호, 홀/짝 표기, 보너스%, 연봉, 보너스, 연봉+보너스 로 출력하세요.
SELECT empno,
	decode(mod(empno,2),0,'짝','홀') "홀짝표기",
	decode(mod(empno,2),0,'20%','30%') "보너스%",
	sal,
	decode(mod(empno,2),0,sal*0.2,sal*0.3) "보너스",
	sal+decode(mod(empno,2),0,sal*0.2,sal*0.3) "연봉+보너스"
FROM emp;

SELECT empno, mod(empno,2)

/* 
 case 문 처리..
 :조건(비교연산자활용)으로 데이터나 컬럼의 내용에 따라 return하는 결과값을
 다르게 처리 활용되는 구문이다.
 1) 형식
 case[표현식]when 조건1 then 결과1
 			when 조건2 then 결과2
 			..
 			..
 			else 결과(상위조건에 해당내용이 없을 때, 처리할 데이터)...
 end
 *  */
SELECT ename, deptno,
	CASE WHEN deptno=10 THEN 'accounting'
		 WHEN deptno=20 THEN 'research'
		 WHEN deptno=30 THEN 'sales'
		 WHEN deptno=40 THEN 'operations'
		 ELSE 'no dept'
	END dname
FROM emp;	
/* 확인예제  직급(JOB)에 따라 급여를 인상하도록 하자. 
CLERK 5%    
SALESMAN 10% 
그외는 0% 
MANAGER  15%
ANALYST 25%
	사원번호  사원명 급여  인상분  총액  
 */
SELECT DISTINCT JOB FROM EMP;
SELECT empno, ename,sal,
	CASE WHEN JOB='CLERK' THEN sal*0.05
		 WHEN JOB='SALESMAN' THEN sal*0.1
		 WHEN JOB='MANAGER' THEN sal*0.15
		 WHEN JOB='ANALYST' THEN sal*0.25
		 ELSE 0
	END "인상분",
	CASE WHEN JOB='CLERK' THEN sal+(sal*0.05)
		 WHEN JOB='SALESMAN' THEN sal+(sal*0.1)
		 WHEN JOB='MANAGER' THEN sal+(sal*0.15)
		 WHEN JOB='ANALYST' THEN sal+(sal*0.25)
		 ELSE 0
	END "총액"
FROM emp;	
SELECT a.*, ROUND(a.sal+a.인상분) "총액" 
FROM (SELECT empno, ename,sal,
	CASE WHEN JOB='CLERK' THEN sal*0.05
		 WHEN JOB='SALESMAN' THEN sal*0.1
		 WHEN JOB='MANAGER' THEN sal*0.15
		 WHEN JOB='ANALYST' THEN sal*0.25
		 ELSE 0
	END 인상분
FROM emp) a;

