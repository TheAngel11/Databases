--# Set 1 [Les cartes són la guerra, disfressada d'esport]
-- 1. Enumerar el nom i el valor de dany de les cartes de tipus de tropa amb un valor de 
-- velocitat d’atac superior a 100 i el nom del qual contingui el caràcter "k".
/*Consulta*/
SELECT c.id_card_name, c.damage
FROM card AS C
JOIN troop AS t ON t.troop_name = c.id_card_name
WHERE c.attack_speed > 100 AND c.id_card_name LIKE '%k%'
ORDER BY c.damage DESC;
/*Validacio*/
--1r, comprovem que les cartes que han aparegut tenen +100 vel.attack
SELECT c.id_card_name, c.attack_speed
FROM card AS C
JOIN troop AS t ON t.troop_name = c.id_card_name
WHERE c.attack_speed > 100 AND c.id_card_name LIKE '%k%'

--2n, mirem quin és el numero de tropes que cumpleixen aquests requisits comprovant que dona 7
SELECT COUNT(t.troop_name)
FROM troop AS t
JOIN card AS c ON t.troop_name = c.id_card_name
WHERE c.attack_speed > 100 AND c.id_card_name LIKE '%k%'

-- 2. Enumerar el valor de dany mitjà, el valor de dany 
-- màxim i el valor de dany mínim de les cartes èpiques.
/*Consulta*/
SELECT AVG(c.damage) AS avg_damage, MAX(c.damage) AS max_damage, MIN(c.damage) AS min_damage
FROM card AS c
JOIN rarity AS r ON  c.rarity = r.degree 
WHERE r.degree LIKE 'Epic';
/*Validacio*/
-- 1r, comprovem l'average calculant-lo per separat i mirant que dongui el mateix
SELECT AVG(card.damage) AS avg_damage FROM card
JOIN rarity ON card.rarity = rarity.degree 
WHERE rarity.degree LIKE 'Epic';

-- 2r, comprovem el minim calculant-lo d'una manera diferent, per separat i mirant que dongui el mateix
SELECT card.damage AS min_damage FROM card 
JOIN rarity ON  card.rarity = rarity.degree 
WHERE rarity.degree LIKE 'Epic' AND card.damage = (SELECT card.damage FROM card
												   JOIN rarity ON  card.rarity = rarity.degree 
												   WHERE rarity.degree LIKE 'Epic'
												   ORDER BY card.damage ASC
												   LIMIT 1);

-- 3r, comprovem el maxim calculant-lo d'una manera diferent, per separat i mirant que dongui el mateix
SELECT card.damage AS max_damage FROM card 
JOIN rarity ON  card.rarity = rarity.degree 
WHERE rarity.degree LIKE 'Epic' AND card.damage = (SELECT card.damage FROM card
												   JOIN rarity ON  card.rarity = rarity.degree 
												   WHERE rarity.degree LIKE 'Epic'
												   ORDER BY card.damage DESC
												   LIMIT 1);

-- 3. Enumera el nom i la descripció de les piles i el nom de les cartes que tenen un nivell de 
-- carta més gran que el nivell mitjà de totes les cartes. Ordena els resultats segons el nom 
-- de les piles i el nom de les cartes de més a menys valor.
/*Consulta*/
SELECT s.name, s.description, c.id_card_name
FROM card AS c
JOIN "group" AS g ON g.card_name = c.id_card_name		
JOIN stack AS s ON g.id_stack = s.id_stack
WHERE c.id_card_name IN (SELECT DISTINCT o.card
FROM owns AS o
JOIN "level" AS l ON l.level = o.level
WHERE l.level > (SELECT AVG(o.level) 
				  FROM owns AS o
				 JOIN card AS c ON c.id_card_name = o.card))
ORDER BY s.name, c.id_card_name DESC;

/*Validacio*/
--1r comprovem que la mitjana de nivell de les cartis sigui coherent (que estigui entre el mínim i el màxim)
SELECT MAX(o.level) AS max_level, MIN(o.level) AS min_level, AVG(o.level) AS avg_level
FROM owns AS o
JOIN card AS c ON c.id_card_name = o.card

--2n mirem que les combinacions possibles són més que les files que ens han donat com a output
SELECT COUNT(s.id_stack) AS num_stacks
FROM stack AS s;

