-- Set 4 [M'agrada la competició. M'agraden els reptes...]

/*CREATE TABLE battle (
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

CREATE TABLE sand (
    id INTEGER PRIMARY KEY,
    title VARCHAR(255),
    max_trophies INTEGER NOT NULL,
    min_trophies INTEGER NOT NULL,
    reward_in_exp INTEGER NOT NULL,
    reward_in_gold INTEGER NOT NULL
);

CREATE TABLE season (
    id_name VARCHAR(100) PRIMARY KEY,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL
);

CREATE TABLE player (
    id_player VARCHAR(100) PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    exp INTEGER NOT NULL,
    trophies INTEGER NOT NULL,
    gold INTEGER NOT NULL,
    gems INTEGER NOT NULL
);*/

-- 1. TODO
-- 2. TODO

-- 3. Llistar la puntuació total dels jugadors guanyadors de batalles de cada temporada. Filtrar
-- la sortida per considerar només les temporades que han començat i acabat el 2019
-- TODO; where date(datetime) between '2019-01-01' and '2019-12-31'
SELECT season.id_name, player.id_player, player.name, SUM(battle.points) AS total_points
FROM takes_place
INNER JOIN battle ON takes_place.id_battle = battle.id_battle
INNER JOIN season ON takes_place.id_season = season.id_name
INNER JOIN player ON battle.winner = player.id_player
GROUP BY season.id_name, player.id_player, player.name
ORDER BY total_points DESC;

-- 4. Enumerar els noms de les arenes en què els jugadors veterans (experiència superior a
-- 170.000) van obtenir insígnies després del "25-10-2021". Ordenar el resultat segons el
-- nom de l’arena en ordre ascendent.
SELECT DISTINCT sand.title FROM sand
    INNER JOIN frees ON frees.id_sand = sand.id
    INNER JOIN player ON player.id_player = frees.id_player
WHERE player.exp > 170000
    AND frees.date > TO_DATE('25/10/2021', 'DD/MM/YYYY')
ORDER BY sand.title;

-- 5. Enumerar el nom de la insígnia, els noms de les cartes i el dany de les cartes dels
-- jugadors amb una experiència superior a 290.000 i obtingudes en arenes el nom de les
-- quals comença per "A" o quan la insígnia no té imatge. Així, considera només els
-- jugadors que tenen una carta el nom de la qual comença per "Lava".
SELECT sand.title AS sand_title, player.name AS player_name, frees.id_badge AS badge_name, card.id_card_name AS card_name, card.damage AS card_damage FROM sand
    INNER JOIN frees ON sand.id = frees.id_sand
    INNER JOIN player ON frees.id_player = player.id_player
    INNER JOIN card ON card.sand = sand.id
WHERE player.exp > 290000 AND card.id_card_name IN
    (SELECT id_card_name FROM card INNER JOIN sand s on card.sand = s.id WHERE s.title LIKE 'A%')
AND player.id_player IN
    (SELECT DISTINCT id_player FROM player INNER JOIN owns ON player.id_player = owns.player WHERE owns.card LIKE 'Lava%');
