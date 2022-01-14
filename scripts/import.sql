-- CREATION OF AUXILIARY TABLES --

DROP TABLE IF EXISTS sand_aux;
CREATE TABLE sand_aux(
	id INTEGER,
	name VARCHAR(100),
	minTrophies INTEGER,
	maxTrophies INTEGER
);
COPY sand_aux(id, name, minTrophies, maxTrophies)
FROM '/Users/Shared/BBDD/arenas.csv'
DELIMITER ','
CSV HEADER;

DROP TABLE IF EXISTS sand_pack_aux;
CREATE TABLE sand_pack_aux(
	id INTEGER,
	arena INTEGER,
	gold INTEGER
);

COPY sand_pack_aux (id, arena, gold)
FROM '/Users/Shared/BBDD/arena_pack.csv'
DELIMITER ','
CSV HEADER;

DROP TABLE IF EXISTS battle_aux;
CREATE TABLE battle_aux(
	winner INTEGER,
	loser INTEGER,
	winner_score INTEGER,
	loser_score INTEGER,
	date DATE,
	duration TIME,
	clan_battle INTEGER
);

COPY battle_aux (winner,loser,winner_score,loser_score,date,duration,clan_battle)
FROM '/Users/Shared/BBDD/battles.csv'
DELIMITER ','
CSV HEADER;

DROP TABLE IF EXISTS building_aux;
CREATE TABLE building_aux(
	building VARCHAR(100),
	cost INTEGER,
	trophies INTEGER,
	prerequisite VARCHAR(100),
	mod_damage INTEGER,
	mod_hit_speed INTEGER,
	mod_radius INTEGER,
	mod_spawn_damage INTEGER,
	mod_lifetime INTEGER,
	description VARCHAR(255)
);

COPY building_aux (building,cost,trophies,prerequisite,mod_damage,mod_hit_speed,mod_radius,mod_spawn_damage,mod_lifetime,description)
FROM '/Users/Shared/BBDD/buildings.csv'
DELIMITER ','
CSV HEADER;

DROP TABLE IF EXISTS card_aux;
CREATE TABLE card_aux(
	name VARCHAR(100),
	rarity  VARCHAR(100),
	arena INTEGER,
	damage INTEGER,
	hit_speed INTEGER,
	spawn_damage INTEGER,
	lifetime INTEGER,
	radious INTEGER
);

COPY card_aux (name,rarity,arena,damage,hit_speed,spawn_damage,lifetime,radious)
FROM '/Users/Shared/BBDD/cards.csv'
DELIMITER ','
CSV HEADER;

DROP TABLE IF EXISTS clan_battle_aux;
CREATE TABLE clan_battle_aux(
	battle INTEGER,
	clan VARCHAR(100),
	start_date DATE,
	end_date DATE
);

COPY clan_battle_aux (battle,clan,start_date,end_date)
FROM '/Users/Shared/BBDD/clan_battles.csv'
DELIMITER ','
CSV HEADER;

DROP TABLE IF EXISTS clan_tech_structure_aux;
CREATE TABLE clan_tech_structure_aux(
	clan VARCHAR(100),
	tech VARCHAR(100),
	structure VARCHAR(100),
	date DATE,
	level INTEGER
);

COPY clan_tech_structure_aux (clan,tech,structure,date,level)
FROM '/Users/Shared/BBDD/clan_tech_structures.csv'
DELIMITER ','
CSV HEADER;

DROP TABLE IF EXISTS clans_aux;
CREATE TABLE clans_aux(
	tag VARCHAR(100),
	name VARCHAR(100),
	description VARCHAR(255),
	requiredTrophies INTEGER,
	score INTEGER,
	trophies INTEGER
);

COPY clans_aux (tag,name,description,requiredTrophies,score,trophies)
FROM '/Users/Shared/BBDD/clans.csv'
DELIMITER ','
CSV HEADER;

DROP TABLE IF EXISTS friends_aux;
CREATE TABLE friends_aux(
	requester VARCHAR(100),
	requested VARCHAR(100)
);

COPY friends_aux (requester,requested)
FROM '/Users/Shared/BBDD/friends.csv'
DELIMITER ','
CSV HEADER;

DROP TABLE IF EXISTS message_players_aux;
CREATE TABLE message_players_aux(
	id INTEGER,
	sender VARCHAR(100),
	receiver VARCHAR(100),
	text VARCHAR(500),
	date DATE,
	answer INTEGER

);

COPY message_players_aux (id,sender,receiver,text,date,answer)
FROM '/Users/Shared/BBDD/messages_between_players.csv'
DELIMITER ','
CSV HEADER;

DROP TABLE IF EXISTS message_clans_aux;
CREATE TABLE message_clans_aux(
	id INTEGER,
	sender VARCHAR(100),
	receiver VARCHAR(100),
	text VARCHAR(500),
	date DATE,
	answer INTEGER

);

COPY message_clans_aux (id,sender,receiver,text,date,answer)
FROM '/Users/Shared/BBDD/messages_to_clans.csv'
DELIMITER ','
CSV HEADER;

