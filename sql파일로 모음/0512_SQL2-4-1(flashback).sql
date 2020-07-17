SELECT * FROM employees
WHERE employee_id = 178;

UPDATE employees
SET salary = 9000
WHERE employee_id = 178;

COMMIT;


--flashback 쿼리로 방금꺼 다시 돌리기
SELECT salary FROM employees
AS OF TIMESTAMP (systimestamp - 5/(24*60))
WHERE employee_id = 178;
--5분전 값 보여줌

UPDATE employees
SET salary = 8400
WHERE employee_id = 178;
--그 값을 보고 다시 업뎃해야함 (수동임)
COMMIT;


UPDATE employees
SET salary = 9200
WHERE employee_id = 178;
COMMIT;

--flashback version 쿼리 : 그시간동안 바뀐이력 다보는 쿼리
SELECT versions_starttime, versions_endtime, versions_xid, salary
FROM employees
VERSIONS BETWEEN TIMESTAMP minvalue AND maxvalue
WHERE employee_id = 178;
--endtime이 널인게 지금 현재값
--xid는 트랜잭션 발생 할 때마다 주어지는 식별번호


--flashback transaction q 트랜잭션 쿼리
SELECT undo_sql FROM flashback_transaction_query
WHERE table_owner = 'HR'
AND table_name = 'EMPLOYEES'
AND xid = '02000A00B1010000';

update "HR"."EMPLOYEES" set "SALARY" = '9000' where ROWID = 'AAAE5oAAEAAAADPABO';
--위 트랜잭션쿼리에서 나온걸로 직접 실행.
--다시 바뀜.


SELECT versions_starttime, versions_endtime, versions_xid, salary
FROM employees
VERSIONS BETWEEN TIMESTAMP minvalue AND maxvalue
WHERE employee_id = 178;
--매번바뀐이력 저장주기 짧아서 몇분지나면 지워짐

COMMIT;