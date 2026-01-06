-- CTEs
-- Common Table Expressions
-- only used immediately after made


-- subquery
select * from 
(
select gender, 
avg(salary) avg_salary, max(salary) max_salary,
 min(salary) min_salary, count(salary) salary_count
from employee_demographics d
join employee_salary s 
on d.employee_id = s.employee_id
group by gender
) as subquery_eg;


-- using CTE
with CTE_example as
(
select gender, 
avg(salary) avg_salary, max(salary) max_salary,
 min(salary) min_salary, count(salary) salary_count
from employee_demographics d
join employee_salary s 
on d.employee_id = s.employee_id
group by gender
)
select * from CTE_example
;

with CTE_example as
(
select gender, 
avg(salary) avg_salary, max(salary) max_salary,
 min(salary) min_salary, count(salary) salary_count
from employee_demographics d
join employee_salary s 
on d.employee_id = s.employee_id
group by gender
)
select avg(avg_salary) from CTE_example;


-- multiple CTEs
with cte_ex1 as
(
select employee_id, gender, birth_date
from employee_demographics
where birth_date>'1959-01-01'
),
cte_ex2 as
(
select employee_id, salary
from employee_salary
where salary>30000
)
select * from cte_ex1
join cte_ex2
on cte_ex1.employee_id = cte_ex2.employee_id;










-- Temporary tables
-- stores unless the window is closed


-- less useful
create temporary table temp_table
(
first_name varchar(50),
last_name varchar(50),
fav_movie varchar(100)
);
select * from temp_table;
insert into temp_table values
('shisihir', 'nepal', 'Shining'),
('ok', 'ok', 'Paris, Texas');


-- more useful method
select * from employee_salary;
create temporary table salary_over_50k
select * from employee_salary
where salary>50000;

select * from salary_over_50k; 