SELECT COUNT(c.id_card_name) AS num_cards
FROM card AS c;

--3r calculem les files i comprovem que ens doni el mateix
SELECT COUNT(s.name)
FROM card AS c
JOIN "group" AS g ON g.card_name = c.id_card_name		
JOIN stack AS s ON g.id_stack = s.id_stack
WHERE c.id_card_name IN (SELECT DISTINCT o.card
FROM owns AS o
JOIN "level" AS l ON l.level = o.level
WHERE l.level > 8.665);

-- 4. Enumerar el nom i el dany de les cartes llegendàries de menor a major valor de dany 
-- que pertanyin a una pila creada l'1 de novembre del 2021. Filtrar la sortida per tenir les 
-- deu millors cartes.
/*Consulta*/
SELECT DISTINCT c.id_card_name AS card_name, c.damage
FROM card AS c
JOIN rarity AS r ON  c.rarity = r.degree 
JOIN "group" AS g ON g.card_name = c.id_card_name			
JOIN stack AS s ON g.id_stack = s.id_stack
WHERE r.degree LIKE 'Legendary' AND '2021' = EXTRACT(YEAR FROM s.creation_date)
AND '11' = EXTRACT(MONTH FROM s.creation_date) AND '1' = EXTRACT(DAY FROM s.creation_date)
ORDER BY c.damage ASC
LIMIT 10;

/*Validacio*/
--1r Comprovem que les cartes que ens han donat com a resultat son legendaries i que son les cartes amb menor dany 
SELECT DISTINCT c.id_card_name AS card_name, c.damage, r.degree
FROM card AS c
JOIN rarity AS r ON  c.rarity = r.degree 
WHERE  r.degree LIKE 'Legendary'
ORDER BY c.damage ASC;

--2n Comprovem que estigui be la data
SELECT DISTINCT c.id_card_name AS card_name, c.damage
FROM card AS c
JOIN "group" AS g ON g.card_name = c.id_card_name			
JOIN stack AS s ON g.id_stack = s.id_stack
WHERE '2021' = EXTRACT(YEAR FROM s.creation_date) 
AND '11' = EXTRACT(MONTH FROM s.creation_date) AND '1' = EXTRACT(DAY FROM s.creation_date)
ORDER BY c.damage ASC;


-- 5. Llistar les tres primeres cartes de tipus edifici (nom i dany) en funció del dany, dels
-- jugadors amb experiència superior a 250.000.
/*Consulta*/
SELECT DISTINCT c.id_card_name AS card_name, c.damage
FROM card AS c
JOIN building AS b ON b.building_name = c.id_card_name
JOIN owns AS o ON o.card = c.id_card_name
JOIN player AS p ON p.id_player = o.player
WHERE p.exp > 250000
ORDER BY c.damage DESC
LIMIT 3;

-- 1r comprovem que les cartes siguin de tipus edifici
SELECT DISTINCT c.id_card_name AS card_name, b.life  	
FROM card AS c
JOIN building AS b ON b.building_name = c.id_card_name;

-- 2n comprovem que les cartes les tinguin jugadors amb +250000exp
--Bomb Tower
SELECT  c.id_card_name AS card_1, p.exp
FROM card AS c
JOIN building AS b ON b.building_name = c.id_card_name
JOIN owns AS o ON o.card = c.id_card_name
JOIN player AS p ON p.id_player = o.player
WHERE p.exp > 250000 AND c.id_card_name LIKE 'Bomb Tower'
ORDER BY p.exp ASC;
--Goblin Cage
SELECT  c.id_card_name AS card_2, p.exp
FROM card AS c
JOIN building AS b ON b.building_name = c.id_card_name
JOIN owns AS o ON o.card = c.id_card_name
JOIN player AS p ON p.id_player = o.player
WHERE p.exp > 250000 AND c.id_card_name LIKE 'Goblin Cage'
ORDER BY p.exp ASC;
--Cannon
SELECT  c.id_card_name AS card_3, p.exp
FROM card AS c
JOIN building AS b ON b.building_name = c.id_card_name
JOIN owns AS o ON o.card = c.id_card_name
JOIN player AS p ON p.id_player = o.player
WHERE p.exp > 250000 AND c.id_card_name LIKE 'Cannon'
ORDER BY p.exp ASC;


