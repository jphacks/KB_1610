class AddAddressToTests < ActiveRecord::Migration[5.0]
  def change
    add_column :tests, :address, :string
  end
end
