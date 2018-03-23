/* sequence
 *1. 유일한 식별자를 위해 만드는 연속형 데이터 처리 객체.
 *2. 기본키 값을 자동으로 생성하기 위해 일련번호(1~~...) 생성 객체
 *	ex) 게시판에서 게시글번호를 자동으로 순서대로 저장하여 처리 할때.
 *3. 형식
 *	create sequence 시퀀스이름
 *		[increment by 증가분]
 *		[start with 시작할번호]
 *		[maxvalue 최고번호 | nomaxvalue]
 *		[minvalue 최저번호 | nominvalue]
 *		[cycle|nocycle 반복여부]
 *		[cache n: nocache : 성능 향상을 위해 메모리 캐쉬 시퀀스 갯수 
 *			default 20]   
 */
CREATE SEQUENCE seq01
	INCREMENT BY 1
	START WITH 1
	MAXVALUE 100;
-- sequence 활용
-- 시퀀스명.nextval : 다음번호호출 count up
SELECT seq01.nextval FROM dual;
-- 시퀀스명.currval : 현재저장된 번호호출..
SELECT seq01.currval FROM dual;
-- 확인) 시퀀스만들기와 활용하기.
--    1) 사번 10001 시작, 최고 99999로 시퀀스 만들기..
--    2) 부서번호 10 시작, 10씩 증가,  최고 90
-- 시퀀스 삭제 drop sequence 시퀀스명;
CREATE SEQUENCE seq_emp
	START with 10001
	INCREMENT BY 1
	MAXVALUE 99999;
CREATE SEQUENCE seq_dept
	START WITH 10
	INCREMENT BY 10
	MAXVALUE 90;
DROP SEQUENCE seq_dept;
SELECT seq_emp.nextval 
FROM dual;
SELECT seq_dept.nextval 
FROM dual;

CREATE TABLE emp08(
	NO NUMBER PRIMARY KEY,
	name varchar2(50),
	regdte date
);
INSERT INTO emp08 values(seq_emp.nextval, '마길동',sysdate);
SELECT * FROM emp08;
CREATE TABLE emp09(
	compcode varchar2(50) PRIMARY KEY,
	name varchar2(50),
	regdte date
);
INSERT INTO emp09 values('KPO25AC'||seq_emp.nextval,'홍길동',sysdate);
SELECT * FROM emp09;



	