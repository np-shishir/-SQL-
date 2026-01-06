select gender, avg(salary) as avg_salary
from employee_demographics d
join employee_salary s
on d.employee_id=s.employee_id
group by gender;

select d.first_name, d.last_name, gender, avg(salary) over(partition by gender) as avg_salary
from employee_demographics d
join employee_salary s
on d.employee_id=s.employee_id;

select d.first_name, d.last_name, gender, salary,
sum(salary) over(partition by gender order by d.employee_id) as avg_salary,
sum(salary) over(order by d.employee_id) as rolling_total
from employee_demographics d
join employee_salary s
on d.employee_id=s.employee_id
order by gender, avg_salary;


select d.employee_id, d.first_name, d.last_name, gender, salary,
-- no duplicates
row_number() over(partition by gender order by salary desc) as row_num,
-- duplicates skipped
rank() over(partition by gender order by salary desc) as rank_num,
-- duplicates skipped but counted
dense_rank() over(partition by gender order by salary desc) as dense_rank_num
from employee_demographics d
join employee_salary s
on d.employee_id=s.employee_id;