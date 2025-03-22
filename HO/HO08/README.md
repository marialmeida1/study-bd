# Pergunta

Especificar as seguintes consultas em SQL para recuperar os dados em um banco de dados relacional, considerando o conjunto de dados (dataset) denominado IMDB-sample disponível na calculadora RelaXLinks to an external site [https://dbis-uibk.github.io/relax/]:

Projetar o primeiro nome e o último nome dos atores de sexo feminino;
Projetar o nome dos filmes com ano superior à 1999;
Projetar o nome do filme e o nome do diretor de cada filme;
Projetar o nome do filme, nome do ator e o papel que cada ator teve no filme para filmes com ranking acima da nota 6;
Projetar o nome do diretor e o número de filmes que cada diretor dirigiu;
Projetar o gênero e o número de filmes de cada gênero; 
Projetar o gênero, o ranking (nota) médio, mínimo e máximo dos filmes do gênero.

# Resposta


###### Questão 01

```sql

SELECT actors.first_name, actors.last_name
FROM actors
INNER JOIN directors
ON actors.first_name = directors.first_name
AND actors.last_name = directors.last_name;

```

###### Questão 02

```sql

SELECT actors.first_name, actors.last_name
FROM actors
FULL OUTER JOIN directors
ON actors.first_name = directors.first_name
AND actors.last_name = directors.last_name;

```

###### Questão 03

```sql

SELECT   
		COALESCE(a.first_name, d.first_name) AS first_name,
    COALESCE(a.last_name, d.last_name) AS last_name
FROM actors AS a, directors AS  d;
```

###### Questão 04

```sql

SELECT movies.name 
FROM movies 
LEFT JOIN movies_directors ON movies.id = movies_directors.movie_id
WHERE movies_directors.movie_id IS NULL;
```

###### Questão 05

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

###### Questão 06

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