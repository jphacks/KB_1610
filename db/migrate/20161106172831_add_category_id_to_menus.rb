class AddCategoryIdToMenus < ActiveRecord::Migration[5.0]
  def change
    add_column :menus, :category_id, :integer
  end
end
