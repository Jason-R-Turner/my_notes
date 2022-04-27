use employees;

-- GROUPBY

select * from employees
group by gender;
# doesn't work, Error Code: 1055. Expression #1 of SELECT list is not in GROUP BY clause and contains nonaggregated column 'employees.employees.emp_no' which is not functionally dependent on columns in GROUP BY clause; this is incompatible with sql_mode=only_full_group_by

select gender from employees
group by gender;
# need to specify a single column

-- group by can only contain the columns by which you group by _ plus some aggregration aggregration of other variables/columns

select first_name from employees
group by first_name;

select emp_no from employees
group by emp_no;

select emp_no, avg(salary) from salaries
group by emp_no;

select emp_no, avg(salary), min(to_date) from salaries
group by emp_no;

-- is the average salary different for different genders:
select * from employees
join salaries using (emp_no);

select gender, avg(salary), format(stddev(salary), 2) from employees
join salaries using (emp_no)
group by gender;

select gender, avg(salary), format(stddev(salary), 2) from employees
join salaries using (emp_no)
group by gender, lsat_name;
# you can do multiple group bys

-- HAVING
select * from employees
where gender = 'F';

select emp_no, avg (salary) as avg_salary from salaries
group by emp_no
having avg_salary > 50000;

SELECT last_name, count(*) AS n_same_last_name
FROM employees
GROUP BY last_name
HAVING n_same_last_name < 150;
