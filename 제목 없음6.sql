select department_id, department_name, location_id
from departments;

select location_id, city
from locations;

select department_id, department_name, location_id, city
from departments natural join locations;

select department_id, department_name, location_id, city
from departments natural join locations
where department_id in(20, 50);

select employee_id, last_name, department_id, location_id
from employees natural join departments;

select locations.city, departments.department_name
from locations join departments
using(location_id)
where location_id = 1400;

select locations.city, departments.department_name
from locations join departments
using(location_id)
where d.location_id = 1400;

select l.city, d.department_name, d.location_id
from locations l join departments d
using (location_id)
where location_id = 1400; 