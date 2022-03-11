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
	winner VARCHAR(100),
	loser VARCHAR(100),
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
	deck VARCHAR(100),
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
DELETE FROM pays;
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
DELETE FROM share_stack;
DELETE FROM stack;
DELETE FROM owns;
DELETE FROM level;
DELETE FROM enchantment;
DELETE FROM troop;
DELETE FROM building;
DELETE FROM takes_place;
DELETE FROM frees;
DELETE FROM badge;
DELETE FROM possesses;
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
INSERT INTO player(id_player, name, exp, trophies, gold, gems)
SELECT  tag, name, experience, trophies, random() * (10000 - 25 + 1) + 25, random() * (10000 - 25 + 1) + 25 FROM player_aux;

-- Sand
-- Insert into sand the data from the auxiliary table (sand_aux, quest_arena)
INSERT INTO sand(id, title, max_trophies, min_trophies, reward_in_exp, reward_in_gold)
SELECT sand_aux.id, name, AVG(maxTrophies), AVG(minTrophies), AVG(experience), AVG(gold)
FROM sand_aux, quest_arena_aux
WHERE quest_arena_aux.arena_id = sand_aux.id
GROUP BY id, name;

-- Season
-- Insert into season the data from the old database (season_aux)
INSERT INTO season(id_name, start_date, end_date)
SELECT name, startDate, endDate FROM season_aux;

-- Success
-- Explanation: the name has to be unique, so that's the reason we are using GROUP BY statement.
-- For the gems, each success has the same gems, so make the average will not be a problem.
INSERT INTO success(id_title, gems_reward)
SELECT DISTINCT name, gems
FROM player_achievement_aux
GROUP BY name, gems;

-- Gets
-- Union of the tables: player - gets - success
INSERT INTO gets(id_success, id_player) SELECT name, pa.player FROM player_achievement_aux AS pa;

-- Mission
-- mission(id_mission(PK), task_description)
INSERT INTO mission(id_mission, title, task_description) SELECT DISTINCT quest_id, quest_title, quest_requirement  FROM player_quest_aux;
-- Depends
-- A mission CAN depend on another one
-- Keep in consider that id_mission_1 and id_mission_2 ARE NOT FK's because it is optional so it would violate not-null constraint.
-- See more here: https://bit.ly/3zoaHCL
INSERT INTO depends(id_mission_1, id_mission_2) SELECT DISTINCT quest_id, quest_depends FROM player_quest_aux;

-- Accepts
-- Explanation: a player can accept a mission, so this table is the union/relation of the missions that a player has accepted.
-- We have another problem. We don't know if that mission is completed in order to unlock another ones.
-- We have the "unlock" field but is a date. So in order to not to store empty data in the "completed" field, I have filled in those missions that
-- are unlocked for now. So we will have to supose they are completed. Fault of us? I don't believe so.
INSERT INTO accepts(id_mission, id_player, id_sand, is_completed)
SELECT DISTINCT player_quest_aux.quest_id, player_tag, quest_arena_aux.arena_id, unlock < NOW() AS completed
FROM player_quest_aux INNER JOIN quest_arena_aux ON player_quest_aux.quest_id = quest_arena_aux.quest_id;

-- Credit Card
INSERT INTO credit_card(number) SELECT DISTINCT credit_card FROM player_purchases_aux;

-- Possesses
INSERT INTO possesses(card_number, id_player) SELECT DISTINCT credit_card, player FROM player_purchases_aux;

-- Badge
-- Explanation: the table player_badge has all the badges that a player has, but in the table badge we have all the badges that exist in the game.
-- So we will need to extract the unique badges from the player_badge table and insert them in the badge table.
-- That is made by the GROUP BY statement.
INSERT INTO badge(id_title, image_path) SELECT name, img FROM player_badge_aux GROUP BY name, img;

--Badge de clan
INSERT INTO badge(id_title, image_path) SELECT DISTINCT cb.badge, cb.url FROM clan_badge_aux AS cb;

