-- 1) Les cartes són la guerra, disfressada d'esport
-- TRIGGERS CARTA --
--1.1) Proporcions de rareses 
--Stored procedure
DROP FUNCTION IF EXISTS card_warning CASCADE;
CREATE OR REPLACE FUNCTION card_warning() RETURNS trigger AS $$
BEGIN
	--Common warning
	IF (SELECT 100 * (SELECT COUNT(c.rarity) FROM card AS c
			WHERE c.rarity LIKE 'Common') / (SELECT COUNT(c.id_card_name) FROM card AS c)) <>
			(SELECT 31*100 / (SELECT COUNT(c.id_card_name) FROM card AS c)) THEN
			
		INSERT INTO Warnings(affected_table, error_message, date, "user")
		SELECT 'card', 'Proporcions de raresa no respectades: Common ' || 'la proporció actual és ' || 
			(SELECT 100 * (SELECT COUNT(c.rarity) FROM card AS c
				WHERE c.rarity LIKE 'Common')) / (SELECT COUNT(c.id_card_name) FROM card AS c) || 
			' quan hauria de ser ' || (SELECT 31*100 / (SELECT COUNT(c.id_card_name) FROM card AS c)), (SELECT CURRENT_DATE), (SELECT CURRENT_USER);
	END IF; 
	
	--Rare warning
	IF (SELECT 100 * (SELECT COUNT(c.rarity) FROM card AS c
			WHERE c.rarity LIKE 'Rare') / (SELECT COUNT(c.id_card_name) FROM card AS c)) <> 
			(SELECT 26*100 / (SELECT COUNT(c.id_card_name) FROM card AS c)) THEN
			
		INSERT INTO Warnings(affected_table, error_message, date, "user")
		SELECT 'card', 'Proporcions de raresa no respectades: Rare ' || 'la proporció actual és ' || 
			(SELECT 100 * (SELECT COUNT(c.rarity) FROM card AS c
				WHERE c.rarity LIKE 'Rare')) / (SELECT COUNT(c.id_card_name) FROM card AS c) || 
			' quan hauria de ser ' || (SELECT 26*100 / (SELECT COUNT(c.id_card_name) FROM card AS c)), (SELECT CURRENT_DATE), (SELECT CURRENT_USER);
	END IF; 
	
	--Epic warning
	IF (SELECT 100 * (SELECT COUNT(c.rarity) FROM card AS c
			WHERE c.rarity LIKE 'Epic') / (SELECT COUNT(c.id_card_name) FROM card AS c)) <> 
			(SELECT 23*100 / (SELECT COUNT(c.id_card_name) FROM card AS c)) THEN
			
		INSERT INTO Warnings(affected_table, error_message, date, "user")
		SELECT 'card', 'Proporcions de raresa no respectades: Epic ' || 'la proporció actual és ' || 
			(SELECT 100 * (SELECT COUNT(c.rarity) FROM card AS c
				WHERE c.rarity LIKE 'Epic')) / (SELECT COUNT(c.id_card_name) FROM card AS c) || 
			' quan hauria de ser ' || (SELECT 23*100 / (SELECT COUNT(c.id_card_name) FROM card AS c)), (SELECT CURRENT_DATE), (SELECT CURRENT_USER);
	END IF; 
	
	--Legendary warning
	IF (SELECT 100 * (SELECT COUNT(c.rarity) FROM card AS c
			WHERE c.rarity LIKE 'Legendary') / (SELECT COUNT(c.id_card_name) FROM card AS c)) <> 
			(SELECT 17*100 / (SELECT COUNT(c.id_card_name) FROM card AS c)) THEN
			
		INSERT INTO Warnings(affected_table, error_message, date, "user")
		SELECT 'card', 'Proporcions de raresa no respectades: Legendary ' || 'la proporció actual és ' || 
			(SELECT 100 * (SELECT COUNT(c.rarity) FROM card AS c
				WHERE c.rarity LIKE 'Legendary')) / (SELECT COUNT(c.id_card_name) FROM card AS c) || 
			' quan hauria de ser ' || (SELECT 17*100 / (SELECT COUNT(c.id_card_name) FROM card AS c)), (SELECT CURRENT_DATE), (SELECT CURRENT_USER);
	END IF; 
	
	--Champion warning
	IF (SELECT 100 * (SELECT COUNT(c.rarity) FROM card AS c
			WHERE c.rarity LIKE 'Champion') / (SELECT COUNT(c.id_card_name) FROM card AS c)) <> 
			(SELECT 3*100 / (SELECT COUNT(c.id_card_name) FROM card AS c)) THEN
			
		INSERT INTO Warnings(affected_table, error_message, date, "user")
		SELECT 'card', 'Proporcions de raresa no respectades: Champion ' || 'la proporció actual és ' || 
			(SELECT 100 * (SELECT COUNT(c.rarity) FROM card AS c
				WHERE c.rarity LIKE 'Champion')) / (SELECT COUNT(c.id_card_name) FROM card AS c) || 
			' quan hauria de ser ' || (SELECT 3*100 / (SELECT COUNT(c.id_card_name) FROM card AS c)), (SELECT CURRENT_DATE), (SELECT CURRENT_USER);
	END IF; 
	
