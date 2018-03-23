/*
 * 
날짜처리는 +숫자를 통해서 일수를 가산/감산할 수 있다.
 */
select ename "사원명", HIREDATE "입사일",
		HIREDATE+30 "입사후 30일 되는 날"
from emp;
-- SYSDATE : 현재 시간과 분/초 단위를 나타날 때 활용된다.
SELECT sysdate FROM dual;
SELECT ename, hiredate, sysdate, SYSDATE-HIREDATE 
FROM emp;
-- months_between( date1, date2)
--  해당 날짜 사이의 개월수를 표현할 때 활용된다.
SELECT ename, hiredate, sysdate, SYSDATE-HIREDATE "입사후, 일수",
		MONTHS_BETWEEN(SYSDATE, HIREDATE) "입사후, 개월 수",
		ADD_MONTHS(HIREDATE, 3) "인턴기간 종료일"
FROM emp;
-- add_months( date, 이후의 개월 수 )
--  해당 날짜이후, 개월 수가 지난 후 날짜를 표현한다.
SELECT ADD_MONTHS(SYSDATE, 5) "지금부터 5개월후 날짜" 
FROM dual;
-- last_day(날짜) : 해당날짜에 속하는 달의 마지막 날짜를 반환한다.
-- next_day(날짜, '요일') : 해당날짜 이후에 첫번째 지정한 요일의 날짜를
--                     반환한다.
SELECT last_day(SYSDATE) "이번달마지막일",
       NEXT_DAY(SYSDATE,'일') "첫번째 일요일"
FROM dual;
-- 연습예제
--  EMP테이블에서 사번과 사원명을 출력하고, 첫급여일(매월 마지막일),
--     입사후, 첫번째 토요일을 을 출력하세요
SELECT EMPNO, ENAME, HIREDATE "입사일", LAST_DAY(HIREDATE) "첫급여일",
		NEXT_DAY(HIREDATE, '토') "첫번째 토요일"
FROM EMP;		
 