CREATE TABLE empxt (empno       NUMBER(4),
                        ename       VARCHAR2(10),
                         job         VARCHAR2(9),
                         mgr         NUMBER(4),
                         hiredate    DATE,
                         sal         NUMBER(7,2),
                         comm        NUMBER(7,2),
                         deptno      NUMBER(2)
                        )
          ORGANIZATION EXTERNAL
           (
            TYPE ORACLE_LOADER
            DEFAULT DIRECTORY dir_1
            ACCESS PARAMETERS
            (
              records delimited by newline
              badfile dir_1:'empxt.bad'
              logfile dir_1:'empxt.log'
              fields terminated by ','
              missing field values are null
              ( empno, ename, job, mgr,
               hiredate char date_format date mask "dd-mon-yy",
                sal, comm, deptno
              )
            )
            LOCATION ('emp.dat')
          );
          
DESC empxt;
SELECT * FROM empxt;
--외부파일끌고온거 업뎃x (DML 적용x) 절대경로의 원래 텍스트파일에서 수정가능.


create table empxt2
      Organization external
     (type oracle_datapump
      Default directory dir_1
      Location('emp2.dat'))
      As
      Select * from employees
      WHERE hire_date < '99/01/01';
      
SELECT * FROM empxt2;