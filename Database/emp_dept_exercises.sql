-- 1 Queries on one table

-- Find all information about all departments */
Select * from dept;
-- Find the employee number (empno) for employees named MARTIN. 
Select empno from emp where ename = 'MARTIN';
-- Find employees (all info) with a salary greater than 1500.
Select * from emp where sal >= 1500;
-- Find all employee names that starts with S. 
Select ename from emp where ename like 'S%';
-- Find the names of salesmen that earn more than 1300
Select ename, sal from emp where sal > 1300;
-- Find the names of employees that are not salesmen
Select ename, job from emp where job != 'SALESMAN';
-- Find the names of all clerks together with their salary if they had a 10 % deduction (no real update)
Select ename, job,sal ,sal * 0.90 from emp where job = 'CLERK';
-- Find the name of employees hired in 1981
Select ename, hiredate from emp where year(hiredate) = 1981;
-- Find name and job for employees whose name ends with ‘s’.
Select ename, job from emp where ename like '%s';
-- Find employees sorted by name.
Select ename from emp order by ename;
-- Find employees sorted by salary in descending order (i.e. highest salary first)
Select ename, sal from emp order by sal desc;
-- Find name of employee without a manager (i.e. the CEO)
Select ename, job from emp where job !='MANAGER';
-- Find department names sorted by location
Select dname, loc from dept order by loc;
-- Find name of department located in New York
Select dname, loc from dept where loc = 'NEW YORK';

-- 2 Aggregate functions

-- Find the number of employees in the company
Select COUNT(ename) FROM emp;
-- Find the sum of all salaries (excluding commission)
Select SUM(sal) from emp;
-- Find the average salary for employees in department number 20

-- Find the name and salary for employees that earn more than company average

-- Find the unique job titles in the company

-- Find the number of employees in each department

-- Find the number of employees in departments with more than four employees

-- Find in decreasing order the maximum salary in each department together with the department number

-- Find total sum of salary and commission for all employees