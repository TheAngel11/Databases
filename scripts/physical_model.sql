-- Create table player -> player(id_player(PK), name, exp, trophies, gold, gems)
DROP TABLE IF EXISTS player CASCADE;
CREATE TABLE player (
    id_player VARCHAR(100) PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    exp INTEGER NOT NULL,
    trophies INTEGER NOT NULL,
    gold INTEGER NOT NULL,
    gems INTEGER NOT NULL
);

-- Create table sand -> sand(id_title(PK), max_trophies, min_trophies, reward_in_exp, reward_in_gold)
DROP TABLE IF EXISTS sand CASCADE;
CREATE TABLE sand (
    id INTEGER PRIMARY KEY,
    title VARCHAR(255),
    max_trophies INTEGER NOT NULL,
    min_trophies INTEGER NOT NULL,
    reward_in_exp INTEGER NOT NULL,
    reward_in_gold INTEGER NOT NULL
);

-- create table season -> season(id_name(PK), start_date, end_date)
DROP TABLE IF EXISTS season CASCADE;
CREATE TABLE season (
    id_name VARCHAR(100) PRIMARY KEY,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL
);

-- create table shop -> shop(id_shop_name(PK), available_gems)
DROP TABLE IF EXISTS shop CASCADE;
CREATE TABLE shop (
    id_shop_name VARCHAR(100) PRIMARY KEY,
    available_gems INTEGER NOT NULL
);

-- create table article -> article(id_article(PK), name, real_price, times_purchasable, id_shop_name(FK))
DROP TABLE IF EXISTS article CASCADE;
CREATE TABLE article (
    id_article INTEGER PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    real_price FLOAT NOT NULL,
    times_purchasable INTEGER NOT NULL,
    id_shop_name VARCHAR(255) NOT NULL,
    FOREIGN KEY (id_shop_name) REFERENCES shop (id_shop_name)
);

-- create table role -> role(id_role(PK), description)
DROP TABLE IF EXISTS role CASCADE;
CREATE TABLE role (
    id_role SERIAL PRIMARY KEY,
    description VARCHAR(300) NOT NULL
);

--create table clan -> clan(id_clan(PK), description, num_trophy, num_min_trophy, total_points, id_player(FK), gold_needed, datetime)
DROP TABLE IF EXISTS clan CASCADE;
CREATE TABLE clan (
    id_clan VARCHAR(100) PRIMARY KEY,
    clan_name VARCHAR(255) NOT NULL,
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
    degree VARCHAR(100) PRIMARY KEY,
    multiplicative_factor FLOAT NOT NULL
);

-- create table card -> card(card_name(PK), damage, attack_speed, rarity(FK), id_sand(FK))
DROP TABLE IF EXISTS card CASCADE;
CREATE TABLE card (
    id_card_name VARCHAR(100) PRIMARY KEY,
    damage INTEGER NOT NULL,
    attack_speed INTEGER NOT NULL,
    rarity VARCHAR(255) NOT NULL,
    sand INTEGER NOT NULL,
    FOREIGN KEY (rarity) REFERENCES rarity (degree),
    FOREIGN KEY (sand) REFERENCES sand (id)
);

-- create table enchantment -> enchantment(enchantment_name(PK/Fk), effect_radius)
DROP TABLE IF EXISTS enchantment CASCADE;
CREATE TABLE enchantment (
    enchantment_name VARCHAR(100) PRIMARY KEY,
    effect_radius INTEGER NOT NULL,
    FOREIGN KEY (enchantment_name) REFERENCES card (id_card_name)
);

-- create table building -> building(building_name(PK/FK), life)
DROP TABLE IF EXISTS building CASCADE;
CREATE TABLE building (
    building_name VARCHAR(100) PRIMARY KEY,
    life INTEGER NOT NULL,
    FOREIGN KEY (building_name) REFERENCES card (id_card_name)
);

-- create table troop -> troop(troop_name(PK/FK), spawn_damage)
DROP TABLE IF EXISTS troop CASCADE;
CREATE TABLE troop (
    troop_name VARCHAR(100) PRIMARY KEY,
    spawn_damage INTEGER NOT NULL,
    FOREIGN KEY (troop_name) REFERENCES card (id_card_name)
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
    description VARCHAR(1000) NOT NULL,
    id_player VARCHAR(255) NOT NULL,
    FOREIGN KEY (id_player) REFERENCES player (id_player)
);

