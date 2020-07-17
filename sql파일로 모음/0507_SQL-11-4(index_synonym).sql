SELECT * FROM employees
WHERE last_name = 'King';

CREATE INDEX emp_lastname_idx
ON employees(last_name);

SELECT * FROM employees
WHERE last_name = 'King';

SELECT index_name
FROM user_indexes
WHERE table_name = 'EMPLOYEES';
--딕셔너리정보 인덱스 뭐있는지

CREATE TABLE emp10
(empid NUMBER(4) PRIMARY KEY,
ename VARCHAR2(20) CONSTRAINT emp10_ename_uk UNIQUE,
email VARCHAR2(50));

SELECT index_name
FROM user_indexes
WHERE table_name = 'EMP10';
--제약조건이름으로 인덱스 만들어졌음

CREATE INDEX emp10_email_ix ON emp10(email);

DROP INDEX emp10_email_ix;
--내가 만든건 드랍가능
DROP INDEX emp10_ename_uk;
--제약조건으로 자동만들어진 인덱스는 삭제x



---------synonyms 동의어(별칭)
SELECT view_name FROM user_views;
--뷰 뭐뭐있는지 보는거

SELECT * FROM emp_dept_loc_join_vu;

CREATE SYNONYM list FOR emp_dept_loc_join_vu;

SELECT * FROM list;

DROP SYNONYM list;

--emp_dept_loc_join_vu이렇게 이름 긴 애를 list라고 별칭 붙여줌
