-- view
--hr user
drop view empvu80;

create view empvu80 as
    select employee_id, last_name, department_id
    from employees
    where department_id = 80;
    
desc empvu80
--����Ʈ ���� Į���� ���� �����Ͱ� �ƴ�..?

select * from empvu80;

select * from (
    select employee_id, last_name, department_id
    from employees
    where department_id = 80);
--��� �������� �ʾҴٸ� �Ź� ���������� ����ϸ鼭 ��������.

create or replace view empvu80 as
    select employee_id, job_id
    from employees
    where department_id = 80;
--������ �߰����ְ�, ������ replace ���ִ� ���

desc empvu80;

-- ����] 50�� �μ������� ���, �̸�, �μ���ȣ�� ���� DEPT50 view�� ������.
--      view ������ EMPNO, EMPLOYEE, DEPTNO �̴�.
--      view �� ���ؼ� 50�� �μ� ������� �ٸ� �μ��� ��ġ���� �ʵ��� �Ѵ�.
create or replace view dept50(EMPNO, EMPLOYEE, DEPTNO) as
    select employee_id, last_name, department_id
    from employees
    where department_id = 50
    with check option constraint dept50_ck;

-- ����] DEPT50�� ������ ��ȸ�϶�.
desc dept50;

-- ����] DEPT50 view �� data�� ��ȸ�϶�.
select * from dept50;
-----------------
drop table teams;
drop table team50;

create table teams as
    select department_id team_id, department_name team_name
    from departments;
    
create view team50 as
    select *
    from teams
    where team_id = 50;
    
select * from team50;

select count(*) from teams;

insert into team50 
values(300, 'Marketing');

select count(*) from teams;

create or replace view team50 as
select *
from teams
where team_id = 50
with check option;

rollback;

insert into team50 values(50, 'IT Support');
select count(*) from teams;
insert into team50 values(301, 'IT Support');

create or replace view empvu10(employee_num, employee_name, job_title)as
    select employee_id, last_name, job_id
    from employees
    where department_id = 10
    with read only;
--read only�� �ϸ� ������ �Ǵµ� dml�� �ȵ�.
--read only�� ��õ��.
insert into empvu10 values(501, 'abel', 'Sales'); -- error
------------------------
drop sequence team_teamid_seq;

create sequence team_teamid_seq;
--1���� �����ϰ� ��. ��������

select team_teamid_seq.nextval from dual;
select team_teamid_seq.nextval from dual;
select team_teamid_seq.currval from dual;

insert into teams
values(team_teamid_seq.nextval, 'Marketing');

select * from teams
where team_id = 3;

drop sequence x_xid_seq;

create sequence x_xid_seq
    start with 10
    increment by 5
    maxvalue 20
    nocache
    nocycle;

select x_xid_seq.nextval from dual;

-- ����] DEPT ���̺��� DEPARTMENT_ID Į���� field value�� ����� sequence�� ������.
--      sequence�� 400 �̻�, 1000 ���Ϸ� �����Ѵ�. 10�� �����Ѵ�.
drop sequence dept_deptid_seq;
create sequence dept_deptid_seq
    start with 400
    increment by 10
    maxvalue 1000;

select dept_deptid_seq.currval from dual;

-- ����] �� sequence ��, DEPT ���̺���, Education �μ��� insert �϶�.
insert into dept(department_id, department_name)
values(dept_deptid_seq.nextval, 'Education');

select *
from dept;

commit;
------------------
drop index emp_lastname_idx;

create index emp_lastname_idx
on employees(last_name);

select last_name, rowid --������ȣ�� ������
from employees;

select last_name
from employees
where rowid = 'AAAEAbAAEAAAADNAAX'; 

select index_name, index_type, table_owner, table_name
from user_indexes;

-- ����] DEPT ���̺��� DEPARTMENT_NAME �� ���� index �� ������.
create index dept_department_name_idx
on dept(department_name);
-----------------------
drop synonym team;

create synonym team
for departments;

select * from team;

-- ����] EMPLOYEES ���̺� EMPS synonym�� ������
drop synonym team;
create synonym emps
for employees;

select * from emps;