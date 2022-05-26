-- 3) Tingueu valor. Encara tenim el nostre clan. Sempre hi ha esperança.
-- 3.1 Cop d'efecte
DROP function IF EXISTS new_leader();
CREATE OR REPLACE FUNCTION new_leader() RETURNS trigger AS $$ 
BEGIN 
RAISE NOTICE 'New leader added';
	INSERT INTO historic_leader(id_leader, id_clan, id_role, start_date) VALUES
	(NEW.id_player, NEW.id_clan, OLD.id_role, LOCALTIMESTAMP); 
RETURN NULL;
END;
$$ LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS trigger_leader ON joins;
CREATE OR REPLACE TRIGGER trigger_historic AFTER UPDATE ON joins 
FOR EACH ROW
WHEN (OLD.id_role IS DISTINCT FROM NEW.id_role  AND NEW.id_role = 1)
EXECUTE FUNCTION new_leader();

DROP function IF EXISTS delete_player_clan;
CREATE OR REPLACE FUNCTION delete_player_clan() RETURNS trigger AS $$ 
BEGIN 
	INSERT INTO historic_delete_players(id_leader, id_player, id_clan, player_role,datetime) 
	SELECT id_player, NEW.id_player, NEW.id_clan, OLD.id_role, LOCALTIMESTAMP
	FROM joins WHERE id_clan = NEW.id_clan AND id_role = (SELECT id_role FROM role WHERE description LIKE 'leader%');
		
	IF((SELECT COUNT(id_player) FROM historic_delete_players AS hdp WHERE hdp.id_clan = NEW.id_clan
		AND hdp.id_leader = (SELECT id_leader FROM historic_delete_players WHERE id_player = NEW.id_player )
		AND hdp.datetime - (SELECT start_date FROM historic_leader AS hl 
						  WHERE hl.id_leader = (SELECT id_leader FROM historic_delete_players WHERE id_player = NEW.id_player )) 
						 < '1 DAY') >= 5)
						 THEN
				
				UPDATE joins SET id_role = hdp.player_role FROM historic_delete_players AS hdp 
				WHERE hdp.id_clan = NEW.id_clan and hdp.id_leader = (SELECT id_leader FROM historic_delete_players WHERE id_player = NEW.id_player)
				AND LOCALTIMESTAMP - hdp.datetime < '1 DAY' AND joins.id_player = hdp.id_player;
				
				
				UPDATE joins SET id_role = hl.id_role FROM historic_leader AS hl
				WHERE hl.id_clan = NEW.id_clan AND joins.id_player = hl.id_leader AND hl.id_leader = 
				(SELECT id_leader FROM historic_delete_players WHERE id_player = NEW.id_player);
				
				IF((SELECT COUNT(id_player) FROM joins WHERE id_clan = NEW.id_clan 
					AND id_role = (SELECT id_role FROM role WHERE description LIKE 'coLeader%')) > 0)
					THEN
										
					UPDATE joins SET id_role = (SELECT id_role FROM role WHERE description LIKE 'leader%')
					WHERE id_clan = NEW.id_clan
					AND id_player = (SELECT id_player FROM joins
									 WHERE id_clan = NEW.id_clan AND 
									id_role = (SELECT id_role FROM role WHERE description LIKE 'coLeader%') 
															  LIMIT 1);

				ELSE
					UPDATE joins SET id_role = (SELECT id_role FROM role WHERE description LIKE 'leader%') 
					WHERE id_clan = NEW.id_clan
					AND id_player = (SELECT id_player FROM joins WHERE id_clan =  NEW.id_clan
									 AND id_role != 0 LIMIT 1);
							  
				END IF;
	END IF;
	RETURN NULL;
END;
$$ LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS trigger_delete_player ON joins;
CREATE OR REPLACE TRIGGER trigger_delete_player AFTER UPDATE ON joins 
FOR EACH ROW
WHEN (NEW.id_role = 0 AND OLD.id_role <> NEW.id_role)
EXECUTE FUNCTION delete_player_clan();

--Validacions

UPDATE joins SET id_role = 2 
WHERE id_player LIKE '#RC2UPGP8';

UPDATE joins SET id_role = 1
WHERE id_player LIKE '#LP098UL8L';

UPDATE joins SET id_role = 0
WHERE id_player LIKE '#QV2PYL';
UPDATE joins SET id_role = 0
WHERE id_player LIKE '#9Q8UCU0Q0';
UPDATE joins SET id_role = 0
WHERE id_player LIKE '#8C8QJR9JG';
UPDATE joins SET id_role = 0
WHERE id_player LIKE '#V0QCQUCL';

