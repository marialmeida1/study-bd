## HO04

## Pergunta

Especificar as seguintes consultas em álgebra relacional para recuperar os dados em um banco de dados relacional, considerando o conjunto de dados (dataset) denominado IMDB-sample disponível na calculadora RelaXLinks to an external site.:

- Projetar o primeiro nome e o último nome dos atores de sexo feminino;
- Projetar o nome dos filmes com ano superior à 1999;
- Projetar o nome do filme e o nome do diretor de cada filme;
- Projetar o nome do filme, nome do ator e o papel que cada ator teve no filme para filmes com ranking acima da nota 6;
- Projetar o nome do diretor e o número de filmes que cada diretor dirigiu;
- Projetar o gênero e o número de filmes de cada gênero; 
- Projetar o gênero, o ranking (nota) médio, mínimo e máximo dos filmes do gênero.

## Resposta

### Questão 1

 π first_name, last_name  (σ gender = 'F' (actors))

### Questão 2

 π name (σ year > 1999 (movies))

### Questão 3

 C = π name, director_id (movies ⋈ id=movie_id(​movies_directors))
 π name, first_name, last_name (C ⋈ director_id=id(​directors))

### Questão 4

C = π name, rank, actor_id, role (movies ⋈ id=id_movie​(roles))
C1 = π first_name, last_name, rank​ (C ⋈ actor_id=id(​actors))
π first_name, last_name, role, rank (σ rank≥6 ​(C1))

### Questão 5

C = γ director_id, count(movie_id) -> soma(movies_directors)
π first_name, last_name, soma (directors ⋈ id=director_id​(C))


### Questão 6

γ gender; count(movie_id) -> n_total_filmes (movies_gender)

### Questão 7

C = π name, rank, gender (movies ⋈ id=movie_id​(movies_gender))
C1 = γ gender; avg(rank) -> avarage (C)
C2 = γ gender; max(rank) -> max (C)
C3 = γ gender; min(rank) -> min (C)
π gender, avarage, min, max ((C1) ⋈ gender (C2)⋈ gender (C3))
