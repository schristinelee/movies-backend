class FavoritesController < ApplicationController
  # before_action :authenticate_user

  def index
    favorites = Favorite.all.order(:id)
    render json: favorites
  end

  def create
    favorite = Favorite.new(
      user_id: current_user.id,
      movie_id: params[:movie_id],
    )
    if favorite.save
      render json: favorite
    else
      render json: { errors: favorite.errors.full_messages }, status: :bad_request
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
