class MoviesController < ApplicationController
  before_action :authenticate_user, except: [:index, :show]

  def index
    movies = Movie.all.order(:id)
    render json: movies
  end

  def create
    movie = Movie.new(
      user_id: current_user.id,
      title: params[:title],
      description: params[:description],
      image_url: params[:image_url],
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
    movie.description = params[:description] || movie.description
    movie.image_url = params[:image_url] || movie.image_url
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
