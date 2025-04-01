# Pergunta

Especificar as seguintes consultas em SQL para recuperar os dados em um banco de dados relacional, considerando o conjunto de dados (dataset) denominado IMDB-sample disponível na calculadora RelaXLinks to an external site [https://dbis-uibk.github.io/relax/]:

- Projetar o primeiro nome e o último nome dos atores que são diretores;
- Projetar o primeiro nome e o último nome dos atores que não são diretores;
- Projetar o primeiro nome e o último nome dos atores e diretores;
- Projetar o nome dos filmes que não são dirigidos por nenhum diretor;
- Projetar primeiro nome e o último nome dos atores que não atuaram em pelo menos dois filmes;
- Projetar, por gênero e ano, o número médio de filmes com menos de dois atores atuando.

# Resposta


## Questão 01


###### Solução Proposta

```sql

SELECT actors.first_name, actors.last_name
FROM actors
INNER JOIN directors
ON actors.first_name = directors.first_name
AND actors.last_name = directors.last_name;
```

###### Solução Corrigida

```sql
SELECT first_name, last_name
FROM actors
INTERSECT 
SELECT first_name, last_name
FROM directors;
```

## Questão 02

###### Solução Proposta

```sql
SELECT actors.first_name, actors.last_name
FROM actors
FULL OUTER JOIN directors
ON actors.first_name = directors.first_name
AND actors.last_name = directors.last_name;
```

###### Solução Corrigida

```sql
SELECT first_name, last_name
FROM actors
EXCEPT 
SELECT first_name, last_name
FROM directors;
```

## Questão 03

###### Solução Proposta

```sql
SELECT   
		COALESCE(a.first_name, d.first_name) AS first_name,
    COALESCE(a.last_name, d.last_name) AS last_name
FROM actors AS a, directors AS  d;
```

###### Solução Corrigida

```sql
SELECT first_name, last_name
FROM actors
UNION 
SELECT first_name, last_name
FROM directors;
```

## Questão 04

###### Solução Proposta

```sql
SELECT movies.name 
FROM movies 
LEFT JOIN movies_directors ON movies.id = movies_directors.movie_id
WHERE movies_directors.movie_id IS NULL;
```

###### Solução Corrigida

```sql
SELECT A.name
FROM 
SELECT id
FROM movies
EXCEPT
SELECT movie_id,
FROM movies_directors
    as A INNER JOIN directors as B ON (A.id = B.id)

```

## Questão 05

###### Solução Proposta

```sql
SELECT actors.first_name, actors.last_name
FROM (
		SELECT identificador
		FROM (
				SELECT actor_id as identificador, COUNT(movie_id) as a
				FROM roles
				GROUP BY actor_id
			) AS table2
		WHERE a < 2
	) AS table1 NATURAL JOIN actors
WHERE actors.id = identificador
WHERE movies_directors.movie_id IS NULL;
```

###### Solução Corrigida

```sql
SELECT C.first_name, C.lat_name
FROM actors AS C JOIN (
    SELECT id
    FROM actors
    EXCEPT
    SELECT actor_id COUNT (*) as TOTAL  
    FROM roles
    GROUP BY actor_id
    HAVING TOTAL >= 2 as A;
) as B ON B.id = C.id;
``` 

## Questão 06

###### Solução Proposta

```sql
SELECT genre,year,a
        FROM (
        SELECT genre,movie_id, a
        FROM (
                    SELECT movie_id as idfilme, COUNT(actor_id) as a
                    FROM roles
                    GROUP BY movie_id
                ) as mov NATURAL JOIN movies_genres
        WHERE a < 2
        AND idfilme=movie_id
    ) AS table_2 NATURAL JOIN movies
WHERE movie_id=id
```

###### Solução Corrigida

```sql
SELECT D.genre, C.year, COUNT (*) as TOTAL
FROM actors AS C JOIN (
    SELECT id
    FROM movies
    EXCEPT
    SELECT movie_id COUNT (*) as TOTAL  
    FROM roles
    GROUP BY movie_id
    HAVING TOTAL >= 2 as A;
) as B ON B.id = C.id INNER JOIN movies_genres AS D ON 
    D.movie_id = B.id
    GROUP BY D.genre, C.year;
```