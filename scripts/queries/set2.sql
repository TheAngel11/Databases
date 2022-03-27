--# Set 2 [No sóc un jugador, sóc un jugador de videojocs]

-- 1. Enumera els missatges (text i data) escrits pels jugadors que tenen més experiència
-- que la mitjana dels jugadors que tenen una "A" en nom seu i pertanyen al clan "NoA". 
-- Donar la llista de ordenada dels missatges més antics als més nous.

/* Consulta */
SELECT message.issue, message.datetime 
    FROM message 
    JOIN player ON player.id_player = message.id_owner 
    WHERE player.exp >= 
    (SELECT AVG(exp) 
        FROM player 
        JOIN joins ON joins.id_player = player.id_player 
        JOIN clan ON clan.id_clan = joins.id_clan 
        WHERE clan.clan_name LIKE 'NoA'
        AND player.name LIKE '%A%') 
    ORDER BY message.datetime ASC; 

/* Validació */
    -- 1r, obtenim un missatge
SELECT id_owner, issue
    FROM message
    WHERE issue LIKE 'Okay, I%'
    AND datetime = '2021-12-04 00:00:00';

    -- 2n, l'experiència del jugador
SELECT id_player, exp 
    FROM player
    WHERE id_player = '#20P8LJPU9';

    -- 3r, comprovem la subconsulta
SELECT player.name, clan.clan_name, player.exp
    FROM player
    JOIN joins ON joins.id_player = player.id_player 
    JOIN clan ON clan.id_clan = joins.id_clan
    WHERE clan.clan_name LIKE 'NoA'
    AND player.name LIKE '%A%';


-- 2. Enumera el número de la targeta de crèdit, la data i el descompte utilitzat pels jugadors
-- per comprar articles de Pack Arena amb un cost superior a 200 i per comprar articles que el 
-- seu nom contingui una "B".

/* Consulta */
SELECT DISTINCT id_credit_card AS card_number, datetime, discount 
    FROM pays 
    WHERE pays.id_article IN 
    (SELECT id_article 
        FROM article 
        JOIN sand_pack ON sand_pack.id_sand_pack = id_article 
        WHERE article.real_price > 200 
        AND article.name LIKE '%B%'); 

/* Validació */
    -- 1r, busquem les compres d'una targeta amb cert descompte
SELECT * 
    FROM pays
    WHERE id_credit_card = '626187849879936'
    AND discount = '51.22';

    -- 2n, condicions de l'article amb ID 80
SELECT *
    FROM article
    WHERE id_article = 80;

    -- 3r, comprovació de subentitat (sand_pack)
SELECT *
    FROM sand_pack
    WHERE id_sand_pack = 80;


-- 3. Enumerar el nom i el nombre d’articles comprats, així com el cost total dels articles 
-- comprats i l’experiència dels jugadors que els van demanar. Filtra la sortida amb els 5 
-- articles en què els usuaris han gastat més diners.

/* Consulta */
SELECT article.name, COUNT(pays.id_article) AS times_bought, SUM(article.real_price) - SUM(pays.discount) AS price, SUM(player.exp) AS exp
    FROM article
    JOIN pays ON article.id_article = pays.id_article
    JOIN player ON player.id_player = pays.id_player
    GROUP BY article.id_article
    ORDER BY price DESC
    LIMIT 5;

/* Validació */
    -- 1r, nombre de vegades comprat
SELECT *
    FROM pays
    JOIN article ON article.id_article = pays.id_article
    WHERE article.name = 'Gaspé Willow';

    -- 2n, preu
SELECT SUM(discount)
    FROM pays
    JOIN article ON article.id_article = pays.id_article
    WHERE article.name = 'Gaspé Willow';

    -- 3r, experiencia
SELECT SUM(player.exp)
    FROM article
    JOIN pays ON article.id_article = pays.id_article
    JOIN player ON player.id_player = pays.id_player
    WHERE article.name = 'Gaspé Willow';


-- 4. Donar els números de les targetes de crèdit que s'han utilitzat més.

/* Consulta */
SELECT number
    FROM credit_card
    JOIN pays ON pays.id_credit_card = credit_card.number
    GROUP BY credit_card.number
    HAVING COUNT(id_credit_card) >= 
    (SELECT COUNT(id_credit_card) AS times_used
	    FROM pays
	    GROUP BY id_credit_card
	    ORDER BY times_used DESC
	    LIMIT 1);

/* Validació */
    -- 1r, validació subconsulta
SELECT id_credit_card, COUNT(id_credit_card) AS times_used
    FROM pays
    GROUP BY id_credit_card
    ORDER BY times_used DESC;

    -- 2n, vegades targeta utilitzada
SELECT *
    FROM pays
    WHERE id_credit_card = '626260924123445'


-- 5. Donar els descomptes totals de les emoticones comprades durant l'any 2020

/* Consulta */
SELECT pays.id_article, SUM(pays.discount) AS total_discount
    FROM pays
    JOIN emoticon ON emoticon.id_emoticon = pays.id_article
    WHERE EXTRACT (YEAR FROM pays.datetime) = ‘2020’
    GROUP BY pays.id_article;

/* Validació */
    -- 1r, descompte total
SELECT *
    FROM pays
    WHERE id_article = '178'
    ORDER BY datetime DESC;

    -- 2n, comprovació emoticona
SELECT *
    FROM article
    JOIN emoticon ON id_emoticon = id_article
    ORDER BY id_emoticon DESC;


