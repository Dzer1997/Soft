#Function Exercise 1A
SELECT dept_name, budget FROM department where test(dept_name) > 1;

#Function Exercise 1b
select d.dept_name, budget from department d join instructor i on d.dept_name = i.dept_name
group by d.dept_name
having COUNT(*) > 1;

#Function Exercise 2
select salary_category(95000.00) as salaryLevel;

#Procedure example 1
call getInstructorsByDept('Computer Science');

#Procedure example 2
call dept_count_proc('Computer Science', @d_count);
SELECT @d_count AS InstructorCount;

#Procedure example 3 with update
CALL giveSalaryRaise('Computer Science', 2.5);

#Procedure example 4 with erro handling

