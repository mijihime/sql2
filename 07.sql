-- subquery (메인쿼리, 서브쿼리) 
select last_name, salary
from employees
where salary > (select salary
                from employees
                where last_name = 'Abel');

-- 과제] Kochhar에게 보고하는 사원들의 이름, 직업, 부서번호를 조회하라.
select last_name, job_id, department_id
from employees
where manager_id = (select employee_id
                        from employees
                        where last_name = 'Kochhar');
                        
select last_name, job_id, salary
from employees
where job_id = (select job_id
                from employees
                where last_name = 'Ernst')
and salary >  (select salary
                from employees
                where last_name = 'Ernst');

-- 과제] IT 부서에서 일하는 사원들의 부서번호, 이름, 직업을 조회하라.
select department_id, last_name, job_id
from employees
where department_id in(select department_id
                        from departments
                        where department_name = 'IT')
order by 1;

select department_id, last_name, job_id
from employees
where job_id like 'IT%'
order by 1;
               
-- 과제] Abel과 같은 부서에게 일하는 동료들의 이름, 입사일을 조회하라.
select last_name, hire_date
from employees
where department_id = (select department_id
                      from employees
                      where last_name = 'Abel')
and last_name <> 'Abel'
order by 1;
-- 서브쿼리에 나오는 답이 1개이기 때문에 비교연산이 가능함.

select last_name, salary
from employees
where salary > (select salary
                from employees
                where last_name = 'King');
-- king이란 사람이 두 명이라 ERROR

select last_name, job_id, salary
from employees
where salary = (select min(salary)
                from employees);
                
select department_id, min(salary)
from employees
group by department_id
having min(salary) > (select min(salary)
                        from employees
                        where department_id = 50);
                        
-- 과제] 회사 평균 월급 이상 버는 사원들의 사번, 이름, 월급을 조회하라.
--      월급 내림차순 정렬한다.
select employee_id, last_name, salary
from employees
where salary >= (select avg(salary)
                        from employees)
order by salary desc;
---------------------
--서브쿼리에서 in, any, all이 아닌이상 리턴값은 하나~~여야 해요
--any = in

select employee_id, last_name
from employees
where salary = (select min(salary)
                from employees
                group by department_id); 
--error 서브쿼리가 하나 이상의 결과를 내기 때문에

select employee_id, last_name
from employees
where salary in (select min(salary)
                 from employees
                 group by department_id); 
-- 서브쿼리가 그룹펑션이라도 리턴값은 in, any, all이 아니고선 하나만 나옴

select employee_id, last_name
from employees
where salary =any (select min(salary)
                    from employees
                    group by department_id); 
-- any는 다른 연산자와 같이 결합돼 사용. or연산자 대신 사용.
-- 어떤 하나라도 트루가 나오면 결과가 나옴.

select employee_id, last_name, job_id, salary
from employees
where salary <any (select salary
                    from employees
                    where job_id = 'IT_PROG')
and job_id <> 'IT_PROG';
-- 서브쿼리에 나온 리턴값중 하나라도 해당이 되면 되는거

-- 과제] 60번 부서의 일부 사원보다 급여가 많은 사원들의 이름을 조회하라.
select last_name
from employees
where salary >any (select salary
                    from employees
                    where department_id = 60);

-- 과제] 회사 평균 월급보다, 그리고 모든 프로그래머보다 월급을 더 받는
--      사원들의 이름, 직업, 월급을 조회하라.
select last_name, job_id, salary
from employees
where salary > (select avg(salary)
                from employees)
and salary > all (select salary
                    from employees
                    where job_id = 'IT_PROG');

select employee_id, last_name, job_id, salary
from employees
where salary <all (select salary
                    from employees
                    where job_id = 'IT_PROG')
and job_id <> 'IT_PROG';
--서브쿼리에 나온 리턴값이 모두 해당 되어야 함.

-- 과제] 이름에 u가 포함된 사원이 있는 부서에서 일하는 사원들의 사번, 이름을 조회하라.
select employee_id, last_name
from employees
where department_id in(select department_id
                        from employees
                        where last_name like '%u%');

-- 과제] 1700번 지역에 위치한 부서에서 일하는 사원들의 이름, 직업, 부서번호를 조회하라.
select last_name, job_id, department_id
from employees
where department_id in(select department_id
                        from departments
                        where location_id = 1700);
-----------------------------
--no row
select last_name
from employees
where salary = (select salary
                from employees
                where employee_id = 1);

select last_name
from employees
where salary in (select salary
                from employees
                where job_id = 'IT');
-- 서브쿼리에 도출되는 값이 없으면 까~알끔하게 나옴

--null
select last_name
from employees
where employee_id in (select manager_id
                        from employees);

select last_name
from employees
where employee_id not in (select manager_id
                        from employees);
-- 매니저가 아닌 일반 사원을 뽑는건데 아무것도 나오지 않음.

-- 과제] 위 문장으로 all 연산자로 refactoring 하라.
select last_name
from employees
where employee_id <>all (select manager_id
                        from employees);
-------------------
select count(*)
from departments;

select count(*)
from departments d
where exists (select * 
                from employees e
                where e.department_id = d.department_id);
 --테이블이 존재하니~?를 물어보는거
 
select count(*)
from departments d
where not exists (select * 
                from employees e
                where e.department_id = d.department_id);
                

