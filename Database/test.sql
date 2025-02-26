CREATE FUNCTION `dept_count` (dept_name VARCHAR(20))
RETURNS INT
deterministic
BEGIN
	declare d_count int;
    select COUNT(*) into d_count
    from instructor
    WHERE instructor.dept_name = dept_name;
RETURN 1;
END
