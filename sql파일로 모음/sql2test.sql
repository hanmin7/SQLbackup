create or REPLACE view dept_loc_vu
as
select department_id dept_id, department_name dept_name, location_id loc_id
from departments;

REVOKE select on hr.dept_loc_vu from dev;
drop view dept_loc_vu;

create or replace view dept_loc_list_vu
as
select d.department_id dept_id, d.department_name dept_name, l.city
from departments d join locations l
using (location_id);
GRANT select on hr.dept_loc_list_vu to public;

drop table emp2 purge;
drop table dept2 purge;

create table dept2 (id number(7), name varchar2(25));
desc dept2;

insert into dept2
select department_id, department_name
from departments;

create table emp2
(id number(7), last_name varchar2(25), first_name varchar2(25), dept_id number(7));
desc emp2;

alter table emp2
modify(last_name varchar2(50));
desc emp2;

select table_name from user_tables
where table_name in ('DEPT2', 'EMP2');

--Q1-6
create table employee2
as
select employee_id id, first_name, last_name, salary, department_id dept_id
from employees;

