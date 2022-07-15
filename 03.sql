-- single function
-- sql�� ��ҹ��� ������ �������� �����ʹ� �ؾ��Ѵ�.

desc dual
select *
from dual; --���ڵ尡 ���� ��. �ʵ尡 �ϳ��� ����.

select *
from employees;

--lower�� �ҹ��ڷ� �ٲ���
select lower('SQL Course')
from dual; --from������ ������ؼ� dual�� �׳� ����..?

select upper('SQL Course')
from dual;

--�� �ܾ��� ù ���ڸ� �빮�ڷ� �ٲ�
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
where lower(last_name) = 'higgins'; --�̱� ����̶� 107���� �����ؼ� ���� ��

select concat('Hello', 'World')
from dual;

select substr('HelloWorld', 2, 5)
from dual;

select substr('Hello', -1, 1) --�ڿ������� �ѱ��� ������
from dual;

select length('Hello')
from dual;

select instr('hello', 'l')
from dual; --ó�� �߰��� l�� �̾Ƴ��°�
select instr('Hello', 'w')
from dual;

select lpad(salary, 5, '*') --������ �� ���� ���ʿ� ä��°�
from employees;
select rpad(salary, 5, '*')
from employees;

-- ����] ������� �̸�, ���� �׷����� ��ȸ�϶�.
--      �׷����� $1000 �� * �ϳ��� ǥ���Ѵ�.

select last_name, lpad(salary, (trunc(salary/ 1000)) + length(salary), '*')
from employees;

-- ����]�� �׷����� ���� ���� �������� �����϶�.
select last_name, rpad(' ', salary / 1000 + 1, '*') sal
from employees
order by sal desc;

select replace('JACK and JUE', 'J', 'BL')
from dual;

select trim('H' from 'Hello')
from dual;
select trim('l' from 'Hello') --�糡�� ���� �� �ֱ� ������ ����� �ִ� ���� �ȵ�
from dual;
select trim(' ' from ' Hello ')
from dual;
--����] �� query���� ' '�� trim������, ������ Ȯ���� �� �ְ� ��ȸ�϶�.
select '|' || trim(' ' from ' Hello ') || '|'
from dual;
select trim(' Hello World ') --���ڸ� ����� ���� ���� �ʾ� �̷��� ���� ��
from dual;

select employee_id, concat(first_name, last_name) name,
    job_id, length(last_name), instr(last_name, 'a') "Contains 'a'?"
from employees
where substr(job_id, 4) = 'PROG';

-- ����] �Ʒ� ���忡�� where����  like��  refactoring�϶�.
select employee_id, concat(first_name, last_name) name,
    job_id, length(last_name), instr(last_name, 'a') "Contains 'a'?"
from employees
where job_id like '%PROG';

-- ����] �̸��� J�� A�� M���� �����ϴ� ������� �̸�, �̸��� ���ڼ��� ��ȸ�϶�.
--      �̸��� ù���ڴ� �빮��, �������� �ҹ��ڷ� ����Ѵ�.
select initcap(last_name), length(last_name)
from employees
where last_name  like 'J%' or 
    last_name like 'A%' or
    last_name like 'M%';
-----------------------------------

select round(45.926, 2) -- �Ҽ��� 2��° �ڸ� �ݿø�
from dual;
select trunc(45.926, 2) -- �Ҽ��� 2��° �ڸ� ����
from dual;
select mod(1600, 300) -- ������
from dual;

select round(45.923, 0), round(45.923) 
from dual;
-- �Ҽ����ڸ� ���� ���ϸ� ù��° �ڸ���
select trunc(45.923, 0), trunc(45.923)
from dual;

select last_name, salary, salary - mod(salary, 10000)
from employees;
-- ����] ������� �̸�, ����, 15.5% �λ�� ����(New Salary, ����), �λ��(Increase)�� ��ȸ�϶�.�� ��ȸ�϶�.
select last_name, salary, round(salary * 1.155) "New Salary",
        round(salary * 1.155) - salary "Increase"
from employees;
------------------------------------------------------
--��¥�� �ٷ�� �Լ�
select sysdate 
from dual;
--������ ��¥�� �˷���

select sysdate + 1
from dual;
select sysdate - 1
from dual;

select sysdate - sysdate
from dual;

select last_name, sysdate - hire_date
from employees
where department_id = 90;

-- ����] 90�� �μ� ������� �̸�, �ټӳ���� ��ȸ�϶�.
select last_name, trunc((sysdate - hire_date)/365)
from employees
where department_id = 90;

select months_between('2022/12/31', '2021/12/31')
from dual;

select add_months('2022/07/14', 1)
from dual;

select next_day('2022/07/14', 7)
from dual;
 -- 7��14�� ���� ù��° ������̶� ��, ��~��
 
select next_day('2022/07/14', 'thursday')
from dual;
-- �������� ���� �̷��Ե� �ٲ�

select next_day('2022/07/14', 'thu')
from dual;
-- ���ε� ��� ����

select last_day('2022/07/14')
from dual;

-- ����] 20�� �̻� ������ ������� �̸�, ù �������� ��ȸ�϶�.
--      ������ �ſ� ���Ͽ� �����Ѵ�.
select last_name, last_day(hire_date)
from employees
where (sysdate - hire_date) >= 365*20;

select last_name, last_day(hire_date)
from employees
where months_between(sysdate, hire_date) >= 12 * 20;
-- ����� ���
