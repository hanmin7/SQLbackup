--0511 월
--1. 회원관리를 위한 회원테이블을 다음과 같이 생성하시오.
--테이블 이름 : member , 속성...

CREATE TABLE member
(user_id NUMBER(6) primary key,
user_name VARCHAR2(20) CONSTRAINT member_uname_nn NOT NULL,
password VARCHAR2(10) CONSTRAINT member_pw_nn NOT NULL,
id_num CHAR(13) CONSTRAINT member_id_uk UNIQUE 
                       CONSTRAINT member_id_nn NOT NULL,
phone VARCHAR2(13),
address VARCHAR2(100),
reg_date DATE,
interest VARCHAR2(15));

--2. 임의로 member테이블에 3건의 데이터를 입력하시오.
INSERT INTO member
VALUES('101', '송광광', '101', '0000000000001', '010-123-4567', '대구 대봉동', sysdate, 'DB');
INSERT INTO member
VALUES('102', '김성영', '102', '0000000000002', '010-123-4568', '대구 이천동', sysdate, 'Java');
INSERT INTO member
VALUES('103', '천인아', '103', '0000000000003', '010-123-4569', '대구 대명동', sysdate, 'Internet');

--3. 웹사이트 게시판 테이블을 다음과 같이 생성하시오
--테이블 이름 : board 속성...
CREATE TABLE board
(no NUMBER(4) primary key,
subject VARCHAR2(50) CONSTRAINT board_subject_nn NOT NULL,
content VARCHAR2(2000),
rdate DATE,
userid NUMBER(6) CONSTRAINT board_userid_fk references MEMBER(USER_ID));

--. 시퀀스 생성.
CREATE SEQUENCE board_no_seq
INCREMENT BY 1
START WITH 1
NOCACHE
NOCYCLE;

--게시판 번호는 방금 시퀀스를 사용해서 입력.
INSERT INTO board
VALUES (board_no_seq.nextval, '제목', '내용', sysdate, '101');
INSERT INTO board
VALUES (board_no_seq.nextval, '제목1', '내용1', sysdate, '102');
INSERT INTO board
VALUES (board_no_seq.nextval, '제목2', '내용2', sysdate, '103');

SELECT * FROM board;

