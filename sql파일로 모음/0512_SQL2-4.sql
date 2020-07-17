SELECT l.location_id, l.city, l.country_id
FROM locations l
JOIN countries c
ON(l.country_id = c.country_id)
JOIN regions
USING(region_id)
WHERE region_name = 'Europe';

SELECT department_name, city
FROM departments
NATURAL JOIN (SELECT l.location_id, l.city, l.country_id
                    FROM locations l
                    JOIN countries c
                    ON(l.country_id = c.country_id)
                    JOIN regions
                    USING(region_id)
                    WHERE region_name = 'Europe');                    

INSERT INTO (SELECT l.location_id, l.city, l.country_id
                    FROM locations l
                    JOIN countries c
                    ON(l.country_id = c.country_id)
                    JOIN regions
                    USING(region_id)
                    WHERE region_name = 'Europe')
VALUES (3300, 'Cardiff', 'UK');

CREATE TABLE deptm3
AS
SELECT department_id, department_name, manager_id
FROM departments
WHERE 1=2;
-- ���̺��� �����ϵ� �����ʹ� ���� ���ϰ���� �� ���󿡼� �̻��� ���� ��������

SELECT * FROm deptm3;

ALTER TABLE deptm3
MODIFY manager_id DEFAULT 1111;
--�Ŵ������̵� �����ų� ����Ʈ��� ���ų� �Ѿ�� 1111��

INSERT INTO deptm3
VALUES (100, '�ѹ���', DEFAULT);

INSERT INTO deptm3
VALUES (200, '������', NULL);

INSERT INTO deptm3(department_id, department_name)
VALUES (300, 'ȫ����');

UPDATE deptm3
SET manager_id = DEFAULT
WHERE manager_id IS NULL;
--����Ʈ�� ����Ʈ��� ���� ����. ����Ʈ��� ���ų� �����ع����� ����Ʈ��(�⺻�� �Ʊ� ������ '1111'�� ��)

@c:\oraclexe\labs\cre_minstab.sql
--��Ƽ���̺� INSERT   -----------------------------------------------------------------------

INSERT  ALL
INTO sal_history VALUES(EMPID,HIREDATE,SAL)
INTO mgr_history VALUES(EMPID,MGR,SAL)
SELECT employee_id EMPID, hire_date HIREDATE, salary SAL, manager_id MGR 
FROM  employees
WHERE employee_id > 200;
--���Ǿ��� INSERT�� 

SELECT employee_id EMPID, hire_date HIREDATE, salary SAL, manager_id MGR 
FROM  employees
WHERE employee_id > 200;

SELECT * FROM sal_history;
SELECT * FROM mgr_history;

ROLLBACK;
--��Ƽ���̺� �μ�Ʈ DML�̶� �ѹ鰡��.

SELECT employee_id EMPID,hire_date HIREDATE,  
           salary SAL, manager_id MGR 
    FROM   employees
    WHERE  employee_id > 200;

INSERT ALL
WHEN SAL > 10000 THEN
INTO sal_history VALUES(EMPID,HIREDATE,SAL)
WHEN MGR > 200   THEN 
INTO mgr_history VALUES(EMPID,MGR,SAL)  
    SELECT employee_id EMPID,hire_date HIREDATE,  
           salary SAL, manager_id MGR 
    FROM   employees
    WHERE  employee_id > 200;
--when������. �����ִ��� ���Ǹ��������� �ƹ����� �ȵ�.

SELECT * FROM sal_history;
SELECT * FROM mgr_history;



--�μ��� �޿�, ����ʰ��Ի���
 SELECT department_id DEPTID, SUM(salary) SAL, MAX(hire_date) HIREDATE  
  FROM   employees
  GROUP BY department_id;


INSERT FIRST   
WHEN SAL  > 25000  THEN    
INTO special_sal VALUES(DEPTID, SAL) 
WHEN HIREDATE like ('%00%') THEN    
INTO hiredate_history_00 VALUES(DEPTID,HIREDATE)  
WHEN HIREDATE like ('%99%') THEN
INTO hiredate_history_99 VALUES(DEPTID, HIREDATE)
  ELSE  INTO hiredate_history VALUES(DEPTID, HIREDATE)
  SELECT department_id DEPTID, SUM(salary) SAL, MAX(hire_date) HIREDATE  
  FROM   employees
  GROUP BY department_id;
--first �� else������ ���� ���� �����ʴ¾ֵ��� �������� �°� ��.

SELECT * FROM special_sal;
SELECT * FROM hiredate_history_99;
SELECT * FROM hiredate_history_00; --special_sal�� ���� ���� �ƹ��͵� ����.
SELECT * FROM hiredate_history; --else��



--pivoting ----------------------------------------------------------------------------
SELECT * FROM sales_source_data;

INSERT INTO sales_source_data
VALUES(144, 6, 1120, null, 2400, 1750, 2120);

INSERT INTO sales_source_data
VALUES(178, 7, 1550, 2280, 1210, 2900, 2000);

INSERT INTO sales_source_data
VALUES(144, 6, 2230, 1700, 1330, 2200, 1000);

COMMIT;

--������� �ֺ��� ������������ �˾ƺ��ٸ�? �׷��Լ����±׷���....
--�ٵ� ������ ���Ϻ��� �ɰ����� ������ �� �� ���� (������� �߸��� ���̺�)
--������ �Ӽ��� ������ ��Ÿ���� �ʾƾ���.
--���/��/����/���� �̷��� ���;� ���� ���̺�.
--����ȭ�� ���� ���̺�.(�ΰ��� �־����. �ٲ����̺����� �׳� �Է¾��Ҽ�����)

DESC sales_info;

ALTER TABLE sales_info
ADD sales_day CHAR(3);

SELECT * FROM sales_info;

--���ϳ��ϳ� �ΰ����� 19�� �ݺ��� �������� ��Ƽ���̺� �̿�

INSERT ALL
INTO sales_info VALUES (employee_id,week_id,sales_MON, 'MON')  
INTO sales_info VALUES (employee_id,week_id,sales_TUE, 'TUE')
INTO sales_info VALUES (employee_id,week_id,sales_WED, 'WED')
INTO sales_info VALUES (employee_id,week_id,sales_THUR, 'THU')
INTO sales_info VALUES (employee_id,week_id, sales_FRI, 'FRI')
SELECT EMPLOYEE_ID, week_id, sales_MON, sales_TUE,
       sales_WED, sales_THUR,sales_FRI 
FROM sales_source_data;

SELECT * FROM sales_info;

DELETE FROM sales_info
WHERE sales IS NULL;

COMMIT;

SELECT employee_id, sales_day, AVG(sales)
FROM sales_info
GROUP BY employee_id, sales_day
ORDER BY 1,2;


--merge  ����   -----------------------------------------------------------------
@c:\oraclexe\labs\cre_emp13.sql

SELECT * FROM emp13;

--�ѹ���ĵ�Ѱɷ� ó�� ����
MERGE INTO emp13 c
     USING employees e
     ON (c.employee_id = e.employee_id)
   WHEN MATCHED THEN
     UPDATE SET
       c.last_name      = e.last_name,
       c.job_id         = e.job_id,
       c.salary         = e.salary,
       c.department_id  = e.department_id
   WHEN NOT MATCHED THEN
     INSERT VALUES(e.employee_id, e.last_name,e.job_id,
          e.salary, e.department_id);
-- ��Ī�ؼ� ���Ͼֵ� e�� �����ϰ� ���������ֵ� ���� �־��..

ROLLBACK;
--������ DML  Ŀ���ؾ��� ���夷��
COMMIT;

