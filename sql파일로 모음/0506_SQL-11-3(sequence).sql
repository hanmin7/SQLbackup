--11�� �� �ڿ� ����

CREATE SEQUENCE dept_deptid_seq
INCREMENT BY 10
START WITH 200
NOCACHE
NOCYCLE;

SELECT * FROM departments;

INSERT INTO departments(department_id, department_name)
VALUES (dept_deptid_seq.nextval, 'Service');

INSERT INTO departments(department_id, department_name)
VALUES (dept_deptid_seq.nextval, 'Service1');

SELECT dept_deptid_seq.currval FROM dual;
--������� ����� �˾ƺ��°�

SELECT * FROM employees;

ROLLBACK;


INSERT INTO employees
VALUES(dept_deptid_seq.nextval, 'Adam', 'Lee', 'ALEE', '123.456.7890', sysdate, 'SA_REP', 8000, null, 102, 50);
--220 ���� �Ҵ��. �ѹ������� ��ȣ�� ���ư�������.
--�������� employees, departments �ƹ� ���̺� �� �� ������(��������) but ����ƴ�. 

--ĳ�ø������µ� ����Ű�� ĳ�ø���������ٽ� �ȸ��� �� �������� �������.


ALTER SEQUENCE dept_deptid_seq
INCREMENT BY 20
MAXVALUE 9999;

DROP SEQUENCE dept_deptid_seq;