-- Set 5 [Preguntes creuades]

-- Creuada 1: Mostrar el nombre de jugadors que té cada clan, però només considerant els jugadors
--amb nom de rol que contingui el text "elder". Restringir la sortida per als 5 primers clans
--amb més jugadors.
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

-- 2.Mostrar el nom dels jugadors, el text dels missatges i la data dels missatges enviats pels jugadors
-- que tenen la carta Skeleton Army i han comprat articles abans del 01-01-2019.
SELECT p.name, m.issue AS message, m.datetime FROM player p INNER JOIN message m on p.id_player = m.id_owner
WHERE p.id_player IN (
    SELECT DISTINCT p.id_player FROM player p
        INNER JOIN owns o ON p.id_player = o.player
    WHERE o.card = 'Skeleton Army')
AND p.id_player IN (SELECT p.id_player FROM player p
    INNER JOIN pays pa ON p.id_player = pa.id_player
    INNER JOIN article a on pa.id_article = a.id_article
WHERE pa.datetime < '2019-01-01');

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

--Creuada 5: Mostrar la identificació de les batalles, la durada, la data d'inici i la data
--de finalització dels clans que la seva descripció no contingui el text "Chuck Norris".
--Considera només les batalles amb una durada inferior a la durada mitjana de totes les batalles.

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


--Creuada 6: Enumerar el nom i l'experiència dels jugadors que pertanyen a un clan que
--té una tecnologia el nom del qual conté la paraula "Militar" i aquests jugadors havien
--comprat el 2021 més de 5 articles.

SELECT p.id_player, p.exp
FROM player AS p JOIN joins AS j ON p.id_player = j.id_player
WHERE id_clan IN
	(SELECT DISTINCT inv.id_clan
	FROM investigates AS inv JOIN technology AS t
	ON inv.name_modifier = t.name_technology
	WHERE inv.name_modifier LIKE '%Militar%')
AND p.id_player IN
	(SELECT id_player FROM pays
	WHERE '2021' = EXTRACT(YEAR FROM datetime)
	GROUP BY id_player HAVING COUNT(id_article) > 5);

--Validació

SELECT id_player, COUNT(id_article) FROM pays
WHERE '2021' = EXTRACT(YEAR FROM datetime)
GROUP BY id_player
ORDER BY COUNT(id_article) DESC;

SELECT DISTINCT inv.id_clan
FROM investigates AS inv JOIN technology AS t
ON inv.name_modifier = t.name_technology
WHERE inv.name_modifier LIKE '%Militar%';

SELECT id_clan, id_player
FROM joins
WHERE id_player IN
	(SELECT id_player FROM pays
	WHERE '2021' = EXTRACT(YEAR FROM datetime)
	GROUP BY id_player HAVING COUNT(id_article) > 5);

-- 7. Indiqueu el nom dels jugadors que tenen
-- totes les cartes amb el major valor de dany.
/*Consulta*/
SELECT player.name FROM player
WHERE player.id_player IN (
SELECT player FROM (
SELECT owns.player, COUNT(DISTINCT owns.card) AS number FROM owns
WHERE owns.card IN (SELECT id_card_name FROM card
WHERE card.damage = (SELECT MAX(damage) FROM card))
GROUP BY owns.player
HAVING COUNT(DISTINCT owns.card) = (SELECT COUNT(id_card_name) FROM card
WHERE card.damage = (SELECT MAX(damage) FROM card))) AS player)
ORDER BY player.name;

/*Validacio*/
SELECT card.id_card_name
FROM card
WHERE card.damage =
(SELECT card.damage FROM card
ORDER BY card.damage DESC
LIMIT 1);

SELECT player.name
FROM player
JOIN owns ON owns.player = player.id_player
JOIN card ON card.id_card_name = owns.card
WHERE card.id_card_name LIKE 'Fisherman'
ORDER BY player.name;


