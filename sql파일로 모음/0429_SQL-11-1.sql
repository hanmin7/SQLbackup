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
-- 테이블 복사 시 제약조건 중 낫널은 기본 복사ㅎ ㅐ옴. 딴건 x

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
VALUES(101, '전현무');
-- 널값은 허용

INSERT INTO member
VALUES(102, '김사랑', 500);
-- 거기 없는 값은 x 위에꺼 오류남. 500번이 없어서
--컬럼레벨로 낫널 넣을 수 있음

INSERT INTO member
VALUES(101, '김사랑', 90);
--기본키 오류
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
-- 뷰에서 정보 업뎃 가능 (단순뷰에서만)

SELECT * FROM employees;

CREATE OR REPLACE VIEW empvu80
AS
SELECT employee_id, last_name, salary, job_id
FROM employees
WHERE department_id = 80;



--employees, departments. locations 를 조인하여 사원번호, 사원이름(last_name), 부서이름, 부서가위치하는도시 이름 출력.
SELECT e.employee_id, e.last_name, d.department_name, l.city
FROM employees e JOIN departments d
ON (e.department_id = d.department_id)
JOIN locations l
ON (d.location_id = l.location_id);

--위를 emp_dept_loc_join_vu 라는 이름으로 정의하시오
CREATE VIEW emp_dept_loc_join_vu
AS
SELECT e.employee_id, e.last_name, d.department_name, l.city
FROM employees e JOIN departments d
ON (e.department_id = d.department_id)
JOIN locations l
ON (d.location_id = l.location_id);