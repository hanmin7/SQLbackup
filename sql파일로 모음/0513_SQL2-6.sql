--SQL2 6�� ��������
SELECT *
FROM employees
WHERE salary > (SELECT salary FROM employees
                    WHERE last_name = 'Abel');
--���� �ϴ� ��������
@c:\oraclexe\labs\cre_empl.sql



SELECT employee_id, manager_id, department_id
FROM empl_demo
WHERE first_name = 'John';
--���̶�� ��� 3������
--110������ �Ŵ�����108, �μ�100 ������ ���� �� ���;���

SELECT employee_id, manager_id, department_id
FROM empl_demo
WHERE (manager_id, department_id) IN
                         (SELECT manager_id, department_id
                         FROM empl_demo
                         WHERE first_name = 'John')
AND first_name <> 'John';
--�ڱ��ڽ��������ϰ� ������.
--108���� 100/ 123��50/ 100��80 �̷��� ������ �´°����� ����
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
--������ ���缭 �������ʰ� �Ŵ�����ȣ ���� ã�� �μ���ȣ ���� ã�Ƽ� �� ������ ��� ����� ���� �� ���͹���.
--in�� �켱������ and���� ������ ���������. �ٵ� in�� or�� �ǹ̶����� �� ����ã�Ƽ� and�� �ع����ϱ� ������� ���� ����
--�̷����ϸ� �ȵȴ�~~~
--nonpairwise




--6-12p correlated ��ȣ���� ��������    ~~~~~~~~~~~~~~~~~~~~~~~~~~
SELECT last_name, salary, department_id
FROM employees o
WHERE salary > (SELECT AVG(salary) FROM employees i
                    WHERE i.department_id = o.department_id);
                    
SELECT last_name, salary, department_id
FROM employees;
--����� �ٹ��ϴ� �ڱ�ҼӺμ� ��ձ޿����� �޿��� ���� �޴� ��� ����
--������ ���������� �Ź� ������. ���������


SELECT last_name, salary, department_id
FROM employees
WHERE salary > ANY (SELECT AVG(salary) FROM employees
                           GROUP BY department_id);
--�̰Ŷ��� �ٸ�����!!



--Q.�������� �ѹ��� �����ؼ� ����� �ٹ��ϴ� �ڱ�ҼӺμ� ��ձ޿����� �޿��� ���� �޴� ��� ã��
--   �Ʊ� ��ȣ���� ������������ �ٸ��� �� �� �ִ� ����� ã�ƺ���.

SELECT a.employee_id, a.last_name, a.salary, a.department_id, b.avgsal
FROM employees a JOIN (SELECT department_id, AVG(salary) avgsal FROM employees
                                GROUP BY department_id) b
ON (a.department_id = b.department_id)
WHERE a.salary > b.avgsal;
--�ζ���???? �ζ��κ� ?? ��������????




--EXISTS    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~
SELECT employee_id, last_name, job_id, department_id
FROM employees o
WHERE EXISTS (SELECT 'X' FROM employees
                    WHERE manager_id = o.employee_id);
                    
SELECT department_id, department_name
FROM departments d
WHERE NOT EXISTS (SELECT 'X' FROM employees
                    WHERE department_id = d.department_id);
                    




--��ȣ���� ������Ʈ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

CREATE TABLE emp6
AS
SELECT employee_id, last_name, department_id
FROM employees;

ALTER table emp6
ADD position VARCHAR2(10);

SELECT * FROM emp6;


--�����ǿ� �׻���� �ش��ϴ� jobid�ִ°�
UPDATE emp6
SET position = (SELECT job_id FROM employees
                    WHERE employee_id = emp6.employee_id);
                    
                    




--with clause   ~~~~~~~~~~~~~~~~~~~~~~~~~~
--�ζ��κ� ���. 
--������� �����ϴ� ���� �� �� ����.
-- ������ �������� �� �� ��. 


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




-- 7�� �غ�~~~
@c:\oraclexe\labs\regexp_tab.sql

SELECT * FROM t1;