-- 6. Enumerar el nom, experiència i número de targeta de crèdit dels jugadors amb 
-- experiència superior a 150.000. Filtra les targetes de crèdit que no han estat 
-- utilitzades per comprar cap article. Donar dues consultes diferents per obtenir el
-- mateix resultat.

/* Consulta 1 */
SELECT player.name, player.exp, possesses.card_number
    FROM possesses
    LEFT JOIN pays ON pays.id_credit_card = possesses.card_number
    JOIN player ON player.id_player = possesses.id_player
    WHERE pays.id_credit_card IS NULL
    AND player.exp >= 150000; 

/* Consulta 2 */
SELECT player.name, player.exp, possesses.card_number
    FROM possesses
    JOIN player ON player.id_player = possesses.id_player
    WHERE player.exp >= 150000
    AND possesses.card_number IN
    (SELECT number FROM credit_card
        LEFT JOIN pays ON pays.id_credit_card = credit_card.number
        WHERE pays.id_credit_card IS NULL);

/* Validació */
    -- 1r, inserció informació
INSERT INTO credit_card(number)
    SELECT 696969696969690;

INSERT INTO possesses(card_number, id_player)
    SELECT 696969696969690, '#9LQJLL';

UPDATE player
    SET exp = 150000
    WHERE id_player = '#9LQJLL';

    -- 2n, eliminació d'informació
DELETE FROM possesses
    WHERE card_number = 696969696969690;

DELETE FROM credit_card
    WHERE number = 696969696969690;

UPDATE player
    SET exp = 58483
    WHERE id_player = '#9LQJLL';

-- 7. Retorna el nom dels articles comprats pels jugadors que tenen més de 105 cartes o 
-- pels jugadors que han escrit més de 4 missatges. Ordeneu els resultats segons el nom 
-- de l'article de més a menys valor.

/* Consulta */
SELECT DISTINCT article.name
    FROM pays
    JOIN article ON article.id_article = pays.id_article
    WHERE id_player IN
    ((SELECT owns.player 
        FROM owns 
        GROUP BY owns.player
        HAVING COUNT(owns.card) >= 105)
    UNION
    (SELECT message.id_owner
        FROM message
        GROUP BY message.id_owner
        HAVING COUNT(message.id_message) > 4))
    ORDER BY article.name DESC;

/* Validació */
    -- 1r, jugadors amb més de 105 cartes
SELECT owns.player
    FROM owns
    GROUP BY owns.player
    HAVING COUNT(owns.card) >= 105;

    -- 2n, resultats COUNT
SELECT owns.player, COUNT(owns.card) AS cards 
    FROM owns   
    GROUP BY owns.player
    ORDER BY cards DESC;

SELECT owns.player, COUNT(owns.card) AS cards
    FROM owns
    GROUP BY owns.player
    ORDER BY cards ASC;

    -- 3r, comprovació COUNT
SELECT *
    FROM owns
    WHERE player = '#RQQQY2L28';

    -- 4r, jugadors amb més de 4 missatges
SELECT message.id_owner
    FROM message
    GROUP BY message.id_owner
    HAVING COUNT(message.id_message) > 4;

    -- 5é, llistat de missatges
SELECT *
    FROM message
    WHERE id_owner = '#UCRG8GGL';

    -- 6é, associació output principal
SELECT article.name
    FROM pays
    JOIN article ON article.id_article = pays.id_article
    WHERE pays.id_player = '#UCRG8GGL';

SELECT DISTINCT article.name
    FROM pays
    JOIN article ON article.id_article = pays.id_article
    WHERE article.name = 'Elko Cryptantha'
    AND id_article IN 
    ((SELECT owns.player
        FROM owns
        GROUP BY owns.player
        HAVING COUNT(owns.card) >= 105)
    UNION
    (SELECT message.id_owner
        FROM message
        GROUP BY message.id_owner
        HAVING COUNT(message.id_message) > 4))
    ORDER BY article.name DESC;

-- 8. Retorna els missatges (text i data) enviats a l'any 2020 entre jugadors i que hagin
-- estat respostos, o els missatges sense respostes enviats a un clan. Ordena els resultats 
-- segons la data del missatge i el text del missatge de més a menys valor.

/* Consulta */
(SELECT message.issue, message.datetime
    FROM message
    JOIN player ON player.id_player = message.id_owner
    JOIN clan ON clan.id_clan = message.id_replier
    WHERE message.id_reply IS NULL)
UNION
(SELECT message.issue, message.datetime
	FROM message
	JOIN player AS p ON p.id_player = message.id_owner
	JOIN player ON player.id_player = message.id_replier
	WHERE message.id_reply IS NOT NULL
	AND EXTRACT (YEAR FROM message.datetime) = ‘2020’)
	ORDER BY datetime DESC, issue DESC;

/* Validació */
    -- 1r, missatge a analitzar (a clan sense resposta)
SELECT *
    FROM message
    WHERE issue = 'Strike the tent.,';

    -- 2n, busquem el clan
SELECT * 
    FROM clan
    WHERE id_clan = '#28V2QQ9C';

    -- 3r, missatge a analitzar (entre jugadors amb resposta amb any 2020)
SELECT *
    FROM message
    WHERE issue LIKE 'You have shown your usual%';

    -- 4rt, comprovem usuaris involucrats
SELECT *
    FROM player
    WHERE id_player = '#GQPRJCUU'
    OR id_player = '#89UP8GG8L'
    OR id_player = '#9UCCQ2Q9R';