-- Frees
-- Explanation: not a lot of things to explain here, basically we are making the union of the badges that a player has released within a sand.
INSERT INTO frees(id_badge, id_player, id_sand, date) SELECT pa.name, pa.player, pa.arena, pa.date FROM player_badge_aux AS pa;

--Clan_battle
INSERT INTO clan_battle(clan_battle, start_date, end_date)
SELECT DISTINCT cb.battle, cb.start_date, cb.end_date
FROM clan_battle_aux AS cb;
-- Battle
-- Explanation: we have datetime and duration given from the auxiliary table. For points we have selected 'winner', for trophies_played and gold_played we have generated random values.
/* In the battle table we have:
   - winner (references to player_deck_aux.deck) it is INTEGER
   - loser (references to player_deck_aux.deck) it is INTEGER
   We need to fill this table with the winner and the loser with the player ids. So the result may be:
 */
-- UPDATE battle SET winner = (SELECT player FROM player_deck_aux WHERE deck = winner), loser = (SELECT player FROM player_deck_aux WHERE deck = loser);
INSERT INTO battle (datetime, duration, points, trophies_played, gold_played, winner, loser, clan_battle)
SELECT DISTINCT battle_aux.date,
                battle_aux.duration,
                floor(random() * 2000 + 1)::int,
                floor(random() * 2000 + 1)::int,
                floor(random() * 2000 + 1)::int,
                (SELECT player FROM player_deck_aux WHERE deck = winner LIMIT 1),
                (SELECT player FROM player_deck_aux WHERE deck = loser LIMIT 1),
                battle_aux.clan_battle
FROM battle_aux;

-- Takes Place
-- Explanation: a battle takes place in one arena (a.k.a sand) and in one season.
-- So we have to make the union of the battles that take place in the same sand and in the same season.
INSERT INTO takes_place(id_battle, id_sand, id_season, datetime)
SELECT id_battle,
       floor(random()*(54000058-54000000+1))+54000000, 'T' || floor(random() * 9 + 1)::int,
       date_trunc('day', now() - (random() * (now() - '2018-01-01')::interval))
FROM battle;

-- RARITY
INSERT INTO rarity(degree, multiplicative_factor)
SELECT rarity, random() * (10000 - 25 + 1) + 25 FROM card_aux
GROUP BY rarity;

-- CARD
INSERT INTO card(id_card_name, damage, attack_speed, rarity, sand)
SELECT name, damage, hit_speed, rarity, arena FROM card_aux;

-- BUILDING
INSERT INTO building (building_name, life)
SELECT name, lifetime FROM card_aux AS card
WHERE card.lifetime IS NOT NULL;

-- TROOP
    INSERT INTO troop (troop_name, spawn_damage)
    SELECT name, spawn_damage FROM card_aux AS card
    WHERE card.spawn_damage IS NOT NULL;

-- ENCHANTMENT
INSERT INTO enchantment (enchantment_name, effect_radius)
SELECT name, radious FROM card_aux AS card
WHERE card.radious IS NOT NULL;

-- LEVEL
INSERT INTO level(level, statistics_multiplier, improvement_cost)
SELECT level,  random() * (10000 - 25 + 1) + 25,  random() * (10000 - 25 + 1) + 25 FROM player_card_aux GROUP BY level;

-- STACK
INSERT INTO stack(id_stack, name, creation_date, description, id_player)
SELECT DISTINCT NULLIF(deck, '')::int, title, date, description, player FROM player_deck_aux;

-- SHARE_STACK
INSERT INTO share_stack(id_stack, id_player)
SELECT s.id_stack, p.id_player FROM player AS p JOIN shared_deck_aux AS sd ON p.id_player = sd.player 
JOIN stack AS s ON sd.deck = s.id_stack;

-- OWNS
INSERT INTO owns(card, level, player, date_level_up, date_found, experience_gained)
SELECT pc.name, pc.level, pc.player, now() , pc.date, random() * (10000 - 25 + 1) + 25 
FROM player_card_aux AS pc JOIN card AS ca ON pc.name = ca.id_card_name;


