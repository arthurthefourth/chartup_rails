class AddPngPathToChart < ActiveRecord::Migration
  def change
    add_column :charts, :png_path, :string
  end
end
