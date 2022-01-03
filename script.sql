-- Create table player -> player(id_player(PK), name, exp, trophies, gold, gems)
DROP TABLE IF EXISTS player CASCADE;
CREATE TABLE player (
    id_player VARCHAR(255) PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    exp INTEGER NOT NULL,
    trophies INTEGER NOT NULL,
    gold INTEGER NOT NULL,
    gems INTEGER NOT NULL
);

-- Create table sand -> sand(id_title(PK), max_trophies, min_trophies, reward_in_exp, reward_in_gold)
DROP TABLE IF EXISTS sand CASCADE;
CREATE TABLE sand (
    id_title VARCHAR(255) PRIMARY KEY,
    max_trophies INTEGER NOT NULL,
    min_trophies INTEGER NOT NULL,
    reward_in_exp INTEGER NOT NULL,
    reward_in_gold INTEGER NOT NULL
);

-- create table season -> season(id_name(PK), start_date, end_date)
DROP TABLE IF EXISTS season CASCADE;
CREATE TABLE season (
    id_name VARCHAR(255) PRIMARY KEY,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL
);

-- create table shop -> shop(id_shop_name(PK), available_gems)
DROP TABLE IF EXISTS shop CASCADE;
CREATE TABLE shop (
    id_shop_name VARCHAR(255) PRIMARY KEY,
    available_gems INTEGER NOT NULL
);

-- create table article -> article(id_article(PK), name, real_price, times_purchasable, id_shop_name(FK))
DROP TABLE IF EXISTS article CASCADE;
CREATE TABLE article (
    id_article SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    real_price FLOAT NOT NULL,
    times_purchasable INTEGER NOT NULL,
    id_shop_name VARCHAR(255) NOT NULL,
    FOREIGN KEY (id_shop_name) REFERENCES shop (id_shop_name)
);

-- create table building -> building(building_name(PK), life)
DROP TABLE IF EXISTS building CASCADE;
CREATE TABLE building (
    building_name VARCHAR(255) PRIMARY KEY,
    life INTEGER NOT NULL
);

-- create table troop -> troop(troop_name(PK), spawn_damage)
DROP TABLE IF EXISTS troop CASCADE;
CREATE TABLE troop (
    troop_name VARCHAR(255) PRIMARY KEY,
    spawn_damage INTEGER NOT NULL
);

-- create table enchantment -> enchantment(enchantment_name(PK), effect_radius)
DROP TABLE IF EXISTS enchantment CASCADE;
CREATE TABLE enchantment (
    enchantment_name VARCHAR(255) PRIMARY KEY,
    effect_radius INTEGER NOT NULL
);

-- create table role -> role(id_role(PK), description)
DROP TABLE IF EXISTS role CASCADE;
CREATE TABLE role (
    id_role SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL
);

-- create table clan -> clan(id_clan(PK), description, num_trophy, num_min_trophy, total_points, id_player(FK), gold_needed, datetime)
DROP TABLE IF EXISTS clan CASCADE;
CREATE TABLE clan (
    id_clan SERIAL PRIMARY KEY,
    description VARCHAR(255) NOT NULL,
    num_trophy INTEGER NOT NULL,
    num_min_trophy INTEGER NOT NULL,
    total_points INTEGER NOT NULL,
    id_player VARCHAR(255) NOT NULL,
    gold_needed INTEGER NOT NULL,
    datetime DATE NOT NULL,
    FOREIGN KEY (id_player) REFERENCES player (id_player)
);

-- create table rarity -> rarity(degree(PK), multiplicative_factor)
DROP TABLE IF EXISTS rarity CASCADE;
CREATE TABLE rarity (
    degree INTEGER PRIMARY KEY,
    multiplicative_factor FLOAT NOT NULL
);

