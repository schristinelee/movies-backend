class AddColumnsToMovies < ActiveRecord::Migration[7.0]
  def change
    add_column :movies, :year, :string
    add_column :movies, :imdbID, :string
    add_column :movies, :type, :string
    add_column :movies, :poster, :string
  end
end
