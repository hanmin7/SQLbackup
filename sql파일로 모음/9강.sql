-- 9�� ////////////////////////////////////// 
CREATE TABLE emp
AS
SELECT * FROM employees;
CREATE TABLE dept
AS
SELECT * FROM departments;

SELECT *
FROM emp;
SELECT *
FROM dept;

INSERT INTO dept
VALUES(70, 'Public Relations', 100, 1700);
--�μ���ȣ70�� �߰� 
--insert into�� �÷� �Ⱦ��� �׳� ���� ������ ��.

SELECT *
FROM dept;
--Ʃ���� ������

INSERT INTO dept(department_name, department_id)
VALUES('Parchasing', 30);
--�Ŵ���,����id �������� null����

DESC dept;
--dept_name�� ������. �̸� �� �־������

INSERT INTO dept
VALUES(100,'Finance', null, null);
--���Ƿ� null �־���

COMMIT;

SELECT *
FROM emp;

UPDATE emp
SET salary = salary*1.1, department_id = 20;
--where�������༭ ��ü �� 21���� �� �ٲ����

ROLLBACK;

UPDATE emp
SET salary = salary*1.1, department_id = 20
WHERE employee_id = 200;
-- �̸����� �ϸ� �ߺ����� �� ������ ����ũ�� Į������ ����ϱ�

UPDATE emp
SET salary = salary+1000
WHERE employee_id = 201;


CREATE TABLE sales_reps
AS
SELECT employee_id, last_name, salary, commission_pct
FROM employees
WHERE 1=2;

SELECT *
FROM sales_reps;

--DML�۾��ϴ� DDL (���̺����)�ϸ� �ڵ� Ŀ�� �Ǿ����
--Ʈ������� ���� 

