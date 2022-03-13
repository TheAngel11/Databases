-- Set 5 [Preguntes creuades]

-- Creuada 1
--Select
SELECT COUNT(j.id_player) AS num_players
FROM joins AS j 
WHERE j.id_role =
	(SELECT ro.id_role FROM role AS ro 
	 WHERE ro.description LIKE 'elder%')
GROUP BY j.id_clan
ORDER BY num_players DESC
LIMIT 5;

-- Validació

SELECT j.id_clan, COUNT(j.id_player) AS num_players
FROM joins AS j 
WHERE j.id_role = 
	(SELECT ro.id_role FROM role AS ro 
	 WHERE ro.description LIKE 'elder%')
GROUP BY j.id_clan
ORDER BY num_players DESC
LIMIT 5;

SELECT j.id_clan, j.id_player, j.id_role, ro.description
FROM role AS ro JOIN joins AS j ON j.id_role = ro.id_role
WHERE j.id_clan LIKE '#L0QPV'
AND ro.description LIKE 'elder%';

-- 3) Llistar els 10 primers jugadors amb experiència superior a 100.000 que han creat més
-- piles i han guanyat batalles a la temporada T7.
SELECT p.id_player, p.name, p.exp, COUNT(s.id_stack) AS stacks_created
FROM player AS p INNER JOIN stack AS s ON p.id_player = s.id_player
WHERE p.exp > 100000
AND p.id_player IN
    (
    SELECT winner FROM takes_place AS tp
        INNER JOIN battle AS b ON tp.id_battle = b.id_battle
        INNER JOIN player AS p ON p.id_player = b.winner
    WHERE id_season LIKE 'T7'
    GROUP BY winner
    ORDER BY COUNT(*) DESC
    )
GROUP BY p.id_player, p.name, p.exp
ORDER BY stacks_created DESC
LIMIT 10;


--Creuada 5: id_batalla+ duracio + start_date + end_date
-- on la descripcio no contingui Chuck Noris + durada < AVG(durada)

SELECT b.id_battle, b.duration, cb.start_date, cb.end_date
FROM battle AS b JOIN clan_battle AS cb ON b.clan_battle = cb.clan_battle
JOIN fight AS f ON f.clan_battle = cb.clan_battle
WHERE f.id_clan NOT IN (SELECT id_clan FROM clan WHERE description LIKE '%Chuck Norris%')
AND b.duration < (SELECT AVG(duration) FROM battle);

--Validació

SELECT id_clan, description 
FROM clan 
WHERE description LIKE '%Chuck Norris%';

SELECT AVG(duration) FROM battle;

SELECT b.id_battle, b.duration, cb.start_date, cb.end_date, f.id_clan
FROM battle AS b JOIN clan_battle AS cb ON b.clan_battle = cb.clan_battle
JOIN fight AS f ON f.clan_battle = cb.clan_battle
WHERE f.id_clan NOT IN (SELECT id_clan FROM clan WHERE description LIKE '%Chuck Norris%')
AND b.duration < (SELECT AVG(duration) FROM battle);


--Creuada 6: nom + exp de player + amb clan amb tecnologia Militar + comprar
--TO DO: Add buy part
SELECT p.id_player, p.exp
FROM player AS p JOIN joins AS j ON p.id_player = j.id_player
WHERE id_clan IN
	(SELECT DISTINCT m.id_clan
	FROM modify AS m JOIN technology AS t 
	ON m.name_modifier = t.name_technology
	WHERE m.name_modifier LIKE '%Militar%')
ORDER BY p.exp DESC;
