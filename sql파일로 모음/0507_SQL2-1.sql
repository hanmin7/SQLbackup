--SQL2     user access


SELECT * FROM session_privs;
--���� �����ִ��� ���°�

GRANT select ON hr.employees TO om;
--om���� hr�� employees ���̺� �� ���ְ� ���� ��

GRANT update ON hr.employees TO om;

REVOKE select ON hr.employees FROM om;
REVOKE update ON hr.employees FROM om;
--��� ���� ����


CREATE VIEW emp_list_5080_vu
AS
SELECT employee_id empno, CONCAT( first_name, CONCAT(' ', last_name)) ename, email, department_id
FROM employees
WHERE department_id BETWEEN 50 AND 80;

SELECT * FROM emp_list_5080_vu;

GRANT select ON hr.emp_list_5080_vu TO om;



--

CREATE VIEW dept_list_vu
AS
SELECT department_id deptno, department_name dept_name, city
FROM departments JOIN locations
USING(location_id);

GRANT select ON hr.dept_list_vu TO public;

--�׳� �ó���̶� �ۺ��ó�� ���� �ٸ�. 
--���� hr�� �ۺ��ó�Ծ�� �ý��۰����ڰ� �ۺ��ó�� ���� �޾ƾ���.

CREATE PUBLIC SYNONYM d FOR hr.dept_list_vu;
--������ d�� �� ���̺� �� �� ����. �� �������� �ó�� ����°�, �ߺ�����

--dual�� ���뵿�Ǿ��



--�� ���� ������ �� om���� �ó���� ������ ������ x
REVOKE select on hr.emp_list_5080_vu FROM om;

GRANT select on hr.emp_list_5080_vu TO om;

DROP VIEW emp_list_5080_vu;



SELECT * FROM session_privs;