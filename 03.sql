-- single function
-- sql은 대소문자 구분을 안하지만 데이터는 해야한다.

desc dual
select *
from dual; --레코드가 리턴 됨. 필드가 하나만 있음.

select *
from employees;

--lower은 소문자로 바꿔줌
select lower('SQL Course')
from dual; --from까지는 써줘야해서 dual을 그냥 써줌..?

select upper('SQL Course')
from dual;

--각 단어의 첫 글자를 대문자로 바꿈
select initcap('SQL Course')
from dual;

select last_name
from employees
where last_name = 'higgins';

select last_name
from employees
where last_name = 'Higgins';

select last_name
from employees
where lower(last_name) = 'higgins'; --싱글 펑션이라 107번을 실행해서 나온 값

select concat('Hello', 'World')
from dual;

select substr('HelloWorld', 2, 5)
from dual;

select substr('Hello', -1, 1) --뒤에서부터 한글자 떼오기
from dual;

select length('Hello')
from dual;

select instr('hello', 'l')
from dual; --처음 발견한 l을 뽑아내는거
select instr('Hello', 'w')
from dual;

select lpad(salary, 5, '*') --데이터 빈 곳을 왼쪽에 채우는거
from employees;
select rpad(salary, 5, '*')
from employees;

-- 과제] 사원들의 이름, 월급 그래프를 조회하라.
--      그래프는 $1000 당 * 하나를 표시한다.

select last_name, lpad(salary, (trunc(salary/ 1000)) + length(salary), '*')
from employees;

-- 과제]위 그래프를 월급 기준 내림차순 정렬하라.
select last_name, rpad(' ', salary / 1000 + 1, '*') sal
from employees
order by sal desc;

select replace('JACK and JUE', 'J', 'BL')
from dual;

select trim('H' from 'Hello')
from dual;
select trim('l' from 'Hello') --양끝만 지울 수 있기 때문에 가운데에 있는 글은 안됨
from dual;
select trim(' ' from ' Hello ')
from dual;
--과제] 위 query에서 ' '가 trim됐음을, 눈으로 확인할 수 있게 조회하라.
select '|' || trim(' ' from ' Hello ') || '|'
from dual;
select trim(' Hello World ') --글자를 지우는 경우는 많지 않아 이렇게 쓰면 됨
from dual;

select employee_id, concat(first_name, last_name) name,
    job_id, length(last_name), instr(last_name, 'a') "Contains 'a'?"
from employees
where substr(job_id, 4) = 'PROG';

-- 과제] 아래 문장에서 where절을  like로  refactoring하라.
select employee_id, concat(first_name, last_name) name,
    job_id, length(last_name), instr(last_name, 'a') "Contains 'a'?"
from employees
where job_id like '%PROG';

-- 과제] 이름이 J나 A나 M으로 시작하는 사원들의 이름, 이름의 글자수를 조회하라.
--      이름은 첫글자는 대문자, 나머지는 소문자로 출력한다.
select initcap(last_name), length(last_name)
from employees
where last_name  like 'J%' or 
    last_name like 'A%' or
    last_name like 'M%';
-----------------------------------

select round(45.926, 2) -- 소숫점 2번째 자리 반올림
from dual;
select trunc(45.926, 2) -- 소숫점 2번째 자리 내림
from dual;
select mod(1600, 300) -- 나머지
from dual;

select round(45.923, 0), round(45.923) 
from dual;
-- 소숫점자리 지정 안하면 첫번째 자리서
select trunc(45.923, 0), trunc(45.923)
from dual;

select last_name, salary, salary - mod(salary, 10000)
from employees;
-- 과제] 사원들의 이름, 월급, 15.5% 인상된 월급(New Salary, 정수), 인상액(Increase)을 조회하라.을 조회하라.
select last_name, salary, round(salary * 1.155) "New Salary",
        round(salary * 1.155) - salary "Increase"
from employees;
------------------------------------------------------
--날짜를 다루는 함수
select sysdate 
from dual;
--서버의 날짜를 알려줌

select sysdate + 1
from dual;
select sysdate - 1
from dual;

select sysdate - sysdate
from dual;

select last_name, sysdate - hire_date
from employees
where department_id = 90;

-- 과제] 90번 부서 사원들의 이름, 근속년수를 조회하라.
select last_name, trunc((sysdate - hire_date)/365)
from employees
where department_id = 90;

select months_between('2022/12/31', '2021/12/31')
from dual;

select add_months('2022/07/14', 1)
from dual;

select next_day('2022/07/14', 7)
from dual;
 -- 7월14일 이후 첫번째 토요일이란 뜻, 일~토
 
select next_day('2022/07/14', 'thursday')
from dual;
-- 가독성을 위해 이렇게도 바꿈

select next_day('2022/07/14', 'thu')
from dual;
-- 약어로도 사용 가능

select last_day('2022/07/14')
from dual;

-- 과제] 20년 이상 재직한 사원들의 이름, 첫 월급일을 조회하라.
--      월급은 매월 말일에 지급한다.
select last_name, last_day(hire_date)
from employees
where (sysdate - hire_date) >= 365*20;

select last_name, last_day(hire_date)
from employees
where months_between(sysdate, hire_date) >= 12 * 20;
-- 강사님 대답
