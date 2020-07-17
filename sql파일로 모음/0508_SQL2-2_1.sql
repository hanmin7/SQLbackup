SELECT * FROM emp3;

CREATE TABLE emp4
(emp_id NUMBER(6),
license_no NUMBER(20),
license_name VARCHAR2(20));

ALTER TABLE emp4
ADD CONSTRAINT emp4_empid_fk FOREIGN KEY(emp_id) REFERENCES emp3(employee_id);
--emp3에 들어있는 우리사원만 등록가능하게
INSERT INTO emp4
VALUES(220, '1234567', '정보처리기사');
COMMIT;

ALTER TABLE emp3
DROP COLUMN employee_id;
--삭제 안됨. 외래키 참조 있어서 


@c:\oraclexe\labs\q_cons.sql

SELECT constraint_name, t.constraint_type, c.column_name, t.status, t.search_condition
FROM user_constraints t JOIN user_cons_columns c
USING (constraint_name)
WHERE t.table_name = UPPER('&table_name');


ALTER TABLE emp3
DROP COLUMN employee_id CASCADE CONSTRAINTS;

SELECT * FROM emp3;
SELECT * FROM emp4;

DESC emp4
ALTER TABLE emp4 RENAME COLUMN license_no TO license_id;

RENAME emp4 TO license_list;

SELECT * FROM license_list;
--보통 테이블명 잘 안바꿈.... 정리할 때 관리시에 바꿈.


CREATE TABLE NEW_EMP
(employee_id NUMBER(6)
PRIMARY KEY USING INDEX(CREATE INDEX emp_id_idx ON NEW_EMP (employee_id)),
first_name VARCHAR2(20),
last_name VARCHAR2(25));

--2-22p
SELECT INDEX_NAME, TABLE_NAME
FROM USER_INDEXES
WHERE TABLE_NAME = 'NEW_EMP';

CREATE INDEX upper_dept_name_idx
ON departments(UPPER(department_name));

SELECT *
FROM departments
WHERE UPPER(department_name) = 'SALES';



DROP TABLE emp3;
show recyclebin;
--지운거 목록

FLASHBACK TABLE emp3 TO BEFORE DROP;
--휴지통에 있는거 다시 되살리기

SELECT * FROM emp3;
SELECT * FROM license_list;

DROP TABLE license_list PURGE;
show recyclebin;

--purge는 휴지통 안가고 바로 지움

purge recyclebin;
