--SQL2     user access


SELECT * FROM session_privs;
--권한 뭐뭐있는지 보는거

GRANT select ON hr.employees TO om;
--om에게 hr의 employees 테이블 볼 수있게 권한 줌

GRANT update ON hr.employees TO om;

REVOKE select ON hr.employees FROM om;
REVOKE update ON hr.employees FROM om;
--줬던 권한 뺏기


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

--그냥 시노님이랑 퍼블릭시노님 권한 다름. 
--아직 hr에 퍼블릭시노님없어서 시스템관리자가 퍼블릭시노님 권한 받아야함.

CREATE PUBLIC SYNONYM d FOR hr.dept_list_vu;
--누구나 d로 저 테이블 볼 수 있음. 각 유저들이 시노님 만드는거, 중복방지

--dual도 공용동의어였음



--뷰 권한 뺏았을 때 om에서 시노님은 있으나 내용은 x
REVOKE select on hr.emp_list_5080_vu FROM om;

GRANT select on hr.emp_list_5080_vu TO om;

DROP VIEW emp_list_5080_vu;



SELECT * FROM session_privs;