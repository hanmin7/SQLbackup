SELECT systimestamp FROM dual;

SELECT current_timestamp FROM dual;
--�𺧷��� �����ϰ� �ִ� ��

ALTER SESSION SET time_zone= '-10:00';
--���� ��ġ�� �ű�.

SELECT systimestamp FROM dual;
SELECT current_timestamp FROM dual;
--�������ϸ� �ٽ� �����·� ���ƿ�.
-- (�� ���ǿ����� ������.)

SELECT current_date, current_timestamp, localtimestamp FROm dual;
--Ŭ���̾�Ʈ�� �ð�... sysdate�� �����ð�. current�� �� �ð�(Ŭ���̾�Ʈ�ð�)


CREATE TABLE orders
(id NUMBER(4),
ord_d1 DATE,
ord_d2 TIMESTAMP,
ord_d3 TIMESTAMP WITH TIME ZONE,
ord_d4 TIMESTAMP WITH LOCAL TIME ZONE);

INSERT INTO orders
VALUES(1111, sysdate, sysdate, sysdate, sysdate);

COMMIT;
SELECT * FROM orders;



---------------------INTERVAL------------------------

CREATE TABLE service
(i1 INTERVAL year to month,
i2 INTERVAL day to second);

INSERT INTO service
VALUES(INTERVAL '3-5' year to month, INTERVAL '90 12:30:00' day to second);
--3��5���� 90�� 12��30��

COMMIT;
SELECT * FROM service;

DESC orders;
SELECT id, ord_d1 �ֹ���¥, ADD_MONTHS(ord_d1, 41) ����������
FROM orders;
--�������� ����� ����ؼ� (3��5���� =41����) 41���� �ĸ� ������µ�


SELECT id, ord_d2 �ֹ���¥, ord_d1+i1 ����������, ord_d2+i2 ��ǰ��ϸ�����
FROM orders, service;
--���͹����� ���ŷο��� �پ�� ����

SELECT employee_id, last_name, hire_date, hire_date+i1
FROM employees, service;

DESC service;
--�츮�� �Ʊ� YEAR(3)�̷��� ���� ������������. �������������ָ� ����Ʈ�� YEAR(2)�� ��.




--�߰� �Լ���~~~~~~~~~~~~~~~~~~~~~~~~~~~

--����� �Ի��� ������ ����ʹ�.
SELECT employee_id, last_name, TO_CHAR(hire_date, 'yyyy')
FROM employees;
--���� �����Ŵ� ���ڿ��� �̾ƿ�

SELECT employee_id, last_name, EXTRACT (year FROM hire_date)
FROM employees;
--EXTRACT : ��¥�״�θ� �̾ƿ�


SELECT TZ_OFFSET('Asia/Seoul') FROM dual;



DROP TABLE emp purge;

CREATE table emp
AS
SELECT employee_id, last_name, salary, hire_date
FROM employees;

SELECT * FROM emp;

ALTER TABLE emp
MODIFY hire_date timestamp;

SELECT * FROM emp;

SELECT employee_id, last_name, FROM_TZ(hire_date, 'Asia/Seoul')
FROM emp;
--��¥�ð� Ÿ�����̸� �� ���� ����
--���� �������� �� �ѹ��� �� �� �̷��� ������ �� �ٿ��� �� �� �ְ�.  

SELECT employee_id, last_name, FROM_TZ(hire_date, '+9:00')
FROM emp;
