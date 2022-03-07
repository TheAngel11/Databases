-- Set 5 [Preguntes creuades]

-- 3) Llistar els 10 primers jugadors amb experiència superior a 100.000 que han creat més
-- piles i han guanyat batalles a la temporada T7.
SELECT p.id_player, p.name, p.exp, COUNT(s.id_stack) AS stacks_created
FROM player AS p INNER JOIN stack AS s ON p.id_player = s.id_player
WHERE p.exp > 100000
AND p.id_player IN
    (
    SELECT winner FROM takes_place AS tp
        INNER JOIN battle AS b ON tp.id_battle = b.id_battle
        INNER JOIN player AS p ON p.id_player = b.winner
    WHERE id_season LIKE 'T7'
    GROUP BY winner
    ORDER BY COUNT(*) DESC
    )
GROUP BY p.id_player, p.name, p.exp
ORDER BY stacks_created DESC
LIMIT 10;