-- 4) M'agrada la competició. M'agraden els reptes ...

-- 4.1) Completar una missió
DROP TRIGGER IF EXISTS completes_mission_reward ON accepts;
CREATE TRIGGER completes_mission_reward AFTER UPDATE
ON accepts FOR EACH ROW EXECUTE FUNCTION complete_mission_reward();

CREATE OR REPLACE FUNCTION complete_mission_reward() RETURNS TRIGGER AS $complete_mission_reward$
   BEGIN
       IF NEW.is_completed = TRUE THEN
          UPDATE player
          SET gold = gold + (SELECT DISTINCT reward_in_gold FROM accepts INNER JOIN sand ON accepts.id_sand = sand.id WHERE accepts.id_mission = 144 AND id_sand = 54000048 LIMIT 1)
          WHERE player.id_player = OLD.id_player;
      END IF;
      RETURN NEW;
   END;
$complete_mission_reward$ LANGUAGE plpgsql;

-- 4.2) Batalla amb jugadors

-- 4.3) Corrupció de dades


--- VALIDATION OF FUNCTION 4.1 ---

-- 1) Let's check how much gold has this player
SELECT gold FROM player WHERE id_player = '#9Q8UCU0Q0';

-- 2) As the player accepts a mission, it has to complete it. We create a new accepts row.
DELETE FROM accepts WHERE id_mission = 144 AND id_player = '#9Q8UCU0Q0'; -- (delete for multiple executions)
INSERT INTO accepts (id_mission, id_player, id_sand, is_completed) VALUES (144, '#9Q8UCU0Q0', 54000048, false);

-- 3) Let's check how much gold gives this mission if it is completed successfully.
SELECT DISTINCT reward_in_gold FROM accepts INNER JOIN sand ON accepts.id_sand = sand.id WHERE accepts.id_mission = 144 AND id_sand = 54000048 LIMIT 1;

-- 4) Ok so now the mission is not completed. Let's make it completed (is_completed = true).
UPDATE accepts SET is_completed = true WHERE id_mission = 144 AND id_player = '#9Q8UCU0Q0' AND id_sand = 54000048;

--5) And finally, let's check how much gold has this player. It has to have more gold.
SELECT * FROM player WHERE id_player = '#9Q8UCU0Q0';