-- create table card -> card(card_name(PK), damage, attack_speed, rarity(FK), id_sand(FK))
DROP TABLE IF EXISTS card CASCADE;
CREATE TABLE card (
    id_card_name VARCHAR(255) PRIMARY KEY,
    damage INTEGER NOT NULL,
    attack_speed INTEGER NOT NULL,
    rarity INTEGER NOT NULL,
    sand VARCHAR(255) NOT NULL,
    FOREIGN KEY (rarity) REFERENCES rarity (degree),
    FOREIGN KEY (sand) REFERENCES sand (id_title)
);

-- create table level -> level(level(PK), statistics_multiplier, improvement_cost)
DROP TABLE IF EXISTS level CASCADE;
CREATE TABLE level (
    level INTEGER PRIMARY KEY,
    statistics_multiplier FLOAT NOT NULL,
    improvement_cost INTEGER NOT NULL
);

-- create table stack -> stack(id_stack(PK), name, creation_date, description, id_player(FK))
DROP TABLE IF EXISTS stack CASCADE;
CREATE TABLE stack (
    id_stack SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    creation_date DATE NOT NULL,
    description VARCHAR(255) NOT NULL,
    id_player VARCHAR(255) NOT NULL,
    FOREIGN KEY (id_player) REFERENCES player (id_player)
);

-- create table group -> group(card_name(PK/FK), id_stack(PK/FK))
DROP TABLE IF EXISTS "group" CASCADE;
CREATE TABLE "group" (
    card_name VARCHAR(255) NOT NULL,
    id_stack INTEGER NOT NULL,
    FOREIGN KEY (card_name) REFERENCES card (id_card_name),
    FOREIGN KEY (id_stack) REFERENCES stack (id_stack),
    PRIMARY KEY (card_name, id_stack)
);

-- create table credit_card -> credit_card(id_credit_card(PK), datetime, number)
DROP TABLE IF EXISTS credit_card CASCADE;
CREATE TABLE credit_card (
    id_credit_card SERIAL PRIMARY KEY,
    datetime DATE NOT NULL,
    number VARCHAR(255) NOT NULL
);

-- create table reward -> reward(id_reward(PK), trophies_needed)
DROP TABLE IF EXISTS reward CASCADE;
CREATE TABLE reward (
    id_reward SERIAL PRIMARY KEY,
    trophies_needed INTEGER NOT NULL
);

-- create table success -> success(id_title(PK), gems_reward)
DROP TABLE IF EXISTS success CASCADE;
CREATE TABLE success (
    id_title VARCHAR(255) PRIMARY KEY,
    gems_reward INTEGER NOT NULL
);

-- create table mission -> mission(id_mission(PK), task_description)
DROP TABLE IF EXISTS mission CASCADE;
CREATE TABLE mission (
    id_mission SERIAL PRIMARY KEY,
    task_description VARCHAR(255) NOT NULL
);

-- create table depends -> depends(id_mission_1(PK/FK), id_mission_2(PK/FK))
DROP TABLE IF EXISTS depends CASCADE;
CREATE TABLE depends (
    id_mission_1 INTEGER,
    id_mission_2 INTEGER, -- it can be null (optional)
    FOREIGN KEY (id_mission_1) REFERENCES mission (id_mission),
    FOREIGN KEY (id_mission_2) REFERENCES mission (id_mission),
    UNIQUE (id_mission_1, id_mission_2)
);

-- create table gets -> gets(id_success(PK/FK), id_player(PK/FK))
DROP TABLE IF EXISTS gets CASCADE;
CREATE TABLE gets (
    id_success VARCHAR(255) NOT NULL,
    id_player VARCHAR(255) NOT NULL,
    FOREIGN KEY (id_success) REFERENCES success (id_title),
    FOREIGN KEY (id_player) REFERENCES player (id_player),
    PRIMARY KEY (id_success, id_player)
);

