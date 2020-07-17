--351p ��6�� ������

SELECT * FROM emp;

SELECT empno, ename, mgr
FROM emp
START WITH empno = 7839
CONNECT BY PRIOR empno =mgr;
--ž�ٿ���  prior�� �θ����� ����
--�������ǹ�ȣ�� �������� mgr�� ��Ÿ���ٴ� ��

SELECT empno, ename, mgr
FROM emp
START WITH empno = 7876
CONNECT BY empno = PRIOR mgr;
--���Ҿ�
--prior�� ��� ���̳�..

SELECT empno, ename, mgr
FROM emp
START WITH empno = 7566
CONNECT BY PRIOR empno =mgr;
--������� ������ ���°͵� ����

SELECT empno, ename, mgr, LEVEL
FROM emp
START WITH empno = 7839
CONNECT BY PRIOR empno =mgr;
--start�� ���� ��ȣ�� �������� 1����.

SELECT empno, ename, mgr, LEVEL
FROM emp
START WITH empno = 7566
CONNECT BY PRIOR empno =mgr;
--level �������ΰ��� �ƴ�.

SELECT RPAD(ename, 15, '*'), LPAD(sal,7,'*')
FROM emp;

SELECT LPAD(ename, (4*level-2)+2,'-')
FROM emp
START WITH empno = 7839
CONNECT BY PRIOR empno =mgr;



SELECT empno, ename, mgr, LEVEL, SYS_CONNECT_BY_PATH(ename,'/') AS path
FROM emp
START WITH empno = 7839
CONNECT BY PRIOR empno =mgr;