-- 6. Els dissenyadors del joc volen canviar algunes coses a les dades. El nom d'una carta 
-- "Rascals" serà "Hal Roach's Rascals", la Raresa "Common" es dirà "Proletari". 
-- Proporcioneu les ordres SQL per fer les modificacions sense eliminar les dades i 
-- reimportar-les.
/*Consulta*/
/*CANVIAR CARTA "Rascals" --> "Hal Roach's Rascals"*/
--1r treure FK's de carta
ALTER TABLE troop 
DROP CONSTRAINT troop_troop_name_fkey;

ALTER TABLE "group" 
DROP CONSTRAINT group_card_name_fkey;

ALTER TABLE owns 
DROP CONSTRAINT owns_card_fkey;

ALTER TABLE buys 
DROP CONSTRAINT buys_id_card_name_fkey;

--2n actualitzar noms de carta de les FK's
UPDATE troop SET troop_name = 'Hal Roach''s Rascals'
WHERE troop.troop_name LIKE 'Rascals';

UPDATE "group" SET card_name = 'Hal Roach''s Rascals'
WHERE "group".card_name LIKE 'Rascals';

UPDATE owns SET card = 'Hal Roach''s Rascals'
WHERE owns.card LIKE 'Rascals';

UPDATE buys SET id_card_name = 'Hal Roach''s Rascals'
WHERE buys.id_card_name LIKE 'Rascals';

--3r actualitzar nom carta de carta
UPDATE card SET id_card_name = 'Hal Roach''s Rascals'
WHERE card.id_card_name LIKE 'Rascals';

--4t tornar a posar les FK's de carta 
ALTER TABLE troop 
ADD CONSTRAINT troop_troop_name_fkey 
FOREIGN KEY (troop_name)
REFERENCES card(id_card_name);

ALTER TABLE "group" 
ADD CONSTRAINT group_card_name_fkey 
FOREIGN KEY (card_name)
REFERENCES card(id_card_name);

ALTER TABLE owns 
ADD CONSTRAINT owns_card_fkey 
FOREIGN KEY (card)
REFERENCES card(id_card_name);

ALTER TABLE buys 
ADD CONSTRAINT buys_id_card_name_fkey 
FOREIGN KEY (id_card_name)
REFERENCES card(id_card_name);

/*CANVIAR RARESA "Common" --> "Proletari"*/
--1r treure FK's de raresa
ALTER TABLE card
DROP CONSTRAINT card_rarity_fkey;

ALTER TABLE chest
DROP CONSTRAINT chest_rarity_fkey;

--2n actualitzar el nom de raresa de les FK's
UPDATE card SET rarity = 'Proletari'
WHERE card.rarity LIKE 'Common';

UPDATE chest SET rarity = 'Proletari'
WHERE chest.rarity LIKE 'Common';

--3r actualitzar nom raresa de raresa
UPDATE rarity SET "degree" = 'Proletari'
WHERE rarity.degree LIKE 'Common';

--4t tornar a posar les FK's de raresa
ALTER TABLE card 
ADD CONSTRAINT card_rarity_fkey 
FOREIGN KEY (rarity)
REFERENCES rarity("degree");

ALTER TABLE chest 
ADD CONSTRAINT chest_rarity_fkey 
FOREIGN KEY (rarity)
REFERENCES rarity("degree");

/*Validacio*/
--1r mirem que els valors abans de ser actualitzats continguin la carta "Rascals" i la raresa "Common"
SELECT c.id_card_name 
FROM card AS c
WHERE c.id_card_name LIKE 'Rascals' OR c.id_card_name LIKE 'Hal Roach''s Rascals'

SELECT r.degree
FROM rarity AS r
WHERE r.degree LIKE 'Common' OR r.degree LIKE 'Proletari'

--2n mirem que un cop actualitzat els valors ja no estan aquests noms en cap lloc i hi ha el nou nom en tots llocs
--carta
SELECT c.id_card_name AS updated_card
FROM card AS c
WHERE c.id_card_name LIKE 'Rascals' OR c.id_card_name LIKE 'Hal Roach''s Rascals'
UNION

SELECT t.troop_name AS updated_card
FROM troop AS t
WHERE t.troop_name LIKE 'Rascals' OR t.troop_name LIKE 'Hal Roach''s Rascals'
UNION

