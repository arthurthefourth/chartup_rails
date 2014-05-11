class AddForeignKeyIndices < ActiveRecord::Migration
  def change
    add_index :charts, :user_id
    add_index :usability_surveys, :user_id
    add_index :site_comments, :user_id
  end
end
