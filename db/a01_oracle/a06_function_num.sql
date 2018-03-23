/*
숫자 함수 : 숫자 데이터를 원하는 데이터로 수학적으로
 처리해주는 함수를 말한다.
1. round(데이터, 표현할 소숫점이하 자리수)
   자리수를 생략하면 정수형으로 반올림 처리
   자리수에 음수를 입력하면 해당 단위로 반올림처리(십자리-1, 백자리-2,
   	 천자리-3) 
*/
SELECT round(25.72,1) d01,
	round(25.72) d02,
	round(1225.45,-2) d03
FROM emp;
-- 연습예제) 연봉을 기준으로 15%를 인상하기로 했다.
--   인상분과 인상된 연봉액을 출력하되 100단위로 반올림 처리하여
--   아래 형식으로 출력하세요.
--   이름, 기존연봉, 인상액, 인상된 연봉액
SELECT ename "이름", sal "기존연봉", sal*0.15 "인상액",
	round(sal+(sal*0.15),-2) "인상된 연봉액"
FROM emp;
--2. trunc(데이터/컬럼명, 자리수 ) 
--   지정된 자리수까지 남기고 값을 버림 처리..
SELECT sal, sal*0.8, trunc(sal*0.8,-2) FROM emp;
--3. ceil(데이터) : 해당 데이터나 컬럼의 값을 소숫점이하 일 때, 올림처리.
--    정수결과물을 출력,
--4. floor(데이터) : 해당 데이터나 컬럼의 값을 소숫점이하 일 때, 내림처리
--    하여 정수 결과물을 출력
SELECT sal, sal*0.25 data01, ceil(sal*0.25) data02,
	floor(sal*0.25) data03 
FROM emp;
--5. mod(데이터1, 데이터2) :데이터1을 데이터2로 나누었을 때, 
--  나눈 나머지를 출력..
SELECT ename, deptno, deptno/10, mod(deptno/10,2)
FROM emp;
-- 확인예제 ) 사번이 짝수인 사원들의 사번과 이름과 직급을 출력하세요.
SELECT empno, ename, job, mod(empno,2) data
FROM emp
WHERE mod(empno,2)=0;
