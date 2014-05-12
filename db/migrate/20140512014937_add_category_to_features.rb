class AddCategoryToFeatures < ActiveRecord::Migration
  def change
    add_column :features, :category, :string
  end
end