UPDATE joins SET id_role = 0
WHERE id_player LIKE '#2Q9JG29RL';

SELECT * FROM joins WHERE id_clan LIKE '#8LGRYC' ORDER BY id_role;
SELECT * FROM historic_delete_players;
SELECT * FROM historic_leader;

--3.2 Hipocresia de trofeus minims
DROP function IF EXISTS update_trophy;
CREATE OR REPLACE FUNCTION update_trophy() RETURNS trigger AS $$ 
BEGIN 
	IF(NEW.trophies < (SELECT num_min_trophy FROM clan AS cl JOIN joins AS j 
					   ON cl.id_clan = j.id_clan WHERE j.id_player = NEW.id_player)) 
	THEN				   
			IF((SELECT id_role FROM joins WHERE id_player = NEW.id_player) = 1) 
			THEN
				
				IF((SELECT COUNT(id_player) FROM joins WHERE id_clan = (SELECT id_clan FROM joins WHERE id_player = NEW.id_player) 
					AND id_role = (SELECT id_role FROM role WHERE description LIKE 'coLeader%')) > 0)THEN
					RAISE NOTICE 'Enter first if';
					UPDATE joins SET id_role = (SELECT id_role FROM role WHERE description LIKE 'leader%') 
					WHERE id_clan = (SELECT id_clan FROM joins WHERE id_player = NEW.id_player)
					AND id_player = (SELECT id_player FROM joins
									 WHERE id_clan =(SELECT id_clan FROM joins WHERE id_player = NEW.id_player) AND 
															  id_role = (SELECT id_role FROM role WHERE description LIKE 'coLeader%') 
															  LIMIT 1);

				ELSE
				UPDATE joins SET id_role = (SELECT id_role FROM role WHERE description LIKE 'leader%') 
					WHERE id_clan = (SELECT id_clan FROM joins WHERE id_player = NEW.id_player) 
					AND id_player = (SELECT id_player FROM joins WHERE id_clan = (SELECT id_clan FROM joins WHERE id_player = NEW.id_player)
									 AND id_role != 0 LIMIT 1);								  
				END IF;			
			END IF;			
			UPDATE joins SET id_role = (SELECT id_role FROM role WHERE description LIKE 'null')  WHERE NEW.id_player = id_player;
	END IF;
	RETURN NULL;
END;
$$ LANGUAGE plpgsql;						   
						   
DROP TRIGGER IF EXISTS trigger_check_trophy ON player;
CREATE OR REPLACE TRIGGER trigger_check_trophy AFTER UPDATE ON player 
FOR EACH ROW
WHEN (NEW.trophies < OLD.trophies)
EXECUTE FUNCTION update_trophy();

--Validació
UPDATE player SET trophies = 6300
WHERE id_player LIKE '#229P2QYL0';

UPDATE player SET trophies = 6300
WHERE id_player LIKE '#28GUPGY2';

UPDATE joins SET id_role = 2 
WHERE id_player LIKE '#8P988JLV0';

UPDATE player SET trophies = 6300
WHERE id_player LIKE '#G82LPRJG';

SELECT j.id_clan, j.id_player, j.id_role, r.description 
FROM joins AS j JOIN role AS r ON j.id_role = r.id_role 
WHERE id_clan LIKE '#28V2QQ9C' ORDER BY j.id_role;

--3.3 Mals perdedors
DROP function IF EXISTS warning_battle;
CREATE OR REPLACE FUNCTION warning_battle() RETURNS trigger AS $$ 
BEGIN 
	INSERT INTO Warnings(affected_table, error_message, date, "user")
		SELECT 'battle', ('S''ha intentat esborrar la batalla ' || OLD.id_battle ||  ' on l''usuari ' || OLD.loser ||' va perdre ' || OLD.points_loser ||' trofeus'
			), (SELECT CURRENT_DATE), (SELECT CURRENT_USER);
	RETURN NULL;
END;
$$ LANGUAGE plpgsql;	
						   
DROP TRIGGER IF EXISTS trigger_delete_battle ON battle;
CREATE OR REPLACE TRIGGER trigger_delete_battle BEFORE DELETE ON battle 
FOR EACH ROW
WHEN (CURRENT_USER NOT LIKE 'admin')
EXECUTE FUNCTION warning_battle();	

--Validació
CREATE ROLE "admin" LOGIN PASSWORD 'BBDD2022' SUPERUSER;

DELETE FROM battle
WHERE id_battle = 9924;
SELECT * FROM Warnings;

DELETE FROM battle
WHERE id_battle = 9927;
SELECT * FROM Warnings;
