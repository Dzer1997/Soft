CREATE DEFINER=`root`@`%` PROCEDURE `joinTournament`(
tr_tournament_id int,
tr_player_id int
)
    DETERMINISTIC
BEGIN
	insert into Tournament_Registrations(tournament_id, player_id) values
    (tr_tournament_id,tr_player_id);	
END