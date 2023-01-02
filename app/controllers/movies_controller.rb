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
      body: params[:body],
      image: params[:image],
    )
    if post.save
      render json: post
    else
      render json: { errors: post.errors.full_messages }, status: :bad_request
    end
  end

  def show
    post = Post.find_by(id: params[:id])
    render json: post
  end

  def update
    post = Post.find_by(id: params[:id])
    post.title = params[:title] || post.title
    post.body = params[:body] || post.body
    post.image = params[:image] || post.image
    if post.save
      render json: post
    else
      render json: { errors: post.errors.full_messages }, status: :bad_request
    end
  end

  def destroy
    post = Post.find_by(id: params[:id])
    post.destroy
    render json: { message: "Post successfully destroyed!" }
  end
end
end