-- create table battle -> battle(id_battle(PK), datetime, duration, points, trophies_played, gold_played)
DROP TABLE IF EXISTS battle CASCADE;
CREATE TABLE battle (
    id_battle SERIAL PRIMARY KEY,
    datetime DATE NOT NULL,
    duration INTEGER NOT NULL,
    points INTEGER NOT NULL,
    trophies_played INTEGER NOT NULL,
    gold_played INTEGER NOT NULL
);

-- create table complete -> compete(id_battle(PK/FK), id_player(PK/FK), id_sand(PK/FK), victories_count, defeat_count, points_count, season(FK))
DROP TABLE IF EXISTS complete CASCADE;
CREATE TABLE complete (
    id_battle INTEGER NOT NULL,
    id_player VARCHAR(255) NOT NULL,
    id_sand VARCHAR(255) NOT NULL,
    victories_count INTEGER NOT NULL,
    defeat_count INTEGER NOT NULL,
    points_count INTEGER NOT NULL,
    season VARCHAR(255) NOT NULL,
    FOREIGN KEY (id_battle) REFERENCES battle (id_battle),
    FOREIGN KEY (id_player) REFERENCES player (id_player),
    FOREIGN KEY (id_sand) REFERENCES sand (id_title),
    FOREIGN KEY (season) REFERENCES season (id_name),
    PRIMARY KEY (id_battle, id_player, id_sand)
);

-- create table fight -> fight(id_clan(PK/FK), id_battle(PK/FK))
DROP TABLE IF EXISTS fight CASCADE;
CREATE TABLE fight (
    id_clan INTEGER NOT NULL,
    id_battle INTEGER NOT NULL,
    FOREIGN KEY (id_clan) REFERENCES clan (id_clan),
    FOREIGN KEY (id_battle) REFERENCES battle (id_battle),
    PRIMARY KEY (id_clan, id_battle)
);

-- create table badge -> badge(id_title(PK), image_path)
DROP TABLE IF EXISTS badge CASCADE;
CREATE TABLE badge (
    id_title VARCHAR(255) PRIMARY KEY,
    image_path VARCHAR(255) NOT NULL
);

-- create table win -> win(id_clan(PK/FK), id_battle(PK/FK), id_title(PK/FK))
DROP TABLE IF EXISTS win CASCADE;
CREATE TABLE win (
    id_clan INTEGER NOT NULL,
    id_battle INTEGER NOT NULL,
    id_title VARCHAR(255) NOT NULL,
    FOREIGN KEY (id_clan) REFERENCES clan (id_clan),
    FOREIGN KEY (id_battle) REFERENCES battle (id_battle),
    FOREIGN KEY (id_title) REFERENCES badge (id_title),
    PRIMARY KEY (id_clan, id_battle, id_title)
);

-- create table structure -> structure(id_structure(FK), num_min_trophy)
DROP TABLE IF EXISTS structure CASCADE;
CREATE TABLE structure (
    id_structure SERIAL PRIMARY KEY,
    num_min_trophy INTEGER NOT NULL
);

-- create table technology -> technology(id_technology(FK), max_level, actual_level)
DROP TABLE IF EXISTS technology CASCADE;
CREATE TABLE technology (
    id_technology SERIAL PRIMARY KEY,
    max_level INTEGER NOT NULL,
    actual_level INTEGER NOT NULL
);

-- create table need -> need(id_structure1(PK/FK), id_structure2(PK/FK))
DROP TABLE IF EXISTS need CASCADE;
CREATE TABLE need (
    id_structure1 INTEGER NOT NULL,
    id_structure2 INTEGER NOT NULL,
    FOREIGN KEY (id_structure1) REFERENCES structure (id_structure),
    FOREIGN KEY (id_structure2) REFERENCES structure (id_structure),
    PRIMARY KEY (id_structure1, id_structure2)
);

