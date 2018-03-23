-- INSERT
-- 데이터을 입력할 때, 활용된다.
-- 형식
-- INSERT INTO 테이블명(컬럼명1,컬럼명2...)
-- VALUES(데이터1, 데이터2....)
-- ## 선언된 컬럼명에 매핑되는 DATATYPE과 합치되는
--    데이터를 순서에 맞게 입력하여야 한다.
SELECT * FROM DEPT01;
CREATE TABLE DEPT02(
  DEPTNO NUMBER,
  DNAME VARCHAR2(50),
  LOC VARCHAR2(100)
);
SELECT * FROM DEPT02;
INSERT INTO DEPT02 VALUES(10,'인사','서울강남');
COMMIT;
INSERT INTO DEPT02(DEPTNO, LOC)
VALUES(20,'서울종로'); -- DNAME은 NULL으로 처리된다.
-- 확인예제
-- MEMBER 테이블 - ID VARCHAR2(20) PASS VARCHAR2(10)
-- 1. 테이블 생성/ 데이터 입력처리..
CREATE TABLE member(
	id varchar2(20),
	pass varchar2(10)
);
INSERT INTO MEMBER values('himan','7777');
COMMIT;
SELECT * FROM MEMBER;
/* 테이블 데이터 수정 update
 * update 테이블명
 * set 컬럼명1 = 변경할데이터,
 *     컬럼명2 = 변경할데이터,
 *     ....
 * where 조건구문..
 *  */
SELECT * FROM emp01;
UPDATE emp01
SET deptno = 30;
-- 조회 조건이 없기 때문에 전체가 변경 처리 됨..
UPDATE emp01
SET hiredate = sysdate;
SELECT * FROM emp01;
CREATE TABLE emp06
AS SELECT * FROM emp;
-- 부서번호가 10번인 사원의 부서번호를 40번으로 수정.
UPDATE emp06
SET deptno = 40
WHERE deptno = 10;
SELECT * FROM emp06;
-- 연습1 : emp06 급여가 3000이상인 사원만 급여를 10% 이상처리
UPDATE emp06
SET sal=sal*1.1
WHERE sal>=3000;
SELECT * FROM emp06;
-- 연습2 : emp06 2월에 입사한 사원을 오늘 입사로 수정 처리.
SELECT to_char(hiredate,'MM')
FROM emp06;
UPDATE emp06
SET hiredate=sysdate
WHERE to_char(hiredate,'MM') ='02';
/* 삭제(delete)
 * 형식 : delete 테이블명 where 조건;
 * 
 * */
SELECT * FROM emp01;
DELETE FROM emp01
WHERE comm IS NULL;
SELECT * FROM emp06;
-- 연습) emp06 기준 JOB SALESMAN인 데이터를 삭제처리하세요
DELETE FROM EMP06
WHERE job = 'SALESMAN';
SELECT * FROM TAB;





