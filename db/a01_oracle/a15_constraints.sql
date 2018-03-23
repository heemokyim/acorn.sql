/* 데이터 무결성 제약 조건
 * 1. 데이터의 정확과 일관성을 보장하기 위하여 테이블에서
 * 	컬럼을 생성할 때, 제약조건을 걸어 놓는 것을 말한다.
 * 데이터 무결성 제약조건의 장점
 * 1. 테이블 생성시 무결성 제약조건을 정의 가능
 * 2. 테이블에 대해 정의, 데이터 딕셔너리에 저장되므로
 * 		응용프로그램에서 입력된 모든 데이터에 대해 동일하게 적용
 * 3. 제약조건 활성화, 비활성화 할 수 있는 융통성을 발휘할 수 있다.

 */
-- NOT NULL : null값을 허용하지 않는다.
CREATE TABLE emp_notnull(
	empno number(4) NOT NULL,
	ename VARCHAR2(10) NOT NULL,
	job VARCHAR2(10),
	deptno number(4)
);
SELECT * FROM emp_notnull;
INSERT INTO emp_notnull values(NULL,'홍길동','판매원',10);
INSERT INTO emp_notnull values(NULL,null,'판매원',10);
INSERT INTO emp_notnull(job, deptno) values('판매원',10);
INSERT INTO emp_notnull(empno,ename) values(7878,'홍길동');
INSERT INTO emp_notnull values(7879,'신길동','개발자',10);
-- unique : 중복된 값을 허용하지 않는다. 항상 유일한 값을 갖도록 한다.
CREATE TABLE emp_unique(
	empno number(4) UNIQUE,
	ename VARCHAR2(10) NOT NULL,
	job VARCHAR2(10),
	deptno NUMBER(4)
);
INSERT INTO emp_unique values(7499,'ALLEN','판매원',30);
INSERT INTO emp_unique values(7499,'홍리나','관리자',40); -- 유일키 예외발생
INSERT INTO emp_unique values(NULL,'신길동','영업',30);
INSERT INTO emp_unique values(NULL,'마길동','총무',50); 
-- null은 동일값이라도 unque로 인식
SELECT * FROM emp_unique;
-- 확인예제 : calendar 테이블에 id(유일키), indate(날짜입력), schedule(일정내용)
--           을 생성하고, 데이터 입력시, 예외 내용을 확인하세요(null, 동일데이터입력)
CREATE TABLE calendar(
	id NUMBER UNIQUE,
	indate DATE,
	schedule VARCHAR2(100)
);
INSERT INTO calendar values(1000,sysdate,'오늘입력');
INSERT INTO calendar values(1000,sysdate,'데이터베이스수업'); -- 유일키 에러발생
INSERT INTO calendar values(1001,to_date('2010/04/01','YYYY/MM/DD'),'4월의 첫날(월간계획)');
INSERT INTO calendar(indate,schedule) values(sysdate,'일정입력요망');
INSERT INTO calendar(indate,schedule) values(sysdate,'일정입력요망');
SELECT * FROM calendar;
-- primary key : null 허용하지 않고, 중복된 값을 허용하지 않을 때 활용된다.
--               not null + unique (결합)
CREATE TABLE student(
	studnum NUMBER PRIMARY KEY,
	name varchar2(30) NOT NULL,
	grade NUMBER,
	major varchar2(50)
);
INSERT INTO student values(7777, '홍길동',1,'컴퓨터공학과');
INSERT INTO student values(NULL,'신길동',1,'멀티미디어과');
-- null이 허용되지 않음.
INSERT INTO student values(7777,'마길동',2,'통계학과');
-- 중복된 값이 허용되지 않음..
INSERT INTO student values(7778,'오길동',4,'문화예술학과');
SELECT * FROM student;
--  
--  
CREATE TABLE emp08_fore(
	empno NUMBER PRIMARY KEY,
	ename varchar2(50) UNIQUE,
	sal NUMBER,
	deptno NUMBER REFERENCES DEPT(DEPTNO)
);
SELECT * FROM emp08_fore;
SELECT * FROM dept;
INSERT INTO emp08_fore values(1111, '홍길동', 3000, 10);
INSERT INTO emp08_fore values(1112,'신길동',4000,50);
-- 참조키 제약조건 에러 발생..
-- 
/* 확인예제
 * 게시판테이블과   게시판의자료테이블
 * board : no     restore  reno(자료 key-board의 no를 참조), 
 *                         fname(파일명), content(내용)
 *  */
