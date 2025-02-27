-- Set 4 [M'agrada la competició. M'agraden els reptes...]

-- 1. Enumera el nom, els trofeus mínims, els trofeus màxims de les arenes que el seu títol
-- comença per "A" i tenen un paquet d’arena amb or superior a 8000.
SELECT DISTINCT max_trophies, min_trophies FROM sand
    INNER JOIN belongs b on sand.id = b.id_sand
    INNER JOIN sand_pack sp on b.id_sand_pack = sp.id_sand_pack
    WHERE b.gold_contained > 8000 AND sand.title LIKE 'A%';

-- Validation
SELECT * FROM belongs WHERE gold_contained > 8000;
SELECT * FROM sand WHERE id = 54000013;
SELECT DISTINCT max_trophies, min_trophies FROM sand
    INNER JOIN belongs b on sand.id = b.id_sand
    INNER JOIN sand_pack sp on b.id_sand_pack = sp.id_sand_pack
    WHERE b.gold_contained > 8000 AND sand.title LIKE 'A%' AND sand.id = 54000013;


-- 2. Llista de nom, data d'inici, data de finalització de les temporades i, de les batalles
-- d'aquestes temporades, el nom del jugador guanyador si el jugador té més victòries que
-- derrotes i la seva experiència és més gran de 200.000
SELECT DISTINCT s.id_name AS season_name, s.start_date, s.end_date, p.name AS player FROM battle
    INNER JOIN takes_place tp on battle.id_battle = tp.id_battle
    INNER JOIN season s on tp.id_season = s.id_name
    INNER JOIN player p ON p.id_player = battle.winner OR p.id_player = battle.loser
WHERE p.exp > 200000
GROUP BY p.name, s.id_name, s.start_date, s.end_date
HAVING COUNT(DISTINCT battle.winner) > COUNT(DISTINCT battle.loser);

-- Validation
SELECT s.id_name, player.id_player FROM player
INNER JOIN battle ON player.id_player = battle.winner OR player.id_player = battle.loser
INNER JOIN takes_place t on battle.id_battle = t.id_battle
INNER JOIN season s on t.id_season = s.id_name
GROUP BY player.id_player, s.id_name
HAVING COUNT(DISTINCT battle.winner) > COUNT(DISTINCT battle.loser);

SELECT * FROM player WHERE id_player = '#209GRYYL0';

SELECT DISTINCT s.id_name AS season_name, s.start_date, s.end_date, p.name AS player FROM battle
    INNER JOIN takes_place tp on battle.id_battle = tp.id_battle
    INNER JOIN season s on tp.id_season = s.id_name
    INNER JOIN player p ON p.id_player = battle.winner OR p.id_player = battle.loser
WHERE p.exp > 200000
AND id_player = '#209GRYYL0'
GROUP BY p.name, s.id_name, s.start_date, s.end_date
HAVING COUNT(DISTINCT battle.winner) > COUNT(DISTINCT battle.loser);

-- 3. Llistar la puntuació total dels jugadors guanyadors de batalles de cada temporada. Filtrar
-- la sortida per considerar només les temporades que han començat i acabat el 2019
SELECT season.id_name, player.id_player, player.name, SUM(battle.points) AS total_points
FROM takes_place
INNER JOIN battle ON takes_place.id_battle = battle.id_battle
INNER JOIN season ON takes_place.id_season = season.id_name
INNER JOIN player ON battle.winner = player.id_player
WHERE season.start_date <= '2019-12-31' AND season.end_date >= '2019-01-01'
GROUP BY season.id_name, player.id_player, player.name
ORDER BY total_points DESC;

-- 4. Enumerar els noms de les arenes en què els jugadors veterans (experiència superior a
-- 170.000) van obtenir insígnies després del "25-10-2021". Ordenar el resultat segons el
-- nom de l’arena en ordre ascendent.
SELECT DISTINCT sand.title FROM sand
    INNER JOIN frees ON frees.id_sand = sand.id
    INNER JOIN player ON player.id_player = frees.id_player
WHERE player.exp > 170000
    AND frees.date > TO_DATE('25/10/2021', 'DD/MM/YYYY')
ORDER BY sand.title;

-- 5. Enumerar el nom de la insígnia, els noms de les cartes i el dany de les cartes dels
-- jugadors amb una experiència superior a 290.000 i obtingudes en arenes el nom de les
-- quals comença per "A" o quan la insígnia no té imatge. Així, considera només els
-- jugadors que tenen una carta el nom de la qual comença per "Lava".
SELECT sand.title AS sand_title, player.name AS player_name, frees.id_badge AS badge_name, card.id_card_name AS card_name, card.damage AS card_damage FROM sand
    INNER JOIN frees ON sand.id = frees.id_sand
    INNER JOIN player ON frees.id_player = player.id_player
    INNER JOIN card ON card.sand = sand.id
WHERE player.exp > 290000 AND card.id_card_name IN
    (SELECT id_card_name FROM card INNER JOIN sand s ON card.sand = s.id WHERE s.title LIKE 'A%') -- cartes obtingudes en arenes que comencen per A
AND player.id_player IN
    (SELECT DISTINCT id_player FROM player INNER JOIN owns ON player.id_player = owns.player WHERE owns.card LIKE 'Lava%'); -- id's de jugadors que tenen cartes que comencen per Lava

