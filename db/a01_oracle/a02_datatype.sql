-- 데이터베이스에서 주로 활용되는 데이터 type의 형태
-- 문자형 데이터 type에서 char, varchar2의 차이를 기술하세요
-- 1. 문자형
--    1) 고정형 문자 : char(크기)
--    2) 가변형 문자 : varchar2(최대크기)
-- 2. 숫자형
--    1) 정수 : number(크기)
--    2) 실수 : number(크기, 소숫점이하크기)
-- 3. 날짜형
--    DATE로 시간과 날짜를 정하할 수 있게 처리한다.
SELECT EMPNO "정수형", ENAME "가변형문자형", HIREDATE "날짜형" FROM EMP; 	


