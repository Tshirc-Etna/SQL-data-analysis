-- Createing the table "employee"
CREATE TABLE Employees (
    employee_id INT PRIMARY KEY,
    first_name NVARCHAR(50),
    last_name NVARCHAR(50),
    department NVARCHAR(50),
    salary DECIMAL(10,2),
    hire_date DATE,
    age INT,
    city NVARCHAR(50),
    performance_rating DECIMAL(3,2)
);


-- Insert Employees values into Table
INSERT INTO Employees 
(employee_id, first_name, last_name, department, salary, hire_date, age, city, performance_rating)
VALUES 
(1, 'John', 'Smith', 'Sales', 55000, '2019-03-15', 35, 'New York', 4.5),

(2, 'Emily', 'Johnson', 'Marketing', 62000, '2018-06-22', 28, 'Chicago', 4.7),
 
(3, 'Michael', 'Williams', 'IT', 75000, '2017-01-10', 42, 'San Francisco', 4.9),

(4, 'Sarah', 'Brown', 'HR', 52000, '2020-11-05', 31, 'Boston', 4.2),

(5, 'David', 'Miller', 'Finance', 68000, '2016-09-18', 39, 'Los Angeles', 4.6),

(6, 'Jennifer', 'Davis', 'Sales', 53000, '2018-12-01', 33, 'Houston', 4.3),

(7, 'Robert', 'Garcia', 'IT', 80000, '2015-07-30', 45, 'Seattle', 4.8),

(8, 'Lisa', 'Martinez', 'Marketing', 59000, '2019-08-14', 36, 'Miami', 4.4),

(9, 'Kevin', 'Robinson', 'Finance', 65000, '2017-04-25', 40, 'Dallas', 4.5),

(10, 'Amanda', 'Clark', 'HR', 51000, '2021-02-17', 29, 'Phoenix', 4.1),

(11, 'Brian', 'Rodriguez', 'IT', 72000, '2016-11-09', 38, 'Denver', 4.7),

(12, 'Jessica', 'Lee', 'Sales', 54000, '2020-05-30', 32, 'Atlanta', 4.2),

(13, 'Daniel', 'Walker', 'Marketing', 60000, '2018-03-12', 37, 'Philadelphia', 4.5),

(14, 'Nicole', 'Hall', 'Finance', 67000, '2017-06-28', 41, 'San Diego', 4.6),

(15, 'Ryan', 'Allen', 'IT', 78000, '2015-12-05', 44, 'Austin', 4.9),

(16, 'Karen', 'White', 'HR', 54000, '2019-05-22', 34, 'Portland', 4.4),

(17, 'Thomas', 'Anderson', 'IT', 82000, '2016-02-14', 43, 'San Jose', 4.8),

(18, 'Maria', 'Lopez', 'Marketing', 57000, '2020-01-08', 30, 'Orlando', 4.3),

(19, 'Christopher', 'Taylor', 'Sales', 56000, '2018-07-15', 36, 'Nashville', 4.5),

(20, 'Elizabeth', 'Moore', 'Finance', 69000, '2017-11-20', 39, 'Charlotte', 4.6),

(21, 'James', 'Jackson', 'IT', 76000, '2016-05-03', 41, 'Columbus', 4.7),

(22, 'Patricia', 'Martin', 'HR', 53000, '2021-03-15', 33, 'Indianapolis', 4.2),

(23, 'Richard', 'Thompson', 'Sales', 57000, '2019-09-01', 37, 'Milwaukee', 4.4),

(24, 'Susan', 'Evans', 'Marketing', 61000, '2017-12-10', 40, 'Kansas City', 4.5),

(25, 'William', 'Harris', 'Finance', 66000, '2018-04-17', 38, 'Tucson', 4.6),

(26, 'Linda', 'Sanders', 'IT', 79000, '2015-10-05', 45, 'Albuquerque', 4.9),

(27, 'Charles', 'Price', 'Sales', 55000, '2020-08-12', 32, 'Omaha', 4.3),

