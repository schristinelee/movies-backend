class RemoveYearImdbIdPosterFromMovies < ActiveRecord::Migration[7.0]
  def change
    remove_column :movies, :year
    remove_column :movies, :imdbID
    remove_column :movies, :poster
  end
end
