CREATE DEFINER=`root`@`%` PROCEDURE `registerPlayer`(
p_username varchar(50),
p_email varchar(50),
p_ranking int)
    DETERMINISTIC
BEGIN
	insert into Players (username,email,ranking) values
    (p_username, p_email, p_ranking);	
END