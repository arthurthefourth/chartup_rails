class AddUserIdToChart < ActiveRecord::Migration
  def change
    add_column :charts, :user_id, :integer
  end
end
