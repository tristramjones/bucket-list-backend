class AddCategoryToAttractions < ActiveRecord::Migration[5.2]
  def change
    add_column :attractions, :category, :string
  end
end
