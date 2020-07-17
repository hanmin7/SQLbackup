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
-- 테이블은 복사하되 데이터는 복사 안하고싶을 때 웨얼에서 이상한 조건 넣음ㅇㅇ

SELECT * FROm deptm3;

ALTER TABLE deptm3
MODIFY manager_id DEFAULT 1111;
--매니저아이디를 안적거나 디폴트라고 적거나 넘어가면 1111들어감

INSERT INTO deptm3
VALUES (100, '총무부', DEFAULT);

INSERT INTO deptm3
VALUES (200, '영업부', NULL);

INSERT INTO deptm3(department_id, department_name)
VALUES (300, '홍보부');

UPDATE deptm3
SET manager_id = DEFAULT
WHERE manager_id IS NULL;
--디폴트는 디폴트라는 값을 가짐. 디폴트라고 적거나 생략해버리면 디폴트값(기본값 아까 설정한 '1111'이 들어감)

@c:\oraclexe\labs\cre_minstab.sql
--멀티테이블 INSERT   -----------------------------------------------------------------------

INSERT  ALL
INTO sal_history VALUES(EMPID,HIREDATE,SAL)
INTO mgr_history VALUES(EMPID,MGR,SAL)
SELECT employee_id EMPID, hire_date HIREDATE, salary SAL, manager_id MGR 
FROM  employees
WHERE employee_id > 200;
--조건없는 INSERT절 

SELECT employee_id EMPID, hire_date HIREDATE, salary SAL, manager_id MGR 
FROM  employees
WHERE employee_id > 200;

SELECT * FROM sal_history;
SELECT * FROM mgr_history;

ROLLBACK;
--멀티테이블 인서트 DML이라 롤백가능.

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
--when절있음. 조건있는절 조건맞지않으면 아무데도 안들어감.

SELECT * FROM sal_history;
SELECT * FROM mgr_history;



--부서별 급여, 가장늦게입사일
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
--first 에 else절까지 있음 조건 맞지않는애들은 엘스절에 맞게 들어감.

SELECT * FROM special_sal;
SELECT * FROM hiredate_history_99;
SELECT * FROM hiredate_history_00; --special_sal에 들어가서 여기 아무것도 없음.
SELECT * FROM hiredate_history; --else절



--pivoting ----------------------------------------------------------------------------
SELECT * FROM sales_source_data;

INSERT INTO sales_source_data
VALUES(144, 6, 1120, null, 2400, 1750, 2120);

INSERT INTO sales_source_data
VALUES(178, 7, 1550, 2280, 1210, 2900, 2000);

INSERT INTO sales_source_data
VALUES(144, 6, 2230, 1700, 1330, 2200, 1000);

COMMIT;

--사원들의 주별로 영업실적합을 알아본다면? 그룹함수쓰는그런거....
--근데 실적을 요일별로 쪼개놔서 수행을 할 수 없음 (설계부터 잘못된 테이블)
--동일한 속성이 여러번 나타나지 않아야함.
--사번/주/요일/실적 이렇게 나와야 좋은 테이블.
--정규화가 덜된 테이블.(널값도 넣어버림. 바꾼테이블에서는 그냥 입력안할수잇음)

DESC sales_info;

ALTER TABLE sales_info
ADD sales_day CHAR(3);

SELECT * FROM sales_info;

--행하나하나 널값빼고 19번 반복할 수없으니 멀티테이블 이용

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


--merge  병합   -----------------------------------------------------------------
@c:\oraclexe\labs\cre_emp13.sql

SELECT * FROM emp13;

--한번스캔한걸로 처리 가능
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
-- 매칭해서 동일애들 e로 업뎃하고 맞지않은애들 새로 넣어라..

ROLLBACK;
--머지도 DML  커밋해야지 저장ㅇㅇ
COMMIT;

