-- 9강 ////////////////////////////////////// 
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
--부서번호70번 추가 
--insert into에 컬럼 안쓰면 그냥 원래 순서로 들어감.

SELECT *
FROM dept;
--튜플의 무순서

INSERT INTO dept(department_name, department_id)
VALUES('Parchasing', 30);
--매니저,로케id 생략으로 null값들어감

DESC dept;
--dept_name이 낫널임. 이름 꼭 넣어줘야함

INSERT INTO dept
VALUES(100,'Finance', null, null);
--임의로 null 넣어줌

COMMIT;

SELECT *
FROM emp;

UPDATE emp
SET salary = salary*1.1, department_id = 20;
--where안적어줘서 전체 다 21행이 다 바뀌어짐

ROLLBACK;

UPDATE emp
SET salary = salary*1.1, department_id = 20
WHERE employee_id = 200;
-- 이름으로 하면 중복생길 수 있으니 유니크한 칼럼으로 사용하기

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

--DML작업하다 DDL (테이블생성)하면 자동 커밋 되어버림
--트랜잭션의 고립성 

