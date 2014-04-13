class AddTitleToChart < ActiveRecord::Migration
  def change
    add_column :charts, :title, :string
  end
end
