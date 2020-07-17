CREATE TABLE orders
(oid NUMBER(4),
cid NUMBER(4));

SELECT * FROM session_privs;


SELECT * FROM hr.employees;
--다른유저의 자료 검색 시 소유자명 적어줘야함
--hr의 권한도 받아야함.

UPDATE hr.employees
SET salary = salary*1.1;

ROLLBACK;

SELECT * FROM hr.emp_list_5080_vu;

CREATE SYNONYM emp FOR hr.emp_list_5080_vu;
--시스템(커멘드창에서) 시노님 권한 받은 후 동의어 생성 

SELECT * FROM emp;
--별칭으로 써서 누구의 뭔테이블인지 알 수없음. 보안상 좋음


SELECT * FROM hr.dept_list_vu;

SELECT * FROM d;

SELECT * FROM session_privs;



--------------------------------------------------------------
SELECT * FROM session_privs;
SELECT * FROM hr.locations;

--role로 권한 받으면 재접속 후 가능.

--------------------------------------------------------------
SELECT * FROM session_privs;
SELECT * FROM tab;
SELECT * FROM emp;

--tab 동의어 보는거
--hr에서 hr.emp_list_5080_vu 뷰 권한 뻇으면 안보임.
--hr에서 뷰 drop해도 안보임.
--근데 om에서 만든 '동의어'는 계속 남아있음.

