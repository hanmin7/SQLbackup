SELECT * FROM employees
WHERE employee_id = 178;

UPDATE employees
SET salary = 9000
WHERE employee_id = 178;

COMMIT;


--flashback ������ ��ݲ� �ٽ� ������
SELECT salary FROM employees
AS OF TIMESTAMP (systimestamp - 5/(24*60))
WHERE employee_id = 178;
--5���� �� ������

UPDATE employees
SET salary = 8400
WHERE employee_id = 178;
--�� ���� ���� �ٽ� �����ؾ��� (������)
COMMIT;


UPDATE employees
SET salary = 9200
WHERE employee_id = 178;
COMMIT;

--flashback version ���� : �׽ð����� �ٲ��̷� �ٺ��� ����
SELECT versions_starttime, versions_endtime, versions_xid, salary
FROM employees
VERSIONS BETWEEN TIMESTAMP minvalue AND maxvalue
WHERE employee_id = 178;
--endtime�� ���ΰ� ���� ���簪
--xid�� Ʈ����� �߻� �� ������ �־����� �ĺ���ȣ


--flashback transaction q Ʈ����� ����
SELECT undo_sql FROM flashback_transaction_query
WHERE table_owner = 'HR'
AND table_name = 'EMPLOYEES'
AND xid = '02000A00B1010000';

update "HR"."EMPLOYEES" set "SALARY" = '9000' where ROWID = 'AAAE5oAAEAAAADPABO';
--�� Ʈ������������� ���°ɷ� ���� ����.
--�ٽ� �ٲ�.


SELECT versions_starttime, versions_endtime, versions_xid, salary
FROM employees
VERSIONS BETWEEN TIMESTAMP minvalue AND maxvalue
WHERE employee_id = 178;
--�Ź��ٲ��̷� �����ֱ� ª�Ƽ� ��������� ������

COMMIT;