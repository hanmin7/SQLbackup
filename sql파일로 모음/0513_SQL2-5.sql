SELECT systimestamp FROM dual;

SELECT current_timestamp FROM dual;
--디벨로퍼 실행하고 있는 나

ALTER SESSION SET time_zone= '-10:00';
--나의 위치를 옮김.

SELECT systimestamp FROM dual;
SELECT current_timestamp FROM dual;
--재접속하면 다시 원상태로 돌아옴.
-- (그 세션에서만 유지됨.)

SELECT current_date, current_timestamp, localtimestamp FROm dual;
--클라이언트의 시간... sysdate는 서버시간. current는 내 시간(클라이언트시간)


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
--3년5개월 90일 12시30분

COMMIT;
SELECT * FROM service;

DESC orders;
SELECT id, ord_d1 주문날짜, ADD_MONTHS(ord_d1, 41) 서비스종료일
FROM orders;
--예전에는 수기로 계산해서 (3년5개월 =41개월) 41개월 후를 적어줬는데


SELECT id, ord_d2 주문날짜, ord_d1+i1 서비스종료일, ord_d2+i2 제품등록만료일
FROM orders, service;
--인터벌쓰면 번거로움이 줄어들어서 좋음

SELECT employee_id, last_name, hire_date, hire_date+i1
FROM employees, service;

DESC service;
--우리는 아까 YEAR(3)이렇게 길이 지정안해줬음. 길이지정안해주면 디폴트값 YEAR(2)로 들어감.




--추가 함수들~~~~~~~~~~~~~~~~~~~~~~~~~~~

--사원들 입사한 연도를 보고싶다.
SELECT employee_id, last_name, TO_CHAR(hire_date, 'yyyy')
FROM employees;
--원래 쓰던거는 문자열로 뽑아옴

SELECT employee_id, last_name, EXTRACT (year FROM hire_date)
FROM employees;
--EXTRACT : 날짜그대로를 뽑아옴


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
--날짜시간 타임존이름 다 같이 나옴
--많이 쓰지않을 때 한번씩 볼 때 이렇게 쿼리할 때 붙여서 볼 수 있게.  

SELECT employee_id, last_name, FROM_TZ(hire_date, '+9:00')
FROM emp;
