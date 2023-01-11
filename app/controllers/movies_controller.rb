class MoviesController < ApplicationController
  before_action :authenticate_user, except: [:index, :show]

  def index
    movies = HTTP.get("https://api.themoviedb.org/3/trending/movie/week?api_key=8856f48be68d7285c433496838dbffb4")
    render json: movies.parse(:json)["results"]
  end

  def create
    movie = Movie.new(
      title: params[:title],
      year: params[:year],
      imdbID: params[:imdbID],
      poster: params[:poster],
    )
    if movie.save
      render json: movie
    else
      render json: { errors: movie.errors.full_messages }, status: :bad_request
    end
  end

  def show
    movie = Movie.find_by(id: params[:id])
    render json: movie
  end

  def update
    movie = Movie.find_by(id: params[:id])
    movie.title = params[:title] || movie.title
    movie.overview = params[:overview] || movie.overview
    movie.poster_path = params[:poster_path] || movie.poster_path
    if movie.save
      render json: movie
    else
      render json: { errors: movie.errors.full_messages }, status: :bad_request
    end
  end

  def destroy
    movie = Movie.find_by(id: params[:id])
    movie.destroy
    render json: { message: "Movie successfully destroyed!" }
  end
end