-- 6.Donar el nom de les missions que donen recompenses a totes les arenes el títol de les
-- quals comença per "t" o acaba per "a". Ordena el resultat pel nom de la missió.
SELECT DISTINCT m.title FROM sand
    INNER JOIN accepts a ON sand.id = a.id_sand
    INNER JOIN mission m ON a.id_mission = m.id_mission
WHERE m.title LIKE 'T%' OR m.title LIKE 'a%'
ORDER BY m.title;

-- Validation

SELECT * FROM mission WHERE title = 'Talbot';

SELECT mission.title, mission.id_mission, accepts.id_sand, sand.title FROM mission
    INNER JOIN accepts ON mission.id_mission = accepts.id_mission
    INNER JOIN sand ON accepts.id_sand = sand.id
WHERE mission.title = 'Talbot' AND sand.title LIKE 'T%';

-- 7. Donar el nom de les arenes amb jugadors que al novembre o desembre de 2021 van
-- obtenir insígnies si el nom de l’arena conté la paraula "Lliga", i les arenes tenen jugadors
-- que al 2021 van obtenir èxits el nom dels quals conté la paraula "Friend".
SELECT * FROM sand WHERE sand.id IN (
    SELECT s.id FROM sand s INNER JOIN frees f on s.id = f.id_sand
    WHERE date > TO_DATE('30/09/2021', 'DD/MM/YYYY')
      AND date < TO_DATE('01/01/2022', 'DD/MM/YYYY')
        AND s.title LIKE '%Lliga%') AND sand.id IN (
            SELECT DISTINCT id_sand FROM frees f
                INNER JOIN sand s ON f.id_sand = s.id
            WHERE f.id_player IN (
                SELECT player.id_player
                FROM player
                    INNER JOIN obtains o on player.id_player = o.id_player
                WHERE date > TO_DATE('31/12/2020', 'DD/MM/YYYY')
                    AND date < TO_DATE('01/01/2022', 'DD/MM/YYYY')
                AND o.id_success LIKE '%Friend%'
        ));

-- Validation
SELECT * FROM sand s INNER JOIN frees f on s.id = f.id_sand
    WHERE date > TO_DATE('30/09/2021', 'DD/MM/YYYY')
      AND date < TO_DATE('01/01/2022', 'DD/MM/YYYY')
        AND s.title LIKE '%Lliga%';

SELECT DISTINCT * FROM frees f
                INNER JOIN sand s ON f.id_sand = s.id
            WHERE f.id_player IN ( -- jugadors que van obtenir exists al 2021
                SELECT player.id_player
                FROM player
                    INNER JOIN obtains o on player.id_player = o.id_player
                WHERE date > TO_DATE('31/12/2020', 'DD/MM/YYYY')
                    AND date < TO_DATE('01/01/2022', 'DD/MM/YYYY')
                AND o.id_success LIKE '%Friend%');

SELECT * FROM sand WHERE sand.id = 54000059 AND sand.id IN (
    SELECT s.id FROM sand s INNER JOIN frees f on s.id = f.id_sand
    WHERE date > TO_DATE('30/09/2021', 'DD/MM/YYYY')
      AND date < TO_DATE('01/01/2022', 'DD/MM/YYYY')
        AND s.title LIKE '%Lliga%') AND sand.id IN (
            SELECT DISTINCT id_sand FROM frees f
                INNER JOIN sand s ON f.id_sand = s.id
            WHERE f.id_player IN (
                SELECT player.id_player
                FROM player
                    INNER JOIN obtains o on player.id_player = o.id_player
                WHERE date > TO_DATE('31/12/2020', 'DD/MM/YYYY')
                    AND date < TO_DATE('01/01/2022', 'DD/MM/YYYY')
                AND o.id_success LIKE '%Friend%'
        ));

-- 8. Retorna el nom de les cartes que pertanyen a jugadors que van completar missions el
-- nom de les quals inclou la paraula "Armer" i l'or de la missió és més gran que l'or mitjà
-- recompensat en totes les missions de les arenes.
SELECT DISTINCT c.id_card_name FROM card c
    INNER JOIN owns o on c.id_card_name = o.card
    INNER JOIN player p on o.player = p.id_player
WHERE id_player IN (
    SELECT a.id_player FROM player p
    INNER JOIN accepts a on p.id_player = a.id_player
    INNER JOIN mission m ON a.id_mission = m.id_mission
    INNER JOIN sand s ON s.id = a.id_sand
WHERE s.reward_in_gold > (SELECT AVG(sand.reward_in_gold) FROM sand)
AND m.title LIKE '%Armer%'
    );


SELECT * FROM mission WHERE title LIKE '%Armer%';
SELECT * FROM player p INNER JOIN accepts a on p.id_player = a.id_player WHERE a.id_mission = 201;
SELECT AVG(sand.reward_in_gold) FROM sand;

SELECT DISTINCT c.id_card_name, o.player FROM card c
    INNER JOIN owns o on c.id_card_name = o.card
    INNER JOIN player p on o.player = p.id_player
WHERE id_player IN (
    SELECT a.id_player FROM player p
    INNER JOIN accepts a on p.id_player = a.id_player
    INNER JOIN mission m ON a.id_mission = m.id_mission
    INNER JOIN sand s ON s.id = a.id_sand
WHERE s.reward_in_gold > (SELECT AVG(sand.reward_in_gold) FROM sand)
AND m.title LIKE '%Armer%'
    )
AND id_player = '#Y08PCY8P2';