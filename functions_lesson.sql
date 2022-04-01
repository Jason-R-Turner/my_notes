use employees;

-- STRING FUNCTIONS:
-- https://dev.mysql.com/doc/refman/5.7/en/string-functions.html

-- CASE CONVERSION
SELECT 
    LOWER(first_name), UPPER(last_name)
FROM
    employees;
# LOWER makes all letters lower case UPPER works for upper case

-- CONCAT
-- e.g. concat first_name and last_name to creat a username:
SELECT 
    CONCAT(first_name, last_name)
FROM
    employees;
    
SELECT 
    CONCAT(first_name, '_', last_name) AS username
FROM
    employees;
    
SELECT 
    concat(lower(first_name, '.', last_name, '@company.com')) AS username
FROM
    employees;
# Doesn't work if you switch concat and lower, it gives Error Code: 1582. Incorrect parameter count in the call to native function 'lower'
    
-- SUBSTRING 
-- Substring function allows us to obtain part of a string

SELECT SUBSTR('abcdefg', 2, 4);
# gives "bcde"

SELECT 
    CONCAT(SUBSTR(first_name, 1, 1), last_name) AS username
FROM
    employees;
  
-- Replace
SELECT REPLACE('abcdefg', 'abc', '123');
# gives '123defg'

SELECT REPLACE('abcdefg', 'ABC', '123');
# gives 'abcdefg' case size matters, it needs to matach. i.e. it's case-sensitive

SELECT REPLACE('abcdefgabc', 'abc', '123');
# gives '123defg123'

-- DATETIME FUNCTIONS
-- https://dev.mysql.com/doc/refman/5.7/en/date-and-time-functions.html

-- we can get the day or month name of the week from a date (or string that mathes the date format)
select dayname("1970-01-01");
# returns 'Thursday'

select monthname("2022-03-31");
# returns 'March'

-- Current date. time or timestamp
select curdate();
# returns '2022-04-01'

select current_time();
# returns '14:57:37'

select current_timestamp();
# returns '2022-04-01 14:58:36'

-- how many years has it been since each employee's original hire date and today?
select *, datediff(curdate(), hire_date)/365 as tenure from employees;
# returns many results like '10001', '1953-09-02', 'Georgi', 'Facello', 'M', '1986-06-26', '35.7890', with the last column being "tenure"


-- unix time is the number of seconds since 1970-01-01
select unix_timestamp('1971-01-01;');
# returns '31536000'

-- We can add our function outputs as new columns onto existing output e.g. days someone was born
select *, dayname(birth_date) as day_of_birth from employees;
# returns many results like '10001', '1953-09-02', 'Georgi', 'Facello', 'M', '1986-06-26', 'Wednesday', with the last column being "day_of_birth"


-- NUMERIC/AGGREGATE FUNCTIONS e.g. min, max, average, stddev, count, sum etc.
SELECT 
    AVG(salary), MIN(salary), MAX(salary), STDDEV(salary)
FROM
    salaries;
# returns '63810.7448', '38623', '158220', '16904.82828800014'


