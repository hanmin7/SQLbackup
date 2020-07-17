--0511 ��
--1. ȸ�������� ���� ȸ�����̺��� ������ ���� �����Ͻÿ�.
--���̺� �̸� : member , �Ӽ�...

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

--2. ���Ƿ� member���̺� 3���� �����͸� �Է��Ͻÿ�.
INSERT INTO member
VALUES('101', '�۱���', '101', '0000000000001', '010-123-4567', '�뱸 �����', sysdate, 'DB');
INSERT INTO member
VALUES('102', '�輺��', '102', '0000000000002', '010-123-4568', '�뱸 ��õ��', sysdate, 'Java');
INSERT INTO member
VALUES('103', 'õ�ξ�', '103', '0000000000003', '010-123-4569', '�뱸 ���', sysdate, 'Internet');

--3. ������Ʈ �Խ��� ���̺��� ������ ���� �����Ͻÿ�
--���̺� �̸� : board �Ӽ�...
CREATE TABLE board
(no NUMBER(4) primary key,
subject VARCHAR2(50) CONSTRAINT board_subject_nn NOT NULL,
content VARCHAR2(2000),
rdate DATE,
userid NUMBER(6) CONSTRAINT board_userid_fk references MEMBER(USER_ID));

--. ������ ����.
CREATE SEQUENCE board_no_seq
INCREMENT BY 1
START WITH 1
NOCACHE
NOCYCLE;

--�Խ��� ��ȣ�� ��� �������� ����ؼ� �Է�.
INSERT INTO board
VALUES (board_no_seq.nextval, '����', '����', sysdate, '101');
INSERT INTO board
VALUES (board_no_seq.nextval, '����1', '����1', sysdate, '102');
INSERT INTO board
VALUES (board_no_seq.nextval, '����2', '����2', sysdate, '103');

SELECT * FROM board;