-- 8. Retorna el nom de les cartes i el dany, que pertanyen a les piles el nom de les quals
-- conté la paraula "Madrid" i van ser creats per jugadors amb experiència superior a
-- 150.000. Considereu només les cartes amb dany superior a 200 i els jugadors que van
-- aconseguir un èxit en el 2021. Enumera el resultat des dels valors més alts del nom de
-- la carta fins als valors més baixos del nom de la carta.
SELECT DISTINCT c.id_card_name AS card_name, c.damage AS damage
FROM card AS c
JOIN "group" AS g ON g.card_name = c.id_card_name
JOIN stack AS s ON g.id_stack = s.id_stack
JOIN player AS p ON p.id_player = s.id_player
JOIN obtains AS o ON p.id_player = o.id_player
WHERE s.name LIKE '%Madrid%' AND p.exp > 150000 AND c.damage > 200 AND '2021' = EXTRACT(YEAR FROM o.date)
ORDER BY c.id_card_name DESC;

--1r mirem que les cartes tinguin amb exit al 2021 i el nom de les piles conté madrid
SELECT DISTINCT c.id_card_name AS card_name,
			EXTRACT(YEAR FROM obt.date) AS exit_date
FROM card AS c
JOIN owns ON owns.card = c.id_card_name
JOIN player AS p ON p.id_player = owns.player
JOIN obtains AS obt ON p.id_player = obt.id_player
WHERE c.damage > 200 AND '2021' = EXTRACT(YEAR FROM obt.date)
ORDER BY c.id_card_name DESC;

--2n mirem que el nom de les piles conté "Madrid" i que van ser creades per jugadors amb +150.000 exp.
SELECT DISTINCT c.id_card_name AS card_name, s.name, p.exp
FROM card AS c
JOIN "group" AS g ON g.card_name = c.id_card_name
JOIN stack AS s ON g.id_stack = s.id_stack
JOIN player AS p ON p.id_player = s.id_player
WHERE s.name LIKE '%Madrid%' AND p.exp > 150000
ORDER BY p.exp ASC;

-- 9) Enumerar el nom, l’experiència i el nombre de trofeus dels jugadors que no han comprat res. Així, el nom,
-- l'experiència i el número de trofeus dels jugadors que no han enviat cap missatge.
-- Ordenar la sortida de menor a més valor en el nom del jugador.
SELECT player.name, player.exp, player.trophies FROM player WHERE id_player IN (
    SELECT player.id_player FROM player
        FULL JOIN pays ON player.id_player = pays.id_player
    WHERE pays.id_player IS NULL)
OR player.id_player IN (
    SELECT player.id_player FROM player
        FULL JOIN message ON player.id_player = message.id_owner
    WHERE message.id_owner IS NULL)
ORDER BY player.name;

-- Validation
SELECT * FROM pays WHERE id_player = '#LYG9QGGQ'; -- 0 results
SELECT * FROM message WHERE id_owner = '#9UUC9L280'; -- 0 results

-- 10.Llistar les cartes comunes que no estan incloses en cap pila i que pertanyen a jugadors
-- amb experiència superior a 200.000. Ordena la sortida amb el nom de la carta.
/*Consulta*/
SELECT DISTINCT c.id_card_name AS card_name, c.damage
FROM card AS c
JOIN rarity AS r ON  c.rarity = r.degree
LEFT JOIN "group" AS g ON g.card_name = c.id_card_name
LEFT JOIN stack AS s ON g.id_stack = s.id_stack
JOIN owns AS o ON c.id_card_name = o.card
JOIN player AS p ON p.id_player = o.player
WHERE r.degree LIKE 'Common' AND p.exp > 200000
GROUP BY c.id_card_name HAVING COUNT(g.card_name) = 0
ORDER BY card_name;

/*Validacio*/
--1r comprovem si hi ha alguna carta que no esta inclosa a cap pila
SELECT c.id_card_name AS card_name, COUNT(g.card_name) AS card_num
FROM card AS c
LEFT JOIN "group" AS g ON g.card_name = c.id_card_name
GROUP BY c.id_card_name
ORDER BY card_num ASC;

--2n, com no hi ha cap carta inclose en cap pila, per validar l'opcio fem un insert de una carta que compleixi els requisits de l'enunciat
INSERT INTO card (id_card_name, damage, attack_speed, rarity, sand)
VALUES ('carta_validacio', 190, 55, 'Common', 54000048);

INSERT INTO owns (card, level, player, date_found, date_level_up, experience_gained)
VALUES ('carta_validacio', 2,'#8C8QJR9JG', '2022-03-03', '2022-03-04', 4000);