--GROUP
INSERT INTO "group"(card_name, id_stack)
SELECT DISTINCT c.name, NULLIF(deck, '')::int FROM player_deck_aux, card_aux AS c;

-- Clan
INSERT INTO clan (id_clan, clan_name, description, num_min_trophy, total_points, num_trophy, id_player,gold_needed, datetime)
SELECT ca.tag, ca.name, ca.description, ca.requiredTrophies, ca.score, ca.trophies, pc.player, random() * (10000 - 25 + 1) + 25, pc."date"
FROM clans_aux AS ca JOIN player_clan_aux AS pc
ON ca.tag = pc.clan
WHERE pc."role" LIKE 'leader:%';

-- Role
-- ID de SERIAL
INSERT INTO role(description)
SELECT DISTINCT "role" FROM player_clan_aux;

-- Join
INSERT INTO joins(id_clan, id_player, id_role, datetime_in)
SELECT pc.clan, pc.player, ro.id_role, pc."date" FROM player_clan_aux AS pc JOIN role AS ro
ON ro.description = pc."role";

-- Give
INSERT INTO give(id_clan, id_player, gold, experience, date)
SELECT pd.clan, pd.player, SUM(pd.gold), random() * (10000 - 25 + 1) + 25, pd.date
FROM player_clan_donation_aux AS pd
GROUP BY pd."date", pd.clan, pd.player HAVING SUM(pd.gold) > 0;

--Fight
INSERT INTO fight(id_clan,clan_battle)
SELECT clan, battle FROM clan_battle_aux GROUP BY clan, battle;

-- Win
-- Nou CSV
INSERT INTO win(id_clan, id_battle, id_title)
SELECT cb.clan, cb.battle, cb.badge
FROM clan_badge_aux AS cb;

-- Modifier
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
INSERT INTO modify(id_clan, name_modifier, card_name, level, date)
SELECT DISTINCT cst.clan, cst.structure, o.card, cst.level, cst.date
FROM clan_tech_structure_aux AS cst JOIN joins AS j ON cst.clan = j.id_clan
JOIN owns AS o ON j.id_player = o.player
JOIN building_aux AS bu ON cst.structure = bu.building
WHERE cst.structure is not null
AND bu.mod_spawn_damage is  null
AND bu.mod_radius is  null
AND bu.mod_lifetime is  null
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
;

--Technology
INSERT INTO modify(id_clan, name_modifier, card_name, level, date)
SELECT DISTINCT cst.clan, cst.tech, o.card, cst.level, cst.date
FROM clan_tech_structure_aux AS cst JOIN joins AS j ON cst.clan = j.id_clan
JOIN owns AS o ON j.id_player = o.player
JOIN enchantment AS en ON o.card = en.enchantment_name
JOIN technology_aux AS te ON cst.tech = te.technology
WHERE cst.tech is not null
AND te.mod_radius is not null ;

-- IMPORTS ARNAU

-- Message
-- aux receiver table for user to user messages
DROP TABLE IF EXISTS receiver;
CREATE TABLE receiver(
	id VARCHAR(255)
);
INSERT INTO receiver (id)
SELECT id_player FROM player;

INSERT INTO message (id_message, issue, datetime, id_owner, id_replier)
SELECT mp.id, mp.text, mp.date, mp.sender, mp.receiver
FROM message_players_aux AS mp
JOIN player AS p ON p.id_player = sender
JOIN receiver AS r ON r.id = receiver;

UPDATE message AS m
SET id_reply = mess.answer
FROM (SELECT mp.answer, mp.id
FROM message_players_aux AS mp
WHERE mp.answer IS NOT NULL) AS mess
WHERE mess.id = m.id_message;

INSERT INTO message (id_message, issue, datetime, id_owner, id_replier)
SELECT mc.id + MAX(mp.id), mc.text, mc.date, mc.sender, mc.receiver
FROM message_clans_aux AS mc
JOIN player AS p ON p.id_player = sender
JOIN clan AS c ON c.id_clan = receiver,
message_players_aux AS mp
GROUP BY mc.id, mc.text, mc.date, mc.sender, mc.receiver;