-- create table share_stack -> share_stack(id_stack(PK/FK), id_player(PK/FK))
DROP TABLE IF EXISTS share_stack CASCADE;
CREATE TABLE share_stack (
    id_stack INTEGER,
    id_player VARCHAR(100),
    PRIMARY KEY(id_stack, id_player),
    FOREIGN KEY(id_stack) REFERENCES stack(id_stack),
    FOREIGN KEY(id_player) REFERENCES player(id_player)
);


-- create table group -> group(card_name(PK/FK), id_stack(PK/FK))
DROP TABLE IF EXISTS "group" CASCADE;
CREATE TABLE "group" (
    card_name VARCHAR(100) NOT NULL,
    id_stack INTEGER NOT NULL,
    FOREIGN KEY (card_name) REFERENCES card (id_card_name),
    FOREIGN KEY (id_stack) REFERENCES stack (id_stack),
    PRIMARY KEY (card_name, id_stack)
);

-- create table credit_card -> credit_card(id_credit_card(PK), datetime, number)
DROP TABLE IF EXISTS credit_card CASCADE;
CREATE TABLE credit_card (
    number BIGINT PRIMARY KEY 
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
    id_title VARCHAR(100) PRIMARY KEY,
    gems_reward INTEGER NOT NULL
);

-- create table mission -> mission(id_mission(PK), task_description)
DROP TABLE IF EXISTS mission CASCADE;
CREATE TABLE mission (
    id_mission SERIAL PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
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
    id_success VARCHAR(100) NOT NULL,
    id_player VARCHAR(100) NOT NULL,
    FOREIGN KEY (id_success) REFERENCES success (id_title),
    FOREIGN KEY (id_player) REFERENCES player (id_player),
    PRIMARY KEY (id_success, id_player)
);

DROP TABLE IF EXISTS  clan_battle CASCADE;
CREATE TABLE clan_battle (
    clan_battle INTEGER NOT NULL PRIMARY KEY,
	start_date DATE NOT NULL,
	end_date DATE NOT NULL
);

-- create table battle -> battle(id_battle(PK), datetime, duration, points, trophies_played, gold_played)
DROP TABLE IF EXISTS battle CASCADE;
CREATE TABLE battle (
    id_battle SERIAL PRIMARY KEY,
    winner VARCHAR(100) NOT NULL,
    loser VARCHAR(100) NOT NULL,
    datetime DATE NOT NULL,
    duration TIME NOT NULL,
    points INTEGER NOT NULL,
    trophies_played INTEGER NOT NULL,
    gold_played INTEGER NOT NULL,
	clan_battle INTEGER,
	FOREIGN KEY (clan_battle) REFERENCES clan_battle (clan_battle),
    FOREIGN KEY (winner) REFERENCES player (id_player),
    FOREIGN KEY (loser) REFERENCES player (id_player)
);

-- create table complete -> compete(id_battle(PK/FK), id_player(PK/FK), id_sand(PK/FK), victories_count, defeat_count, points_count, season(FK))
DROP TABLE IF EXISTS takes_place CASCADE;
CREATE TABLE takes_place (
    id_battle INTEGER NOT NULL,
    id_sand INTEGER NOT NULL,
    id_season VARCHAR(100) NOT NULL,
    datetime DATE NOT NULL,
    FOREIGN KEY (id_battle) REFERENCES battle (id_battle),
    FOREIGN KEY (id_sand) REFERENCES sand (id),
    FOREIGN KEY (id_season) REFERENCES season (id_name),
    PRIMARY KEY (id_battle, datetime)
);


DROP TABLE IF EXISTS fight CASCADE;
CREATE TABLE fight (
    id_clan VARCHAR(100) NOT NULL,
    clan_battle INTEGER NOT NULL,
    FOREIGN KEY (id_clan) REFERENCES clan (id_clan),
	FOREIGN KEY (clan_battle) REFERENCES clan_battle (clan_battle),
	PRIMARY KEY (id_clan, clan_battle)
);

-- create table badge -> badge(id_title(PK), image_path)
DROP TABLE IF EXISTS badge CASCADE;
CREATE TABLE badge (
    id_title VARCHAR(100) PRIMARY KEY,
    image_path VARCHAR(255) NOT NULL
);

