--11강 뷰 뒤에 내용

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
--몇번까지 썼는지 알아보는거

SELECT * FROM employees;

ROLLBACK;


INSERT INTO employees
VALUES(dept_deptid_seq.nextval, 'Adam', 'Lee', 'ALEE', '123.456.7890', sysdate, 'SA_REP', 8000, null, 102, 50);
--220 으로 할당됨. 롤백했지만 번호는 돌아가지않음.
--시퀀스는 employees, departments 아무 테이블 다 쓸 수있음(공유가능) but 권장아님. 

--캐시만들어놨는데 껏다키면 캐시만들었던수다시 안만들어서 그 다음부터 만들어짐.


ALTER SEQUENCE dept_deptid_seq
INCREMENT BY 20
MAXVALUE 9999;

DROP SEQUENCE dept_deptid_seq;