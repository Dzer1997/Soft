CREATE DEFINER=`root`@`%` FUNCTION `getTotalWins`(player_id int) RETURNS int
    DETERMINISTIC
BEGIN
	DECLARE total_wins INT;
    
    SELECT COUNT(*) INTO total_wins 
    FROM Matches 
    WHERE winner_id = player_id;
    
    RETURN total_wins;
END