DROP TABLE IF EXISTS player_purchases_aux;
CREATE TABLE player_purchases_aux(
	player VARCHAR(100),
	credit_card BIGINT,
	buy_id INTEGER,
	buy_name VARCHAR(100),
	buy_cost FLOAT,
	buy_stock INTEGER,
	date DATE,
	discount FLOAT,
	arenapack_id INTEGER,
	chest_name VARCHAR(100),
	chest_rarity VARCHAR(100),
	chest_unlock_time INTEGER,
	chest_num_cards INTEGER,
	bundle_gold INTEGER,
	bundle_gems INTEGER,
	emote_name VARCHAR(100),
	emote_path VARCHAR(255)
);

COPY player_purchases_aux (player,credit_card,buy_id,buy_name,buy_cost,buy_stock,date,discount,arenapack_id,chest_name,chest_rarity,chest_unlock_time,chest_num_cards,bundle_gold,bundle_gems,emote_name,emote_path)
FROM '/Users/Shared/BBDD/player_purchases.csv'
DELIMITER ','
CSV HEADER;

DROP TABLE IF EXISTS player_aux CASCADE;
CREATE TABLE player_aux(
	tag VARCHAR(100),
	"name" VARCHAR(100),
	experience INTEGER,
	trophies INTEGER,
	cardnumber BIGINT,
	cardexpiry DATE
);
COPY player_aux
FROM '/Users/Shared/BBDD/players.csv'
DELIMITER ','
CSV HEADER;

DROP TABLE IF EXISTS player_quest_aux;
CREATE TABLE player_quest_aux (
	player_tag VARCHAR(100),
	quest_id INTEGER,
	quest_title VARCHAR(100),
	quest_description VARCHAR(100),
	quest_requirement VARCHAR(100),
	quest_depends INTEGER,
	unlock DATE
);
COPY player_quest_aux
FROM '/Users/Shared/BBDD/players_quests.csv'
DELIMITER ','
CSV HEADER;

DROP TABLE IF EXISTS player_achievement_aux;
CREATE TABLE player_achievement_aux(
	player VARCHAR(100),
	"name" VARCHAR(100),
	description VARCHAR(255),
	arena INTEGER,
	"date" DATE,
	gems INTEGER
);
COPY player_achievement_aux
FROM '/Users/Shared/BBDD/playersachievements.csv'
DELIMITER ','
CSV HEADER;

DROP TABLE IF EXISTS player_badge_aux;
CREATE TABLE player_badge_aux(
	player VARCHAR(100),
	"name" VARCHAR(100),
	arena INTEGER,
	"date" DATE,
	img VARCHAR(100)
);
COPY player_badge_aux
FROM '/Users/Shared/BBDD/playersbadge.csv'
DELIMITER ','
CSV HEADER;

DROP TABLE IF EXISTS player_card_aux;
CREATE TABLE player_card_aux(
	player VARCHAR(100),
	"id" INTEGER,
	"name" VARCHAR(100),
	"level" INTEGER,
	amount INTEGER,
	"date" TIMESTAMP
);
COPY player_card_aux
FROM '/Users/Shared/BBDD/playerscards.csv'
DELIMITER ','
CSV HEADER;

DROP TABLE IF EXISTS player_clan_aux;
CREATE TABLE player_clan_aux(
	player VARCHAR(100),
	clan VARCHAR(100),
	"role" VARCHAR(300),
	"date" DATE
);
COPY player_clan_aux
FROM '/Users/Shared/BBDD/playersClans.csv'
DELIMITER ','
CSV HEADER;

DROP TABLE IF EXISTS player_clan_donation_aux;
CREATE TABLE player_clan_donation_aux(
	player VARCHAR(100),
	clan VARCHAR(100),
	gold INTEGER,
	"date" DATE
);
COPY player_clan_donation_aux
FROM '/Users/Shared/BBDD/playersClansdonations.csv'
DELIMITER ','
CSV HEADER;

DROP TABLE IF EXISTS player_deck_aux;
CREATE TABLE player_deck_aux(
	player VARCHAR(100),
	deck INTEGER,
	title VARCHAR(100),
	description VARCHAR(500),
	"date" DATE,
	card INTEGER,
	"level" INTEGER
);
COPY player_deck_aux
FROM '/Users/Shared/BBDD/playersdeck.csv'
DELIMITER ','
CSV HEADER;

DROP TABLE IF EXISTS quest_arena_aux;
CREATE TABLE quest_arena_aux(
	quest_id INTEGER,
	arena_id INTEGER,
	gold INTEGER,
	experience INTEGER
);
COPY quest_arena_aux
FROM '/Users/Shared/BBDD/quests_arenas.csv'
DELIMITER ','
CSV HEADER;

DROP TABLE IF EXISTS season_aux;
CREATE TABLE season_aux(
	"name" VARCHAR(100),
	startDate DATE,
	endDate DATE
);
COPY season_aux
FROM '/Users/Shared/BBDD/seasons.csv'
DELIMITER ','
CSV HEADER;

DROP TABLE IF EXISTS shared_deck_aux;
CREATE TABLE shared_deck_aux(
	deck INTEGER,
	player VARCHAR(100)
);
COPY shared_deck_aux
FROM '/Users/Shared/BBDD/shared_decks.csv'
DELIMITER ','
CSV HEADER;

