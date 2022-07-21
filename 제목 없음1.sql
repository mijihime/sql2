select salary, salary * 12 annual_salary
from employees;

select last_name || ' ' || job_id as "Emp and Title"
from employees;

select last_name, salary
from employees
where salary >= 12000;

select last_name, hire_date
from employees
where hire_date like '2005%';

select last_name
from employees
where last_name like '_o%';

select last_name, salary, department_id
from employees
where salary between 5000 and 12000 
        and department_id in(20, 50);
        
select last_name, job_id, salary
from employees
where job_id like 'SA%' and salary not in(2500, 3500);

select initcap(last_name), length(last_name)
from employees
where last_name like 'J%' or
        last_name like 'A%' or
        last_name like 'M%';
        
select last_name, last_day(hire_date)
from employees
where sysdate - hire_date >= 20*365;

select last_name, to_char(hire_date, 'YYYY.MM.DD') hire_date, 
       to_char(next_day(add_months(hire_date, 3), 'monday'), 'YYYY.MM.DD') pe_date
from employees;

select last_name, job_id, salary * 12 annual_salary
from employees;

select last_name, hire_date, to_char(hire_date, 'day') days
from employees
order by    case to_char(hire_date, 'fmday') 
   when 'monday' then 1 
   when 'tuesday' then 2
   when  'wendensday' then 3
   when  'thursday' then 4
   when  'friday' then 5
   when   'saturday' then 6
   else 7
   end;
   
select last_name, hire_date, 
   case when(to_char(hire_date, 'yyyy') >= 2005) then 100
            else 10
            end point
from employees;

select avg(nvl(commission_pct, 0))
from employees;

select count(manager_id)
from employees;

select manager_id, min(salary)
from employees
where manager_id is not null
group by manager_id
having min(salary) > 6000;

select job_id, sum(decode(department_id, 20, salary)) "20",
                sum(decode(department_id, 50, salary)) "50",
                sum(decode(department_id, 80, salary)) "80"
from employees
group by job_id;

select last_name, job_id, department_id, department_name, city
from employees join departments
using(department_id)
join locations
using(location_id)
where city = 'Toronto';

select e.last_name e_name, e.hire_date e_hiredate, m.last_name m_name, m.hire_date m_hiredate
from employees e join employees m
on e.manager_id = m.employee_id
where e.hire_date < m.hire_date;

select last_name, hire_date
from employees 
where department_id =any (select department_id
                        from employees
                        where last_name = 'Abel')
and last_name <> 'Abel'
order by 1;