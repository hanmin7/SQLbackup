--351p 제6절 계층형

SELECT * FROM emp;

SELECT empno, ename, mgr
FROM emp
START WITH empno = 7839
CONNECT BY PRIOR empno =mgr;
--탑다운방식  prior가 부모한테 붙음
--이전행의번호가 다음행의 mgr에 나타낸다는 뜻

SELECT empno, ename, mgr
FROM emp
START WITH empno = 7876
CONNECT BY empno = PRIOR mgr;
--바텀업
--prior를 어디에 붙이냐..

SELECT empno, ename, mgr
FROM emp
START WITH empno = 7566
CONNECT BY PRIOR empno =mgr;
--보고싶은 가지만 보는것도 가능

SELECT empno, ename, mgr, LEVEL
FROM emp
START WITH empno = 7839
CONNECT BY PRIOR empno =mgr;
--start에 적힌 번호를 기준으로 1시작.

SELECT empno, ename, mgr, LEVEL
FROM emp
START WITH empno = 7566
CONNECT BY PRIOR empno =mgr;
--level 고정적인값이 아님.

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

