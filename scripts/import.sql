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
FROM 'C:\Users\Shared\BBDD\clan_badge.csv'  --canvi dirrecció
DELIMITER ','
CSV HEADER;

ALTER TABLE clan_badge_aux ALTER COLUMN battle TYPE INTEGER USING battle::integer;


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


-- Frees
-- Explanation: not a lot of things to explain here, basically we are making the union of the badges that a player has released within a sand.
DELETE FROM frees;
INSERT INTO frees(id_badge, id_player, id_sand) SELECT pa.name, pa.player, pa.arena FROM player_badge_aux AS pa;

-- Battle
-- Explanation: we have datetime and duration given from the auxiliary table. For points we have selected 'winner', for trophies_played and gold_played we have generated random values.

INSERT INTO battle(datetime, duration, points, trophies_played, gold_played) 
SELECT date, duration, winner, floor(random() * 50 + 1)::int, floor(random() * 2000 + 1)::int 
FROM battle_aux;
--INSERT INTO badge(id_title, image_path) SELECT DISTINCT cb.badge, cb.url FROM clan_badge_aux AS cb;

-- Complete
-- Explanation: this is the most complex table.
-- INSERT INTO complete(id_battle, id_player, id_sand, victories_count, defeat_count, points_count, season) SELECT battle, player, sand FROM battle, player, sand WHERE battle.id_battle = player.id_player AND battle.id_battle = sand.id_title;

-- Imports Angel

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

-- Imports Arnau

-- Shop
INSERT INTO shop(id_shop_name, available_gems)
VALUES ('SHOP', random() * (10000 - 25 + 1) + 25);

INSERT INTO friend(id_player1, id_player2)
SELECT requester, requested
FROM friends_aux;

-- TODO: no hay artículos
INSERT INTO pays(id_player, id_credit_card, id_article, datetime, discount)
SELECT pp.player, pp.credit_card, a.id_article, pp.date, pp.discount
FROM player_purchases_aux AS pp
JOIN article AS a ON a.times_purchasable = pp.buy_stock;

/*INSERT INTO buys(id_shop_name, id_player, id_credit_card, datetime)
SELECT s.id_shop_name, pp.player, pp.credit_card, pp.date
FROM player_purchases_aux AS pp, shop AS s, credit_card AS cc
WHERE credit_card = cc.number
GROUP BY s.id_shop_name, pp.player, pp.credit_card, pp.date;*/

INSERT INTO obtains(id_success, id_player)
SELECT "name", player
FROM player_achievement_aux;

-- TODO: tabla is_found: escoger de manera aleatoria los ID's de chest y de misión.

-- hemos quitado el campo gems_contained de la tabla sand_pack
-- TODO: como conectamos esta tabla con article?
/*INSERT INTO sand_pack(id_sand_pack, id_sand, gold_contained)
SELECT "id", MAX(arena), MAX(gold)
FROM sand_pack_aux GROUP BY id;*/

-- OJO: hemos puesto el campo id_reply que es el id del mensaje al que se responde.
-- OJO hay que tener dos tablas porque si no hay conflictos con los ids. Y los ids no los podemos autogenerar nosotros porque las referencias de reply se perderían.
/*DELETE FROM message;
INSERT INTO message (id_message, issue, datetime, id_owner, id_replier, id_reply)
SELECT "id", "text", "date", sender, receiver, answer
FROM message_players_aux;

INSERT INTO "message" (id_message, issue, datetime, id_clan, id_replier, id_reply)
SELECT "id", "text", "date", sender, receiver, answer
FROM message_clans_aux;*/

-- Article
-- INSERT INTO article(name, real_price, times_purchasable)
-- SELECT pp.pp.buy_cost/pp.buy_stock, pp.buy_stock
-- FROM player_purchases_aux AS pp;

/*INSERT INTO bundle(id_bundle, gold_contained, gems_contained)
SELECT (a.id_article, pp.bundle_gold, pp.bundle_gems)
FROM player_purchases_aux AS pp
JOIN article AS a ON a.times_purchasable = pp.buy_stock
WHERE pp.bundle_gold > 0 OR pp.bundle_gems > 0;*/

/*INSERT INTO emoticon(id_emoticon, emoticon_name, "path")
SELECT (a.id_article, pp.emote_name, pp.emote_path)
FROM player_purchases_aux AS pp
JOIN article AS a ON a.times_purchasable = pp.buy_stock
WHERE pp.emote_path != null;

INSERT INTO chest(id_chest, rarity, unlocking_time)
SELECT (a.id_article, pp.chest_rarity, pp.chest_unlock_time)
FROM player_purchases_aux AS pp
JOIN article AS a ON a.times_purchasable = pp.buy_stock
WHERE pp.chest_rarity != null;*/

--Imports MAR

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

DELETE FROM clan_battle;
INSERT INTO clan_battle(clan_battle, start_date, end_date)
SELECT DISTINCT cb.battle, cb.start_date, cb.end_date
FROM clan_battle_aux AS cb
GROUP BY cb.battle, cb.start_date, cb.end_date;

DELETE FROM fight;
INSERT INTO fight(clan_battle, battle)
SELECT cb.battle, ba.id_battle
FROM clan_battle_aux AS cb JOIN battle_aux AS b ON cb.battle= b.clan_battle
, battle AS ba
WHERE b.duration = ba.duration
AND b.date = ba.datetime
GROUP BY cb.battle, ba.id_battle;

DELETE FROM battle_clan;
INSERT INTO battle_clan(id_clan,clan_battle)
SELECT clan, battle FROM clan_battle_aux;

-- Win
/*-- Nou CSV
INSERT INTO win(id_clan, id_battle, id_title)
SELECT cb.clan, cb.battle, cb.badge
FROM clan_badge_aux AS cb;*/

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
-- need(id_structure1, id_structure2)
--Flaten pre
INSERT INTO need(id_structure, pre_structure)
SELECT bu.building, bu.prerequisite FROM building_aux AS bu
WHERE bu.prerequisite is not null;

--REQUIRES
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
