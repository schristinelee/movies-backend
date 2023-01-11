class FavoritesController < ApplicationController
  require "httparty"
  # before_action :authenticate_user

  def index
    favorites = Favorite.all.order(:id)
    render json: favorites
  end

  def create
    api_key = ENV["TMDB_API_KEY"]
    movie_id = params[:id]
    response = HTTParty.get("https://api.themoviedb.org/3/movie/#{movie_id}?api_key=#{api_key}")
    movie = response.parsed_response
    # added checking if the movie is present in the response
    if movie && movie["id"]
      @favorite = Favorite.new(user_id: current_user.id, movie_id: movie["id"])
      if @favorite.save
        redirect_to favorites_path, notice: "Movie was successfully added to favorites"
      else
        render json: { errors: @favorite.errors.full_messages }, status: :bad_request
      end
    else
      render json: { errors: "Movie not found" }, status: :not_found
    end
  end

  def show
    favorite = Favorite.find_by(id: params[:id])
    render json: favorite
  end

  def update
    favorite = Favorite.find_by(id: params[:id])
    favorite.movie_id = params[:movie_id] || favorite.movie_id
    if favorite.save
      render json: favorite
    else
      render json: { errors: favorite.errors.full_messages }, status: :bad_request
    end
  end

  def destroy
    favorite = Favorite.find_by(id: params[:id])
    favorite.destroy
    render json: { message: "Favorite successfully destroyed!" }
  end
end
