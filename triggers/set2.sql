-- 2) No sóc un jugador, sóc un jugador de videojocs

-- 2.1) Procés de compra

-- FUNCTION --
DROP TRIGGER IF EXISTS buy_process ON pays CASCADE;
DROP FUNCTION IF EXISTS buy_process();
CREATE FUNCTION buy_process()
RETURNS TRIGGER AS $$
BEGIN
	--Bundle case
	IF (NEW.id_article IN (SELECT id_bundle FROM bundle)) THEN
		UPDATE player
		SET gold = gold + (SELECT gold_contained FROM bundle WHERE id_bundle = NEW.id_article),
		gems = gems + (SELECT gems_contained FROM bundle WHERE id_bundle = NEW.id_article)
		WHERE player.id_player = NEW.id_player;
	END IF;
	-- Sand pack case
	IF (NEW.id_article IN (SELECT id_sand_pack FROM sand_pack)) THEN
		UPDATE player
		SET gold = gold + (SELECT gold_contained FROM belongs 
						   WHERE id_sand_pack = NEW.id_article
	  					   AND id_sand = (
						   SELECT id FROM sand 
						   -- Inside trophies range
						   WHERE max_trophies > (SELECT trophies FROM player WHERE id_player = NEW.id_player)
	  					   AND min_trophies <= (SELECT trophies FROM player WHERE id_player = NEW.id_player)
						   -- Not a debug sand
						   AND id NOT IN (SELECT id FROM debugSand)
						   -- Possible sand pack sand?
						   AND id IN (SELECT id_sand FROM belongs WHERE id_sand_pack = NEW.id_article)))
		WHERE player.id_player = NEW.id_player;
	END IF;
RETURN NULL;
END;
$$ LANGUAGE plpgsql;

-- TRIGGER --
CREATE OR REPLACE TRIGGER buy_process
AFTER INSERT ON pays
FOR EACH ROW
EXECUTE FUNCTION buy_process();


-- VALIDATION --
-- 1. BUNDLE
	-- 1.1. Creating user for validation
INSERT INTO credit_card VALUES(696969696969696);
INSERT INTO player VALUES('#ARNAU', 'Arnau', 0, 0, 0, 0);
INSERT INTO possesses VALUES(696969696969696, '#ARNAU');

	-- 1.2. Looking for a buyable bundle
SELECT * FROM pays WHERE id_article IN (SELECT id_bundle FROM bundle);

	-- 1.3. Getting information about bundle with ID = 125
SELECT * FROM bundle WHERE id_bundle = 125;

	-- 1.4. Buy execution
INSERT INTO pays VALUES('#ARNAU', 696969696969696, 125, '2022-02-22 00:00:00', 0);

	-- 1.5. Gold and gems checking
SELECT * FROM player WHERE id_player = '#ARNAU';

	-- 1.6 Player reset
UPDATE player SET gold = 0, gems = 0 WHERE id_player = '#ARNAU';

-- 2. SAND PACK
	-- 2.1 Looking for a buyable sand pack
SELECT * FROM pays WHERE id_article IN (SELECT id_sand_pack FROM sand_pack);

	-- 2.2 Getting information about sand pack with ID = 5
SELECT * FROM belongs WHERE id_sand_pack = 5 AND id_sand NOT IN (SELECT id FROM debugSand);

	-- 2.3 Checking trophies for sand ID = 54000013
SELECT * FROM sand WHERE id = 54000013;

	-- 2.4 Player set up to fit arena analysed
UPDATE player SET trophies = 5500 WHERE id_player = '#ARNAU';

	-- 2.5 Buy execution
INSERT INTO pays VALUES('#ARNAU', 696969696969696, 5, '2022-02-22 00:00:00', 0);

	-- 2.6 Checking our player's gold
SELECT * FROM player WHERE id_player = '#ARNAU';

	-- 2.7 Deleting introduced data
DELETE FROM pays WHERE id_player = '#ARNAU';
DELETE FROM possesses WHERE card_number = 696969696969696;
DELETE FROM credit_card WHERE number = 696969696969696;
DELETE FROM player WHERE id_player = '#ARNAU';	

-------------------------------- END 2.1 -------------------------------------------------

-- 2.2) Jugadors prohibits

-- FUNCTION --
DROP TRIGGER IF EXISTS banned_players ON message CASCADE;
DROP FUNCTION IF EXISTS banned_players();
CREATE FUNCTION banned_players()
RETURNS TRIGGER AS $$
DECLARE
	message TEXT;
	messages TEXT;
