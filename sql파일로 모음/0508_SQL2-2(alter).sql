--ALTER

CREATE TABLE emp3
AS
SELECT employee_id, last_name, salary, hire_date, department_id
FROM employees
WHERE department_id = 50;

SELECT * FROM emp3;
DESC emp3;

ALTER TABLE emp3
ADD(job_id VARCHAR2(15));
DESC emp3;
SELECT * FROM emp3;

ALTER TABLE emp3
MODIFY(last_name VARCHAR2(20));

ALTER TABLE emp3
MODIFY(job_id DEFAULT 'No Job');

UPDATE emp3
SET job_id = DEFAULT;
--기존행이 바로 디폴트값으로 안변해서 업데이트 해줌
--null과 같이 따옴표 없이 씀

ALTER TABLE emp3
DROP COLUMN hire_date;

--제약조건 낫널 복사해 옴



--------제약조건에서 alter
SELECT constraint_name, constraint_type, status
FROM user_constraints
WHERE table_name = 'EMP3';

DESC user_cons_columns;

SELECT * FROM user_cons_columns
WHERE table_name = 'EMP3';

--제약조건 어디에 뭐 있는지 보는 쿼리   -------------------------------
SELECT constraint_name, t.constraint_type, c.column_name, t.status
FROM user_constraints t JOIN user_cons_columns c
USING (constraint_name)
WHERE t.table_name = 'EMP3';
--------------------------------------------------------------------------
--제약조건타입 c는 낫널 p는 프라이머리키 u는 유니크



ALTER TABLE emp3
ADD primary key(employee_id);

ALTER TABLE emp3
DROP primary key;
--프라이머리키 하나밖에 없어서 이름없어도 프라이머리키로 지울 수 있음



--조건이름 지정
ALTER TABLE emp3
ADD CONSTRAINT emp3_empid_pk primary key(employee_id);

ALTER TABLE emp3
ADD unique(last_name);

ALTER TABLE emp3
DROP CONSTRAINT sys_c007053;
--유니크는 여러개가 가능하기에 유니크로 지울 수 없어서 그 이름으로 지정해서 지워야함


ALTER TABLE emp3
RENAME CONSTRAINT sys_c007054 TO emp3_name_uk;
--만약 이름 없는걸로 생성했을 때 이름수정하는 거 

--ALTER TABLE emp3
--RENAME CONSTRAINT sys_c007049 TO emp3_name_nn;

SELECT * FROM emp3;

ALTER TABLE emp3
ADD CONSTRAINT emp3_deptid_fk FOREIGN KEY(department_id)
REFERENCES departments(department_id);
--조회해 보면 타입 R로 나옴.

ALTER TABLE emp3
ADD CONSTRAINT emp3_sal_ck CHECK(salary BETWEEN 3000 AND 10000);
--check제약까지 만들었음.



SELECT constraint_name, t.constraint_type, c.column_name, t.status, t.search_condition
FROM user_constraints t JOIN user_cons_columns c
USING (constraint_name)
WHERE t.table_name = 'EMP3';
--더 상세하게 보여줌(search_condition  낫널이랑 체크 구분해줌)
--딕셔너리




--status 
UPDATE emp3
SET salary = 13000
WHERE employee_id  = 144;
--제약조건때문에 생성x

ALTER TABLE emp3
DISABLE CONSTRAINT emp3_sal_ck;
--체크 제약 잠시 꺼둠 상태 확인하면 disable로 나옴

UPDATE emp3
SET salary = 13000
WHERE employee_id  = 144;
COMMIT;
SELECT * FROM emp3;
--다시 실행하면 생성됨.

ALTER TABLE emp3
ENABLE CONSTRAINT emp3_sal_ck;
--다시 키려고해도 제약조건 위배하는거 없어야 할 수 있음
--다시 업뎃 후 해야함

UPDATE emp3
SET salary = 8000
WHERE employee_id  = 144;
COMMIT;
ALTER TABLE emp3
ENABLE CONSTRAINT emp3_sal_ck;

--빠른 일처리를 위해서 씀. (status enable, disable)
-- 많은 자료 처리하면 오류도 많이 나올 수 있음 그 때 그 예외 처리는 나중에...




--SELECT constraint_name, t.constraint_type, c.column_name, t.status, t.search_condition
--FROM user_constraints t JOIN user_cons_columns c
--USING (constraint_name)
--WHERE t.table_name = UPPER('&table_name')
--/
--스크립트 저장 만들기 ~~~
--메모장에 슬래시까지 해서 q_cons.sql 로 저장
--저장한거 불러와서 쓸 때 -> @c:\oraclexe\labs\q_cons.sq
--(저장위치랑 제목 써줘서 씀)
