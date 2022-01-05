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
	"date" DATE
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
	mod_hit_speed VARCHAR(100),
	mod_radius INTEGER,
	mod_spawn_damage VARCHAR(100),
	mod_lifetime VARCHAR(100),
	description VARCHAR(500)
);
COPY technology_aux FROM '/Users/Shared/BBDD/technologies.csv'
DELIMITER ','
CSV HEADER;

-- NOW MIGRATE THE DATA --

-- Sand
-- Insert into sand the data from the auxiliary table (sand_aux, quest_arena)
DELETE FROM sand WHERE sand.id_title LIKE '%'; -- bypass warning
INSERT INTO sand(id_title, max_trophies, min_trophies, reward_in_exp, reward_in_gold)
SELECT name, AVG(maxTrophies), AVG(minTrophies), AVG(experience), AVG(gold)
FROM sand_aux, quest_arena_aux
WHERE quest_arena_aux.arena_id = sand_aux.id
GROUP BY name;

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
INSERT INTO mission(id_mission, task_description) SELECT quest_id, quest_requirement FROM player_quest_aux GROUP BY quest_id, quest_requirement;

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

-- Frees
-- Explanation: not a lot of things to explain here, basically we are making the union of the badges that a player has released within a sand.
DELETE FROM frees;
INSERT INTO frees(id_badge, id_player, id_sand) SELECT pa.name, pa.player, pa.arena FROM player_badge_aux AS pa;