-- create table win -> win(id_clan(PK/FK), id_battle(PK/FK), id_title(PK/FK))
DROP TABLE IF EXISTS win CASCADE;
CREATE TABLE win (
    id_clan VARCHAR(100) NOT NULL,
    id_battle INTEGER NOT NULL,
    id_title VARCHAR(100) NOT NULL,
    FOREIGN KEY (id_clan) REFERENCES clan (id_clan),
    FOREIGN KEY (id_battle) REFERENCES clan_battle (clan_battle),
    FOREIGN KEY (id_title) REFERENCES badge (id_title),
    PRIMARY KEY (id_clan, id_battle, id_title)
);

-- create table modifier -> modifier(name_modifier(PK),description, cost, damage, attack_speed, effect_radius, spawn_damage, life)
DROP TABLE IF EXISTS modifier CASCADE;
CREATE TABLE modifier (
    name_modifier VARCHAR(100) PRIMARY KEY,
    description VARCHAR(255) NOT NULL,
    cost INTEGER NOT NULL,
	damage INTEGER,
	attack_speed INTEGER,
	effect_radius INTEGER,
	spawn_damage INTEGER,
	life INTEGER	
);
-- create table structure -> structure(name_structure(FK), num_min_trophy)
DROP TABLE IF EXISTS structure CASCADE;
CREATE TABLE structure (
    name_structure VARCHAR(100) PRIMARY KEY,
    num_min_trophy INTEGER NOT NULL,
	FOREIGN KEY (name_structure) REFERENCES modifier (name_modifier)
);

-- create table technology -> technology(name_technology(FK), max_level, actual_level)
DROP TABLE IF EXISTS technology CASCADE;
CREATE TABLE technology (
    name_technology VARCHAR(100) PRIMARY KEY,
    max_level INTEGER NOT NULL,
	FOREIGN KEY (name_technology) REFERENCES modifier (name_modifier)	
);

-- create table need -> need(id_structure(PK/FK), pre_structure(PK/FK))
DROP TABLE IF EXISTS need CASCADE;
CREATE TABLE need (
    id_structure VARCHAR(100) NOT NULL,
    pre_structure VARCHAR(100),
    FOREIGN KEY (id_structure) REFERENCES structure (name_structure),
    FOREIGN KEY (pre_structure) REFERENCES structure (name_structure),
    PRIMARY KEY (id_structure,pre_structure)
);

-- create table requires -> requires(id_technology(PK/FK), pre_technology(PK/FK), previous_level)
DROP TABLE IF EXISTS requires CASCADE;
CREATE TABLE requires (
    id_technology VARCHAR(100) NOT NULL,
    pre_technology VARCHAR(100) NOT NULL,
    previous_level INTEGER NOT NULL,
    FOREIGN KEY (id_technology) REFERENCES technology (name_technology),
    FOREIGN KEY (pre_technology) REFERENCES technology (name_technology),
    PRIMARY KEY (id_technology, pre_technology)
);


-- create table modify -> modify(id_clan(PK/FK), card_name(PK/FK), id_modifier(PK/FK), amount_donations)
DROP TABLE IF EXISTS modify CASCADE;
CREATE TABLE modify (
    id_clan VARCHAR(100) NOT NULL,
    card_name VARCHAR(100) NOT NULL,
    name_modifier VARCHAR(100) NOT NULL,
    "level" INTEGER NOT NULL,
    "date" DATE NOT NULL,
    FOREIGN KEY (id_clan) REFERENCES clan (id_clan),
    FOREIGN KEY (card_name) REFERENCES card (id_card_name),
    FOREIGN KEY (name_modifier) REFERENCES modifier (name_modifier),
    PRIMARY KEY (id_clan, card_name, name_modifier)
);

-- create table joins -> joins(id_clan(PK/FK), id_player(PK/FK), id_role(PK/FK), datetime_in, datetime_out)
DROP TABLE IF EXISTS joins CASCADE;
CREATE TABLE joins (
    id_clan VARCHAR(100) NOT NULL,
    id_player VARCHAR(100) NOT NULL,
    id_role INTEGER NOT NULL,
    datetime_in TIMESTAMP NOT NULL,
    FOREIGN KEY (id_clan) REFERENCES clan (id_clan),
    FOREIGN KEY (id_player) REFERENCES player (id_player),
    FOREIGN KEY (id_role) REFERENCES role (id_role),
    PRIMARY KEY (id_clan, id_player, id_role)
);

