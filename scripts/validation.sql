--CARD

--Model físic

--Numero de buildings, enchantment i tropes totals
SELECT c.id_card_name AS card, 
COUNT(b.building_name) AS num_buildings, 
COUNT(enchantment) AS num_enchantments,
COUNT(troop) AS num_troops
FROM card AS c JOIN building AS b ON c.id_card_name = b.building_name
JOIN enchantment AS e ON c.id_card_name = e.enchantment_name
JOIN troop AS t ON c.id_card_name = t.troop_name;

--Seleccionar totes les cartes d'una certa raresa
SELECT c.id_card_name AS card, c.rarity AS rarity
FROM card AS c JOIN 
--Seleccionar totes les cartes d'un jugador d'un nivell en concret

--Seleccionar el nombre de cartes que hi ha en una pila

--Seleccionar quantes piles te un jugador

--Model Csv

--Numero de buildings, enchantment i tropes totals
SELECT c.id_card_name AS card_aux, 
COUNT(c.buildings) AS num_buildings, 
COUNT(c.enchantment) AS num_enchantments,
COUNT(c.troop) AS num_troops
FROM card AS c JOIN building AS b ON c.id_card_name = b.building_name
JOIN enchantment AS e ON c.id_card_name = e.enchantment_name
JOIN troop AS t ON c.id_card_name = t.troop_name;

--Seleccionar totes les cartes d'una certa raresa
SELECT c.id_card_name AS card, c.rarity AS rarity
FROM card AS c JOIN 
--Seleccionar totes les cartes d'un jugador d'un nivell en concret

--Seleccionar el nombre de cartes que hi ha en una pila


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