RETURN NULL;
END;
$$ LANGUAGE plpgsql;

--Trigger
DROP TRIGGER IF EXISTS rarity_proportions ON card;
CREATE OR REPLACE TRIGGER rarity_proportions 
AFTER UPDATE ON card
FOR EACH ROW
WHEN(OLD.rarity IS DISTINCT FROM NEW.rarity) 
EXECUTE FUNCTION card_warning();



-- Validation
UPDATE card SET rarity = 'Rare'
WHERE id_card_name = 'X-Bow' OR id_card_name = 'Giant' OR id_card_name = 'Balloon'
OR id_card_name = 'Witch' OR id_card_name = 'Golem';

UPDATE card SET rarity = 'Rare'
WHERE id_card_name = 'Tornado';

SELECT COUNT(c.rarity), c.rarity  FROM card AS c
GROUP BY c.rarity;

SELECT * FROM Warnings


--1.2) Regal d'actualització de cartes 
--Stored procedure
DROP FUNCTION IF EXISTS level_up_card CASCADE;
CREATE OR REPLACE FUNCTION level_up_card() RETURNS trigger AS $$
BEGIN
	
	UPDATE owns SET level = (SELECT MAX(l.level) FROM level AS l)
	WHERE card = NEW.card;
	
RETURN NULL;
END;
$$ LANGUAGE plpgsql;

--Trigger
DROP TRIGGER IF EXISTS free_gift ON owns;
CREATE OR REPLACE TRIGGER free_gift 
AFTER INSERT ON owns
FOR EACH ROW
EXECUTE FUNCTION level_up_card();

-- Validation
---1 we see what cards a player don't have yet
SELECT c.id_card_name FROM card AS c
WHERE c.id_card_name NOT IN(
SELECT o.card FROM owns AS o
WHERE o.player LIKE '#QV2PYL');

---2 we insert one of these cards into owns
INSERT INTO owns(card, level, player, date_found, date_level_up, experience_gained)
SELECT 'Bomb', 1, '#QV2PYL', (SELECT CURRENT_DATE), (SELECT CURRENT_DATE), '1100';

---3 we check what is the max level
SELECT MAX(l.level) FROM level AS l;

---4 we check that the card introduced has increased his level into max level
SELECT o.player, o.card, o.level FROM owns AS o
WHERE o.card LIKE 'Bomb' AND o.player LIKE '#QV2PYL';


--1.3) Targetes OP que necessiten revisió
--Stored procedure
DROP FUNCTION IF EXISTS balance_card CASCADE;
CREATE OR REPLACE FUNCTION balance_card() RETURNS trigger AS $$
BEGIN
		--temporal table
		CREATE TABLE cards_winners ( 
		card VARCHAR(255),
		FOREIGN KEY (card) REFERENCES card (id_card_name)
		);
		
		--insert into the temporal table the cards who have more than 90% winrate
		INSERT INTO cards_winners
		SELECT DISTINCT c.id_card_name
		FROM card AS c
		JOIN owns AS o ON o.card = c.id_card_name
		JOIN player AS p ON p.id_player = o.player
		JOIN battle AS b ON b.winner = p.id_player
		WHERE c.id_card_name IN 
			(SELECT c.id_card_name 
			FROM card AS c
			JOIN "group" AS g ON g.card_name = c.id_card_name
			WHERE g.id_stack = (
				SELECT s.id_stack
				FROM battle AS b
				JOIN player AS p ON b.winner = p.id_player
				JOIN stack AS s ON s.id_player = p.id_player
				WHERE p.id_player = NEW.winner
				ORDER BY s.id_stack
				LIMIT 1))
		GROUP BY c.id_card_name HAVING (
		--percentage of wins
		((SELECT COUNT(b.winner) AS num_wins
		FROM card AS c
		JOIN owns AS o ON o.card = c.id_card_name
		JOIN player AS p ON p.id_player = o.player
		JOIN battle AS b ON b.winner = p.id_player
		WHERE b.winner LIKE NEW.winner AND c.id_card_name IN 
			(SELECT c.id_card_name 
			FROM card AS c
			JOIN "group" AS g ON g.card_name = c.id_card_name
			WHERE g.id_stack = (
				SELECT s.id_stack
				FROM battle AS b
				JOIN player AS p ON b.winner = p.id_player
				JOIN stack AS s ON s.id_player = p.id_player
				WHERE p.id_player = NEW.winner
				ORDER BY s.id_stack
				LIMIT 1))) * 100) / 
			
		 --divided by total matches
		(SELECT COUNT(b.winner) AS total_played
		FROM card AS c
		JOIN owns AS o ON o.card = c.id_card_name
		JOIN player AS p ON p.id_player = o.player
		JOIN battle AS b ON b.winner = p.id_player
		WHERE (b.loser LIKE NEW.winner OR b.winner LIKE NEW.winner) AND c.id_card_name IN 
			(SELECT c.id_card_name 
			FROM card AS c
			JOIN "group" AS g ON g.card_name = c.id_card_name
			WHERE g.id_stack = (
				SELECT s.id_stack
				FROM battle AS b
				JOIN player AS p ON b.winner = p.id_player
				JOIN stack AS s ON s.id_player = p.id_player
				WHERE p.id_player = NEW.winner
				ORDER BY s.id_stack
				LIMIT 1)))) > 49;
		
		-- There is a card with more than 90% winrate
		IF ((SELECT COUNT(cw.card)FROM cards_winners AS cw) <> 0) THEN

			--The card has been inside the OpCardBlackList for 7 or more days
				
			UPDATE card SET damage = ((damage * 99)/100), attack_speed = ((attack_speed * 99)/100)
			WHERE id_card_name IN (
				SELECT cw.card FROM OpCardBlackList AS op 
				JOIN cards_winners AS cw ON cw.card = op.card
				WHERE op.date <= (SELECT CAST(CURRENT_DATE - CAST('7 days' AS INTERVAL) AS DATE)));
				
			UPDATE enchantment SET effect_radius = ((effect_radius * 99)/100)
			WHERE enchantment_name IN (
				SELECT cw.card FROM OpCardBlackList AS op 
				JOIN cards_winners AS cw ON cw.card = op.card
				WHERE op.date <= (SELECT CAST(CURRENT_DATE - CAST('7 days' AS INTERVAL) AS DATE)));
			
			UPDATE troop SET spawn_damage = ((spawn_damage * 99)/100)
			WHERE troop_name IN (
				SELECT cw.card FROM OpCardBlackList AS op 
				JOIN cards_winners AS cw ON cw.card = op.card
				WHERE op.date <= (SELECT CAST(CURRENT_DATE - CAST('7 days' AS INTERVAL) AS DATE)));
			
			UPDATE building SET life = ((life * 99)/100)
			WHERE building_name IN (
				SELECT cw.card FROM OpCardBlackList AS op 
				JOIN cards_winners AS cw ON cw.card = op.card
				WHERE op.date <= (SELECT CAST(CURRENT_DATE - CAST('7 days' AS INTERVAL) AS DATE)));
				
			--The card it's not inside the OpCardBlackList
			INSERT INTO OpCardBlackList 
			SELECT cw.card, (SELECT CAST(CURRENT_DATE - CAST('7 days' AS INTERVAL) AS DATE)) 
			FROM cards_winners AS cw
			WHERE cw.card NOT IN(SELECT op.card FROM OpCardBlackList AS op);
			
		END IF;
		
		DROP TABLE IF EXISTS cards_winners CASCADE;  

