--SQL2 6강 서브쿼리
SELECT *
FROM employees
WHERE salary > (SELECT salary FROM employees
                    WHERE last_name = 'Abel');
--원래 하던 서브쿼리
@c:\oraclexe\labs\cre_empl.sql



SELECT employee_id, manager_id, department_id
FROM empl_demo
WHERE first_name = 'John';
--존이라는 사람 3명있음
--110번존의 매니저는108, 부서100 쌍으로 같은 걸 나와야함

SELECT employee_id, manager_id, department_id
FROM empl_demo
WHERE (manager_id, department_id) IN
                         (SELECT manager_id, department_id
                         FROM empl_demo
                         WHERE first_name = 'John')
AND first_name <> 'John';
--자기자신은제외하고 봐야함.
--108번은 100/ 123은50/ 100은80 이렇게 쌍으로 맞는값들이 나옴
--pairwise

SELECT employee_id, manager_id, department_id
FROM empl_demo
WHERE manager_id IN
                         (SELECT manager_id
                         FROM empl_demo
                         WHERE first_name = 'John')
AND department_id IN
                         (SELECT department_id
                         FROM empl_demo
                         WHERE first_name = 'John')
AND first_name <> 'John';
--쌍으로 맞춰서 나오지않고 매니저번호 따로 찾고 부서번호 따로 찾아서 둘 조합의 모든 경우의 값이 다 나와버림.
--in의 우선순위가 and보다 우위라서 먼저실행됨. 근데 in이 or의 의미때문에 다 따로찾아서 and를 해버리니까 모든경우의 수가 나옴
--이렇게하면 안된다~~~
--nonpairwise




--6-12p correlated 상호관련 서브쿼리    ~~~~~~~~~~~~~~~~~~~~~~~~~~
SELECT last_name, salary, department_id
FROM employees o
WHERE salary > (SELECT AVG(salary) FROM employees i
                    WHERE i.department_id = o.department_id);
                    
SELECT last_name, salary, department_id
FROM employees;
--사원이 근무하는 자기소속부서 평균급여보다 급여를 많이 받는 사람 추출
--하지만 서브쿼리가 매번 실행함. 배드쿼리임


SELECT last_name, salary, department_id
FROM employees
WHERE salary > ANY (SELECT AVG(salary) FROM employees
                           GROUP BY department_id);
--이거랑은 다른거임!!



--Q.서브쿼리 한번만 실행해서 사원이 근무하는 자기소속부서 평균급여보다 급여를 많이 받는 사람 찾기
--   아까 상호관련 서브쿼리말고 다르게 할 수 있는 방법을 찾아보자.

SELECT a.employee_id, a.last_name, a.salary, a.department_id, b.avgsal
FROM employees a JOIN (SELECT department_id, AVG(salary) avgsal FROM employees
                                GROUP BY department_id) b
ON (a.department_id = b.department_id)
WHERE a.salary > b.avgsal;
--인라인???? 인라인뷰 ?? 언제했지????




--EXISTS    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~
SELECT employee_id, last_name, job_id, department_id
FROM employees o
WHERE EXISTS (SELECT 'X' FROM employees
                    WHERE manager_id = o.employee_id);
                    
SELECT department_id, department_name
FROM departments d
WHERE NOT EXISTS (SELECT 'X' FROM employees
                    WHERE department_id = d.department_id);
                    




--상호관련 업데이트 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

CREATE TABLE emp6
AS
SELECT employee_id, last_name, department_id
FROM employees;

ALTER table emp6
ADD position VARCHAR2(10);

SELECT * FROM emp6;


--포지션에 그사원이 해당하는 jobid넣는거
UPDATE emp6
SET position = (SELECT job_id FROM employees
                    WHERE employee_id = emp6.employee_id);
                    
                    




--with clause   ~~~~~~~~~~~~~~~~~~~~~~~~~~
--인라인뷰 대신. 
--쿼리블록 참조하는 쿼리 쓸 수 있음.
-- 복잡한 서브쿼리 쓸 때 편리. 


WITH
dept_costs AS ( SELECT d.department_name, sum(e.salary) AS dept_total
                    FROM employees e JOIN departments d
                    ON e.department_id = d.department_id
                    GROUP BY d.department_name),
avg_cost AS ( SELECT SUM(dept_total)/COUNT(*) AS dept_avg
                  FROM dept_costs)
SELECT *
FROM dept_costs
WHERE dept_total > (SELECT dept_avg  FROM avg_cost)
ORDER BY department_name;




-- 7강 준비~~~
@c:\oraclexe\labs\regexp_tab.sql

SELECT * FROM t1;