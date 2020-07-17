CREATE TABLE bigemp
AS
SELECT * FROM employees;

INSERT INTO bigemp
SELECT * FROM bigemp;

COMMIT;

CREATE SEQUENCE emp_id_seq
START WITH 1001
INCREMENT BY 1;

UPDATE bigemp
SET employee_id = emp_id_seq.nextval;
COMMIT;

SELECT MIN(employee_id), MAX(employee_id)
FROM bigemp;

SELECT index_name FROM user_indexes
WHERE table_name = 'BIGEMP';
--�ε��� ����




--�ڵ����� ���� �ް�

SELECT * FROM bigemp
WHERE employee_id = 123456;
--�ڵ����� Ȯ��

CREATE INDEX bigemp_id_ix
ON bigemp(employee_id);
--�ε��� �����

SELECT * FROM bigemp
WHERE employee_id = 234567;
--�ٽ� �ڵ�����Ȯ�� �غ���
--�Ʊ� �ڽ�Ʈ�� 900��� 17�� ������




SELECT * FROM bigemp
WHERE salary = 3000;
--���������� �ε��� ��� �� ǮŸ�ӽ�ĵ��

CREATE INDEX bigemp_sal_ix
ON bigemp(salary);

SELECT * FROM bigemp
WHERE salary = 3000;
--�ߺ������Ͱ� ���Ƽ� �ڽ�Ʈ���� �׷��� ���� ������������


SELECT * FROM bigemp
WHERE salary*12 > 110000;
--�Լ��� �ؼ� �� ǮŸ�ӽ�ĵ��

DROP INDEX bigemp_sal_ix;

CREATE INDEX bigemp_annsal_ix
ON bigemp(salary*12);
-- ������ �����ϰ� �������� �ε��� �������

SELECT * FROM bigemp
WHERE salary*12 > 110000;


--�ڵ��������� �ε����� ���Ǵ��� �� �� ����. -------------------
--�������� �ڽ�Ʈ �� �Դ� �ɷ� ���� ȿ������ �������� ���� ���� �ְ�.
--�ε��� ������ ����~~


DROP INDEX bigemp_annsal_ix;

--�ε����� �ڸ� ������.
--get stated���� storage�� �������� ���̺�� ������ �����.
--�ε��� ����� ��� �뷮�� �پ����
