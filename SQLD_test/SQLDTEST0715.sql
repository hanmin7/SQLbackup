--0715 SQL

--���߷�����
SELECT empno, ename, job, deptno, dname
FROM emp NATURAL JOIN dept;

SELECT * FROM dept;
--���� ���߷��� �̳����� 40�� �ƿ��͹߻�

SELECT empno, ename, job, deptno, dname
FROM emp JOIN dept
USING(deptno);
--�̰Ͷ��� �̳�����. ���質Ÿ����x

SELECT empno, ename, job, dept.deptno, dname
FROM emp JOIN dept
ON (emp.deptno = dept.deptno);
--������ �̳�����.  ���谡 �����Ÿ� ã��. equi ����

SELECT empno, ename, job, dept.deptno, dname
FROM emp, dept
WHERE emp.deptno = dept.deptno;
--���Ĵٵ�����. ������x �̰� ���� 3���߿� �ϳ��� �ٲٴ¹��� �˾Ƶ־�...

SELECT empno, ename, job, deptno, dname
FROM emp JOIN dept
USING(deptno)
WHERE sal > 1000;
--ǥ�ؿ��� ������ where�߰���..

SELECT empno, ename, job, dept.deptno, dname
FROM emp, dept
WHERE emp.deptno = dept.deptno
AND sal > 1300;
--��ǥ���� �����߰��� AND��



SELECT empno, ename, job, dept.deptno, dname
FROM emp RIGHT OUTER JOIN dept
ON (emp.deptno = dept.deptno);
--ǥ���� �ƿ�������
--�����߰��� ǥ����.

SELECT empno, ename, job, dept.deptno, dname
FROM emp, dept
WHERE emp.deptno(+) = dept.deptno;
--��ǥ�ؿ��� ǥ����. �����߰��ϰڴٴ¶����� ���ʿ� (+) ����.

