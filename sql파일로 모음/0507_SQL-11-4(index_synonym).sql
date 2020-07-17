SELECT * FROM employees
WHERE last_name = 'King';

CREATE INDEX emp_lastname_idx
ON employees(last_name);

SELECT * FROM employees
WHERE last_name = 'King';

SELECT index_name
FROM user_indexes
WHERE table_name = 'EMPLOYEES';
--��ųʸ����� �ε��� ���ִ���

CREATE TABLE emp10
(empid NUMBER(4) PRIMARY KEY,
ename VARCHAR2(20) CONSTRAINT emp10_ename_uk UNIQUE,
email VARCHAR2(50));

SELECT index_name
FROM user_indexes
WHERE table_name = 'EMP10';
--���������̸����� �ε��� ���������

CREATE INDEX emp10_email_ix ON emp10(email);

DROP INDEX emp10_email_ix;
--���� ����� �������
DROP INDEX emp10_ename_uk;
--������������ �ڵ�������� �ε����� ����x



---------synonyms ���Ǿ�(��Ī)
SELECT view_name FROM user_views;
--�� �����ִ��� ���°�

SELECT * FROM emp_dept_loc_join_vu;

CREATE SYNONYM list FOR emp_dept_loc_join_vu;

SELECT * FROM list;

DROP SYNONYM list;

--emp_dept_loc_join_vu�̷��� �̸� �� �ָ� list��� ��Ī �ٿ���
