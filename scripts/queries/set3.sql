# Set 3 [Tingueu valor. Encara tenim el nostre clan. Sempre hi ha esperança]

--		CLANS		--
--Consulta 1: Llistar els clans (nom i descripció) i el nombre de jugadors que tenen 
--una experiència superior a 200.000. Filtra la sortida per tenir els clans amb més trofeus requerits.

SELECT c.clan_name, c.description, COUNT(j.id_player) AS players
FROM clan AS c JOIN joins AS j ON j.id_clan = c.id_clan
JOIN player AS p ON j.id_player = p.id_player
WHERE p.exp > 200000
AND c.num_min_trophy = 
	(SELECT MAX(num_min_trophy) FROM clan)
GROUP BY clan_name, description
ORDER BY players DESC;

--Validació:

SELECT c.clan_name AS clan, j.id_player AS player, p.exp AS exp
FROM clan AS c JOIN joins AS j ON j.id_clan = c.id_clan
JOIN player AS p ON j.id_player = p.id_player
ORDER BY clan DESC, exp DESC;


SELECT clan_name, num_min_trophy AS required_trophies
FROM clan
ORDER BY num_min_trophy DESC;

-- Consulta 2: Llistar els 15 jugadors amb més experiència, la seva experiència i el nom del clan 
--que pertany si el clan que ha investigat una tecnologia amb un cost superior a 1000.

SELECT p.name, p.exp, j.id_clan
FROM player AS p LEFT JOIN joins AS j ON j.id_player = p.id_player
WHERE j.id_clan IN 
	(SELECT DISTINCT id_clan
	 FROM investigates AS inv JOIN modifier AS mo ON inv.name_modifier = mo.name_modifier
	 JOIN technology AS t ON inv.name_modifier = t.name_technology
	WHERE mo.cost > 1000)
ORDER BY p.exp DESC
LIMIT 15;

--Validació: 

SELECT p.name, p.exp
FROM player AS p 
ORDER BY p.exp DESC;

SELECT DISTINCT id_clan
FROM investigates AS inv JOIN modifier AS mo ON inv.name_modifier = mo.name_modifier
JOIN technology AS t ON inv.name_modifier = t.name_technology
WHERE mo.cost > 1000
ORDER BY id_clan DESC);

--Consulta 3: Enumera l’identificador, la data d'inici i la durada de les batalles que van 
--començar després del "01-01-2021" i en què van participar clans amb trofeus mínims superiors a
--6900. Donar només 5 batalles amb la major durada.

SELECT DISTINCT b.id_battle, b.datetime AS start_date, b.duration
FROM battle AS b JOIN fight AS f ON b.clan_battle = f.clan_battle
JOIN clan AS c ON f.id_clan = c.id_clan
WHERE b.datetime > date('01.01.21')
AND c.num_min_trophy > 6900
ORDER BY b.duration DESC
LIMIT 5;

--Validació:

SELECT DISTINCT b.id_battle, b.datetime, 
b.duration, cl.id_clan, cl.num_min_trophy 
FROM clan AS cl JOIN fight AS f
ON f.id_clan = cl.id_clan
JOIN battle AS b 
ON b.clan_battle = f.clan_battle
WHERE b.datetime > date('01.01.21')
ORDER BY b.duration DESC;

--Consulta 4: Enumera per a cada clan el nombre d'estructures i el cost total d'or. Considera les 
--estructures creades a l'any 2020 i amb trofeus mínims superiors a 1200. Donar només 
--la informació dels clans que tinguin més de 2 estructures 

SELECT inv.id_clan AS clan, COUNT(st.name_structure) AS num_structure, SUM(m.cost) AS total_cost
FROM investigates AS inv JOIN modifier AS m ON inv.name_modifier = m.name_modifier
JOIN structure AS st ON inv.name_modifier = st.name_structure
JOIN clan AS cl ON cl.id_clan = inv.id_clan
WHERE '2020' = EXTRACT(YEAR FROM inv.date)
AND cl.num_min_trophy > 1200
GROUP BY inv.id_clan HAVING COUNT(st.name_structure) > 2;


-- Validació

SELECT id_clan FROM clan WHERE num_min_trophy < 1200;

SELECT inv.id_clan AS clan, COUNT(st.name_structure) AS structure_total, SUM(m.cost) AS cost_total
FROM investigates AS inv JOIN modifier AS m ON inv.name_modifier = m.name_modifier
JOIN structure AS st ON inv.name_modifier = st.name_structure
GROUP BY inv.id_clan
ORDER BY inv.id_clan ASC;

--Consulta 5: Enumera el nom dels clans, la descripció i els trofeus mínims ordenat de
--menor a major nivell de trofeus mínims per als clans amb jugadors que tinguin més de 
--200.000 d’experiència i el rol co-líder.

SELECT DISTINCT c.clan_name, c.description, c.num_min_trophy
FROM clan AS c JOIN joins AS j ON j.id_clan = c.id_clan
JOIN role AS r ON r.id_role = j.id_role
JOIN player AS p ON p.id_player = j.id_player
WHERE r.description LIKE 'coLeader%'
AND p.exp > 200000
ORDER BY c.num_min_trophy ASC;

--Validació 

SELECT cl.clan_name, COUNT(j.id_player)
FROM clan AS cl JOIN joins AS j ON cl.id_clan = j.id_clan
JOIN player AS p ON p.id_player = j.id_player
JOIN role AS ro ON ro.id_role = j.id_role
WHERE ro.description LIKE 'coLeader%' 
AND p.exp > 200000
GROUP BY  cl.clan_name;
	
SELECT p.id_player, p.exp, cl.clan_name, r.description
FROM player AS p JOIN joins AS j ON j.id_player = p.id_player
JOIN role AS r ON r.id_role = j.id_role
JOIN clan AS cl ON cl.id_clan = j.id_clan
WHERE r.description LIKE 'coLeader%'
ORDER BY p.exp DESC;

--Consulta 6: Necessitem canviar algunes dades a la base de dades. Hem d'incrementar un 25% el 
--cost de les tecnologies que utilitzen els clans amb trofeus mínims superiors a la mitjana 
--de trofeus mínims de tots els clans

UPDATE modifier SET cost = cost * 1.25 
WHERE name_modifier IN
(SELECT DISTINCT tech.name_technology FROM technology AS tech 
JOIN investigates AS inv ON tech.name_technology = inv.name_modifier
JOIN clan AS cl ON cl.id_clan = inv.id_clan
WHERE cl.num_min_trophy > (SELECT AVG(num_min_trophy) FROM clan));

-- Validació:

SELECT id_clan, num_min_trophy, 
(SELECT AVG(num_min_trophy) FROM clan) 
FROM clan ORDER BY num_min_trophy DESC;

SELECT COUNT(*) FROM technology;

SELECT DISTINCT tech.name_technology
FROM technology AS tech 
JOIN investigates AS inv ON tech.name_technology = inv.name_modifier
JOIN clan AS cl ON cl.id_clan = inv.id_clan
WHERE cl.num_min_trophy > (SELECT AVG(num_min_trophy) FROM clan)
ORDER BY tech.name_technology ASC;

SELECT DISTINCT tech.name_technology, m.cost
FROM modifier AS m JOIN technology AS tech 
ON tech.name_technology = m.name_modifier
ORDER BY tech.name_technology ASC;



-- Consulta 7: Enumerar el nom i la descripció de la tecnologia utilitzada pels 
--clans que tenen una estructura "Monument" construïda després del "01-01-2021". 
--Ordena les dades segons el nom i la descripció de les tecnologies.

SELECT DISTINCT m.name_modifier, m.description
FROM modifier AS m 
JOIN technology AS t ON t.name_technology = m.name_modifier
JOIN investigates AS inv ON inv.name_modifier = m.name_modifier
WHERE id_clan IN 
	(SELECT inves.id_clan 
	 FROM structure AS st JOIN investigates AS inves 
	 ON inves.name_modifier = st.name_structure
	 WHERE inves.date  > date('01.01.21')
AND st.name_structure LIKE '%Monument%')
ORDER BY name_modifier ASC, description ASC;

--Validació: 

SELECT st.name_structure, inves.date, inves.id_clan 
FROM structure AS st JOIN investigates AS inves 
ON inves.name_modifier = st.name_structure
WHERE inves.date  > date('01.01.21')
AND st.name_structure LIKE '%Monument%';

SELECT COUNT(t.name_technology)
FROM investigates AS inv JOIN technology AS t 
ON t.name_technology = inv.name_modifier
WHERE inv.id_clan IN 
('#28V2QQ9C', '#PV2G9U2L', '#PPCLCJG9', 'P0LLG9RG');

SELECT COUNT(*) FROM technology;

SELECT inv.id_clan, t.name_technology
FROM investigates AS inv JOIN technology AS t ON t.name_technology = inv.name_modifier
WHERE inv.id_clan IN ('#28V2QQ9C', '#PV2G9U2L', '#PPCLCJG9', 'P0LLG9RG')
ORDER BY inv.id_clan, t.name_technology;

-- Consulta 8:Enumera els clans amb un mínim de trofeus superior a 6900 i 
--que hagin participat a totes les batalles de clans.

SELECT cl.id_clan FROM clan AS cl
WHERE NOT EXISTS 
	(SELECT clan_battle FROM clan_battle AS cb 
	WHERE NOT EXISTS 
	 	(SELECT * FROM fight AS f 
		 WHERE cl.id_clan = f.id_clan 
		 AND cb.clan_battle = f.clan_battle));
				 
--Validació

SELECT id_clan FROM clan LIMIT 1; --#8LGRYC

--Seleccionar les batalles d eclans on NO participa
SELECT DISTINCT clan_battle FROM clan_battle AS cb 
WHERE clan_battle NOT IN 
	(SELECT clan_battle FROM fight 
 	WHERE id_clan LIKE '#8LGRYC')
ORDER BY clan_battle ASC;

--Afegim la informació a una taula auxiliar
DROP TABLE IF EXISTS more_fights_aux;
CREATE TABLE more_fights_aux(
	clan_battle INTEGER,
	id_clan VARCHAR(100)
);

--Insertem dades
COPY more_fights_aux(clan_battle, id_clan)
FROM 'C:/Users/Public/CSV_BBDD/more_fights.csv'
DELIMITER ';'
CSV HEADER;

INSERT INTO fight(clan_battle, id_clan)
SELECT clan_battle, id_clan FROM more_fights_aux;
