--0511 ��2    2-28p

CREATE GLOBAL TEMPORARY TABLE emp_temp1
ON COMMIT DELETE ROWS
AS
SELECT employee_id, salary, department_id
FROM employees;

CREATE GLOBAL TEMPORARY TABLE emp_temp2
ON COMMIT PRESERVE ROWS -- �α׾ƿ��ϸ� �ȳ���
AS
SELECT employee_id, salary, department_id
FROM employees;

SELECT * FROM emp_temp1; 
SELECT * FROM emp_temp2; --preserve��  ���뵵 �����

--�ٵ� ���������ϰ� �ٽ� ���� ��ȸ�غ��� ���̺� �ȳ���.

INSERT INTO emp_temp1
SELECT employee_id, salary, department_id
FROM employees
WHERE department_id = 90;

INSERT INTO emp_temp2
SELECT employee_id, salary, department_id
FROM employees
WHERE salary > 9000;

COMMIT;

SELECT * FROM emp_temp1; --on commit delete�� Ŀ���ϸ� ���� �����
SELECT * FROM emp_temp2; --


UPDATE emp_temp2
SET salary = salary*1.1;

TRUNCATE TABLE emp_temp2;
DROP TABLE emp_temp2;
DROP TABLE emp_temp1;

SELECT * FROM session_privs;