SELECT movies.title, movies.year, movies.rating, genres.name, studios.name
FROM movies
JOIN genres ON movies.genre_id = genres.id
LEFT OUTER JOIN studios on movies.studio_id = studios.id
ORDER BY movies.title;


#FULL OUTER JOIN studios ON movies.studio_id = studios.id


SELECT actors.name
FROM actors
ORDER BY actors.name;

SELECT movies.title, cast_members.character
FROM cast_members
JOIN movies ON cast_members.movie_id = movies.id
JOIN actors ON cast_members.actor_id = actors.id;
WHERE actor.name =

Visiting /movies/:id will show the details for the movie. This page should contain
information about the movie (including genre and studio) as well
as a list of all of the actors and their roles. Each actor name is
a link to the details page for that actor.

SELECT genres.name as genres, studios.name as studio, actors.name, cast_members.character
FROM cast_members
JOIN movies ON cast_members.movie_id = movies.id
JOIN actors ON cast_members.actor_id = actors.id
JOIN genres ON movies.genre_id = genres.id
JOIN studios ON movies.studio_id = studios.id
WHERE movies.name = '#{params[:id]}'
