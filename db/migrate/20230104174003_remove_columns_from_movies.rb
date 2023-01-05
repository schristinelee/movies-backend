class RemoveColumnsFromMovies < ActiveRecord::Migration[7.0]
  def change
    remove_column :movies, :image_url
    remove_column :movies, :description
    remove_column :movies, :user_id
  end
end
