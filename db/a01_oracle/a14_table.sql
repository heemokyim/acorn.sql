/* create table 구조 정의
 * 1. 형식
 * create table 테이블명(컬럼명 데이터type ... );
 * 2. data type 
 * 	1) char(size) :고정형 문자 데이터
 *  2) varchar2(size) : 2000bytes 가변길이 문자열.
 *  3) number : 최고 40자리까지의 숫자를 저장.
 *     number(w) : w자리까지의 수치로 최대 38자리
 *     number(w,d) : w는 전체길이, d는 소수점 이하 자릿수
 *  4) date : bc 4712 ~ ad 4712
 *  5) long : 가변 길이의 문자형 데이터 type, 최대 2gb
 *  6) lob : 2gb 가변 길의 바이너리 데이터 저장. 이미지 /실행 파일 저장.
 * 3. 제약사항
 * 	1) PRIMARY KEY : 컬럼명 DATA TYPE PRIMARY KEY
 * 		테이블에서 유일하며 NULL이 되지 않게 처리되는 KEY 컬럼을 지정할 때
 * 		활용된다.
 *     EX) EMP --> empno, DEPT --> deptno
 *      입력시/수정시 위 제약사항(null,중복) 처리시 에러발생.
 * 
 */
CREATE TABLE board(
	NO NUMBER PRIMARY KEY,
	refno NUMBER,
	title varchar2(100),
	content varchar2(1000),
	writer varchar2(100),
	credate DATE,
	readcnt number
);
SELECT * FROM board;
INSERT INTO board values(1,0,'첫번째 등록','내용없음','홍길동',sysdate,0);
INSERT INTO board values(2,0,'첫번째 등록','내용없음','홍길동',sysdate,0);
-- 확인예제) 문제은행 테이블을 primary key를 가진 컬럼을 포함하여 생성하세요.
--          번호, 문제, 문제유형, 등록일, 정답
CREATE TABLE exambank(
	NO NUMBER PRIMARY KEY,
	QUESTION VARCHAR2(1000),
	QUETYPE varchar2(10),
	CREDTE DATE,
	ANSWER VARCHAR2(500)
);
INSERT INTO EXAMBANK VALUES(
	1, '활용하는 데이터 종류는?','단답식',sysdate,'oracle');
SELECT * FROM exambank;
/*테이블에 새로운 컬럼 추가
 * 형식
 * alter table 테이블명 add(컬럼명 데이터타입);
 * */
SELECT * FROM emp02;
ALTER TABLE emp02 add( dname varchar2(30) );
-- 연습 emp02에 credate로 등록 날짜를 입력하는 컬럼을 추가하세요..
-- 컬럼명 데이터타입 DEFAULT 입력하지않았을 때 초기값 설정.
ALTER TABLE emp02 add( credte DATE DEFAULT sysdate);
SELECT * FROM emp02;
INSERT INTO emp02(ename, job) values('홍길동','SUPERMAN');
/* 컬럼을 수정 MODITY
 * 	기존의 테이블 소속 컬럼의 TYPE, 크기, 기본값 변경 가능
 * 형식
 * 	ALTER TABLE 테이블명
 * 	MODIFY 컬럼명  변경할DATETYPE DEFAULT 변경할DEFAULT값
 * */
SELECT * FROM EMP04;
-- 	"JOB" VARCHAR2(9), 
ALTER TABLE EMP04
MODIFY JOB NUMBER;
-- f5으로 데이터 TYPE변경확인..
SELECT * FROM EMP03;
ALTER TABLE EMP03
MODIFY JOB NUMBER;
/* 구조 변경시 제약 사항.
 * 1. 해당 컬럼에 자료가 없는 경우.
 * 		컬럼의 데이터타입과 크기를 변경할 수 있다.
 * 2. 해당 컬럼에 자료가 있는 경우
 * 		1) 컬럼의 데이터 타입을 변경할 수 없다.
 * 			문자 -> 숫자  숫자 --> 문자  문자->날짜..
 * 		    변경 불가.
 * 		2) 크기를 늘리거나 줄일 수 있지만, 현재 가지고 있는 
 * 			데이터 크기보다 작게 변경은 할 수 없다.
 * */