UPDATE message AS m
SET id_reply = mess.answer
FROM (SELECT (mc.answer + aux.max) AS answer, (mc.id + aux.max) AS id
FROM message_clans_aux AS mc,
(SELECT MAX(mp.id) AS max FROM message_clans_aux AS mp) AS aux
WHERE mc.answer IS NOT NULL) AS mess
WHERE mess.id = m.id_message;

-- Shop
INSERT INTO shop(id_shop_name, available_gems)
VALUES ('SHOP', random() * (10000 - 25 + 1) + 25);

-- Article
DELETE FROM belongs;
DELETE FROM bundle;
DELETE FROM chest;
DELETE FROM emoticon;
DELETE FROM article;

INSERT INTO article(id_article, name, real_price, times_purchasable, id_shop_name)
SELECT DISTINCT pp.buy_id, pp.buy_name, pp.buy_cost, pp.buy_stock, shop.id_shop_name
FROM player_purchases_aux AS pp, shop;

-- Sand pack
INSERT INTO sand_pack(id_sand_pack) 
SELECT DISTINCT buy_id FROM player_purchases_aux AS pp
WHERE pp.arenapack_id IS NOT NULL;

-- Chest
INSERT INTO chest(id_chest, chest_name, rarity, unlocking_time)
SELECT DISTINCT buy_id, chest_name, chest_rarity, chest_unlock_time
FROM player_purchases_aux
WHERE chest_name IS NOT NULL
AND chest_rarity IS NOT NULL
AND chest_unlock_time IS NOT NULL;

UPDATE chest
SET gold_contained = random() * (1000 - 25 + 1) + 25, gems_contained = random() * (5 - 25 + 1) + 25;

-- Emote
INSERT INTO emoticon(id_emoticon, emoticon_name, path)
SELECT DISTINCT buy_id, emote_name, emote_path
FROM player_purchases_aux
WHERE emote_path IS NOT NULL
AND emote_name IS NOT NULL;

-- Bundle
INSERT INTO bundle(id_bundle, gold_contained, gems_contained)
SELECT DISTINCT buy_id, bundle_gold, bundle_gems
FROM player_purchases_aux
WHERE bundle_gold IS NOT NULL
AND bundle_gems IS NOT NULL;

-- Pays
DELETE FROM pays;
INSERT INTO pays(id_player, id_credit_card, id_article, datetime, discount)
SELECT DISTINCT pp.player, pp.credit_card, pp.buy_id, pp.date, pp.discount
FROM player_purchases_aux AS pp
JOIN credit_card ON credit_card.number = pp.credit_card;

-- Belongs
INSERT INTO belongs(id_sand_pack, id_sand, gold_contained)
SELECT DISTINCT pp.buy_id, sp.arena, sp.gold
FROM sand_pack_aux AS sp
JOIN player_purchases_aux AS pp ON pp.arenapack_id = sp.id;

-- Reward
INSERT INTO reward (id_reward, trophies_needed)
SELECT DISTINCT id_reward, MAX(trophies_needed)
FROM reward_aux
GROUP BY id_reward;

-- Friend
INSERT INTO friend(id_player1, id_player2)
SELECT requester, requested
FROM friends_aux
JOIN player AS p ON p.id_player = requester
JOIN receiver AS r ON r.id = requested;

DROP TABLE IF EXISTS receiver;

-- Obtains
INSERT INTO obtains(id_success, id_player, date)
SELECT pa.name, pa.player, pa.date
FROM player_achievement_aux AS pa
JOIN player AS p ON p.id_player = pa.player
JOIN success AS s ON s.id_title = pa.name;

-- Is found
INSERT INTO is_found(id_chest, id_mission)
SELECT DISTINCT isf.chest, isf.mission
FROM is_found_aux AS isf
JOIN chest AS c ON c.id_chest = isf.chest;

-- Buys
INSERT INTO buys(id_shop_name, id_player, id_card_name, datetime)
SELECT s.id_shop_name, '#LVRUV8YV', 'Knight', '2022-1-14 21:19:00'
FROM shop AS s;
