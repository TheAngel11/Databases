-----CARD-----

--Model físic

--Numero de buildings, enchantment i tropes totals
SELECT COUNT(DISTINCT b.building_name) AS num_buildings, 
COUNT(DISTINCT e.enchantment_name) AS num_enchantments,
COUNT(DISTINCT t.troop_name) AS num_troops
FROM building AS b,
enchantment AS e,
troop AS t;


--Seleccionar totes les cartes ordenades per raresa
SELECT c.id_card_name AS card, c.rarity AS rarity
FROM card AS c JOIN rarity AS r ON c.rarity = r.degree
GROUP BY c.id_card_name, rarity
ORDER BY rarity;
--Seleccionar les cartes d'un jugador una per una amb cartes de nivell major a 5
SELECT c.id_card_name AS card, p.id_player AS player, l.level AS level
FROM card AS c JOIN owns AS o ON c.id_card_name =  o.card
JOIN player AS p ON p.id_player = o.player
JOIN level AS l ON l.level = o.level
GROUP BY c.id_card_name , p.id_player, l.level HAVING l.level > 5
ORDER BY c.id_card_name;

--Seleccionar quantes piles te un jugador
SELECT COUNT(DISTINCT s.id_stack) AS num_stacks
FROM stack AS s JOIN player AS p ON s.id_player = p.id_player
--GROUP BY p.id_player
--ORDER BY p.id_player;
    -- Model Csv --

--Numero de buildings, enchantment i tropes totals
--num buildings
SELECT COUNT(DISTINCT c.name) AS num_buildings
FROM card_aux AS c
WHERE lifetime IS NOT NULL;

--num enchantments
SELECT COUNT(DISTINCT c.name) AS num_enchantments
FROM card_aux AS c
WHERE radious IS NOT NULL;

--num troops
SELECT COUNT(DISTINCT c.name) AS num_troops
FROM card_aux AS c
WHERE spawn_damage IS NOT NULL;

COUNT(DISTINCT e.enchantment_name) AS num_enchantments
COUNT(DISTINCT t.troop_name) AS num_troops
FROM c AS b 
, enchantment AS e 
, troop AS t;
    
--Seleccionar totes les cartes d'una certa raresa
SELECT c.name AS card, c.rarity AS rarity
FROM card_aux AS c
GROUP BY c.name, c.rarity
ORDER BY rarity;
--Seleccionar les cartes d'un jugador una per una amb cartes de nivell major a 5
SELECT c.name AS card, p.tag AS tag, p_c.level AS level
FROM card_aux AS c JOIN player_card_aux AS p_c ON p_c.name = c.name
JOIN player_aux AS p ON p_c.player = p.tag
GROUP BY c.name, tag, level HAVING level > 5
ORDER BY card;

-----PLAYER------
    -- Model Fisic --
--Selecciona els jugadors amb més de 5 piles

--Caracteristiques de Jugador
SELECT p.id_player AS player, p.name, p.exp, p.trophies, p.gold, p.gems
FROM player AS p
ORDER BY player;



    -- Model Csv --

--Caracteristiques de Jugador
SELECT p.tag, p.name, p.experience, p.trophies
FROM player_aux AS p
ORDER BY p.tag;


----------------- CLAN -----------------

--COnsulta 1: Caracteristiques de clan
--Model fisic
SELECT cl.id_clan, cl.clan_name, cl.num_trophy AS trophies, 
COUNT(DISTINCT j.id_player) AS total_players, 
SUM(g.gold) AS total_gold_donation
FROM clan AS cl JOIN joins AS j ON cl.id_clan = j.id_clan
JOIN give AS g ON cl.id_clan = g.id_clan
GROUP BY cl.id_clan;

--Model CSV
SELECT ca.tag, ca.name, ca.trophies, 
COUNT(DISTINCT pc.player)AS total_players, 
SUM(pcd.gold) AS total_gold_donation
FROM clan_aux AS ca JOIN player_clan_aux AS pc ON ca.tag = pc.clan
JOIN player_clan_donation AS pcd ON pc.clan = pcd.clan
GROUP BY ca.tag, ca.name, ca.trophies;


--Consulta 2: Rol
--Model fisic
SELECT j.id_clan, ro.id_role, COUNT(j.id_player) AS total_players, ro.description 
FROM joins AS j JOIN role AS ro ON j.id_role = ro.id_role
GROUP BY j.id_clan, ro.id_role, ro.description
ORDER BY j.id_clan, ro.id_role ASC
LIMIT 4;

--Model CSV
SELECT pc.clan, COUNT(pc.player) AS total_players, pc.role
FROM player_clan_aux AS pc
GROUP BY pc.clan, pc.role
ORDER BY pc.clan
LIMIT 4;


--Consulta 3: Donacions
--Model fisic
SELECT g.id_clan,  COUNT(g.id_player) AS total_players, SUM(g.gold) AS gold
FROM give AS g 
GROUP BY g.id_clan
ORDER BY g.id_clan;

--Model CSV
SELECT pcd.clan, COUNT(pcd.player) AS total_players, SUM(pcd.gold) AS gold
FROM player_clan_donation AS pcd
GROUP BY pcd.clan
ORDER BY pcd.clan;

