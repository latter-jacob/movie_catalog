require 'sinatra'
require 'shotgun'
require 'pg'
require "pry"

def db_connection
  begin
    connection = PG.connect(dbname: "movies")
    yield(connection)
  ensure
    connection.close
  end
end

get "/actors" do
  actors = db_connection { |conn| conn.exec("SELECT actors.name
  FROM actors
  ORDER BY actors.name;") }
  erb :'actors/index', locals: { actors: actors }
end

get "/actors/:name" do
  roles = db_connection { |conn| conn.exec("SELECT movies.title, cast_members.character
  FROM cast_members
  JOIN movies ON cast_members.movie_id = movies.id
  JOIN actors ON cast_members.actor_id = actors.id
  WHERE actors.name = '#{params[:name]}';")}
  erb :'actors/show', locals: { name: params[:name], roles: roles }
end

get "/movies" do
  mlg_string = 'SELECT movies.title,movies.year, movies.rating, genres.name as genres, studios.name
  FROM movies
  JOIN genres ON movies.genre_id = genres.id
  LEFT OUTER JOIN studios on movies.studio_id = studios.id
  ORDER BY movies.title;'
  movies = db_connection { |conn| conn.exec(mlg_string) }

  erb :'movies/index', locals: { movies: movies}
end

get "/movies/:id" do
  film = db_connection { |conn| conn.exec("SELECT genres.name as genres, studios.name as studio, actors.name as actor, cast_members.character as character
  FROM cast_members
  JOIN movies ON cast_members.movie_id = movies.id
  JOIN actors ON cast_members.actor_id = actors.id
  JOIN genres ON movies.genre_id = genres.id
  JOIN studios ON movies.studio_id = studios.id
  WHERE movies.title = '#{params[:id]}';")}
  erb :'movies/show', locals: { id: params[:id], film: film}
end

get "/" do
  redirect "/movies"
end
