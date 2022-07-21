-- DDL(Date Definition Language)
drop table hire_dates;

create table hire_dates(
id number(8),
hire_date date default sysdate);

select tname
from tab; 
-- date dictionary
-- 현 스키마가 가지고 있는 테이블 목록들을 조회 해볼 수 있다.

-- 과제] date table 후, 위 문장 실행결과에서 쓰레기는 제하고, 조회하라.
select tname
from tab
where tname not like 'BIN%';

insert into hire_dates values(1, to_date('2025/12/21'));
insert into hire_dates values(2, null);
insert into hire_dates(id) values(3);

commit;

select *
from hire_dates;
-------------------------------------------------------------
-- DCL(Data Control Language)
-- system connection으로 변경한다. system레이아웃에서 해야하는데 10레이아웃에 해서 커넥션 함
create user you identified by you;
grant connect, resource to you; 

-- you user를 만들었기 때문에 이제 you ueser로 만든다.
select tname
from tab;

--constraint 제약조건 문법
--다른 제약조건은 몰라도 primary key는 있어야함.
create table depts(
department_id number(3) constraint depts_deptid_pk primary key,
department_name varchar2(20));

desc user_constraints

select constraint_name, constraint_type, table_name
from user_constraints;
--이름 짖는 규칙으로 depts의 deptid의 primarykey

create table emps(
employee_id number(3) primary key,
emp_name varchar2(10) constraint emps_empname_nn not null,
email varchar2(20),
salary number(6) constraint emps_sal_ck check(salary > 1000),
department_id number(3),
constraint emps_email_uk unique(email),
constraint emps_dept_id_fk foreign key(department_id)
    references depts(department_id));
--사실 상 데이터타입 뒤 예외처리(검증)하는거임.
--constraint는 칼럼 뒤에 쓰기도 하고, 테이블 끝에 쓰기도 함. 두가지 문법
--primary key는 기본적으로 not null이자 unique를 포함함
--check는 서비스 관점임. 퍼시스턴스 관점에선 데이터타입만 중요해서
--froreign key~ references ~(복사)
--unique
--not null

select constraint_name, constraint_type, table_name
from user_constraints;

insert into depts values(100, 'Development');
insert into emps values(500, 'musk', 'musk@gmail.com', 5000, 100);
commit;

delete depts; 
--무결성을 위해서 에러가 뜸 삭제안시켜줌 (YOU.EMPS_DEPT_ID_FK) violated

insert into depts values(100, 'Marketing'); 
-- error, (YOU.DEPTS_DEPTID_PK) violated
insert into depts values(null, 'Marketing');
--cannot insert NULL into
insert into emps values(501, null, 'good@gmail.com', 6000, 100);
--cannot insert NULL into
insert into emps values(501, 'label', 'musk@gmail.com', 6000, 100);
--(YOU.EMPS_EMAIL_UK) violated
insert into emps values(501, 'abel', 'good@gmail.com', 6000, 200);
--parent key not found, 200번이 없어서.

--system user
grant all on hr.departments to you;

--you user
drop table emps cascade constraints;
--cascade 연달아 일어나게 하는 것

select constraint_name, constraint_type, table_name
from user_constraints;

create table employees(
employee_id number(6) constraint emp_empid_pk primary key,
first_name varchar2(20),
last_name varchar2(25) constraint emp_lastname_nn not null,
email varchar2(25) constraint emp_email_nn not null
                    constraint emp_email_pk unique,
phone_number varchar2(20),
hire_date date constraint emp_hiredate_nn not null,
job_id varchar2(10) constraint emp_jobid_nn not null,
salary number(8) constraint emp_salary_ck check(salary > 0),
commission_pct number(2, 2),
manager_id number(6) constraint emp_managerid_fk references employees(employee_id),
department_id number(4) constraint emp_dept_fk references hr.departments(department_id));
--다른 스키마에 있는 테이블도 reference 할 수 있지만 87행처럼 권한을 줘야함.
-----------------------------------

drop table gu cascade constraints;
drop table dong cascade constraints;
drop table dong2 cascade constraints;

create table gu(
gu_id number(3) primary key,
gu_name char(9) not null);

create table dong(
dong_id number(4) primary key,
dong_name varchar2(12) not null,
gu_id number(3) references gu(gu_id) on delete cascade);
--foreign은 생략 가능하지만 references는 생략 불가.

create table dong2(
dong_id number(4) primary key,
dong_name varchar2(12) not null,
gu_id number(3) references gu(gu_id) on delete set null);

insert into gu values(100, '강남구');
insert into gu values(200, '노원구');

insert into dong values(5000, '압구정동', null);
insert into dong values(5001, '삼성동', 100);
insert into dong values(5002, '역삼동', 100);
insert into dong values(6001, '상계동', 200);
insert into dong values(6002, '중계동', 200);

insert into dong2
select * from dong;

delete gu
where gu_id = 100;

select * from dong;
select * from dong2;

commit;
------------------------------
--disable fk
drop table a cascade constraints;
drop table b cascade constraints;

create table a(
aid number(1) constraint a_aid_pk primary key);

create table b(
bid number(2),
aid number(1),
constraint b_aid_fk foreign key(aid) references a(aid));

insert into a values(1);
insert into b values(31, 1);
insert into b values(32, 9); -- error

alter table b disable constraint b_aid_fk;
insert into b values(32, 9);

alter table b enable constraint b_aid_fk;
--error, parent keys not found
alter table b enable novalidate constraint b_aid_fk;

insert into b values(33, 8); 
--error parent key not found
-------------------
drop table sub_departments;

create table sub_departments as
    select department_id dept_id, department_name dept_name
    from hr.departments;

desc sub_departments

select * from sub_departments;
-----------------
--테이블 업데이트
drop table users cascade constraints;
--cascade를 붙여야 제약조건까지 삭제 됨.

create table users(
user_id number(3));
desc users

alter table users add(user_name varchar2(10));
desc users;
--추가
alter table users modify(user_name number(7));
desc users
--수정

alter table users drop column user_name;
desc users
--삭제
------------------
--테이블의 읽기전용
insert into users values(1);

alter table users read only;
insert into users values(2);
-- 읽기전용으로 바껴서 업뎃이 안됨

alter table users read write;
insert into users values(2);
--읽기쓰기 가능
select * from users;

commit;