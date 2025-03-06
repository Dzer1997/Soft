CREATE DEFINER=`root`@`%` PROCEDURE `submitMatchResult`(
    smr_tournament_id int,
    smr_player1_id int,
    smr_player2_id int,
    smr_winner_id int,
    smr_match_date datetime
)
    DETERMINISTIC
BEGIN
	insert into Matches (tournament_id, player1_id,player2_id,winner_id,match_date) values
    (smr_tournament_id,smr_player1_id, smr_player2_id, smr_winner_id,smr_match_date);
END