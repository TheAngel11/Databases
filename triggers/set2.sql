-- 2) No sóc un jugador, sóc un jugador de videojocs

-- 2.1) Procés de compra

-- FUNCTION --

-- TRIGGER --

-- VALIDATION --

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


-- 2.3) Final de temporada

-- FUNCTION --

-- TRIGGER --

-- VALIDATION --
