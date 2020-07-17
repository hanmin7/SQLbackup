SELECT employee_id, last_name, job_id, employees.department_id, department_name
FROM employees, departments
WHERE employees.department_id = departments.department_id;

SELECT employee_id, last_name, job_id, employees.department_id, department_name
FROM employees JOIN departments
On(employees.department_id = departments.department_id);

SELECT employee_id, last_name, job_id, employees.department_id, department_name
FROM employees LEFT OUTER JOIN departments
On(employees.department_id = departments.department_id);

SELECT employee_id, last_name, job_id, employees.department_id, department_name
FROM employees RIGHT OUTER JOIN departments
On(employees.department_id = departments.department_id);

SELECT employee_id, last_name, job_id, employees.department_id, department_name
FROM employees FULL OUTER JOIN departments
On(employees.department_id = departments.department_id);

SELECT employee_id, last_name, job_id, employees.department_id, department_name
FROM employees, departments
WHERE employees.department_id = departments.department_id(+);

SELECT employee_id, last_name, job_id, employees.department_id, department_name
FROM employees, departments
WHERE employees.department_id(+) = departments.department_id;

SELECT employee_id, last_name, job_id, employees.department_id, department_name
FROM employees, departments
WHERE employees.department_id(+) = departments.department_id(+);
--이건 허용x

SELECT employee_id, last_name, job_id, employees.department_id, department_name
FROM employees, departments
WHERE employees.department_id(+) = departments.department_id
OR employees.department_id = departments.department_id(+);
--이것도 x
--(+)한문장에 한번만.



SELECT employee_id, last_name, job_id, employees.department_id, department_name
FROM employees, departments
WHERE employees.department_id = departments.department_id(+)
UNION
SELECT employee_id, last_name, job_id, employees.department_id, department_name
FROM employees, departments
WHERE employees.department_id(+) = departments.department_id;
--비표준에서 full 아우터조인 방법.


SELECT e.last_name, d.department_name, l.city
FROM employees e JOIN departments d
ON(e.department_id = d.department_id)
JOIN locations l
ON(d.location_id = l.location_id);

SELECT e.last_name, d.department_name, l.city
FROM employees e , departments d , locations l
WHERE e.department_id = d.department_id
AND d.location_id = l.location_id;


--아우터인애들만 보는거
--표준풀아우터조인에서 이너애들 마이너스
SELECT employee_id, last_name, job_id, employees.department_id, department_name
FROM employees FULL OUTER JOIN departments
On(employees.department_id = departments.department_id)
MINUS
SELECT employee_id, last_name, job_id, employees.department_id, department_name
FROM employees JOIN departments
On(employees.department_id = departments.department_id);