DROP TABLE IF EXISTS technology_aux;
CREATE TABLE technology_aux(
	technology VARCHAR(100),
	"cost" INTEGER,
	max_level INTEGER,
	prerequisite VARCHAR(100),
	prereq_level INTEGER,
	mod_damage INTEGER,
	mod_hit_speed INTEGER,
	mod_radius INTEGER,
	mod_spawn_damage INTEGER,
	mod_lifetime INTEGER,
	description VARCHAR(500)
);
COPY technology_aux FROM '/Users/Shared/BBDD/technologies.csv'
DELIMITER ','
CSV HEADER;

-- Custom Auxiliary Tables
DROP TABLE IF EXISTS reward_aux;
CREATE TABLE reward_aux (
    id_reward INTEGER,
    trophies_needed INTEGER
);
COPY reward_aux
FROM '/Users/Shared/BBDD/rewards.csv'
DELIMITER ','
CSV HEADER;

DROP TABLE IF EXISTS clan_badge_aux;
CREATE TABLE clan_badge_aux(
	battle VARCHAR,
	clan VARCHAR(100),
	badge VARCHAR(100),
	url VARCHAR(100)
);

COPY clan_badge_aux 
FROM '/Users/Shared/BBDD/clan_badge.csv'
DELIMITER ','
CSV HEADER;

ALTER TABLE clan_badge_aux ALTER COLUMN battle TYPE INTEGER USING battle::integer;

DROP TABLE IF EXISTS complete_aux CASCADE;
CREATE TABLE complete_aux (
    id_battle INTEGER NOT NULL,
    id_player VARCHAR(255) NOT NULL,
    id_sand INTEGER NOT NULL,
    season VARCHAR(255) NOT NULL,
    FOREIGN KEY (id_battle) REFERENCES battle (id_battle),
    FOREIGN KEY (id_player) REFERENCES player (id_player),
    FOREIGN KEY (id_sand) REFERENCES sand (id),
    FOREIGN KEY (season) REFERENCES season (id_name),
    PRIMARY KEY (id_battle, id_player, id_sand)
);

DROP TABLE IF EXISTS is_found_aux;
CREATE table is_found_aux(
	chest INTEGER,
	mission INTEGER
);
COPY is_found_aux
FROM '/Users/Shared/BBDD/is_found.csv'
DELIMITER ','
CSV HEADER;

-- DELETE PART 
DELETE FROM buys;
DELETE FROM is_found;
DELETE FROM obtains;
DELETE FROM friend;
DELETE FROM reward;
DELETE FROM chest;
DELETE FROM emoticon;
DELETE FROM bundle;
DELETE FROM belongs;
DELETE FROM sand_pack;
DELETE FROM article;
DELETE FROM shop;
DELETE FROM message;
DELETE FROM modify;
DELETE FROM requires;
DELETE FROM need;
DELETE FROM technology;
DELETE FROM structure;
DELETE FROM modifier;
DELETE FROM win;
DELETE FROM fight;
DELETE FROM give;
DELETE FROM joins;
DELETE FROM role;
DELETE FROM "group";
DELETE FROM stack;
DELETE FROM owns;
DELETE FROM level;
DELETE FROM enchantment;
DELETE FROM troop;
DELETE FROM building;
DELETE FROM complete;
DELETE FROM frees;
DELETE FROM badge;
DELETE FROM credit_card;
DELETE FROM accepts;
DELETE FROM depends;
DELETE FROM mission;
DELETE FROM gets;
DELETE FROM success;
DELETE FROM season;
DELETE FROM card;
DELETE FROM sand;
DELETE FROM clan;
DELETE FROM card;
DELETE FROM rarity;
DELETE FROM battle;
DELETE FROM clan_battle;
DELETE FROM player;

-- NOW MIGRATE THE DATA --

-- PLAYER
DELETE FROM player;
INSERT INTO player(id_player, name, exp, trophies, gold, gems)
SELECT  tag, name, experience, trophies, random() * (10000 - 25 + 1) + 25, random() * (10000 - 25 + 1) + 25 FROM player_aux;

-- Sand
-- Insert into sand the data from the auxiliary table (sand_aux, quest_arena)
DELETE FROM sand; -- bypass warning
INSERT INTO sand(id, title, max_trophies, min_trophies, reward_in_exp, reward_in_gold)
SELECT sand_aux.id, name, AVG(maxTrophies), AVG(minTrophies), AVG(experience), AVG(gold)
FROM sand_aux, quest_arena_aux
WHERE quest_arena_aux.arena_id = sand_aux.id
GROUP BY id, name;

-- Season
-- Insert into season the data from the old database (season_aux)
DELETE FROM season;
INSERT INTO season(id_name, start_date, end_date)
SELECT name, startDate, endDate FROM season_aux;

-- Success
-- Explanation: the name has to be unique, so that's the reason we are using GROUP BY statement.
-- For the gems, each success has the same gems, so make the average will not be a problem.
DELETE FROM success;
INSERT INTO success(id_title, gems_reward)
SELECT name, AVG(gems)
FROM player_achievement_aux
GROUP BY name;

