# Pergunta

Especificar as seguintes consultas em SQL para recuperar os dados em um banco de dados relacional, considerando o conjunto de dados (dataset) denominado IMDB-sample disponível na calculadora RelaXLinks to an external site [https://dbis-uibk.github.io/relax/]:

Projetar o primeiro nome e o último nome dos atores de sexo feminino;
Projetar o nome dos filmes com ano superior à 1999;
Projetar o nome do filme e o nome do diretor de cada filme;
Projetar o nome do filme, nome do ator e o papel que cada ator teve no filme para filmes com ranking acima da nota 6;
Projetar o nome do diretor e o número de filmes que cada diretor dirigiu;
Projetar o gênero e o número de filmes de cada gênero; 
Projetar o gênero, o ranking (nota) médio, mínimo e máximo dos filmes do gênero.


# Respostas

## Questão 01:

```sql
SELECT first_name, last_name FROM actors WHERE gender = 'F';
```
## Questão 02:

```sql
SELECT name FROM movies WHERE year > 1999;
```
## Questão 03:

```sql
SELECT name, first_name, last_name 
FROM ( 
    SELECT name, director_id 
    FROM movies NATURAL JOIN movies_directors 
    WHERE id = movie_id
) AS table_1 
NATURAL JOIN directors 
WHERE id = director_id;
```

## Questão 04:

```sql
SELECT movies.name, table1.role, table1.first_name, table1.last_name
FROM (
SELECT actors.first_name, actors.last_name, roles.role, roles.movie_id
FROM actors
NATURAL JOIN roles
WHERE actors.id = roles.actor_id
) as table1
NATURAL JOIN movies
WHERE movies.id = table1.movie_id AND movies.rank > 6;
```

## Questão 05:

###### Anotações: Todo atributo mostrado no select deve ser mostrado no group by (OBRIGATÓRIO)

```sql
SELECT directiors.id, directors.first_name, directors.last_name, COUNT(directors.id) as n
FROM directors
NATURAL JOIN movies_directors
WHERE directors.id = movies_directors.director_id
GROUP BY directors.id;
```

## Questão 06:

```sql
SELECT movies_genres.genre, COUNT(movies.id) as n
FROM movies
NATURAL JOIN movies_genres
WHERE movies.id = movies_genres.movie_id
GROUP BY movies_genres.genre;
```

## Questão 07:

```sql
SELECT  movies_genres.genre, 
AVG(movies.rank) as m, 
MIN(movies.rank) as a, 
MAX(movies.rank) as b
FROM movies
NATURAL JOIN movies_genres
WHERE movies.id = movies_genres.movie_id
GROUP BY movies_genres.genre;
```