-- create table requires -> requires(id_technology1(PK/FK), id_technology2(PK/FK), previous_level)
DROP TABLE IF EXISTS requires CASCADE;
CREATE TABLE requires (
    id_technology1 INTEGER NOT NULL,
    id_technology2 INTEGER NOT NULL,
    previous_level INTEGER NOT NULL,
    FOREIGN KEY (id_technology1) REFERENCES technology (id_technology),
    FOREIGN KEY (id_technology2) REFERENCES technology (id_technology),
    PRIMARY KEY (id_technology1, id_technology2)
);

-- create table modifier -> modifier(id_modifier(PK), name, description, cost)
DROP TABLE IF EXISTS modifier CASCADE;
CREATE TABLE modifier (
    id_modifier SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    description VARCHAR(255) NOT NULL,
    cost INTEGER NOT NULL
);

-- create table modify -> modify(id_clan(PK/FK), card_name(PK/FK), id_modifier(PK/FK), amount_donations)
DROP TABLE IF EXISTS modify CASCADE;
CREATE TABLE modify (
    id_clan INTEGER NOT NULL,
    card_name VARCHAR(255) NOT NULL,
    id_modifier INTEGER NOT NULL,
    amount_donations INTEGER NOT NULL,
    FOREIGN KEY (id_clan) REFERENCES clan (id_clan),
    FOREIGN KEY (card_name) REFERENCES card (id_card_name),
    FOREIGN KEY (id_modifier) REFERENCES modifier (id_modifier),
    PRIMARY KEY (id_clan, card_name, id_modifier)
);

-- create table joins -> joins(id_clan(PK/FK), id_player(PK/FK), id_role(PK/FK), datetime_in, datetime_out)
DROP TABLE IF EXISTS joins CASCADE;
CREATE TABLE joins (
    id_clan INTEGER NOT NULL,
    id_player VARCHAR(255) NOT NULL,
    id_role INTEGER NOT NULL,
    datetime_in TIMESTAMP NOT NULL,
    datetime_out TIMESTAMP,
    FOREIGN KEY (id_clan) REFERENCES clan (id_clan),
    FOREIGN KEY (id_player) REFERENCES player (id_player),
    FOREIGN KEY (id_role) REFERENCES role (id_role),
    PRIMARY KEY (id_clan, id_player, id_role)
);

-- create table give -> give(id_clan(PK/FK), id_player(PK/FK), gold, experience)
DROP TABLE IF EXISTS give CASCADE;
CREATE TABLE give (
    id_clan INTEGER NOT NULL,
    id_player VARCHAR(255) NOT NULL,
    gold INTEGER NOT NULL,
    experience INTEGER NOT NULL,
    FOREIGN KEY (id_clan) REFERENCES clan (id_clan),
    FOREIGN KEY (id_player) REFERENCES player (id_player),
    PRIMARY KEY (id_clan, id_player)
);

-- create table owns -> owns(card(PK/FK), level(PK/FK), player(PK/FK), date_found, date_level_up, experience_ gained)
DROP TABLE IF EXISTS owns CASCADE;
CREATE TABLE owns (
    card VARCHAR(255) NOT NULL,
    level INTEGER NOT NULL,
    player VARCHAR(255) NOT NULL,
    date_found TIMESTAMP NOT NULL,
    date_level_up TIMESTAMP,
    experience_gained INTEGER NOT NULL,
    FOREIGN KEY (card) REFERENCES card (id_card_name),
    FOREIGN KEY (level) REFERENCES level (level),
    FOREIGN KEY (player) REFERENCES player (id_player),
    PRIMARY KEY (card, level, player)
);

-- create table accepts -> accepts(id_mission(PK/FK), id_player(PK/FK), is_completed)
DROP TABLE IF EXISTS accepts CASCADE;
CREATE TABLE accepts (
    id_mission INTEGER NOT NULL,
    id_player VARCHAR(255) NOT NULL,
    is_completed BOOLEAN NOT NULL,
    FOREIGN KEY (id_mission) REFERENCES mission (id_mission),
    FOREIGN KEY (id_player) REFERENCES player (id_player),
    PRIMARY KEY (id_mission, id_player)
);

