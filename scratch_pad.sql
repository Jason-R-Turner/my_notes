use employees;

/*SELECT salary,
    (salary - (SELECT AVG(salary) FROM salaries))
    /
    (SELECT stddev(salary) FROM salaries) AS zscore
FROM salaries;*/

SELECT 
    (salary - (SELECT 
            AVG(salary)
        FROM
            salaries)) / (SELECT 
            STDDEV(salary)
        FROM
            salaries) AS zscore
FROM
    salaries;
    
SELECT salary,
    (salary - (SELECT AVG(salary) FROM salaries))
    /
    (SELECT stddev(salary) FROM salaries) AS zscore
FROM salaries;

Select z.zscore FROM (SELECT salary,
    (salary - (SELECT AVG(salary) FROM salaries))
    /
    (SELECT stddev(salary) FROM salaries) AS zscore
FROM salaries) as z;

Select max(z.zscore) FROM (SELECT salary,
    (salary - (SELECT AVG(salary) FROM salaries))
    /
    (SELECT stddev(salary) FROM salaries) AS zscore
FROM salaries) as z;

Select z.salary, z.zscore FROM (SELECT salary,
    (salary - (SELECT AVG(salary) FROM salaries WHERE
    to_date > CURDATE()))
    /
    (SELECT stddev(salary) FROM salariesWHERE
    to_date > CURDATE()) AS zscore
FROM salaries) as z where zscore >= ((Select max(z.zscore) FROM (SELECT salary,
    (salary - (SELECT AVG(salary) FROM salaries))
    /
    (SELECT stddev(salary) FROM salaries) AS zscore
FROM salaries) as z) -1);


SELECT 
    z.salary, z.zscore
FROM
    (SELECT 
        salary,
            (salary - (SELECT 
                    AVG(salary)
                FROM
                    salaries
                WHERE
                    to_date > CURDATE())) / (SELECT 
                    STDDEV(salary)
                FROM
                    salaries
                WHERE
                    to_date > CURDATE()) AS zscore
    FROM
        salaries WHERE
    to_date > CURDATE()) AS z
WHERE
    zscore > ((SELECT 
            MAX(z.zscore)
        FROM
            (SELECT 
                salary,
                    (salary - (SELECT 
                            AVG(salary)
                        FROM
                            salaries
                        WHERE
                            to_date > CURDATE())) / (SELECT 
                            STDDEV(salary)
                        FROM
                            salaries WHERE
    to_date > CURDATE()) AS zscore
            FROM
                salaries
            WHERE
                to_date > CURDATE()) AS z) - 1);

# alt way

SELECT z.zscore From (SELECT salary,
    (salary - (SELECT AVG(salary) FROM salaries))
    /
    (SELECT stddev(salary) FROM salaries) AS zscore
FROM salaries) as z where zscore > 4;

SELECT z.zscore From (SELECT salary,
    (salary - (SELECT AVG(salary) FROM salaries))
    /
    (SELECT stddev(salary) FROM salaries) AS zscore
FROM salaries) as z where zscore > ((SELECT
    max(salary - (SELECT AVG(salary) FROM salaries))
    /
    (SELECT stddev(salary) FROM salaries) AS zscore
FROM salaries) -1);

# scalar value for max zscore from all salaries
SELECT
    max(salary - (SELECT AVG(salary) FROM salaries))
    /
    (SELECT stddev(salary) FROM salaries) AS zscore
FROM salaries;


## Temporary Tables
use employees;

CREATE TEMPORARY TABLE employees_with_departments AS
SELECT emp_no, first_name, last_name, dept_no, dept_name
FROM employees
JOIN dept_emp USING(emp_no)
JOIN departments USING(dept_no)
LIMIT 100;

-- Temp Tables: The heart of the matter: flexiblity
select emp_no, salary
from salaries
where to_date > now ()
limit 10;

-- 72012
select avg(salary)
from salaries
where to_date > now()
limit 10;

create temporary table jemison_1749.salary_info AS
select emp_no, salary
from salaries
where to_date > now ()
limit 10;

alter table jemison.salary_info add avg_salary INT;

update jemison_1749.salary_info
set avg_salary = (select avg(salary) from salaries where to_date > now ());

# "salary > avg_salary", returns a boolean oanswer of 1 or 0
select emp_no, salary > avg_salary as "greater" , salary, avg_salary from jemison_1749.salary_info;

select sum(greater) from jemison_1749.salary_info2;

-- create a temporary table, you can add new columns

select * from jemison_1749.salary_info2
join employees using(emp_no)
order by greater desc, diff desc;

create table jemison_1749.who_to_schmooze as select * from ryan.salary_info2;

SELECT salary, 
(salary - (SELECT AVG(salary) FROM salaries WHERE to_date > CURDATE()))
/ 
(SELECT STDDEV(salary) FROM salaries WHERE to_date > CURDATE()) AS current_zscore
FROM salaries WHERE to_date > CURDATE() order by current_zscore desc;
    
SELECT d.dept_name, Round(avg(s.salary), 2) as average_salary_now
FROM dept_emp AS de
JOIN salaries AS s
ON s.emp_no = de.emp_no
	AND de.to_date > CURDATE()
    AND s.to_date > CURDATE()
JOIN departments AS d
  ON d.dept_no = de.dept_no
GROUP BY d.dept_name
ORDER BY average_salary_now DESC;

SELECT AVG(salary) FROM salaries;