RETURN NULL;
END;
$$ LANGUAGE plpgsql;
	
--Trigger
DROP TRIGGER IF EXISTS revise_cards ON battle;
CREATE OR REPLACE TRIGGER revise_cards 
AFTER INSERT ON battle
FOR EACH ROW
EXECUTE FUNCTION balance_card();

--Validacio
--Inserting win to the player '#QV2PYL'
INSERT INTO battle(winner, loser, datetime, duration, points, trophies_played, gold_played)
VALUES('#QV2PYL', '#9Q8UCU0Q0', CURRENT_DATE, '00:12:00', 10020, 20010, 501);

--Inserting another win to the player '#QV2PYL'
INSERT INTO battle(winner, loser, datetime, duration, points, trophies_played, gold_played)
VALUES('#QV2PYL', '#8C8QJR9JG', CURRENT_DATE, '00:10:00', 1040, 1000, 400);

--We check the victories and loses of the cards on the stack 
--of the player '#QV2PYL' before and after winning the battle
--victories
SELECT COUNT(b.winner) AS num_wins
FROM card AS c
JOIN owns AS o ON o.card = c.id_card_name
JOIN player AS p ON p.id_player = o.player
JOIN battle AS b ON b.winner = p.id_player
WHERE b.winner LIKE '#QV2PYL' AND c.id_card_name IN 
	(SELECT c.id_card_name 
	FROM card AS c
	JOIN "group" AS g ON g.card_name = c.id_card_name
	WHERE g.id_stack = (
		SELECT s.id_stack
		FROM battle AS b
		JOIN player AS p ON b.winner = p.id_player
		JOIN stack AS s ON s.id_player = p.id_player
		WHERE p.id_player = '#QV2PYL'
		ORDER BY s.id_stack
		LIMIT 1))
GROUP BY c.id_card_name;

--loses
SELECT COUNT(b.loser) AS num_loses
FROM card AS c
JOIN owns AS o ON o.card = c.id_card_name
JOIN player AS p ON p.id_player = o.player
JOIN battle AS b ON b.winner = p.id_player
WHERE b.loser LIKE '#QV2PYL' AND c.id_card_name IN 
	(SELECT c.id_card_name 
	FROM card AS c
	JOIN "group" AS g ON g.card_name = c.id_card_name
	WHERE g.id_stack = (
		SELECT s.id_stack
		FROM battle AS b
		JOIN player AS p ON b.winner = p.id_player
		JOIN stack AS s ON s.id_player = p.id_player
		WHERE p.id_player = '#QV2PYL'
		ORDER BY s.id_stack
		LIMIT 1))
GROUP BY c.id_card_name;

--We access into OpCardBlackList
SELECT * FROM OpCardBlackList

--We drop OpCardBlackList and create it from physical_model

--Inserting a past win to the player '#QV2PYL'
INSERT INTO battle(winner, loser, datetime, duration, points, trophies_played, gold_played)
VALUES('#QV2PYL', '#2PPRU8QU0', CURRENT_DATE, '00:15:00', 1540, 4000, 700);
	   
--Inserting a new actual win to show if the card stadistics inside OpCardBlackList decrease
INSERT INTO battle(winner, loser, datetime, duration, points, trophies_played, gold_played)
VALUES('#QV2PYL', '#8C8QJR9JG', CURRENT_DATE, '00:20:00', 120, 1003, 430);

--We check the winner stack cards
SELECT c.id_card_name 
	FROM card AS c
	JOIN "group" AS g ON g.card_name = c.id_card_name
	WHERE g.id_stack = (
		SELECT s.id_stack
		FROM battle AS b
		JOIN player AS p ON b.winner = p.id_player
		JOIN stack AS s ON s.id_player = p.id_player
		WHERE p.id_player = '#QV2PYL'
		ORDER BY s.id_stack
		LIMIT 1);

--We see if Sparky stats have decreased 
SELECT c.id_card_name, c.damage, c.attack_speed, t.spawn_damage
FROM card AS c JOIN troop AS t ON c.id_card_name = t.troop_name
WHERE c.id_card_name LIKE 'Sparky';