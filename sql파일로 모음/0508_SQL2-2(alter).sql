--ALTER

CREATE TABLE emp3
AS
SELECT employee_id, last_name, salary, hire_date, department_id
FROM employees
WHERE department_id = 50;

SELECT * FROM emp3;
DESC emp3;

ALTER TABLE emp3
ADD(job_id VARCHAR2(15));
DESC emp3;
SELECT * FROM emp3;

ALTER TABLE emp3
MODIFY(last_name VARCHAR2(20));

ALTER TABLE emp3
MODIFY(job_id DEFAULT 'No Job');

UPDATE emp3
SET job_id = DEFAULT;
--�������� �ٷ� ����Ʈ������ �Ⱥ��ؼ� ������Ʈ ����
--null�� ���� ����ǥ ���� ��

ALTER TABLE emp3
DROP COLUMN hire_date;

--�������� ���� ������ ��



--------�������ǿ��� alter
SELECT constraint_name, constraint_type, status
FROM user_constraints
WHERE table_name = 'EMP3';

DESC user_cons_columns;

SELECT * FROM user_cons_columns
WHERE table_name = 'EMP3';

--�������� ��� �� �ִ��� ���� ����   -------------------------------
SELECT constraint_name, t.constraint_type, c.column_name, t.status
FROM user_constraints t JOIN user_cons_columns c
USING (constraint_name)
WHERE t.table_name = 'EMP3';
--------------------------------------------------------------------------
--��������Ÿ�� c�� ���� p�� �����̸Ӹ�Ű u�� ����ũ



ALTER TABLE emp3
ADD primary key(employee_id);

ALTER TABLE emp3
DROP primary key;
--�����̸Ӹ�Ű �ϳ��ۿ� ��� �̸���� �����̸Ӹ�Ű�� ���� �� ����



--�����̸� ����
ALTER TABLE emp3
ADD CONSTRAINT emp3_empid_pk primary key(employee_id);

ALTER TABLE emp3
ADD unique(last_name);

ALTER TABLE emp3
DROP CONSTRAINT sys_c007053;
--����ũ�� �������� �����ϱ⿡ ����ũ�� ���� �� ��� �� �̸����� �����ؼ� ��������


ALTER TABLE emp3
RENAME CONSTRAINT sys_c007054 TO emp3_name_uk;
--���� �̸� ���°ɷ� �������� �� �̸������ϴ� �� 

--ALTER TABLE emp3
--RENAME CONSTRAINT sys_c007049 TO emp3_name_nn;

SELECT * FROM emp3;

ALTER TABLE emp3
ADD CONSTRAINT emp3_deptid_fk FOREIGN KEY(department_id)
REFERENCES departments(department_id);
--��ȸ�� ���� Ÿ�� R�� ����.

ALTER TABLE emp3
ADD CONSTRAINT emp3_sal_ck CHECK(salary BETWEEN 3000 AND 10000);
--check������� �������.



SELECT constraint_name, t.constraint_type, c.column_name, t.status, t.search_condition
FROM user_constraints t JOIN user_cons_columns c
USING (constraint_name)
WHERE t.table_name = 'EMP3';
--�� ���ϰ� ������(search_condition  �����̶� üũ ��������)
--��ųʸ�




--status 
UPDATE emp3
SET salary = 13000
WHERE employee_id  = 144;
--�������Ƕ����� ����x

ALTER TABLE emp3
DISABLE CONSTRAINT emp3_sal_ck;
--üũ ���� ��� ���� ���� Ȯ���ϸ� disable�� ����

UPDATE emp3
SET salary = 13000
WHERE employee_id  = 144;
COMMIT;
SELECT * FROM emp3;
--�ٽ� �����ϸ� ������.

ALTER TABLE emp3
ENABLE CONSTRAINT emp3_sal_ck;
--�ٽ� Ű�����ص� �������� �����ϴ°� ����� �� �� ����
--�ٽ� ���� �� �ؾ���

UPDATE emp3
SET salary = 8000
WHERE employee_id  = 144;
COMMIT;
ALTER TABLE emp3
ENABLE CONSTRAINT emp3_sal_ck;

--���� ��ó���� ���ؼ� ��. (status enable, disable)
-- ���� �ڷ� ó���ϸ� ������ ���� ���� �� ���� �� �� �� ���� ó���� ���߿�...




--SELECT constraint_name, t.constraint_type, c.column_name, t.status, t.search_condition
--FROM user_constraints t JOIN user_cons_columns c
--USING (constraint_name)
--WHERE t.table_name = UPPER('&table_name')
--/
--��ũ��Ʈ ���� ����� ~~~
--�޸��忡 �����ñ��� �ؼ� q_cons.sql �� ����
--�����Ѱ� �ҷ��ͼ� �� �� -> @c:\oraclexe\labs\q_cons.sq
--(������ġ�� ���� ���༭ ��)
