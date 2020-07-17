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
--인덱스 없음




--자동추적 권한 받고

SELECT * FROM bigemp
WHERE employee_id = 123456;
--자동추적 확인

CREATE INDEX bigemp_id_ix
ON bigemp(employee_id);
--인덱스 만들고

SELECT * FROM bigemp
WHERE employee_id = 234567;
--다시 자동추적확인 해보기
--아까 코스트값 900몇에서 17로 떨어짐




SELECT * FROM bigemp
WHERE salary = 3000;
--샐러리열은 인덱스 없어서 또 풀타임스캔함

CREATE INDEX bigemp_sal_ix
ON bigemp(salary);

SELECT * FROM bigemp
WHERE salary = 3000;
--중복데이터가 많아서 코스트값이 그렇게 많이 떨어지지않음


SELECT * FROM bigemp
WHERE salary*12 > 110000;
--함수로 해서 또 풀타임스캔함

DROP INDEX bigemp_sal_ix;

CREATE INDEX bigemp_annsal_ix
ON bigemp(salary*12);
-- 원래꺼 삭제하고 계산식으로 인덱스 만들었음

SELECT * FROM bigemp
WHERE salary*12 > 110000;


--자동추적으로 인덱스가 사용되는지 알 수 있음. -------------------
--추적으로 코스트 덜 먹는 걸로 가장 효과적인 쿼리문을 택할 수도 있고.
--인덱스 종류도 많음~~


DROP INDEX bigemp_annsal_ix;

--인덱스도 자리 차지함.
--get stated에서 storage에 유저스에 테이블과 별개로 저장됨.
--인덱스 지우면 사용 용량도 줄어들음
