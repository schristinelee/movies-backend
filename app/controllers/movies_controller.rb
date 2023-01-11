class MoviesController < ApplicationController
  before_action :authenticate_user, except: [:index, :show]

  def index
    api_key = ENV["TMDB_API_KEY"]
    response = HTTP.get("https://api.themoviedb.org/3/trending/movie/week?api_key=#{api_key}")
    render json: response.parse(:json)["results"]
  end

  # def index
  #   api_key = ENV["TMDB_API_KEY"]
  #   response = HTTP.get("https://api.themoviedb.org/3/movie/now_playing?api_key=#{api_key}&language=en-US&page=1")
  #   render json: response.parse(:json)["results"]
  # end

  # def index
  #   api_key = ENV["TMDB_API_KEY"]
  #   response = HTTP.get("https://api.themoviedb.org/3/movie/top_rated?api_key=#{api_key}&language=en-US&page=1")
  #   render json: response.parse(:json)["results"]
  # end

  def show
    api_key = ENV["TMDB_API_KEY"]
    movie_id = params[:id]
    response = HTTP.get("https://api.themoviedb.org/3/movie/#{movie_id}?api_key=#{api_key}")
    render json: response.parse(:json)
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
end
