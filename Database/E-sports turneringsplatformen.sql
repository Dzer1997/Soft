-- Udarbejd SQL-forespørgsler til følgende:
-- 1. Hent alle turneringer, der starter inden for de næste 30 dage.
SELECT * from Tournaments where start_date between now() And date_add(now(),interval 30 day);
-- 2. Find det antal turneringer, en spiller har deltaget.
Select player_id, count(tournament_id) As total_cout_tournaments from Tournament_Registrations group by player_id;
-- 3. Vis en liste over spillere registreret i en bestemt turnering.
select p. * from Players p Join Tournament_Registrations tr on p.player_id = tr.player_id where tr.tournament_id=1;
-- 4. Find spillere med flest sejre i en bestemt turnering.
SELECT P.player_id, P.username, COUNT(M.winner_id) AS win_count  
FROM Players P  
JOIN Matches M ON P.player_id = M.winner_id  
WHERE M.tournament_id = 1  -- HER KAN VI SKRIVE ID 
GROUP BY P.player_id, P.username  
ORDER BY win_count DESC  
LIMIT 1;
-- 5. Hent alle kampe, hvor en bestemt spiller har deltaget.
Select * from Matches where player1_id= 1 or player2_id = 1;
-- 6. Hent en spillers tilmeldte turneringer
Select t.* from Tournaments t join  Tournament_Registrations tr on T.tournament_id = TR.tournament_id  where tr.player_id =1;
-- 7. Find de 5 bedst rangerede spillere.
Select * from Players order by ranking desc limit 5;
-- 8. Beregn gennemsnitlig ranking for alle spillere.
SELECT AVG(ranking) AS average_ranking FROM players;
-- 9. Vis turneringer med mindst 5 deltagere.
SELECT t.tournament_id, t.name, t.game, t.max_players, t.start_date, COUNT(tr.player_id) AS total_players
FROM Tournaments t
JOIN Tournament_Registrations tr ON t.tournament_id = tr.tournament_id
GROUP BY t.tournament_id
HAVING COUNT(tr.player_id) >= 5; 
-- 10. Find det samlede antal spillere i systemet.
select COUNT(*) as total_players from Players;
-- 11. Find alle kampe, der mangler en vinder.
Select * from Matches where winner_id IS NULL;
-- 12. Vis de mest populære spil baseret på turneringsantal.
SELECT game, COUNT(*) AS total_tournaments
FROM Tournaments GROUP BY game ORDER BY total_tournaments DESC;
-- 13. Find de 5 nyeste oprettede turneringer.
SELECT * FROM Tournaments ORDER BY created_at DESC LIMIT 5;
-- 14. Find spillere, der har registreret sig i flere end 3 turneringer.
SELECT p.player_id, p.username, COUNT(tr.tournament_id) AS total_tournaments
FROM Players p
JOIN Tournament_Registrations tr ON p.player_id = tr.player_id
GROUP BY p.player_id, p.username
HAVING COUNT(tregisterPlayerr.tournament_id) > 3;
-- 15. Hent alle kampe i en turnering sorteret efter dato.
Select m.match_date from Matches m Join Tournament_Registrations tr ON m.tournament_id = tr.tournament_id order by tr.registered_at;                                                                                                                                                                                                                                        v
