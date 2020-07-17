DELETE FROM departments
WHERE department_id = 60;

UPDATE employees
SET department_id = 400
WHERE employee_id = 107;

DESC user_constraints;
SELECT table_name, constraint_name, constraint_type
FROM user_constraints
WHERE table_name IN ('EMPLOYEES','DEPARTMENTS')
ORDER BY 1;

DESC user_constraints;
SELECT table_name, constraint_name, constraint_type
FROM user_constraints
WHERE table_name IN ('EMP')
ORDER BY 1;
-- ���̺� ���� �� �������� �� ������ �⺻ ���社 ����. ���� x

CREATE TABLE member
(member_id NUMBER(4) PRIMARY KEY,
member_name VARCHAR2(20) CONSTRAINT member_name_uk UNIQUE
                                          CONSTRAINT member_name_nn NOT NULL,
member_deptno NUMBER(4),
CONSTRAINT member_deptno_fk FOREIGN KEY(member_deptno) REFERENCES departments(department_id));

SELECT table_name, constraint_name, constraint_type
FROM user_constraints
WHERE table_name IN ('MEMBER')
ORDER BY 1;

INSERT INTO member (member_id, member_name)
VALUES(101, '������');
-- �ΰ��� ���

INSERT INTO member
VALUES(102, '����', 500);
-- �ű� ���� ���� x ������ ������. 500���� ���
--�÷������� ���� ���� �� ����

INSERT INTO member
VALUES(101, '����', 90);
--�⺻Ű ����
--10-12p

CREATE TABLE ann_sal_list
AS 
SELECT employee_id AS emp_id, last_name emp_name, 
          salary*12 AS ann_sal
FROM employees;

CREATE TABLE sum_sal
AS
SELECT department_id AS deptno, SUM(salary) sum_sal_by_deptno
FROM employees
GROUP BY department_id;

DESC sum_sal;
SELECT * FROM sum_sal;

CREATE TABLE dept80
AS
SELECT employee_id, last_name,
          salary*12 ANNSAL,
          hire_date
FROM employees
WHERE department_id = 80;         

DESC dept80;

SELECT * FROM tab;

DESC user_tables;
SELECT table_name FROM user_tables;

DROP TABLE member;
DROP TABLE sum_sal;
DROP TABLE emp;
DROP TABLE dept;
DROP TABLE departments;

SELECT * FROM jobs;

CREATE VIEW dept80_vu
AS
SELECT employee_id, last_name, salary*12 annsal, hire_date
FROM employees
WHERE department_id = 80;

SELECT * FROM dept80;
SELECT * FROM dept80_vu;
DESC dept80_vu;

UPDATE employees
SET salary = salary*1.2;
COMMIT;

SELECT employee_id, last_name, salary*12 annsal, hire_date
FROM employees
WHERE department_id = 80;

CREATE VIEW empvu80
AS
SELECT employee_id, last_name, salary
FROM employees
WHERE department_id = 80;

SELECT * FROM empvu80;

UPDATE empvu80
SET salary = 11000
WHERE employee_id = 176;
COMMIT;
-- �信�� ���� ���� ���� (�ܼ��信����)

SELECT * FROM employees;

CREATE OR REPLACE VIEW empvu80
AS
SELECT employee_id, last_name, salary, job_id
FROM employees
WHERE department_id = 80;



--employees, departments. locations �� �����Ͽ� �����ȣ, ����̸�(last_name), �μ��̸�, �μ�����ġ�ϴµ��� �̸� ���.
SELECT e.employee_id, e.last_name, d.department_name, l.city
FROM employees e JOIN departments d
ON (e.department_id = d.department_id)
JOIN locations l
ON (d.location_id = l.location_id);

--���� emp_dept_loc_join_vu ��� �̸����� �����Ͻÿ�
CREATE VIEW emp_dept_loc_join_vu
AS
SELECT e.employee_id, e.last_name, d.department_name, l.city
FROM employees e JOIN departments d
ON (e.department_id = d.department_id)
JOIN locations l
ON (d.location_id = l.location_id);