-- create table give -> give(id_clan(PK/FK), id_player(PK/FK), gold, experience)
DROP TABLE IF EXISTS give CASCADE;
CREATE TABLE give (
    id_clan VARCHAR(100) NOT NULL,
    id_player VARCHAR(100) NOT NULL,
    date TIMESTAMP NOT NULL,
    gold INTEGER NOT NULL,
    experience INTEGER NOT NULL,
    FOREIGN KEY (id_clan) REFERENCES clan (id_clan),
    FOREIGN KEY (id_player) REFERENCES player (id_player),
    PRIMARY KEY (id_clan, id_player, date)
);

-- create table owns -> owns(card(PK/FK), level(PK/FK), player(PK/FK), date_found, date_level_up, experience_ gained)
DROP TABLE IF EXISTS owns CASCADE;
CREATE TABLE owns (
    card VARCHAR(100) NOT NULL,
    level INTEGER NOT NULL,
    player VARCHAR(100) NOT NULL,
    date_found DATE NOT NULL,
    date_level_up DATE,
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
    id_player VARCHAR(100) NOT NULL,
    id_sand INTEGER NOT NULL,
    is_completed BOOLEAN NOT NULL,
    FOREIGN KEY (id_mission) REFERENCES mission (id_mission),
    FOREIGN KEY (id_player) REFERENCES player (id_player),
    FOREIGN KEY (id_sand) REFERENCES sand (id),
    PRIMARY KEY (id_mission, id_player, id_sand)
);

-- create table friend -> friend(id_player1(PK/FK), id_player2(PK/FK))
DROP TABLE IF EXISTS friend CASCADE;
CREATE TABLE friend (
    id_player1 VARCHAR(100) NOT NULL,
    id_player2 VARCHAR(100) NOT NULL,
    FOREIGN KEY (id_player1) REFERENCES player (id_player),
    FOREIGN KEY (id_player2) REFERENCES player (id_player),
    PRIMARY KEY (id_player1, id_player2)
);

-- create table bundle -> bundle(id_bundle(PK), gold_contained, gems_contained)
DROP TABLE IF EXISTS bundle CASCADE;
CREATE TABLE bundle (
    id_bundle INTEGER PRIMARY KEY,
    gold_contained INTEGER NOT NULL,
    gems_contained INTEGER NOT NULL,
    FOREIGN KEY (id_bundle) REFERENCES article(id_article)
);

-- create table emoticon -> emoticon(id_emoticon(PK), path)
DROP TABLE IF EXISTS emoticon CASCADE;
CREATE TABLE emoticon (
    id_emoticon INTEGER PRIMARY KEY,
    emoticon_name VARCHAR(100) NOT NULL,
    "path" VARCHAR(255) NOT NULL,
    FOREIGN KEY (id_emoticon) REFERENCES article(id_article)
);

-- create table chest -> chest(id_chest(PK), gold_contained, gems_contained, unlocking_time)
DROP TABLE IF EXISTS chest CASCADE;
CREATE TABLE chest (
    id_chest INTEGER PRIMARY KEY,
	chest_name VARCHAR(100) NOT NULL,
    rarity VARCHAR(100) NOT NULL,
    gold_contained INTEGER,
    gems_contained INTEGER,
    unlocking_time INTEGER NOT NULL,
    FOREIGN KEY (rarity) REFERENCES rarity (degree),
    FOREIGN KEY (id_chest) REFERENCES article(id_article)
);

-- create table pays -> pays(id_player(PK/FK), id_credit_card(PK/FK), id_article(PK/FK), datetime, discount)
DROP TABLE IF EXISTS pays CASCADE;
CREATE TABLE pays (
    id_player VARCHAR(100) NOT NULL,
    id_credit_card BIGINT NOT NULL,
    id_article INTEGER NOT NULL,
    datetime TIMESTAMP NOT NULL,
    discount FLOAT NOT NULL,
    FOREIGN KEY (id_player) REFERENCES player (id_player),
    FOREIGN KEY (id_credit_card) REFERENCES credit_card (number),
    FOREIGN KEY (id_article) REFERENCES article (id_article),
    PRIMARY KEY (id_player, id_credit_card, id_article, datetime)
);

