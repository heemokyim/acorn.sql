/*
함수
 데이터를 효과적으로 처리하기 위하여 기능 함수를 내장으로
 정의하고 그것을 활용할 수 있다..
 1) 함수에 크게 단일행 함수
 	문자함수, 숫자, 날짜, 변환 함수
 2) 다중행 함수가 있다.
 	통계치(max, min, 등 group 처리 함수가 일반적이다.)
*/
-- dual : 오라클에서 test나 간단한 데이터 1라인을 출력하기 위하 임시 테이블
SELECT 1+2, lower('HiHi MAN') FROM dual; 
-- 문자 함수
--1) lower() : 소문자로 변환
SELECT ename, LOWER(ename) "소문자"
FROM emp;
--2) upper() : 대문자 변환
SELECT 'Database' db, UPPER('Database') "대문자" FROM DUAL;
-- 실무 예제) 화면조회시 소문자를 입력하더라도, 대문자 데이터로 검색되게 처리..
-- 하는 SQL작성하세요 직급을 입력처리..
SELECT empno, ename, job
FROM EMP
WHERE job=UPPER('manageR'); -- 입력된 데이터가 manager이더라도 검색을 해줌
-- Smith란 이름을 입력했을 때, 대소문자 상관없이 검색처리되어 
-- 해당 데이터의 사번, 이름, 급여를 출력하세요.
SELECT empno, ename, sal
FROM EMP
WHERE ename=upper('Smith');
--3) INITCAP() : 첫글자만 대문자로 처리 되고, 나머지는 소문자
SELECT INITCAP(ename), initcap(job), initcap('DATA BASE PROGRAM') show
FROM emp;
--4) concat() : 문자열을 연결 처리..
SELECT concat(ename,job) "ename과 job 연결"
FROM emp;
--5) SUBSTR()/SUBSTRB() : 문자열을 잘라 추출한다.(한글 1byte/2byte)
SELECT ename, substr(ename,1,3) ename01, substrb(ename,1,3) ename02,
       substr('안녕맨~~~',1,3) show01, substrb('안녕맨~~~',1,3) show02
FROM emp;
--6) LENGTH()/LENGTHB() : 문자의 길이를 반환처리. (한글 1byte/2byte)
SELECT length(ename), length('데이터베이스') show01,
	lengthb('데이터베이스') show02
FROM emp;
-- 확인예제.. EMP
-- 직원 중, 이름이 4글자인 직원의 이름을 사원번호와 함께 소문자로 출력 하세요..
SELECT empno, LOWER(ename)
FROM EMP
WHERE length(ename) =4;
-- 이름이 6글자 이상인 사원의 사번과 이름과 급여를 출력하세요.
SELECT empno, ename, sal
FROM EMP
WHERE length(ename) >= 6;
-- 7) instr () : 대상 문자열이나 칼럼에서 특정 문자가 나타나는 위치를 알려준다.
SELECT instr('Database', 'b')
FROM dual;
SELECT ename, instr(ename, 'A') "A index" 
FROM emp;
-- 8) LPAD() :크기를 정하고, 해당 크기보다 데이터가 적을 때, 지정한 문자열을
--   왼쪽에서 부터 채워 넣는 것을 말한다.
-- 9) RPAD() : 오른쪽 부터 문자열을 채워 넣는 것을 말한다.
SELECT rpad(ename,10,'*') show02, lpad(job,7,'#') show01
FROM emp;
-- 10) ltrim(), rtrim(), trim() : 해당 데이터에서 오른쪽, 왼쪽, 특정 기준에
--  따라서 데이터 삭제처리하는 것을 말한다.
--  trim('삭제할문자열' from 컬럼명 ) : 양쪽으로 데이터를 삭제 처리..
SELECT job, rtrim(job, 'R') show01, ename, ltrim(ename,'S') show02,
	trim('S' FROM ename) show03
FROM emp;
-- 확인예제
-- 1. 이름과 직책을 출력하고, 직책은 1째부터 4번째 글자를 추출하세요.
SELECT ename, job, substr(job,1,4) show FROM emp;
-- 2. 부서번호-이름 형식으로 데이터를 출력 하되, 전체 글자가 20자가 되지 않으면,
--     오른쪽에 '!' 표시로 20자리가 되게끔 처리하세요.
SELECT rpad( deptno || '-' || ename, 20, '!') show
FROM emp;
SELECT rpad( concat( concat(deptno,'-'), ename), 20, '!') show
FROM emp;
-- 3. 사번, 이름, 직책을 출력 하되, 직책에 'MAN'으로 끝나는 데이터가 있으면 
--     삭제후, 출력 되게 하세요
SELECT job, rtrim(job, 'MAN') SHOW FROM EMP;

