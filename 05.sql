--group function
select avg(salary), max(salary), min(salary), sum(salary)
from employees;

select min(hire_date), max(hire_date)
from employees;
--최근 날짜가 max임둥

-- 과제] 최고월급과 최소월급의 차액을 조회하라.
select max(salary) - min(salary)
from employees;

select count(*)
from employees;

-- 과제] 70번 부서원이 몇명인지 조회하라.
select count(*)
from employees
where department_id = 70;

select count(employee_id)
from employees;
--primary고 null값이 없기 때문에 카운트가 다 됨

select count(manager_id)
from employees;
--그룹함수에서는 파라미터 밸류가 null이면 무시함.

select avg(commission_pct)
from employees;

-- 과제] 조직의 평균 커미션율을 조회하라.
select avg(nvl(commission_pct,0))
from employees;
------------------------
select avg(salary)
from employees;

select avg(distinct salary)
from employees;
--중복값 제외 평균 구함

select avg(all salary)
from employees;

-- 과제] 직원이 배치된 부서 개수를 조회하라.
select count(distinct department_id)
from employees;

-- 과제] 매니저 수를 조회하라.
select count(distinct manager_id)
from employees;
-------------------------------
--그룹의 갯수를 n개로 만들기

select department_id, count(employee_id)
from employees
group by department_id
order by department_id;
--그룹바이는 레이블?을 만드는 느낌, 그룹바이가 없으면 표가 의미가 없어짐

select employee_id
from employees
where department_id = 30;

select department_id, job_id, count(employee_id)
from employees
group by department_id
order by department_id; 
--error 그룹바이절에 나온게 셀렉절에 나온거,, employee_id는 count에서 리턴한 값이라

-- 과제] 직업별 사원수를 조회하라.
select job_id, count(employee_id)
from employees
group by job_id
order by job_id;

----------------------------
select department_id, max(salary)
from employees
group by department_id
having department_id > 50;

select department_id, max(salary)
from employees
where department_id > 50
group by department_id;
--결과는 같나 알고리즘이 다름

select department_id, max(salary)
from employees
group by department_id
having max(salary) > 10000;

select department_id, max(salary) max_sal
from employees
group by department_id
having max_sal > 10000; --error

select department_id, max(salary)
from employees
where max(salary) > 10000
group by department_id; --error 그냥 그룹은 having써라