(28, 'Margaret', 'Bennett', 'HR', 52000, '2019-06-25', 35, 'Raleigh', 4.2),
 
(29, 'Steven', 'Wood', 'Marketing', 58000, '2017-02-28', 39, 'Fresno', 4.5),

(30, 'Barbara', 'Barnes', 'Finance', 67000, '2016-07-19', 42, 'Sacramento', 4.7);

-- filtering by 
--Select all employees
SELECT * FROM Employees;

-- Select only first and last names
SELECT first_name, last_name FROM Employees;

-- Select employees from the Sales department
SELECT * FROM Employees WHERE department = 'Sales';

-- Find employees older than 35
SELECT * FROM Employees WHERE age > 35;

-- Find employees with salary over 70000
SELECT * FROM Employees WHERE salary > 70000;

-- Find employees from New York or Chicago
SELECT * FROM Employees WHERE city IN ('New York', 'Chicago');


-- Sort employees by salary in descending order
SELECT * FROM Employees ORDER BY salary DESC;

-- Sort employees by age, youngest to oldest
SELECT * FROM Employees ORDER BY age ASC;

-- Sort employees by department and then by salary
SELECT * FROM Employees ORDER BY department, salary DESC;

-- Aggregation:
-- Count total number of employees
SELECT COUNT(*) AS total_employees FROM Employees;

-- Calculate average salary
SELECT AVG(salary) AS average_salary FROM Employees;

-- Count employees in each department
SELECT department, COUNT(*) AS department_count 
FROM Employees 
GROUP BY department;

-- Calculate average salary by department
SELECT department, AVG(salary) AS avg_department_salary 
FROM Employees 
GROUP BY department;

-- More complexe filtering:
-- Find employees with performance rating above 4.5
SELECT * FROM Employees WHERE performance_rating > 4.5;

-- Find employees in IT department older than 40
SELECT * FROM Employees 
WHERE department = 'IT' AND age > 40;

-- Find employees in Sales with salary above 54000
SELECT * FROM Employees 
WHERE department = 'Sales' AND salary > 54000;

-- Find average salary for each department, only for departments with more than 3 employees
SELECT department, AVG(salary) AS avg_salary, COUNT(*) AS employee_count
FROM Employees 
GROUP BY department
HAVING COUNT(*) > 3;

-- Find the youngest and oldest employees in each department
SELECT department, 
       MIN(age) AS youngest_age, 
       MAX(age) AS oldest_age
FROM Employees
GROUP BY department;

-- Find the median salary (this requires a bit more complex query)
SELECT AVG(salary) AS median_salary
FROM (
    SELECT salary
    FROM (
        SELECT salary, 
               ROW_NUMBER() OVER (ORDER BY salary) AS row_num,
               COUNT(*) OVER () AS total_count
        FROM Employees
    ) AS ranked
    WHERE row_num IN ((total_count + 1)/2, (total_count + 2)/2)
) AS median_query;

-- Calculate the total payroll by department
SELECT department, 
       SUM(salary) AS total_department_payroll,
       COUNT(*) AS employee_count,
       AVG(salary) AS average_salary
FROM Employees
GROUP BY department
ORDER BY total_department_payroll DESC;

-- Top 5 employees by performance rating
SELECT
    CONCAT(first_name, ' ', last_name) AS full_name, 
    department, 
    performance_rating 
FROM Employees 
ORDER BY performance_rating DESC
LIMIT 5 ;

-- Department-wide statistics
SELECT 
    department, 
    COUNT(*) AS employee_count, 
    ROUND(AVG(salary), 2) AS avg_salary, 
    MAX(salary) AS max_salary 
FROM Employees 
GROUP BY department;


--Comprehensive department report
SELECT 
    department, 
    COUNT(*) AS total_employees, 
    ROUND(AVG(CAST(age AS FLOAT)), 1) AS avg_age, 
    SUM(salary) AS total_salary, 
    ROUND(AVG(performance_rating), 2) AS avg_performance 
FROM Employees 
GROUP BY department
ORDER BY total_employees DESC;
