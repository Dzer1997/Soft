CREATE DEFINER=`root`@`localhost` FUNCTION `getTournamentStatus`(tournament_id INT) RETURNS varchar(10) CHARSET utf8mb4
    DETERMINISTIC
BEGIN
    DECLARE status_value VARCHAR(10);
    DECLARE tournament_start DATE DEFAULT NULL;
    DECLARE matches_remaining INT DEFAULT 0;

    -- Hent startdatoen for turneringen
    SELECT start_date INTO tournament_start 
    FROM Tournaments 
    WHERE tournament_id = tournament_id
    LIMIT 1;

    -- Hvis der ikke findes en turnering, returnér NULL
    IF tournament_start IS NULL THEN
        RETURN 'unknown';
    END IF;

    -- Hvis turneringen er i fremtiden, er den "upcoming"
    IF NOW() < tournament_start THEN
        SET status_value = 'upcoming';
    ELSE
        -- Tjek hvor mange kampe i turneringen der mangler en vinder
        SELECT COUNT(*) INTO matches_remaining
        FROM Matches 
        WHERE tournament_id = tournament_id AND winner_id IS NULL;

        -- Hvis der stadig er kampe uden en vinder, er den "ongoing"
        IF matches_remaining > 0 THEN
            SET status_value = 'ongoing';
        ELSE
            SET status_value = 'completed';
        END IF;
    END IF;

    RETURN status_value;
END