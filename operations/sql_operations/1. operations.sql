select * from employee_demographics;

select * from employee_salary;

select * from parks_departments as d;

select gender, count(*)
from employee_demographics
group by gender
order by count(*);

select * from employee_demographics
where first_name like '%n';

select  dept_id, max(salary)
from employee_salary
group by dept_id;

select * from employee_demographics
where birth_date > '1980-01-01' and gender='Male';


select s.first_name, s.last_name, d.department_name, s.salary
from employee_salary as s
left join parks_departments as d
on s.dept_id = d.department_id;


select d.department_name,
avg(s.salary) as avg_salary
from employee_salary  s
left join parks_departments  d 
on d.department_id= s.dept_id
where d.department_name is not null
group by department_name;



select d.department_name,
max(s.salary) as max_salary,
min(s.salary) as min_salary,
avg(s.salary) as avg_salary
from parks_departments d
join employee_salary s 
group by d.department_name
order by max_salary desc;


select * from employee_salary
where salary> (
	select avg(salary) 
    from employee_salary
);