-- create table friend -> friend(id_player1(PK/FK), id_player2(PK/FK))
DROP TABLE IF EXISTS friend CASCADE;
CREATE TABLE friend (
    id_player1 VARCHAR(255) NOT NULL,
    id_player2 VARCHAR(255) NOT NULL,
    FOREIGN KEY (id_player1) REFERENCES player (id_player),
    FOREIGN KEY (id_player2) REFERENCES player (id_player),
    PRIMARY KEY (id_player1, id_player2)
);

-- create table bundle -> bundle(id_bundle(PK), gold_contained, gems_contained)
DROP TABLE IF EXISTS bundle CASCADE;
CREATE TABLE bundle (
    id_bundle SERIAL PRIMARY KEY,
    gold_contained INTEGER NOT NULL,
    gems_contained INTEGER NOT NULL
);

-- create table emoticon -> emoticon(id_emoticon(PK), path)
DROP TABLE IF EXISTS emoticon CASCADE;
CREATE TABLE emoticon (
    id_emoticon SERIAL PRIMARY KEY,
    path VARCHAR(255) NOT NULL
);

-- create table chest -> chest(id_chest(PK), gold_contained, gems_contained, unlocking_time)
DROP TABLE IF EXISTS chest CASCADE;
CREATE TABLE chest (
    id_chest SERIAL PRIMARY KEY,
    gold_contained INTEGER NOT NULL,
    gems_contained INTEGER NOT NULL,
    unlocking_time TIMESTAMP NOT NULL
);

-- create table pays -> pays(id_player(PK/FK), id_credit_card(PK/FK), id_article(PK/FK), datetime, discount)
DROP TABLE IF EXISTS pays CASCADE;
CREATE TABLE pays (
    id_player VARCHAR(255) NOT NULL,
    id_credit_card INTEGER NOT NULL,
    id_article INTEGER NOT NULL,
    datetime TIMESTAMP NOT NULL,
    discount INTEGER NOT NULL,
    FOREIGN KEY (id_player) REFERENCES player (id_player),
    FOREIGN KEY (id_credit_card) REFERENCES credit_card (id_credit_card),
    FOREIGN KEY (id_article) REFERENCES article (id_article),
    PRIMARY KEY (id_player, id_credit_card, id_article)
);

-- create table buys -> buys(id_shop_name(PK/FK), id_player(PK/FK), id_card_name(PK/FK), datetime)
DROP TABLE IF EXISTS buys CASCADE;
CREATE TABLE buys (
    id_shop_name VARCHAR(255) NOT NULL,
    id_player VARCHAR(255) NOT NULL,
    id_credit_card INTEGER NOT NULL,
    datetime TIMESTAMP NOT NULL,
    FOREIGN KEY (id_shop_name) REFERENCES shop (id_shop_name),
    FOREIGN KEY (id_player) REFERENCES player (id_player),
    FOREIGN KEY (id_credit_card) REFERENCES credit_card (id_credit_card),
    PRIMARY KEY (id_shop_name, id_player, id_credit_card)
);

-- create table obtains -> obtains(id_success(PK/FK), id_player(PK/FK))
DROP TABLE IF EXISTS obtains CASCADE;
CREATE TABLE obtains (
    id_success VARCHAR(255) NOT NULL,
    id_player VARCHAR(255) NOT NULL,
    FOREIGN KEY (id_success) REFERENCES success (id_title),
    FOREIGN KEY (id_player) REFERENCES player (id_player),
    PRIMARY KEY (id_success, id_player)
);

-- create table is_found -> is_found(id_chest(PK/FK), id_mission(PK/FK))
DROP TABLE IF EXISTS is_found CASCADE;
CREATE TABLE is_found (
    id_chest INTEGER NOT NULL,
    id_mission INTEGER NOT NULL,
    FOREIGN KEY (id_chest) REFERENCES chest (id_chest),
    FOREIGN KEY (id_mission) REFERENCES mission (id_mission),
    PRIMARY KEY (id_chest, id_mission)
);

