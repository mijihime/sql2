-- datetype conversion (데이터타입 변환)

select hire_date
from employees
where hire_date = '2003/06/17';
-- 문자가 날짜로 변환

select salary
from employees
where salary = '7000';
-- 문자가 숫자로 변환

select hire_date || ''
from employees;
-- 날짜가 문자로 변환

select salary || ''
from employees;
-- 숫자가 문자로 변환
--------------------
select to_char(hire_date)
from employees;

select to_char(sysdate, 'yyyy-mm-dd')
from dual;
-- 두번째 아이를 fm(폼의 모델?)이라고 부름.

select to_char(sysdate, 'fmYEAR MONTH DDsp DAY(DY)')
from dual;
--sp를 없애면 숫자가 뜨지요.

select to_char(sysdate, 'Year Month Ddsp Day(Dy)')
from dual;

select to_char(sysdate, 'd')
from dual;
-- 요일을 숫자로 할 수 있슴다

-- 과제] 아래 테이블을 월요일부터 입사일순 오름차순 정렬하라.
select last_name, hire_date, 
        to_char(hire_date, 'day')
from employees
order by to_char(hire_date -1, 'd'), 2;

select to_char(sysdate, 'hh24:mi:ss am')
from dual;

select to_char(sysdate, 'DD "of" Month')
from dual;
-- 날짜 형식 안에 일반 문자 넣기

select to_char(hire_date, 'DD Month RR')  
from employees;

select to_char(hire_date, 'fmDD Month RRRR')  
from employees;
--여백의 최소화 fill mode
----------------------------

select to_char(salary) 
from employees;

select last_name, to_char(salary, '$99,999.99'),
    to_char(salary, '$00,000.00')
from employees
where last_name = 'Ernst';

select '|' || to_char(12.12, '9999.999') || '|',
    '|' || to_char(12.12, '0000.000') || '|'
from dual;

select '|' || to_char(12.12, 'fm9999.999') || '|',
    '|' || to_char(12.12, 'fm0000.000') || '|'
from dual;

select to_char(1237, 'L9999')
from dual;
-- 로컬의 L
------------------------------
select last_name, hire_date
from employees
where hire_date = to_date('Sep 21, 2005', 'Mon dd, yyyy');

select last_name, hire_date
from employees
where hire_date = to_date('Sep 21, 2005', 'Mon  dd yy');
-- 형식을 정확히 맞추지않아도 번역이 최대한 되지만, 그만큼 잘못된 정보가  들어올 수 있음

select last_name, hire_date
from employees
where hire_date = to_date('Sep 21, 2005', 'fxMon  dd yy'); 
--Formay eXtract 정확하게!! 양식에 맞게 쓰라고 경고줌.
----------------------------

select to_number('1237')
from dual;

select to_number('1,237.12')
from dual; 
--error

select to_number('1,237.12', '9,999.99')
from dual;

-- 과제] <이름> earns <$,월급> monthly but wants <$,월급x3>.로 조회하라.
select last_name || ' earns ' || 
    to_char(salary, 'fm$99,999')|| ' Monthly but wants ' || 
    to_char(salary * 3, 'fm$99,999') || '.'
from employees;

-- 과제] 사원들의 이름, 입사일, 인사평가일을 조회하라.
--      인사평가일은 입사한지 3개월 후 첫번째 월요일이다.(3개월째는 포함안함)
--      날짜는 YYYY.MM.DD로 표시한다.
select last_name, to_char(hire_date, 'YYYY.MM.DD') hire_date,
        to_char(next_day(add_months(to_char(hire_date), 3), 'monday'), 'YYYY.MM.DD') review_date
from employees;
-----------------------------
--etc 기타 (null)
select nvl(null, 0)
from dual;

select job_id, nvl(commission_pct, 0)
from employees;

-- 과제] 사원들의 이름, 직업, 연봉을 조회하라.
select last_name, job_id, 
        12 * salary + (salary * nvl(commission_pct, 0)) sal
from employees;

select last_name, job_id, 
        salary * (1 +  nvl(commission_pct, 0)) *12 ann_sal
from employees
order by ann_sal desc; -- 강사님 답변

-- 과제] 사원들의 이름, 커미션율을 조회하라.
--      커미션이 없으면, No Commission을 표시한다.
select last_name, nvl(to_char(commission_pct, '0.00'), 'No Commission') commission
from employees;

