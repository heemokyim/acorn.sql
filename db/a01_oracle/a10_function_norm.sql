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