-- create table sand_pack -> sand_pack(id_sand_pack(PK), gold_contained, gems_contained, sand(FK))
DROP TABLE IF EXISTS sand_pack CASCADE;
CREATE TABLE sand_pack (
    id_sand_pack SERIAL PRIMARY KEY,
    gold_contained INTEGER NOT NULL,
    gems_contained INTEGER NOT NULL,
    id_sand VARCHAR(255) NOT NULL,
    FOREIGN KEY (id_sand) REFERENCES sand (id_title)
);

-- create table message -> message(id_message(PK), title, issue, datetime, id_owner(PK), id_clan(FK), id_replier(FK))
DROP TABLE IF EXISTS message CASCADE;
CREATE TABLE message (
    id_message SERIAL PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    issue VARCHAR(255) NOT NULL,
    datetime TIMESTAMP NOT NULL,
    id_owner VARCHAR(255) NOT NULL,
    id_clan INTEGER,
    id_replier VARCHAR(255),
    FOREIGN KEY (id_owner) REFERENCES player (id_player),
    FOREIGN KEY (id_clan) REFERENCES clan (id_clan),
    FOREIGN KEY (id_replier) REFERENCES player (id_player)
);

-- create table frees -> frees(id_badge(PK/FK), id_player(PK/FK), id_sand(FK))
DROP TABLE IF EXISTS frees CASCADE;
CREATE TABLE frees (
    id_badge VARCHAR(255) NOT NULL,
    id_player VARCHAR(255) NOT NULL,
    id_sand VARCHAR(255) NOT NULL,
    FOREIGN KEY (id_badge) REFERENCES badge (id_title),
    FOREIGN KEY (id_player) REFERENCES player (id_player),
    FOREIGN KEY (id_sand) REFERENCES sand (id_title),
    PRIMARY KEY (id_badge, id_player)
);

-- NOW MIGRATE THE DATA --

-- Import the data from the old database
-- Insert into sand the data from the old database (sand_aux)
-- INSERT INTO sand(id_title, max_trophies, min_trophies) SELECT name, minTrophies, maxTrophies FROM sand_aux;

-- insert into sand the data from the old database (sand_aux, quest_arena)
DELETE FROM sand WHERE sand.id_title LIKE '%'; -- bypass warning
INSERT INTO sand(id_title, max_trophies, min_trophies, reward_in_exp, reward_in_gold)
SELECT name, AVG(maxTrophies), AVG(minTrophies), AVG(experience), AVG(gold)
FROM sand_aux, quest_arena
WHERE quest_arena.arena_id = sand_aux.id
GROUP BY name;

-- insert into season the data from the old database (season_aux)
INSERT INTO season(id_name, start_date, end_date)
SELECT name, startDate, endDate FROM season_aux;

-- Explanation: the name has to be unique, so that's the reason we are using GROUP BY statement.
-- For the gems, each success has the same gems, so make the average will not be a problem.
INSERT INTO success(id_title, gems_reward)
SELECT name, AVG(gems)
FROM player_achievement
GROUP BY name;

-- Union of the tables: player - gets - success
INSERT INTO gets(id_success, id_player) SELECT name, pa.player FROM player_achievement AS pa;

-- mission(id_mission(PK), task_description)
INSERT INTO mission (id_mission, task_description) SELECT quest_id, quest_requirement FROM player_quest GROUP BY quest_id, quest_requirement;

-- A mission can depend on another one
INSERT INTO depends(id_mission_1, id_mission_2) SELECT DISTINCT quest_id, quest_depends FROM player_quest;

INSERT INTO battle (datetime, duration, points, trophies_played, gold_played) SELECT ba.date, ba.duration, ba.points, ba.trophies, ba.gold FROM battle_aux AS ba;