-- create table buys -> buys(id_shop_name(PK/FK), id_player(PK/FK), id_card_name(PK/FK), datetime)
DROP TABLE IF EXISTS buys CASCADE;
CREATE TABLE buys (
    id_shop_name VARCHAR(100) NOT NULL,
    id_player VARCHAR(100) NOT NULL,
    id_card_name VARCHAR(100)  NOT NULL,
    datetime TIMESTAMP NOT NULL,
    FOREIGN KEY (id_shop_name) REFERENCES shop (id_shop_name),
    FOREIGN KEY (id_player) REFERENCES player (id_player),
    FOREIGN KEY (id_card_name) REFERENCES card (id_card_name),
    PRIMARY KEY (id_shop_name, id_player, id_card_name, datetime)
);

-- create table obtains -> obtains(id_success(PK/FK), id_player(PK/FK))
DROP TABLE IF EXISTS obtains CASCADE;
CREATE TABLE obtains (
    id_success VARCHAR(100) NOT NULL,
    id_player VARCHAR(100) NOT NULL,
    date DATE NOT NULL,
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
    id_sand_pack INTEGER PRIMARY KEY,
    FOREIGN KEY (id_sand_pack) REFERENCES article (id_article)
);

-- create table belongs -> belongs(id_sand_pack(PK/FK), id_arena(PK/FK), gold_contained)
DROP TABLE IF EXISTS belongs CASCADE;
CREATE TABLE belongs (
    id_sand_pack INTEGER,
    id_sand INTEGER,
    gold_contained INTEGER NOT NULL,
    FOREIGN KEY (id_sand_pack) REFERENCES sand_pack(id_sand_pack),
    FOREIGN KEY (id_sand) REFERENCES sand (id),
    PRIMARY KEY (id_sand, id_sand_pack)
);

-- create table message -> message(id_message(PK), title, issue, datetime, id_owner(PK), id_clan(FK), id_replier(FK))
DROP TABLE IF EXISTS message CASCADE;
CREATE TABLE message (
    id_message SERIAL PRIMARY KEY,
    issue VARCHAR(1000) NOT NULL,
    datetime TIMESTAMP NOT NULL,
    id_owner VARCHAR(255),
    id_replier VARCHAR(255),
    id_reply INTEGER,
    FOREIGN KEY (id_owner) REFERENCES player (id_player),
    FOREIGN KEY (id_reply) REFERENCES message (id_message)
);

-- create table frees -> frees(id_badge(PK/FK), id_player(PK/FK), id_sand(FK))
DROP TABLE IF EXISTS frees CASCADE;
CREATE TABLE frees (
    id_badge VARCHAR(100) NOT NULL,
    id_player VARCHAR(100) NOT NULL,
    id_sand INTEGER NOT NULL,
    date DATE NOT NULL,
    FOREIGN KEY (id_badge) REFERENCES badge (id_title),
    FOREIGN KEY (id_player) REFERENCES player (id_player),
    FOREIGN KEY (id_sand) REFERENCES sand (id),
    PRIMARY KEY (id_badge, id_player)
);

DROP TABLE IF EXISTS frees CASCADE;
CREATE TABLE frees (
    id_badge VARCHAR(100) NOT NULL,
    id_player VARCHAR(100) NOT NULL,
    id_sand INTEGER NOT NULL,
    date DATE NOT NULL,
    FOREIGN KEY (id_badge) REFERENCES badge (id_title),
    FOREIGN KEY (id_player) REFERENCES player (id_player),
    FOREIGN KEY (id_sand) REFERENCES sand (id),
    PRIMARY KEY (id_badge, id_player)
);

DROP TABLE IF EXISTS possesses CASCADE;
CREATE TABLE possesses (
	card_number BIGINT NOT NULL,
	id_player VARCHAR(100) NOT NULL,
	FOREIGN KEY (card_number) REFERENCES credit_card(number),
	FOREIGN KEY (id_player) REFERENCES player(id_player),
	PRIMARY KEY (card_number, id_player)
);