BEGIN
    -- Getting offensive words
	messages := 'SELECT message FROM offense;';
    -- Offensive words interation
	FOR message IN EXECUTE messages LOOP
        -- Offensive message check
		IF (NEW.issue LIKE '%' || message || '%') THEN
            -- Warning due to message to player
			IF (NEW.id_replier IN (SELECT id_player FROM player)) THEN
				INSERT INTO MessageWarnings SELECT
				NEW.id_message, NEW.datetime, NEW.id_owner,
				'Missatge d''odi enviat amb paraula/s ' || message || ' a l''usuari ' ||
				(SELECT name FROM player WHERE id_player = NEW.id_replier);
            -- Warning due to message to clan
			ELSE
				INSERT INTO MessageWarnings SELECT
				NEW.id_message, NEW.datetime, NEW.id_owner,
				'Missatge d''odi enviat amb paraula/s ' || message || ' al clan ' ||
				(SELECT clan_name FROM clan WHERE id_clan = NEW.id_replier);
			END IF;
            -- Number of warnings regulation -> banning
			IF (SELECT name FROM player WHERE id_player = NEW.id_owner) NOT LIKE '%_banned_%' THEN
				UPDATE player SET name = '_banned_' || name
				WHERE id_player = NEW.id_owner;
			END IF;
		END IF;
	END LOOP;
RETURN NULL;
END;
$$ LANGUAGE plpgsql;

-- TRIGGER --
CREATE OR REPLACE TRIGGER banned_players
AFTER INSERT ON message
FOR EACH ROW
EXECUTE FUNCTION banned_players();

-- VALIDATION --
    -- 1. Manage our offensive word
DELETE FROM offense;
INSERT INTO offense VALUES('cabron');

    -- 2. Offensive message owner (player) creation
INSERT INTO player VALUES('#ARNAU', 'Arnau', 0, 0, 0, 0);

    -- 3. Obtain receivers ID
        -- Player's case:
SELECT * FROM player; -- choose random ID from column id_player
        -- Clan's case:
SELECT * FROM clan; -- choose random ID from column id_clan

    -- 4. Message insertion (2001 is a non used ID inside messages table, should be changed in case other have been inserted)
        -- To a player:
INSERT INTO message VALUES(2001, 'Calla cabron', '2022-02-22 00:00:00', '#ARNAU', '#QV2PYL', null);
        -- To a clan:
INSERT INTO message VALUES(2001, 'Ets uncabron', '2022-02-22 00:00:00', '#ARNAU', '#8LGRYC', null);

    -- 5. Check warning procedure
SELECT * FROM MessageWarnings;

    -- 6. Check banning procedure
SELECT * FROM player WHERE id_player = '#ARNAU';

    -- 7. Deleting inserted data
DELETE FROM offense WHERE message = 'cabron';
DELETE FROM MessageWarnings WHERE id_player = '#ARNAU';
DELETE FROM message WHERE id_owner = '#ARNAU';
DELETE FROM player WHERE id_owner = '#ARNAU';

-------------------------------- END 2.2 -------------------------------------------------

-- 2.3) Final de temporada

-- FUNCTION --
DROP TRIGGER IF EXISTS season_end ON season CASCADE;
DROP FUNCTION IF EXISTS season_end();
CREATE FUNCTION season_end()
RETURNS TRIGGER AS $$
BEGIN
	INSERT INTO Ranquing
	SELECT season.id_name, player.id_player, sand.id, player.trophies
	FROM player, sand, season
	-- Looking for player corresponding sand
	WHERE sand.max_trophies > player.trophies
	AND sand.min_trophies <= player.trophies
	-- Avoiding debug sands
	AND sand.id NOT IN (SELECT id FROM DebugSand)
	AND season.id_name =
	-- Last season search
	(SELECT season.id_name FROM season WHERE season.end_date =
	(SELECT MAX(end_date) FROM season));
RETURN NULL;
END;
$$ LANGUAGE plpgsql;

-- TRIGGER --
CREATE OR REPLACE TRIGGER season_end
BEFORE INSERT ON season
EXECUTE FUNCTION season_end();

-- VALIDATION --
	-- 1. Creating validation player
INSERT INTO player VALUES('#ARNAU', 'ARNAU', 0, 2750, 0, 0);

	-- 2. Looking for arena associated to 2750 trophies
SELECT * FROM sand WHERE sand.id NOT IN (SELECT id FROM debugSand);

	-- 3. New season start
INSERT INTO season SELECT 'T11', CURRENT_DATE, '2022-12-31';

	-- 4. Trigger effect checking
SELECT * FROM Ranquing WHERE user_id = '#ARNAU';

	-- 5. Arena reviewing
SELECT * FROM sand WHERE id = 54000010;

	-- 6. Deleting inserted data
DELETE FROM Ranquing;
DELETE FROM season WHERE id_name = 'T11';
DELETE FROM player WHERE id_player = '#ARNAU';

-------------------------------- END 2.3 -------------------------------------------------
