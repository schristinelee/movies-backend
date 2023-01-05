class MoviesController < ApplicationController
  before_action :authenticate_user, except: [:index, :show]

  def index
    movies = Movie.all
    render json: movies
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
    movie.year = params[:year] || movie.year
    movie.imdbID = params[:imdbID] || movie.imdbID
    movie.poster = params[:poster] || movie.poster
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
