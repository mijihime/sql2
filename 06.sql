--join
select department_id, department_name, location_id
from departments;

select location_id, city
from locations;

-- equi join 이퀴조인
select department_id, department_name, location_id, city
from departments natural join locations;
-- 양쪽 테이블의 레코드를 확인 후 공통 칼럼을 찾은 후 조인시킨다.
-- 필드 네임이 다르고 데이터 타입이 같아도 되지만, 웬만하면 같게 하자.

select department_id, department_name, location_id, city
from departments natural join locations
where department_id in (20, 50);

select employee_id, last_name, department_id, location_id
from employees join departments
using (department_id);

select employee_id, last_name, department_id, location_id
from employees natural join departments;

-- 과제] 위에서 누락된 1인의 이름을 조회하라.
select last_name, department_id, hire_date
from employees
where department_id is null;

select locations.city, departments.department_name
from locations join departments
using (location_id)
where location_id = 1400;

select l.city, d.department_name
from locations l join departments d
using (location_id)
where location_id = 1400;

select l.city, d.department_name
from locations l join departments d
using (location_id)
where d.location_id = 1400; --error

select l.city, d.department_name, d.location_id
from locations l join departments d
using (location_id)
where location_id = 1400; --error
--using 칼럼에는 어디든 접두사를 붙이지 못한다.

select e.last_name, d.department_name
from employees e join departments d
using(department_id)
where manager_id = 100; --error

select e.last_name, d.department_name
from employees e join departments d
using(department_id)
where d.manager_id = 100;

select e.last_name, d.department_name
from employees e join departments d
using(department_id)
where e.manager_id = 100;
--접두사를 안붙이는건 using칼럼이기 때문에 매니저아이디엔 가능

select e.employee_id, e.last_name, e.department_id,
    d.department_id, d.location_id
from employees e join departments d
on e.department_id = d.department_id;

select employee_id, city, department_name
from employees e join departments d
on e.department_id = d.department_id
join locations l
on d.location_id = l.location_id;

-- 과제] 위 문장을, using 으로 refactoring 하라.
select employee_id, city, department_name
from employees e join departments d
using (department_id)
join locations l
using(location_id);

select e.employee_id, e.last_name, e.department_id,
    d.department_id, d.location_id
from employees e join departments d
on e.department_id = d.department_id
where e.manager_id = 149;

select e.employee_id, e.last_name, e.department_id,
    d.department_id, d.location_id
from employees e join departments d
on e.department_id = d.department_id
and e.manager_id = 149;
--where을 and로 리팩토링 함. 조건문.

-- 과제] Toronto에 위치한 부서에서 일하는 사원들의
--   이름, 직업, 부서번호, 부서명을 조회하라.
select e.last_name, e.job_id, e.department_id, 
    department_name, l.city
from employees e join departments d
on d.department_id = e.department_id
join locations l
on d.location_id = l.location_id
where l.city = 'Toronto';

-- non-equi join
select e.last_name, e.salary, e.job_id
from employees e join jobs j
on e.salary between j.min_salary and j.max_salary
and j.job_id = 'IT_PROG';

--self join
select worker.last_name emp, manager.last_name mgr
from employees worker join employees manager
on worker.manager_id = manager.employee_id;

select worker.last_name emp, manager.last_name mgr
from employees worker join employees manager
on manager_id = employee_id; --error

select last_name emp, last_name mgr
from employees worker join employees manager
on manager_id = employee_id; -- error

-- 과제] 같은 부서에서 일하는 사원들의 이름, 부서번호, 동료의 이름을 조회하라.
select e.department_id, e.last_name employee, c.last_name colleague
from employees e join employees c
on e.department_id = c.department_id
and e.employee_id <> c.employee_id
order by 1, 2, 3;

--과제] Davies 보다 후에 입사한 사원들의 이름, 입사일을 조회하라.
select c.last_name, c.hire_date
from employees e join employees c
on e.hire_date < c.hire_date
where e.last_name = 'Davies';

-- 과제] 매니저보다 먼저 입사한 사원들의 이름, 입사일, 매니저명, 매니저 입사일을 조회하라.
select e.last_name e_name, e.hire_date e_hiredate, m.last_name m_name, m.hire_date m_hiredate
from employees e join employees m
on e.manager_id = m.employee_id
where e.hire_date < m.hire_date;
---------------------------------

select e.last_name, e.department_id, d.department_name
from employees e join departments d
on e.department_id = d.department_id;

--부서가 없는 직원 포함
select e.last_name, e.department_id, d.department_name
from employees e left outer join departments d
on e.department_id = d.department_id;

--직원이 없는 부서 포함
select e.last_name, e.department_id, d.department_name
from employees e right outer join departments d
on e.department_id = d.department_id;

--다포함
select e.last_name, e.department_id, d.department_name
from employees e full outer join departments d
on e.department_id = d.department_id;

-- 과제] 사원들의 이름, 사번, 매니저명, 매니저의 사번을 조회하라.
-- king 사장도 테이블에 포함한다.
select e.last_name e_name, e.employee_id e_id, m.last_name m_name, m.employee_id m_id
from employees e left outer join employees m
on e.manager_id = m.employee_id
order by 2; 

--------------------------------------
select d.department_id, d.department_name, d.location_id, l.city
from departments d, locations l
where d.location_id = l.location_id;

select d.department_id, d.department_name, d.location_id, l.city
from departments d, locations l
where d.location_id = l.location_id
and d.department_id in(20, 50);

select e.last_name, d.department_name, l.city
from employees e, departments d, locations l
where e.department_id = d.department_id
and d.location_id = l.location_id;

select e.last_name, e.salary, e.job_id
from employees e, jobs j
where e.salary between j.min_salary and j.max_salary
and j.job_id = 'IT_PROG';

select e.last_name, e.department_id, d.department_name
from employees e, departments d
where e.department_id(+) = d.department_id;
--right out join

select e.last_name, e.department_id, d.department_name
from employees e, departments d
where e.department_id = d.department_id(+);
-- left out join

select e.last_name, e.department_id, d.department_name
from employees e, departments d
where e.department_id(+) = d.department_id(+);
--error full out join은 없음

select worker.last_name || ' works for ' || manager.last_name
from employees worker, employees manager
where worker.manager_id = manager.employee_id;