-- Gets
-- Union of the tables: player - gets - success
DELETE FROM gets;
INSERT INTO gets(id_success, id_player) SELECT name, pa.player FROM player_achievement_aux AS pa;

-- Mission
-- mission(id_mission(PK), task_description)
DELETE FROM mission;
INSERT INTO mission(id_mission, task_description) SELECT DISTINCT quest_id, quest_requirement FROM player_quest_aux GROUP BY quest_id, quest_requirement;

-- Depends
-- A mission CAN depend on another one
-- Keep in consider that id_mission_1 and id_mission_2 ARE NOT FK's because it is optional so it would violate not-null constraint.
-- See more here: https://bit.ly/3zoaHCL
DELETE FROM depends;
INSERT INTO depends(id_mission_1, id_mission_2) SELECT DISTINCT quest_id, quest_depends FROM player_quest_aux;

-- Accepts
-- Explanation: a player can accept a mission, so this table is the union/relation of the missions that a player has accepted.
-- We have another problem. We don't know if that mission is completed in order to unlock another ones.
-- We have the "unlock" field but is a date. So in order to not to store empty data in the "completed" field, I have filled in those missions that
-- are unlocked for now. So we will have to supose they are completed. Fault of us? I don't believe so.
DELETE FROM accepts;
INSERT INTO accepts(id_mission, id_player, is_completed) SELECT DISTINCT quest_id, player_tag, unlock < NOW() AS completed FROM player_quest_aux;

-- Credit Card
-- Explanation: the id is not here because id_credit_card is a SERIAL type although a card number is already unique.
-- The date, as I have supposed, is the expiration date of the card, but that field is not in the importation data, so I have filled it with the purchase date.
-- Is not a good way to do so, but the field is there and we have to fill out with any value. We can not store empty data. Fault of us.
DELETE FROM credit_card;
INSERT INTO credit_card(datetime, number) SELECT  date, credit_card FROM player_purchases_aux;

-- Badge
-- Explanation: the table player_badge has all the badges that a player has, but in the table badge we have all the badges that exist in the game.
-- So we will need to extract the unique badges from the player_badge table and insert them in the badge table.
-- That is made by the GROUP BY statement.
DELETE FROM badge;
INSERT INTO badge(id_title, image_path) SELECT name, img FROM player_badge_aux GROUP BY name, img;

--Badge de clan
INSERT INTO badge(id_title, image_path) SELECT DISTINCT cb.badge, cb.url FROM clan_badge_aux AS cb;

-- Frees
-- Explanation: not a lot of things to explain here, basically we are making the union of the badges that a player has released within a sand.
DELETE FROM frees;
INSERT INTO frees(id_badge, id_player, id_sand) SELECT pa.name, pa.player, pa.arena FROM player_badge_aux AS pa;
select * from frees;

--Clan_battle
DELETE FROM clan_battle;
INSERT INTO clan_battle(clan_battle, start_date, end_date)
SELECT DISTINCT cb.battle, cb.start_date, cb.end_date
FROM clan_battle_aux AS cb 
GROUP BY cb.battle, cb.start_date, cb.end_date;

-- Battle
-- Explanation: we have datetime and duration given from the auxiliary table. For points we have selected 'winner', for trophies_played and gold_played we have generated random values.
INSERT INTO battle(datetime, duration, points, trophies_played, gold_played, clan_battle) 
SELECT date, duration, winner, floor(random() * 50 + 1)::int, floor(random() * 2000 + 1)::int, clan_battle
FROM battle_aux;


-- Complete
-- Explanation: we are importing the data from a csv.

