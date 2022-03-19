# Set 3 [Tingueu valor. Encara tenim el nostre clan. Sempre hi ha esperança]

--Consulta 1: Llistar clans (nom i descripció) + num jugadors > 200000 exp + filtar per trofeus desc

SELECT c.clan_name, c.description, COUNT(j.id_player) AS players
FROM clan AS c JOIN joins AS j ON j.id_clan = c.id_clan
JOIN player AS p ON j.id_player = p.id_player
WHERE p.exp > 200000
AND c.num_min_trophy = 
	(SELECT MAX(num_min_trophy) FROM clan)
GROUP BY clan_name, description
ORDER BY players DESC;

--Validació EXP
SELECT c.clan_name AS clan, j.id_player AS player, p.exp AS exp
FROM clan AS c JOIN joins AS j ON j.id_clan = c.id_clan
JOIN player AS p ON j.id_player = p.id_player
ORDER BY clan DESC, exp DESC;

--Validació MAX_TROPHIES
SELECT clan_name, num_min_trophy AS required_trophies
FROM clan
ORDER BY num_min_trophy DESC;

--Consulta 3:

SELECT DISTINCT b.id_battle, b.datetime As start_date, b.duration
FROM battle AS b JOIN fight AS f ON b.clan_battle = f.clan_battle
JOIN clan AS c ON f.id_clan = c.id_clan
WHERE b.datetime > date('01.01.21')
AND c.num_min_trophy > 6900
ORDER BY b.duration DESC
LIMIT 5;

--Consulta 5:

SELECT DISTINCT c.clan_name, c.description, c.num_min_trophy
FROM clan AS c JOIN joins AS j ON j.id_clan = c.id_clan
JOIN role AS r ON r.id_role = j.id_role
JOIN player AS p ON p.id_player = j.id_player
WHERE r.description LIKE '%coLeader%'
AND p.exp > 200000
ORDER BY c.num_min_trophy ASC;
