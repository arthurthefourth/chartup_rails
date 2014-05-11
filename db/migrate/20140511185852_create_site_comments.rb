class CreateSiteComments < ActiveRecord::Migration
  def change
    create_table :site_comments do |t|
      t.integer :user_id
      t.boolean :responded_to

      t.timestamps
    end
  end
end