-- Union between battle and battle_aux (id's)
SELECT id_battle, winner, loser, battle.duration, datetime, points, winner_score, loser_score FROM battle, battle_aux WHERE battle.duration = battle_aux.duration AND battle.datetime = battle_aux.date;

-- winners
SELECT id_battle, player, winner, loser, battle.duration, datetime, points, winner_score, loser_score
FROM battle, battle_aux, player_deck_aux
WHERE battle.duration = battle_aux.duration
        AND battle.datetime = battle_aux.date
        AND (battle_aux.winner = player_deck_aux.deck OR battle_aux.loser = player_deck_aux.deck)
GROUP BY id_battle, player, winner, loser, battle.duration, datetime, points, winner_score, loser_score;

-- losers
SELECT id_battle, player, winner, loser, battle.duration, datetime, points, winner_score, loser_score
FROM battle, battle_aux, player_deck_aux
WHERE battle.duration = battle_aux.duration
        AND battle.datetime = battle_aux.date
        AND battle_aux.loser = player_deck_aux.deck
GROUP BY id_battle, player, winner, loser, battle.duration, datetime, points, winner_score, loser_score;


-- losers reduced
DROP TABLE IF EXISTS complete_aux;
CREATE TABLE complete_aux (
    id_battle INTEGER,
    id_player VARCHAR(255)
);

INSERT INTO complete_aux (id_battle, id_player)
SELECT id_battle, player AS id_player
FROM battle, battle_aux, player_deck_aux
WHERE battle.duration = battle_aux.duration
    AND battle.datetime = battle_aux.date
    AND (battle_aux.loser = player_deck_aux.deck OR battle_aux.winner = player_deck_aux.deck)
GROUP BY id_battle, player, winner, loser, battle.duration, datetime, points;

-- Alter creating a new column called "id_sand" in losers_reduced
ALTER TABLE complete_aux ADD COLUMN id_sand INTEGER;
ALTER TABLE complete_aux ADD COLUMN id_season VARCHAR(100);
ALTER TABLE complete_aux ADD COLUMN datetime DATE;

-- Fill id_sand with random values between 54000000 and 54000058
UPDATE complete_aux SET id_sand = floor(random()*(54000058-54000000+1))+54000000;
UPDATE complete_aux SET id_season = 'T' || floor(random() * 9 + 1)::int;
UPDATE complete_aux SET datetime = date_trunc('day', now() - (random() * (now() - '2018-01-01')::interval));

DELETE FROM complete;
INSERT INTO complete(id_battle, id_player, id_sand, season, datetime) SELECT id_battle, id_player, complete_aux.id_sand, id_season, complete_aux.datetime FROM complete_aux;
SELECT * FROM complete;

-- RARITY
DELETE FROM rarity;
INSERT INTO rarity(degree, multiplicative_factor)
SELECT rarity, random() * (10000 - 25 + 1) + 25 FROM card_aux
GROUP BY rarity;

-- CARD
DELETE FROM card;
INSERT INTO card(id_card_name, damage, attack_speed, rarity, sand)
SELECT name, damage, hit_speed, rarity, arena FROM card_aux;

-- BUILDING
DELETE FROM building;
INSERT INTO building (building_name, life)
SELECT name, lifetime FROM card_aux AS card
WHERE card.lifetime IS NOT NULL;

-- TROOP
DELETE FROM troop;
    INSERT INTO troop (troop_name, spawn_damage)
    SELECT name, spawn_damage FROM card_aux AS card
    WHERE card.spawn_damage IS NOT NULL;

-- ENCHANTMENT
DELETE FROM enchantment;
INSERT INTO enchantment (enchantment_name, effect_radius)
SELECT name, radious FROM card_aux AS card
WHERE card.radious IS NOT NULL;

-- LEVEL
INSERT INTO level(level, statistics_multiplier, improvement_cost)
SELECT level,  random() * (10000 - 25 + 1) + 25,  random() * (10000 - 25 + 1) + 25 FROM player_card_aux GROUP BY level;

-- STACK
INSERT INTO stack(id_stack, name, creation_date, description, id_player)
SELECT  deck, title, date, description, player FROM player_deck_aux GROUP BY deck, title, date, description, player;

-- OWNS
DELETE FROM owns;
INSERT INTO owns(card, level, player, date_level_up, date_found, experience_gained)
SELECT pc.name, pc.level, pc.player, now() , pc.date, random() * (10000 - 25 + 1) + 25 
FROM player_card_aux AS pc JOIN card AS ca ON pc.name = ca.id_card_name;


--GROUP
INSERT INTO "group"(card_name, id_stack)
SELECT DISTINCT c.name, deck FROM player_deck_aux, card_aux AS c;

-- Clan
DELETE FROM clan CASCADE;
INSERT INTO clan (id_clan, clan_name, description, num_min_trophy, total_points, num_trophy, id_player,gold_needed, datetime)
SELECT ca.tag, ca.name, ca.description, ca.requiredTrophies, ca.score, ca.trophies, pc.player, random() * (10000 - 25 + 1) + 25, pc."date"
FROM clans_aux AS ca JOIN player_clan_aux AS pc
ON ca.tag = pc.clan
WHERE pc."role" LIKE 'leader:%';

-- Role
-- ID de SERIAL
DELETE FROM role;
INSERT INTO role(description)
SELECT DISTINCT "role" FROM player_clan_aux;

-- Join
DELETE FROM joins;
INSERT INTO joins(id_clan, id_player, id_role, datetime_in)
SELECT pc.clan, pc.player, ro.id_role, pc."date" FROM player_clan_aux AS pc JOIN role AS ro
ON ro.description = pc."role";

-- Give
DELETE FROM give;
INSERT INTO give(id_clan, id_player, gold, experience, date)
SELECT pd.clan, pd.player, SUM(pd.gold), random() * (10000 - 25 + 1) + 25, pd.date
FROM player_clan_donation_aux AS pd
GROUP BY pd."date", pd.clan, pd.player HAVING SUM(pd.gold) > 0;

--Fight
DELETE FROM fight;
INSERT INTO fight(id_clan,clan_battle)
SELECT clan, battle FROM clan_battle_aux GROUP BY clan, battle;

-- Win
-- Nou CSV
INSERT INTO win(id_clan, id_battle, id_title)
SELECT cb.clan, cb.battle, cb.badge
FROM clan_badge_aux AS cb;

-- Modifier
DELETE FROM modifier;
INSERT INTO modifier(name_modifier, description, cost, damage, attack_speed, effect_radius, spawn_damage, life )
SELECT bu.building, bu.description, bu.cost, bu.mod_damage, bu.mod_hit_speed, bu.mod_radius, bu.mod_spawn_damage, bu.mod_lifetime FROM building_aux AS bu;

INSERT INTO modifier(name_modifier, description, cost, damage, attack_speed, effect_radius, spawn_damage, life )
SELECT te.technology, te.description, te.cost, te.mod_damage, te.mod_hit_speed, te.mod_radius, te.mod_spawn_damage, te.mod_lifetime  FROM technology_aux AS te;

UPDATE modifier SET damage = 0 WHERE damage is null;
UPDATE modifier SET attack_speed = 0 WHERE attack_speed is null;
UPDATE modifier SET effect_radius = 0 WHERE effect_radius is null;
UPDATE modifier SET spawn_damage = 0 WHERE spawn_damage is null;
UPDATE modifier SET life = 0 WHERE life is null;

--STRUCTURE
INSERT INTO structure(name_structure, num_min_trophy)
SELECT bu.building, bu.trophies FROM building_aux AS bu;

--TECHNOLOGY
INSERT INTO technology(name_technology, max_level)
SELECT te.technology, te.max_level FROM technology_aux AS te;


--NEED (structure)
INSERT INTO need(id_structure, pre_structure)
SELECT bu.building, bu.prerequisite FROM building_aux AS bu
WHERE bu.prerequisite is not null;

--REQUIRES(technology)
INSERT INTO requires(id_technology, pre_technology, previous_level)
SELECT te.technology, te.prerequisite, te.prereq_level FROM technology_aux AS te
WHERE te.prerequisite is not null;

---MODIFY
-- TOTES LES CARTES
--Structure
DELETE FROM modify;
INSERT INTO modify(id_clan, name_modifier, card_name, level, date)
SELECT DISTINCT cst.clan, cst.structure, o.card, cst.level, cst.date
FROM clan_tech_structure_aux AS cst JOIN joins AS j ON cst.clan = j.id_clan
JOIN owns AS o ON j.id_player = o.player
JOIN building_aux AS bu ON cst.structure = bu.building
WHERE cst.structure is not null
AND bu.mod_spawn_damage is  null
AND bu.mod_radius is  null
AND bu.mod_lifetime is  null
GROUP BY cst.clan, cst.tech, cst.structure , o.card, cst.level, cst.date
;

--Technology
INSERT INTO modify(id_clan, name_modifier, card_name, level, date)
SELECT DISTINCT cst.clan, cst.tech, o.card, cst.level, cst.date
FROM clan_tech_structure_aux AS cst JOIN joins AS j ON cst.clan = j.id_clan
JOIN owns AS o ON j.id_player = o.player
JOIN technology_aux AS te ON cst.tech = te.technology
WHERE cst.tech is not null
AND te.mod_spawn_damage is  null
AND te.mod_radius is  null
AND te.mod_lifetime is  null
GROUP BY cst.clan, cst.tech, cst.structure , o.card, cst.level, cst.date
;

---TROOP
--Structure
INSERT INTO modify(id_clan, name_modifier, card_name, level, date)
SELECT DISTINCT cst.clan, cst.structure, o.card, cst.level, cst.date
FROM clan_tech_structure_aux AS cst JOIN joins AS j ON cst.clan = j.id_clan
JOIN owns AS o ON j.id_player = o.player
JOIN troop AS tr ON o.card = tr.troop_name
JOIN building_aux AS bu ON cst.structure = bu.building
WHERE cst.structure is not null
AND bu.mod_spawn_damage is not null
GROUP BY cst.clan, cst.tech, cst.structure , o.card, cst.level, cst.date
;

--Technology
INSERT INTO modify(id_clan, name_modifier, card_name, level, date)
SELECT DISTINCT cst.clan, cst.tech, o.card, cst.level, cst.date
FROM clan_tech_structure_aux AS cst JOIN joins AS j ON cst.clan = j.id_clan
JOIN owns AS o ON j.id_player = o.player
JOIN troop AS tr ON o.card = tr.troop_name
JOIN technology_aux AS te ON cst.tech = te.technology
WHERE cst.tech is not null
AND te.mod_spawn_damage is not null
GROUP BY cst.clan, cst.tech, cst.structure , o.card, cst.level, cst.date
;

---BUILDING
--Structure
INSERT INTO modify(id_clan, name_modifier, card_name, level, date)
SELECT DISTINCT cst.clan, cst.structure, o.card, cst.level, cst.date
FROM clan_tech_structure_aux AS cst JOIN joins AS j ON cst.clan = j.id_clan
JOIN owns AS o ON j.id_player = o.player
JOIN building AS b ON o.card = b.building_name
JOIN building_aux AS bu ON cst.structure = bu.building
WHERE cst.structure is not null
AND bu.mod_lifetime is not null
GROUP BY cst.clan, cst.tech, cst.structure , o.card, cst.level, cst.date
;

--Technology
INSERT INTO modify(id_clan, name_modifier, card_name, level, date)
SELECT DISTINCT cst.clan, cst.tech, o.card, cst.level, cst.date
FROM clan_tech_structure_aux AS cst JOIN joins AS j ON cst.clan = j.id_clan
JOIN owns AS o ON j.id_player = o.player
JOIN building AS b ON o.card = b.building_name
JOIN technology_aux AS te ON cst.tech = te.technology
WHERE cst.tech is not null
AND te.mod_lifetime is not null 
GROUP BY cst.clan, cst.tech, cst.structure , o.card, cst.level, cst.date
;

---ENCHANTMENT
--Structure
INSERT INTO modify(id_clan, name_modifier, card_name, level, date)
SELECT DISTINCT cst.clan, cst.structure, o.card, cst.level, cst.date
FROM clan_tech_structure_aux AS cst JOIN joins AS j ON cst.clan = j.id_clan
JOIN owns AS o ON j.id_player = o.player
JOIN enchantment AS en ON o.card = en.enchantment_name
JOIN building_aux AS bu ON cst.structure = bu.building
WHERE cst.structure is not null
AND bu.mod_radius is not null
GROUP BY cst.clan, cst.tech, cst.structure , o.card, cst.level, cst.date
;

--Technology
INSERT INTO modify(id_clan, name_modifier, card_name, level, date)
SELECT DISTINCT cst.clan, cst.tech, o.card, cst.level, cst.date
FROM clan_tech_structure_aux AS cst JOIN joins AS j ON cst.clan = j.id_clan
JOIN owns AS o ON j.id_player = o.player
JOIN enchantment AS en ON o.card = en.enchantment_name
JOIN technology_aux AS te ON cst.tech = te.technology
WHERE cst.tech is not null
AND te.mod_radius is not null 
GROUP BY cst.clan, cst.tech, cst.structure , o.card, cst.level, cst.date
;

-- IMPORTS ARNAU

-- Message
-- aux receiver table for user to user messages
DROP TABLE IF EXISTS receiver;
CREATE TABLE receiver(
	id VARCHAR(255)
);
INSERT INTO receiver (id)
SELECT id_player FROM player;

DELETE FROM message;
INSERT INTO message (id_message, issue, datetime, id_owner, id_replier, id_reply)
SELECT mp.id, mp.text, mp.date, mp.sender, mp.receiver, mp.answer
FROM message_players_aux AS mp
JOIN player AS p ON p.id_player = sender
JOIN receiver AS r ON r.id = receiver;

INSERT INTO message (id_message, issue, datetime, id_owner, id_replier, id_reply)
SELECT mc.id + MAX(mp.id), mc.text, mc.date, mc.sender, mc.receiver, mc.answer + MAX(mp.id)
FROM message_clans_aux AS mc
JOIN player AS p ON p.id_player = sender
JOIN clan AS c ON c.id_clan = receiver,
message_players_aux AS mp
GROUP BY mc.id, mc.text, mc.date, mc.sender, mc.receiver, mc.answer; 

-- Shop
INSERT INTO shop(id_shop_name, available_gems)
VALUES ('SHOP', random() * (10000 - 25 + 1) + 25);

-- Article
DELETE FROM article;

-- Sand_pack
-- auxiliar relation counter
DROP TABLE IF EXISTS counter;
CREATE TABLE counter(
	id_article SERIAL,
	id_sand_pack INTEGER
);

INSERT INTO counter (id_sand_pack)
SELECT pp.arenapack_id
FROM player_purchases_aux AS pp
WHERE pp.arenapack_id is not null
GROUP BY pp.arenapack_id
ORDER BY pp.arenapack_id ASC;

INSERT INTO article(name, real_price, times_purchasable, id_shop_name)
SELECT 'SAND_PACK', MAX(pp.buy_cost), SUM(pp.buy_stock), s.id_shop_name 
FROM player_purchases_aux AS pp,
shop AS s
WHERE pp.arenapack_id is not null
GROUP BY pp.arenapack_id, s.id_shop_name
ORDER BY pp.arenapack_id ASC;

-- hemos quitado el campo gems_contained de la tabla sand_pack
DELETE FROM sand_pack;
INSERT INTO sand_pack (id_sand_pack)
SELECT id_article
FROM counter
ORDER BY id_article ASC;

DELETE FROM belongs;
INSERT INTO belongs (id_sand_pack, id_sand, gold_contained)
SELECT c.id_article, sp.arena, sp.gold
FROM sand_pack_aux AS sp,
counter AS c
WHERE c.id_sand_pack = sp.id;

DROP TABLE IF EXISTS counter;

-- Bundle
DROP TABLE IF EXISTS counter;
CREATE TABLE counter(
	id_article SERIAL,
	num_sand_pack INTEGER,
	buy_cost FLOAT,
	gold INTEGER,
	gems INTEGER
);

INSERT INTO counter (num_sand_pack, buy_cost, gold, gems)
SELECT DISTINCT MAX(a.id_article), pp.buy_cost, pp.bundle_gold, pp.bundle_gems
FROM player_purchases_aux AS pp,
article AS a
WHERE pp.bundle_gold is not null
GROUP BY pp.buy_cost, pp.bundle_gold, pp.bundle_gems
ORDER BY pp.buy_cost ASC;

INSERT INTO article(name, real_price, times_purchasable, id_shop_name)
SELECT DISTINCT 'BUNDLE', pp.buy_cost, pp.buy_stock, s.id_shop_name 
FROM player_purchases_aux AS pp,
shop AS s
WHERE pp.bundle_gold is not null
ORDER BY pp.buy_cost ASC;

DELETE FROM bundle;
INSERT INTO bundle(id_bundle, gold_contained, gems_contained)
SELECT id_article + num_sand_pack, gold, gems
FROM counter
ORDER BY id_article ASC;

-- Emoticon
DROP TABLE IF EXISTS counter;
CREATE TABLE counter(
	id_article SERIAL,
	num_articles INTEGER,
	buy_cost FLOAT,
	path VARCHAR(255)
);

INSERT INTO counter (num_articles, buy_cost, path)
SELECT DISTINCT MAX(a.id_article), pp.buy_cost, pp.emote_path
FROM player_purchases_aux AS pp,
article AS a
WHERE pp.emote_name is not null
AND pp.emote_path is not null
GROUP BY pp.buy_cost, pp.emote_path
ORDER BY pp.buy_cost ASC;

INSERT INTO article(name, real_price, times_purchasable, id_shop_name)
SELECT DISTINCT pp.emote_name, pp.buy_cost, pp.buy_stock, s.id_shop_name 
FROM player_purchases_aux AS pp,
shop AS s
WHERE pp.emote_name is not null
AND pp.emote_path is not null
ORDER BY pp.buy_cost ASC;

DELETE FROM emoticon;
INSERT INTO emoticon(id_emoticon, path)
SELECT id_article + num_articles, path
FROM counter
ORDER BY id_article ASC;

-- Chest
DROP TABLE IF EXISTS counter;
CREATE TABLE counter(
	id_article SERIAL,
	num_articles INTEGER,
	buy_cost FLOAT,
	chest_rarity VARCHAR(255),
	chest_unlock_time INTEGER,
	chest_num_cards VARCHAR(255)
);

INSERT INTO counter (num_articles, buy_cost, chest_rarity, chest_unlock_time, chest_num_cards)
SELECT DISTINCT MAX(a.id_article), pp.buy_cost, pp.chest_rarity, pp.chest_unlock_time, pp.chest_num_cards
FROM player_purchases_aux AS pp,
article AS a
WHERE pp.chest_rarity is not null
AND pp.chest_name is not null
AND pp.chest_unlock_time is not null
AND pp.chest_num_cards is not null
GROUP BY pp.buy_cost, pp.chest_rarity, pp.chest_unlock_time, pp.chest_num_cards
ORDER BY pp.buy_cost ASC;

INSERT INTO article(name, real_price, times_purchasable, id_shop_name)
SELECT DISTINCT pp.chest_name, pp.buy_cost, pp.buy_stock, s.id_shop_name 
FROM player_purchases_aux AS pp,
shop AS s
WHERE pp.chest_name is not null
AND pp.chest_rarity is not null
AND pp.chest_unlock_time is not null
AND pp.chest_num_cards is not null
ORDER BY pp.buy_cost ASC;

DELETE FROM chest;
INSERT INTO chest(id_chest, rarity, unlocking_time, gold_contained, gems_contained)
SELECT id_article + num_articles, chest_rarity, chest_unlock_time, random() * (1000 - 25 + 1) + 25, random() * (5 - 25 + 1) + 25
FROM counter
ORDER BY id_article ASC;

-- Reward
DELETE FROM reward;
INSERT INTO reward (id_reward, trophies_needed)
SELECT DISTINCT id_reward, MAX(trophies_needed)
FROM reward_aux
GROUP BY id_reward;

-- Friend
DELETE FROM friend;
INSERT INTO friend(id_player1, id_player2)
SELECT requester, requested
FROM friends_aux
JOIN player AS p ON p.id_player = requester
JOIN receiver AS r ON r.id = requested;

DROP TABLE IF EXISTS receiver;

-- Obtains
DELETE FROM obtains;
INSERT INTO obtains(id_success, id_player)
SELECT pa.name, pa.player
FROM player_achievement_aux AS pa
JOIN player AS p ON p.id_player = pa.player
JOIN success AS s ON s.id_title = pa.name;

-- Is found
DELETE FROM is_found;
INSERT INTO is_found(id_chest, id_mission)
SELECT DISTINCT isf.chest, isf.mission
FROM is_found_aux AS isf
JOIN chest AS c ON c.id_chest = isf.chest;

-- Pays
/*DELETE FROM pays;
INSERT INTO pays(id_player, id_credit_card, datetime, discount)
SELECT DISTINCT pp.player, pp.credit_card, pp.date, pp.discount
FROM player_purchases_aux AS pp
JOIN player AS p ON p.id_player = pp.player
JOIN credit_card AS cc ON cc.number = pp.credit_card;*/

-- Buys
DELETE FROM buys;
INSERT INTO buys(id_shop_name, id_player, id_card_name, datetime)
SELECT s.id_shop_name, '#LVRUV8YV', 'Knight', '2022-1-14 21:19:00'
FROM shop AS s;