select job_id, nvl2(commission_pct, 'SAL+COMM', 'SAL') income
from employees;
select job_id, nvl2(commission_pct, 'SAL+COMM', 0) income
from employees;

select first_name, last_name,
        nullif(length(first_name), length(last_name))
from employees;
-- 'nullif' 앞, 뒤 글자수가 같으면 null, 다르면 앞글자 수를 리턴함

select to_char(null), to_number(null), to_date(null)
from dual;

select last_name, job_id,
    coalesce(to_char(commission_pct), to_char(manager_id), 'None')
from employees;
-- 'coalesc'는 처음으로 null이 아닌 값을 리턴한다.
--------------------------------------------------

select last_name, salary, 
    decode(trunc(salary / 2000),
        0, 0.00,
        1, 0.09,
        2, 0.20,
        3, 0.30,
        4, 0.40,
        5, 0.42,
        6, 0.44,
           0.45) tax_rate
from employees
where department_id = 80;
--switch같은 개념. 파라미터는 몇개든 더 넣어도 됨.

select decode(salary, 'a', 1)
from employees;
--기본값이 null이라 빈 상태로 나옴.

select decode(salary, 'a', 1, 0)
from employees;

select decode(job_id, 1, 1)
from employees; -- error, invalid number 데이터타입이 다르고, 숫자로 바꿀 수 없는 형태라서.

select decode(hire_date, 'a', 1)
from employees;

select decode(hire_date, 1, 1)
from employees; --error

select last_name, hire_date, to_char(hire_date, 'day') day,
         decode (to_char(hire_date, 'd'), 
                '1', 7,
                '2', 1,
                '3', 2,
                '4', 3,
                '5', 4,
                '6', 5,
                     6) num
from employees
order by 4;

select last_name, hire_date, to_char(hire_date, 'day') day,
         decode (to_char(hire_date, 'fmday'), 
                'sunday',    7,
                'monday',    1,
                'tuesday',   2,
                'wednesday', 3,
                'thursday',  4,
                'saturday',  5,
                'friday',    6) num
from employees
order by 4;

-- 과제] 사원들의 직업, 직업별 등급을 조회하라. 기본등급은 null이다.
-- IT_PROG,  A,
-- AD_PRES,  B,
-- ST-MAN,   C,
-- ST_CLERK, D,

select job_id, decode(job_id, 
                        'IT_PROG',  'A',
                        'AD_PRES',  'B',
                        'ST_MAN',   'C',
                        'ST_CLERK', 'D') job_rate
from employees;

select last_name, job_id, salary,
    case job_id when 'IT_PROG' then 1.10 * salary
                when 'AD_PRES' then 1.05 * salary
    else salary end revised_salary
from employees;
--then의 타입은 같아야함. 그래야 하나의 칼럼이 완성됨(else도) 
select case job_id when '1' then 1
                    when '2' then 2
                    else 0
        end grade
from employees;

select case salary when 1 then '1'
                    when 2 then '2'
                    else '0'
        end grade
from employees;

select case salary when '1' then '1' --error
                    when 2 then '2'
                    else '0'
        end grade
from employees; 

select case salary when 1 then '1'
                    when 2 then '2'
                    else 0 --error
        end grade
from employees;

select case salary when 1 then 1
                    when 2 then '2'
                    else '0'
        end grade
from employees;

select last_name, salary,
    case when salary < 5000 then 'low'
        when salary < 10000 then 'medium'
        when salary < 20000 then 'high'
        else 'good'
    end grade
from employees;
-- decode가 못하는 조건문을 가지고 값을 리턴해주는거

-- 과제] 이름, 입사일, 요일을 월요일부터 요일순으로 조회하라.
select last_name, hire_date, to_char(hire_date, 'day') day
from employees
order by case to_char(hire_date, 'd') 
            when  '1' then 7
            when '2' then 1
            when '3' then 2
            when '4' then 3
            when '5' then 4
            when '6' then 5
                     else 6
         end;

-- 과제] 2005년 이전에 입사한 사원들에게 100만원 상품권,
--      2005년 후에 입사한 사원들에게 10만원 상품권을 지급한다.
--      사원들의 이름, 입사일, 상품권 금액을 조회하라.
select last_name, hire_date,
         case when hire_date < '2006-01-01' then '100만원'
                else '10만원'
        end voucher
from employees