SELECT * FROM board;
CREATE TABLE RESTORE(
 reno NUMBER REFERENCES board(no),
 fname varchar2(100),
 content varchar2(100)
);
INSERT INTO restore values(1,'file01.txt','첨부파일1');
INSERT INTO restore values(1,'file02.txt','첨부파일2');
INSERT INTO restore values(1,'file03.txt','첨부파일3');
SELECT * FROM restore;
INSERT INTO restore values(3,'file01.txt','첨부파일1');
-- 참조 키 에러 발생...
/* check : 해당 컬럼에 지정된 데이터만 입력 처리 되게 설정..
 *    컬럼명 type check (컬럼명 in(한정된 데이터 범위))
 * 1) check(컬럼명 in(데이터1, 데이터2,데이터3))
 * 2) check(컬럼명 >=0 and 컬럼명 <=100)
 * 
 * */
CREATE TABLE citizen(
	citino NUMBER PRIMARY KEY,
	name varchar2(50),
	gender VARCHAR2(1) check( gender in('M','F'))
);
SELECT * FROM citizen;
INSERT INTO citizen values(1, '이정석','M');
INSERT INTO citizen values(2, '홍리나','F');
SELECT * FROM citizen;
INSERT INTO citizen values(3, '홍경석','K');
-- 확인) 물품테이블(물건id, 물건명, 상태('신제품','중고품','전시용'))
create table product(
   id varchar2(20) primary key,
   name varchar2(30),
   status varchar2(10) check(status in('신제품','중고품','전시용') ) 
);
insert into product values(1001,'맥북','신제품');
insert into product values(1002,'갤노트10','전시용');
insert into product values(1003,'갤','사용중');  
SELECT * FROM product;
SELECT * FROM student;
CREATE TABLE exam(
	studno NUMBER PRIMARY KEY REFERENCES student(studnum),
	subject01 NUMBER check( subject01>=0 AND subject01<=100),
	subject02 NUMBER check( subject02>=0 AND subject02<=100),	
	subject03 NUMBER check( subject03>=0 AND subject03<=100));
INSERT INTO exam values(7777,90,70,80);
INSERT INTO exam values(7778,100,90,70);
DELETE FROM exam WHERE studno=7778;
INSERT INTO exam values(7778,120,90,70);
INSERT INTO exam values(7778,100,90,70);
SELECT a.*, b.*
FROM student a, exam b 
WHERE a.studnum = b.studno;
SELECT * 
FROM user_constraints
WHERE TABLE_NAME IN ('PRODUCT','CITIZEN');
-- user_constraints : 데이터 딕션어리 테이블로 현재 오라클
-- 데이터베이스에서 제약조건 설정 내용을 볼 수 있다..
/* 사용자 정의 제약조건 제약조건이름을 선언하여 사용하기.
 * 1. 형식
 * 	컬럼명 테이터TYPE constraint 사용자정의제약조건이름 primary key/not null....
 * 2. constraint이름 명명규칙.
 * 		테이블명_컬럼명_제약조건종류 ex) member_no_pk
 * 	제약조건종류 
 * 	pk : primary key
 *  fk : foreign key
 *  uk : unique key
 *  ck : check
 *  nn : not null
 * */
CREATE TABLE student01(
	NO NUMBER CONSTRAINT student01_no_pk PRIMARY KEY,
	name VARCHAR2(50)
);
SELECT *
FROM user_constraints
WHERE table_name in('STUDENT01');
/* 무결성 제약조건 삭제 처리.
 * alter table 테이블명
 * drop constraint 제약조건이름(CONSTRAINT_NAME) [CASCADE]
 * 	CASCADE : 삭제되는 컬럼을 참조하는 참조 무결성 제약조건도 함께 삭제
 * */
ALTER TABLE student01
DROP CONSTRAINT STUDENT01_NO_PK;
-- 제약조건 추가 처리.
-- alter table 테이블명
-- add constraint 제약조건명(테이블_컬럼_제약조건type) 제약조건type
ALTER TABLE student01
ADD CONSTRAINT student01_no_pk PRIMARY key(no);
-- 확인예제 emp_dept 테이블에 empno는 primary key
--         ename은 not null로 제약조건을 추가하고,
--         확인한 후, 제약조건을 삭제처리하세요.
SELECT * FROM emp_dept;
ALTER TABLE emp_dept
MODIFY ename CONSTRAINT empDept_empno_nn NOT NULL;

SELECT *
FROM user_constraints
WHERE table_name in('EMP_DEPT');
INSERT INTO EMP_DEPT VALUES(7777,'홍길동','총무','서울강남');
INSERT INTO EMP_DEPT VALUES(7777,'신길동','인사','서울강남');
ALTER TABLE EMP_DEPT
DROP CONSTRAINT empDept_empno_nn;
INSERT INTO EMP_DEPT VALUES(7777,'신길동','인사','서울강남');







