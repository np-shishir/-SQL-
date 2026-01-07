-- stored procedures



create procedure large_salaries()
select * 
from employee_salary
where salary>=50000;

call large_salaries();

delimiter $$
create procedure large_salaries2()
begin
	select *
    from employee_salary
    where salary>=50000;
    select * 
    from employee_salary 
    where salary>=10000;
end $$
delimiter ;

call large_salaries2();

drop procedure if exists get_salary;
create procedure get_salary(p_employee_id int)
	select *
    from employee_salary
    where employee_id = p_employee_id;
    
call get_salary(2);



-- Trigger and events
-- trigger is a block of code that executes automatically when an event takes place in a specific table

delimiter $$
create trigger employee_insert
	after insert on employee_salary
	for each row
begin
	insert into employee_demographics (employee_id, first_name, last_name)
    values (new.employee_id, new.first_name, new.last_name); -- from employee_salary
end $$
delimiter ;


insert into employee_salary (employee_id, first_name, last_name, occupation, salary, dept_id)
values (13, 'Jean', 'Sap', 'Entertainment 720 CEO', 100000, null);

select * from employee_salary;
select * from employee_demographics;


-- events 
select *
from employee_demographics;


delimiter $$
create event delete_retirees
on schedule every 30 second
do
begin
	delete
    from employee_demographics
    where age >= 60;

end $$

delimiter ;



