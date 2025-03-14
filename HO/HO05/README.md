## Pergunta

Especificar as seguintes consultas em álgebra relacional para recuperar os dados em um banco de dados relacional, considerando o conjunto de dados (dataset) denominado IMDB-sample disponível na calculadora RelaXLinks to an external site [https://dbis-uibk.github.io/relax/]:

Projetar o primeiro nome e o último nome dos atores que são diretores;
Projetar o primeiro nome e o último nome dos atores que não são diretores;
Projetar o primeiro nome e o último nome dos atores e diretores;
Projetar o nome dos filmes que não são dirigidos por nenhum diretor;
Projetar primeiro nome e o último nome dos atores que não atuaram em pelo menos dois filmes;
Projetar, por gênero e ano, o número médio de filmes com menos de dois atores atuando.

## Resposta

### Questão 1

 π first_name, last_name ∩ π first_name,last_name directors

### Questão 2

π first_name,last_name actors - π first_name,last_name directors

### Questão 3

 π first_name,last_name actors ∪ π first_name,last_name directors

### Questão 4

C1 = directors ⨝ id = director_id movies_directors
C2 = C1 ⨝ movies_directors.movie_id = movies.id movies
π name movies - π name C2

### Questão 5

C1 = π actor_id σ n<2 γ actor_id; count(movie_id) -> n (roles) ⨝ actor_id=id actors
π first_name,last_name C1

### Questão 6

C1 = π movie_id, n σ n<2 γ movie_id; count(actor_id) -> n roles
C2 = π name, year, genre σ id=movie_id (movies⨝C1⨝movies_genres)
C3 = γ genre, year ; count(genre) -> n C2
π genre, year, average γ genre,year; avg(n) -> average C3
