select * from employee_demographics;
  
select * from employee_salary;
#
select gender, avg(age) as total
from employee_demographics
group by gender
having total>40 or total<40
order by total desc
;


select occupation, count(*) as total
from employee_salary
group by occupation
having total=1;

select * from employee_demographics
order by age desc
limit 1, 2;


select d.gender, avg(s.salary) as avg_salary
from employee_demographics d
join employee_salary s
group by d.gender;


select * from employee_demographics d
join employee_salary s
	on d.employee_id = s.employee_id;


select first_name, last_name, 'Old Man' as Label
from employee_demographics d
where age>40 and gender='Male'
union
select first_name, last_name, 'Old Lady' as Label
from employee_demographics d
where age>35 and gender='Female'
union
select first_name, last_name, 'High paid' as Label
from employee_salary s
where salary>70000
order by first_name, last_name;


-- String functions

select length('sky') as length;
select upper('sky');
select lower('sky');

select first_name, length(d.first_name) as length, 
upper(d.first_name) as upper_name
from employee_demographics as d
order by length;

select trim('        Tom Sawyer        ');

-- substring
select first_name, 
left(first_name, 4),
right(first_name, 4)
from employee_demographics;

-- birth months
select first_name, birth_date,
substring(birth_date, 6,2) as birth_mnths
from employee_demographics;



select first_name, replace(first_name, 'a', 'z')
from employee_demographics;

select locate('x', 'Alexander');

select first_name, locate('ri', first_name) as position
from employee_demographics
order by position desc;


select first_name, last_name,
concat(first_name,' ',  last_name) as full_name
from employee_demographics;


-- case
select first_name, last_name,
case
	when age<=30 then 'Young'
    when age between 31 and 45 then 'Middle age'
    when age>45 then 'Old'
end as status
from employee_demographics;

select first_name, last_name, salary,
case
	when salary<30000 then 'Low paid'
    when salary between 30001 and 60000 then 'Well paid'
    when salary>60000 then 'Highly paid'
end as payment_status
from employee_salary
;


-- increase salary as per their initial and add bonus to finance dept
select first_name, last_name, salary,
case
	when salary<45000 then salary+(0.5*salary)
    when salary>=45000 then salary+(0.7*salary)
end as updated_salary,
case
	when dept_id = 6 then salary*0.1
end as bonus
from employee_salary
order by updated_salary desc;

select * from employee_salary;

