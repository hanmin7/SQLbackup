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
--�̰� ���x

SELECT employee_id, last_name, job_id, employees.department_id, department_name
FROM employees, departments
WHERE employees.department_id(+) = departments.department_id
OR employees.department_id = departments.department_id(+);
--�̰͵� x
--(+)�ѹ��忡 �ѹ���.



SELECT employee_id, last_name, job_id, employees.department_id, department_name
FROM employees, departments
WHERE employees.department_id = departments.department_id(+)
UNION
SELECT employee_id, last_name, job_id, employees.department_id, department_name
FROM employees, departments
WHERE employees.department_id(+) = departments.department_id;
--��ǥ�ؿ��� full �ƿ������� ���.


SELECT e.last_name, d.department_name, l.city
FROM employees e JOIN departments d
ON(e.department_id = d.department_id)
JOIN locations l
ON(d.location_id = l.location_id);

SELECT e.last_name, d.department_name, l.city
FROM employees e , departments d , locations l
WHERE e.department_id = d.department_id
AND d.location_id = l.location_id;


--�ƿ����ξֵ鸸 ���°�
--ǥ��Ǯ�ƿ������ο��� �̳ʾֵ� ���̳ʽ�
SELECT employee_id, last_name, job_id, employees.department_id, department_name
FROM employees FULL OUTER JOIN departments
On(employees.department_id = departments.department_id)
MINUS
SELECT employee_id, last_name, job_id, employees.department_id, department_name
FROM employees JOIN departments
On(employees.department_id = departments.department_id);