SELECT e.enchantment_name AS updated_card
FROM enchantment AS e
WHERE e.enchantment_name LIKE 'Rascals' OR e.enchantment_name LIKE 'Hal Roach''s Rascals'
UNION

SELECT DISTINCT g.card_name AS updated_card
FROM "group" AS g
WHERE g.card_name LIKE 'Rascals' OR g.card_name LIKE 'Hal Roach''s Rascals'
UNION

SELECT DISTINCT o.card AS updated_card
FROM owns AS o
WHERE o.card LIKE 'Rascals' OR o.card LIKE 'Hal Roach''s Rascals'
UNION

SELECT b.id_card_name AS updated_card
FROM buys AS b
WHERE b.id_card_name LIKE 'Rascals' OR b.id_card_name LIKE 'Hal Roach''s Rascals';
--raresa
SELECT c.rarity AS updated_rarity
FROM card AS c
WHERE c.rarity LIKE 'Common' OR c.rarity LIKE 'Proletari'
UNION

SELECT ch.rarity AS updated_rarity
FROM chest AS ch
WHERE ch.rarity LIKE 'Common' OR ch.rarity LIKE 'Proletari';


-- 7. Enumerar els noms de les cartes que no estan en cap pila i els noms de les cartes que 
-- només estan en una pila. Per validar els resultats de la consulta, proporcioneu dues 
-- consultes diferents per obtenir el mateix resultat.
/*Consulta*/
	--CONDICIONS
SELECT c.id_card_name AS card_name
FROM card AS c
LEFT JOIN "group" AS g ON g.card_name = c.id_card_name 	
GROUP BY c.id_card_name HAVING COUNT(g.card_name) = 0 OR COUNT(g.card_name) = 1;
 
	--UNION
(SELECT c.id_card_name AS card_name
FROM card AS c
LEFT JOIN "group" AS g ON g.card_name = c.id_card_name 	
GROUP BY c.id_card_name HAVING COUNT(g.card_name) = 0)
UNION

(SELECT c.id_card_name AS card_name
FROM card AS c
LEFT JOIN "group" AS g ON g.card_name = c.id_card_name 	
GROUP BY c.id_card_name HAVING COUNT(g.card_name) = 1);

/*Validacio*/
--1r validem que no hi hagi cap carta que no estigui a cap o a només 1 pila
SELECT c.id_card_name AS card_name, COUNT(g.card_name) AS card_num
FROM card AS c
LEFT JOIN "group" AS g ON g.card_name = c.id_card_name 	
GROUP BY c.id_card_name
ORDER BY card_num ASC;

--2n fem un insert d'una nova carta
INSERT INTO card (id_card_name, damage, attack_speed, rarity, sand) 		
VALUES ('carta_no_afegida_a_pila', 150, 35, 'Epic', 54000016);

--3r mirem que amb el nou insert si dona el resultat que esperem


-- 8. Enumera el nom i el dany de les cartes èpiques que tenen un dany superior al dany mitjà 
-- de les cartes llegendàries. Ordena els resultats segons el dany de les cartes de menys 
-- a més valor.
/*Consulta*/
SELECT DISTINCT c.id_card_name AS card_name, c.damage
FROM card AS c
JOIN rarity AS r ON  c.rarity = r.degree 
WHERE r.degree LIKE 'Epic' AND c.damage > (SELECT AVG(c.damage)
										  FROM card AS c
										  JOIN rarity AS r ON  c.rarity = r.degree 
										  WHERE r.degree LIKE 'Legendary')

ORDER BY c.damage ASC;

/*Validacio*/
--1r mirem quin és el valor del dany mitja de les cartes llegendaries, que hauria de ser menor a 89
SELECT AVG(c.damage) avg_legendary_dmg
FROM card AS c
JOIN rarity AS r ON  c.rarity = r.degree 
WHERE r.degree LIKE 'Legendary';

--2n comprovem que les cartes que han donat al output estan entre les cartes epiques
SELECT DISTINCT c.id_card_name AS card_name, c.damage
FROM card AS c
JOIN rarity AS r ON  c.rarity = r.degree 
WHERE r.degree LIKE 'Epic'
ORDER BY c.damage ASC;
