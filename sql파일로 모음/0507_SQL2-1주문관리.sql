CREATE TABLE orders
(oid NUMBER(4),
cid NUMBER(4));

SELECT * FROM session_privs;


SELECT * FROM hr.employees;
--�ٸ������� �ڷ� �˻� �� �����ڸ� ���������
--hr�� ���ѵ� �޾ƾ���.

UPDATE hr.employees
SET salary = salary*1.1;

ROLLBACK;

SELECT * FROM hr.emp_list_5080_vu;

CREATE SYNONYM emp FOR hr.emp_list_5080_vu;
--�ý���(Ŀ���â����) �ó�� ���� ���� �� ���Ǿ� ���� 

SELECT * FROM emp;
--��Ī���� �Ἥ ������ �����̺����� �� ������. ���Ȼ� ����


SELECT * FROM hr.dept_list_vu;

SELECT * FROM d;

SELECT * FROM session_privs;



--------------------------------------------------------------
SELECT * FROM session_privs;
SELECT * FROM hr.locations;

--role�� ���� ������ ������ �� ����.

--------------------------------------------------------------
SELECT * FROM session_privs;
SELECT * FROM tab;
SELECT * FROM emp;

--tab ���Ǿ� ���°�
--hr���� hr.emp_list_5080_vu �� ���� �P���� �Ⱥ���.
--hr���� �� drop�ص� �Ⱥ���.
--�ٵ� om���� ���� '���Ǿ�'�� ��� ��������.