ALTER TABLE EMP03
MODIFY JOB varchar2(20);
ALTER TABLE EMP03
MODIFY JOB varchar2(5);

SELECT * FROM EMP04;
-- 확인) emp04 테이블의 empno를 문자형으로 변환 처리하세요.
ALTER TABLE EMP04
MODIFY empno varchar2(50);
-- 확인) emp03 ename의 크기를 늘리고, empno가 primary key가 있는지
--		확인하고 없으며 primary key를 설정하세요.
alter TABLE emp03
MODIFY ename varchar2(50);
ALTER TABLE EMP03
MODIFY empno NUMBER PRIMARY KEY;
/* 컬럼의 삭제..
 * 형식
 * alter table 테이블명
 * drop column 컬럼명..
 * */
SELECT * FROM emp04;
ALTER TABLE emp04
DROP COLUMN deptno;
SELECT * FROM emp03;
ALTER TABLE emp03
DROP COLUMN comm;
-- 컬럼의 이름의 변경..
-- alter table 테이블명
-- rename column 기존컬럼명 to 변경할 컬럼명..
ALTER TABLE emp03
RENAME COLUMN sal TO salary;
SELECT * FROM emp03;
-- 테이블명의 변경..
-- alter table 기존테이블명 rename to 변경테이블명
ALTER TABLE emp03 RENAME TO emp30;
SELECT * FROM emp30;
CREATE TABLE emp03
AS SELECT * FROM emp;
-- 테이블 삭제 처리..: drop table 테이블명..
SELECT * FROM emp03;
DROP TABLE emp03;
-- 확인예제 emp30의 empno를 no로 변경, ename을 name으로 변경처리..
--         emp30을 emp40으로 복사한 후, emp30의 테이블은 삭제처리..
SELECT * FROM emp30;
ALTER TABLE emp30
RENAME COLUMN empno TO NO;
ALTER TABLE emp30
RENAME COLUMN ename TO name;

CREATE TABLE emp40
AS
SELECT * FROM emp30;
DROP TABLE emp30;
SELECT * FROM emp40;


-- 특정 컬럼에 데이터가 없어서, 기준 데이터로 수정형식으로 입력할 경우.
CREATE TABLE emp07
AS
SELECT * FROM emp;

UPDATE emp07
SET hiredate=NULL;

UPDATE emp07 a
 SET hiredate = (SELECT hiredate 
                   FROM emp b 
                  WHERE a.empno=b.empno);
/* 데이터 테이블 삭제
 * 1. ddl
 *    테이블 구조에 대한 삭제명령으로 처리하는 것을 말한다. 
 * 	  기존 데이터 삭제뿐 아니라, 물리적인 저장 공간까지 반환..
 *    rollback이 불가능
 * 	  where 절을 이용하여 특정 행만 삭제하는 것이 불가능
 *    truncate table 테이블명.
 * 2. dml
 *    기존 데이터만 삭제하는 명령이며, rollback가능
 *    where절을 이용하여 특정 행만 삭제 가능
 *    delete from 테이블명
 * */
CREATE TABLE empDEL01
as
SELECT * FROM emp;
CREATE TABLE empTRUN01
as
SELECT * FROM emp;
SELECT * FROM empDEL01;
DELETE FROM empDEL01;
ROLLBACK;
SELECT * FROM empTRUN01;
TRUNCATE TABLE empTRUN01;
ROLLBACK; -- truncate로 처리한 테이블은 원복이 되지 않는다.
-- 확인예제  deptDel테이블과 deptTRUN테이블을 복사형식으로 생성하고
--   deptDel: delete문에 의해서 부서번호 10 데이터를 삭제한 후, 복구처리
--   deptTRUN : truncate문제 의해 삭제 복구가능 여부 확인.    
CREATE TABLE deptDEL
AS
SELECT * FROM dept;
CREATE TABLE deptTRUN
AS
SELECT * FROM dept;
SELECT * FROM deptDEL;
DELETE FROM deptDEL
WHERE deptno = 10;
ROLLBACK;
SELECT * FROM deptTRUN;
truncate TABLE deptTRUN;



























