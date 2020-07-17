SELECT * FROM emp3;

CREATE TABLE emp4
(emp_id NUMBER(6),
license_no NUMBER(20),
license_name VARCHAR2(20));

ALTER TABLE emp4
ADD CONSTRAINT emp4_empid_fk FOREIGN KEY(emp_id) REFERENCES emp3(employee_id);
--emp3�� ����ִ� �츮����� ��ϰ����ϰ�
INSERT INTO emp4
VALUES(220, '1234567', '����ó�����');
COMMIT;

ALTER TABLE emp3
DROP COLUMN employee_id;
--���� �ȵ�. �ܷ�Ű ���� �־ 


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
--���� ���̺�� �� �ȹٲ�.... ������ �� �����ÿ� �ٲ�.


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
--����� ���

FLASHBACK TABLE emp3 TO BEFORE DROP;
--�����뿡 �ִ°� �ٽ� �ǻ츮��

SELECT * FROM emp3;
SELECT * FROM license_list;

DROP TABLE license_list PURGE;
show recyclebin;

--purge�� ������ �Ȱ��� �ٷ� ����

purge recyclebin;
