--0511 월2    2-28p

CREATE GLOBAL TEMPORARY TABLE emp_temp1
ON COMMIT DELETE ROWS
AS
SELECT employee_id, salary, department_id
FROM employees;

CREATE GLOBAL TEMPORARY TABLE emp_temp2
ON COMMIT PRESERVE ROWS -- 로그아웃하면 안나옴
AS
SELECT employee_id, salary, department_id
FROM employees;

SELECT * FROM emp_temp1; 
SELECT * FROM emp_temp2; --preserve는  내용도 끌고옴

--근데 접속해제하고 다시 들어가서 조회해보면 테이블 안나옴.

INSERT INTO emp_temp1
SELECT employee_id, salary, department_id
FROM employees
WHERE department_id = 90;

INSERT INTO emp_temp2
SELECT employee_id, salary, department_id
FROM employees
WHERE salary > 9000;

COMMIT;

SELECT * FROM emp_temp1; --on commit delete라서 커밋하면 내용 사라짐
SELECT * FROM emp_temp2; --


UPDATE emp_temp2
SET salary = salary*1.1;

TRUNCATE TABLE emp_temp2;
DROP TABLE emp_temp2;
DROP TABLE emp_temp1;

SELECT * FROM session_privs;