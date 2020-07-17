--0715 SQL

--내추럴조인
SELECT empno, ename, job, deptno, dname
FROM emp NATURAL JOIN dept;

SELECT * FROM dept;
--위의 내추럴은 이너조인 40번 아우터발생

SELECT empno, ename, job, deptno, dname
FROM emp JOIN dept
USING(deptno);
--이것또한 이너조인. 관계나타내지x

SELECT empno, ename, job, dept.deptno, dname
FROM emp JOIN dept
ON (emp.deptno = dept.deptno);
--여전히 이너조인.  관계가 같은거만 찾음. equi 조인

SELECT empno, ename, job, dept.deptno, dname
FROM emp, dept
WHERE emp.deptno = dept.deptno;
--논스탠다드조인. 권장은x 이걸 위의 3개중에 하나로 바꾸는법은 알아둬야...

SELECT empno, ename, job, deptno, dname
FROM emp JOIN dept
USING(deptno)
WHERE sal > 1000;
--표준에서 조건은 where추가로..

SELECT empno, ename, job, dept.deptno, dname
FROM emp, dept
WHERE emp.deptno = dept.deptno
AND sal > 1300;
--비표준은 조건추가는 AND로



SELECT empno, ename, job, dept.deptno, dname
FROM emp RIGHT OUTER JOIN dept
ON (emp.deptno = dept.deptno);
--표준의 아우터조인
--빈줄추가로 표현됨.

SELECT empno, ename, job, dept.deptno, dname
FROM emp, dept
WHERE emp.deptno(+) = dept.deptno;
--비표준에서 표현법. 빈줄추가하겠다는뜻으로 그쪽에 (+) 써줌.

