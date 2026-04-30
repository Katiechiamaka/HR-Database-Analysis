 -- Testing some Queries
-- Checking employees name ending with the letter A(Wildcard)
SELECT emp_name
FROM employees
WHERE emp_name LIKE '%A';

-- Checking employees which the letter "E" as the secound letter in their name
SELECT emp_name
FROM employees
WHERE emp_name LIKE '_e%';

-- Checking salary ranges
SELECT 
    ROUND(AVG(salary), 2) AS avg_salary,
    MAX(salary) AS highest_salary,
    MIN(salary) AS lowest_salary
FROM payroll;

## Querying random questions

## The "Big Picture" Roster
-- 1. List of all employees, their roles, and their specific departments?
SELECT e.emp_name AS Employees_Name,
	   e.emp_role AS Role,
       d.department AS Department
FROM employees e
JOIN department d
ON e.emp_id = d.employee_id
;

## Salary Leaderboard
-- 2. Who are the top 5 highest-paid employees in the company?
SELECT emp_id AS Employees_ID,
	   emp_name AS Name,
       emp_role AS Role,
	   emp_salary AS salary
FROM employees
ORDER BY salary DESC
LIMIT 5;

## Departmental Headcount
-- 3. How many employees are assigned to each department?
SELECT *
FROM employees;

SELECT *
FROM department;

SELECT d.department,
	   COUNT(emp_id) AS Total_staff
FROM employees e
JOIN department d
ON e.emp_id = d.employee_id
GROUP BY department
ORDER BY Total_staff DESC;


## Total Compensation Analysis
-- 4. What is the total "Take Home" pay (Salary + Bonus) for every employee?

SELECT *
FROM employees;

SELECT *
FROM payroll;

SELECT  e.emp_id,
		e.emp_name AS Employee_Name,
		(p.salary + p.bonus) AS Net_salary,
        p.paycheck_id
FROM employees e
JOIN payroll p
ON e.emp_id = p.emp_id
ORDER BY Net_salary DESC;


## Age Demographics (The "Veteran" Check)
-- 5. How old is each employee, and who is the oldest person on the team?
SELECT *
FROM employees;

SELECT *
FROM department;

SELECT 
    emp_name, 
    emp_date_of_birth,
    TIMESTAMPDIFF(YEAR, emp_date_of_birth, CURDATE()) AS Age
FROM employees
ORDER BY Age DESC;

## Regional Footprint
-- 6. Which geographical locations have the highest concentration of staff?
SELECT *
FROM employees;

SELECT *
FROM location;

SELECT 
    d.location, COUNT(l.location_id) AS No_of_staffs
FROM
    department d
INNER JOIN
    location l ON d.employee_id = l.employee_id
GROUP BY d.location
ORDER BY No_of_staffs DESC;

## Average Pay by Role
-- 7. What is the average salary for each specific role within the company?
SELECT *
FROM employees;

SELECT 
	emp_role,
    ROUND(AVG(emp_salary),2) AS avg_salary
FROM employees
GROUP BY emp_role
ORDER BY avg_salary DESC;


## Bonus vs. Base Salary Ratio
-- 8. Which employees are receiving a bonus that is more than 15% of their base salary?
SELECT *
FROM employees;

SELECT *
FROM payroll;

SELECT 
    e.emp_name, 
    p.salary, 
    p.bonus,
    (p.bonus / p.salary) * 100 AS bonus_percentage
FROM employees e
INNER JOIN payroll p
ON e.emp_id = p.emp_id
WHERE (p.bonus / p.salary) > 0.15
ORDER BY bonus_percentage DESC;



