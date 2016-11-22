class CreateIndias < ActiveRecord::Migration[5.0]
  def change
    create_table :indias do |t|
      t.string :name
      t.text :detail
      t.text :image
      t.string :address
      t.float :latitude
      t.float :longitude
      t.timestamps
    end
  end
end