--Consulta 4: Info modificador tecnologies
--Model fisic
SELECT DISTINCT m.id_clan, te.name_technology AS modifier_tech, mo.damage, 
mo.attack_speed, mo.effect_radius
FROM modify AS m JOIN enchantment AS en ON m.card_name = en.enchantment_name
JOIN technology AS te ON te.name_technology = m.name_modifier
JOIN modifier AS mo ON mo.name_modifier = m.name_modifier
ORDER BY m.id_clan ASC, te.name_technology ASC;

--Model CSV
SELECT DISTINCT cst.clan, cst.tech, te.mod_damage, te.mod_hit_speed ,te.mod_radius
FROM clan_tech_structure_aux AS cst JOIN technology_aux AS te 
ON cst.tech = te.technology
WHERE tech is not null
AND te.mod_radius is not null
ORDER BY cst.clan ASC, cst.tech ASC;

--Consulta 5: Total de modificadors
--Model fisic
SELECT m.id_clan, COUNT(DISTINCT te.name_technology) AS technology
FROM modify AS m JOIN technology AS te ON te.name_technology = m.name_modifier
GROUP BY m.id_clan
ORDER BY m.id_clan ASC;

SELECT m.id_clan, COUNT(DISTINCT st.name_structure) AS structure
FROM modify AS m JOIN structure AS st ON st.name_structure = m.name_modifier
GROUP BY m.id_clan
ORDER BY m.id_clan ASC;

--Model CSV
SELECT cst.clan, COUNT(cst.tech) AS tech, COUNT(cst.structure) AS structure
FROM clan_tech_structure_aux AS cst
GROUP BY cst.clan
ORDER BY cst.clan ASC;


-------- BATALLA  ------------
--Consulta 1
--Model fisic
SELECT cb.clan_battle, cb.start_date, cb.end_date, bat.id_battle, bat.duration
FROM clan_battle AS cb JOIN battle AS bat ON bat.clan_battle = cb.clan_battle
ORDER BY cb.clan_battle, bat.duration ASC;

--Model CSV
SELECT DISTINCT cb.battle, cb.start_date, cb.end_date, b.duration
FROM clan_battle_aux AS cb JOIN battle_aux AS b ON cb.battle = b.clan_battle
ORDER BY cb.battle, b.duration ASC;

--Consulta 2
--Model fisic
SELECT cb.clan_battle, f.id_clan, COUNT(bat.id_battle) AS battles
FROM clan_battle AS cb JOIN fight AS f ON cb.clan_battle = f.clan_battle
JOIN battle AS bat ON bat.clan_battle = cb.clan_battle
GROUP BY cb.clan_battle,f.id_clan
ORDER BY cb.clan_battle, f.id_clan;

--Model CSV
SELECT DISTINCT cb.battle, cb.clan, COUNT(b.clan_battle) AS battles
FROM clan_battle_aux AS cb JOIN battle_aux AS b ON cb.battle = b.clan_battle
GROUP BY cb.battle, cb.clan
ORDER BY cb.battle, cb.clan;

------------ ARENA -----------
--Consulta 1
--Model fisic
SELECT * FROM sand;

-- Model CSV
SELECT * FROM sand_aux;

-- Consulta 2. Select all the cards that are unlocked in the arena with id 54000025
-- Model Fisic
SELECT * FROM card WHERE sand = 54000025;

-- Model CSV
SELECT * FROM card_aux WHERE arena = 54000025;

-- Consulta 3: Selecciona todas las insígnias que desbloquea esta arena
-- Model Fisic
SELECT * FROM badge
    INNER JOIN frees ON frees.id_badge = badge.id_title
    INNER JOIN sand ON sand.id = frees.id_sand
WHERE sand.id = 54000025;

-- Model CSV
SELECT * FROM player_badge_aux
    INNER JOIN sand_aux ON sand_aux.id = player_badge_aux.arena
WHERE sand_aux.id = 54000025;

------------ MISSION -----------
--Consulta 1: Selecciona todas las misiones que se han completado
--Model fisic
SELECT * FROM mission
    INNER JOIN accepts a ON mission.id_mission = a.id_mission
    INNER JOIN player p on a.id_player = p.id_player
WHERE a.is_completed = true;

-- Model CSV
SELECT player_tag, quest_id
FROM player_quest_aux
GROUP BY player_quest_aux.player_tag, player_quest_aux.quest_id;

SELECT * FROM mission INNER JOIN depends d on mission.id_mission = d.id_mission_1 WHERE id_mission_1 = 110;

------------ BATALLES -----------
--Consulta 1: Selecciona todas las batallas
--Model fisic
SELECT * FROM battle;

-- Model CSV
SELECT * FROM battle_aux;

SELECT * FROM complete WHERE id_player = '#CQG8R8UV';

------------ ASSOLIMENTS -----------
--Consulta 1: Selecciona todas las asolimientos
--Model fisic
SELECT * FROM success INNER JOIN gets g ON success.id_title = g.id_success
    INNER JOIN player p ON g.id_player = p.id_player
WHERE g.id_player = '#2Q9JG29RL';