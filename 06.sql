--join
select department_id, department_name, location_id
from departments;

select location_id, city
from locations;

-- equi join ��������
select department_id, department_name, location_id, city
from departments natural join locations;
-- ���� ���̺��� ���ڵ带 Ȯ�� �� ���� Į���� ã�� �� ���ν�Ų��.
-- �ʵ� ������ �ٸ��� ������ Ÿ���� ���Ƶ� ������, �����ϸ� ���� ����.

select department_id, department_name, location_id, city
from departments natural join locations
where department_id in (20, 50);

select employee_id, last_name, department_id, location_id
from employees join departments
using (department_id);

select employee_id, last_name, department_id, location_id
from employees natural join departments;

-- ����] ������ ������ 1���� �̸��� ��ȸ�϶�.
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
--using Į������ ���� ���λ縦 ������ ���Ѵ�.

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
--���λ縦 �Ⱥ��̴°� usingĮ���̱� ������ �Ŵ������̵� ����

select e.employee_id, e.last_name, e.department_id,
    d.department_id, d.location_id
from employees e join departments d
on (e.department_id = d.department_id);

select employee_id, city, department_name
from employees e join departments d
on e.department_id = d.department_id
join locations l
on d.location_id = l.location_id;

-- ����] �� ������, using ���� refactoring �϶�.
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
--where�� and�� �����丵 ��. ���ǹ�.

-- ����] Toronto�� ��ġ�� �μ����� ���ϴ� �������
--   �̸�, ����, �μ���ȣ, �μ����� ��ȸ�϶�.
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

-- ����] ���� �μ����� ���ϴ� ������� �̸�, �μ���ȣ, ������ �̸��� ��ȸ�϶�.
select e.department_id, e.last_name employee, c.last_name colleague
from employees e join employees c
on e.department_id = c.department_id
and e.employee_id <> c.employee_id
order by 1, 2, 3;

--����] Davies ���� �Ŀ� �Ի��� ������� �̸�, �Ի����� ��ȸ�϶�.
select c.last_name, c.hire_date
from employees e join employees c
on e.hire_date < c.hire_date
where e.last_name = 'Davies';