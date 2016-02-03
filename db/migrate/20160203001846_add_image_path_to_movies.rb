class AddImagePathToMovies < ActiveRecord::Migration
  def change
    add_column :movies, :image_path, :string
  end
end
