class AddLatitudeAndLongitudeToTests < ActiveRecord::Migration[5.0]
  def change
    add_column :tests, :latitude, :float8
    add_column :tests, :longitude, :float8
  end
end
