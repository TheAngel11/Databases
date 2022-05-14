-- 4) M'agrada la competició. M'agraden els reptes ...

-- 4.1) Completar una missió
DROP TRIGGER IF EXISTS completes_mission_reward ON accepts;
CREATE TRIGGER completes_mission_reward
    AFTER UPDATE
    ON accepts
    FOR EACH ROW
EXECUTE FUNCTION complete_mission_reward();

CREATE OR REPLACE FUNCTION complete_mission_reward() RETURNS TRIGGER AS
$complete_mission_reward$
BEGIN
    IF NEW.is_completed = TRUE THEN -- test if the mission is completed
        UPDATE player -- update gold
        SET gold = gold + (SELECT DISTINCT reward_in_gold
                           FROM accepts
                                    INNER JOIN sand ON accepts.id_sand = sand.id
                           WHERE accepts.id_mission = 144
                             AND id_sand = 54000048
                           LIMIT 1)
        WHERE player.id_player = OLD.id_player;
        UPDATE player -- update experience
        SET exp = exp + (SELECT DISTINCT reward_in_exp
                         FROM accepts
                                  INNER JOIN sand ON accepts.id_sand = sand.id
                         WHERE accepts.id_mission = 144
                           AND id_sand = 54000048
                         LIMIT 1)
        WHERE player.id_player = OLD.id_player;
    ELSE -- if the mission is not completed
        INSERT INTO warnings(affected_table, error_message, date, "user")
        SELECT 'accepts',
               'L entrada de la quest per a ' ||
               (SELECT title FROM mission WHERE mission.id_mission = new.id_mission) ||
               'sha realitzat sense completar el ' ||
               (SELECT task_description FROM mission WHERE id_mission = new.id_mission) || ' prerequisit',
               now(),
               (SELECT id_player FROM player WHERE id_player = new.id_player);
    END IF;
    RETURN NEW;
END;
$complete_mission_reward$ LANGUAGE plpgsql;

-- 4.2) Batalla amb jugadors
DROP TRIGGER IF EXISTS battle_completed ON battle;
CREATE TRIGGER battle_completed
    AFTER INSERT
    ON battle
    FOR EACH ROW
EXECUTE FUNCTION battle_completed();

CREATE OR REPLACE FUNCTION battle_completed() RETURNS TRIGGER AS
$battle_completed$
BEGIN
    UPDATE player SET trophies = trophies + new.trophies_played WHERE id_player = new.winner;
    RETURN NEW;
END;
$battle_completed$ LANGUAGE plpgsql;

-- 4.3) Corrupció de dades
DROP TRIGGER IF EXISTS check_inconsistencies_before_insert ON give;
CREATE TRIGGER check_inconsistencies_before_insert
    BEFORE INSERT
    ON give
    FOR EACH ROW
EXECUTE FUNCTION check_inconsistencies();

DROP TRIGGER IF EXISTS check_inconsistencies_before_update ON give;
CREATE TRIGGER check_inconsistencies_before_update
    BEFORE UPDATE
    ON give
    FOR EACH ROW
EXECUTE FUNCTION check_inconsistencies();

CREATE OR REPLACE FUNCTION check_inconsistencies() RETURNS TRIGGER AS
$check_inconsistencies$
BEGIN
    IF new.gold IS NULL THEN
        INSERT INTO warnings(affected_table, error_message, date, "user")
        SELECT 'give',
               'Sha realitzat una donacio dor nula.',
               now(),
               new.id_player;
        RETURN NEW;
    END IF;
    -- test if the player who has donated belongs to the same clan
    IF new.id_player IS NOT NULL THEN
        IF new.id_player NOT IN (SELECT id_player FROM joins WHERE id_clan = new.id_clan) THEN
            INSERT INTO warnings(affected_table, error_message, date, "user")
            SELECT 'give',
                   'Sha realitzat una donacio de ' || new.gold || ' dor a ' ||
                   (SELECT clan_name FROM clan WHERE id_clan = new.id_clan) ||
                   ' sha realitzat sense pertanyer al clan.',
                   now(),
                   new.id_player;
        END IF;
    END IF;
    RETURN NEW;
END ;
$check_inconsistencies$ LANGUAGE plpgsql;


--- VALIDATION OF FUNCTION 4.1 ---

-- 1) Let's check how much gold and exp has this player
SELECT gold, exp
FROM player
WHERE id_player = '#9Q8UCU0Q0';

-- 2) As the player accepts a mission, it has to complete it. We create a new accepts row.
DELETE
FROM accepts
WHERE id_mission = 144
  AND id_player = '#9Q8UCU0Q0'; -- (delete for multiple executions)
INSERT INTO accepts (id_mission, id_player, id_sand, is_completed)
VALUES (144, '#9Q8UCU0Q0', 54000048, false);

-- 3) Let's check how much gold and experience gives this mission if it is completed successfully.
SELECT DISTINCT reward_in_gold, reward_in_exp
FROM accepts
         INNER JOIN sand ON accepts.id_sand = sand.id
WHERE accepts.id_mission = 144
  AND id_sand = 54000048
LIMIT 1;


-- 4) Ok so now the mission is not completed. Let's make it completed (is_completed = true).
UPDATE accepts
SET is_completed = true
WHERE id_mission = 144
  AND id_player = '#9Q8UCU0Q0'
  AND id_sand = 54000048;

-- 5) And finally, let's check how much gold has this player. It has to have more gold.
SELECT *
FROM player
WHERE id_player = '#9Q8UCU0Q0';

-- 6) Now let's check what happens if the mission is not completed
UPDATE accepts
SET is_completed = false
WHERE id_mission = 144
  AND id_player = '#9Q8UCU0Q0'
  AND id_sand = 54000048;

-- 7) A new warning has to be created
SELECT *
FROM warnings
WHERE affected_table = 'accepts';

--- VALIDATION OF FUNCTION 4.2 ---

-- 1) Let's check how many trophies has this player
SELECT *
FROM player
WHERE id_player = '#9Q8UCU0Q0';

-- 2) Let's create a new battle, making the player #9Q8UCU0Q0 the winner
DELETE
FROM battle
WHERE id_battle = 9920;
INSERT INTO battle (id_battle, winner, loser, datetime, duration, points, trophies_played, gold_played, clan_battle)
VALUES (9920, '#9Q8UCU0Q0', '#PJG9RLQC', now(), '00:10:30', 100, 1150, 1500, NULL);

-- 3) Let's check how many trophies has this player
SELECT *
FROM player
WHERE id_player = '#9Q8UCU0Q0';

-- Validation of function 4.3

-- 1) We are going to insert a null value in the gold column of the give table
DELETE FROM give WHERE id_player = '#9Q8UCU0Q0';
INSERT INTO give (id_clan, id_player, date, gold, experience)
VALUES ('#PV2G9U2L', '#9Q8UCU0Q0', now(), NULL, 665);

-- 2) We are going to make a donation to a clan that does not belong the player with id #9Q8UCU0Q0
SELECT * FROM joins WHERE id_player = '#9Q8UCU0Q0'; -- he belongs to a clan with id #8LGRYC
INSERT INTO give (id_clan, id_player, date, gold, experience)
VALUES ('#8LGRYC', '#9Q8UCU0Q0', now(), 100, 665); -- warning table should not be affected
SELECT * FROM warnings WHERE affected_table = 'give';

INSERT INTO give (id_clan, id_player, date, gold, experience)
VALUES ('#P0LLG9RG', '#9Q8UCU0Q0', now(), 100, 665); -- warning table now should be affected
SELECT * FROM warnings WHERE affected_table = 'give';
