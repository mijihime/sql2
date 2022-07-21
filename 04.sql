-- datetype conversion (������Ÿ�� ��ȯ)

select hire_date
from employees
where hire_date = '2003/06/17';
-- ���ڰ� ��¥�� ��ȯ

select salary
from employees
where salary = '7000';
-- ���ڰ� ���ڷ� ��ȯ

select hire_date || ''
from employees;
-- ��¥�� ���ڷ� ��ȯ

select salary || ''
from employees;
-- ���ڰ� ���ڷ� ��ȯ
--------------------
select to_char(hire_date)
from employees;

select to_char(sysdate, 'yyyy-mm-dd')
from dual;
-- �ι�° ���̸� fm(���� ��?)�̶�� �θ�.

select to_char(sysdate, 'fmYEAR MONTH DDsp DAY(DY)')
from dual;
--sp�� ���ָ� ���ڰ� ������.

select to_char(sysdate, 'Year Month Ddsp Day(Dy)')
from dual;

select to_char(sysdate, 'd')
from dual;
-- ������ ���ڷ� �� �� �ֽ���

-- ����] �Ʒ� ���̺��� �����Ϻ��� �Ի��ϼ� �������� �����϶�.
select last_name, hire_date, 
        to_char(hire_date, 'day')
from employees
order by to_char(hire_date -1, 'd'), 2;

select to_char(sysdate, 'hh24:mi:ss am')
from dual;

select to_char(sysdate, 'DD "of" Month')
from dual;
-- ��¥ ���� �ȿ� �Ϲ� ���� �ֱ�

select to_char(hire_date, 'DD Month RR')  
from employees;

select to_char(hire_date, 'fmDD Month RRRR')  
from employees;
--������ �ּ�ȭ fill mode
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
-- ������ L
------------------------------
select last_name, hire_date
from employees
where hire_date = to_date('Sep 21, 2005', 'Mon dd, yyyy');

select last_name, hire_date
from employees
where hire_date = to_date('Sep 21, 2005', 'Mon  dd yy');
-- ������ ��Ȯ�� �������ʾƵ� ������ �ִ��� ������, �׸�ŭ �߸��� ������  ���� �� ����

select last_name, hire_date
from employees
where hire_date = to_date('Sep 21, 2005', 'fxMon  dd yy'); 
--Formay eXtract ��Ȯ�ϰ�!! ��Ŀ� �°� ����� �����.
----------------------------

select to_number('1237')
from dual;

select to_number('1,237.12')
from dual; 
--error

select to_number('1,237.12', '9,999.99')
from dual;

-- ����] <�̸�> earns <$,����> monthly but wants <$,����x3>.�� ��ȸ�϶�.
select last_name || ' earns ' || 
    to_char(salary, 'fm$99,999')|| ' Monthly but wants ' || 
    to_char(salary * 3, 'fm$99,999') || '.'
from employees;

-- ����] ������� �̸�, �Ի���, �λ������� ��ȸ�϶�.
--      �λ������� �Ի����� 3���� �� ù��° �������̴�.(3����°�� ���Ծ���)
--      ��¥�� YYYY.MM.DD�� ǥ���Ѵ�.
select last_name, to_char(hire_date, 'YYYY.MM.DD') hire_date,
        to_char(next_day(add_months(to_char(hire_date), 3), 'monday'), 'YYYY.MM.DD') review_date
from employees;
-----------------------------
--etc ��Ÿ (null)
select nvl(null, 0)
from dual;

select job_id, nvl(commission_pct, 0)
from employees;

-- ����] ������� �̸�, ����, ������ ��ȸ�϶�.
select last_name, job_id, 
        12 * salary + (salary * nvl(commission_pct, 0)) sal
from employees;

select last_name, job_id, 
        salary * (1 +  nvl(commission_pct, 0)) *12 ann_sal
from employees
order by ann_sal desc; -- ����� �亯

-- ����] ������� �̸�, Ŀ�̼����� ��ȸ�϶�.
--      Ŀ�̼��� ������, No Commission�� ǥ���Ѵ�.
select last_name, nvl(to_char(commission_pct, '0.00'), 'No Commission') commission
from employees;

select job_id, nvl2(commission_pct, 'SAL+COMM', 'SAL') income
from employees;
select job_id, nvl2(commission_pct, 'SAL+COMM', 0) income
from employees;

select first_name, last_name,
        nullif(length(first_name), length(last_name))
from employees;
-- 'nullif' ��, �� ���ڼ��� ������ null, �ٸ��� �ձ��� ���� ������

select to_char(null), to_number(null), to_date(null)
from dual;

select last_name, job_id,
    coalesce(to_char(commission_pct), to_char(manager_id), 'None')
from employees;
-- 'coalesc'�� ó������ null�� �ƴ� ���� �����Ѵ�.
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
--switch���� ����. �Ķ���ʹ� ��� �� �־ ��.

select decode(salary, 'a', 1)
from employees;
--�⺻���� null�̶� �� ���·� ����.

select decode(salary, 'a', 1, 0)
from employees;

select decode(job_id, 1, 1)
from employees; -- error, invalid number ������Ÿ���� �ٸ���, ���ڷ� �ٲ� �� ���� ���¶�.

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

-- ����] ������� ����, ������ ����� ��ȸ�϶�. �⺻����� null�̴�.
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
--then�� Ÿ���� ���ƾ���. �׷��� �ϳ��� Į���� �ϼ���(else��) 
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
-- decode�� ���ϴ� ���ǹ��� ������ ���� �������ִ°�

-- ����] �̸�, �Ի���, ������ �����Ϻ��� ���ϼ����� ��ȸ�϶�.
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

-- ����] 2005�� ������ �Ի��� ����鿡�� 100���� ��ǰ��,
--      2005�� �Ŀ� �Ի��� ����鿡�� 10���� ��ǰ���� �����Ѵ�.
--      ������� �̸�, �Ի���, ��ǰ�� �ݾ��� ��ȸ�϶�.
select last_name, hire_date,
         case when hire_date < '2006-01-01' then '100����'
                else '10����'
        end voucher
from employees
